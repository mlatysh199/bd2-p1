<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.ProductEntity" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Productos</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/crud_style.css">
    <script src="<%= request.getContextPath() %>/scripts/crud_script.js"></script> 
    <script>
        const columnNames = ['id', 'nombre', 'descripcion', 'precio', 'categoria', 'inventario'];
        const pathName = '/CRUD/product';
    </script>


</head>
<body>
    <div class="container"> 
        <h1>Gestion de Productos</h1><div class="sub-header">
    <div class="user-button">
        <a href="/menu">
            USUARIO : <%= request.getAttribute("username") %>
        </a>
    </div>
    <div class="search-container">
        <form action="/CRUD/product" method="get">
        <input type="text" name="search" class="search-input" placeholder="Buscar...">
        <button type="submit" class="search-button">Buscar</button>
    </form>
    </div>

    <button class="add-button" onclick="showModal()">Agregar nuevo Producto</button>
    <div id="modal-content">
        <%@ include file="/WEB-INF/CRUD/product_add_modal.jsp" %>
    </div>
</div>
<table>
    <thead>
    <tr>
        <th>id</th>
        <th>nombre</th>
        <th>descripcion</th>
        <th>precio</th>
        <th>categoria</th>
        <th>inventario</th>
        <th style="width: 50px;"></th>
        <th style="width: 50px;"></th>
    </tr>
    </thead>
    <tbody>
        <%
            List<ProductEntity> products = (List<ProductEntity>) request.getAttribute("products");
            for (ProductEntity product : products) {
        %>
        <tr onclick="toggleButtons(this)" class="trara">
            <td><%= product.getId() %></td>
            <td><%= product.getNombre() %></td>
            <td><%= product.getDescripcion() %></td>
            <td><%= product.getPrecio() %></td>
            <td><%= product.getCategoria() %></td>
            <td><%= product.getInventario() %></td>
            <td style="width: 50px;" class="delete-cell">
                
            </td>
            <td style="width: 50px;" class="edit-cell">
                
            </td>
        </tr>
        <% } %>
    </tbody>
</table>


</div>
</body>
</html>