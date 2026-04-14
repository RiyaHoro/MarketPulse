library(rvest)
library(dplyr)
library(stringr)

scrape_products <- function(url) {

  page <- read_html(url)

  product_name <- page %>%
    html_nodes(".title") %>%
    html_text(trim = TRUE)

  price <- page %>%
    html_nodes(".price") %>%
    html_text(trim = TRUE) %>%
    gsub("\\$", "", .) %>%
    as.numeric()

  review_text <- page %>%
    html_nodes(".description") %>%
    html_text(trim = TRUE)

  data <- data.frame(
    product_name,
    price,
    review_text,
    stringsAsFactors = FALSE
  )

  return(data)
}