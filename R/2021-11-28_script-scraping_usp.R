#==============================================================================
# Construindo uma tabela para tomada de decisão
# Ícaro Vidal Freire
# data de acesso: 2021-11-28
#==============================================================================

# url do site -------------------------------------------------------------
url_usp <- "https://www.edusp.com.br/loja/assuntos/21/matematica"

# preparando o site -------------------------------------------------------
site_usp <- url_usp |> 
  httr::GET(httr::config(ssl_verifypeer = FALSE)) |> 
  rvest::read_html()

# raspando os dados -------------------------------------------------------
nomes_livros <- site_usp |> 
  rvest::html_elements("#dvProdutos p") |> 
  rvest::html_text2() |> 
  stringr::str_trim()

preco_antigo <- site_usp |> 
  rvest::html_elements("strike") |> 
  rvest::html_text2() |> 
  stringr::str_sub(4) |> 
  stringr::str_replace(",", ".") |> 
  readr::parse_double()

preco_desconto <- site_usp |> 
  rvest::html_elements("h2:nth-child(2)") |> 
  rvest::html_text2() |> 
  stringr::str_trim() |> 
  stringr::str_sub(8) |> 
  stringr::str_replace(",", ".") |> 
  readr::parse_double()  

# criando tabela geral ----------------------------------------------------
## tabela geral
tabela_lista <- tibble::tibble(
  nome = nomes_livros,
  preco_antigo = preco_antigo,
  preco_desconto = preco_desconto
)

## lista de desejos
lista_de_desejos <- c(
  "Poeta, um Matemático e um Físico, Um:...",
  "Programação Matemática para Otimização...",
  "Números: Uma Introdução à Matemática"
)

## tabela de decisão
tabela_lista |> 
  dplyr::filter(nome %in% lista_de_desejos) |> 
  dplyr::mutate(
    decisao = dplyr::if_else(
      preco_desconto <= 0.7 * preco_antigo, "compre", "aguarde"
    )
  )


