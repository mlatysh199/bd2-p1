<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.ReceiptEntity" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Compras de productos</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/crud_style.css">
    <script src="<%= request.getContextPath() %>/scripts/crud_script.js"></script> 
    <script>
        const columnNames = ['id', 'fecha', 'cliente_id', 'detalle_id', 'total', 'cantidad total', 'metodo de pago', 'descripcion', 'cantidad productos'];
        
        const pathName = '/CRUD/receipt';
        function populateProductsAmountDropdown(cell) {
            console.log("papageno")
  // Parse the JSON string into a JavaScript object
  var productsAmounts = JSON.parse(cell.innerHTML);

  // Create a select element
  var select = document.createElement("select");

  // Iterate through the JavaScript object and add options
  for (var key in productsAmounts) {
    if (productsAmounts.hasOwnProperty(key)) {
      var option = document.createElement("option");
      var link = document.createElement("a");

      // Create a link with the key as text and a custom URL (modify as needed)
      link.textContent = key + " : " + productsAmounts[key];
      link.href = "/CRUD/product?search=" + key; // Set your custom URL here

      // Append the link to the option
      option.appendChild(link);
      // make all options disabled
        option.disabled = true;

      // Append the option to the select
      select.appendChild(option);
    }
  }

  // Set the select element's value based on the cell's current value (if needed)
  select.value = "ver productos";

  // Clear the cell's content and append the select element
  cell.innerHTML = "";
  cell.appendChild(select);
}

document.addEventListener("DOMContentLoaded", function() {
    // Call your function here, e.g., toggleButtons
    var elem = document.querySelector(".products-amount-cell");
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
        <!--
                private int id;
    private String date;
    private int clientId;
    private int detailId;
    private int total;
    private int totalAmount;
    private String paymentMethod;
    private String description;
    private Map<Integer, Integer> productsAmounts;
        -->
        <tr onclick="toggleButtons(this)" class="trara">
            <td><%= receipt.getId() %></td>
            <td><%= receipt.getDate() %></td>
            <td><%= receipt.getClientId() %></td>
            <td><%= receipt.getDetailId() %></td>
            <td><%= receipt.getTotal() %></td>
            <td><%= receipt.getTotalAmount() %></td>
            <td><%= receipt.getPaymentMethod() %></td>
            <td><%= receipt.getDescription() %></td>
            <td class="products-amount-cell"><%= receipt.getJSONProductsAmounts() %></td>
            
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