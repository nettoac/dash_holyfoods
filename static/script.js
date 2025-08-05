// Variáveis globais
let allData = [];
let availableColumns = {};
let customFilters = [];
let allClients = [];
let selectedClients = new Set();
let lastDataTimestamp = null;

// Cores gradiente para os gráficos
const gradientColors = [
    'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
    'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)',
    'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)',
    'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)',
    'linear-gradient(135deg, #fa709a 0%, #fee140 100%)',
    'linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)',
    'linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%)',
    'linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)'
];

const montanteGradientColors = [
    'linear-gradient(135deg, #e74c3c 0%, #c0392b 100%)',
    'linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%)',
    'linear-gradient(135deg, #3498db 0%, #2980b9 100%)',
    'linear-gradient(135deg, #1abc9c 0%, #16a085 100%)',
    'linear-gradient(135deg, #f39c12 0%, #e67e22 100%)',
    'linear-gradient(135deg, #95a5a6 0%, #7f8c8d 100%)',
    'linear-gradient(135deg, #34495e 0%, #2c3e50 100%)',
    'linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%)'
];

// Função para clarear cores (criar efeito gradiente)
function lightenColor(color, percent) {
    const num = parseInt(color.replace('#', ''), 16);
    const amt = Math.round(2.55 * percent);
    const R = (num >> 16) + amt;
    const G = (num >> 8 & 0x00FF) + amt;
    const B = (num & 0x0000FF) + amt;
    return '#' + (0x1000000 + (R < 255 ? R < 1 ? 0 : R : 255) * 0x10000 +
        (G < 255 ? G < 1 ? 0 : G : 255) * 0x100 +
        (B < 255 ? B < 1 ? 0 : B : 255)).toString(16).slice(1);
}

// Formatação de moeda
function formatCurrency(value) {
    return new Intl.NumberFormat('pt-BR', {
        style: 'currency',
        currency: 'BRL',
        minimumFractionDigits: 2
    }).format(value);
}

// Formatação de número
function formatNumber(value, decimals = 2) {
    // Verifica se o valor é NaN, null, undefined ou não é um número válido
    if (value === null || value === undefined || isNaN(value) || !isFinite(value)) {
        value = 0;
    }
    return new Intl.NumberFormat('pt-BR', {
        minimumFractionDigits: decimals,
        maximumFractionDigits: decimals
    }).format(value);
}

// Função para recarregar dados manualmente
function reloadData() {
    fetch('/api/reload-data', { method: 'POST' })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Dados recarregados com sucesso!');
                // Força atualização completa do cache (equivalente a Ctrl+F5)
                window.location.href = window.location.href + '?cache_bust=' + new Date().getTime();
            } else {
                alert('Erro: ' + data.message);
            }
        });
}

// Variáveis globais para o modal de upload
let selectedFiles = [];

// Função para abrir o modal de upload
function openUploadModal() {
    document.getElementById('uploadModal').style.display = 'block';
    selectedFiles = [];
    updateFileList();
    updateUploadButton();
}

// Função para fechar o modal de upload
function closeUploadModal() {
    document.getElementById('uploadModal').style.display = 'none';
    selectedFiles = [];
    document.getElementById('fileList').innerHTML = '';
    document.getElementById('uploadProgress').style.display = 'none';
    document.getElementById('progressFill').style.width = '0%';
}

// Função para lidar com a seleção de arquivos
function handleFileSelection(files) {
    const fileArray = Array.from(files);
    
    // Filtrar apenas arquivos CSV
    const csvFiles = fileArray.filter(file => file.name.toLowerCase().endsWith('.csv'));
    
    if (csvFiles.length !== fileArray.length) {
        alert('Apenas arquivos CSV são permitidos. Alguns arquivos foram ignorados.');
    }
    
    // Adicionar arquivos à lista (evitar duplicatas)
    csvFiles.forEach(file => {
        if (!selectedFiles.some(f => f.name === file.name)) {
            selectedFiles.push(file);
        }
    });
    
    updateFileList();
    updateUploadButton();
    
    // Verificar se arquivos já existem
    if (selectedFiles.length > 0) {
        checkExistingFiles();
    }
}

