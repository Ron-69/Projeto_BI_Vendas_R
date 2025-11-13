# 📊 Projeto de Business Intelligence (BI) e Análise de Vendas com R

## Visão Geral

Este projeto demonstra um pipeline completo de Data Analytics e Business Intelligence utilizando a linguagem **R** e o ecossistema **Tidyverse**. O objetivo é transformar dados brutos de vendas (`train.csv` / Superstore Sales) em *insights* acionáveis para gestão e tomada de decisão.

## 🎯 Objetivo de Negócio

* Realizar a **análise descritiva** das vendas.
* Identificar padrões de **sazonalidade** (Série Temporal).
* Determinar os principais **drivers de receita** por Categoria e a performance por Região.

## ⚙️ Metodologia e Tecnologias

O projeto seguiu as etapas clássicas de um fluxo de BI/Analytics:

### 1. Tecnologias Utilizadas
* **Linguagem:** R
* **Manipulação de Dados:** `dplyr` (para `group_by`, `summarise`, `mutate`), `tidyr` (para `drop_na`).
* **Datas:** `lubridate` (para conversão e agregação de datas).
* **Visualização:** `ggplot2` (para gráficos estáticos) e `scales` (para formatação de moeda).
* **IDE:** RStudio.

### 2. Etapas de Processamento

1.  **Carregamento e Limpeza:** Remoção de linhas vazias/inconsistentes (`drop_na()`) e conversão de colunas de data (de `character` para `date` usando `dmy()`).
2.  **Agregação (Data Wrangling):** Criação de DataFrames resumidos (`df_mensal`, `df_categoria`, `df_regiao`) usando `group_by()` para análise de série temporal e análises categóricas.
3.  **Visualização:** Construção de gráficos informativos usando `ggplot2`.

## 📈 Resultados e Insights Principais

Os resultados foram visualizados em três gráficos principais que formam o núcleo do nosso Dashboard de BI:

### 1. Série Temporal de Vendas

* **Gráfico:** Linha mostrando a Vendas Totais por `Mes_Ano`.
* **Insight:** Claramente visível a forte **sazonalidade** da empresa, com picos de vendas concentrados no final de cada ano (Q4 - Outubro, Novembro, Dezembro), indicando dependência de períodos promocionais.

### 2. Vendas por Categoria

* **Gráfico:** Barras Horizontais (`geom_col` + `coord_flip`) mostrando o total de `Sales` por `Category`.
* **Insight:** A categoria **Technology** (Tecnologia) e **Furniture** (Móveis) são as maiores geradoras de receita. A estratégia de vendas e estoque deve priorizar esses segmentos.

### 3. Vendas por Região

* **Gráfico:** Barras mostrando o total de `Sales` por `Region`.
* **Insight:** [**INSIRA AQUI a sua Região com as Vendas Mais Altas**]. Esta análise orienta onde os investimentos em marketing ou logística devem ser concentrados para maximizar o retorno.

## 📌 Como Reproduzir

1.  Clone este repositório: `git clone [SEU LINK DO REPO]`
2.  Abra o arquivo `Projeto_BI_Vendas_R.Rproj` no **RStudio**.
3.  Instale os pacotes necessários no console: `install.packages(c("tidyverse", "lubridate", "scales"))`
4.  Execute o script `analise_vendas.R` em blocos para replicar a análise e gerar os gráficos.