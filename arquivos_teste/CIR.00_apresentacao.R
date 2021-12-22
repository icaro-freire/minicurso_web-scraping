# =============================================================================
# Título : Introdução ao ambiente computacional estatístico R
# Autor  : Laboratório de Estatística Computacional - LEC
# Data   : 24/04/2021 13:08:12
# Tutores: José Cláudio Faria
#          Ivan Bezerra Allaman
# =============================================================================
#... Script otimizado para uso no Tinn-R (https://tinn-r.org/pt/)
# =============================================================================

#.. R: um software livre, gratuito, expansível e de qualidade!
#.. (Construído e mantido pela comunidade de usuários)
#..
#...                               ^
#...                              /'\
#...                             /-.-\
#...                            /-----\
#...                          </   R   \>
#...                        <</---------\>>
#..                           BEM  |  VINDO
#...            <<</---------------------------------\>>>
#                 ---'---   ---'---   ---'---   ---'---
#             ... | bas |   | sta |   | gra |   | dat | ...
#                 -------   -------   -------   -------
#                     \-------/           \-------/
#                      ---'---             ---'----
#                  ... | car |             | MASS | ...
#                      -------             --------
#                          \-----------------/
#                                ---'---
#                            ... | xxxx | ...
#                                -------
#                                  ...

#... ENVIE AS INTRUÇÕES ABAIXO PARA O INTERPRETADOR R
#... (INICIALMENTE LINHA POR LINHA OU PEQUENAS SELEÇÕES)
#... PARA SE FAMILIARIZAR COM OS PRINCIPAIS RECURSOS

#. Apresentação do ambiente R

#.. Recursos gráficos básicos (exemplos)
dev.new()                                    # Abre um novo dispositivo gráfico
bringToTop(stay=T)                           # Traz pra a frente da tela

demo(graphics,                               # Inicia demo
     echo=FALSE,
     ask=TRUE)                               #... Dê clicks no gráfico para avançar
msgWindow('hide')                            # Oculta o dispositivo gráfico

demo()                                       # Lista os demos dos pacotes carregados na sessão

msgWindow('restore')
demo(persp,
     echo=FALSE,
     ask=TRUE)                               # Recursos gráficos 3D

msgWindow('hide')
demo(package='stats')                        # Lista os demos do pacote stats

msgWindow('restore')
demo('lm.glm',                               # Rada o demo lm.glm do pacote stats
     package='stats',
     echo=FALSE,
     ask=TRUE)

msgWindow('hide')
system.file('demo',
            'lm.glm.R',
            package='stats')                 # Localiza o local físico do arquivo de um demo

demo(package=.packages(all.available=TRUE))  # Lista os demos de todos os pacotes instalados (carregados ou não)

#.. Recursos gráficos mais avançados (exemplos)
msgWindow('restore')
demo(plotmath,
     echo=FALSE,
     ask=TRUE)                               # Recursos para escrever equações,
                                             # fórmulas e símbolos dentro de gráficos
msgWindow('hide')

# install.packages('plotrix')
library(plotrix)                             # Atenção, 'plotrix' não vem instalado

msgWindow('restore')
demo(plotrix,                                # Interativo: necessário fazer escolhas no R
     echo=FALSE)
msgWindow('hide')

#... rgl (3d dinâmico)
# install.packages('rgl')
library(rgl)                                 # Atenção, 'rgl' não vem instalado

demo(abundance,
     echo=FALSE)                             # Interagir com o mouse no gráfico...
demo(bivar,
     echo=FALSE)                             # Interagir com o mouse no gráfico...

#.. Gráficos interativos para ensino
# install.packages('asbio')
msgWindow('restore')
library(asbio,
        echo=FALSE)                          # Atenção, 'asbio' não vem instalado
anm.ci.tck()                                 # Intervalo de confiança
