<?php

namespace Dao\Usuarios;

use Dao\Table;

class Usuarios extends Table
{
    public static function getUsuarios()
    {
        return self::obtenerRegistros(
            "SELECT usercod, useremail, username, userfching, userpswdest, userpswdexp, userest, usertipo
             FROM usuario ORDER BY usercod DESC",
            []
        );
    }

    public static function getUsuarioById(int $id)
    {
        return self::obtenerUnRegistro(
            "SELECT usercod, useremail, username, userfching, userpswdest, userpswdexp, userest, usertipo
             FROM usuario WHERE usercod = :id",
            ["id" => $id]
        );
    }
}
