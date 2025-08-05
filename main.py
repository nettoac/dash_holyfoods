from fastapi import FastAPI, HTTPException, UploadFile, File
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse, FileResponse
from fastapi.middleware.cors import CORSMiddleware
import pandas as pd
import os
import json
from datetime import datetime, timedelta
from typing import List, Dict, Any, Optional
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import threading
import time
from pathlib import Path

app = FastAPI(title="Dashboard de Inadimplência - HolyFoods")

# Configurar CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Servir arquivos estáticos
app.mount("/static", StaticFiles(directory="static"), name="static")

# Variáveis globais
data_cache = None
last_update = None
BASE_DADOS_PATH = "base_dados"
file_change_notification = None
problematic_files = []  # Lista de arquivos com problemas

class ExcelFileHandler(FileSystemEventHandler):
    def on_modified(self, event):
        if not event.is_directory and event.src_path.endswith(('.xls', '.xlsx', '.csv', '.tsv', '.txt')):
            filename = os.path.basename(event.src_path)
            print(f"Arquivo modificado: {event.src_path}")
            set_file_notification(f"Arquivo '{filename}' foi modificado", "warning")
            load_data()
    
    def on_created(self, event):
        if not event.is_directory and event.src_path.endswith(('.xls', '.xlsx', '.csv', '.tsv', '.txt')):
            filename = os.path.basename(event.src_path)
            print(f"Arquivo criado: {event.src_path}")
            set_file_notification(f"Novo arquivo '{filename}' foi adicionado", "success")
            load_data()
    
    def on_deleted(self, event):
        if not event.is_directory and event.src_path.endswith(('.xls', '.xlsx', '.csv', '.tsv', '.txt')):
            filename = os.path.basename(event.src_path)
            print(f"Arquivo removido: {event.src_path}")
            set_file_notification(f"Arquivo '{filename}' foi removido", "danger")
            load_data()

def set_file_notification(message: str, alert_type: str):
    """Define uma notificação de mudança de arquivo"""
    global file_change_notification
    file_change_notification = {
        "message": message,
        "type": alert_type,
        "timestamp": datetime.now().isoformat()
    }

def ensure_base_dados_folder():
    """Verifica se a pasta base_dados existe, se não existir, cria a pasta"""
    if not os.path.exists(BASE_DADOS_PATH):
        os.makedirs(BASE_DADOS_PATH)
        print(f"✓ Pasta '{BASE_DADOS_PATH}' criada com sucesso")
    else:
        print(f"✓ Pasta '{BASE_DADOS_PATH}' já existe")

# Adicionar após as importações (linha 14)
import asyncio
from concurrent.futures import ThreadPoolExecutor

# Variáveis globais adicionais (após linha 35)
file_monitor_active = False
last_files_check = {}
monitor_thread = None

# Substituir a função start_file_watcher (linha 76-86)
def start_file_watcher():
    """Inicia o monitoramento híbrido da pasta base_dados"""
    global file_monitor_active, monitor_thread
    
    if not os.path.exists(BASE_DADOS_PATH):
        return None
    
    file_monitor_active = True
    
    # Tentar Watchdog primeiro
    observer = None
    try:
        event_handler = ExcelFileHandler()
        observer = Observer()
        observer.schedule(event_handler, BASE_DADOS_PATH, recursive=False)
        observer.start()
        print(f"✓ Watchdog iniciado na pasta: {BASE_DADOS_PATH}")
    except Exception as e:
        print(f"⚠️ Watchdog falhou: {e}")
        observer = None
    
    # Iniciar polling como backup
    monitor_thread = threading.Thread(target=file_polling_monitor, daemon=True)
    monitor_thread.start()
    print(f"✓ Sistema de polling iniciado na pasta: {BASE_DADOS_PATH}")
    
    return observer

def file_polling_monitor():
    """Monitor de polling que verifica arquivos a cada 2 segundos"""
    global file_monitor_active, last_files_check
    
    while file_monitor_active:
        try:
            if os.path.exists(BASE_DADOS_PATH):
                current_files = {}
                
                # Verificar todos os arquivos na pasta
                for filename in os.listdir(BASE_DADOS_PATH):
                    if filename.endswith(('.xls', '.xlsx', '.csv', '.txt', '.tsv')):
                        file_path = os.path.join(BASE_DADOS_PATH, filename)
                        if os.path.isfile(file_path):
                            # Usar timestamp de modificação como identificador
                            current_files[filename] = os.path.getmtime(file_path)
                
                # Verificar se há arquivos novos ou modificados
                files_changed = False
                for filename, mtime in current_files.items():
                    if filename not in last_files_check or last_files_check[filename] != mtime:
                        print(f"📁 Arquivo detectado via polling: {filename}")
                        files_changed = True
                
                # Verificar se arquivos foram removidos
                for filename in last_files_check:
                    if filename not in current_files:
                        print(f"🗑️ Arquivo removido: {filename}")
                        files_changed = True
                
                # Se houve mudanças, recarregar dados
                if files_changed:
                    last_files_check = current_files.copy()
                    print("🔄 Recarregando dados devido a mudanças detectadas...")
                    load_data()
                    set_file_notification(f"Arquivos atualizados! {len(current_files)} arquivo(s) encontrado(s)", "success")
                
                # Atualizar cache mesmo sem mudanças (primeira execução)
                elif not last_files_check:
                    last_files_check = current_files.copy()
                    if current_files:
                        print(f"📊 Carregamento inicial: {len(current_files)} arquivo(s) encontrado(s)")
                        load_data()
        
        except Exception as e:
            print(f"❌ Erro no polling monitor: {e}")
        
        # Aguardar 2 segundos antes da próxima verificação
        time.sleep(2)