// Função para verificar se arquivos já existem
async function checkExistingFiles() {
    const filenames = selectedFiles.map(file => file.name);
    
    try {
        const response = await fetch('/api/check-files', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(filenames)
        });
        
        const data = await response.json();
        
        if (data.success) {
            // Marcar arquivos duplicados
            selectedFiles.forEach(file => {
                const result = data.results.find(r => r.filename === file.name);
                file.isDuplicate = result ? result.exists : false;
            });
            
            updateFileList();
            updateUploadButton();
        }
    } catch (error) {
        console.error('Erro ao verificar arquivos:', error);
    }
}

// Função para atualizar a lista de arquivos
function updateFileList() {
    const fileList = document.getElementById('fileList');
    
    if (selectedFiles.length === 0) {
        fileList.innerHTML = '';
        return;
    }
    
    const html = selectedFiles.map((file, index) => {
        const sizeText = formatFileSize(file.size);
        const statusClass = file.isDuplicate ? 'duplicate' : 'ready';
        const statusText = file.isDuplicate ? 'Arquivo já existe!' : 'Pronto para envio';
        const itemClass = file.isDuplicate ? 'file-item duplicate' : 'file-item';
        
        return `
            <div class="${itemClass}">
                <div class="file-info">
                    <div class="file-name">${file.name}</div>
                    <div class="file-size">${sizeText}</div>
                    <div class="file-status ${statusClass}">${statusText}</div>
                </div>
                <button class="file-remove" onclick="removeFile(${index})" title="Remover arquivo">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        `;
    }).join('');
    
    fileList.innerHTML = html;
}

// Função para remover arquivo da lista
function removeFile(index) {
    selectedFiles.splice(index, 1);
    updateFileList();
    updateUploadButton();
}

// Função para formatar tamanho do arquivo
function formatFileSize(bytes) {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

// Função para atualizar o botão de upload
function updateUploadButton() {
    const uploadBtn = document.getElementById('uploadBtn');
    const validFiles = selectedFiles.filter(file => !file.isDuplicate);
    
    uploadBtn.disabled = validFiles.length === 0;
    
    if (selectedFiles.length === 0) {
        uploadBtn.innerHTML = '<i class="fas fa-upload"></i> Enviar Arquivos';
    } else {
        uploadBtn.innerHTML = `<i class="fas fa-upload"></i> Enviar ${validFiles.length} Arquivo(s)`;
    }
}

// Função para fazer upload dos arquivos selecionados
async function uploadSelectedFiles() {
    const validFiles = selectedFiles.filter(file => !file.isDuplicate);
    
    if (validFiles.length === 0) {
        alert('Nenhum arquivo válido para envio.');
        return;
    }
    
    // Mostrar barra de progresso
    document.getElementById('uploadProgress').style.display = 'block';
    document.getElementById('uploadBtn').disabled = true;
    
    let successCount = 0;
    let errorCount = 0;
    const errors = [];
    
    for (let i = 0; i < validFiles.length; i++) {
        const file = validFiles[i];
        const progress = ((i + 1) / validFiles.length) * 100;
        
        // Atualizar progresso
        document.getElementById('progressFill').style.width = progress + '%';
        document.getElementById('progressText').textContent = `Enviando ${file.name}... (${i + 1}/${validFiles.length})`;
        
        try {
            const formData = new FormData();
            formData.append('file', file);
            
            const response = await fetch('/api/upload-csv', {
                method: 'POST',
                body: formData
            });
            
            const data = await response.json();
            
            if (data.success) {
                successCount++;
            } else {
                errorCount++;
                errors.push(`${file.name}: ${data.message}`);
            }
        } catch (error) {
            errorCount++;
            errors.push(`${file.name}: Erro de conexão`);
        }
    }
    
    // Finalizar progresso
    document.getElementById('progressFill').style.width = '100%';
    document.getElementById('progressText').textContent = 'Upload concluído!';
    
    // Mostrar resultado
    let message = `Upload concluído!\n\n`;
    message += `✓ Arquivos enviados com sucesso: ${successCount}\n`;
    
    if (errorCount > 0) {
        message += `✗ Arquivos com erro: ${errorCount}\n\n`;
        message += 'Erros encontrados:\n' + errors.join('\n');
    }
    
    alert(message);
    
    // Fechar modal e recarregar dados
    closeUploadModal();
    
    if (successCount > 0) {
        location.reload();
    }
}

// Configurar drag and drop
document.addEventListener('DOMContentLoaded', function() {
    const dropZone = document.getElementById('dropZone');
    
    if (dropZone) {
        // Prevenir comportamento padrão
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            dropZone.addEventListener(eventName, preventDefaults, false);
        });
        
        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }
        
        // Destacar zona de drop
        ['dragenter', 'dragover'].forEach(eventName => {
            dropZone.addEventListener(eventName, highlight, false);
        });
        
        ['dragleave', 'drop'].forEach(eventName => {
            dropZone.addEventListener(eventName, unhighlight, false);
        });
        
        function highlight(e) {
            dropZone.classList.add('dragover');
        }
        
        function unhighlight(e) {
            dropZone.classList.remove('dragover');
        }
        
        // Lidar com arquivos soltos
        dropZone.addEventListener('drop', handleDrop, false);
        
        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;
            handleFileSelection(files);
        }
    }
});

