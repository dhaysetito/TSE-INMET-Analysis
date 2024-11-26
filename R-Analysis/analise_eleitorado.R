#install.packages("tidyverse")

#install.packages("readr")     # Para leitura de arquivos CSV
#install.packages("dplyr")     # Para manipulação de dados

library(tidyverse)

# Configura o diretório de trabalho para o local do arquivo .R
setwd("C:/Users/giovanni.ornellas/Desktop/UFRJ")

#caminho_dataset_final_BARJ <- "perfil_eleitor_secao_ATUAL_RJ.csv"
caminho_datasetBA <- "perfil_eleitor_secao_ATUAL_BA.csv"

dataset_BA <- read_delim(
  file = caminho_datasetBA,   # Caminho do arquivo
  delim = ";",                # Configuração do separador de campo, ex.: ";" ou ","
  quote = "\"",               # Configuração do delimitador de campo
  locale = locale(encoding = "ISO-8859-1") # Configuração da codificação de caracteres
)

print(head(dataset_BA))

# Analise BA

tamanho_antes <- object.size(dataset_BA)

# Número de linhas e colunas antes da projeção
linhas_antes <- nrow(dataset_BA)
colunas_antes <- ncol(dataset_BA)
celulas_antes <- linhas_antes * colunas_antes

# Selecionar as colunas de interesse
colunas_interesse <- c(
  "NM_MUNICIPIO", "CD_GENERO", "DS_GENERO", 
  "CD_ESTADO_CIVIL", "DS_ESTADO_CIVIL", 
  "CD_FAIXA_ETARIA", "DS_FAIXA_ETARIA", 
  "CD_GRAU_ESCOLARIDADE", "DS_GRAU_ESCOLARIDADE", 
  "QT_ELEITORES_PERFIL"
)

# Aplicar a função select() para filtrar as colunas
dataset_reduzido_BA <- dataset_BA %>%
  select(all_of(colunas_interesse))

# Número de linhas e colunas depois da projeção
linhas_depois <- nrow(dataset_reduzido_BA)
colunas_depois <- ncol(dataset_reduzido_BA)
celulas_depois <- linhas_depois * colunas_depois

# Filtrar linhas válidas
dataset_final_BA <- dataset_reduzido_BA %>%
  filter(
    DS_FAIXA_ETARIA != "Inválido", # Elimina linhas com "Inválido" em DS_FAIXA_ETARIA
    !if_any(everything(), ~ . == "NÃO INFORMADO") # Elimina linhas com "NÃO INFORMADO" em qualquer coluna
  )

# Número de linhas e colunas depois da projeção
linhas_finais <- nrow(dataset_final_BA)
colunas_finais <- ncol(dataset_final_BA)
celulas_finais <- linhas_finais * colunas_finais

# ANALISES

# Valores unicos de cada coluna
valores_unicos <- lapply(dataset_final_BA, unique)
valores_unicos

# Total geral de eleitores
total_geral <- sum(dataset_final_BA$QT_ELEITORES_PERFIL, na.rm = TRUE)

# Critério 1: Homens, 35 a 39 anos, casados, com nível médio completo
criterio1 <- dataset_final_BA %>%
  filter(
    DS_GENERO == "MASCULINO",
    DS_FAIXA_ETARIA == "35 a 39 anos",
    DS_ESTADO_CIVIL == "CASADO",
    DS_GRAU_ESCOLARIDADE == "ENSINO MÉDIO COMPLETO"
  )
total_criterio1 <- sum(criterio1$QT_ELEITORES_PERFIL, na.rm = TRUE)
compare_criterio1 <- total_criterio1/total_geral * 100

# Critério 2: Mulheres, 45 a 49 anos, solteiras, com ensino superior completo
criterio2 <- dataset_final_BA %>%
  filter(
    DS_GENERO == "FEMININO",
    DS_FAIXA_ETARIA == "45 a 49 anos",
    DS_ESTADO_CIVIL == "SOLTEIRO",
    DS_GRAU_ESCOLARIDADE == "SUPERIOR COMPLETO"
  )
total_criterio2 <- sum(criterio2$QT_ELEITORES_PERFIL, na.rm = TRUE)
compare_criterio2 <- total_criterio2/total_geral * 100

# Critério 3: Homens, 25 a 29 anos, divorciados, com ensino médio incompleto
criterio3 <- dataset_final_BA %>%
  filter(
    DS_GENERO == "MASCULINO",
    DS_FAIXA_ETARIA == "25 a 29 anos",
    DS_ESTADO_CIVIL == "DIVORCIADO",
    DS_GRAU_ESCOLARIDADE == "ENSINO FUNDAMENTAL INCOMPLETO"
  )
total_criterio3 <- sum(criterio3$QT_ELEITORES_PERFIL, na.rm = TRUE)
compare_criterio3 <- total_criterio3/total_geral * 100

# Critério 4: Ambos os gêneros, 60 a 64 anos, viúvos, lê e escreve
criterio4 <- dataset_final_BA %>%
  filter(
    DS_FAIXA_ETARIA == "60 a 64 anos",
    DS_ESTADO_CIVIL == "VIÚVO",
    DS_GRAU_ESCOLARIDADE == "LÊ E ESCREVE"
  )
