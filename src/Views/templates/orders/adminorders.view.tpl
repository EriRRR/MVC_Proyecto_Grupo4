<h2 style="text-align:center; font-family: Arial, sans-serif; color: #333;">Historial General de Compras</h2>
<table style="width:100%; border-collapse: collapse; font-family: Arial, sans-serif; margin: 0 auto; max-width: 1100px;">
  <thead>
    <tr style="background-color: #4CAF50; color: white;">
      <th style="padding: 12px; border: 1px solid #ddd;">ID Orden</th>
      <th style="padding: 12px; border: 1px solid #ddd;">Usuario</th>
      <th style="padding: 12px; border: 1px solid #ddd;">Nombre Pagador</th>
      <th style="padding: 12px; border: 1px solid #ddd;">Email</th>
      <th style="padding: 12px; border: 1px solid #ddd;">Monto</th>
      <th style="padding: 12px; border: 1px solid #ddd;">Moneda</th>
      <th style="padding: 12px; border: 1px solid #ddd;">Estado</th>
      <th style="padding: 12px; border: 1px solid #ddd;">Fecha</th>
    </tr>
  </thead>
  <tbody>
    {{foreach orders}}
    <tr style="text-align: center; border-bottom: 1px solid #ddd;">
      <td style="padding: 10px; border: 1px solid #ddd;">{{orderId}}</td>
      <td style="padding: 10px; border: 1px solid #ddd;">{{userId}}</td>
      <td style="padding: 10px; border: 1px solid #ddd; text-align: left;">{{payerName}}</td>
      <td style="padding: 10px; border: 1px solid #ddd; text-align: left;">{{payerEmail}}</td>
      <td style="padding: 10px; border: 1px solid #ddd;">L {{amount}}</td>
      <td style="padding: 10px; border: 1px solid #ddd;">{{currency}}</td>
      <td style="padding: 10px; border: 1px solid #ddd;">{{status}}</td>
      <td style="padding: 10px; border: 1px solid #ddd;">{{createTime}}</td>
    </tr>
    {{endfor orders}}
  </tbody>
</table>

