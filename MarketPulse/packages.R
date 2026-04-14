# Install packages if missing

required_packages <- c(
  "rvest",
  "tidyverse",
  "syuzhet",
  "DBI",
  "RMariaDB",
  "lubridate"
)

install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

invisible(lapply(required_packages, install_if_missing))