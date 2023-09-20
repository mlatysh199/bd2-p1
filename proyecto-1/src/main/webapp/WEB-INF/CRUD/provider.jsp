<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.ProviderEntity" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Proveedores</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/crud_style.css">
    <script src="<%= request.getContextPath() %>/scripts/crud_script.js"></script>
    <script>
        const columnNames = ['id', 'nombre', 'direccion', 'descripcion'];
        const pathName = '/CRUD/provider';
    </script>

</head>
<body>
    <div class="container">
        <h1>Gestion de Proveedores</h1>
    <div class="sub-header"> 
    
    

    <div class="user-button">
        <a href="/menu">
            USUARIO : <%= request.getAttribute("username") %>
        </a>
    </div>
    <div class="search-container">
        <form action="/CRUD/provider" method="get">
        <input type="text" name="search" class="search-input" placeholder="Buscar...">
        <button type="submit" class="search-button">Buscar</button>
    </form>
    </div>
    <button class="add-button" onclick="showModal()">Agregar nuevo proveedor</button>
    <div id="modal-content">
        <%@ include file="/WEB-INF/CRUD/provider_add_modal.jsp" %>
    </div>
</div>
    <table>
        <thead>
        <tr>
            <th>id</th>
            <th>nombre</th>
            <th>direccion</th>
            <th>descripcion</th>
            <th style="width: 50px;"></th>
            <th style="width: 50px;"></th>
        </tr>
        </thead>
        <tbody>
            <%
                List<ProviderEntity> providers = (List<ProviderEntity>) request.getAttribute("providers");
                for (ProviderEntity provider : providers) {
            %>
            <tr onclick="toggleButtons(this)" class="trara">
                <td><div class="cell-content"><%= provider.getId() %></div></td>
                <td><div class="cell-content"><%= provider.getName() %></div></td>
                <td><div class="cell-content"><%= provider.getAddress() %></div></td>
                <td><div class="cell-content"><%= provider.getDescription() %></div></td>
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
