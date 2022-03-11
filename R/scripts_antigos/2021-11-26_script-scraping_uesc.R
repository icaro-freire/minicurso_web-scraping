#==============================================================================
# Raspando material sobre R
# Ícaro Vidal Freire
# data de acesso: 2021-11-26
#==============================================================================

# pacote usado ------------------------------------------------------------
library(magrittr)

# url do site -------------------------------------------------------------
url_uesc <- "http://nbcgib2.uesc.br/avale-es/r"

# site para scraping ------------------------------------------------------
site_uesc <- rvest::read_html(url_uesc)

# raspando os materiais ---------------------------------------------------
links <- site_uesc |> 
  rvest::html_elements("#sp-component li li a") |> 
  rvest::html_attr("href") |> 
  stringr::str_subset("R/ir") %>% 
  stringr::str_c("http://nbcgib2.uesc.br", .)

# preparando para download ------------------------------------------------
arquivos_uesc <- fs::dir_create("download_arquivos/arquivos_uesc")
nomes_links <- fs::path_file(links)

# fazendo o download ------------------------------------------------------
purrr::walk2(links, arquivos_uesc/nomes_links, download.file)

#==============================================================================