CREATE TABLE product_sentiment (
id INT AUTO_INCREMENT PRIMARY KEY,
product_name TEXT,
price FLOAT,
review_text TEXT,
sentiment_score FLOAT,
recommendation VARCHAR(20),
scrape_time DATETIME
);