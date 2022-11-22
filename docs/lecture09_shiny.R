library(shiny)
library(magrittr)
library(bslib)
# thematic::thematic_shiny(font = "auto")

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = bs_theme(bootswatch = "superhero", font_scale = 1.5),

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("cells",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            textInput(inputId = "label_x",
                      label = "Label for the x-axis:"),
            textInput(inputId = "title",
                      label = "Title for the graph:"),
            actionButton(inputId = "make_graph", 
                         label = "Make the plot!",
                         icon = icon("drafting-compass"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
          tabsetPanel(
            tabPanel("Plot", plotOutput("distPlot")),
            tabPanel("Summary statisics", tableOutput("tabStats"))
          )
        )
    )
)

# Define server logic required to draw a histogram
# server <- function(input, output) {
#   # generate cells based on input$cells from ui.R
#   x <- reactive(faithful[, 2])
#   breaks <- eventReactive(input$make_graph, {seq(min(x()), max(x()), length.out = input$cells + 1)})
#   xlab <- eventReactive(input$make_graph, {input$label_x})
#   title <- eventReactive(input$make_graph, {input$title})
#   
#   output$distPlot <- renderPlot({
#     # draw the histogram with the specified number of cells
#     hist(x(), breaks = breaks(), col = 'darkgray', border = 'white', xlab=xlab(), main=title())
#   })
# }

server <- function(input, output) {
  # bs_themer()
  # generate cells based on input$cells from ui.R
  x <- reactive(faithful[, 2])
  breaks <- reactive(seq(min(x()), max(x()), length.out = input$cells + 1)) %>% bindEvent(input$make_graph)
  xlab <- reactive(input$label_x) %>% bindEvent(input$make_graph)
  title <- reactive(input$title) %>% bindEvent(input$make_graph)
  observeEvent(input$make_graph, message("make a new graph"))
  
  output$distPlot <- renderPlot({
    # draw the histogram with the specified number of cells
    hist(x(), breaks = breaks(), col = 'darkgray', border = 'white', xlab=xlab(), main=title())
  })
  
  output$tabStats <- renderTable({xtable::xtable(t(summary(x())))})
}

# Run the application 
shinyApp(ui = ui, server = server)
