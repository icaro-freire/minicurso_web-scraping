#==============================================================================
# Download das revistas Eureka
# Ícaro Vidal Freire
# 2022-03-04
#==============================================================================

# url do site -------------------------------------------------------------
url_eureka <- "https://www.obm.org.br/revista-eureka/"

# preparação do site ------------------------------------------------------
site_eureka <- rvest::read_html(url_eureka)

# raspagem dos dados ------------------------------------------------------
## extraindo links
links_eureka <- site_eureka |>
  rvest::html_elements("#revistas-list a") |>
  rvest::html_attr("href") |>
  stringr::str_subset(".pdf")

## modificando os nomes
index <- c(stringr::str_c("0", seq(1, 9)), seq(10, 42))
nomes_eureka <- stringr::str_c(index, "_eureka.pdf")

## criando os diretórios e caminhos
arquivos_eureka <- fs::dir_create("downloads/arquivos_eureka")

# fazendo os downloads ----------------------------------------------------
download.file(links_eureka, arquivos_eureka/nomes_eureka)

#==============================================================================




