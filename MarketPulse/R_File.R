library(rvest)
library(tidyverse)
library(syuzhet)
library(DBI)
library(RMariaDB)
library(lubridate)

con <- dbConnect(
  RMariaDB::MariaDB(),
  dbname = "market_engine",
  host = "localhost",
  port = 3306,
  user = "root",
  password = "root"
)