<?php

namespace Controllers\Proveedores;

use Controllers\PrivateController;
use Dao\Proveedores\Proveedores as ProveedoresDAO;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;
use Utilities\Security;

const LIST_URL = "index.php?page=Proveedores-Proveedores";
const XSR_KEY = "xsrToken_proveedores";

class Proveedor extends PrivateController
{
    private array $viewData;
    private array $modes;

    public function __construct()
    {
        $this->modes = [
            "INS" => 'Nuevo Proveedor',
            "UPD" => 'Editando Proveedor %s',
            "DEL" => 'Eliminando Proveedor %s',
            "DSP" => 'Detalle Proveedor %s'
        ];
        $this->viewData = [
            "id" => 0,
            "nombre" => "",
            "contacto" => "",
            "telefono" => "",
            "correo" => "",
            "direccion" => "",
            "estado" => "activo",  // valor por defecto
            "mode" => "",
            "modeDsc" => "",
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

        if ($this->viewData["mode"] !== "INS") {
            $this->cargarDatosProveedor();
        }

        if ($this->isPostBack()) {
            $this->datosFormulario();
            $this->validarDatos();

            if (count($this->viewData["errores"]) === 0) {
                $this->procesarDatos();
            }
        }

        $this->prepararVista();
        Renderer::render("proveedores/proveedor", $this->viewData);
    }

    private function capturarModoPantalla()
    {
        if (isset($_GET["mode"])) {
            $this->viewData["mode"] = $_GET["mode"];
            if (!isset($this->modes[$this->viewData["mode"]])) {
                Site::redirectToWithMsg(LIST_URL, "Solicitud no válida.");
            }
        }
    }

    private function cargarDatosProveedor()
    {
        if (isset($_GET["id"])) {
            $this->viewData["id"] = $_GET["id"];
            $proveedor = ProveedoresDAO::getProveedorById($this->viewData["id"]);
            if ($proveedor) {
                foreach ($proveedor as $key => $value) {
                    $this->viewData[$key] = $value;
                }
            } else {
                Site::redirectToWithMsg(LIST_URL, "Proveedor no encontrado.");
            }
        } else {
            Site::redirectToWithMsg(LIST_URL, "Solicitud incompleta.");
        }
    }

    private function datosFormulario()
    {
        // Incluimos 'estado' para capturar ese dato del formulario
        foreach (["id", "nombre", "contacto", "telefono", "correo", "direccion", "estado", "xsrToken"] as $campo) {
            if (isset($_POST[$campo])) {
                $this->viewData[$campo] = trim(strtolower($_POST[$campo]));
            }
        }
    }

    private function validarDatos()
    {
        if (Validators::IsEmpty($this->viewData["nombre"])) {
            $this->viewData["errores"]["nombre"] = "Nombre es requerido";
        }

        // Validar que el estado sea uno de los permitidos
        if (!in_array($this->viewData["estado"], ["activo", "inactivo"])) {
            $this->viewData["estado"] = "activo"; // valor por defecto seguro
        }

        $tokenEsperado = $_SESSION[XSR_KEY] ?? '';
        if ($this->viewData["xsrToken"] !== $tokenEsperado) {
            Site::redirectToWithMsg(LIST_URL, "Solicitud inválida.");
        }
    }

    private function procesarDatos()
    {
        switch ($this->viewData["mode"]) {
            case "INS":
                if (ProveedoresDAO::nuevoProveedor(
                    $this->viewData["nombre"],
                    $this->viewData["contacto"],
                    $this->viewData["telefono"],
                    $this->viewData["correo"],
                    $this->viewData["direccion"]
                )) {
                    Site::redirectToWithMsg(LIST_URL, "Proveedor creado.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al crear proveedor"];
                }
                break;

            case "UPD":
                $data = [
                    "id" => $this->viewData["id"],
                    "nombre" => $this->viewData["nombre"],
                    "contacto" => $this->viewData["contacto"],
                    "telefono" => $this->viewData["telefono"],
                    "correo" => $this->viewData["correo"],
                    "direccion" => $this->viewData["direccion"],
                    "estado" => $this->viewData["estado"] // Valor validado y correcto
                ];

                if (ProveedoresDAO::actualizarProveedor($data)) {
                    Site::redirectToWithMsg(LIST_URL, "Proveedor actualizado.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al actualizar proveedor"];
                }
                break;

            case "DEL":
                if (ProveedoresDAO::eliminarProveedor($this->viewData["id"])) {
                    Site::redirectToWithMsg(LIST_URL, "Proveedor eliminado.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al eliminar proveedor"];
                }
                break;
        }
    }

    private function prepararVista()
    {
        $this->viewData["modeDsc"] = sprintf(
            $this->modes[$this->viewData["mode"]],
            $this->viewData["id"]
        );

        if ($this->viewData["mode"] === "INS") {
            $this->viewData["idreadonly"] = "";
        }
        if ($this->viewData["mode"] === "DEL" || $this->viewData["mode"] === "DSP") {
            $this->viewData["readonly"] = "readonly";
        }
        if ($this->viewData["mode"] === "DSP") {
            $this->viewData["showAction"] = false;
        }

        $this->viewData["xsrToken"] = hash("sha256", random_int(0, 1000000) . time() . 'proveedor' . $this->viewData["mode"]);
        $_SESSION[XSR_KEY] = $this->viewData["xsrToken"];
    }
}
