#==============================================================================
# Raspando uma tabela da Wikipédia
# Ícaro Vidal Freire
# 2022-03-04
#==============================================================================

# carregando pacote -------------------------------------------------------
library(magrittr)

# preparando url ----------------------------------------------------------
url_wiki <- "https://pt.wikipedia.org/wiki/R_(linguagem_de_programa%C3%A7%C3%A3o)"

# preparando site ---------------------------------------------------------
site_wiki <- rvest::read_html(url_wiki)

# raspando a tabela -------------------------------------------------------
tabela_wiki <- site_wiki |>
  rvest::html_elements(".wikitable") |>
  rvest::html_table()

# exibindo a tabela -------------------------------------------------------

tabela_wiki

#==============================================================================
