#==============================================================================
# Raspando tabelas
# Ícaro Vidal Freire
# minicurso Web Scraping
#==============================================================================

# Site com 1 (uma tabela) -------------------------------------------------

site_uma_tabela <- "https://rmd4sci.njtierney.com/keyboard-shortcuts"

tabela_atalhhos <- site_uma_tabela |> 
  rvest::read_html() |> 
  rvest::html_table()

tabela_atalhhos |> tibble::view()

# Site com mais de uma tabela ---------------------------------------------

site_tabelas <- "https://pt.wikipedia.org/wiki/R_(linguagem_de_programa%C3%A7%C3%A3o)"

## Escolhendo a tabela 5
tabela_descricao <- site_tabelas |> 
  rvest::read_html() |> 
  rvest::html_table() %>%
  .[5]

tabela_descricao |> tibble::view()