def stop_file_monitor():
    """Para o monitoramento de arquivos"""
    global file_monitor_active
    file_monitor_active = False

# Modificar o início da função load_data() (linha 87)
def load_data():
    """Carrega dados dos arquivos na pasta base_dados"""
    global data_cache, last_update, problematic_files
    
    print(f"🔍 Verificando pasta: {os.path.abspath(BASE_DADOS_PATH)}")
    
    if not os.path.exists(BASE_DADOS_PATH):
        print(f"❌ Pasta {BASE_DADOS_PATH} não encontrada")
        return
    
    # Listar todos os arquivos para debug
    all_files = os.listdir(BASE_DADOS_PATH)
    print(f"📂 Arquivos na pasta: {all_files}")
    
    # Filtrar arquivos de dados
    data_files = [f for f in all_files if f.endswith(('.xls', '.xlsx', '.csv', '.txt', '.tsv'))]
    print(f"📊 Arquivos de dados encontrados: {data_files}")
    
    if not data_files:
        print("⚠️ Nenhum arquivo de dados encontrado na pasta base_dados")
        data_cache = None  # Limpar cache quando não há arquivos
        last_update = datetime.now()
        print("🔄 Cache de dados limpo")
        return data_cache
    
    all_data = []
    problematic_files = []  # Reset da lista de arquivos problemáticos
    successful_files = []
    
    for filename in os.listdir(BASE_DADOS_PATH):
        if filename.endswith(('.xls', '.xlsx', '.csv', '.txt', '.tsv')):
            file_path = os.path.join(BASE_DADOS_PATH, filename)
            try:
                # Tentar diferentes engines e métodos para arquivos corrompidos
                df = None
                
                # Se for arquivo CSV/TXT/TSV, processar diretamente
                if filename.endswith(('.csv', '.txt', '.tsv')):
                    try:
                        # Lista de separadores para testar
                        if filename.endswith('.tsv'):
                            separators = ['\t']
                        elif filename.endswith('.txt'):
                            separators = ['\t', ';', ',']
                        else:
                            separators = [';', ',', '\t']  # Testar ponto e vírgula primeiro para CSV
                        
                        df = None
                        # Tentar diferentes combinações de separador e codificação
                        for separator in separators:
                            for encoding in ['utf-8', 'latin-1']:
                                try:
                                    df = pd.read_csv(file_path, sep=separator, encoding=encoding, header=0)
                                    if df is not None and not df.empty and len(df.columns) > 1:
                                        print(f"✓ Arquivo CSV {filename} carregado com sucesso (sep='{separator}', encoding='{encoding}')")
                                        break
                                except Exception:
                                    continue
                            if df is not None and not df.empty and len(df.columns) > 1:
                                break
                        
                        if df is None or df.empty or len(df.columns) <= 1:
                            raise Exception("Não foi possível ler o arquivo com nenhuma combinação de separador/codificação")
                            
                    except Exception as csv_error:
                        print(f"✗ Erro ao ler arquivo CSV {filename}: {csv_error}")
                        problematic_files.append(filename)
                        continue
                
                # Se for arquivo Excel, usar a lógica existente
                elif filename.endswith(('.xls', '.xlsx')):
                    # Primeiro, tentar com openpyxl (mais moderno)
                    if filename.endswith('.xlsx'):
                        engines_to_try = ['openpyxl', 'xlrd']
                    else:
                        engines_to_try = ['xlrd', 'openpyxl']
                    
                    for engine in engines_to_try:
                        try:
                            # Tentar ler com diferentes parâmetros
                            df = pd.read_excel(file_path, engine=engine, header=0)
                            
                            if df is not None and not df.empty:
                                print(f"✓ Arquivo Excel {filename} carregado com engine {engine}")
                                break
                                
                        except Exception as engine_error:
                            print(f"Tentativa com engine {engine} para {filename}: {engine_error}")
                            
                            # Se falhou com xlrd, tentar com diferentes configurações
                            if engine == 'xlrd':
                                try:
                                    # Tentar ignorar erros de formatação
                                    df = pd.read_excel(file_path, engine=engine, header=0, na_values=[''])
                                    if df is not None and not df.empty:
                                        print(f"✓ Arquivo Excel {filename} carregado com engine {engine} (modo compatibilidade)")
                                        break
                                except:
                                    pass
                            continue
                    
                    # Se ainda não conseguiu ler Excel, tentar métodos alternativos
                    if df is None:
                        try:
                            # Tentar ler como CSV se for um arquivo mal formatado
                            df = pd.read_csv(file_path, encoding='latin-1', sep='\t')
                            print(f"✓ Arquivo Excel {filename} lido como CSV/TSV (fallback)")
                        except:
                            try:
                                # Última tentativa: ler como CSV com separador vírgula
                                df = pd.read_csv(file_path, encoding='latin-1', sep=',')
                                print(f"✓ Arquivo Excel {filename} lido como CSV com vírgula (fallback)")
                            except:
                                print(f"AVISO: Não foi possível ler {filename} - arquivo pode estar corrompido ou em formato não suportado")
                                problematic_files.append(filename)
                                continue
                    
                # Padronizar nomes das colunas
                expected_columns = [
                    'ID', 'Cliente', 'Data Emissão', 'Data Vencimento', 'Data Liquidação',
                    'Valor documento', 'Saldo', 'Situação', 'Número documento', 'Número no banco',
                    'Categoria', 'Histórico', 'Forma de recebimento', 'Meio de recebimento',
                    'Taxas', 'Competência', 'Recebimento', 'Recebido'
                ]
                
                if len(df.columns) >= len(expected_columns):
                    df.columns = expected_columns[:len(df.columns)]
                    all_data.append(df)
                    successful_files.append((filename, len(df)))
                    print(f"✓ Arquivo carregado: {filename} - {len(df)} registros")
                else:
                    print(f"✗ Arquivo {filename} não possui todas as colunas esperadas")
                    problematic_files.append(filename)
                    
            except Exception as e:
                print(f"✗ Erro ao carregar {filename}: {e}")
                problematic_files.append(filename)
    
    if all_data:
        data_cache = pd.concat(all_data, ignore_index=True)
        # Converter colunas de data
        date_columns = ['Data Emissão', 'Data Vencimento', 'Data Liquidação']
        for col in date_columns:
            if col in data_cache.columns:
                data_cache[col] = pd.to_datetime(data_cache[col], format='%d/%m/%Y', errors='coerce')
        
        # Converter colunas numéricas (formato brasileiro com vírgula)
        def convert_brazilian_currency(value):
            """Converte valores monetários brasileiros para float"""
            if pd.isna(value) or value == '' or value == 'nan':
                return 0.0
            
            value_str = str(value).strip()
            
            # Remove símbolos de moeda e espaços
            value_str = value_str.replace('R$', '').replace(' ', '')
            
            # Trata formato brasileiro: 1.234.567,89
            if ',' in value_str and '.' in value_str:
                # Se vírgula vem depois do ponto, vírgula é decimal
                if value_str.rfind(',') > value_str.rfind('.'):
                    value_str = value_str.replace('.', '').replace(',', '.')
                else:
                    # Ponto é decimal, vírgula é separador de milhares
                    value_str = value_str.replace(',', '')
            elif ',' in value_str:
                # Apenas vírgula - verifica se é decimal (2 dígitos após vírgula)
                comma_pos = value_str.rfind(',')
                after_comma = value_str[comma_pos+1:]
                if len(after_comma) == 2 and after_comma.isdigit():
                    value_str = value_str.replace(',', '.')
                else:
                    value_str = value_str.replace(',', '')
            
            try:
                return float(value_str)
            except ValueError:
                return 0.0
        
        numeric_columns = ['Valor documento', 'Saldo', 'Recebido']
        for col in numeric_columns:
            if col in data_cache.columns:
                data_cache[col] = data_cache[col].apply(convert_brazilian_currency)
        
        # Mapear situação 'Cancelada' para 'Protestada'
        if 'Situação' in data_cache.columns:
            data_cache['Situação'] = data_cache['Situação'].replace('Cancelada', 'Protestada')
        
        # Limpar valores NaN em todas as colunas
        data_cache = data_cache.fillna('')
        
        last_update = datetime.now()
        
        # Exibir resumo do carregamento
        print("\n" + "="*50)
        print("RESUMO DO CARREGAMENTO DE DADOS")
        print("="*50)
        print(f"✓ Arquivos carregados com sucesso: {len(successful_files)}")
        for filename, records in successful_files:
            print(f"  • {filename} - {records} registros")
        
        if problematic_files:
            print(f"\n✗ Arquivos com problemas: {len(problematic_files)}")
            for filename in problematic_files:
                print(f"  • {filename}")
            print("\n💡 DICA: Para corrigir arquivos problemáticos:")
            print("   1. Abra o arquivo no Excel")
            print("   2. Salve novamente (Ctrl+S)")
            print("   3. Ou converta para formato .xlsx")
        
        print(f"\n📊 Total de registros carregados: {len(data_cache)}")
        print("="*50 + "\n")
    else:
        # Limpar cache quando não há dados válidos
        data_cache = None
        last_update = datetime.now()
        if problematic_files:
            print(f"\n⚠️  Encontrados {len(problematic_files)} arquivos com problemas, mas nenhum pôde ser carregado.")
            print("💡 Todos os arquivos precisam ser corrigidos antes de usar o sistema.")
        else:
            print("Nenhum arquivo Excel encontrado na pasta base_dados")
        print("🔄 Cache de dados limpo")
    
    return data_cache