// Carrega dados iniciais
async function loadInitialData() {
    try {
        const [dataResponse, columnsResponse] = await Promise.all([
            axios.get('/api/data'),
            axios.get('/api/columns')
        ]);

        allData = dataResponse.data.data;
        availableColumns = columnsResponse.data.unique_values;

        populateFilterOptions();
        updateDashboard();
    } catch (error) {
        console.error('Erro ao carregar dados:', error);
    }
}

// Popula opções dos filtros
function populateFilterOptions() {
    // Clientes - novo combobox
    allClients = availableColumns['Cliente'] || [];
    setupClientCombobox();

    // Forma de Recebimento
    const formaContainer = document.getElementById('formaRecebimento');
    formaContainer.innerHTML = '';
    if (availableColumns['Forma de recebimento']) {
        availableColumns['Forma de recebimento'].forEach(forma => {
            const label = document.createElement('label');
            const checkbox = document.createElement('input');
            checkbox.type = 'checkbox';
            checkbox.value = forma;
            label.appendChild(checkbox);
            label.appendChild(document.createTextNode(' ' + forma));
            formaContainer.appendChild(label);
        });
    }

    // Modal de filtro customizado
    const customColumnSelect = document.getElementById('customColumn');
    customColumnSelect.innerHTML = '';
    Object.keys(availableColumns).forEach(column => {
        const option = document.createElement('option');
        option.value = column;
        option.textContent = column;
        customColumnSelect.appendChild(option);
    });
}

function setupClientCombobox() {
    const searchInput = document.getElementById('clientSearch');
    const dropdown = document.getElementById('clientDropdown');
    const selectedContainer = document.getElementById('selectedClients');

    // Eventos do input de busca
    searchInput.addEventListener('input', function () {
        const searchTerm = this.value.toLowerCase();
        filterAndShowClients(searchTerm);
    });

    searchInput.addEventListener('focus', function () {
        filterAndShowClients(this.value.toLowerCase());
    });

    // Fechar dropdown ao clicar fora
    document.addEventListener('click', function (e) {
        if (!e.target.closest('.client-combobox')) {
            dropdown.classList.remove('show');
        }
    });

    updateSelectedClientsDisplay();
}

function filterAndShowClients(searchTerm) {
    const dropdown = document.getElementById('clientDropdown');
    const filteredClients = allClients.filter(client =>
        client.toLowerCase().includes(searchTerm)
    );

    dropdown.innerHTML = '';
    filteredClients.forEach(client => {
        const option = document.createElement('div');
        option.className = 'client-option';
        option.innerHTML = `
            <input type="checkbox" id="client_${client}" ${selectedClients.has(client) ? 'checked' : ''}>
            <label for="client_${client}">${client}</label>
        `;

        const checkbox = option.querySelector('input');
        checkbox.addEventListener('change', function () {
            if (this.checked) {
                selectedClients.add(client);
            } else {
                selectedClients.delete(client);
            }
            updateSelectedClientsDisplay();
            updateDashboard();
        });

        dropdown.appendChild(option);
    });

    dropdown.classList.add('show');
}

function updateSelectedClientsDisplay() {
    const container = document.getElementById('selectedClients');
    container.innerHTML = '';

    selectedClients.forEach(client => {
        const tag = document.createElement('div');
        tag.className = 'client-tag';
        tag.innerHTML = `
            ${client}
            <span class="remove" onclick="removeClient('${client}')">&times;</span>
        `;
        container.appendChild(tag);
    });
}

function removeClient(client) {
    selectedClients.delete(client);
    updateSelectedClientsDisplay();
    // Atualizar checkbox no dropdown se estiver visível
    const checkbox = document.getElementById(`client_${client}`);
    if (checkbox) {
        checkbox.checked = false;
    }
    updateDashboard();
}

