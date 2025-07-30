<section class="depth-2 px-2 py-2">
    <h2>Mantenimiento de Productos</h2>
</section>

<form method="get" action="index.php">
    <input type="hidden" name="page" value="Productos-Productos" />
    <input type="text" name="q" placeholder="Buscar productos..." value="{{q}}" />
    <button type="submit">Buscar</button>
</form>

<section class="WWList my-4">
    <table>
        <thead>
            <tr>
                <th align="center">Id</th>
                <th align="center">Nombre</th>
                <th align="center">Descripción</th>
                <th align="center">Precio</th>
                <th align="center">Stock</th>
                <th align="center">Categoría</th>
                <th align="center">Proveedor</th>
                <th align="center">Estado</th>
                <th align="center">
                    {{if isNewEnabled}}
                    <a href="index.php?page=Productos-Producto&mode=INS&id=">
                        Nuevo
                    </a>
                    {{endif isNewEnabled}}
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach productos}}
            <tr>
                <td align="center">{{productId}}</td>
                <td align="center">{{productName}}</td>
                <td align="center">{{productDescription}}</td>
                <td align="center">{{productPrice}}</td>
                <td align="center">{{productStock}}</td>
                <td align="center">{{categoria_nombre}}</td>
                <td align="center">{{proveedor_nombre}}</td>
                <td align="center">{{productStatus}}</td>
                <td align="center">
                    <a href="index.php?page=Productos-Producto&mode=DSP&id={{productId}}">👁️</a>&nbsp;
                    {{if ~isUpdateEnabled}}
                    <a href="index.php?page=Productos-Producto&mode=UPD&id={{productId}}">✏️</a>&nbsp;
                    {{endif ~isUpdateEnabled}}
                    {{if ~isDeleteEnabled}}
                    <a href="index.php?page=Productos-Producto&mode=DEL&id={{productId}}">🗑️</a>
                    {{endif ~isDeleteEnabled}}
                </td>
            </tr>
            {{endfor productos}}
        </tbody>
    </table>
</section>
