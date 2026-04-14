

connect_db <- function() {

  con <- dbConnect(
    RMariaDB::MariaDB(),
    dbname = DB_NAME,
    host = DB_HOST,
    user = DB_USER,
    password = DB_PASSWORD,
    port = DB_PORT
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