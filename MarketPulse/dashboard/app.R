library(shiny)
library(DBI)
library(RMariaDB)
library(ggplot2)

# Database connection
con <- dbConnect(
  RMariaDB::MariaDB(),
  dbname = "market_engine",
  host = Sys.getenv("MYSQL_HOST"),
  user = Sys.getenv("MYSQL_USER"),
  password = Sys.getenv("MYSQL_PASSWORD")
)

# Load data
data <- dbReadTable(con, "product_sentiment")

ui <- fluidPage(

  titlePanel("Real-Time Market Sentiment Engine"),

  sidebarLayout(

    sidebarPanel(

      selectInput(
        "product",
        "Select Product:",
        choices = unique(data$product_name)
      )

    ),

    mainPanel(

      h3("Product Sentiment"),

      tableOutput("product_table"),

      h3("Sentiment Trend"),

      plotOutput("sentiment_plot"),

      h3("Price Trend"),

      plotOutput("price_plot")

    )
  )
)

server <- function(input, output) {

  filtered_data <- reactive({

    data[data$product_name == input$product, ]

  })

  output$product_table <- renderTable({

    filtered_data()[,c(
      "product_name",
      "price",
      "sentiment_score",
      "recommendation"
    )]

  })

  output$sentiment_plot <- renderPlot({

    ggplot(filtered_data(),
           aes(x = scrape_time, y = sentiment_score)) +
      geom_line() +
      geom_point() +
      theme_minimal()

  })

  output$price_plot <- renderPlot({

    ggplot(filtered_data(),
           aes(x = scrape_time, y = price)) +
      geom_line() +
      geom_point() +
      theme_minimal()

  })

}

shinyApp(ui = ui, server = server)