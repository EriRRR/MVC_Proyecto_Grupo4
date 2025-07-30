<?php

namespace Controllers\Proveedores;

use Controllers\PrivateController;
use Dao\Proveedores\Proveedores as ProveedoresDAO;
use Views\Renderer;

class Proveedores extends PrivateController
{
    private array $viewData;

    public function __construct()
    {
        parent::__construct();

        $this->viewData = [];

        $this->viewData["isNewEnabled"] = parent::isFeatureAutorized($this->name . "\\new");
        $this->viewData["isUpdateEnabled"] = parent::isFeatureAutorized($this->name . "\\update");
        $this->viewData["isDeleteEnabled"] = parent::isFeatureAutorized($this->name . "\\delete");
    }

    public function run(): void
    {
        $this->viewData["proveedores"] = ProveedoresDAO::getProveedores();
        Renderer::render("proveedores/proveedores", $this->viewData);
    }
}

