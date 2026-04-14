library(shiny)
library(DBI)
library(RMariaDB)
library(ggplot2)

source("../scraper.R")
source("../sentiment_engine.R")
source("../database.R")

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

      textInput(
        "url",
        "Enter Test Site URL:",
        value = "https://webscraper.io/test-sites/e-commerce/static/computers/laptops"
      ),

      actionButton(
        "scrape",
        "Scrape Website"
      ),

      br(),
      br(),

      selectInput(
        "product",
        "Select Product:",
        choices = NULL
      )

    ),

    mainPanel(

      h3("Product Sentiment"),

      tableOutput("product_table"),

      h3("Sentiment Trend"),
      plotOutput("sentiment_plot"),

      h3("Price Trend"),
      plotOutput("price_plot"),

      h2(textOutput("recommendation_text"))

    )
  )
)
server <- function(input, output, session) {

  data_reactive <- reactiveVal()

  # Load existing database data
  observe({

    df <- dbReadTable(con, "product_sentiment")

    df$scrape_time <- as.POSIXct(df$scrape_time)

    data_reactive(df)

    updateSelectInput(
      session,
      "product",
      choices = unique(df$product_name)
    )

  })


  # Run scraper when button is clicked
  observeEvent(input$scrape, {

  req(input$url)

  products <- scrape_products(input$url)

  products <- analyze_sentiment(products)

  store_results(con, products)

  # reload database after inserting
  df <- dbReadTable(con, "product_sentiment")

  df$scrape_time <- as.POSIXct(df$scrape_time)

  data_reactive(df)

  updateSelectInput(
    session,
    "product",
    choices = unique(df$product_name)
  )

})


  filtered_data <- reactive({

    df <- data_reactive()

    df[df$product_name == input$product, ]

  })


  output$product_table <- renderTable({

    df <- filtered_data()

    df$price <- paste0("$", df$price)

    df[,c(
      "product_name",
      "price",
      "sentiment_score",
      "recommendation"
    )]

  }, striped = TRUE, bordered = TRUE)


  output$sentiment_plot <- renderPlot({

    ggplot(filtered_data(),
           aes(x = scrape_time, y = sentiment_score)) +

      geom_line(color = "#2E86C1", linewidth = 1.2) +
      geom_point(color = "#1B4F72", size = 3) +

      geom_hline(yintercept = 0,
                 linetype = "dashed",
                 color = "red") +

      labs(
        title = "Review Sentiment Over Time",
        x = "Time",
        y = "Sentiment Score"
      ) +

      theme_minimal()

  })


  output$price_plot <- renderPlot({

    ggplot(filtered_data(),
           aes(x = scrape_time, y = price)) +

      geom_line(color = "#27AE60", linewidth = 1.2) +
      geom_point(color = "#1E8449", size = 3) +

      labs(
        title = "Product Price Trend",
        x = "Time",
        y = "Price ($)"
      ) +

      theme_minimal()

  })


  output$recommendation_text <- renderText({

    rec <- tail(filtered_data()$recommendation, 1)

    paste("Current Recommendation:", rec)

  })

}
shinyApp(ui = ui, server = server)