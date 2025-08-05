import pandas as pd
from datetime import datetime, timedelta
import random

# Colunas esperadas pelo sistema
expected_columns = [
    'ID', 'Cliente', 'Data Emissão', 'Data Vencimento', 'Data Liquidação',
    'Valor documento', 'Saldo', 'Situação', 'Número documento', 'Número no banco',
    'Categoria', 'Histórico', 'Forma de recebimento', 'Meio de recebimento',
    'Taxas', 'Competência', 'Recebimento', 'Recebido'
]

# Criar dados de teste
data = []
for i in range(3):
    data.append({
        'ID': f'TEST{i+1:03d}',
        'Cliente': f'Cliente Teste Notificação {i+1}',
        'Data Emissão': (datetime.now() - timedelta(days=random.randint(30, 60))).strftime('%d/%m/%Y'),
        'Data Vencimento': (datetime.now() - timedelta(days=random.randint(1, 30))).strftime('%d/%m/%Y'),
        'Data Liquidação': '',
        'Valor documento': random.uniform(1000, 5000),
        'Saldo': random.uniform(500, 2000),
        'Situação': 'Cancelada',
        'Número documento': f'DOC{i+1:05d}',
        'Número no banco': f'BCO{i+1:05d}',
        'Categoria': 'Teste',
        'Histórico': f'Teste de notificação {i+1}',
        'Forma de recebimento': 'Boleto',
        'Meio de recebimento': 'Banco',
        'Taxas': 0,
        'Competência': datetime.now().strftime('%m/%Y'),
        'Recebimento': '',
        'Recebido': 0
    })

df = pd.DataFrame(data)
df.to_excel('base_dados/teste_notificacao.xlsx', index=False)
print('Arquivo teste_notificacao.xlsx criado com sucesso!')
print(f'Total de registros: {len(df)}')
print(f'Soma dos valores: R$ {df["Saldo"].sum():,.2f}')
print('Situação dos registros: Cancelada (será mapeada para Protestada)')