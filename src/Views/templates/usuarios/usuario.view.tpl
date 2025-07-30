<section class="grid py-4 px-4 my-4" style="display: flex; justify-content: center;">
  <form style="display: flex; flex-direction: column; gap: 0.5rem; width: 100%; max-width: 400px;">

    <label>ID</label>
    <input type="text" name="usercod" value="{{usercod}}" readonly />

    <label>Correo</label>
    <input type="email" name="useremail" value="{{useremail}}" readonly />

    <label>Nombre</label>
    <input type="text" name="username" value="{{username}}" readonly />

    <label>Fecha Ingreso</label>
    <input type="text" name="userfching" value="{{userfching}}" readonly />

    <label>Estado</label>
    <input type="text" name="userest" value="{{userest}}" readonly />

    <label>Expiración Contraseña</label>
    <input type="text" name="userpswdexp" value="{{userpswdexp}}" readonly />

    <label>Tipo</label>
    <input type="text" name="usertipo" value="{{usertipo}}" readonly />

    <button id="btnCancel" type="button">Cancelar</button>
  </form>
</section>

<script>
  document.getElementById("btnCancel").addEventListener("click", function(e){
    e.preventDefault();
    window.location = "index.php?page=Usuarios-Usuarios";
  });
</script>
