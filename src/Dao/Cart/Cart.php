<?php

namespace Dao\Cart;
use Dao\Cart\Cart;
use Utilities\Security;



class Cart extends \Dao\Table
{
    public static function getProductosDisponibles()
    {
        $sqlAllProductosActivos = "SELECT * from products where productStatus in ('ACT');";
        $productosDisponibles = self::obtenerRegistros($sqlAllProductosActivos, array());

        //Sacar el stock de productos con carretilla autorizada
        $deltaAutorizada = \Utilities\Cart\CartFns::getAuthTimeDelta();
        $sqlCarretillaAutorizada = "select productId, sum(crrctd) as reserved
            from carretilla where TIME_TO_SEC(TIMEDIFF(now(), crrfching)) <= :delta
            group by productId;";
        $prodsCarretillaAutorizada = self::obtenerRegistros(
            $sqlCarretillaAutorizada,
            array("delta" => $deltaAutorizada)
        );
        //Sacar el stock de productos con carretilla no autorizada
        $deltaNAutorizada = \Utilities\Cart\CartFns::getUnAuthTimeDelta();
        $sqlCarretillaNAutorizada = "select productId, sum(crrctd) as reserved
            from carretillaanon where TIME_TO_SEC(TIMEDIFF(now(), crrfching)) <= :delta
            group by productId;";
        $prodsCarretillaNAutorizada = self::obtenerRegistros(
            $sqlCarretillaNAutorizada,
            array("delta" => $deltaNAutorizada)
        );
        $productosCurados = array();
        foreach ($productosDisponibles as $producto) {
            if (!isset($productosCurados[$producto["productId"]])) {
                $productosCurados[$producto["productId"]] = $producto;
            }
        }
        foreach ($prodsCarretillaAutorizada as $producto) {
            if (isset($productosCurados[$producto["productId"]])) {
                $productosCurados[$producto["productId"]]["productStock"] -= $producto["reserved"];
            }
        }
        foreach ($prodsCarretillaNAutorizada as $producto) {
            if (isset($productosCurados[$producto["productId"]])) {
                $productosCurados[$producto["productId"]]["productStock"] -= $producto["reserved"];
            }
        }
        $productosDisponibles = null;
        $prodsCarretillaAutorizada = null;
        $prodsCarretillaNAutorizada = null;
        return $productosCurados;
    }

    public static function getProductoDisponible($productId)
    {
        $sqlAllProductosActivos = "SELECT * from products where productStatus in ('ACT') and productId=:productId;";
        $productosDisponibles = self::obtenerRegistros($sqlAllProductosActivos, array("productId" => $productId));

        //Sacar el stock de productos con carretilla autorizada
        $deltaAutorizada = \Utilities\Cart\CartFns::getAuthTimeDelta();
        $sqlCarretillaAutorizada = "select productId, sum(crrctd) as reserved
            from carretilla where productId=:productId and TIME_TO_SEC(TIMEDIFF(now(), crrfching)) <= :delta
            group by productId;";
        $prodsCarretillaAutorizada = self::obtenerRegistros(
            $sqlCarretillaAutorizada,
            array("productId" => $productId, "delta" => $deltaAutorizada)
        );
        //Sacar el stock de productos con carretilla no autorizada
        $deltaNAutorizada = \Utilities\Cart\CartFns::getUnAuthTimeDelta();
        $sqlCarretillaNAutorizada = "select productId, sum(crrctd) as reserved
            from carretillaanon where productId = :productId and TIME_TO_SEC(TIMEDIFF(now(), crrfching)) <= :delta
            group by productId;";
        $prodsCarretillaNAutorizada = self::obtenerRegistros(
            $sqlCarretillaNAutorizada,
            array("productId" => $productId, "delta" => $deltaNAutorizada)
        );
        $productosCurados = array();
        foreach ($productosDisponibles as $producto) {
            if (!isset($productosCurados[$producto["productId"]])) {
                $productosCurados[$producto["productId"]] = $producto;
            }
        }
        foreach ($prodsCarretillaAutorizada as $producto) {
            if (isset($productosCurados[$producto["productId"]])) {
                $productosCurados[$producto["productId"]]["productStock"] -= $producto["reserved"];
            }
        }
        foreach ($prodsCarretillaNAutorizada as $producto) {
            if (isset($productosCurados[$producto["productId"]])) {
                $productosCurados[$producto["productId"]]["productStock"] -= $producto["reserved"];
            }
        }
        $productosDisponibles = null;
        $prodsCarretillaAutorizada = null;
        $prodsCarretillaNAutorizada = null;
        return $productosCurados[$productId];
    }


    public static function addToAnonCart(
        int $productId,
        string $anonCod,
        int $amount,
        float $price
    ) {
        $validateSql = "SELECT * from carretillaanon where anoncod = :anoncod and productId = :productId";
        $producto = self::obtenerUnRegistro($validateSql, ["anoncod" => $anonCod, "productId" => $productId]);
        if ($producto) {
            $updateSql = "UPDATE carretillaanon set crrctd = crrctd + 1 where anoncod = :anoncod and productId = :productId";
            return self::executeNonQuery($updateSql, ["anoncod" => $anonCod, "productId" => $productId]);
        } else {
            return self::executeNonQuery(
                "INSERT INTO carretillaanon (anoncod, productId, crrctd, crrprc, crrfching) VALUES (:anoncod, :productId, :crrctd, :crrprc, NOW());",
                ["anoncod" => $anonCod, "productId" => $productId, "crrctd" => $amount, "crrprc" => $price]
            );
        }
    }

    public static function getAnonCart(string $anonCod)
    {
        return self::obtenerRegistros("SELECT a.*, b.crrctd, b.crrprc, b.crrfching FROM products a inner join carretillaanon b on a.productId = b.productId where b.anoncod=:anoncod;", ["anoncod" => $anonCod]);
    }

