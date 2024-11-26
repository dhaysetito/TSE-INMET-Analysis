# --------------------
# 1. Carregar os dados
# --------------------

library(lubridate)
library(xtable)

# Instalar e carregar pacotes necessários
# install.packages("tidyverse")  # Executar apenas se ainda não tiver o pacote
library(tidyverse)
old <- options(pillar.sigfig = 4)

# Definir o caminho dos arquivos
file_2022 <- "D:/Downloads/Dataset/2022/INMET_S_PR_A807_CURITIBA_01-01-2022_A_31-12-2022.CSV"
file_2023 <- "D:/Downloads/Dataset/2023/INMET_S_PR_A807_CURITIBA_01-01-2023_A_31-12-2023.CSV"

# Carregar os datasets
data_2022 <- read_delim(file_2022,
                        delim = ";",
                        skip = 8, # pular cabeçalho de 8 linhas
                        locale = locale(encoding = "ISO-8859-1", decimal_mark = ","))

print(head(data_2022))

data_2023 <- read_delim(file_2023,
                        delim = ";",
                        skip = 8, # pular cabeçalho de 8 linhas
                        locale = locale(encoding = "ISO-8859-1", decimal_mark = ","))

# Verificar dimensões dos datasets
dim_2022 <- dim(data_2022)  # Número de linhas e colunas
dim_2023 <- dim(data_2023)

# Número total de células
num_celulas_2022 <- dim_2022[1] * dim_2022[2]
num_celulas_2023 <- dim_2023[1] * dim_2023[2]

print(dim_2022)
print(dim_2023)
print(num_celulas_2022)
print(num_celulas_2023)

# ---------------------
# 2. Seleção de colunas
# ---------------------

# Seleção de colunas de interesse
colunas_inmet <- c(
  "Data",
  "Hora UTC",
  "PRECIPITAÇÃO TOTAL, HORÁRIO (mm)",
  "PRESSAO ATMOSFERICA AO NIVEL DA ESTACAO, HORARIA (mB)",
  "PRESSÃO ATMOSFERICA MAX.NA HORA ANT. (AUT) (mB)",
  "PRESSÃO ATMOSFERICA MIN. NA HORA ANT. (AUT) (mB)",
  "TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)",
  "TEMPERATURA MÁXIMA NA HORA ANT. (AUT) (°C)",
  "TEMPERATURA MÍNIMA NA HORA ANT. (AUT) (°C)",
  "VENTO, DIREÇÃO HORARIA (gr) (° (gr))",
  "VENTO, RAJADA MAXIMA (m/s)",
  "VENTO, VELOCIDADE HORARIA (m/s)"
)

data_2022_selected <- data_2022 %>% select(any_of(colunas_inmet))
data_2023_selected <- data_2023 %>% select(any_of(colunas_inmet))

print(head(data_2022_selected))

# Verificar dimensões após seleção
dim_selected_2022 <- dim(data_2022_selected)
dim_selected_2023 <- dim(data_2023_selected)

print(dim_selected_2022)
print(dim_selected_2023)

# ----------------------
# 3. Filtragem de linhas
# ----------------------

# Remover linhas com valores nulos
data_2022_clean <- data_2022_selected %>% drop_na()
data_2023_clean <- data_2023_selected %>% drop_na()

# Verificar dimensões após limpeza
dim_clean_2022 <- dim(data_2022_clean)
dim_clean_2023 <- dim(data_2023_clean)

print(dim_clean_2022)
print(dim_clean_2023)

print(head(data_2022_clean))

# x[!x %in% boxplot.stats(x)$out]

# boxplot()
# 
# box22_3 <- boxplot(data_2022_clean[3], aes(y = colnames(data_2022_clean)[3], group = year, color = factor(year))) +
#   labs(
#     title = "Média de PRECIPITAÇÃO TOTAL, HORÁRIO (mm)",
#     x = "Mês",
#     y = "Média de Precipitação (mm)",
#     color = "Ano"
#   ) +
#   theme_minimal() +
#   scale_color_manual(values = c("2022" = "blue", "2023" = "orange"))

# --------------------------------------------------------------
# Boxplot PRESSAO - 2022
# --------------------------------------------------------------

# Seleção das variáveis de interesse
data_boxplot <- data_2022_clean %>%
  select(
    `PRESSAO ATMOSFERICA AO NIVEL DA ESTACAO, HORARIA (mB)`,
    `PRESSÃO ATMOSFERICA MAX.NA HORA ANT. (AUT) (mB)`,
    `PRESSÃO ATMOSFERICA MIN. NA HORA ANT. (AUT) (mB)`
  )

