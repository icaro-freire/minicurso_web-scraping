#==============================================================================
# Raspando apostilas (verdes) da OBMEP
# Ícaro Vidal Freire
# site: http://www.obmep.org.br/apostilas.htm
#==============================================================================

# carregando pacote -------------------------------------------------------
library(magrittr)

# site desejado -----------------------------------------------------------
site <- "http://www.obmep.org.br/apostilas.htm"

# raspando dos dados ------------------------------------------------------
links <- site |> 
  rvest::read_html() |> 
  rvest::html_elements(".green") |> 
  rvest::html_attr("href") |> 
  stringr::str_subset("apostila") %>%
  stringr::str_c("http://www.obmep.org.br", .)

nomes_tb <- site |> 
  rvest::read_html() |> 
  rvest::html_elements(".box") |> 
  rvest::html_text2() |> 
  stringr::str_trim() |> 
  stringr::str_sub(end = -8) |> 
  tibble::as_tibble() |> 
  dplyr::slice(1:11)

nomes <- nomes_tb$value

nomes <- nomes |>
  stringr::str_remove_all(" \\(\\.\\.\\.\\)") |>
  stringr::str_remove("- ") |>
  stringr::str_replace_all(" ", "-") |>
  stringr::str_to_lower() |>
  base::iconv(to = "ASCII//TRANSLIT") %>%
  stringr::str_c("apostila-obmep_", .)

index <- 
  stringr::str_c("0", seq(1, 9)) |> 
  stringr::str_c("_") |> 
  c("10_", "11_")

nomes_apostilas <- stringr::str_c(index, nomes)

# preparando para download ------------------------------------------------
## criando diretório para salvar arquivos
arquivos_obmep <- fs::dir_create("arquivos_obmep")

## argumentos para função download.file
argS <- list(
  url = links,
  destfile = arquivos_obmep/nomes_apostilas,
  mode = "wb"
)

## fazendo o download
purrr::pmap(argS, download.file)

