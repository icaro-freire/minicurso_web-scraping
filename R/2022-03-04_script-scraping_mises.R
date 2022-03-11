#==============================================================================
# Raspando dados de artigos em diversas páginas do site Mises
# Ícaro Vidal Freire
# 2022-03-04
#==============================================================================

# criando a função para raspagem ----------------------------------------------

raspa_mises <- function(nPg){
  # preparando url ----------------------------------------------------------
  url_mises <- stringr::str_c("https://www.mises.org.br/Articles_Thumbs.aspx?page=", nPg, "&type=0&text=")
  # preparando site ---------------------------------------------------------
  site_mises <- url_mises |>
    polite::bow(user_agent = "Curso de Extensão da UFRB: Raspando dados da Web com o R") |>
    polite::scrape()
  # raspando a data ---------------------------------------------------------
  data_mises <- site_mises |>
    rvest::html_elements(".mis-text-sans span:nth-child(1)") |>
    rvest::html_text2() |>
    lubridate::dmy()
  # raspando o autor --------------------------------------------------------
  autor_mises <- site_mises |>
    rvest::html_elements(".mis-text") |>
    rvest::html_text2()
  # raspando o título -------------------------------------------------------
  titulo_mises <- site_mises |>
    rvest::html_elements(".thumbsArticle") |>
    rvest::html_text2()
  # construindo a tabela ----------------------------------------------------
  tabela <- tibble::tibble(
    data   = data_mises,
    autor  = autor_mises,
    titulo = titulo_mises
  )
  # exibindo tabela ---------------------------------------------------------
  print(tabela)
}

# fazendo as iterações --------------------------------------------------------
tabela_mises <- purrr::map_df(0:24, raspa_mises)

# criando diretório para download -----------------------------------------
dados <- fs::dir_create("dados")

# escrevendo a tabela como um arquivo csv  --------------------------------
readr::write_csv(tabela_mises, "dados/tabela_mises.csv")

#==============================================================================
