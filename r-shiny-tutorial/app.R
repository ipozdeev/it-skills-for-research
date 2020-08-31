library(shiny)
source("datafeed.R")
source("helpers.R")

# user interface is defined here
ui <- fluidPage(
  titlePanel("market betas vs. average returns"),
  
  sidebarLayout(
    sidebarPanel(
      "select data frequency",
      selectInput("frequency",
                  label = "select frequency",
                  choices = list("daily" = "daily", 
                                 "monthly" = "monthly",
                                 "yearly" = "yearly"), selected = "daily"),
    ),
    mainPanel("results",
              textOutput(("b")))
  )
)

# what your computer/server does is defined here
server <- function(input, output) {
  r = get_stock_data()
  print(r)
  mu = apply(r, 1, FUN = mean)
  b = calculate_betas(r ,freq = input$frequency, mkt_col = "SPY")
  output$b <- renderText({ 
    "You have selected this"
  })
}

# this runs the app with the UI and server logic
shinyApp(ui = ui, server = server)