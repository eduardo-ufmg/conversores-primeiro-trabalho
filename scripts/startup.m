%% STARTUP.M - Configuração inicial do projeto Conversores
% Execute este arquivo para configurar o ambiente MATLAB para o projeto

fprintf('=== Configurando Projeto Conversores ===\n');

% Obter diretório raiz do projeto
project_root = fileparts(mfilename('fullpath'));

% Adicionar caminhos necessários
addpath(fullfile(project_root, 'models', 'matlab'));
addpath(fullfile(project_root, 'scripts'));
addpath(fullfile(project_root, 'simulations'));

fprintf('Caminhos adicionados:\n');
fprintf('  - models/matlab\n');
fprintf('  - scripts\n');
fprintf('  - simulations\n');

% Criar diretórios se não existirem
dirs_to_create = {
    fullfile(project_root, 'data', 'input'),
    fullfile(project_root, 'data', 'output'), 
    fullfile(project_root, 'data', 'results'),
    fullfile(project_root, 'reports', 'figures')
};

for i = 1:length(dirs_to_create)
    if ~exist(dirs_to_create{i}, 'dir')
        mkdir(dirs_to_create{i});
        fprintf('Diretório criado: %s\n', dirs_to_create{i});
    end
end

% Configurações do ambiente
format compact;  % Formato compacto para exibição
close all;       % Fechar todas as figuras abertas

% Verificar se FEMM está disponível
try
    % Tentar inicializar FEMM (apenas teste)
    openfemm(0);
    closefemm;
    fprintf('✓ FEMM disponível e funcionando\n');
catch
    fprintf('⚠ FEMM não encontrado ou não configurado\n');
    fprintf('  Instale FEMM e configure a integração COM/ActiveX\n');
end

% Configurar propriedades padrão para figuras
set(0, 'DefaultFigureColor', 'white');
set(0, 'DefaultAxesFontSize', 12);
set(0, 'DefaultTextFontSize', 12);
set(0, 'DefaultLineLineWidth', 1.5);

% Definir variáveis globais do projeto
global PROJECT_CONFIG;
PROJECT_CONFIG.root = project_root;
PROJECT_CONFIG.data_input = fullfile(project_root, 'data', 'input');
PROJECT_CONFIG.data_output = fullfile(project_root, 'data', 'output');
PROJECT_CONFIG.data_results = fullfile(project_root, 'data', 'results');
PROJECT_CONFIG.models_femm = fullfile(project_root, 'models', 'femm');
PROJECT_CONFIG.models_simulink = fullfile(project_root, 'models', 'simulink');
PROJECT_CONFIG.reports_figures = fullfile(project_root, 'reports', 'figures');

fprintf('✓ Configuração concluída!\n');
fprintf('=== Projeto Conversores Pronto ===\n\n');

% Exibir informações úteis
fprintf('Comandos úteis:\n');
fprintf('  help femm_matlab_integration  - Ajuda sobre integração FEMM\n');
fprintf('  PROJECT_CONFIG                - Configurações do projeto\n');
fprintf('  cd(PROJECT_CONFIG.root)       - Ir para diretório raiz\n\n');