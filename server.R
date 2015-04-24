library(shiny)

R <- 10
SIMULATED <- F
thePi <- NULL

is.inside <- function(x, y, r) {
  myRetVal <- x^2 + y^2 <= r^2  
  
  myRetVal
}

getPi <- function(runs, r) {
  myRetVal <- thePi
    
  if( !SIMULATED ) {    
    withProgress(message = 'Simulating values', value = 0.1, {
    set.seed(12345)
  
    myRetVal <- NULL
    myRetVal$runs <- runs  
    myRetVal$radius <- as.numeric(r)
    
    myRetVal$xs <- runif(runs,min= -myRetVal$radius ,max= myRetVal$radius )
    myRetVal$ys <- runif(runs,min= -myRetVal$radius ,max= myRetVal$radius )      
    
    myRetVal$pi <-  (sum(is.inside(myRetVal$xs,myRetVal$ys,myRetVal$radius))/runs) * 4
    myRetVal$prc <- abs(100*(myRetVal$pi - pi)/pi)
    myRetVal$diff <- myRetVal$pi - pi
    
    thePi <- myRetVal
    SIMULATED <- T
    })
  }
  
  myRetVal
}

shinyServer(function(input, output) {
  
  output$pi <- renderText( 
    {             
      input$submit      
      getPi( isolate(input$sims) * 1000, R )$pi
    }     
  )
  
  output$prc <- renderText( 
    { 
      input$submit
      myPi <- getPi( isolate(input$sims) * 1000, R )
      paste( round(myPi$prc,4), "%")  
    }     
  )
  
  output$diff <- renderText( 
  {  
    input$submit    
    myPi <- getPi( isolate(input$sims) * 1000, R )
  
    round(myPi$diff,4)
  }     
  )
  
  output$piPlot <- renderPlot({        
    input$submit

    r <- 0
    runs <- 0
    
    runs <- isolate(input$sims) * 1000
    r <- R
    
    if( r > 0 ) {
      myPi <- getPi( runs, r )
    
      withProgress(message = 'Generating plot', value = 0.1, {
      plot(myPi$xs,myPi$ys,pch='.',col=ifelse( is.inside(myPi$xs,myPi$ys, myPi$radius),"blue","grey")
           ,xlab='',ylab='',asp=1, xaxt='n',yaxt='n', axes = F,
          main=paste(runs, "simulations, radius", myPi$radius))       
      })
    }
  })
})