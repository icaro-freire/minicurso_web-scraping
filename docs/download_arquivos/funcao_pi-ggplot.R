#====================================================
# Estimativa de Pi com ggplot
# Ícaro Vidal Freire
# icarofreire7@gmail.com
#====================================================


# 00. Carregando Pacotes ------------------------------------------------------

library(tidyverse) # pacote para análise de dados
library(ggforce)   # pacote usado para criar um círculo unitário


# 01. Função ------------------------------------------------------------------

piEstimativa <- function(n){
  x = runif(n, -1, 1)
  y = runif(n, -1, 1)
  
  dt = tibble(x, y)
  
  graph <- dt %>% 
    ggplot(aes(x, y)) +
    geom_circle(
      aes(x0 = 0, y0 = 0, r = 1), 
      color = "red", 
      inherit.aes = FALSE
    ) +
    geom_point(alpha = 0.5, color = "blue")
  
  print(graph)
  
  raio <- sqrt(x^2 + y^2) # distância do ponto (x, y) à origem, denominado `raio`
  pontos_dentro <- raio[raio < 1] # pontos que estão dentro do círculo unitário
  print(4 * length(pontos_dentro) / n ) # calcula a estimativa
}


# 02. Estimando Pi ------------------------------------------------------------

piEstimativa(10)
piEstimativa(100)
piEstimativa(1000)
piEstimativa(2000)