# Transformar os dados para o formato long (necessário para ggplot)
data_long <- data_boxplot %>%
  pivot_longer(
    cols = everything(),
    names_to = "Variável",
    values_to = "Valor"
  )

# Criar o gráfico de boxplot
ggplot(data_long, aes(x = Variável, y = Valor, fill = Variável)) +
  geom_boxplot(outlier.color = "black", outlier.size = 1.5) +
  scale_fill_manual(values = c("blue", "orange", "gray")) +
  labs(
    title = "Pressão Atmosférica (mB) - 2022",
    subtitle = "(a) Pressão Atmosférica (mB) - 2022",
    x = NULL,
    y = "Pressão (mB)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_blank(),
    axis.text.x = element_blank()
  )

# --------------------------------------------------------------
# Boxplot PRESSAO - 2023
# --------------------------------------------------------------

# Seleção das variáveis de interesse
data_boxplot <- data_2023_clean %>%
  select(
    `PRESSAO ATMOSFERICA AO NIVEL DA ESTACAO, HORARIA (mB)`,
    `PRESSÃO ATMOSFERICA MAX.NA HORA ANT. (AUT) (mB)`,
    `PRESSÃO ATMOSFERICA MIN. NA HORA ANT. (AUT) (mB)`
  )

# Transformar os dados para o formato long (necessário para ggplot)
data_long <- data_boxplot %>%
  pivot_longer(
    cols = everything(),
    names_to = "Variável",
    values_to = "Valor"
  )

# Criar o gráfico de boxplot
ggplot(data_long, aes(x = Variável, y = Valor, fill = Variável)) +
  geom_boxplot(outlier.color = "black", outlier.size = 1.5) +
  scale_fill_manual(values = c("blue", "orange", "gray")) +
  labs(
    title = "Pressão Atmosférica (mB) - 2023",
    subtitle = "(a) Pressão Atmosférica (mB) - 2023",
    x = NULL,
    y = "Pressão (mB)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_blank(),
    axis.text.x = element_blank()
  )

# --------------------------------------------------------------
# Boxplot TEMPERATURA - 2022
# --------------------------------------------------------------

# Seleção das variáveis de interesse
data_boxplot <- data_2022_clean %>%
  select(
    `TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`,
    `TEMPERATURA MÁXIMA NA HORA ANT. (AUT) (°C)`,
    `TEMPERATURA MÍNIMA NA HORA ANT. (AUT) (°C)`
  )

# Transformar os dados para o formato long (necessário para ggplot)
data_long <- data_boxplot %>%
  pivot_longer(
    cols = everything(),
    names_to = "Variável",
    values_to = "Valor"
  )

# Criar o gráfico de boxplot
ggplot(data_long, aes(x = Variável, y = Valor, fill = Variável)) +
  geom_boxplot(outlier.color = "black", outlier.size = 1.5) +
  scale_fill_manual(values = c("blue", "orange", "gray")) +
  labs(
    title = "Temperatura do Ar (°C) - 2022",
    subtitle = "(a) Temperatura do Ar (°C) - 2022",
    x = NULL,
    y = "Temperatura (°C)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_blank(),
    axis.text.x = element_blank()
    
  )

# --------------------------------------------------------------
# Boxplot TEMPERATURA - 2023
# --------------------------------------------------------------

# Seleção das variáveis de interesse
data_boxplot <- data_2023_clean %>%
  select(
    `TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`,
    `TEMPERATURA MÁXIMA NA HORA ANT. (AUT) (°C)`,
    `TEMPERATURA MÍNIMA NA HORA ANT. (AUT) (°C)`
  )

# Transformar os dados para o formato long (necessário para ggplot)
data_long <- data_boxplot %>%
  pivot_longer(
    cols = everything(),
    names_to = "Variável",
    values_to = "Valor"
  )

# Criar o gráfico de boxplot
ggplot(data_long, aes(x = Variável, y = Valor, fill = Variável)) +
  geom_boxplot(outlier.color = "black", outlier.size = 1.5) +
  scale_fill_manual(values = c("blue", "orange", "gray")) +
  labs(
    title = "Temperatura do Ar (°C) - 2023",
    subtitle = "(a) Temperatura do Ar (°C) - 2023",
    x = NULL,
    y = "Temperatura (°C)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_blank(),
    axis.text.x = element_blank()
    
  )

