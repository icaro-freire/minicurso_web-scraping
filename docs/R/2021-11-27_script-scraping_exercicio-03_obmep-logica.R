#==============================================================================
# Exercício 03: Download do material de Lógica da OBMEP
# Ícaro Vidal Freire
# data de acesso: 2021-11-26
#==============================================================================

# carregando pacote -------------------------------------------------------
library(magrittr)

# url do site -------------------------------------------------------------
url_logica <- "https://portaldaobmep.impa.br/index.php/modulo/ver?modulo=153&tipo=7"

# preparando o site -------------------------------------------------------
site_logica <- rvest::read_html(url_logica)

# raspando os dados -------------------------------------------------------

## links
links_logica <- site_logica |>
  rvest::html_elements(".btn-block") |> 
  rvest::html_attr("href") %>%
  stringr::str_c("https:", .)

## limpando e nomeando
nomes_logica <- site_logica |> 
  rvest::html_elements("h3") |> 
  rvest::html_text2() |> 
  base::iconv(to = "ASCII//TRANSLIT") |> 
  stringr::str_to_lower() |> 
  stringr::str_replace_all(" - ", "_") |> 
  stringr::str_replace_all(" ", "-") %>% 
  .[-c(9,10)] %>%
  stringr::str_c("0", seq(1, 8), "_apostilas-logica_", .)

# preparando para download ------------------------------------------------

## criando diretório e argumentos
arquivos_logica <- fs::dir_create("downloads/arquivos_logica")
logica_args <- list(links_logica, arquivos_logica/nomes_logica, mode = "wb")

## fazendo download
purrr::pwalk(logica_args, download.file)

#==============================================================================