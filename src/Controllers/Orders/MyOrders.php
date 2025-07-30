<?php
namespace Controllers\Orders;

use Controllers\PrivateController;
use Dao\Cart\Cart;
use Utilities\Security;

class MyOrders extends PrivateController
{
    public function __construct()
    {
        $this->name = "Orders-MyOrders"; // Nombre para autorización en PrivateController
        parent::__construct();
    }

    public function run(): void
    {
        $userId = Security::getUserId();
        $orders = Cart::getOrdersByUser($userId);
        \Views\Renderer::render("orders/myorders", ["orders" => $orders]);
    }
}
