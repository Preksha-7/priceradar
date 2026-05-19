-- From the price_history table, lookup for a particular product
CREATE INDEX IF NOT EXISTS idx_price_history_product_id
ON price_history(product_id);

-- Price history sorted by time for charts
CREATE INDEX IF NOT EXISTS idx_price_history_scraped_at
ON price_history(product_id, scraped_at);

-- Tracked product by user for dashboard
CREATE INDEX IF NOT EXISTS idx_tracked_products_user_id
ON tracked_products(user_id);

-- Trackes products by product. Find all users tracking something
CREATE INDEX IF NOT EXISTS idx_tracked_products_product_id
ON tracked_products(product_id);

-- Alerts by users : track notifications
CREATE INDEX IF NOT EXISTS idx_alerts_user_id
ON alerts(user_id);

-- Unread alerts for fast lookup
CREATE INDEX IF NOT EXISTS idx_alerts_unread
ON alerts(user_id, is_read);

