#==============================================================================
# Raspando de e-books do II Simpósio da Região Nordeste
# Ícaro Vidal Freire
# site: https://mtm.grad.ufsc.br/livrosdigitais/
#==============================================================================

# carregando pacotes ------------------------------------------------------
library(magrittr)

# site para web scraping --------------------------------------------------
site <- "https://mtm.grad.ufsc.br/livrosdigitais/"

# raspagem ----------------------------------------------------------------
links <- site |> 
  rvest::read_html() |> 
  rvest::html_elements(".content a") |> 
  rvest::html_attr("href")

nomes <- site |> 
  rvest::read_html() |> 
  rvest::html_elements(".content a") |> 
  rvest::html_attr("href") |> 
  fs::path_file() |> 
  base::iconv(to = "ASCII//TRANSLIT") |> 
  stringr::str_to_lower() |> 
  stringr::str_replace_all("_", "-") |> 
  stringr::str_remove("-marcosh.s.martins-rosimarypereira") |> 
  stringr::str_remove("-silviam.holanda-inderj.taneja") %>%
  stringr::str_c("livros-ufsc_", .)

# download dos livros -----------------------------------------------------
argS <- list(
  url = links,
  destfile = fs::dir_create("livros-ufsc")/nomes,
  mode = "wb"
)

purrr::pmap(argS, download.file)

