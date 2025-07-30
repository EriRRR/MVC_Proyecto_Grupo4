<section class="depth-2 px-4 py-4" style="text-align: center;">
  <h2 style="font-size: 2rem; color: #333;">🛒 Carrito de Compras</h2>
</section>

<section class="px-4 py-4" style="display: flex; justify-content: center;">
  <div style="width: 100%; max-width: 900px; background-color: #fff; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
  
    {{if productos}}
    <table style="width: 100%; border-collapse: collapse; text-align: center;">
      <thead>
        <tr style="background-color: #f8f8f8; border-bottom: 2px solid #ddd;">
          <th style="padding: 0.75rem;">Producto</th>
          <th>Cantidad</th>
          <th>Precio</th>
          <th>Subtotal</th>
          <th>Acción</th>
        </tr>
      </thead>
      <tbody>
        {{foreach productos}}
        <tr style="border-bottom: 1px solid #eee;">
          <td style="padding: 0.75rem;">{{productName}}</td>
          <td>{{crrctd}}</td>
          <td>L {{crrprc}}</td>
          <td>L {{subtotal}}</td>
          <td>
            <form method="post" action="index.php?page=Cart_Show">
              <input type="hidden" name="productId" value="{{productId}}">
              <input type="hidden" name="action" value="delete">
              <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 0.4rem 0.8rem; border-radius: 6px; cursor: pointer; font-weight: bold;">
                🗑️
              </button>
            </form>
          </td>
        </tr>
        {{endfor productos}}
      </tbody>
    </table>

    <div style="text-align: right; margin-top: 1.5rem; font-size: 1.3rem;">
      <strong>Total: <span style="color: #2c3e50;">L {{total}}</span></strong>
    </div>

    {{else}}
      <p style="text-align: center; font-size: 1.2rem; color: #888;"></p>
    {{endif productos}}
    <form action="index.php?page=checkout_checkout" method="post">
   <button type="submit" style="background-color: #27ae60; color: white; border: none; padding: 0.6rem 1.2rem; border-radius: 8px; cursor: pointer; font-weight: 700; font-size: 1rem; transition: background-color 0.3s ease;">
  Place Order
</button>

  </div>
</section>

