#==============================================================================
# Raspando título de artigo em mais de uma página
# Ícaro Vidal Freire
# data de acesso: 2021-11-28
#==============================================================================

# treinando na 1ª página --------------------------------------------------

## url do site
url_pg1 <- "https://mises.org.br/Articles_Thumbs.aspx?page=0&type=1&text="

## preparando o site
site_mises_pg1 <- rvest::read_html(url_pg1)

## raspando títulos
titulos_pg1 <- site_mises_pg1 |> 
  rvest::html_elements(".thumbsArticle") |> 
  rvest::html_text2()

## raspando autores
autores_pg1 <- site_mises_pg1 |> 
  rvest::html_elements(".mis-text") |> 
  rvest::html_text2()

## raspando datas
datas_pg1 <- site_mises_pg1 |> 
  rvest::html_elements(".mis-text-sans span:nth-child(1)") |> 
  rvest::html_text2() |> 
  lubridate::dmy()

## tabela final
tabela_mises_pg1 <- tibble::tibble(
  titulo = titulos_pg1,
  autor = autores_pg1,
  data = datas_pg1
)

tabela_mises_pg1 |> tibble::view()

# raspando em várias páginas ----------------------------------------------

## criando uma função para raspar
raspa_mises <- function(nPg){
  # preparando o site
  site_mises <- 
    stringr::str_c("https://mises.org.br/Articles_Thumbs.aspx?page=", nPg, "&type=1&text=") |>
    polite::bow() |> 
    polite::scrape()
  # raspando titulo
  raspa_titulo <- site_mises |> 
    rvest::html_elements(".thumbsArticle") |> 
    rvest::html_text2()
  # raspando autor
  raspa_autor <- site_mises |> 
    rvest::html_elements(".mis-text") |> 
    rvest::html_text2()
  # raspando data
  raspa_data <- site_mises |>
    rvest::html_elements(".mis-text-sans span:nth-child(1)") |>
    rvest::html_text2() |>
    lubridate::dmy()
  # juntando tudo numa tabela
  tabela_mises <- tibble::tibble(
    titulo = raspa_titulo,
    autor = raspa_autor,
    data = raspa_data
  )
  # exibindo a tabela
  print(tabela_mises)
}

## testando a função raspa_mises
raspa_mises(0)
raspa_mises(1)

## raspando tudo e colocando em tabelas
tabelas_mises <- purrr::map(0:3, raspa_mises)

## juntando as tabelas
tabela_mises <- dplyr::bind_rows(
  tabelas_mises[[1]],
  tabelas_mises[[2]],
  tabelas_mises[[3]],
  tabelas_mises[[4]]
)

# exibição final
tabela_mises |> tibble::view()

#==============================================================================