    public static function getAuthCart(int $usercod)
    {
        return self::obtenerRegistros("SELECT a.*, b.crrctd, b.crrprc, b.crrfching FROM products a inner join carretilla b on a.productId = b.productId where b.usercod=:usercod;", ["usercod" => $usercod]);
    }

    public static function addToAuthCart(
        int $productId,
        int $usercod,
        int $amount,
        float $price
    ) {
        $validateSql = "SELECT * from carretilla where usercod = :usercod and productId = :productId";
        $producto = self::obtenerUnRegistro($validateSql, ["usercod" => $usercod, "productId" => $productId]);
        if ($producto) {
            $updateSql = "UPDATE carretilla set crrctd = crrctd + 1 where usercod = :usercod and productId = :productId";
            return self::executeNonQuery($updateSql, ["usercod" => $usercod, "productId" => $productId]);
        } else {
            return self::executeNonQuery(
                "INSERT INTO carretilla (usercod, productId, crrctd, crrprc, crrfching) VALUES (:usercod, :productId, :crrctd, :crrprc, NOW());",
                ["usercod" => $usercod, "productId" => $productId, "crrctd" => $amount, "crrprc" => $price]
            );
        }
    }

    public static function moveAnonToAuth(
        string $anonCod,
        int $usercod
    ) {
        $sqlstr = "INSERT INTO carretilla (userCod, productId, crrctd, crrprc, crrfching)
        SELECT :usercod, productId, crrctd, crrprc, NOW() FROM carretillaanon where anoncod = :anoncod
        ON DUPLICATE KEY UPDATE carretilla.crrctd = carretilla.crrctd + carretillaanon.crrctd;";

        $deleteSql = "DELETE FROM carretillaanon where anoncod = :anoncod;";
        self::executeNonQuery($sqlstr, ["anoncod" => $anonCod, "usercod" => $usercod]);
        self::executeNonQuery($deleteSql, ["anoncod" => $anonCod]);
    }

    public static function getProducto($productId)
    {
        $sqlAllProductosActivos = "SELECT * from products where productId=:productId;";
        $productosDisponibles = self::obtenerRegistros($sqlAllProductosActivos, array("productId" => $productId));
        return $productosDisponibles;
    }


  public static function deleteFromAuthCart($productId, $usercod)
{
    $sql = "DELETE FROM carretilla WHERE usercod = :usercod AND productId = :productId";
    return self::executeNonQuery($sql, ["usercod" => $usercod, "productId" => $productId]);
}

public static function deleteFromAnonCart($productId, $anonCod)
{
    $sql = "DELETE FROM carretillaanon WHERE anoncod = :anonCod AND productId = :productId";
    return self::executeNonQuery($sql, ["anonCod" => $anonCod, "productId" => $productId]);
}

public static function removeFromCart($usercodOrAnon, $productId, $isLogged)
{
    if ($isLogged) {
        $sql = "DELETE FROM carretilla WHERE usercod = :usercod AND productId = :productId";
        return self::executeNonQuery($sql, [
            "usercod" => $usercodOrAnon,
            "productId" => $productId
        ]);
    } else {
        $sql = "DELETE FROM carretillaanon WHERE anoncod = :anoncod AND productId = :productId";
        return self::executeNonQuery($sql, [
            "anoncod" => $usercodOrAnon,
            "productId" => $productId
        ]);
    }
}


public static function confirmarCompra(int $usercod)
{
    $productos = self::getAuthCart($usercod);

    foreach ($productos as $producto) {
        $sql = "UPDATE products 
                SET productStock = productStock - :cantidad 
                WHERE productId = :productId AND productStock >= :cantidad;";
        self::executeNonQuery($sql, [
            "cantidad" => $producto["crrctd"],
            "productId" => $producto["productId"]
        ]);
    }

    // Limpiar el carrito tras la compra
    $sqlVaciar = "DELETE FROM carretilla WHERE usercod = :usercod;";
    self::executeNonQuery($sqlVaciar, [
        "usercod" => $usercod
    ]);
}


public static function getAllOrders(): array
{
    $sql = "SELECT o.*, u.username, u.useremail 
            FROM orders o
            INNER JOIN usuario u ON o.userId = u.usercod
            ORDER BY o.createTime DESC;";
    return self::obtenerRegistros($sql, []);
}





public static function guardarOrdenPaypal(int $userId, object $result)
{
    // Convertir la fecha ISO 8601 a formato MySQL compatible
    $createTimeIso = $result->purchase_units[0]->payments->captures[0]->create_time;
    $createTime = date('Y-m-d H:i:s', strtotime($createTimeIso));

    $sqlInsert = "INSERT INTO orders (
        userId, orderId, status, amount, currency, payerName, payerEmail, createTime
    ) VALUES (
        :userId, :orderId, :status, :amount, :currency, :payerName, :payerEmail, :createTime
    );";

    $params = [
        "userId" => $userId,
        "orderId" => $result->id,
        "status" => $result->status,
        "amount" => $result->purchase_units[0]->payments->captures[0]->amount->value,
        "currency" => $result->purchase_units[0]->payments->captures[0]->amount->currency_code,
        "payerName" => $result->payer->name->given_name . ' ' . $result->payer->name->surname,
        "payerEmail" => $result->payer->email_address,
        "createTime" => $createTime,
    ];

    return self::executeNonQuery($sqlInsert, $params);
}

// Devuelve órdenes de un usuario
public static function getOrdersByUser($userId)
{
    $sqlstr = "SELECT * FROM orders WHERE userId = :userId ORDER BY createTime DESC;";
    return self::obtenerRegistros($sqlstr, ["userId" => $userId]);
}



    
}

