#==============================================================================
# Tabela para tomada de decisão na compra de livros da USP
# Ícaro Vidal Freire
# 2022-03-04
#==============================================================================

# preparando a url --------------------------------------------------------
url_usp <- "https://www.edusp.com.br/loja/assuntos/21/matematica"

# preparando o site -------------------------------------------------------
site_usp <- url_usp |>
  httr::GET(httr::config(ssl_verifypeer = FALSE)) |>
  rvest::read_html()

# raspando todos os títulos -----------------------------------------------
titulos_usp <- site_usp |>
  rvest::html_elements("#dvProdutos p") |>
  rvest::html_text2() |>
  stringr::str_trim()

# construindo uma lista de desejos ----------------------------------------
lista_desejos <- c(
  "Números: Uma Introdução à Matemática",
  "Poeta, um Matemático e um Físico, Um:...",
  "Programação Matemática para Otimização..."
)

# raspando o preço antigo -------------------------------------------------
preco_antigo_usp <- site_usp |>
  rvest::html_elements("strike") |>
  rvest::html_text2() |>
  stringr::str_sub(4) |>
  stringr::str_replace_all(",", ".") |>
  readr::parse_double()

# raspando o novo preço ---------------------------------------------------
preco_novo_usp <- site_usp |>
  rvest::html_elements("h2+ h2") |>
  rvest::html_text2() |>
  stringr::str_trim() |>
  stringr::str_sub(8) |>
  stringr::str_replace_all(",", ".") |>
  readr::parse_double()

# criando tabela de decisão -----------------------------------------------
tabela_usp <-
  tibble::tibble(
    titulo       = titulos_usp,
    preco_antigo = preco_antigo_usp,
    preco_novo   = preco_novo_usp,
    decisao      = dplyr::if_else(preco_novo <= (1 - 0.2) * preco_antigo, "compre!!!", "agarde")
  ) |>
  dplyr::filter(titulo %in% lista_desejos)
# exibindo a tabela --------------------------------------------------------
  tabela_usp
#==============================================================================
