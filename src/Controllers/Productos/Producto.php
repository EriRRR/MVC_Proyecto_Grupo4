<?php

namespace Controllers\Productos;

use Controllers\PrivateController;
use Dao\Productos\Productos as ProductosDAO;
use Dao\Categorias\Categorias as CategoriasDAO;
use Dao\Proveedores\Proveedores as ProveedoresDAO;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;
use Utilities\Security;


const LIST_URL = "index.php?page=Productos-Productos";
const XSR_KEY = "xsrToken_productos";

class Producto extends PrivateController
{
    private array $viewData;
    private array $estados;
    private array $modes;

    public function __construct()
    {
        $this->modes = [
            "INS" => 'Creando nuevo Producto',
            "UPD" => 'Modificando Producto %s %s',
            "DEL" => 'Eliminando Producto %s %s',
            "DSP" => 'Mostrando Detalle de %s %s'
        ];
        $this->estados = ["ACT", "INA", "DSC"];
        $this->viewData = [
            "productId" => 0,
            "productName" => "",
            "productDescription" => "",
            "productPrice" => "",
            "productStock" => "",
            "categoryId" => null,
            "providerId" => null,
            "productStatus" => "ACT",
            "categorias" => [],
            "proveedores" => [],
            "mode" => "",
            "modeDsc" => "",
            "error_productName" => "",
            "error_productPrice" => "",
            "error_productStock" => "",
            "error_categoryId" => "",
            "error_providerId" => "",
            "error_productStatus" => "",
            "errores" => [],
            "readonly" => "",
            "showAction" => true,
            "xsrToken" => "",
            "idreadonly" => "readonly",
            "imagen" => "",
            "error_imagen" => ""
        ];
    }

    public function run(): void
    {
        $this->capturarModoPantalla();

        $this->viewData["categorias"] = CategoriasDAO::getCategorias();
        $this->viewData["proveedores"] = ProveedoresDAO::getProveedores();

        $this->datosDeDao();

        if ($this->isPostBack()) {
            $this->datosFormulario();
            $this->validarDatos();

            if (count($this->viewData["errores"]) === 0) {
                $this->procesarDatos();
            }
        }

        $this->prepararVista();
        Renderer::render("productos/producto", $this->viewData);
    }

    private function throwError(string $message)
    {
        Site::redirectToWithMsg(LIST_URL, $message);
    }

    private function capturarModoPantalla()
    {
        if (isset($_GET["mode"])) {
            $this->viewData["mode"] = $_GET["mode"];
            if (!isset($this->modes[$this->viewData["mode"]])) {
                $this->throwError("BAD REQUEST: No se puede procesar su solicitud.");
            }
        }
    }

    private function datosDeDao()
    {
        if ($this->viewData["mode"] != "INS") {
            if (isset($_GET["id"])) {
                $this->viewData["productId"] = $_GET["id"];
               $producto = ProductosDAO::getProductById($this->viewData["productId"]);

                if ($producto) {
                    $this->viewData["productName"] = $producto["productName"];
                    $this->viewData["productDescription"] = $producto["productDescription"];
                    $this->viewData["productPrice"] = $producto["productPrice"];
                    $this->viewData["productStock"] = $producto["productStock"];
                    $this->viewData["categoryId"] = $producto["categoryId"];
                    $this->viewData["providerId"] = $producto["providerId"];
                    $this->viewData["productStatus"] = $producto["productStatus"];
                    $this->viewData["imagen"] = $producto["imagen"] ?? "";
                    $this->viewData["productId"] = $producto["productId"];
                } else {
                    $this->throwError("BAD REQUEST: No existe registro en la DB");
                }
            } else {
                $this->throwError("BAD REQUEST: No se puede extraer el registro de la DB");
            }
        }
    }