// Atualiza dashboard
async function updateDashboard() {
    try {
        const filters = getCurrentFilters();

        const [
            kpisResponse,
            faixaRecebimentoResponse,
            faixaVencimentoResponse,
            topPagadoresResponse,
            topDevedoresResponse,
            pizzaClientesResponse,
            pizzaMontanteResponse
        ] = await Promise.all([
            axios.post('/api/kpis', filters),
            axios.post('/api/charts/faixa-recebimento', filters),
            axios.post('/api/charts/faixa-vencimento', filters),
            axios.post('/api/charts/top-pagadores', filters),
            axios.post('/api/charts/top-devedores', filters),
            axios.post('/api/charts/pizza-clientes', filters),
            axios.post('/api/charts/pizza-montante', filters)
        ]);

        updateKPIs(kpisResponse.data);
        updateFaixaRecebimentoChart(faixaRecebimentoResponse.data);
        updateFaixaVencimentoChart(faixaVencimentoResponse.data);
        updateTopPagadoresChart(topPagadoresResponse.data);
        updateTopDevedoresChart(topDevedoresResponse.data);
        updatePizzaClientesChart(pizzaClientesResponse.data);
        updatePizzaMontanteChart(pizzaMontanteResponse.data);
    } catch (error) {
        console.error('Erro ao atualizar dashboard:', error);
    }
}

// Obtém filtros atuais
function getCurrentFilters() {
    const filters = {};

    const dataInicio = document.getElementById('dataInicio').value;
    const dataFim = document.getElementById('dataFim').value;

    // Clientes - do combobox
    const clientesChecked = Array.from(selectedClients);

    // Situação - checkboxes
    const situacaoChecked = Array.from(document.querySelectorAll('#situacao input[type="checkbox"]:checked')).map(cb => cb.value);

    // Forma de Recebimento - checkboxes
    const formaRecebimentoChecked = Array.from(document.querySelectorAll('#formaRecebimento input[type="checkbox"]:checked')).map(cb => cb.value);

    if (dataInicio) filters.data_inicio = dataInicio;
    if (dataFim) filters.data_fim = dataFim;
    if (clientesChecked.length > 0) filters.clientes = clientesChecked;
    if (situacaoChecked.length > 0) filters.situacao = situacaoChecked;
    if (formaRecebimentoChecked.length > 0) filters.forma_recebimento = formaRecebimentoChecked;
    if (customFilters.length > 0) filters.custom_filters = customFilters;

    return filters;
}

// Atualiza KPIs
function updateKPIs(kpis) {
    document.getElementById('kpi-montante').textContent = formatCurrency(kpis.montante);
    document.getElementById('kpi-pago').textContent = formatCurrency(kpis.pago_recebido);
    document.getElementById('kpi-vencido').textContent = formatCurrency(kpis.vencido);
    document.getElementById('kpi-em-aberto').textContent = formatCurrency(kpis.em_aberto);
    document.getElementById('kpi-qtd-vencidos').textContent = kpis.qtd_vencidos;
    document.getElementById('kpi-total-titulos').textContent = kpis.total_titulos;
    document.getElementById('kpi-atraso-medio').textContent = formatNumber(kpis.atraso_medio, 0);
    document.getElementById('kpi-inadimplencia').textContent = formatNumber(kpis.inadimplencia) + '%';
    // Tratamento especial para IAG e IAP
    const iagValue = (kpis.iag === null || kpis.iag === undefined || isNaN(kpis.iag) || !isFinite(kpis.iag)) ? 0 : kpis.iag;
    const iapValue = (kpis.iap === null || kpis.iap === undefined || isNaN(kpis.iap) || !isFinite(kpis.iap)) ? 0 : kpis.iap;

    document.getElementById('kpi-iag').textContent = formatNumber(iagValue) + '%';
    document.getElementById('kpi-iap').textContent = formatNumber(iapValue) + '%';
}

