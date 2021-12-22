#==============================================================================
# Raspando material sobre R
# Ícaro Vidal Freire
# site: https://nbcgib.uesc.br/lec/avale-es/r
#==============================================================================

# Quebrou em 2021-11-25

# pacote para operador pipe %>% -------------------------------------------
library(magrittr)

# site para raspagem ------------------------------------------------------
site <- "https://nbcgib.uesc.br/lec/avale-es/r"

# raspagem ----------------------------------------------------------------
## 1º modo
site |> 
  httr::GET(httr::config(ssl_verifypeer = FALSE)) |> 
  rvest::read_html() |> 
  rvest::html_elements("#rt-mainbody li") |> 
  rvest::html_element("a") |> 
  rvest::html_attr("href") |>
  stringr::str_subset("R/ir") |> 
  stringr::str_replace("/lec/", "https://nbcgib.uesc.br/lec/")

## 2º modo
links <- site |> 
  rvest::read_html() |> 
  rvest::html_elements("#rt-mainbody li") |> 
  rvest::html_element("a") |> 
  rvest::html_attr("href") |> 
  stringr::str_subset("R/ir") %>%
  stringr::str_c("https://nbcgib.uesc.br", .)

nomes_arquivos <- site |> 
  rvest::read_html() |> 
  rvest::html_elements("#rt-mainbody li") |> 
  rvest::html_element("a") |> 
  rvest::html_attr("href") |> 
  stringr::str_subset("R/ir") %>%
  stringr::str_c("https://nbcgib.uesc.br", .) |> 
  fs::path_file()

# download de tudo --------------------------------------------------------
## criando o diretório para salvar os arquivos
arquivos_uesc <- fs::dir_create("arquivos_uesc")

## fazendo download de tudo com purrr
purrr::walk2(links, arquivos_uesc/nomes_arquivos, download.file)
