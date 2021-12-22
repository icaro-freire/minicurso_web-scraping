#==============================================================================
# Raspando de e-books do II Simpósio da Região Nordeste
# Ícaro Vidal Freire
# site: https://www.obm.org.br/revista-eureka/
#==============================================================================

# site desejado -----------------------------------------------------------
site <- "https://www.obm.org.br/revista-eureka/"

# raspando dados ----------------------------------------------------------
links <- site |> 
  rvest::read_html() |> 
  rvest::html_elements("#revistas-list") |> 
  rvest::html_elements("a") |> 
  rvest::html_attr("href") |> 
  stringr::str_subset(".pdf")

index <- c(
  stringr::str_c("0", seq(1, 9)), 
  seq(10, 40)
)

nomes <- stringr::str_c(index, "_eureka")


# download de tudo --------------------------------------------------------
## criando o diretório para salvar os arquivos
arquivos_eureka <- fs::dir_create("arquivos_eureka")

## organizando a lista de argumentos
argS <- list(url = links, destfile = arquivos_eureka/nomes, mode = "wb")

## fazendo o download
purrr::pmap(argS, download.file)