def calculate_kpis(df: pd.DataFrame, filters: Dict = None) -> Dict:
    """Calcula os KPIs principais"""
    if df is None or df.empty:
        return {
            'montante': 0,
            'pago_recebido': 0,
            'vencido': 0,
            'em_aberto': 0,
            'qtd_vencidos': 0,
            'total_titulos': 0,
            'atraso_medio': 0,
            'inadimplencia': 0,
            'iag': 0.0,
            'iap': 0.0
        }
    
    # Aplicar filtros se fornecidos
    filtered_df = apply_filters(df, filters) if filters else df
    
    # Pago/Recebidos (Situação = "Paga")
    pago_recebidos = filtered_df[filtered_df['Situação'] == 'Paga']['Recebido'].sum()
    
    # Vencido - Situações "Cancelada" e "Protestada"
    vencido = filtered_df[filtered_df['Situação'].isin(['Cancelada', 'Protestada'])]['Saldo'].sum()
    
    # Em Aberto - Apenas situação "Em aberto"
    em_aberto = filtered_df[filtered_df['Situação'] == 'Em aberto']['Saldo'].sum()
    
    # Montante
    montante = pago_recebidos + vencido + em_aberto
    
    # Quantidade de vencidos (Em aberto + Cancelada + Protestada)
    qtd_vencidos = len(filtered_df[filtered_df['Situação'].isin(['Em aberto', 'Cancelada', 'Protestada'])])
    
    # Total de títulos (todas as situações)
    total_titulos = len(filtered_df)
    
    # Atraso médio (em dias) - incluindo canceladas e protestadas
    # Soma total de dias dividido pelo total de títulos vencidos, depois dividido por 30
    hoje = datetime.now()
    em_aberto_protestada = filtered_df[filtered_df['Situação'].isin(['Em aberto', 'Cancelada', 'Protestada'])].copy()
    if not em_aberto_protestada.empty and 'Data Vencimento' in em_aberto_protestada.columns:
        em_aberto_protestada['dias_atraso'] = (hoje - em_aberto_protestada['Data Vencimento']).dt.days
        # Filtrar apenas contas com atraso positivo
        contas_com_atraso = em_aberto_protestada[em_aberto_protestada['dias_atraso'] > 0]
        if not contas_com_atraso.empty:
            total_dias_atraso = contas_com_atraso['dias_atraso'].sum()
            qtd_titulos_vencidos = len(contas_com_atraso)
            atraso_medio = (total_dias_atraso / qtd_titulos_vencidos) / 30
        else:
            atraso_medio = 0
    else:
        atraso_medio = 0
    
    # Inadimplência (%)
    total_documentos = len(filtered_df)
    # inadimplencia = (qtd_vencidos / total_documentos * 100) if total_documentos > 0 else 0
    inadimplencia = (abs(vencido) / montante * 100) if montante > 0 else 0
    
    # IAG - Índice de Atraso Geral
    # Valor das contas vencidas desde ontem (D-1) até todos os períodos, somente das contas não pagas
    ontem = hoje - timedelta(days=1)
    contas_nao_pagas = filtered_df[filtered_df['Situação'].isin(['Em aberto', 'Cancelada', 'Protestada'])].copy()
    
    if not contas_nao_pagas.empty and 'Data Vencimento' in contas_nao_pagas.columns:
        # Filtrar contas vencidas desde ontem e somar valores
        contas_vencidas_d1 = contas_nao_pagas[contas_nao_pagas['Data Vencimento'] <= ontem]
        valor_vencido_d1 = contas_vencidas_d1['Saldo'].sum() if not contas_vencidas_d1.empty else 0
        
        # Calcular IAP - Índice de Atraso Parcial
        # Valor das contas com mais de 30 dias de atraso que não foram pagas
        contas_nao_pagas['dias_atraso'] = (hoje - contas_nao_pagas['Data Vencimento']).dt.days
        contas_30_dias = contas_nao_pagas[contas_nao_pagas['dias_atraso'] > 30]
        valor_30_dias = contas_30_dias['Saldo'].sum() if not contas_30_dias.empty else 0
    else:
        valor_vencido_d1 = 0
        valor_30_dias = 0
    
    # IAG = (Valor Vencido D-1 / Montante Total) * 100
    iag = (valor_vencido_d1 / montante * 100) if montante > 0 else 0
    
    # IAP = (Valor Contas 30+ dias / Montante Total) * 100
    iap = (valor_30_dias / montante * 100) if montante > 0 else 0
    
    return {
        'montante': float(montante),
        'pago_recebido': float(pago_recebidos),
        'vencido': float(-abs(vencido)),  # Sempre negativo
        'em_aberto': float(em_aberto) if not (pd.isna(em_aberto) or em_aberto is None) else 0.0,
        'qtd_vencidos': int(qtd_vencidos),
        'total_titulos': int(total_titulos),
        'atraso_medio': float(atraso_medio),
        'inadimplencia': float(inadimplencia),
        'iag': float(iag) if not (pd.isna(iag) or iag is None) else 0.0,
        'iap': float(iap) if not (pd.isna(iap) or iap is None) else 0.0
    }

