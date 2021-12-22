#==============================================================================
# Criando uma tabela de desejos para decisão
# Ícaro Vidal Freire
# site: https://www.edusp.com.br/loja/assuntos/21/matematica
#==============================================================================

# carregando pacotes ------------------------------------------------------
library(magrittr)

# site desejado -----------------------------------------------------------
site <- "https://www.edusp.com.br/loja/assuntos/21/matematica"

# raspando dados ----------------------------------------------------------
lista_desejos <- site |> 
  httr::GET(httr::config(ssl_verifypeer = FALSE)) |> 
  rvest::read_html() |> 
  rvest::html_elements("#dvProdutos p") |> 
  rvest::html_text2() |> 
  stringr::str_trim() %>% 
  .[c(8, 13, 15)] 

preco_normal <- site |> 
  httr::GET(httr::config(ssl_verifypeer = FALSE)) |> 
  rvest::read_html() |> 
  rvest::html_elements(".preco h2") |> 
  rvest::html_text2() |> 
  stringr::str_trim() |> 
  stringr::str_subset("De") |> 
  stringr::str_sub(7) |> 
  stringr::str_replace_all(",", ".") |> 
  as.numeric() %>%
  .[c(8, 13, 15)]

preco_desconto <- site |> 
  httr::GET(httr::config(ssl_verifypeer = FALSE)) |> 
  rvest::read_html() |> 
  rvest::html_elements(".preco h2") |> 
  rvest::html_text2() |> 
  stringr::str_trim() |> 
  stringr::str_subset("Por") |> 
  stringr::str_sub(8) |> 
  stringr::str_replace_all(",", ".") |> 
  as.numeric() %>%
  .[c(8, 13, 15)]

tabela <- 
  tibble::tibble(
    nome = lista_desejos,
    preco_normal = preco_normal,
    preco_desconto = preco_desconto
  ) |> 
  dplyr::mutate(
    decisao = ifelse(
      preco_desconto <= (1 - 0.3) * preco_normal, "compre", "aguarde"
    )
  )

# resultado final ---------------------------------------------------------
tabela |> knitr::kable()
