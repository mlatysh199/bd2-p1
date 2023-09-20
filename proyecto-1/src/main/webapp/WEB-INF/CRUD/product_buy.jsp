<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.ProductBuyEntity" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Compras de productos</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/crud_style.css">
    <script src="<%= request.getContextPath() %>/scripts/crud_script.js"></script> 
    <script>
        const columnNames = ['id', 'producto_id', 'proveedor_id', 'fecha', 'cantidad', 'monto', 'descripcion'];
        const pathName = '/CRUD/productBuy';
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
        <form action="/CRUD/productBuy" method="get">
        <input type="text" name="search" class="search-input" placeholder="Buscar...">
        <button type="submit" class="search-button">Buscar</button>
    </form>
    </div>
    <button class="add-button" onclick="showModal()">Agregar nuevo Producto compra</button>
    <div id="modal-content">
        <%@ include file="/WEB-INF/CRUD/product_buy_add_modal.jsp" %>
    </div>

</div>
<table>
    <thead>
    <tr>
        <th>id</th>
        <th>producto</th>
        <th>proveedor</th>
        <th>fecha</th>
        <th>cantidad</th>
        <th>monto</th>
        <th>descripcion</th>
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
            <td><div class="cell-content"><%= productBuy.getId() %></div></td>
            <td><div class="cell-content"><%= productBuy.getProducto_id() %></div></td>
            <td><div class="cell-content"><%= productBuy.getProveedor_id() %></div></td>
            <td><div class="cell-content"><%= productBuy.getFecha() %></div></td>
            <td><div class="cell-content"><%= productBuy.getCantidad() %></div></td>
            <td><div class="cell-content"><%= productBuy.getMonto() %></div></td>
            <td><div class="cell-content"><%= productBuy.getDescripcion() %></div></td>
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