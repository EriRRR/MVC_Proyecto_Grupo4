<?php
namespace Controllers\Orders;

use Controllers\PrivateController;
use Dao\Cart\Cart;
use Utilities\Security;
use Utilities\Site;

class AdminOrders extends PrivateController
{
    public function run(): void
    {
        if (!Security::isInRol(Security::getUserId(), "Auditor")) {
            Site::redirectToWithMsg("index.php", "No tienes permisos para acceder a esta sección.");
            return;
        }

        $orders = Cart::getAllOrders();
        \Views\Renderer::render("orders/adminorders", ["orders" => $orders]);
    }
}