def apply_filters(df: pd.DataFrame, filters: Dict) -> pd.DataFrame:
    """Aplica filtros ao DataFrame"""
    filtered_df = df.copy()
    
    if 'data_inicio' in filters and filters['data_inicio']:
        data_inicio = pd.to_datetime(filters['data_inicio'])
        filtered_df = filtered_df[filtered_df['Data Emissão'] >= data_inicio]
    
    if 'data_fim' in filters and filters['data_fim']:
        data_fim = pd.to_datetime(filters['data_fim'])
        filtered_df = filtered_df[filtered_df['Data Emissão'] <= data_fim]
    
    if 'clientes' in filters and filters['clientes']:
        filtered_df = filtered_df[filtered_df['Cliente'].isin(filters['clientes'])]
    
    if 'situacao' in filters and filters['situacao']:
        filtered_df = filtered_df[filtered_df['Situação'].isin(filters['situacao'])]
    
    if 'forma_recebimento' in filters and filters['forma_recebimento']:
        filtered_df = filtered_df[filtered_df['Forma de recebimento'].isin(filters['forma_recebimento'])]
    
    # Filtros customizados
    if 'custom_filters' in filters:
        for custom_filter in filters['custom_filters']:
            column = custom_filter.get('column')
            values = custom_filter.get('values', [])
            if column in filtered_df.columns and values:
                filtered_df = filtered_df[filtered_df[column].isin(values)]
    
    return filtered_df

