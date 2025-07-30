<section class="depth-2 px-2 py-2">
  <h2>Lista de Proveedores</h2>
</section>

<section class="WWList my-4">
{{if isNewEnabled}}
<div style="text-align: right; margin-bottom: 10px;">
  <a href="index.php?page=Proveedores-Proveedor&mode=INS&id=" style="padding: 6px 12px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px;">
    + Nuevo Proveedor
  </a>
</div>
{{endif isNewEnabled}}


  <table>
    <thead>
      <tr>
        <th align="center">ID</th>
        <th align="center">Nombre</th>
        <th align="center">Contacto</th>
        <th align="center">Teléfono</th>
        <th align="center">Estado</th>
        <th align="center">Acciones</th>
      </tr>
    </thead>
    <tbody>
      {{foreach proveedores}}
      <tr>
        <td align="center">{{id}}</td>
        <td align="center">{{nombre}}</td>
        <td align="center">{{contacto}}</td>
        <td align="center">{{telefono}}</td>
        <td align="center">{{estado}}</td>
        <td align="center">
          <a href="index.php?page=Proveedores-Proveedor&mode=DSP&id={{id}}">👁️</a>
          {{if ~isUpdateEnabled}}
          <a href="index.php?page=Proveedores-Proveedor&mode=UPD&id={{id}}">✏️</a>
          {{endif ~isUpdateEnabled}}
          {{if ~isDeleteEnabled}}
          <a href="index.php?page=Proveedores-Proveedor&mode=DEL&id={{id}}">🗑️</a>
          {{endif ~isDeleteEnabled}}
        </td>
      </tr>
      {{endfor proveedores}}
    </tbody>
  </table>
</section>



