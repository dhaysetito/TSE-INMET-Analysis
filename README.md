# Análise de Dados Públicos: Eleições 2024 e Dados Meteorológicos

## Descrição
Este projeto realiza a análise de dois conjuntos de dados públicos utilizando o Microsoft Excel, com foco nas tarefas de carga, transformação e análise de dados. Os datasets analisados são:

1. **Perfil do Eleitorado - Eleições Municipais 2024 (TSE)**: Comparação entre os perfis de eleitores de dois estados brasileiros, RJ e SP. Na analise em R foi feita, RJ e BA.
2. **Dados Meteorológicos (INMET)**: Comparação dos dados de 2022 e 2023 da estação A807.

O objetivo do projeto é aplicar técnicas de manipulação de dados, visualização gráfica e geração de insights com base em dados reais, desenvolvendo habilidades de análise com MS-Excel.

## Estrutura do Projeto

- **Dataset 1: Perfil do Eleitorado (TSE)**  
  Analisamos dados do eleitorado para as eleições municipais de 2024, utilizando as seguintes colunas:  
  - NM_MUNICIPIO
  - CD_GENERO / DS_GENERO
  - CD_ESTADO_CIVIL / DS_ESTADO_CIVIL
  - CD_FAIXA_ETARIA / DS_FAIXA_ETARIA
  - CD_GRAU_ESCOLARIDADE / DS_GRAU_ESCOLARIDADE
  - QT_ELEITORES_PERFIL

  As tarefas envolvem projeção (eliminação de colunas), filtragem de dados, cálculo de estatísticas básicas e uso de tabelas dinâmicas para responder perguntas específicas sobre o perfil eleitoral dos municípios selecionados.

- **Dataset 2: Dados Meteorológicos (INMET)**  
  Comparação entre os dados meteorológicos de dois anos consecutivos de uma única estação automática, com foco nas seguintes variáveis:  
  - Precipitação Total
  - Pressão Atmosférica
  - Temperatura Máxima, Mínima e Média
  - Velocidade e Direção do Vento

  A análise inclui filtragem de dados, eliminação de outliers, estatísticas básicas e uso de tabelas dinâmicas para agrupar e visualizar os dados por período (mensal, trimestral, etc.).

## Funcionalidades
- Carga dos arquivos CSV no MS-Excel.
- Transformações, como projeção de colunas e filtro de linhas.
- Estatísticas descritivas (média, moda, mediana, desvio padrão, etc.).
- Visualizações gráficas (gráficos de barra, heatmaps, etc.).
- Tabelas dinâmicas para análise interativa.

## Estrutura do Repositório

```
├── datasets/              # Diretório contendo os arquivos CSV utilizados
├── analises/              # Resultados da análise e arquivos do Excel
├── analises-R/            # Analises em R
├── README.md              # Este arquivo
└── LICENSE                # Licença do projeto (MIT)
```

## Pré-requisitos

- **Microsoft Excel** (ou software compatível)
- Conhecimento básico de manipulação de planilhas e funções estatísticas
- R e RStudio
## Execução

1. Faça o download dos datasets:
   - [Perfil do Eleitorado 2024 - SP](https://cdn.tse.jus.br/estatistica/sead/odsele/perfil_eleitor_secao/perfil_eleitor_secao_ATUAL_SP.zip)
   - [Perfil do Eleitorado 2024 - RJ](https://cdn.tse.jus.br/estatistica/sead/odsele/perfil_eleitor_secao/perfil_eleitor_secao_ATUAL_RJ.zip)
   - [Perfil do Eleitorado 2024 - BA](https://cdn.tse.jus.br/estatistica/sead/odsele/perfil_eleitor_secao/perfil_eleitor_secao_ATUAL_BA.zip).
   - [Dados Meteorológicos INMET - 2022](https://portal.inmet.gov.br/uploads/dadoshistoricos/2022.zip).
   - [Dados Meteorológicos INMET - 2022](https://portal.inmet.gov.br/uploads/dadoshistoricos/2023.zip).
2. Carregue os arquivos CSV no Excel utilizando a função "Obter Dados".
3. Siga as etapas descritas para eliminar colunas, filtrar dados e realizar as análises.

> Observação 1: Não foi possível carregar o dataset modificado (após a remoção das linhas e colunas pertinentes ao trabalho) do eleitorado, devido ao grande tamanho do mesmo.

> Observação 2: [Link para planilha do Excel - Tratamento Dados Meteorológicos](https://docs.google.com/spreadsheets/d/12yxkIR3oSAmJSG3R_kwqa-2_15iYjkzB/edit?usp=sharing&ouid=111488868475156613940&rtpof=true&sd=true)

## Contribuição
Sinta-se à vontade para contribuir com sugestões, melhorias ou correções. Para colaborar:
- Faça um fork deste repositório.
- Crie uma nova branch (`git checkout -b feature/sua-feature`).
- Envie as mudanças (`git commit -am 'Adiciona nova feature'`).
- Envie a branch (`git push origin feature/sua-feature`).
- Abra um Pull Request.

## Licença
Este projeto está licenciado sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
