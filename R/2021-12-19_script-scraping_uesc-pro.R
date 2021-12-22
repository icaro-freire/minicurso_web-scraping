#==============================================================================
# Raspando material sobre R
# Ícaro Vidal Freire
# data de acesso: 2021-12-19
#==============================================================================

# pacote usado ------------------------------------------------------------
library(magrittr)

# url do site -------------------------------------------------------------
url_uesc <- "https://lec.pro.br/avale-es/r"

# site para scraping ------------------------------------------------------
site_uesc <- rvest::read_html(url_uesc)

# raspando os materiais ---------------------------------------------------
links_uesc <- site_uesc |> 
  rvest::html_elements("li:nth-child(2) h5+ ul a") |> 
  rvest::html_attr("href") %>% 
  stringr::str_c("https://lec.pro.br", .)

# preparando para download ------------------------------------------------
arquivos_uesc <- fs::dir_create("download_arquivos/arquivos_uesc")
nomes_links_uesc <- fs::path_file(links_uesc)

# fazendo o download ------------------------------------------------------
purrr::walk2(links_uesc, arquivos_uesc/nomes_links_uesc, download.file)

#==============================================================================