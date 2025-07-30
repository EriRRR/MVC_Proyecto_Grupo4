<?php

namespace Dao\Categorias;

use Dao\Table;

class Categorias extends Table
{
    public static function getCategorias()
    {
        $sqlstr = "SELECT * from categorias;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getCategoriaById(int $id)
    {
        $sqlstr = "SELECT * from categorias where id = :id;";
        return self::obtenerUnRegistro($sqlstr, ["id" => $id]);
    }

    public static function nuevaCategoria(string $nombre, string $descripcion, string $estado)
    {
        $sqlstr = "INSERT INTO categorias (nombre, descripcion, estado) VALUES (:nombre, :descripcion, :estado);";
        return self::executeNonQuery(
            $sqlstr,
            [
                "nombre" => $nombre,
                "descripcion" => $descripcion,
                "estado" => $estado
            ]
        );
    }

    public static function actualizarCategoria(int $id, string $nombre, string $descripcion, string $estado)
    {
        $sqlstr = "UPDATE categorias set nombre = :nombre, descripcion = :descripcion, estado = :estado where id = :id;";
        return self::executeNonQuery(
            $sqlstr,
            [
                "id" => $id,
                "nombre" => $nombre,
                "descripcion" => $descripcion,
                "estado" => $estado
            ]
        );
    }

    public static function eliminarCategoria(int $id): string
    {
        $sqlstr = "DELETE from categorias where id = :id;";
        return self::executeNonQuery(
            $sqlstr,
            [
                "id" => $id
            ]
        );
    }
}
