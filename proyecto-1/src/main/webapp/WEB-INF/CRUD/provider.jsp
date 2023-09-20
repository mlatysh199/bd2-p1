<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.ProviderEntity" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Proveedores</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/crud_style.css">
<script>
    let selectedRow = null; 
    
    function toggleButtons(row) {
 
    if (selectedRow === row) {
 
        selectedRow = null;
        const cellData = row.querySelector('.delete-cell');
        cellData.removeChild(cellData.querySelector('.delete-button'));
        const cellData2 = row.querySelector('.edit-cell');
        cellData2.removeChild(cellData2.querySelector('.edit-button'));
        row.classList.remove('selected-row'); 
    } else {

        if (selectedRow) {
            const cellData = selectedRow.querySelector('.delete-cell');
        cellData.removeChild(cellData.querySelector('.delete-button'));
        const cellData2 = selectedRow.querySelector('.edit-cell');
        cellData2.removeChild(cellData2.querySelector('.edit-button'));
        selectedRow.classList.remove('selected-row');
        }
        

        selectedRow = row;
        

        const deleteButton = document.createElement('button');
  
        deleteButton.onclick = (event) => deleteRow(event, row);
        row.querySelector('.delete-cell').appendChild(deleteButton);
        deleteButton.classList.add('delete-button');
        const editButton = document.createElement('button');
  
        editButton.onclick = (event) => {toggleButtons(row); editRow(event, row)};
 
        row.querySelector('.edit-cell').appendChild(editButton);
        editButton.classList.add('edit-button');
        row.classList.add('selected-row'); 
    }
}
function deleteRow(event, row) {
    event.stopPropagation(); 
    if (confirm("Are you sure you want to delete this client?")) {

        const clientId = row.querySelector('td:first-child').textContent; 


        fetch('/CRUD/provider?id=' + clientId, {
            method: 'DELETE'
        })
        .then(response => {
            if (response.ok) {
            
                row.remove();
                selectedRow = null;
                alert('Client deleted successfully!');
            } else {
                alert('Failed to delete the client.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while deleting the client.');
        });
    }
}
    
    function editRow(event, row) {
        event.stopPropagation(); 
        const columns = row.querySelectorAll('td');
        const columnNames = ['id', 'nombre', 'direccion', 'descripcion'];
        const rowData = {};
        for (var i = 0; i < columns.length; i++) {
            const cell = columns[i];
            rowData[columnNames[i]] = cell.textContent;
        }
        showEditModal(rowData);
    }
    
    document.addEventListener('modalClosed', function() {

        window.location.reload();
    });
    </script>

</head>
<body>
    
    <h1 id="mi-titulo">Gestion de Proveedores</h1>
    
    <button class="boton-agregar" onclick="showModal()">Agregar nuevo proveedor</button>
    <div id="modal-content">
        <%@ include file="/WEB-INF/CRUD/provider_add_modal.jsp" %>
    </div>

    <div class="user-button">
        <a href="/menu">
            <%= request.getAttribute("username") %>
        </a>
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
            <tr onclick="toggleButtons(this)">
                <td><%= provider.getId() %></td>
                <td><%= provider.getName() %></td>
                <td><%= provider.getAddress() %></td>
                <td><%= provider.getDescription() %></td>
                <td style="width: 50px;" class="delete-cell">
                
                </td>
                <td style="width: 50px;" class="edit-cell">
                    
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <div class="search-container">
        <form action="/CRUD/provider" method="get">
        <input type="text" name="search" class="search-input" placeholder="Buscar...">
        <button type="submit" class="search-button">Buscar</button>
    </form>
    </div>

</body>
</html>
