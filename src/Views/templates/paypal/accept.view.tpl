<h1>Orden Aceptada</h1>
<hr/>
<pre>
========================================
              FACTURA DE PAGO
========================================

ID de Orden       : {{order_id}}
Estado            : {{status}}
Fecha de Pago     : {{payment_date}}

------ DATOS DEL PAGADOR ------
Nombre            : {{payer_name}}
Email             : {{payer_email}}

------ DIRECCIÓN DE ENVÍO ------
Dirección         : {{shipping_address.address_line_1}}
Ciudad            : {{shipping_address.admin_area_2}}
Departamento      : {{shipping_address.admin_area_1}}
Código Postal     : {{shipping_address.postal_code}}
País              : {{shipping_address.country_code}}

------ PRODUCTOS COMPRADOS ------
{{foreach productos}}
- {{productName}} (x{{crrctd}}) - L {{crrprc}} c/u
{{endfor productos}}

------ DETALLES DE PAGO --------
ID de Pago        : {{payment_id}}
Monto             : {{amount}} {{currency}}

========================================
         TOTAL PAGADO: {{amount}} {{currency}}
========================================

Gracias por su compra.
</pre>

<div style="text-align: center; margin-top: 1.5rem;">
  <a href="index.php?page=Index" style="display: inline-block; padding: 0.5rem 1rem; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px;">
    Regresar al inicio
  </a>
</div>










