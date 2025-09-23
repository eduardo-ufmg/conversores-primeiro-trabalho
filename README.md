# Conversores - Primeiro Trabalho

Este repositório contém os arquivos do primeiro trabalho sobre conversores, utilizando integração entre FEMM (Finite Element Method Magnetics), MATLAB e Simulink para análise e simulação de componentes magnéticos e circuitos de conversores de potência.

## Estrutura do Projeto

```
├── models/                 # Arquivos de modelo
│   ├── femm/              # Modelos FEMM (.fem)
│   ├── simulink/          # Modelos Simulink (.slx, .mdl)
│   └── matlab/            # Funções MATLAB para modelagem
├── simulations/           # Scripts de simulação e configuração
├── reports/               # Relatórios e documentação
│   ├── latex/            # Código LaTeX dos relatórios
│   ├── figures/          # Figuras geradas
│   ├── analysis/         # Análises e resultados
│   └── presentations/    # Apresentações
├── data/                  # Dados de entrada e resultados
│   ├── input/            # Dados de entrada
│   ├── output/           # Saídas brutas das simulações
│   └── results/          # Resultados processados
├── scripts/               # Scripts utilitários e automação
└── docs/                  # Documentação técnica e guias

```

## Ferramentas Utilizadas

### FEMM (Finite Element Method Magnetics)
- Análise de campos magnéticos por elementos finitos
- Modelagem de componentes magnéticos (transformadores, indutores)
- Arquivos de modelo: `.fem`

### MATLAB
- Processamento de dados e análise numérica
- Scripts de automação e pós-processamento
- Integração com FEMM e Simulink
- Arquivos: `.m`, `.mat`

### Simulink
- Simulação de circuitos de conversores
- Modelagem de sistemas dinâmicos
- Arquivos de modelo: `.slx`, `.mdl`

## Fluxo de Trabalho

1. **Modelagem Magnética**: Desenvolvimento de modelos FEMM para componentes magnéticos
2. **Extração de Parâmetros**: Uso do MATLAB para processar resultados do FEMM
3. **Simulação de Circuitos**: Implementação em Simulink usando parâmetros extraídos
4. **Análise de Resultados**: Processamento e visualização dos dados
5. **Documentação**: Geração de relatórios técnicos

## Convenções de Nomenclatura

### Arquivos de Modelo
- `[componente]_[configuracao]_v[versao].[extensao]`
- Exemplo: `boost_converter_v1_0.slx`, `transformer_core_analysis.fem`

### Scripts e Simulações
- `[funcao]_[componente]_[parametro].m`
- Exemplo: `simulate_boost_efficiency.m`, `extract_inductance_femm.m`

## Como Usar

1. Clone este repositório
2. Configure o MATLAB com os caminhos necessários
3. Instale o FEMM e configure a integração com MATLAB
4. Execute os scripts na ordem indicada na documentação

## Contribuição

- Mantenha a estrutura de diretórios organizada
- Documente todos os modelos e simulações
- Use controle de versão para arquivos importantes
- Mantenha README.md atualizado em cada diretório

## Licença

Este projeto está licenciado sob a MIT License - veja o arquivo [LICENSE](LICENSE) para detalhes.