total_criterio4 <- sum(criterio4$QT_ELEITORES_PERFIL, na.rm = TRUE)
compare_criterio4 <- total_criterio4/total_geral * 100

# Critério 5: Ambos os gêneros, 21 a 24 anos, analfabeto
criterio5 <- dataset_final_BA %>%
  filter(
    DS_FAIXA_ETARIA == "21 a 24 anos",
    DS_GRAU_ESCOLARIDADE == "ANALFABETO"
  )
total_criterio5 <- sum(criterio5$QT_ELEITORES_PERFIL, na.rm = TRUE)
compare_criterio5 <- total_criterio5/total_geral * 100

# Exibir resultados
cat("Total geral de eleitores:", total_geral, "\n")
cat("Critério 1 (Homens, 35-39, casados, ensino médio completo):", total_criterio1, "\n")
cat("Critério 2 (Mulheres, 45-49, solteiras, ensino superior completo):", total_criterio2, "\n")
cat("Critério 3 (Homens, 25-29, divorciados, ensino médio incompleto):", total_criterio3, "\n")
cat("Critério 4 (Ambos os gêneros, 60-64, viúvos, lê e escreve):", total_criterio4, "\n")
cat("Critério 5 (Ambos os gêneros, 21-24, analfabeto):", total_criterio5, "\n")

################################################################

# Contagem de eleitores por sexo
contagem_por_sexo <- dataset_final_BA %>%
  group_by(DS_GENERO) %>%
  summarise(Total_Eleitores = sum(QT_ELEITORES_PERFIL, na.rm = TRUE))

# Contagem de eleitores por município
contagem_por_municipio <- dataset_final_BA %>%
  group_by(NM_MUNICIPIO) %>%
  summarise(Total_Eleitores = sum(QT_ELEITORES_PERFIL, na.rm = TRUE))

# Contagem de eleitores por faixa etária
contagem_por_idade <- dataset_final_BA %>%
  group_by(DS_FAIXA_ETARIA) %>%
  summarise(Total_Eleitores = sum(QT_ELEITORES_PERFIL, na.rm = TRUE))

# Contagem de eleitores por estado civil
contagem_por_estado_civil <- dataset_final_BA %>%
  group_by(DS_ESTADO_CIVIL) %>%
  summarise(Total_Eleitores = sum(QT_ELEITORES_PERFIL, na.rm = TRUE))

# Contagem de eleitores por grau de escolaridade
contagem_por_escolaridade <- dataset_final_BA %>%
  group_by(DS_GRAU_ESCOLARIDADE) %>%
  summarise(Total_Eleitores = sum(QT_ELEITORES_PERFIL, na.rm = TRUE))

# Exibir as tabelas
contagem_por_sexo
contagem_por_municipio
contagem_por_idade
contagem_por_estado_civil
contagem_por_escolaridade

# Contagem de eleitores por sexo e idade
contagem_sexo_idade <- dataset_final_BA %>%
  group_by(DS_GENERO, DS_FAIXA_ETARIA) %>%
  summarise(Total_Eleitores = sum(QT_ELEITORES_PERFIL, na.rm = TRUE))

# Contagem de eleitores por sexo e município
contagem_sexo_municipio <- dataset_final_BA %>%
  group_by(DS_GENERO, NM_MUNICIPIO) %>%
  summarise(Total_Eleitores = sum(QT_ELEITORES_PERFIL, na.rm = TRUE))

# Contagem de eleitores por grau de escolaridade e estado civil
contagem_escolaridade_estado <- dataset_final_BA %>%
  group_by(DS_GRAU_ESCOLARIDADE, DS_ESTADO_CIVIL) %>%
  summarise(Total_Eleitores = sum(QT_ELEITORES_PERFIL, na.rm = TRUE))

# Exibir as tabelas
contagem_sexo_idade
contagem_sexo_municipio
contagem_escolaridade_estado

## Estatiticas por agrupamento

# Função para calcular estatísticas básicas
calcular_estatisticas <- function(data, coluna) {
  
  estatisticas <- data %>%
    summarise(
      Media = mean(.data[[coluna]], na.rm = TRUE),
      Mediana = median(.data[[coluna]], na.rm = TRUE),
      Moda = as.numeric(names(sort(table(.data[[coluna]]), decreasing = TRUE)[1])),
      Desvio_Padrao = sd(.data[[coluna]], na.rm = TRUE),
      Variancia = var(.data[[coluna]], na.rm = TRUE),
      Minimo = min(.data[[coluna]], na.rm = TRUE),
      Maximo = max(.data[[coluna]], na.rm = TRUE),
      Intervalo = Maximo - Minimo
    )
  
  return(estatisticas)
}

estatisticas_sexo_idade <- calcular_estatisticas(contagem_sexo_idade, "Total_Eleitores")
estatisticas_sexo_municipio <- calcular_estatisticas(contagem_sexo_municipio, "Total_Eleitores")
estatisticas_escolaridade_estado <- calcular_estatisticas(contagem_escolaridade_estado, "Total_Eleitores")

estatisticas_sexo_municipio
estatisticas_sexo_idade
estatisticas_escolaridade_estado
