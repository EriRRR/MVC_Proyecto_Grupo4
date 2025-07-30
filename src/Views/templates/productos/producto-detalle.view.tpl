<section style="padding: 1.5rem 2rem; background-color: #f8f9fa; border-bottom: 1px solid #ddd; display: flex; justify-content: space-between; align-items: center;">
  <h2 style="margin: 0; font-size: 2rem; color: #333;">Detalle del Producto</h2>
  <a href="index.php?page=Index" style="color: #007bff; text-decoration: none; font-size: 1rem;">← Volver al catálogo</a>
</section>

<section style="padding: 2rem; display: flex; flex-wrap: wrap; gap: 2rem; justify-content: center;">
  <div style="width: 260px; height: 260px; background-color: #fff; border: 1px solid #ccc; border-radius: 12px; display: flex; align-items: center; justify-content: center; overflow: hidden;">
    {{if imagen}}
      <img src="uploads/productos/{{imagen}}" alt="{{productName}}" style="width: 100%; height: 100%; object-fit: cover;" />
    {{else}}
      <span style="color: #aaa;"></span>
    {{endif imagen}}
  </div>

  <div style="max-width: 500px;">
    <h3 style="font-size: 1.6rem; color: #222; margin-bottom: 1rem;">🧾 {{productName}}</h3>
    <p style="font-size: 1rem; margin-bottom: 0.5rem; color: #444;"><em>{{productDescription}}</em></p>
    <p style="font-size: 1rem; margin-bottom: 0.5rem;"><strong>Precio:</strong> L {{productPrice}}</p>
    <p style="font-size: 1rem; margin-bottom: 0.5rem;"><strong>Stock:</strong> {{productStock}}</p>
    <p style="font-size: 1rem; margin-bottom: 0.5rem;"><strong>Categoría:</strong> {{categoria_nombre}}</p>
    <p style="font-size: 1rem;"><strong>Proveedor:</strong> {{proveedor_nombre}}</p>
  </div>
</section>





