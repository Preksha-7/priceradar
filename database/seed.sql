-- Test users (passwords are all "password123" hashed with bcrypt)
INSERT IGNORE INTO users (email, password_hash, email_notifications) VALUES
('test@example.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TiGqTlNnSJBLDJn4.yH6GwRKfKm2', TRUE),
('demo@example.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TiGqTlNnSJBLDJn4.yH6GwRKfKm2', TRUE);

-- Test products (real Amazon products for reference)
INSERT IGNORE INTO products (name, category, asin, amazon_url, current_price) VALUES
('boAt Rockerz 450 Bluetooth Headphones', 'Electronics', 'B07QDLW94W',
 'https://www.amazon.in/dp/B07QDLW94W', 1299.00),
('Xiaomi 11i HyperCharge 5G Smartphone', 'Smartphones', 'B09W2KXNT9',
 'https://www.amazon.in/dp/B09W2KXNT9', 24999.00),
('Prestige IRIS 750 W Mixer Grinder', 'Appliances', 'B00GKXO47M',
 'https://www.amazon.in/dp/B00GKXO47M', 2195.00);

-- Fake price history for the headphones (last 30 days)
INSERT IGNORE INTO price_history (product_id, price, mrp, discount_percent, scraped_at) VALUES
(1, 1499.00, 3000.00, 50.03, DATE_SUB(NOW(), INTERVAL 30 DAY)),
(1, 1450.00, 3000.00, 51.67, DATE_SUB(NOW(), INTERVAL 25 DAY)),
(1, 1399.00, 3000.00, 53.37, DATE_SUB(NOW(), INTERVAL 20 DAY)),
(1, 1350.00, 3000.00, 55.00, DATE_SUB(NOW(), INTERVAL 15 DAY)),
(1, 1299.00, 3000.00, 56.70, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(1, 1199.00, 3000.00, 60.03, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(1, 1299.00, 3000.00, 56.70, DATE_SUB(NOW(), INTERVAL 1 DAY));

-- Fake price history for the smartphone
INSERT IGNORE INTO price_history (product_id, price, mrp, discount_percent, scraped_at) VALUES
(2, 26999.00, 29999.00, 10.00, DATE_SUB(NOW(), INTERVAL 30 DAY)),
(2, 25999.00, 29999.00, 13.33, DATE_SUB(NOW(), INTERVAL 20 DAY)),
(2, 25499.00, 29999.00, 15.00, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(2, 24999.00, 29999.00, 16.67, DATE_SUB(NOW(), INTERVAL 1 DAY));

-- Link test user to tracked products with target prices
INSERT IGNORE INTO tracked_products (user_id, product_id, target_price, is_active) VALUES
(1, 1, 1000.00, TRUE),
(1, 2, 22000.00, TRUE),
(1, 3, 1800.00, TRUE);

-- One sample alert
INSERT IGNORE INTO alerts (user_id, product_id, message, current_price, is_read) VALUES
(1, 1, 'boAt Rockerz 450 dropped to ₹1,199 — your target is ₹1,000', 1199.00, FALSE);