// Atualiza gráfico de faixa de recebimento
function updateFaixaRecebimentoChart(data) {
    // Ordenar as faixas na ordem correta: 0-30, 31-60, 61-90, +90
    const ordenacao = ['0-30 dias', '31-60 dias', '61-90 dias', '+90 dias'];
    const labels = [];
    const values = [];

    ordenacao.forEach(faixa => {
        if (data[faixa] !== undefined) {
            labels.push(faixa);
            values.push(data[faixa]);
        }
    });

    const trace = {
        type: 'bar',
        orientation: 'h',
        x: values,
        y: labels,
        marker: {
            color: ['#4CAF50', '#FFC107', '#FF9800', '#F44336'],
            opacity: 0.8
        },
        text: values.map(v => formatCurrency(v)),
        textposition: 'auto',
        textfont: { size: 10 }
    };

    const layout = {
        margin: { l: 80, r: 20, t: 10, b: 30 },
        height: 280,
        xaxis: { title: '', showgrid: true },
        yaxis: { title: '', autorange: 'reversed' },
        showlegend: false,
        font: { size: 11 }
    };

    Plotly.newPlot('chart-faixa-recebimento', [trace], layout, { responsive: true });
}

// Atualiza gráfico de faixa de vencimento
function updateFaixaVencimentoChart(data) {
    // Ordenar as faixas na ordem correta: 0-30, 31-60, 61-90, +90
    const ordenacao = ['0-30 dias', '31-60 dias', '61-90 dias', '+90 dias'];
    const labels = [];
    const values = [];

    ordenacao.forEach(faixa => {
        if (data[faixa] !== undefined) {
            labels.push(faixa);
            values.push(data[faixa]);
        }
    });

    const trace = {
        type: 'bar',
        orientation: 'h',
        x: values,
        y: labels,
        marker: {
            color: ['#FF5722', '#FF7043', '#FF8A65', '#FFAB91'],
            opacity: 0.8
        },
        text: values.map(v => formatCurrency(v)),
        textposition: 'auto',
        textfont: { size: 10 }
    };

    const layout = {
        margin: { l: 80, r: 20, t: 10, b: 30 },
        height: 280,
        xaxis: { title: '', showgrid: true },
        yaxis: { title: '', autorange: 'reversed' },
        showlegend: false,
        font: { size: 11 }
    };

    Plotly.newPlot('chart-faixa-vencimento', [trace], layout, { responsive: true });
}

// Atualiza gráfico de top pagadores (Pareto - maior para menor)
function updateTopPagadoresChart(data) {
    // Converter para array e ordenar do maior para o menor
    const sortedData = Object.entries(data)
        .sort(([, a], [, b]) => b - a)
        .slice(0, 5); // Limitar a 5 itens

    const labels = sortedData.map(([key]) => key);
    const values = sortedData.map(([, value]) => value);

    const trace = {
        type: 'bar',
        orientation: 'h',
        x: values,
        y: labels,
        marker: {
            color: ['#006400', '#228B22', '#32CD32', '#7CFC00', '#90EE90'],
            opacity: 0.8
        },
        text: values.map(v => formatCurrency(v)),
        textposition: 'auto',
        textfont: { size: 10 }
    };

    const layout = {
        margin: { l: 120, r: 20, t: 10, b: 30 },
        height: 280,
        xaxis: { title: '', showgrid: true },
        yaxis: { title: '', autorange: 'reversed' },
        showlegend: false,
        font: { size: 10 }
    };

    Plotly.newPlot('chart-top-pagadores', [trace], layout, { responsive: true });
}

// Atualiza gráfico de top devedores (Pareto - maior para menor)
function updateTopDevedoresChart(data) {
    // Converter para array e ordenar do maior para o menor
    const sortedData = Object.entries(data)
        .sort(([, a], [, b]) => b - a)
        .slice(0, 15); // Limitar a 15 itens

    const labels = sortedData.map(([key]) => key);
    const values = sortedData.map(([, value]) => value);

    // Cores em gradiente do vermelho mais forte para mais claro
    const colors = [
        '#8B0000', '#B22222', '#DC143C', '#FF1493', '#FF4500',
        '#FF6347', '#FF7F50', '#FF8C00', '#FFA500', '#FFD700',
        '#F0E68C', '#BDB76B', '#9ACD32', '#7CFC00', '#90EE90'
    ];

    const trace = {
        type: 'bar',
        orientation: 'h',
        x: values,
        y: labels,
        marker: {
            color: colors.slice(0, values.length),
            opacity: 0.8
        },
        text: values.map(v => formatCurrency(v)),
        textposition: 'auto',
        textfont: { size: 9 }
    };

    const layout = {
        margin: { l: 120, r: 20, t: 10, b: 30 },
        height: 320,
        xaxis: { title: '', showgrid: true },
        yaxis: { title: '', autorange: 'reversed' },
        showlegend: false,
        font: { size: 10 }
    };

    Plotly.newPlot('chart-top-devedores', [trace], layout, { responsive: true });
}

