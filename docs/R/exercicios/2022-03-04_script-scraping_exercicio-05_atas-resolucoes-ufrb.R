#==============================================================================
# Raspando Atas e Resoluções da UFRB
# Ícaro Vidal Freire
# 2022-03-04
#==============================================================================

library(magrittr)

# url do site -------------------------------------------------------------
url_ufrb <- "https://ufrb.edu.br/soc/atas-e-resolucoes?page=1"

# preparando o site -------------------------------------------------------
site_ufrb <- url_ufrb |>
  polite::bow(user_agent = "Curso de Extensão da UFRB: Raspagem de Dados com o R") |>
  polite::scrape()

# raspando a tabela -------------------------------------------------------
tab_inicial_pg1 <- site_ufrb |>
  rvest::html_elements(".table-hover") |>
  rvest::html_table()

tb_pg1 <- tab_inicial_pg1[[1]] |> tibble::as_tibble()

tb_pg1 <- tb_pg1 |>
  dplyr::mutate(link = links_ufrb) |>
  dplyr::filter(Categoria == "Resolução CONSUNI")

tb_pg1$Título <- tb_pg1$Título |>
  stringr::str_replace_all("/", "-") |>
  stringr::str_replace_all(" ", "_") |>
  stringr::str_to_lower() |>
  stringi::stri_trans_general("Latin-ASCII") |>
  stringi::stri_c(".pdf")

arquivos_ufrb <- fs::dir_create("downloads/arquivos_ufrb")

download.file(tb_pg1$link, arquivos_ufrb/tb_pg1$Título)
# fazendo download --------------------------------------------------------

links_ufrb <- site_ufrb |>
  rvest::html_elements(".col-md-4 a") |>
  rvest::html_attr("href")

nomes_ufrb <- site_ufrb |>
  rvest::html_elements(".col-md-4 a") |>
  rvest::html_text2() |>
  stringr::str_replace_all(" ", "_") |>
  stringr::str_to_lower() |>
  stringi::stri_trans_general("Latin-ASCII") %>%
  stringr::str_c(".pdf") |>
  stringr::str_replace_all("/", "-")

arquivos_ufrb <- fs::dir_create("downloads/arquivos_ufrb")

download.file(links_ufrb, arquivos_ufrb/nomes_ufrb)

#==============================================================================
