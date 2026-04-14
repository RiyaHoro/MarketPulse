source("packages.R")

analyze_sentiment <- function(data) {

  data$sentiment_score <- get_sentiment(data$review_text)

  data$recommendation <- ifelse(
    data$sentiment_score > 0.2,
    "BUY",
    "AVOID"
  )

  data$scrape_time <- Sys.time()

  return(data)
}