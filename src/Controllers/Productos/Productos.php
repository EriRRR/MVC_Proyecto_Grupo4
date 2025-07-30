<?php

namespace Controllers\Productos;

use Controllers\PrivateController;
use Dao\Productos\Productos as ProductosDAO;
use Views\Renderer;

class Productos extends PrivateController
{
    private array $viewData = [];

    public function __construct()
    {
        parent::__construct();

        $this->viewData["isNewEnabled"] = parent::isFeatureAutorized($this->name . "\\new");
        $this->viewData["isUpdateEnabled"] = parent::isFeatureAutorized($this->name . "\\update");
        $this->viewData["isDeleteEnabled"] = parent::isFeatureAutorized($this->name . "\\delete");
    }

    public function run(): void
    {
        $filtro = $_GET["q"] ?? "";
        $productos = ProductosDAO::getProducts();

        if (!empty($filtro)) {
            $productos = array_filter($productos, function ($producto) use ($filtro) {
                return stripos($producto["productName"], $filtro) !== false ||
                       stripos($producto["productDescription"], $filtro) !== false;
            });
        }

        $this->viewData["productos"] = $productos;
        $this->viewData["q"] = $filtro;

        Renderer::render("productos/productos", $this->viewData);
    }
}
