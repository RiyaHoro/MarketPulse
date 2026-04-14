# Real-Time Web Scraping & Market Sentiment Engine

## Overview

The **Real-Time Web Scraping & Market Sentiment Engine** is a data pipeline built with **R** that automatically collects product data from websites, analyzes review sentiment, stores historical results in **MySQL**, and visualizes trends through an **R Shiny dashboard**.

The system helps determine whether a product is worth purchasing based on the sentiment of recent reviews and price trends.

This project demonstrates concepts from **data engineering, web scraping, sentiment analysis, database integration, and data visualization**.

---

## System Architecture

Website → Web Scraping (rvest) → Data Processing → Sentiment Analysis → MySQL Database → Shiny Dashboard

---

## Features

* Web scraping of product information from HTML pages
* Extraction of:

  * Product name
  * Price
  * Review text
* Sentiment analysis using the **syuzhet** package
* Automatic **BUY / AVOID recommendation**
* Historical data storage using **MySQL**
* Interactive **R Shiny dashboard**
* Visualization of:

  * Sentiment trends
  * Price trends
  * Product recommendation

---

## Tech Stack

| Component            | Technology |
| -------------------- | ---------- |
| Programming Language | R          |
| Web Scraping         | rvest      |
| Data Processing      | tidyverse  |
| Sentiment Analysis   | syuzhet    |
| Database             | MySQL      |
| Dashboard            | Shiny      |
| Version Control      | GitHub     |

---

## Project Structure

```
MarketPulse
│
├── scraper.R              # Extracts product data from websites
├── sentiment_engine.R     # Performs sentiment analysis
├── database.R             # Handles MySQL connection and storage
├── run_pipeline.R         # Runs the full data pipeline
│
├── dashboard
│   └── app.R              # Shiny dashboard application
│
└── README.md
```

---

## Database Schema

Table: **product_sentiment**

| Column          | Description                   |
| --------------- | ----------------------------- |
| id              | Unique record ID              |
| product_name    | Name of the product           |
| price           | Product price                 |
| review_text     | Extracted review text         |
| sentiment_score | Sentiment score from analysis |
| recommendation  | BUY or AVOID                  |
| scrape_time     | Timestamp of scraping         |

---

## Installation

### 1. Install R packages

```
install.packages(c(
"rvest",
"tidyverse",
"syuzhet",
"DBI",
"RMariaDB",
"shiny",
"ggplot2"
))
```

---

### 2. Configure MySQL Environment Variables

```
Sys.setenv(MYSQL_HOST="localhost")
Sys.setenv(MYSQL_USER="root")
Sys.setenv(MYSQL_PASSWORD="root")
Sys.setenv(MYSQL_DATABASE="market_engine")
```

---

### 3. Run the Data Pipeline

```
source("run_pipeline.R")
```

This will:

* scrape product data
* analyze sentiment
* store results in MySQL

---

### 4. Run the Dashboard

```
shiny::runApp("dashboard")
```

The dashboard will open in your browser.

---

## Dashboard Visualizations

The Shiny dashboard includes:

* Product sentiment table
* Sentiment trend over time
* Price trend analysis
* Current BUY / AVOID recommendation

---

## Example Workflow

1. Scraper collects product data from a website.
2. Sentiment engine analyzes review text.
3. Results are stored in MySQL.
4. Dashboard reads database data.
5. Users visualize trends and recommendations.

---

## Learning Outcomes

This project demonstrates practical experience with:

* Web scraping
* Text mining
* Sentiment analysis
* Database integration
* Data pipelines
* Dashboard development
* Version control using GitHub

---

## Future Improvements

* Support for multiple websites
* Automatic scheduled scraping using GitHub Actions
* Real-time dashboard refresh
* Sentiment gauge visualization
* Advanced sentiment models

---

## Author

Riya Horo

B.Tech Computer Science Engineering

---
