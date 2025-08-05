import pandas as pd
import os
from pathlib import Path

def test_excel_loading():
    """Testa o carregamento de arquivos Excel com diferentes engines"""
    base_path = "base_dados"
    
    if not os.path.exists(base_path):
        print(f"Pasta {base_path} não encontrada")
        return
    
    problematic_files = []
    successful_files = []
    
    for filename in os.listdir(base_path):
        if filename.endswith(('.xls', '.xlsx')):
            file_path = os.path.join(base_path, filename)
            print(f"\nTestando arquivo: {filename}")
            
            df = None
            success_engine = None
            
            # Testar engines na mesma ordem do sistema
            if filename.endswith('.xlsx'):
                engines_to_try = ['openpyxl', 'xlrd']
            else:
                engines_to_try = ['xlrd', 'openpyxl']
            
            for engine in engines_to_try:
                try:
                    df = pd.read_excel(file_path, engine=engine, header=0)
                    if df is not None and not df.empty:
                        success_engine = engine
                        print(f"  ✓ Sucesso com engine {engine} - {len(df)} registros")
                        break
                except Exception as e:
                    print(f"  ✗ Falha com engine {engine}: {str(e)[:100]}...")
                    
                    # Tentar modo compatibilidade para xlrd
                    if engine == 'xlrd':
                        try:
                            df = pd.read_excel(file_path, engine=engine, header=0, na_values=[''])
                            if df is not None and not df.empty:
                                success_engine = f"{engine} (compatibilidade)"
                                print(f"  ✓ Sucesso com {success_engine} - {len(df)} registros")
                                break
                        except Exception as e2:
                            print(f"  ✗ Falha com {engine} (compatibilidade): {str(e2)[:50]}...")
            
            # Tentar métodos alternativos se ainda não conseguiu
            if df is None:
                try:
                    df = pd.read_csv(file_path, encoding='latin-1', sep='\t')
                    success_engine = "CSV/TSV"
                    print(f"  ✓ Sucesso como CSV/TSV - {len(df)} registros")
                except:
                    try:
                        df = pd.read_csv(file_path, encoding='latin-1', sep=',')
                        success_engine = "CSV"
                        print(f"  ✓ Sucesso como CSV - {len(df)} registros")
                    except Exception as e:
                        print(f"  ✗ Falha total: {str(e)[:50]}...")
                        problematic_files.append(filename)
                        continue
            
            if df is not None:
                successful_files.append((filename, success_engine, len(df)))
    
    print("\n" + "="*60)
    print("RESUMO DOS TESTES")
    print("="*60)
    
    print(f"\nArquivos carregados com sucesso: {len(successful_files)}")
    for filename, engine, records in successful_files:
        print(f"  • {filename} ({engine}) - {records} registros")
    
    print(f"\nArquivos problemáticos: {len(problematic_files)}")
    for filename in problematic_files:
        print(f"  • {filename}")
    
    if problematic_files:
        print("\n⚠️  RECOMENDAÇÃO: Os arquivos problemáticos precisam ser:")
        print("   1. Abertos no Excel")
        print("   2. Salvos novamente (Ctrl+S)")
        print("   3. Ou convertidos para .xlsx")
    else:
        print("\n✅ Todos os arquivos foram carregados com sucesso!")

if __name__ == "__main__":
    test_excel_loading()