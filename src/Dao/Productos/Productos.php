<?php

namespace Dao\Productos;

use Dao\Table;

class Productos extends Table
{
    public static function getProducts()
    {
        $sqlstr = "SELECT p.*, c.nombre as categoria_nombre, pr.nombre as proveedor_nombre
                   FROM products p
                   LEFT JOIN categorias c ON p.categoryId = c.id
                   LEFT JOIN proveedores pr ON p.providerId = pr.id
                   ORDER BY p.productId;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getProductById(int $id)
    {
        $sqlstr = "SELECT * FROM products WHERE productId = :id;";
        return self::obtenerUnRegistro($sqlstr, ["id" => $id]);
    }

    public static function nuevoProduct(
        string $productName,
        string $productDescription,
        float $productPrice,
        int $productStock,
        ?int $categoryId,
        string $productStatus,
        ?int $providerId,
        ?string $imagen = null
    )
    {
        $sqlstr = "INSERT INTO products 
            (productName, productDescription, productPrice, productStock, categoryId, productStatus, providerId, imagen)
            VALUES
            (:productName, :productDescription, :productPrice, :productStock, :categoryId, :productStatus, :providerId, :imagen);";

        return self::executeNonQuery(
            $sqlstr,
            [
                "productName" => $productName,
                "productDescription" => $productDescription,
                "productPrice" => $productPrice,
                "productStock" => $productStock,
                "categoryId" => $categoryId,
                "productStatus" => $productStatus,
                "providerId" => $providerId,
                "imagen" => $imagen
            ]
        );
    }

    public static function actualizarProduct(
        int $productId,
        string $productName,
        string $productDescription,
        float $productPrice,
        int $productStock,
        ?int $categoryId,
        string $productStatus,
        ?int $providerId,
        ?string $imagen = null
    )
    {
        if ($imagen !== null && $imagen !== '') {
            $sqlstr = "UPDATE products
                       SET productName = :productName,
                           productDescription = :productDescription,
                           productPrice = :productPrice,
                           productStock = :productStock,
                           categoryId = :categoryId,
                           productStatus = :productStatus,
                           providerId = :providerId,
                           imagen = :imagen
                       WHERE productId = :productId;";
            $params = [
                "productId" => $productId,
                "productName" => $productName,
                "productDescription" => $productDescription,
                "productPrice" => $productPrice,
                "productStock" => $productStock,
                "categoryId" => $categoryId,
                "productStatus" => $productStatus,
                "providerId" => $providerId,
                "imagen" => $imagen
            ];
        } else {
            $sqlstr = "UPDATE products
                       SET productName = :productName,
                           productDescription = :productDescription,
                           productPrice = :productPrice,
                           productStock = :productStock,
                           categoryId = :categoryId,
                           productStatus = :productStatus,
                           providerId = :providerId
                       WHERE productId = :productId;";
            $params = [
                "productId" => $productId,
                "productName" => $productName,
                "productDescription" => $productDescription,
                "productPrice" => $productPrice,
                "productStock" => $productStock,
                "categoryId" => $categoryId,
                "productStatus" => $productStatus,
                "providerId" => $providerId
            ];
        }
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function eliminarProduct(int $productId)
    {
        $sqlstr = "DELETE FROM products WHERE productId = :productId;";
        return self::executeNonQuery($sqlstr, ["productId" => $productId]);
    }

public static function getCatalog()
{
    $sql = "SELECT p.*, c.nombre as categoria_nombre
            FROM products p
            LEFT JOIN categorias c ON p.categoryId = c.id
            WHERE productStatus = 'ACT'";
    return self::obtenerRegistros($sql, []);
}



    public static function buscarCatalogo(string $filtro)
    {
        $sql = "SELECT p.*, c.nombre as categoria_nombre
                FROM products p
                LEFT JOIN categorias c ON p.categoryId = c.id
                WHERE productStatus = 'ACT'
                  AND (productName LIKE :filtro OR productDescription LIKE :filtro)";
        $params = [
            "filtro" => "%" . $filtro . "%"
        ];
        return self::obtenerRegistros($sql, $params);
    }



public static function getProductDetailById(int $id)
{
    $sqlstr = "SELECT p.*, c.nombre as categoria_nombre, pr.nombre as proveedor_nombre
               FROM products p
               LEFT JOIN categorias c ON p.categoryId = c.id
               LEFT JOIN proveedores pr ON p.providerId = pr.id
               WHERE p.productId = :id;";
    return self::obtenerUnRegistro($sqlstr, ["id" => $id]);
}





}




