#Setup e Carregamento de Dados

#Carrega a coleção de pacotes Tidyverse, que inclui o dplyr (manipulação de dados), 
# ggplot2 (visualização) e readr (leitura de dados).
library(tidyverse)

# Carrega o lubridate, que faz parte do tidyverse, especializado em 
# manipulação de datas (crucial para séries temporais).
library(lubridate)

# Carrega seu arquivo de vendas (CSV) em um objeto (variável) chamado df_vendas.
df_vendas <- read_csv("train.csv")

# Célula 2: Remoção de linhas com NA (incluindo a linha 9802 vazia)
# drop_na() sem argumentos remove qualquer linha que tenha NA em QUALQUER coluna.
# Isso garante que a linha 9802 e quaisquer outras linhas com dados faltantes sejam removidas.
df_vendas <- df_vendas %>% drop_na()

cat("\nDataFrame após a remoção de NAs/Linhas vazias:\n")
print(dim(df_vendas))

# Exibe a estrutura dos dados (nomes das colunas e seus tipos), 
# similar ao df.info() do Pandas.
str(df_vendas)

# Fornece um resumo estatístico das colunas (média, mediana, quartis, etc.).
summary(df_vendas)

# Limpeza e Preparação de Datas (Mutate)

# mutate() é uma função do dplyr que cria ou modifica colunas. Aqui, ela converte a coluna 
# de data (Order Date) de texto para o tipo Date usando a função mdy() (Month-Day-Year), 
# o formato comum em bases de dados de vendas.
df_vendas <- df_vendas %>% mutate(`Order Date` = dmy(`Order Date`), 
                                  `Ship Date` = dmy(`Ship Date`))

# Exibe as primeiras linhas do DataFrame para verificar se a data foi convertida 
# corretamente.
head(df_vendas)

colnames(df_vendas)

# Agregação Mensal (Group_by e Summarise)

# Cria um novo objeto (df_mensal) para armazenar os dados agregados. O operador %>% (pipe)
# encadeia funções de forma legível.
df_mensal <- df_vendas %>%
  # Cria uma nova coluna, Mes_Ano, que contém apenas o primeiro dia de cada mês (ex: 2024-01-01,
  # 2024-02-01), simplificando a agregação.
  mutate(Mes_Ano = floor_date(`Order Date`, "month")) %>%
  
  # Calcula as métricas desejadas para cada grupo de Mes_Ano.
  group_by(Mes_Ano) %>% 
  
  summarise(
    Vendas_Totais = sum(Sales) # Lucro_Medio foi removido para evitar o erro
  ) %>%
  
  # Remove o agrupamento para permitir futuras manipulações.
  ungroup()

# Exibe o novo DataFrame agregado, que agora tem uma linha por mês, contendo Vendas_Totais 
# e Lucro_Medio.
cat("\nDados Agregados Mensalmente (Série Temporal):\n")
print(head(df_mensal))

# Visualização da Série Temporal de Vendas

library(scales)

plot_vendas_mensal <- df_mensal %>% ggplot(aes(x = Mes_Ano, y = Vendas_Totais)) +
  
  geom_line(color = "steelblue", linewidth = 1) + geom_point(color = "darkblue", size = 2) +
  
  labs( title = "Série Temporal de Vendas Totais (2015-2018)", x = "Mês", y = "Vendas Totais" ) +
  
  scale_y_continuous(labels = scales::dollar_format(prefix = "R$", big.mark = ".", decimal.mark = ",")) +
  
  theme_minimal() + theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(plot_vendas_mensal)


# Agregação e Visualização por Categoria
df_categoria <- df_vendas %>%
  group_by(Category) %>%
  summarise(
    Vendas_Totais = sum(Sales)
  ) %>%
  # Ordena pela categoria com mais vendas para o gráfico
  arrange(desc(Vendas_Totais))

# Plotagem do gráfico de barras
plot_vendas_categoria <- df_categoria %>%
  # Mapeia a Categoria para Y e Vendas para X, com a ordem já definida
  ggplot(aes(x = reorder(Category, Vendas_Totais), y = Vendas_Totais)) +
  
  geom_col(fill = "darkgreen") +
  
  # Coordenadas invertidas para melhor leitura dos nomes das categorias
  coord_flip() +
  
  labs(
    title = "Vendas Totais por Categoria de Produto",
    x = "Categoria",
    y = "Vendas Totais"
  ) +
  
  scale_y_continuous(labels = scales::dollar_format(prefix = "R$", big.mark = ".", decimal.mark = ",")) +
  theme_minimal()

# Exibe o gráfico
print(plot_vendas_categoria)


# Agregação e Visualização por Região

df_regiao <- df_vendas %>% group_by(Region) %>% summarise( Vendas_Totais = sum(Sales) ) %>%
  
arrange(desc(Vendas_Totais))

plot_vendas_regiao <- df_regiao %>% ggplot(aes(x = reorder(Region, Vendas_Totais), y = Vendas_Totais, fill = Region)) +
  
geom_col() +
  
coord_flip() +
  
labs( title = "Vendas Totais por Região de Atuação", x = "Região", y = "Vendas Totais" ) +
  
scale_y_continuous(labels = scales::dollar_format(prefix = "R$", big.mark = ".", decimal.mark = ",")) +
  
theme_minimal() +
  
theme(legend.position = "none")

print(plot_vendas_regiao)