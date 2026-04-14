source("scraper.R")
source("sentiment_engine.R")
source("database.R")

cat("Starting pipeline...\n")

# Scrape data
products <- scrape_products()

cat("Scraping complete\n")

# Sentiment analysis
products <- analyze_sentiment(products)

cat("Sentiment analysis complete\n")

# Database connection
con <- connect_db()

# Store data
store_results(con, products)

cat("Data stored in MySQL\n")

# Close connection
dbDisconnect(con)

cat("Rows inserted:", nrow(products), "\n")

cat("Pipeline finished\n")