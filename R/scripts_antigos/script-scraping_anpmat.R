#==============================================================================
# Raspando de e-books do II Simpósio da Região Nordeste
# Ícaro Vidal Freire
# site: https://anpmat.org.br/ebooks-dos-simposios
#==============================================================================

# carregando pacotes ------------------------------------------------------
library(magrittr)

# url do site -------------------------------------------------------------
site <- "https://anpmat.org.br/ebooks-dos-simposios"

# raspando os dados -------------------------------------------------------
links <- site |> 
  rvest::read_html() |> 
  rvest::html_elements("#post-890 a") |>  
  rvest::html_attr("href") %>% 
  .[25:33]

nomes <- site |> 
  rvest::read_html() |> 
  rvest::html_elements("#post-890 a") |>  
  rvest::html_text2() %>%
  .[25:33] |> 
  base::iconv(to = "ASCII//TRANSLIT") |> 
  stringr::str_remove_all("- ") |> 
  stringr::str_remove("\\?") |> 
  stringr::str_remove(":") |> 
  stringr::str_to_lower() |> 
  stringr::str_replace_all(" ", "-") %>%
  stringr::str_c("livro-anpmat_", .)
  

# download de tudo --------------------------------------------------------
## criando um diretório para download
arquivos_anpmat <- fs::dir_create("arquivos_anpmat")

## criando os argumentos para usar em pmap()
argS <- list(links, arquivos_anpmat/nomes, mode = "wb")

## fazendo o download
purrr::pmap(argS, download.file)