# --------------------------------------------------------------
# Boxplot VENTO - 2022
# --------------------------------------------------------------

# Seleção das variáveis de interesse
data_boxplot <- data_2022_clean %>%
  select(
    `VENTO, RAJADA MAXIMA (m/s)`,
    `VENTO, VELOCIDADE HORARIA (m/s)`
  )

# Transformar os dados para o formato long (necessário para ggplot)
data_long <- data_boxplot %>%
  pivot_longer(
    cols = everything(),
    names_to = "Variável",
    values_to = "Valor"
  )

# Criar o gráfico de boxplot
ggplot(data_long, aes(x = Variável, y = Valor, fill = Variável)) +
  geom_boxplot(outlier.color = "black", outlier.size = 1.5) +
  scale_fill_manual(values = c("blue", "orange", "gray")) +
  labs(
    title = "Vento (m/s) - 2022",
    subtitle = "(a) Vento (m/s) - 2022",
    x = NULL,
    y = "Vento (m/s)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_blank(),
    axis.text.x = element_blank()
    
  )

# --------------------------------------------------------------
# Boxplot VENTO - 2023
# --------------------------------------------------------------

# Seleção das variáveis de interesse
data_boxplot <- data_2023_clean %>%
  select(
    `VENTO, RAJADA MAXIMA (m/s)`,
    `VENTO, VELOCIDADE HORARIA (m/s)`
  )

# Transformar os dados para o formato long (necessário para ggplot)
data_long <- data_boxplot %>%
  pivot_longer(
    cols = everything(),
    names_to = "Variável",
    values_to = "Valor"
  )

# Criar o gráfico de boxplot
ggplot(data_long, aes(x = Variável, y = Valor, fill = Variável)) +
  geom_boxplot(outlier.color = "black", outlier.size = 1.5) +
  scale_fill_manual(values = c("blue", "orange", "gray")) +
  labs(
    title = "Vento (m/s) - 2023",
    subtitle = "(a) Vento (m/s) - 2023",
    x = NULL,
    y = "Vento (m/s)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_blank(),
    axis.text.x = element_blank()
    
  )

# --------------------------------------------------------------
# Boxplot VENTO graus - 2022
# --------------------------------------------------------------

# Seleção das variáveis de interesse
data_boxplot <- data_2022_clean %>%
  select(
    `VENTO, DIREÇÃO HORARIA (gr) (° (gr))`
  )

# Transformar os dados para o formato long (necessário para ggplot)
data_long <- data_boxplot %>%
  pivot_longer(
    cols = everything(),
    names_to = "Variável",
    values_to = "Valor"
  )

# Criar o gráfico de boxplot
ggplot(data_long, aes(x = Variável, y = Valor, fill = Variável)) +
  geom_boxplot(outlier.color = "black", outlier.size = 1.5) +
  scale_fill_manual(values = c("blue", "orange", "gray")) +
  labs(
    title = "Vento (° (gr)) - 2022",
    subtitle = "(a) Vento (m/s) - 2022",
    x = NULL,
    y = "Vento (° (gr))"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_blank(),
    axis.text.x = element_blank()
    
  )

# --------------------------------------------------------------
# Boxplot VENTO graus - 2023
# --------------------------------------------------------------

# Seleção das variáveis de interesse
data_boxplot <- data_2023_clean %>%
  select(
    `VENTO, DIREÇÃO HORARIA (gr) (° (gr))`
  )

# Transformar os dados para o formato long (necessário para ggplot)
data_long <- data_boxplot %>%
  pivot_longer(
    cols = everything(),
    names_to = "Variável",
    values_to = "Valor"
  )

# Criar o gráfico de boxplot
ggplot(data_long, aes(x = Variável, y = Valor, fill = Variável)) +
  geom_boxplot(outlier.color = "black", outlier.size = 1.5) +
  scale_fill_manual(values = c("blue", "orange", "gray")) +
  labs(
    title = "Vento (° (gr)) - 2023",
    subtitle = "(a) Vento (m/s) - 2023",
    x = NULL,
    y = "Vento (° (gr))"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_blank(),
    axis.text.x = element_blank()
    
  )

# ----------
# 4. Análise
# ----------

# Função para calcular a moda
calc_mode <- function(x) {
  uniq_x <- unique(x)
  uniq_x[which.max(tabulate(match(x, uniq_x)))]
}

