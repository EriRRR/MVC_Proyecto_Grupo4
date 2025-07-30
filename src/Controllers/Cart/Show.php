<?php

namespace Controllers\Cart;

use Controllers\PublicController;
use Dao\Cart\Cart;
use Utilities\Cart\CartFns;
use Utilities\Security;
use Views\Renderer;

class Show extends PublicController
{
    public function run(): void
    {
        $productos = [];
        $total = 0;

        if ($this->isPostBack()) {
            $productId = intval($_POST["productId"]);
            $action = $_POST["action"] ?? "";

            if ($action === "delete") {
                if (Security::isLogged()) {
                    Cart::removeFromCart(Security::getUserId(), $productId, true);
                } else {
                    Cart::removeFromCart(CartFns::getAnnonCartCode(), $productId, false);
                }
            }
        }

        if (Security::isLogged()) {
            $productos = Cart::getAuthCart(Security::getUserId());
        } else {
            $productos = Cart::getAnonCart(CartFns::getAnnonCartCode());
        }

        foreach ($productos as &$producto) {
            $producto["subtotal"] = number_format($producto["crrctd"] * $producto["crrprc"], 2);
            $total += $producto["crrctd"] * $producto["crrprc"];
            $producto["crrprc"] = number_format($producto["crrprc"], 2);
        }

        $viewData = [
            "productos" => $productos,
            "total" => number_format($total, 2)
        ];

        Renderer::render("cart/show", $viewData);
    }
}

