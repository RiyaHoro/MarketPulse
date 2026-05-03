

connect_db <- function() {

  con <- DBI::dbConnect(
    RMariaDB::MariaDB(),
    host = "localhost",
    user = "root",
    password = "root",
    dbname = "market_engine"
  )

  return(con)
}

store_results <- function(con, data) {

  dbWriteTable(
    con,
    "product_sentiment",
    data,
    append = TRUE,
    row.names = FALSE
  )

}