// Atualiza gráfico pizza de formas de recebimento
function updatePizzaClientesChart(data) {
    const labels = Object.keys(data);
    const values = Object.values(data).map(v => Math.abs(v));
    const total = values.reduce((a, b) => a + b, 0);
    
    // Mostrar todas as formas de recebimento sem agrupamento
    const processedLabels = labels;
    const processedValues = values;

    // Cores com gradientes reais
    const vibrant3DColors = [
        '#FF6B35', '#4ECDC4', '#45B7D1', '#96CEB4', 
        '#FFEAA7', '#DDA0DD', '#FF7675', '#74B9FF', 
        '#00B894', '#FDCB6E', '#A29BFE', '#FD79A8'
    ];
    
    // Criar gradientes para cada setor
    const gradientPatterns = processedLabels.map((label, index) => {
        const baseColor = vibrant3DColors[index % vibrant3DColors.length];
        const lighterColor = lightenColor(baseColor, 30);
        return `radial-gradient(circle, ${lighterColor} 0%, ${baseColor} 100%)`;
    });
    
    // Extrusão dinâmica baseada no valor (setores menores mais destacados)
    const pullValues = processedValues.map(v => {
        const percentage = (v / total) * 100;
        return percentage < 10 ? 0.15 : 0.05;
    });

    const trace = {
        type: 'pie',
        labels: processedLabels,
        values: processedValues,
        marker: {
            colors: gradientPatterns,
            line: { color: '#FFFFFF', width: 3 }
        },
        textfont: {
            family: 'Arial Black, sans-serif',
            size: 16,  // Aumentado para melhor legibilidade
            color: '#FFFFFF'
        },
        textinfo: 'label+percent+value',  // Incluir valores em R$
        textposition: 'inside',
        hole: 0.2,  // Reduzido para dar mais espaço aos textos
        pull: pullValues,  // Extrusão dinâmica
        sort: false,
        rotation: 45,
        // Hover customizado
        hovertemplate: '<b>%{label}</b><br>' +
                      'Valor: R$ %{value:,.2f}<br>' +
                      'Percentual: %{percent}<br>' +
                      '<extra></extra>',
        // Animação de entrada
        animation: {
            duration: 1000,
            easing: 'cubic-in-out'
        }
    };

    const layout = {
        showlegend: true,
        legend: {
            orientation: 'v',  // Vertical para economizar espaço
            y: 0.5,
            x: 1.05,  // Posicionado à direita
            xanchor: 'left',
            font: { size: 12, color: '#333', family: 'Arial' }
        },
        paper_bgcolor: 'rgba(0,0,0,0)',
        plot_bgcolor: 'rgba(0,0,0,0)',
        margin: { t: 50, b: 50, l: 50, r: 120 },  // Margem ajustada
        height: 350,  // Altura reduzida para caber na área
        width: 500,   // Largura reduzida para caber na área
        // Anotação lateral com total
        annotations: [{
            text: `<b>💰 TOTAL GERAL</b><br><span style="font-size:12px;color:#2c3e50;font-weight:bold">${formatCurrency(total)}</span>`,
            x: 1.1, y: 0.85,  // Posicionado à direita
            font: { size: 12, color: '#2c3e50', family: 'Arial Black' },
            showarrow: false,
            align: 'left',
            xanchor: 'left'
        }]
    };

    const config = {
        responsive: true,
        displayModeBar: false
    };

    Plotly.newPlot('chart-pizza-clientes', [trace], layout, config);
}

