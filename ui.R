library(shiny)
library(data.table)

fluidPage(
  
  titlePanel(h1("Indice de production industrielle", align="center")),
  
  column(2,
         checkboxGroupInput("pays", "pays", width='800px',
                            choices = c("Allemagne"=1,"Espagne"=2,"France"=3,"Italie"=4),
                            selected = c(1, 2, 3, 4))),
  column(10,

  tabsetPanel(
    tabPanel("Indices",fluidRow(
      column(12,"   "),
      column(3,
             checkboxInput(inputId = "log",
                           label = strong("echelle logarithmique"),
                           value = FALSE)),
      column(9,  
             sliderInput(inputId = "base", 'annee de base', 
                         width='100%', ticks=FALSE, sep="",
                         min=1974, max=2016,
                         value=2001, step=1)), 
      column(12,
             plotOutput('plot'))
    )),
    tabPanel("Taux de croissance",fluidRow(
      column(3,
             selectInput("lissage", "lissage (ans) :", width='80px',
                         choices=c(3,5,7))),
      column(9,"   "),
      column(12,
                    plotOutput('plot2')
      ))))
  )
)