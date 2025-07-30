CREATE TABLE products (
    productId INT(11) NOT NULL AUTO_INCREMENT,
    productName VARCHAR(255) NOT NULL,
    productDescription TEXT NOT NULL,
    productPrice DECIMAL(10, 2) NOT NULL,
    imagen VARCHAR(255) DEFAULT NULL, -- URL o ruta de imagen
    productStock INT(11) NOT NULL DEFAULT 0,
    productStatus ENUM('ACT', 'INA', 'DSC') NOT NULL DEFAULT 'ACT', -- Estado: Activo, Inactivo, Descontinuado
    categoryId INT DEFAULT NULL,
    providerId INT DEFAULT NULL,
    productCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES categorias(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (providerId) REFERENCES proveedores(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
