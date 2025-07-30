<?php
namespace Controllers\Categorias;

use Controllers\PrivateController;
use Dao\Categorias\Categorias as CategoriasDAO;
use Views\Renderer;

class Categorias extends PrivateController
{
    private array $viewData;

    public function __construct()
    {
        parent::__construct();

        $this->viewData = [];

        $this->viewData["isNewEnabled"] = parent::isFeatureAutorized($this->name . "\\new");
        $this->viewData["isUpdateEnabled"] = parent::isFeatureAutorized($this->name . "\\update");
        $this->viewData["isDeleteEnabled"] = parent::isFeatureAutorized($this->name . "\\delete");
    }

    public function run(): void
    {
        $this->viewData["categorias"] = CategoriasDAO::getCategorias();
        Renderer::render("categorias/categorias", $this->viewData);
    }
}


