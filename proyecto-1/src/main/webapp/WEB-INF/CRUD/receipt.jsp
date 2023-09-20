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
        const columnNames = ['id', 'fecha', 'client_id', 'total', 'cantidad total', 'metodo de pago', 'descripcion', 'productos'];
        const pathName = '/CRUD/receipt';
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
        <!-- ['id', 'fecha', 'client_id', 'total', 'cantidad total', 'metodo de pago', 'descripcion', 'productos'];-->
        <th>id</th>
        <th>fecha</th>
        <th>client_id</th>
        <th>total</th>
        <th>cantidad total</th>
        <th>metodo de pago</th>
        <th>descripcion</th>
        <th>productos</th>
        <th style="width: 50px;"></th>
        <th style="width: 50px;"></th>
    </tr>
    </thead>
    <tbody>
        <%
            List<ProductBuyEntity> productsBuy = (List<ProductBuyEntity>) request.getAttribute("productsBuy");
            for (ProductBuyEntity productBuy : productsBuy) {
        %>
        <tr onclick="toggleButtons(this)" class="trara">
            <td><%= productBuy.getId() %></td>
            <td><%= productBuy.getProducto_id() %></td>
            <td><%= productBuy.getProveedor_id() %></td>
            <td><%= productBuy.getFecha() %></td>
            <td><%= productBuy.getCantidad() %></td>
            <td><%= productBuy.getMonto() %></td>
            <td><%= productBuy.getDescripcion() %></td>
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