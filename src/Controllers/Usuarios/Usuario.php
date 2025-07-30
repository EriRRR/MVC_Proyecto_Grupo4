<?php

namespace Controllers\Usuarios;

use Controllers\PrivateController;
use Dao\Usuarios\Usuarios as UsuariosDAO;
use Utilities\Site;
use Views\Renderer;

const LIST_URL = "index.php?page=Usuarios-Usuarios";

class Usuario extends PrivateController
{
    private array $viewData;

    public function __construct()
    {
        $this->viewData = [
            "usercod" => 0,
            "useremail" => "",
            "username" => "",
            "userfching" => "",
            "userpswdest" => "",
            "userpswdexp" => "",
            "userest" => "",
            "usertipo" => "",
            "mode" => "DSP",
            "modeDsc" => "Detalle Usuario %s",
            "readonly" => "readonly",
            "showAction" => false,
        ];
    }

    public function run(): void
    {
        if (!isset($_GET["mode"]) || $_GET["mode"] !== "DSP") {
            Site::redirectToWithMsg(LIST_URL, "Modo inválido.");
        }

        if (!isset($_GET["id"])) {
            Site::redirectToWithMsg(LIST_URL, "Falta ID.");
        }

        $this->viewData["usercod"] = intval($_GET["id"]);

        $usuario = UsuariosDAO::getUsuarioById($this->viewData["usercod"]);
        if (!$usuario) {
            Site::redirectToWithMsg(LIST_URL, "Usuario no encontrado.");
        }

        foreach ($usuario as $key => $value) {
            $this->viewData[$key] = $value;
        }

        $this->viewData["modeDsc"] = sprintf($this->viewData["modeDsc"], $this->viewData["usercod"]);

        Renderer::render("usuarios/usuario", $this->viewData);
    }
}
