# Dashboard de Inadimplência - HolyFoods

Sistema completo de dashboard para controle de inadimplência de clientes com monitoramento automático de arquivos Excel.

## Características

- **Dashboard Interativo**: Interface moderna e responsiva com gráficos dinâmicos
- **Monitoramento Automático**: Atualização automática quando arquivos Excel são modificados
- **Filtros Avançados**: Sistema de filtros com opção de criar filtros customizados
- **KPIs em Tempo Real**: Indicadores de performance atualizados automaticamente
- **Gráficos Responsivos**: Visualizações adaptáveis a diferentes tamanhos de tela

## Funcionalidades

### KPIs Principais
- **Montante**: Valor total (Pago + Vencido)
- **Pago/Recebidos**: Soma dos valores recebidos (situação "Paga")
- **Vencido**: Soma dos valores em aberto (situação "Em aberto")
- **Quantidade de Vencidos**: Número de documentos em aberto
- **Atraso Médio**: Média de dias de atraso
- **% Inadimplência**: Percentual de inadimplência

### Gráficos
- **Distribuição por Faixa de Recebimento**: Barras horizontais (0-30, 31-60, 61-90, 90+ dias)
- **Distribuição por Faixa de Vencimento**: Barras horizontais (0-30, 31-60, 61-90, 90+ dias)
- **Top 5 Clientes que Pagam em Dia**: Ranking dos melhores pagadores
- **Top 15 Maiores Devedores**: Ranking dos maiores devedores
- **Gráficos Pizza**: Distribuição por clientes e montante geral

### Sistema de Filtros
- **Filtros Básicos**: Data, clientes, situação, forma de recebimento
- **Filtros Customizados**: Criação de filtros baseados em qualquer coluna
- **Validação**: Prevenção de filtros duplicados
- **Interface Intuitiva**: Modal para criação de novos filtros

## Instalação

### Pré-requisitos
- Python 3.8 ou superior
- pip (gerenciador de pacotes Python)

### Passos de Instalação

1. **Clone ou baixe o projeto**
   ```bash
   cd c:\desenv\neia_recebebiveis
   ```

2. **Instale as dependências**
   ```bash
   pip install -r requirements.txt
   ```

3. **Verifique a estrutura de pastas**
   ```
   neia_recebebiveis/
   ├── base_dados/          # Pasta para arquivos Excel
   ├── static/              # Arquivos estáticos (HTML, CSS, JS)
   ├── main.py              # Aplicação FastAPI
   ├── requirements.txt     # Dependências
   └── README.md           # Este arquivo
   ```

4. **Adicione seus arquivos Excel**
   - Coloque os arquivos Excel na pasta `base_dados/`
   - Os arquivos devem ter o cabeçalho padrão especificado

## Uso

### Iniciando o Servidor

```bash
python main.py
```

Ou usando uvicorn diretamente:

