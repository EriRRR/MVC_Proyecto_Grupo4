CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    orderId VARCHAR(255) NOT NULL,
    status VARCHAR(50),
    amount DECIMAL(12,2),
    currency VARCHAR(10),
    payerName VARCHAR(255),
    payerEmail VARCHAR(255),
    createTime DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_userId(userId)
);