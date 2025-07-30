<?php

namespace Dao\Proveedores;

use Dao\Table;

class Proveedores extends Table
{
    public static function getProveedores()
    {
        return self::obtenerRegistros("SELECT * FROM proveedores ORDER BY id DESC", []);
    }

    public static function getProveedorById(int $id)
    {
        return self::obtenerUnRegistro("SELECT * FROM proveedores WHERE id = :id", ["id" => $id]);
    }
public static function nuevoProveedor(string $nombre, string $contacto, string $telefono, string $correo, string $direccion)
{
    $sqlstr = "INSERT INTO proveedores (nombre, contacto, telefono, correo, direccion)
               VALUES (:nombre, :contacto, :telefono, :correo, :direccion);";
    return self::executeNonQuery($sqlstr, [
        "nombre" => $nombre,
        "contacto" => $contacto,
        "telefono" => $telefono,
        "correo" => $correo,
        "direccion" => $direccion
    ]);
}

    public static function actualizarProveedor($data)
    {
        return self::executeNonQuery(
            "UPDATE proveedores SET nombre = :nombre, contacto = :contacto, telefono = :telefono,
            correo = :correo, direccion = :direccion, estado = :estado WHERE id = :id",
            $data
        );
    }

    public static function eliminarProveedor(int $id)
    {
        return self::executeNonQuery("DELETE FROM proveedores WHERE id = :id", ["id" => $id]);
    }
}
