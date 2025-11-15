-- Createing Database
CREATE DATABASE Zomato_analysis;

-- Use Database
USE Zomato_analysis;


-- 1. Restaurants
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    area VARCHAR(100),
    cost_for_two INT,
    avg_rating DECIMAL(3,2),
    is_veg BOOLEAN,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Cuisines
CREATE TABLE cuisines (
    cuisine_id INT AUTO_INCREMENT PRIMARY KEY,
    cuisine_name VARCHAR(100) NOT NULL
);

-- 3. Restaurant–Cuisine Mapping
CREATE TABLE restaurant_cuisines (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    cuisine_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (cuisine_id) REFERENCES cuisines(cuisine_id)
);

-- 4. Customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255),
    phone VARCHAR(20),
    city VARCHAR(100),
    registered_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 5. Menu Items
CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(255),
    price DECIMAL(10,2),
    is_veg BOOLEAN,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- 6. Orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_time DATETIME,
    total_amount DECIMAL(10,2),
    payment_mode VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- 7. Order Items
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

-- 8. Ratings
CREATE TABLE ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    rating INT,
    review TEXT,
    rating_time DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

