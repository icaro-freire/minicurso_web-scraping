#==============================================================================
# Raspando uma Tabela, dentre várias
# Ícaro Vidal Freire
# data de acesso: 2021-11-26
#==============================================================================

# pacotes usados ----------------------------------------------------------
library(magrittr)

# url do site -------------------------------------------------------------
url_tabelas <- "https://pt.wikipedia.org/wiki/R_(linguagem_de_programa%C3%A7%C3%A3o)"

# preparação do site ------------------------------------------------------
site_tabelas <- rvest::read_html(url_tabelas)

# raspando os dados -------------------------------------------------------

## modo longo
tabelas <- site_tabelas |> 
  rvest::html_elements("table") |> 
  rvest::html_table() %>%
  .[[5]]

tabelas |> tibble::view()

## modo curto
tabela <- site_tabelas |> 
  rvest::html_elements(".wikitable") |> 
  rvest::html_table()

tabela |> tibble::view()

#==============================================================================