@app.on_event("startup")
async def startup_event():
    """Carrega dados iniciais e inicia monitoramento"""
    ensure_base_dados_folder()
    load_data()
    start_file_watcher()

@app.get("/")
async def read_root():
    """Serve a página principal"""
    return FileResponse('static/index.html')

@app.get("/api/data")
async def get_data():
    """Retorna todos os dados"""
    if data_cache is None:
        return {
            "data": [],
            "last_update": None,
            "total_records": 0
        }
    
    return {
        "data": data_cache.to_dict('records'),
        "last_update": last_update.isoformat() if last_update else None,
        "total_records": len(data_cache)
    }

@app.post("/api/kpis")
async def get_kpis(filters: Dict = None):
    """Retorna KPIs calculados com filtros opcionais"""
    if data_cache is None:
        return {
            "montante": 0,
            "pago_recebido": 0,
            "vencido": 0,
            "qtd_vencidos": 0,
            "total_titulos": 0,
            "atraso_medio": 0,
            "inadimplencia": 0,
            "iag": 0.0,
            "iap": 0.0
        }
    
    kpis = calculate_kpis(data_cache, filters)
    return kpis

@app.get("/api/columns")
async def get_columns():
    """Retorna as colunas disponíveis para filtros"""
    if data_cache is None:
        response = {
            "columns": [],
            "unique_values": {
                "Cliente": [],
                "Situação": [],
                "Forma de recebimento": []
            },
            "filters": {
                "situacao": [],
                "forma_recebimento": []
            }
        }
        return response
    
    unique_values = {}
    for col in data_cache.columns:
        if data_cache[col].dtype == 'object':
            unique_values[col] = data_cache[col].dropna().unique().tolist()
    
    response = {
        "columns": list(data_cache.columns),
        "unique_values": unique_values,
        "filters": {
            "situacao": sorted(data_cache['Situação'].unique().tolist()),
            "forma_recebimento": sorted(data_cache['Forma de recebimento'].unique().tolist())
        }
    }
    return response

@app.get("/api/file-notification")
async def get_file_notification():
    """Retorna notificação de mudança de arquivo se houver"""
    global file_change_notification
    if file_change_notification:
        notification = file_change_notification
        file_change_notification = None  # Limpa a notificação após ser lida
        return notification
    return None

@app.get("/api/problematic-files")
async def get_problematic_files():
    """Retorna lista de arquivos com problemas de carregamento"""
    global problematic_files
    return {
        "problematic_files": problematic_files,
        "count": len(problematic_files),
        "message": "Para corrigir: abra o arquivo no Excel e salve novamente (Ctrl+S)" if problematic_files else "Todos os arquivos foram carregados com sucesso"
    }

