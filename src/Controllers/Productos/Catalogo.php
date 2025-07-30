<?php

namespace Controllers\Productos;

use Controllers\PrivateController;
use Dao\Productos\Productos as ProductosDAO;
use Views\Renderer;

class Catalogo extends PrivateController
{
    public function run(): void
    {
        $q = $_GET["q"] ?? "";
        $productos = ProductosDAO::getProducts(); // <--- corregido aquí

        if (!empty($q)) {
            $q = strtolower($q);
            $productos = array_filter($productos, function ($prod) use ($q) {
                return stripos($prod["productName"], $q) !== false ||
                       stripos($prod["productDescription"], $q) !== false ||
                       stripos($prod["categoria_nombre"] ?? '', $q) !== false;
            });
        }

        Renderer::render("productos/catalogo", [
            "productos" => $productos,
            "q" => $_GET["q"] ?? ""
        ]);
    }
}