    private function datosFormulario()
    {
        $campos = [
            "productId", "productName", "productDescription", "productPrice", "productStock",
            "categoryId", "providerId", "productStatus", "xsrToken"
        ];

        foreach ($campos as $campo) {
            if (isset($_POST[$campo])) {
                $this->viewData[$campo] = $_POST[$campo];
            }
        }

        if (isset($_FILES["imagen"]) && $_FILES["imagen"]["error"] === UPLOAD_ERR_OK) {
            $nombreTmp = $_FILES["imagen"]["tmp_name"];
            $nombreOriginal = basename($_FILES["imagen"]["name"]);
            $extension = pathinfo($nombreOriginal, PATHINFO_EXTENSION);
            $nuevoNombre = uniqid("prod_", true) . "." . $extension;

            if (!move_uploaded_file($nombreTmp, "uploads/productos/" . $nuevoNombre)) {
                $this->viewData["errores"]["imagen"] = "No se pudo guardar la imagen";
                $this->viewData["imagen"] = "";
            } else {
                $this->viewData["imagen"] = $nuevoNombre;
            }
        } else {
            if ($this->viewData["mode"] === "UPD" && isset($_POST["imagen_anterior"])) {
                $this->viewData["imagen"] = $_POST["imagen_anterior"];
            } else {
                $this->viewData["imagen"] = "";
            }
        }
    }

   
    private function validarDatos()
    {
        if (Validators::IsEmpty($this->viewData["productName"])) {
            $this->viewData["errores"]["productName"] = "El nombre es requerido";
        }
        if (!is_numeric($this->viewData["productPrice"]) || floatval($this->viewData["productPrice"]) < 0) {
            $this->viewData["errores"]["productPrice"] = "El precio debe ser un número positivo";
        }
        if (!ctype_digit(strval($this->viewData["productStock"])) || intval($this->viewData["productStock"]) < 0) {
            $this->viewData["errores"]["productStock"] = "El stock debe ser un número entero positivo o cero";
        }
        if (!in_array($this->viewData["productStatus"], $this->estados)) {
            $this->viewData["errores"]["productStatus"] = "El valor del estado no es correcto";
        }
        $categoriaIds = array_column($this->viewData["categorias"], "id");
        if (!in_array($this->viewData["categoryId"], $categoriaIds)) {
            $this->viewData["errores"]["categoryId"] = "La categoría seleccionada no es válida";
        }
        $proveedorIds = array_column($this->viewData["proveedores"], "id");
        if (!in_array($this->viewData["providerId"], $proveedorIds)) {
            $this->viewData["errores"]["providerId"] = "El proveedor seleccionado no es válido";
        }
        $tmpXsrToken = $_SESSION[XSR_KEY] ?? '';
        if ($this->viewData["xsrToken"] !== $tmpXsrToken) {
            error_log("Intento ingresar con un token inválido.");
            $this->throwError("Algo sucedió que impidió procesar la solicitud. Intente de nuevo!!");
        }
    }

    private function procesarDatos()
    {
        switch ($this->viewData["mode"]) {
            case "INS":
                if (
                    ProductosDAO::nuevoProduct(
                        $this->viewData["productName"],
                        $this->viewData["productDescription"],
                        $this->viewData["productPrice"],
                        $this->viewData["productStock"],
                        $this->viewData["categoryId"],
                        $this->viewData["productStatus"],
                        $this->viewData["providerId"],
                        $this->viewData["imagen"]
                    ) > 0
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Producto agregado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al crear el nuevo producto."];
                }
                break;
            case "UPD":
                if (
                    ProductosDAO::actualizarProduct(
                        $this->viewData["productId"],
                        $this->viewData["productName"],
                        $this->viewData["productDescription"],
                        $this->viewData["productPrice"],
                        $this->viewData["productStock"],
                        $this->viewData["categoryId"],
                        $this->viewData["productStatus"],
                        $this->viewData["providerId"],
                        $this->viewData["imagen"]
                    )
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Producto actualizado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al actualizar el producto."];
                }
                break;
            case "DEL":
                if (
                    ProductosDAO::eliminarProduct(
                        $this->viewData["productId"]
                    )
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Producto eliminado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al eliminar el producto."];
                }
                break;
        }
    }

    private function prepararVista()
    {
        $this->viewData["modeDsc"] = sprintf(
            $this->modes[$this->viewData["mode"]],
            $this->viewData["productName"],
            $this->viewData["productId"]
        );

        $this->viewData["productStatus" . $this->viewData["productStatus"]] = 'selected';

        foreach ($this->viewData["categorias"] as &$categoria) {
            $categoria["selected"] = ($categoria["id"] == $this->viewData["categoryId"]) ? "selected" : "";
        }
        unset($categoria);

        foreach ($this->viewData["proveedores"] as &$prov) {
            $prov["selected"] = ($prov["id"] == $this->viewData["providerId"]) ? "selected" : "";
        }
        unset($prov);

        if (count($this->viewData["errores"]) > 0) {
            foreach ($this->viewData["errores"] as $campo => $error) {
                $this->viewData['error_' . $campo] = $error;
            }
        }

        if ($this->viewData["mode"] === "INS") {
            $this->viewData["idreadonly"] = "";
        }
        if ($this->viewData["mode"] === "DEL" ||  $this->viewData["mode"] === "DSP") {
            $this->viewData["readonly"] = "readonly";
        }
        if ($this->viewData["mode"] === "DSP") {
            $this->viewData["showAction"] = false;
        }

        $this->viewData["xsrToken"] = hash("sha256", random_int(0, 1000000) . time() . 'product' . $this->viewData["mode"]);
        $_SESSION[XSR_KEY] = $this->viewData["xsrToken"];
    }
}
