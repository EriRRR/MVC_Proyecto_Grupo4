<section class="depth-2 px-4 py-4">
  <h2>Catálogo de Productos</h2>

  <form method="get" action="index.php" style="text-align: center; margin-bottom: 1.5rem;">
    <input type="hidden" name="page" value="Productos-Catalogo" />
    <input type="text" name="q" placeholder="Buscar productos..." value="{{q}}" style="padding: 0.5rem; width: 250px;" />
    <button type="submit" style="padding: 0.5rem;">Buscar</button>
  </form>
</section>

<section class="grid px-4 py-4" style="display: flex; flex-wrap: wrap; gap: 1.5rem; justify-content: center;">
  {{foreach productos}}
  <div class="card" style="width: 220px; border: 1px solid #ccc; border-radius: 10px; padding: 1rem; box-shadow: 0 0 8px rgba(0,0,0,0.1); display: flex; flex-direction: column; align-items: center;">

    <div style="width: 200px; height: 200px; background-color: #fafafa; overflow: hidden; display: flex; align-items: center; justify-content: center;">
      {{if imagen}}
        <img src="uploads/productos/{{imagen}}" alt="{{productName}}" style="width: 100%; height: 100%; object-fit: cover; display: block;" />
      {{else}}
        <div style="color:#aaa;"></div>
      {{endif imagen}}
    </div>

    <div style="margin-top: 1rem; text-align: center;">
      <h3 style="font-size: 1.1rem; margin: 0 0 0.25rem;">{{productName}}</h3>
      <p style="margin: 0.25rem 0;"><strong>Categoría:</strong> {{categoria_nombre}}</p>
      <p style="margin: 0.25rem 0;"><strong>Precio:</strong> L {{productPrice}}</p>
      <p style="margin: 0.25rem 0;"><strong>Stock:</strong> {{productStock}}</p>
      <button type="button" class="primary" style="margin-top: 0.5rem; width: 100%;">Añadir al carrito</button>
    </div>
  </div>
  {{endfor productos}}
</section>