```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

### Acessando o Dashboard

Abra seu navegador e acesse:
```
http://localhost:8000
```

### Estrutura dos Arquivos de Dados

Os arquivos de dados devem estar na pasta `base_dados/` e podem ser nos seguintes formatos:
- **Excel**: `.xls`, `.xlsx`
- **CSV**: `.csv` (separado por vírgula)
- **TSV**: `.tsv` (separado por tab)
- **TXT**: `.txt` (detecta automaticamente separador)

Todos os formatos devem conter as seguintes colunas na ordem especificada:

1. **ID**: Identificador único
2. **Cliente**: Nome do cliente
3. **Data Emissão**: Data de emissão do documento
4. **Data Vencimento**: Data de vencimento
5. **Data Liquidação**: Data de liquidação (se pago)
6. **Valor documento**: Valor original do documento
7. **Saldo**: Saldo devedor atual
8. **Situação**: "Paga" ou "Em aberto"
9. **Número documento**: Número do documento
10. **Número no banco**: Número no banco
11. **Categoria**: Categoria do documento
12. **Histórico**: Histórico/observações
13. **Forma de recebimento**: Forma de recebimento
14. **Meio de recebimento**: Meio de recebimento
15. **Taxas**: Taxas aplicadas
16. **Competência**: Competência
17. **Recebimento**: Informações de recebimento
18. **Recebido**: Valor efetivamente recebido

#### Vantagens dos Arquivos CSV
- **Maior compatibilidade**: Funciona com qualquer editor de texto
- **Menor chance de corrupção**: Formato mais simples e robusto
- **Facilidade de edição**: Pode ser editado em qualquer programa
- **Melhor performance**: Carregamento mais rápido

### Monitoramento Automático

O sistema monitora automaticamente a pasta `base_dados/` e atualiza os dados quando:
- Novos arquivos Excel são adicionados
- Arquivos existentes são modificados
- O dashboard é atualizado automaticamente a cada 30 segundos

## API Endpoints

### Principais Endpoints

- `GET /`: Página principal do dashboard
- `GET /api/data`: Retorna todos os dados carregados
- `POST /api/kpis`: Calcula KPIs com filtros opcionais
- `GET /api/columns`: Retorna colunas disponíveis para filtros
- `POST /api/charts/*`: Endpoints para dados dos gráficos

### Exemplo de Uso da API

```javascript
// Obter KPIs com filtros
fetch('/api/kpis', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({
        data_inicio: '2025-01-01',
        data_fim: '2025-12-31',
        situacao: ['Em aberto']
    })
})
.then(response => response.json())
.then(data => console.log(data));
```

## Tecnologias Utilizadas

### Backend
- **FastAPI**: Framework web moderno e rápido
- **Pandas**: Manipulação e análise de dados
- **Watchdog**: Monitoramento de arquivos
- **OpenPyXL**: Leitura de arquivos Excel
- **Uvicorn**: Servidor ASGI

### Frontend
- **HTML5/CSS3**: Estrutura e estilização
- **JavaScript ES6+**: Lógica do frontend
- **Plotly.js**: Biblioteca de gráficos interativos
- **Axios**: Cliente HTTP para requisições
- **Font Awesome**: Ícones

## Personalização

### Modificando Cores e Estilos

Edite o arquivo `static/index.html` na seção `<style>` para personalizar:
- Cores dos gráficos
- Layout responsivo
- Estilos dos componentes

### Adicionando Novos KPIs

1. Modifique a função `calculate_kpis()` em `main.py`
2. Adicione o novo KPI no HTML
3. Atualize a função `updateKPIs()` no JavaScript

### Criando Novos Gráficos

1. Adicione novo endpoint em `main.py`
2. Crie função JavaScript correspondente
3. Adicione elemento HTML para o gráfico

## Solução de Problemas

### Problemas Comuns

1. **Erro ao carregar arquivos Excel**
   - Verifique se os arquivos estão na pasta `base_dados/`
   - Confirme se o cabeçalho está correto
   - Verifique se não há caracteres especiais nos nomes dos arquivos

2. **Dashboard não atualiza**
   - Verifique se o servidor está rodando
   - Confirme se há dados na pasta `base_dados/`
   - Verifique o console do navegador para erros JavaScript

3. **Gráficos não aparecem**
   - Verifique se o Plotly.js está carregando
   - Confirme se há dados suficientes para gerar os gráficos
   - Verifique a conexão com a API

### Logs e Debugging

O sistema exibe logs no console quando:
- Arquivos são carregados
- Dados são atualizados
- Erros ocorrem

Para debug detalhado, execute com:
```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --reload --log-level debug
```

## Contribuição

Para contribuir com o projeto:

1. Faça um fork do repositório
2. Crie uma branch para sua feature
3. Implemente as mudanças
4. Teste thoroughly
5. Submeta um pull request

## Licença

Este projeto é de uso interno da HolyFoods.

## Suporte

Para suporte técnico, entre em contato com a equipe de desenvolvimento.

---

**Dashboard de Inadimplência - HolyFoods**  
Versão 1.0 - 2025# dash_holyfoods
