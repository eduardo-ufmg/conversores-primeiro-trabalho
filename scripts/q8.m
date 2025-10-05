
clear all; clc; closefemm;

nome_arquivo_fem = 'com_gap.fem'; 
corrente_saturacao = 2.92;
percentuais = [0.25, 0.50, 0.75, 1.0, 1.25, 1.50, 1.75];
correntes = corrente_saturacao * percentuais;
indutancias = zeros(size(correntes));

for k = 1:length(correntes)
    
    corrente_atual = correntes(k);
    percentual_atual = percentuais(k) * 100;
    
    fprintf('\n-------------------------------------------------\n');
    fprintf('Rodando simulação para %.2f A (%.0f%%)\n', corrente_atual, percentual_atual);
    
    % Abre o FEMM e o seu arquivo .fem
    openfemm;
    opendocument(nome_arquivo_fem);
    
    % Modifica a corrente no circuito para o valor da iteração atual
    mi_modifycircprop('Bobina', 1, corrente_atual);
    
    % Salva uma cópia temporária e roda a análise
    mi_saveas('temp_analise.fem');
    mi_analyze(1);
    mi_loadsolution();
    
    
    % Pega o valor da indutância
    propriedades = mo_getcircuitproperties('Bobina');
    indutancias(k) = propriedades(3);
    fprintf('A indutância para esta corrente é: %f H\n', indutancias(k));
    
    % Mostra o mapa de densidade na janela de resultados
    mo_showdensityplot(1, 0, 0, 2.0, 'bmag');
    mo_zoomnatural();
    
    % Pausa o script e espera o usuário
    input('esperando pra tirar print...');
    
    closefemm; % Fecha a instância do FEMM para a próxima iteração
end

figure;
plot(correntes, indutancias, '-o', 'LineWidth', 2, 'Color', 'r');
title('Item 8b: Indutância vs. Corrente (Com Entreferro)');
xlabel('Corrente (A)');
ylabel('Indutância (H)');
grid on;

disp('Gráfico final gerado. Análise concluída.');