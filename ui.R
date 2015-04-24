library(shiny)

shinyUI(fluidPage(
  
  # Application title

  titlePanel(withMathJax("\\(\\pi\\) approximation with Monte Carlo")),
  
  fluidRow(
    column(5,
           br(),
           sliderInput("sims",
                       "number of simulations ( x 1000 )",
                       min = 25,
                       max = 1000,
                       value = 1),
           #selectInput("radius", c( "1", "2", "5", "10", "25"), label = "radius"),
           actionButton("submit", "Simulate Again"),
           br(),
           br(),
           fluidRow(
             column(5,
                    withMathJax( "\\(\\pi_{estimated}\\)")
             ),
             column(5,
                    strong(textOutput("pi"))
             )
           ),           
           fluidRow(
             column(5,
                    withMathJax("\\(\\pi - \\pi_{estimated}\\)" )
             ),
             column(5,
                    textOutput("diff")
             )
           ),           
           fluidRow(
             column(5,
                    "error"
             ),
             column(5,
                    textOutput("prc")
             )
           )
           
    ),
    column(7,
           plotOutput("piPlot")
    )    
  ),  
  br(),
  fluidRow(
  column(12,
  withMathJax("The approximation is based on the fact that \\( A_{circle} = \\pi * r^2 \\) and \\( A_{square} = 4 * r^2 \\)" ),               
  withMathJax( "what means that \\( \\pi = 4 * A_{circle}/A_{square} \\)" ),
  withMathJax("Both areas (\\( A_{circle}, A_{square}\\) ) can be estimated by selecting random point on the square and checking if the point belongs to the circle or not by "),
  withMathJax("looking at \\( x^2 + y^2 <= r^2 \\)"),  
  br(),
  br(),
  withMathJax("The value of \\( \\pi \\) can be now estimated as follows"),
  withMathJax("$$ \\pi_{estimated} = 4 * numberOfBluePoints / TotalNumberOfPoints $$")
  )
  )
))
