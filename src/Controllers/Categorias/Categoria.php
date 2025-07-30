<?php

namespace Controllers\Categorias;

use Controllers\PrivateController;
use Dao\Categorias\Categorias as CategoriasDAO;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;
use Utilities\Security;

const LIST_URL = "index.php?page=Categorias-Categorias";
const XSR_KEY = "xsrToken_categorias";

class Categoria extends PrivateController
{
    private array $viewData;
    private array $estados;
    private array $modes;

    public function __construct()
    {
        $this->modes = [
            "INS" => 'Creando nueva Categoría',
            "UPD" => 'Modificando Categoría %s %s',
            "DEL" => 'Eliminando Categoría %s %s',
            "DSP" => 'Mostrando Detalle de %s %s'
        ];
        $this->estados = ["activo", "inactivo"];
        $this->viewData = [
            "id" => 0,
            "nombre" => "",
            "descripcion" => "",
            "estado" => "activo",
            "mode" => "",
            "modeDsc" => "",
            "estadoactivo" => "",
            "estadoinactivo" => "",
            "errores" => [],
            "readonly" => "",
            "showAction" => true,
            "xsrToken" => "",
            "idreadonly" => "readonly",
        ];
    }

    public function run(): void
    {
        
   
        $this->capturarModoPantalla();
        $this->datosDeDao();

        if ($this->isPostBack()) {
            $this->datosFormulario();
            $this->validarDatos();

            if (count($this->viewData["errores"]) === 0) {
                $this->procesarDatos();
            }
        }

        $this->prepararVista();
        Renderer::render("categorias/categoria", $this->viewData);
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
                $this->viewData["id"] = $_GET["id"];
                $categoria = CategoriasDAO::getCategoriaById($this->viewData["id"]);
                if (count($categoria) > 0) {
                    $this->viewData["nombre"] = $categoria["nombre"];
                    $this->viewData["descripcion"] = $categoria["descripcion"];
                    $this->viewData["id"] = $categoria["id"];
                    $this->viewData["estado"] = $categoria["estado"];
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
        if (isset($_POST["id"])) {
            $this->viewData["id"] = $_POST["id"];
        }
        if (isset($_POST["nombre"])) {
            $this->viewData["nombre"] = $_POST["nombre"];
        }
        if (isset($_POST["descripcion"])) {
            $this->viewData["descripcion"] = $_POST["descripcion"];
        }
        if (isset($_POST["estado"])) {
            $this->viewData["estado"] = $_POST["estado"];
        }
        if (isset($_POST["xsrToken"])) {
            $this->viewData["xsrToken"] = $_POST["xsrToken"];
        }
    }

    private function validarDatos()
    {
        if (Validators::IsEmpty($this->viewData["nombre"])) {
            $this->viewData["errores"]["nombre"] = "El nombre es requerido";
        }

        if (!in_array($this->viewData["estado"], $this->estados)) {
            $this->viewData["errores"]["estado"] = "El valor del estado no es correcto";
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
                    CategoriasDAO::nuevaCategoria(
                        $this->viewData["nombre"],
                        $this->viewData["descripcion"],
                        $this->viewData["estado"]
                    ) > 0
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Categoría agregada exitosamente.");
                } else {
                    $this->viewData["errores"]["global"][] = "Error al crear la nueva categoría.";
                }
                break;

            case "UPD":
                if (
                    CategoriasDAO::actualizarCategoria(
                        $this->viewData["id"],
                        $this->viewData["nombre"],
                        $this->viewData["descripcion"],
                        $this->viewData["estado"]
                    )
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Categoría actualizada exitosamente.");
                } else {
                    $this->viewData["errores"]["global"][] = "Error al actualizar la categoría.";
                }
                break;

            case "DEL":
                if (
                    CategoriasDAO::eliminarCategoria($this->viewData["id"])
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Categoría eliminada exitosamente.");
                } else {
                    $this->viewData["errores"]["global"][] = "Error al eliminar la categoría.";
                }
                break;
        }
    }

    private function prepararVista()
    {
        $this->viewData["modeDsc"] = sprintf(
            $this->modes[$this->viewData["mode"]],
            $this->viewData["nombre"],
            $this->viewData["id"]
        );
        $this->viewData["estado" . $this->viewData["estado"]] = 'selected';

        if (count($this->viewData["errores"]) > 0) {
            foreach ($this->viewData["errores"] as $campo => $error) {
                $this->viewData['error_' . $campo] = $error;
            }
        }

        if ($this->viewData["mode"] === "INS") {
            $this->viewData["idreadonly"] = "";
        }

        if (in_array($this->viewData["mode"], ["DEL", "DSP"])) {
            $this->viewData["readonly"] = "readonly";
        }

        if ($this->viewData["mode"] === "DSP") {
            $this->viewData["showAction"] = false;
        }

        // Solo generar nuevo token si no es POST
        if (!$this->isPostBack()) {
            $this->viewData["xsrToken"] = hash("sha256", random_int(0, 1000000) . time() . 'categoria' . $this->viewData["mode"]);
            $_SESSION[XSR_KEY] = $this->viewData["xsrToken"];
        } else {
            $this->viewData["xsrToken"] = $_SESSION[XSR_KEY] ?? '';
        }
    }
}
