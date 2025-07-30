<?php

namespace Controllers;

use \Dao\Productos\Productos as ProductosDao;
use \Views\Renderer;
use \Utilities\Site;

class HomeController extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/products.css");
        
        $viewData = [];
        $viewData["catalogo"] = ProductosDao::getCatalog(); // Muestra todo lo activo

        Renderer::render("home", $viewData); // Asegúrate que esta vista exista
    }
}



