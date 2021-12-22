# pacotes carregados ----------------------------------------------------------
library(magrittr)

# site desejado ---------------------------------------------------------------
url_sbm <- "https://sbm.org.br/colecao-coloquios-de-matematica/"

# raspagem --------------------------------------------------------------------
links <- url_sbm  |>
  rvest::read_html() |>
  rvest::html_elements(".download-link") |>
  rvest::html_attr("href")

nomes <- url_sbm |>
  rvest::read_html() |>
  rvest::html_elements(".download-link") |>
  rvest::html_text2()

# visualizando como tabela ----------------------------------------------------
tabela <-
  tibble::tibble(nome = nomes, link = links) |>
  tibble::view()

# limpando os nomes -----------------------------------------------------------
nomes_clean <- nomes |>
  base::iconv(to = "ASCII//TRANSLIT") |>
  stringr::str_to_lower() |>
  stringr::str_replace_all(" ", "-") %>%
  stringr::str_c("livro-sbm_", .)

# download de todos os arquivos -----------------------------------------------
purrr::pmap(
  list(
    url = links,
    destfile = fs::dir_create("livros_sbm")/nomes_clean,
    mode = "wb"
  ),
  download.file
)
