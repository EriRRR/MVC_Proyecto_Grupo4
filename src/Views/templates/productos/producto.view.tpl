<section class="depth-2 px-2 py-2">
    <h2>{{modeDsc}}</h2>
</section>
<section class="grid py-4 px-4 my-4">
    <div class="row">
        <div class="col-12 offset-m-1 col-m-10 offset-l-3 col-l-6">
            <form class="row" action="index.php?page=Productos-Producto&mode={{mode}}&id={{productId}}" method="post" enctype="multipart/form-data">
                <div class="row">
                    <label for="productId" class="col-12 col-m-4">Id</label>
                    <input type="text" class="col-12 col-m-8" name="productId" id="productId" value="{{productId}}" {{idreadonly}}/>
                    <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
                </div>
                <div class="row">
                    <label for="productName" class="col-12 col-m-4">Nombre</label>
                    <input type="text" class="col-12 col-m-8" name="productName" id="productName" value="{{productName}}"  {{readonly}}/>
                    {{if error_productName}} 
                        <span class="error col-12 col-m-8">{{error_productName}}</span>
                    {{endif error_productName}}
                </div>
                <div class="row">
                    <label for="productDescription" class="col-12 col-m-4">Descripción</label>
                    <textarea class="col-12 col-m-8" name="productDescription" id="productDescription" {{readonly}}>{{productDescription}}</textarea>
                </div>
                <div class="row">
                    <label for="productPrice" class="col-12 col-m-4">Precio</label>
                    <input type="text" class="col-12 col-m-8" name="productPrice" id="productPrice" value="{{productPrice}}"  {{readonly}}/>
                    {{if error_productPrice}} 
                        <span class="error col-12 col-m-8">{{error_productPrice}}</span>
                    {{endif error_productPrice}}
                </div>
                <div class="row">
                    <label for="productStock" class="col-12 col-m-4">Stock</label>
                    <input type="text" class="col-12 col-m-8" name="productStock" id="productStock" value="{{productStock}}"  {{readonly}}/>
                    {{if error_productStock}} 
                        <span class="error col-12 col-m-8">{{error_productStock}}</span>
                    {{endif error_productStock}}
                </div>
                <div class="row">
                    <label for="categoryId" class="col-12 col-m-4">Categoría</label>
                    <select id="categoryId" name="categoryId"  {{if readonly}}readonly disabled{{endif readonly}} >
                        <option value="">-- Seleccione Categoría --</option>
                        {{foreach categorias}}
                            <option value="{{id}}" {{selected}}>{{nombre}}</option>
                        {{endfor categorias}}
                    </select>
                    {{if error_categoryId}} 
                        <span class="error col-12 col-m-8">{{error_categoryId}}</span>
                    {{endif error_categoryId}}
                </div>
                <div class="row">
                    <label for="providerId" class="col-12 col-m-4">Proveedor</label>
                    <select id="providerId" name="providerId" {{if readonly}}readonly disabled{{endif readonly}}>
                        <option value="">-- Seleccione Proveedor --</option>
                        {{foreach proveedores}}
                            <option value="{{id}}" {{selected}}>{{nombre}}</option>
                        {{endfor proveedores}}
                    </select>
                    {{if error_providerId}}
                        <span class="error col-12 col-m-8">{{error_providerId}}</span>
                    {{endif error_providerId}}
                </div>
                <div class="row">
                    <label for="productStatus" class="col-12 col-m-4">Estado</label>
                    <select id="productStatus" name="productStatus"  {{if readonly}}readonly disabled{{endif readonly}} >
                        <option value="ACT" {{productStatusACT}}>Activo</option>
                        <option value="INA" {{productStatusINA}}>Inactivo</option>
                        <option value="DSC" {{productStatusDSC}}>Descontinuado</option>
                    </select>
                    {{if error_productStatus}} 
                        <span class="error col-12 col-m-8">{{error_productStatus}}</span>
                    {{endif error_productStatus}}
                </div>
                <div class="row">
                    <label for="imagen" class="col-12 col-m-4">Imagen</label>
                    <input type="file" class="col-12 col-m-8" name="imagen" id="imagen" {{readonly}}/>
                    {{if imagen}}
                        <small>Imagen actual: {{imagen}}</small><br/>
                        <img src="uploads/productos/{{imagen}}" alt="Imagen producto" style="max-width:150px; max-height:150px;"/>
                        <input type="hidden" name="imagen_anterior" value="{{imagen}}" />
                    {{endif imagen}}
                    {{if error_imagen}} 
                        <span class="error col-12 col-m-8">{{error_imagen}}</span>
                    {{endif error_imagen}}
                </div>
                <div class="row flex-end">
                    <button id="btnCancel" type="button">
                        {{if showAction}}
                            Cancelar
                        {{endif showAction}}
                        {{ifnot showAction}}
                            Volver
                        {{endifnot showAction}}
                    </button>
                    &nbsp;
                    {{if showAction}}
                    <button class="primary" type="submit">Confirmar</button>
                    {{endif showAction}}
                </div>
                {{if error_global}}
                    {{foreach error_global}}
                        <div class="error col-12 col-m-8">{{this}}</div>
                    {{endfor error_global}}
                {{endif error_global}}
            </form>
        </div>
    </div>
</section>
<script>
    document.addEventListener("DOMContentLoaded", ()=>{
        document.getElementById("btnCancel").addEventListener("click", (e)=>{
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Productos-Productos");
        });
    });
</script>
