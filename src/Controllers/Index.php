<?php

/**
 * PHP Version 7.2
 *
 * @category Public
 * @package  Controllers
 */

namespace Controllers;

use Dao\Cart\Cart;
use Utilities\Site;
use Utilities\Cart\CartFns;
use Utilities\Security;

/**
 * Index Controller
 *
 * @category Public
 * @package  Controllers
 */
class Index extends PublicController
{
    /**
     * Index run method
     *
     * @return void
     */
    public function run(): void
    {
        // Agregar CSS para productos
        Site::addLink("public/css/products.css");

        // Procesar envío de formulario (agregar al carrito)
        if ($this->isPostBack()) {
            if (Security::isLogged()) {
                $usercod = Security::getUserId();
                $productId = intval($_POST["productId"]);
                $product = Cart::getProductoDisponible($productId);
                if ($product["productStock"] - 1 >= 0) {
                    Cart::addToAuthCart(
                        $productId,
                        $usercod,
                        1,
                        $product["productPrice"]
                    );
                }
            } else {
                $cartAnonCod = CartFns::getAnnonCartCode();
                if (isset($_POST["addToCart"])) {
                    $productId = intval($_POST["productId"]);
                    $product = Cart::getProductoDisponible($productId);
                    if ($product["productStock"] - 1 >= 0) {
                        Cart::addToAnonCart(
                            $productId,
                            $cartAnonCod,
                            1,
                            $product["productPrice"]
                        );
                    }
                }
            }
            $this->getCartCounter();
        }

       
        $q = $_GET["q"] ?? "";

        
        $products = Cart::getProductosDisponibles();

       
        if (!empty($q)) {
            $products = array_filter($products, function ($p) use ($q) {
                return stripos($p["productName"], $q) !== false ||
                       stripos($p["productDescription"], $q) !== false;
            });
        }

        
        $viewData = [
            "products" => $products,
            "q" => $q
        ];

       
        \Views\Renderer::render("index", $viewData);
    }
}