// Atualiza gráfico pizza do montante
function updatePizzaMontanteChart(data) {
    const labels = Object.keys(data);
    const values = Object.values(data).map(v => Math.abs(v));
    const total = values.reduce((a, b) => a + b, 0);
    
    // Mostrar todas as formas de recebimento sem agrupamento
    const processedLabels = labels;
    const processedValues = values;

    // Paleta diferenciada para o montante com gradientes
    const montanteColors = [
        '#E74C3C', '#9B59B6', '#3498DB', '#1ABC9C', 
        '#F39C12', '#E67E22', '#95A5A6', '#34495E', 
        '#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A'
    ];
    
    // Criar gradientes para cada setor do montante
    const montanteGradientPatterns = processedLabels.map((label, index) => {
        const baseColor = montanteColors[index % montanteColors.length];
        const lighterColor = lightenColor(baseColor, 30);
        return `radial-gradient(circle, ${lighterColor} 0%, ${baseColor} 100%)`;
    });
    
    // Extrusão mais sutil para o gráfico de montante
    const pullValues = processedValues.map(v => {
        const percentage = (v / total) * 100;
        return percentage < 8 ? 0.12 : 0.03;
    });

    const trace = {
        type: 'pie',
        labels: processedLabels,
        values: processedValues,
        marker: {
            colors: montanteGradientPatterns,
            line: { color: '#FFFFFF', width: 2.5 }
        },
        textfont: {
            family: 'Arial Black, sans-serif',
            size: 16,  // Aumentado para melhor legibilidade
            color: '#FFFFFF'
        },
        textinfo: 'label+percent+value',  // Incluir valores em R$
        textposition: 'inside',
        hole: 0.2,  // Reduzido para dar mais espaço aos textos
        pull: pullValues,
        sort: false,
        rotation: -30,  // Rotação diferente
        // Hover customizado específico para montante
        hovertemplate: '<b>%{label}</b><br>' +
                      'Montante: R$ %{value:,.2f}<br>' +
                      'Participação: %{percent}<br>' +
                      '<extra></extra>',
        // Animação com delay
        animation: {
            duration: 1200,
            easing: 'elastic-out'
        }
    };

    const layout = {
        showlegend: true,
        legend: {
            orientation: 'v',  // Vertical para economizar espaço
            y: 0.5,
            x: 1.05,  // Posicionado à direita
            xanchor: 'left',
            font: { size: 12, color: '#333', family: 'Arial' }
        },
        paper_bgcolor: 'rgba(0,0,0,0)',
        plot_bgcolor: 'rgba(0,0,0,0)',
        margin: { t: 50, b: 50, l: 50, r: 120 },  // Margem ajustada
        height: 350,  // Altura reduzida para caber na área
        width: 500,   // Largura reduzida para caber na área
        // Anotação lateral com total - alinhada com o gráfico superior
        annotations: [{
            text: `<b>📊 TOTAL GERAL</b><br><span style="font-size:12px;color:#2c3e50;font-weight:bold">${formatCurrency(total)}</span>`,
            x: 1.05, y: 0.9,  // Posicionado à direita e mais alto para alinhar
            font: { size: 12, color: '#2c3e50', family: 'Arial Black' },
            showarrow: false,
            align: 'left',
            xanchor: 'left'
        }]
    };

    const config = {
        responsive: true,
        displayModeBar: false
    };

    Plotly.newPlot('chart-pizza-montante', [trace], layout, config);
}

// Aplica filtros
function applyFilters() {
    updateDashboard();
}

// Limpa filtros
function clearFilters() {
    document.getElementById('dataInicio').value = '';
    document.getElementById('dataFim').value = '';

    // Limpar clientes selecionados
    selectedClients.clear();
    updateSelectedClientsDisplay();

    // Desmarcar outros checkboxes
    document.querySelectorAll('#situacao input[type="checkbox"]').forEach(cb => cb.checked = false);
    document.querySelectorAll('#formaRecebimento input[type="checkbox"]').forEach(cb => cb.checked = false);

    customFilters = [];
    updateCustomFiltersDisplay();
    updateDashboard();
}

// Modal de filtro customizado
function openCustomFilterModal() {
    document.getElementById('customFilterModal').style.display = 'block';
    updateCustomColumnValues();
}

function closeCustomFilterModal() {
    document.getElementById('customFilterModal').style.display = 'none';
}

function updateCustomColumnValues() {
    const column = document.getElementById('customColumn').value;
    const valuesSelect = document.getElementById('customValues');
    valuesSelect.innerHTML = '';

    if (column && availableColumns[column]) {
        availableColumns[column].forEach(value => {
            const option = document.createElement('option');
            option.value = value;
            option.textContent = value;
            valuesSelect.appendChild(option);
        });
    }
}

function addCustomFilter() {
    const column = document.getElementById('customColumn').value;
    const values = Array.from(document.getElementById('customValues').selectedOptions).map(o => o.value);

    if (column && values.length > 0) {
        // Verificar se o filtro já existe
        const existingFilter = customFilters.find(f => f.column === column);
        if (existingFilter) {
            alert('Filtro para esta coluna já existe!');
            return;
        }

        customFilters.push({ column, values });
        updateCustomFiltersDisplay();
        closeCustomFilterModal();
    }
}

