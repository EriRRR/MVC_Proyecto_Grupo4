<section class="grid py-4 px-4 my-4" style="display: flex; justify-content: center;">
  <form method="post" action="index.php?page=Proveedores-Proveedor&mode={{mode}}&id={{id}}" 
        style="display: flex; flex-direction: column; gap: 0.5rem; width: 100%; max-width: 400px;">

    <input type="hidden" name="xsrToken" value="{{xsrToken}}" />

    <label>ID</label>
    <input type="text" name="id" value="{{id}}" readonly />

    <label>Nombre</label>
    <input type="text" name="nombre" value="{{nombre}}" {{readonly}} />
    {{if error_nombre}}
      <span class="error">{{error_nombre}}</span>
    {{endif error_nombre}}

    <label>Contacto</label>
    <input type="text" name="contacto" value="{{contacto}}" {{readonly}} />

    <label>Teléfono</label>
    <input type="text" name="telefono" value="{{telefono}}" {{readonly}} />

    <label>Correo</label>
    <input type="email" name="correo" value="{{correo}}" {{readonly}} />

    <label>Dirección</label>
    <textarea name="direccion" {{readonly}}>{{direccion}}</textarea>

    <label>Estado</label>
    <select name="estado" {{readonly}}>
      <option value="activo" {{estadoactivo}}>Activo</option>
      <option value="inactivo" {{estadoinactivo}}>Inactivo</option>
    </select>

    {{if showAction}}
      <button class="primary" type="submit">Confirmar</button>
    {{endif showAction}}

    <button id="btnCancel" type="button">Cancelar</button>
  </form>
</section>

<script>
  document.getElementById("btnCancel").addEventListener("click", function (e) {
    e.preventDefault();
    window.location = "index.php?page=Proveedores-Proveedores";
  });
</script>