summary_stats <- function(x) {
  x = c(mean(x),
        calc_mode(x),
        median(x),
        var(x),
        sd(x),
        diff(range(x)),
        IQR(x),
        max(x),
        min(x))
  names(x) = c("Média", "Moda", "Mediana", "Variância", "Desvio Padrão", "Amplitude", "IQR", "Máximo", "Mínimo")
  x
}

summary_mmm <- function(x) {
  x = c(max(x),
        min(x),
        mean(x))
  names(x) = c("Máximo", "Mínimo","Média")
  x
}

stats_22 <- data_2022_clean %>% 
  select_if(is.numeric) %>%
  apply(2, summary_stats) %>%
  round(digits=1) %>% 
  t

#view(stats_22)
print(xtable(stats_22, type = "latex"), file = "stats22.tex")

stats_23 <- data_2023_clean %>% 
  select_if(is.numeric) %>%
  apply(2, summary_stats) %>%
  round(digits=1) %>% 
  t

view(stats_23)
print(xtable(stats_23, type = "latex"), file = "stats23.tex")

# 4.1. Seleção de linhas e cálculo de estatísticas

# Adicionar colunas de ano e mês
data_2022_clean <- data_2022_clean %>%
  mutate(
    year = year(`Data`),
    month = month(`Data`, label = TRUE, abbr = TRUE) # Nome dos meses abreviados
  )

data_2023_clean <- data_2023_clean %>%
  mutate(
    year = year(`Data`),
    month = month(`Data`, label = TRUE, abbr = TRUE) # Nome dos meses abreviados
  )

# Adicionando uma coluna para o trimestre
data_2022_clean <- data_2022_clean %>%
  mutate(Trimestre = paste0("Trimestre", quarter(Data)))

data_2023_clean <- data_2023_clean %>%
  mutate(Trimestre = paste0("Trimestre", quarter(Data)))

# Calculando os máximos, mínimos e médias por trimestre
resumo_2022_trimestral <- data_2022_clean %>%
  group_by(Trimestre) %>%
  summarise(
    Máximo = max(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE),
    Mínimo = min(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE),
    Média = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE)
  )

resumo_2022_total <- data_2022_clean %>% 
  select(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`)%>%
  summarise(
    Máximo = max(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE),
    Mínimo = min(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE),
    Média = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE)
  ) %>% 
  mutate(Trimestre = "Total")

resumo_2022_trim_temp <- bind_rows(resumo_2022_trimestral,resumo_2022_total)

view(resumo_2022_trim_temp)
print(xtable(resumo_2022_trim_temp, type = "latex"), file = "trim22.tex")

resumo_2023_trimestral <- data_2023_clean %>%
  group_by(Trimestre) %>%
  summarise(
    Máximo = max(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE),
    Mínimo = min(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE),
    Média = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE)
  )

resumo_2023_total <- data_2023_clean %>% 
  select(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`)%>%
  summarise(
    Máximo = max(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE),
    Mínimo = min(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE),
    Média = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE)
  ) %>% 
  mutate(Trimestre = "Total")

resumo_2023_trim_temp <- bind_rows(resumo_2023_trimestral,resumo_2023_total)

view(resumo_2023_trim_temp)
print(xtable(resumo_2023_trim_temp, type = "latex"), file = "trim23.tex")

# Combinar os dois datasets
combined_data <- bind_rows(data_2022_clean, data_2023_clean)

# ---------------------------------------
# Calcular a média mensal de PRECIPITAÇÃO
# ---------------------------------------
monthly_precipitation <- combined_data %>%
  group_by(year, month) %>%
  summarise(
    mean_precipitation = mean(`PRECIPITAÇÃO TOTAL, HORÁRIO (mm)`, na.rm = TRUE)
  )

# Criar o gráfico com ggplot2
dev.new()

precip_mensal <- ggplot(monthly_precipitation, aes(x = month, y = mean_precipitation, group = year, color = factor(year))) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Média de PRECIPITAÇÃO TOTAL, HORÁRIO (mm)",
    x = "Mês",
    y = "Média de Precipitação (mm)",
    color = "Ano"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("2022" = "blue", "2023" = "orange"))

precip_mensal %>% print

# ---------------------------------------
# Calcular a média horária de PRECIPITAÇÃO
# ---------------------------------------
hourly_precipitation <- combined_data %>%
  group_by(year, `Hora UTC`) %>%
  summarise(
    mean_precipitation = mean(`PRECIPITAÇÃO TOTAL, HORÁRIO (mm)`, na.rm = TRUE)
  )

# Criar o gráfico com ggplot2
dev.new()

