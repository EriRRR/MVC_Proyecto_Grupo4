<?php

namespace Controllers\Usuarios;

use Controllers\PrivateController;
use Dao\Usuarios\Usuarios as UsuariosDAO;
use Views\Renderer;

class Usuarios extends PrivateController
{
    private array $viewData;

    public function __construct()
    {
        parent::__construct();

        $this->viewData = [
            "usuarios" => [],
            "isNewEnabled" => false,
            "isUpdateEnabled" => false,
            "isDeleteEnabled" => false,
        ];
    }

    public function run(): void
    {
        $this->viewData["usuarios"] = UsuariosDAO::getUsuarios();
        Renderer::render("usuarios/usuarios", $this->viewData);
    }
}
