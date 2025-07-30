<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Utilities\Security;

class Accept extends PublicController
{
    public function run(): void
    {
        $dataview = array();
        $token = $_GET["token"] ?? "";
        $session_token = $_SESSION["orderid"] ?? "";

        if ($token !== "" && $token == $session_token) {
            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $result = $PayPalRestApi->captureOrder($session_token);

            if (is_array($result)) {
                $result = json_decode(json_encode($result));
            }

            // Guardar orden
            \Dao\Cart\Cart::guardarOrdenPaypal(Security::getUserId(), $result);

            // Obtener productos antes de confirmar la compra
            $productos = \Dao\Cart\Cart::getAuthCart(Security::getUserId());
            $dataview["productos"] = $productos;

            // Confirmar compra: actualizar stock y limpiar carrito
            \Dao\Cart\Cart::confirmarCompra(Security::getUserId());

            // Extraer datos para la factura
            $order = $result;
            $purchaseUnit = $order->purchase_units[0];
            $capture = $purchaseUnit->payments->captures[0];

            $dataview["order_id"] = $order->id;
            $dataview["status"] = $order->status;
            $dataview["payer_name"] = $order->payer->name->given_name . " " . $order->payer->name->surname;
            $dataview["payer_email"] = $order->payer->email_address;
            $dataview["amount"] = $capture->amount->value;
            $dataview["currency"] = $capture->amount->currency_code;
            $dataview["payment_id"] = $capture->id;
            $dataview["payment_date"] = date('Y-m-d H:i:s', strtotime($capture->create_time));
            $dataview["shipping_address"] = $purchaseUnit->shipping->address;

        } else {
            $dataview["error"] = "No Order Available!!!";
        }

        \Views\Renderer::render("paypal/accept", $dataview);
    }
}