precip_hora <- ggplot(hourly_precipitation, aes(x = `Hora UTC`, y = mean_precipitation, group = year, color = factor(year))) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Média de PRECIPITAÇÃO TOTAL, HORÁRIO (mm)",
    x = "Hora",
    y = "Média de Precipitação (mm)",
    color = "Ano"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("2022" = "blue", "2023" = "orange"))+
  theme(axis.text.x = element_text(angle = 90))

precip_hora %>% print

# ----------------------------------
# Calcular a média mensal de PRESSÃO
# ----------------------------------
monthly_pressure <- combined_data %>%
  group_by(year, month) %>%
  summarise(
    mean_pressure = mean(`PRESSAO ATMOSFERICA AO NIVEL DA ESTACAO, HORARIA (mB)`, na.rm = TRUE)
  )

# Criar o gráfico da média mensal
dev.new()

pressao_mensal <- ggplot(monthly_pressure, aes(x = month, y = mean_pressure, group = year, color = factor(year))) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Média de PRESSÃO ATMOSFÉRICA AO NÍVEL DA ESTAÇÃO, HORÁRIA (mB)",
    x = "Mês",
    y = "Média de Pressão (mB)",
    color = "Ano"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("2022" = "blue", "2023" = "orange"))

pressao_mensal %>% print

# -----------------------------------
# Calcular a média horária de PRESSÃO
# -----------------------------------
hourly_pressure <- combined_data %>%
  group_by(year, `Hora UTC`) %>%
  summarise(
    mean_pressure = mean(`PRESSAO ATMOSFERICA AO NIVEL DA ESTACAO, HORARIA (mB)`, na.rm = TRUE)
  )

# Criar o gráfico da média horária
dev.new()

pressao_hora <- ggplot(hourly_pressure, aes(x = `Hora UTC`, y = mean_pressure, group = year, color = factor(year))) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Média de PRESSÃO ATMOSFÉRICA AO NÍVEL DA ESTAÇÃO, HORÁRIA (mB)",
    x = "Hora",
    y = "Média de Pressão (mB)",
    color = "Ano"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("2022" = "blue", "2023" = "orange")) +
  theme(axis.text.x = element_text(angle = 90))

pressao_hora %>% print

# --------------------------------------
# Calcular a média mensal de TEMPERATURA
# --------------------------------------
monthly_temp <- combined_data %>%
  group_by(year, month) %>%
  summarise(
    mean_temp = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE)
  )

# Criar o gráfico com ggplot2
dev.new()

temp_mensal <- ggplot(monthly_temp, aes(x = month, y = mean_temp, group = year, color = factor(year))) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Média de TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)",
    x = "Mês",
    y = "Média de Precipitação (mm)",
    color = "Ano"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("2022" = "blue", "2023" = "orange"))

temp_mensal %>% print

# ---------------------------------------
# Calcular a média horária de TEMPERATURA
# ---------------------------------------
hourly_temp <- combined_data %>%
  group_by(year, `Hora UTC`) %>%
  summarise(
    mean_temp = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE)
  )

# Criar o gráfico com ggplot2
dev.new()

temp_hora <- ggplot(hourly_temp, aes(x = `Hora UTC`, y = mean_temp, group = year, color = factor(year))) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Média de TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)",
    x = "Hora",
    y = "Média de Precipitação (mm)",
    color = "Ano"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("2022" = "blue", "2023" = "orange"))+
  theme(axis.text.x = element_text(angle = 90))

temp_hora %>% print

# --------------------------------------
# Calcular a média mensal de TEMPERATURA
# --------------------------------------
monthly_vento <- combined_data %>%
  group_by(year, month) %>%
  summarise(
    mean_vento = mean(`VENTO, RAJADA MAXIMA (m/s)`, na.rm = TRUE)
  )

# Criar o gráfico com ggplot2
dev.new()

vento_mensal <- ggplot(monthly_vento, aes(x = month, y = mean_vento, group = year, color = factor(year))) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Média de VENTO, RAJADA MAXIMA (m/s)",
    x = "Mês",
    y = "Média de Precipitação (mm)",
    color = "Ano"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("2022" = "blue", "2023" = "orange"))

vento_mensal %>% print

