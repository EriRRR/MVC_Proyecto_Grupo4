<?php

namespace Controllers\Productos;

use Controllers\PublicController;
use Dao\Productos\Productos;
use Views\Renderer;
use Utilities\Site;

class ProductoDetalle extends PublicController
{
    private array $viewData = [];

    public function run(): void
    {
        if (!isset($_GET["id"]) || !ctype_digit($_GET["id"])) {
            Site::redirectToWithMsg("index.php?page=Productos-Productos", "Producto no válido.");
            return;
        }

        $productId = intval($_GET["id"]);
        $producto = Productos::getProductDetailById($productId);

        if (!$producto) {
            Site::redirectToWithMsg("index.php?page=Productos-Productos", "Producto no encontrado.");
            return;
        }

        $this->viewData = $producto;
        Renderer::render("productos/producto-detalle", $this->viewData);
    }
}
