#==============================================================================
# Download de arquivos com extensão .R
# Ícaro Vidal Freire
# 2022-03-04
#==============================================================================

# carregando pacotes ------------------------------------------------------
library(magrittr)

# preparando url ----------------------------------------------------------
url_uesc <- "https://lec.pro.br/avale-es/r"

# preparando o site -------------------------------------------------------
site_uesc <- rvest::read_html(url_uesc)

# raspando os links -------------------------------------------------------
links_uesc <- site_uesc |>
  rvest::html_elements("li:nth-child(2) h5+ ul a") |>
  rvest::html_attr("href") %>%
  stringr::str_c("https://lec.pro.br", .)

# raspando os nomes dos arquivos ------------------------------------------
nomes_uesc <- fs::path_file(links_uesc)

# preparando pasta para download ------------------------------------------
arquivos_uesc <- fs::dir_create("download_arquivos/arquivos_uesc")

# fazendo o download ------------------------------------------------------
download.file(links_uesc, arquivos_uesc/nomes_uesc)

#==============================================================================
