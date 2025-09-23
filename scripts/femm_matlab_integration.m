function params = femm_matlab_integration(fem_file, varargin)
% FEMM_MATLAB_INTEGRATION Integra FEMM com MATLAB para extração de parâmetros
%
% SYNTAX:
%   params = femm_matlab_integration(fem_file)
%   params = femm_matlab_integration(fem_file, 'parameter', value, ...)
%
% INPUTS:
%   fem_file - String com caminho para arquivo .fem
%
% OPTIONAL PARAMETERS:
%   'current' - Valor da corrente para análise (default: 1)
%   'frequency' - Frequência de operação em Hz (default: 50)
%   'plot' - Mostrar gráficos dos resultados (default: false)
%
% OUTPUTS:
%   params - Struct com parâmetros extraídos
%     .inductance - Indutância em H
%     .resistance - Resistência em Ohm
%     .flux_density - Densidade de fluxo máxima em T
%     .energy - Energia magnética em J
%
% EXAMPLE:
%   params = femm_matlab_integration('models/femm/inductor_core.fem', ...
%                                   'current', 2, 'frequency', 100, 'plot', true);
%
% See also: OPENFEMM, MI_ANALYZE, MO_LINEINTEGRAL

% Verificar se arquivo existe
if ~exist(fem_file, 'file')
    error('Arquivo FEMM não encontrado: %s', fem_file);
end

% Parser de argumentos opcionais
p = inputParser;
addParameter(p, 'current', 1, @isnumeric);
addParameter(p, 'frequency', 50, @isnumeric);
addParameter(p, 'plot', false, @islogical);
parse(p, varargin{:});

current = p.Results.current;
frequency = p.Results.frequency;
show_plot = p.Results.plot;

try
    % Inicializar FEMM
    fprintf('Inicializando FEMM...\n');
    openfemm(0); % 0 = minimizado
    
    % Abrir arquivo
    fprintf('Carregando arquivo: %s\n', fem_file);
    opendocument(fem_file);
    
    % Configurar corrente se necessário
    if current ~= 1
        % Aqui você pode implementar lógica para ajustar corrente
        % dependendo do seu modelo específico
        fprintf('Configurando corrente: %.2f A\n', current);
    end
    
    % Executar análise
    fprintf('Executando análise magnética...\n');
    mi_analyze(1); % 1 = minimizado
    mi_loadsolution;
    
    % Extrair parâmetros magnéticos
    fprintf('Extraindo parâmetros...\n');
    
    % Calcular indutância (exemplo - adapte para seu modelo)
    % Este é um exemplo genérico - você deve adaptar para sua geometria
    flux_total = mo_lineintegral(4); % Fluxo total
    params.inductance = abs(flux_total / current);
    
    % Calcular energia magnética
    params.energy = mo_blockintegral(2); % Energia magnética
    
    % Calcular densidade de fluxo máxima
    mo_selectblock(0, 0); % Selecionar ponto no núcleo
    flux_density = mo_getb(0, 0); % Obter B no ponto
    params.flux_density = sqrt(flux_density(1)^2 + flux_density(2)^2);
    
    % Resistência (aproximação - pode ser calculada com perdas)
    % Este é um exemplo - implemente conforme necessário
    params.resistance = 0.1; % Placeholder
    
    % Parâmetros adicionais
    params.frequency = frequency;
    params.current = current;
    params.timestamp = datetime('now');
    
    % Plotar resultados se solicitado
    if show_plot
        plot_femm_results(params);
    end
    
    % Salvar dados
    [~, name, ~] = fileparts(fem_file);
    output_file = fullfile('data/results', sprintf('%s_params_%s.mat', ...
                          name, datestr(now, 'yyyymmdd_HHMMSS')));
    
    % Criar diretório se não existir
    if ~exist('data/results', 'dir')
        mkdir('data/results');
    end
    
    save(output_file, 'params');
    fprintf('Parâmetros salvos em: %s\n', output_file);
    
    % Fechar FEMM
    closefemm;
    
    fprintf('Análise concluída com sucesso!\n');
    
catch ME
    % Fechar FEMM em caso de erro
    try
        closefemm;
    catch
        % Ignorar erro ao fechar
    end
    
    fprintf('Erro durante análise: %s\n', ME.message);
    rethrow(ME);
end

end

function plot_femm_results(params)
% PLOT_FEMM_RESULTS Plota resultados da análise FEMM
    figure('Name', 'Resultados da Análise FEMM');
    
    subplot(2, 2, 1);
    bar(params.inductance * 1000); % em mH
    title('Indutância');
    ylabel('L (mH)');
    grid on;
    
    subplot(2, 2, 2);
    bar(params.resistance * 1000); % em mΩ
    title('Resistência');
    ylabel('R (mΩ)');
    grid on;
    
    subplot(2, 2, 3);
    bar(params.flux_density);
    title('Densidade de Fluxo Máxima');
    ylabel('B (T)');
    grid on;
    
    subplot(2, 2, 4);
    bar(params.energy * 1000); % em mJ
    title('Energia Magnética');
    ylabel('E (mJ)');
    grid on;
    
    sgtitle(sprintf('Análise para I = %.1f A, f = %.0f Hz', ...
                   params.current, params.frequency));
end