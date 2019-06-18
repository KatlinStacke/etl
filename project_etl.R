# install.packages("readxl", dependencies = T)
# install.packages("tidyverse")

library(readxl)
library(tidyr)
library(tibble)
library(tidyr)
library(magrittr)

#Importar os dados

HEADER_SIZE <- 4
SHEET_POSITION <- 35
path = "/home/katlin/Documentos/01-Utilizacao-da-Internet.xlsx"

excel <- read_xlsx(path, sheet = SHEET_POSITION, skip = HEADER_SIZE)
as.tibble("excel")

#Criando as partições

excel_1 <- as.tibble(excel[(1:42), (1:8)])
excel_3 <- as.tibble(excel[(1:42), (17:24)])


# Alterando o nome das colunas em cada partição

column_names = c("Regiões", "Total", "< 4", "4-7", "8-10", "11-14", ">15", "Nao Determ.")
names(excel_1)[1:8] <- column_names
names(excel_3)[1:8] <- column_names

# Os valores da variável Anos de Estudo estão espalhados nas colunas (Tipo 4 para Tipo 1)

a <- excel_1 %>% gather("< 4", "4-7", "8-10", "11-14", ">15", "Nao Determ.", key = "Anos de Estudo", value = "Quantidade")
b <- excel_3 %>% gather("< 4", "4-7", "8-10", "11-14", ">15", "Nao Determ.", key = "Anos de Estudo", value = "%")

# ontando o arquivo final

dados_estruturados <- as_tibble(cbind(a,b)[,c(1,3,4,8)])
dados_estruturados

getwd()