# ---------------------------------------------------------------------
# Calcular a média, máxima e mínima de temperatura para cada hora e ano
hourly_temperature <- combined_data %>%
  group_by(year, `Hora UTC`) %>%  # Agrupar por ano e Hora UTC
  summarise(
    mean_temp = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE),
    max_temp = max(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE),
    min_temp = min(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`, na.rm = TRUE)
  )

# Transformar os dados para o formato long (para facilitar o gráfico)
hourly_temperature_long <- hourly_temperature %>%
  pivot_longer(
    cols = c(mean_temp, max_temp, min_temp),
    names_to = "Metric",
    values_to = "Temperature"
  )

# Criar o gráfico de temperaturas horárias
ggplot(hourly_temperature_long, aes(x = `Hora UTC`, y = Temperature, group = interaction(year, Metric), color = year)) +
  geom_line(aes(linetype = Metric), size = 1) +  # Diferenciar por tipo de linha (métrica)
  labs(
    title = "Temperatura Máxima, Média e Mínima ao Longo do Dia",
    x = "Hora UTC",
    y = "Temperatura (°C)",
    color = "Ano",
    linetype = "Métrica"
  ) +
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90)) #+
  #scale_color_manual(values = c("2022" = "blue", "2023" = "orange"))


# 4.2. Estatísticas básicas de variáveis quantitativas

# Estatísticas básicas para 2022
# summary_2022 <- data_2022_clean %>%
#   summarise(
#     mean_temp = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     median_temp = median(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     sd_temp = sd(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     max_temp = max(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     min_temp = min(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`)
#   )
# 
# summary_2023 <- data_2023_clean %>%
#   summarise(
#     mean_temp = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     median_temp = median(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     sd_temp = sd(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     max_temp = max(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     min_temp = min(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`)
#   )
# 
# print(summary_2022)
# print(summary_2023)

# 4.3. Agrupamento temporal e cálculo de estatísticas

# Agrupar por mês e calcular estatísticas básicas de temperatura
# monthly_stats_2022 <- data_2022_clean %>%
#   group_by(month = lubridate::month(`Data`, label = TRUE)) %>%
#   summarise(
#     mean_temp = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     max_temp = max(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     min_temp = min(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`)
#   )
# 
# monthly_stats_2023 <- data_2023_clean %>%
#   group_by(month = lubridate::month(`Data`, label = TRUE)) %>%
#   summarise(
#     mean_temp = mean(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     max_temp = max(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     min_temp = min(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`)
#   )
# 
# print(monthly_stats_2022)
# print(monthly_stats_2023)

# 4.4. Comparação entre anos

# Comparar as médias anuais de temperatura
# annual_stats <- data.frame(
#   year = c(2022, 2023),
#   mean_temp = c(
#     mean(data_2022_clean$`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`),
#     mean(data_2023_clean$`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`)
#   )
# )
# 
# print(annual_stats)

# # 4.5. Gráficos com ggplot2
# 
# library(ggplot2)
# 
# # Combinar dados de ambos os anos
# monthly_combined <- bind_rows(
#   mutate(monthly_stats_2022, year = 2022),
#   mutate(monthly_stats_2023, year = 2023)
# )
# 
# dev.new()
# 
# # Gráfico de linha
# monthly_combined %>% ggplot( aes(x = month, y = mean_temp, color = factor(year))) +
#   geom_line(size = 10) +
#   geom_point() +
#   geom_line() +
#   labs(
#     title = "Temperatura Média Mensal - 2022 vs 2023",
#     x = "Mês",
#     y = "Temperatura Média (°C)",
#     color = "Ano"
#   ) +
#   theme_minimal()

# # 4.6. Mapas de calor
# 
# # Adicionar colunas auxiliares para agrupamento
# data_2022_clean <- data_2022_clean %>%
#   mutate(
#     month = lubridate::month(`Data`, label = TRUE),
#     hour = lubridate::hour(`Data`)
#   )
# 
# dev.new()
# 
# # Criar mapa de calor
# heatmap_temp <- data_2022_clean %>%
#   group_by(month, hour) %>%
#   summarise(max_temp = max(`TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)`)) 
# 
# heatmap_temp %>% ggplot(aes(x = hour, y = month, fill = max_temp)) +
#   geom_tile() +
#   labs(
#     title = "Mapa de Calor: Temperatura Máxima (2022)",
#     x = "Hora",
#     y = "Mês",
#     fill = "Temp Máx (°C)"
#   ) +
#   theme_minimal()

#print(heatmap_temp)

# ------------------------------------------------------------------------------
# Descartar
# ------------------------------------------------------------------------------

# my_skim <- skim_with(numeric = sfl(mean,calc_mode,median,var,sd,range,IQR,max,min), append = FALSE)

# print(my_skim(data_2022_clean))



