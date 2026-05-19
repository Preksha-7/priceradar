-- The table that stores information about the user
CREATE TABLE IF NOT EXISTS users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email_notifications BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- The table that stores information about the products entered by users
CREATE TABLE IF NOT EXISTS products(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(500) NOT NULL,
    image_url TEXT,
    category VARCHAR(100),
    asin VARCHAR(20),
    amazon_url TEXT,
    current_price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- The table that stores price history for ML models
CREATE TABLE IF NOT EXISTS price_history(
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    mrp DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    in_stock BOOLEAN DEFAULT TRUE,
    scraped_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- The table to map users to tracked products
CREATE TABLE IF NOT EXISTS tracked_products(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    target_price DECIMAL(10,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    UNIQUE KEY unique_user_product (user_id, product_id)
);

-- Table storing information about alerts being sent to the user
CREATE TABLE IF NOT EXISTS alerts(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    message TEXT,
    current_price DECIMAL(10,2),
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Table to check health of each platform
CREATE TABLE IF NOT EXISTS platform_metadata(
    id INT AUTO_INCREMENT PRIMARY KEY,
    platform_name VARCHAR(255) NOT NULL UNIQUE,
    last_successful_scrape TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    failure_count INT DEFAULT 0
);

-- Table to list all the platforms (Only amazon for now)
INSERT IGNORE INTO platform_metadata (platform_name, is_active)
VALUES ('amazon', TRUE);
