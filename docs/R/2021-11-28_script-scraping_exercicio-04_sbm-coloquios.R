#==============================================================================
# Exercício 04: Download ebooks IV Colóquio de Matemática da Região Norte
# Ícaro Vidal Freire
# data de acesso: 2021-11-28
#==============================================================================

# carregando pacotes ------------------------------------------------------
library(magrittr)

# url site ----------------------------------------------------------------
url_sbm <- "https://sbm.org.br/colecao-coloquios-de-matematica/"

# preparando o site -------------------------------------------------------
site_sbm <- rvest::read_html(url_sbm)

# raspando os dados -------------------------------------------------------
## links
links_sbm <- site_sbm |> 
  rvest::html_elements(".download-link") |> 
  rvest::html_attr("href") %>%
  .[7:10]

## nomes dos arquivos
nomes_links_sbm <- site_sbm |> 
  rvest::html_elements(".download-link") |> 
  rvest::html_text2() |> 
  stringr::str_to_lower() |> 
  base::iconv(to = "ASCII//TRANSLIT") |> 
  stringr::str_replace_all(" ", "-") %>%
  stringr::str_c("livros-sbm_", .) %>%
  .[7:10]

# praparando o download ---------------------------------------------------
## construindo diretórios e lista de argumentos
arquivos_sbm <- fs::dir_create("download/arquivos_sbm")
args_sbm <- list(links_sbm, arquivos_sbm/nomes_links_sbm, mode = "wb")

## fazendo o download de tudo
purrr::pwalk(args_sbm, download.file)
