#==============================================================================
# Download de livros da UFSC para graduação 
# Ícaro Vidal Freire
# data de acesso: 2021-11-26
#==============================================================================

# carregando pacote -------------------------------------------------------
library(magrittr)

# url do site -------------------------------------------------------------
url_ufsc <- "https://mtm.grad.ufsc.br/livrosdigitais/"

# preparando o site -------------------------------------------------------
site_ufsc <- rvest::read_html(url_ufsc)

# raspando os dados -------------------------------------------------------

## links
links_ufsc <- site_ufsc |> 
  rvest::html_elements(".content a") |> 
  rvest::html_attr("href")

## nomes
nomes_links_ufsc <- links_ufsc |> 
  fs::path_file() |> 
  stringr::str_remove("-SilviaM.Holanda-InderJ.Taneja") |> 
  stringr::str_remove("-MarcosH.S.Martins-RosimaryPereira") |>
  base::iconv(to = "ASCII//TRANSLIT") |> 
  stringr::str_to_lower() |> 
  stringr::str_replace_all("_", "-") %>%
  stringr::str_c("livros-ufsc_", .)

# preparando para download ------------------------------------------------

## criando diretório e lista de argumentos 
arquivos_ufsc <- fs::dir_create("downloads/arquivos_ufsc")
args_ufsc <- list(links_ufsc, arquivos_ufsc/nomes_links_ufsc, mode = "wb")

## download
purrr::pwalk(args_ufsc, download.file)

#==============================================================================