@app.post("/api/charts/faixa-recebimento")
async def get_faixa_recebimento(filters: Dict = None):
    """Retorna dados para gráfico de faixa de recebimento"""
    if data_cache is None:
        return {}
    
    filtered_df = apply_filters(data_cache, filters) if filters else data_cache
    pagos = filtered_df[filtered_df['Situação'] == 'Paga'].copy()
    
    if pagos.empty:
        return {"0-30 dias": 0, "31-60 dias": 0, "61-90 dias": 0, "+90 dias": 0}
    
    hoje = datetime.now()
    pagos['dias_para_recebimento'] = (pagos['Data Liquidação'] - pagos['Data Emissão']).dt.days
    
    faixas = {
        "0-30 dias": pagos[pagos['dias_para_recebimento'] <= 30]['Recebido'].sum(),
        "31-60 dias": pagos[(pagos['dias_para_recebimento'] > 30) & (pagos['dias_para_recebimento'] <= 60)]['Recebido'].sum(),
        "61-90 dias": pagos[(pagos['dias_para_recebimento'] > 60) & (pagos['dias_para_recebimento'] <= 90)]['Recebido'].sum(),
        "+90 dias": pagos[pagos['dias_para_recebimento'] > 90]['Recebido'].sum()
    }
    
    return {k: float(v) for k, v in faixas.items()}

@app.post("/api/charts/faixa-vencimento")
async def get_faixa_vencimento(filters: Dict = None):
    """Retorna dados para gráfico de faixa de vencimento"""
    if data_cache is None:
        return {}
    
    filtered_df = apply_filters(data_cache, filters) if filters else data_cache
    vencidos = filtered_df[filtered_df['Situação'].isin(['Em aberto', 'Protestada'])].copy()
    
    if vencidos.empty:
        return {"0-30 dias": 0, "31-60 dias": 0, "61-90 dias": 0, "+90 dias": 0}
    
    hoje = datetime.now()
    vencidos['dias_vencido'] = (hoje - vencidos['Data Vencimento']).dt.days
    
    faixas = {
        "0-30 dias": vencidos[(vencidos['dias_vencido'] >= 0) & (vencidos['dias_vencido'] <= 30)]['Saldo'].sum(),
        "31-60 dias": vencidos[(vencidos['dias_vencido'] > 30) & (vencidos['dias_vencido'] <= 60)]['Saldo'].sum(),
        "61-90 dias": vencidos[(vencidos['dias_vencido'] > 60) & (vencidos['dias_vencido'] <= 90)]['Saldo'].sum(),
        "+90 dias": vencidos[vencidos['dias_vencido'] > 90]['Saldo'].sum()
    }
    
    return {k: float(v) for k, v in faixas.items()}

@app.post("/api/charts/top-pagadores")
async def get_top_pagadores(filters: Dict = None):
    """Retorna top 5 clientes que pagam em dia"""
    if data_cache is None:
        return {}
    
    filtered_df = apply_filters(data_cache, filters) if filters else data_cache
    pagos = filtered_df[filtered_df['Situação'] == 'Paga']
    
    if pagos.empty:
        return {}
    
    top_pagadores = pagos.groupby('Cliente')['Recebido'].sum().sort_values(ascending=False).head(5)
    
    return {
        cliente[:30]: float(valor) 
        for cliente, valor in top_pagadores.items()
    }

@app.post("/api/charts/top-devedores")
async def get_top_devedores(filters: Dict = None):
    """Retorna top 15 clientes devedores"""
    if data_cache is None:
        return {}
    
    filtered_df = apply_filters(data_cache, filters) if filters else data_cache
    devedores = filtered_df[
        (filtered_df['Situação'].isin(['Em aberto', 'Protestada'])) & 
        (filtered_df['Recebido'] == 0)
    ]
    
    if devedores.empty:
        return {}
    
    top_devedores = devedores.groupby('Cliente')['Saldo'].sum().sort_values(ascending=False).head(15)
    
    return {
        cliente[:30]: float(valor) 
        for cliente, valor in top_devedores.items()
    }

@app.post("/api/charts/pizza-clientes")
async def get_pizza_clientes(filters: Dict = None):
    """Retorna dados para gráfico pizza de distribuição por forma de recebimento"""
    if data_cache is None:
        return {}
    
    filtered_df = apply_filters(data_cache, filters) if filters else data_cache
    
    # Agrupar por forma de recebimento e somar os valores
    # Para contas pagas, usar o valor recebido; para em aberto, usar o saldo
    forma_recebimento_data = {}
    
    for forma in filtered_df['Forma de recebimento'].unique():
        if pd.isna(forma) or forma == '':
            continue
            
        forma_df = filtered_df[filtered_df['Forma de recebimento'] == forma]
        
        # Somar valores recebidos (contas pagas) + saldo em aberto
        valor_recebido = forma_df[forma_df['Situação'] == 'Paga']['Recebido'].sum()
        valor_aberto = forma_df[forma_df['Situação'].isin(['Em aberto', 'Protestada'])]['Saldo'].sum()
        
        total_forma = valor_recebido + valor_aberto
        
        if total_forma > 0:
            forma_recebimento_data[forma] = float(total_forma)
    
    return forma_recebimento_data

