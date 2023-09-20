<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  %>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.ClientEntity" %>
<!DOCTYPE html>
<html>

<head>
    <title>Gestion de Clientes</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/crud_style.css">
    <script src="<%= request.getContextPath() %>/scripts/crud_script.js"></script>
    <script>
        const columnNames = ['id', 'nombre', 'fecha de ultima compra', 'correo', 'direccion', 'cantidad de compras'];
        const pathName = '/CRUD/client';
    </script>
</head>

<body>
    <div class="container">
    <h1>Gestion de Clientes</h1>
    <div class="sub-header">
    <div class="user-button">
        <a href="/menu">
            USUARIO : <%= request.getAttribute("username") %>
        </a>
    </div>
    <div class="search-container">
        <form action="/CRUD/client" method="get">
            <input type="text" name="search" class="search-input" placeholder="Buscar...">
            <button type="submit" class="search-button">Buscar</button>
        </form>
    </div>
    <button class="add-button" onclick="showModal()">Agregar nuevo cliente</button>
    <div id="modal-content">
        <%@ include file="/WEB-INF/CRUD/client_add_modal.jsp" %>
    </div>
</div>
    <table>
        <thead>
            <tr>
                <th>id</th>
                <th>nombre</th>
                <th>fecha de ultima compra</th>
                <th>correo</th>
                <th>direccion</th>
                <th>cantidad de compras</th>
                <th style="width: 50px;"></th>
                <th style="width: 50px;"></th>
            </tr>
        </thead>
        <tbody>
            <% List<ClientEntity> clients = (List<ClientEntity>) request.getAttribute("clients");
                    for (ClientEntity client : clients) {
                    %>
                    <tr onclick="toggleButtons(this)" class="trara">
                        <td><div class="cell-content"><%= client.getId() %></div></td>
                        <td><div class="cell-content"><%= client.getNombre() %></div></td>
                        <td><div class="cell-content"><%= client.getFechaUltimaCompra() %></div></td>
                        <td><div class="cell-content"><%= client.getCorreo() %></div></td>
                        <td><div class="cell-content"><%= client.getDireccion() %></div></td>
                        <td><div class="cell-content"><%= client.getCantidadCompras() %></div></td>
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