function updateCustomFiltersDisplay() {
    const container = document.getElementById('customFilters');
    container.innerHTML = '';

    customFilters.forEach((filter, index) => {
        const filterDiv = document.createElement('div');
        filterDiv.className = 'custom-filter-item';
        filterDiv.innerHTML = `
            <strong>${filter.column}:</strong> ${filter.values.join(', ')}
            <button class="remove-filter" onclick="removeCustomFilter(${index})">
                <i class="fas fa-times"></i>
            </button>
        `;
        container.appendChild(filterDiv);
    });
}

function removeCustomFilter(index) {
    customFilters.splice(index, 1);
    updateCustomFiltersDisplay();
}

// Função para mostrar notificação
function showNotification(message) {
    const notification = document.getElementById('notification');
    const messageElement = document.getElementById('notification-message');

    messageElement.textContent = message;
    notification.classList.remove('hidden');
    notification.classList.add('show');

    setTimeout(() => {
        notification.classList.remove('show');
        notification.classList.add('hidden');
    }, 1000);
}

// Função para mostrar alerta Bootstrap
function showFileAlert(message, type) {
    const alertContainer = document.getElementById('file-alerts-container');
    const alertId = 'alert-' + Date.now();

    const alertHtml = `
        <div id="${alertId}" class="alert alert-${type} alert-dismissible fade show" role="alert" style="margin-bottom: 10px;">
            <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'warning' ? 'exclamation-triangle' : 'times-circle'}"></i>
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    `;

    alertContainer.insertAdjacentHTML('beforeend', alertHtml);

    // Auto-remover após 5 segundos
    setTimeout(() => {
        const alert = document.getElementById(alertId);
        if (alert) {
            alert.remove();
        }
    }, 5000);
}

// Função para verificar notificações de arquivo
function checkFileNotifications() {
    fetch('/api/file-notification')
        .then(response => response.json())
        .then(notification => {
            if (notification && notification.message) {
                showFileAlert(notification.message, notification.type);
                // Recarregar dados quando houver mudança
                loadInitialData();
            }
        })
        .catch(error => {
            console.error('Erro ao verificar notificações:', error);
        });
}

// Função para verificar arquivos problemáticos
function checkProblematicFiles() {
    fetch('/api/problematic-files')
        .then(response => response.json())
        .then(data => {
            if (data.count > 0) {
                const fileList = data.problematic_files.join(', ');
                const message = `⚠️ ${data.count} arquivo(s) com problemas: ${fileList}. ${data.message}`;
                showFileAlert(message, 'warning');
            }
        })
        .catch(error => {
            console.error('Erro ao verificar arquivos problemáticos:', error);
        });
}

// Event listeners
document.addEventListener('DOMContentLoaded', function () {
    // Event listener para mudança de coluna customizada
    document.getElementById('customColumn').addEventListener('change', updateCustomColumnValues);

    // Fechar modal ao clicar fora
    window.onclick = function (event) {
        const modal = document.getElementById('customFilterModal');
        if (event.target === modal) {
            closeCustomFilterModal();
        }
    }

    // Inicializar aplicação
    loadInitialData();

    // Verificar arquivos problemáticos na inicialização
    checkProblematicFiles();

    // Inicializar timestamp para detecção de novos arquivos
    fetch('/api/data')
        .then(response => response.json())
        .then(data => {
            lastDataTimestamp = data.last_update;
        })
        .catch(error => console.error('Erro ao inicializar timestamp:', error));
});

// Auto-refresh a cada 10 segundos para verificar mudanças de arquivo
setInterval(() => {
    checkFileNotifications();
}, 10000);

// Auto-refresh de dados a cada 30 segundos (apenas recarrega dados se não há filtros ativos)
setInterval(() => {
    const filters = getCurrentFilters();
    const hasActiveFilters = Object.keys(filters).length > 0;
    if (!hasActiveFilters) {
        // Verificar se há novos dados
        fetch('/api/data')
            .then(response => response.json())
            .then(data => {
                if (lastDataTimestamp && data.last_update !== lastDataTimestamp) {
                    showNotification('Dados atualizados!');
                }
                lastDataTimestamp = data.last_update;
                loadInitialData();
            })
            .catch(error => {
                console.error('Erro ao verificar novos dados:', error);
                loadInitialData();
            });
    }
}, 30000);