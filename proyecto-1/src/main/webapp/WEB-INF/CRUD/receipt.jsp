<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.ReceiptEntity" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Compras de productos</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/crud_style.css">
    <style>

.dropdown:hover .dropdown-content {
      display: block;
      opacity: 1;
  }
    .dropdown-content {
      display: none;
      position: absolute;
      transition: opacity 0.3s ease-in-out;
      overflow: auto;
      width: 6%;
      box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
      border: 1px solid #00A4BD;
      background-color: #00A4BD;
  }

  .dropdown-content a {
      display: block;
      color: #000000;
      padding: 5px;
      text-decoration: none;
      
  }

  .dropdown-content a:hover {
      color: #FFFFFF;
      background-color: #00A4BD;
  }

  .dropdown-button {
    background-color: #00A4BD;
    color: #FFFFFF;
    padding: 5px;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s, color 0.3s;
}

/* Add a hover effect */
.dropdown-button:hover {
    background-color: #0084A0;
}
    </style>
    <script src="<%= request.getContextPath() %>/scripts/crud_script.js"></script> 
    <script>
        const columnNames = ['id', 'fecha', 'cliente_id', 'detalle_id', 'total', 'cantidad total', 'metodo de pago', 'descripcion', 'cantidad productos'];
        
        const pathName = '/CRUD/receipt';
        function populateProductsAmountDropdown(cell) {
  // Parse the JSON string into a JavaScript object
  var productsAmounts = JSON.parse(cell.querySelector(".json-content").textContent);

  for (var key in productsAmounts) {
    if (productsAmounts.hasOwnProperty(key)) {
      var link = document.createElement("a");

      // Create a link with the key as text and a custom URL (modify as needed)
      link.textContent = key + " : " + productsAmounts[key];
      link.href = "/CRUD/product?search=" + key; // Set your custom URL here

      // Append the option to the select
      cell.querySelector(".dropdown-content").appendChild(link);
    }
  }
}

document.addEventListener("DOMContentLoaded", function() {
    // Call your function here, e.g., toggleButtons
    var elem = document.querySelector(".dropdown");
    populateProductsAmountDropdown(elem);
  });

    </script>
</head>
<body>
    <div class="container">
    <h1>Gestion de Productos</h1>
    <div class="sub-header">
    <div class="user-button">
        <a href="/menu">
            USUARIO : <%= request.getAttribute("username") %>
        </a>
    </div>
    <div class="search-container">
        <form action="/CRUD/receipt" method="get">
        <input type="text" name="search" class="search-input" placeholder="Buscar...">
        <button type="submit" class="search-button">Buscar</button>
    </form>
    </div>
    <button class="add-button" onclick="showModal()">Agregar nuevo Producto compra</button>
    <div id="modal-content">
        <%@ include file="/WEB-INF/CRUD/receipt_add_modal.jsp" %>
    </div>

</div>
<table>
    <thead>
    <tr>
        <!-- const columnNames = ['id', 'fecha', 'cliente_id', 'detalle_id', 'total', 'cantidad total', 'metodo de pago', 'descripcion', 'cantidad productos'];-->
        <th>id</th>
        <th>fecha</th>
        <th>cliente_id</th>
        <th>detalle_id</th>
        <th>total</th>
        <th>cantidad total</th>
        <th>metodo de pago</th>
        <th>descripcion</th>
        <th>cantidad productos</th>
        <th style="width: 50px;"></th>
        <th style="width: 50px;"></th>
    </tr>
    </thead>
    <tbody>
        <%
            List<ReceiptEntity> receipts = (List<ReceiptEntity>) request.getAttribute("receipts");
            for (ReceiptEntity receipt : receipts) {
        %>
        <tr onclick="toggleButtons(this)" class="trara">
            <td><div class="cell-content"><%= receipt.getId() %></div></td>
            <td><div class="cell-content"><%= receipt.getDate() %></div></td>
            <td><div class="cell-content"><%= receipt.getClientId() %></div></td>
            <td><div class="cell-content"><%= receipt.getDetailId() %></div></td>
            <td><div class="cell-content"><%= receipt.getTotal() %></div></td>
            <td><div class="cell-content"><%= receipt.getTotalAmount() %></div></td>
            <td><div class="cell-content"><%= receipt.getPaymentMethod() %></div></td>
            <td><div class="cell-content"><%= receipt.getDescription() %></div></td>
            <td class="dropdown" style="justify-content: center;">
                <p hidden class="json-content"  class="cell-content"><%= receipt.getJSONProductsAmounts() %></p>
                <button class="dropdown-button">ver productos</button>
            <div class="dropdown-content">
            </div>
            </td>
            <td class="delete-cell">
                
            </td>
            <td class="edit-cell">
                
            </td>
        </tr>
        <% } %>
    </tbody>
</table>

</div>
</body>
</html>