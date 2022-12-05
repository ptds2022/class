library(shiny)
# Modules
histogramUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("var"), "Variable", choices = names(mtcars)),
    numericInput(ns("bins"), "bins", value = 10, min = 1),
    plotOutput(ns("hist"))
  )
}

histogramServer <- function(id, title = reactive("Histogram")) {
  moduleServer(id, function(input, output, session) {
    output$hist <- renderPlot({
      hist(mtcars[,input$var], breaks = input$bins, main = title())
    }, res = 96)
  })
}

ui <- fluidPage(
  histogramUI("hist1")
)
server <- function(input, output, session) {
  # data <- reactive(mtcars$mpg)
  histogramServer("hist1")
}
# Run the application 
shinyApp(ui, server)