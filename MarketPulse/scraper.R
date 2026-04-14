source("packages.R")
source("config.R")

scrape_products <- function() {

  page <- read_html(TARGET_URL)

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