@app.post("/api/charts/pizza-montante")
async def get_pizza_montante(filters: Dict = None):
    """Retorna dados para gráfico pizza de distribuição do montante por situação"""
    if data_cache is None:
        return {}
    
    filtered_df = apply_filters(data_cache, filters) if filters else data_cache
    
    # Agrupar por situação
    situacao_data = {}
    
    # Recebidos (contas pagas)
    recebidos = filtered_df[filtered_df['Situação'] == 'Paga']['Recebido'].sum()
    if recebidos > 0:
        situacao_data['Recebidos'] = float(recebidos)
    
    # Em Abertos
    em_aberto = filtered_df[filtered_df['Situação'] == 'Em aberto']['Saldo'].sum()
    if em_aberto > 0:
        situacao_data['Em Abertos'] = float(em_aberto)
    
    # Protestados
    protestados = filtered_df[filtered_df['Situação'] == 'Protestada']['Saldo'].sum()
    if protestados > 0:
        situacao_data['Protestados'] = float(protestados)
    
    return situacao_data

# Adicionar novo endpoint após linha 475
@app.post("/api/reload-data")
async def reload_data():
    """Força o recarregamento dos dados"""
    try:
        print("🔄 Recarregamento manual solicitado...")
        load_data()
        return {
            "success": True,
            "message": "Dados recarregados com sucesso",
            "timestamp": datetime.now().isoformat(),
            "total_records": len(data_cache) if data_cache is not None else 0
        }
    except Exception as e:
        return {
            "success": False,
            "message": f"Erro ao recarregar dados: {str(e)}"
        }

@app.post("/api/check-files")
async def check_files(filenames: List[str]):
    """Verifica se arquivos já existem na pasta base_dados"""
    try:
        os.makedirs(BASE_DADOS_PATH, exist_ok=True)
        
        results = []
        for filename in filenames:
            file_path = os.path.join(BASE_DADOS_PATH, filename)
            exists = os.path.exists(file_path)
            results.append({
                "filename": filename,
                "exists": exists
            })
        
        return {
            "success": True,
            "results": results
        }
        
    except Exception as e:
        return {
            "success": False,
            "message": f"Erro ao verificar arquivos: {str(e)}"
        }

@app.post("/api/upload-csv")
async def upload_csv(file: UploadFile = File(...)):
    """Upload de arquivo CSV para a pasta base_dados"""
    try:
        # Verificar se é um arquivo CSV
        if not file.filename.lower().endswith('.csv'):
            return {
                "success": False,
                "message": "Apenas arquivos CSV são permitidos"
            }
        
        # Criar pasta base_dados se não existir
        os.makedirs(BASE_DADOS_PATH, exist_ok=True)
        
        # Salvar arquivo
        file_path = os.path.join(BASE_DADOS_PATH, file.filename)
        
        # Verificar se arquivo já existe - AGORA RETORNA ERRO
        if os.path.exists(file_path):
            return {
                "success": False,
                "message": f"Já existe um arquivo com o nome '{file.filename}' na pasta. Por favor, renomeie o arquivo ou remova o arquivo existente.",
                "error_type": "duplicate_file"
            }
        
        # Salvar conteúdo do arquivo
        content = await file.read()
        with open(file_path, "wb") as f:
            f.write(content)
        
        print(f"📁 Arquivo CSV enviado: {file.filename} -> {file_path}")
        
        # Recarregar dados automaticamente
        load_data()
        
        return {
            "success": True,
            "message": f"Arquivo '{file.filename}' enviado com sucesso",
            "filename": os.path.basename(file_path),
            "timestamp": datetime.now().isoformat(),
            "total_records": len(data_cache) if data_cache is not None else 0
        }
        
    except Exception as e:
        print(f"❌ Erro no upload: {str(e)}")
        return {
            "success": False,
            "message": f"Erro ao fazer upload: {str(e)}"
        }

@app.get("/api/columns")
async def get_columns():
    """Retorna as colunas disponíveis para filtros"""
    if data_cache is None:
        response = {
            "columns": [],
            "unique_values": {
                "Cliente": [],
                "Situação": [],
                "Forma de recebimento": []
            },
            "filters": {
                "situacao": [],
                "forma_recebimento": []
            }
        }
        return response
    
    unique_values = {}
    for col in data_cache.columns:
        if data_cache[col].dtype == 'object':
            unique_values[col] = data_cache[col].dropna().unique().tolist()
    
    response = {
        "columns": list(data_cache.columns),
        "unique_values": unique_values,
        "filters": {
            "situacao": sorted(data_cache['Situação'].unique().tolist()),
            "forma_recebimento": sorted(data_cache['Forma de recebimento'].unique().tolist())
        }
    }
    return response

