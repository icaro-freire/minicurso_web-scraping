#==============================================================================
# Exercício 02: Download das apostilas do PIC
# Ícaro Vidal Freire
# data de acesso: 2021-11-26
#==============================================================================

# pacptes carregados ------------------------------------------------------
library(magrittr)

# url do site -------------------------------------------------------------
url_obmep <- "http://www.obmep.org.br/apostilas.htm"

# preparação do site ------------------------------------------------------
site_obmep <- rvest::read_html(url_obmep)

# raspagem dos dados ------------------------------------------------------

## links das apostilas
links_obmep <- site_obmep |> 
  rvest::html_elements(".green") |> 
  rvest::html_attr("href") |> 
  stringr::str_subset("apostila") %>%
  stringr::str_c("http://www.obmep.org.br", .)

## nomes das apostilas
nomes_links_obmep <- site_obmep |> 
  rvest::html_elements(".box") |> 
  rvest::html_text2() |> 
  stringr::str_trim() |> 
  stringr::str_sub(end = -8) |>
  stringr::str_to_lower() |> 
  stringr::str_replace_all(" - ", " ") |> 
  stringr::str_remove(" \\(\\.\\.\\.\\)") |> 
  stringr::str_replace_all(" ", "-") |> 
  base::iconv(to = "ASCII//TRANSLIT") %>%
  stringr::str_c("apostila-obmep_", .) %>%
  .[1:11]

# fazendo o download ------------------------------------------------------

## criando os diretórios e argumentos
arquivos_obmep <- fs::dir_create("downloads/arquivos_obmep")
obmep_args <- list(links_obmep, arquivos_obmep/nomes_links_obmep, mode = "wb")

## download com purrr
purrr::pwalk(obmep_args, download.file)

#==============================================================================