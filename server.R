library(shiny)
library(ggplot2)
library(RColorBrewer)

function(input, output) {

#  PIB_Decodex <- read_excel("E:/PIB_Decodex.xlsx")
#  pib <- ts(cbind(PIB_Decodex$DEU,PIB_Decodex$ESP,PIB_Decodex$ITA,PIB_Decodex$FRA),frequency=1,start=1974)
  load("pib.RData")
  tca<-diff(pib)
  for (j in 1:4){
    for (i in 1:42) {
      tca[i,j]<-tca[i,j]/pib[i,j]*100
    }}
  
  thePal <- c("tomato3","orange","blue","green")
  
  output$plot <- renderPlot({
    pib2 <-  pib
    base=input$base-1973
    for(i in 1:4) pib2[,i]=pib[,i]/pib[base,i]*100
  
    if (input$log) lg="y" else lg=""
    choix<-as.numeric(input$pays)

    plot(pib2[,choix], plot.type="single", 
         col=thePal[choix], lwd=2,
         xlab="annees",
         ylab="indice de production industrielle",
         log=lg) 
    abline(a=100,b=0)
    
    }, height=500)
  
  output$plot2 <- renderPlot({
    p<-as.numeric(input$lissage)
    choix<-as.numeric(input$pays)

    tca_filt<-filter(tca,rep(1/p,p),sides=2)
    plot(tca_filt[,choix], plot.type="single", 
          col=thePal[choix], lwd=2,
         xlab="annees",
         ylab="croissance annuelle") 
    abline(a=0,b=0)
    
    
  }, height=500)
  
}