@app.get("/api/file-notification")
async def get_file_notification():
    """Retorna notificação de mudança de arquivo se houver"""
    global file_change_notification
    if file_change_notification:
        notification = file_change_notification
        file_change_notification = None  # Limpa a notificação após ser lida
        return notification
    return None

@app.get("/api/problematic-files")
async def get_problematic_files():
    """Retorna lista de arquivos com problemas de carregamento"""
    global problematic_files
    return {
        "problematic_files": problematic_files,
        "count": len(problematic_files),
        "message": "Para corrigir: abra o arquivo no Excel e salve novamente (Ctrl+S)" if problematic_files else "Todos os arquivos foram carregados com sucesso"
    }

@app.post("/api/charts/faixa-recebimento")
async def get_faixa_recebimento(filters: Dict = None):
    """Retorna dados para gráfico de faixa de recebimento"""
    if data_cache is None:
        return {}
    
    filtered_df = apply_filters(data_cache, filters) if filters else data_cache
    pagos = filtered_df[filtered_df['Situação'] == 'Paga'].copy()
    
    if pagos.empty:
        return {"0-30 dias": 0, "31-60 dias": 0, "61-90 dias": 0, "+90 dias": 0}
    
    hoje = datetime.now()
    pagos['dias_para_recebimento'] = (pagos['Data Liquidação'] - pagos['Data Emissão']).dt.days
    
    faixas = {
        "0-30 dias": pagos[pagos['dias_para_recebimento'] <= 30]['Recebido'].sum(),
        "31-60 dias": pagos[(pagos['dias_para_recebimento'] > 30) & (pagos['dias_para_recebimento'] <= 60)]['Recebido'].sum(),
        "61-90 dias": pagos[(pagos['dias_para_recebimento'] > 60) & (pagos['dias_para_recebimento'] <= 90)]['Recebido'].sum(),
        "+90 dias": pagos[pagos['dias_para_recebimento'] > 90]['Recebido'].sum()
    }
    
    return {k: float(v) for k, v in faixas.items()}

@app.post("/api/charts/faixa-vencimento")
async def get_faixa_vencimento(filters: Dict = None):
    """Retorna dados para gráfico de faixa de vencimento"""
    if data_cache is None:
        return {}
    
    filtered_df = apply_filters(data_cache, filters) if filters else data_cache
    vencidos = filtered_df[filtered_df['Situação'].isin(['Em aberto', 'Protestada'])].copy()
    
    if vencidos.empty:
        return {"0-30 dias": 0, "31-60 dias": 0, "61-90 dias": 0, "+90 dias": 0}
    
    hoje = datetime.now()
    vencidos['dias_vencido'] = (hoje - vencidos['Data Vencimento']).dt.days
    
    faixas = {
        "0-30 dias": vencidos[(vencidos['dias_vencido'] >= 0) & (vencidos['dias_vencido'] <= 30)]['Saldo'].sum(),
        "31-60 dias": vencidos[(vencidos['dias_vencido'] > 30) & (vencidos['dias_vencido'] <= 60)]['Saldo'].sum(),
        "61-90 dias": vencidos[(vencidos['dias_vencido'] > 60) & (vencidos['dias_vencido'] <= 90)]['Saldo'].sum(),
        "+90 dias": vencidos[vencidos['dias_vencido'] > 90]['Saldo'].sum()
    }
    
    return {k: float(v) for k, v in faixas.items()}

@app.post("/api/charts/top-pagadores")
async def get_top_pagadores(filters: Dict = None):
    """Retorna top 5 clientes que pagam em dia"""
    if data_cache is None:
        return {}
    
    filtered_df = apply_filters(data_cache, filters) if filters else data_cache
    pagos = filtered_df[filtered_df['Situação'] == 'Paga']
    
    if pagos.empty:
        return {}
    
    top_pagadores = pagos.groupby('Cliente')['Recebido'].sum().sort_values(ascending=False).head(5)
    
    return {
        cliente[:30]: float(valor) 
        for cliente, valor in top_pagadores.items()
    }

@app.post("/api/charts/top-devedores")
async def get_top_devedores(filters: Dict = None):
    """Retorna top 15 clientes devedores"""
    if data_cache is None:
        return {}
    
    filtered_df = apply_filters(data_cache, filters) if filters else data_cache
    devedores = filtered_df[
        (filtered_df['Situação'].isin(['Em aberto', 'Protestada'])) & 
        (filtered_df['Recebido'] == 0)
    ]
    
    if devedores.empty:
        return {}
    
    top_devedores = devedores.groupby('Cliente')['Saldo'].sum().sort_values(ascending=False).head(15)
    
    return {
        cliente[:30]: float(valor) 
        for cliente, valor in top_devedores.items()
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="localhost", port=8000)