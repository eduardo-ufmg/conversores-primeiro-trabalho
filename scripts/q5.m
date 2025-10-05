clear all; clc; 

nome_arquivo_fem = 'sem_gap.fem'; 

corrente_saturacao = 2.92; % Corrente 100%
percentuais = [0.25, 0.50, 0.75, 1.0, 1.25, 1.50, 1.75];
correntes = corrente_saturacao * percentuais;
indutancias = zeros(size(correntes));

for k = 1:length(correntes)
    
    corrente_atual = correntes(k);
    percentual_atual = percentuais(k) * 100;
    
    fprintf('Rodando simulação para %.2f A (%.0f%%)\n', corrente_atual, percentual_atual);
    
    openfemm;
    opendocument(nome_arquivo_fem);
    
    mi_modifycircprop('Bobina', 1, corrente_atual);
    
    mi_saveas('temp_analise_item5.fem');
    mi_analyze(1);
    mi_loadsolution();
    
    propriedades = mo_getcircuitproperties('Bobina');
    indutancias(k) = propriedades(3);
    fprintf('A indutância para esta corrente é: %f H\n', indutancias(k));
    
    mo_showdensityplot(1, 0, 0, 2.0, 'bmag');
    mo_zoomnatural();
    
    % Pausa o script e espera o usuário
    input('pausa para tirar print do diagrama de fluxo..');
    
    closefemm;
end

disp('Valores de indutância calculados:');
disp(indutancias');

figure;
plot(correntes, indutancias, '-o', 'LineWidth', 2);
title('Item 5b: Indutância vs. Corrente (Sem Entreferro)');
xlabel('Corrente (A)');
ylabel('Indutância (H)');
grid on;

disp('Gráfico final gerado. Análise concluída.');