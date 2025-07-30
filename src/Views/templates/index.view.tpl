<section class="depth-2 px-4 py-4" 
  style="display: flex; justify-content: space-between; align-items: center; background-color: #f8f9fa; padding: 1rem 2rem; border-bottom: 2px solid #ddd;">
  <h2 style="margin: 0; font-size: 2rem; color: #333; font-weight: 600; font-family: Arial, sans-serif;">
    🛍️ Catálogo de Productos
  </h2>



  <a href="index.php?page=Cart-Show" style="text-decoration: none; font-size: 1.5rem; position: relative; color: #333;">
    🛒
    <span style="
      position: absolute;
      top: -10px;
      right: -12px;
      background: red;
      color: white;
      border-radius: 50%;
      padding: 2px 6px;
      font-size: 0.75rem;
      font-weight: bold;
      min-width: 20px;
      text-align: center;
      line-height: 1;
    ">
      {{if ~CART_ITEMS}}{{~CART_ITEMS}}{{endif ~CART_ITEMS}}
    </span>
  </a>
</section>

<section style="text-align: center; margin: 2rem 0 1.5rem 0;">
  <form action="index.php" method="get" style="display: inline-flex; gap: 0.5rem; align-items: center;">
    <input type="hidden" name="page" value="index" />
    <input 
      type="text" 
      name="q" 
      placeholder="Buscar productos..." 
      value="{{q}}" 
      style="padding: 0.5rem 1rem; font-size: 1rem; border: 1px solid #ccc; border-radius: 6px; width: 300px;" 
      autocomplete="off"
    />
    <button 
      type="submit" 
      style="background-color: #58eb4bff; color: white; border: none; padding: 0.5rem 1rem; font-size: 1rem; border-radius: 6px; cursor: pointer;"
    >
      Buscar
    </button>
  </form>
</section>




<section class="grid px-4 py-4" style="display: flex; flex-wrap: wrap; gap: 2rem; justify-content: center; padding: 2rem;">
  {{foreach products}}
  <div class="card" style="width: 240px; border: 1px solid #ddd; border-radius: 12px; padding: 1rem; box-shadow: 0 4px 12px rgba(0,0,0,0.1); display: flex; flex-direction: column; align-items: center; background-color: #fff; transition: transform 0.3s;">
    
    <div style="width: 220px; height: 220px; background-color: #f0f0f0; overflow: hidden; display: flex; align-items: center; justify-content: center; border-radius: 8px;">
      {{if imagen}}
        <img src="uploads/productos/{{imagen}}" alt="{{productName}}" style="width: 100%; height: 100%; object-fit: cover; display: block;" />
      {{else}}
        <div style="color:#aaa;"></div>
      {{endif imagen}}
    </div>
    
<div style="margin-top: 1rem; text-align: center;">
  <h3 style="font-size: 1.2rem; margin: 0 0 0.5rem; color: #222;">{{productName}}</h3>
  <p style="margin: 0.25rem 0; color: #555;"><strong>💰 Precio:</strong> L {{productPrice}}</p>
  <p style="margin: 0.25rem 0; color: #555;"><strong>📦 Stock:</strong> {{productStock}}</p>
  <form action="index.php?page=index" method="post" style="margin-top: 0.75rem;">
    <input type="hidden" name="productId" value="{{productId}}">
    <button type="submit" name="addToCart" style="
      background-color: #28a745;
      color: white;
      border: none;
      padding: 0.5rem 1rem;
      font-size: 1rem;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s;
    ">+ Agregar al Carrito</button>
  </form>
  <a href="index.php?page=Productos-ProductoDetalle&id={{productId}}" 
   style="margin-top: 0.5rem; display: inline-block; color: #007bff; cursor: pointer;">
   Ver detalle
</a>
</div>

  </div>
  {{endfor products}}
</section>
