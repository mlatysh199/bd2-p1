<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.ProductBuyEntity" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Compras de productos</title>
    <style>
        
        body {
            background-color: white;
        }

       

        #mi-titulo {
            position: absolute;
            top: 50px;
            left:50%; 
            transform: translateX(-50%);
        }

        #id-cliente{

            position: absolute;
            top: 180px;
            left: 100px;

        }

        #nombre-cliente{

            position: absolute;
            top: 180px;
            left: 250px;

        }


        #fecha-ultima-compra-cliente{

            position: absolute;
            top: 180px;
            left: 450px;

        }

        #correo-cliente{

            position: absolute;
            top: 180px;
            left: 750px;

        }

        #direccion-cliente{

            position: absolute;
            top: 180px;
            left: 950px;

        }   

        #cantidad-compras-cliente{

            position: absolute;
            top: 180px;
            left: 1150px;

        }


        .boton-agregar{

            background-color: green;
            color: white; 
            padding: 10px 20px; 
            border: none; 
            border-radius: 5px; 
            cursor: pointer; 
            position: absolute;
            top: 75px;
            left: 100px;

        }

        .boton-editar{

            background-color: yellow; 
            color: black; 
            padding: 10px 20px; 
            border: none; 
            border-radius: 5px;
            cursor: pointer;
            position: absolute;
            top: 200px;
            left: 1550px;
        }   
        
        .boton-agregar:hover {
            background-color: #024900;
        }
        

        table {
            width: 80%;
            border-collapse: collapse;
            margin-top: 10%;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .search-container{
            text-align: center; 
            margin-top: 75px;
            margin-left: 1000px;
            position: absolute;
            top: 0;
            right: 0;
        }

       
        .search-input {
            padding: 10px;
            width: 300px; 
            border: 1px solid #ccc; 
            border-radius: 5px;
        }

        
        .search-button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white; 
            border: none; 
            border-radius: 5px; 
            cursor: pointer; 
        }

	  .search-button:hover {
            background-color: #006797;
        }

        .selected-row {
    background-color: #e0e0e0; 

    .delete-button {
    background-color: red;
    color: white;
    border: none;
    border-radius: 50%;
    width: 30px; 
    height: 30px;
    font-size: 16px;
    cursor: pointer;
    display: flex; 
    align-items: center;
    justify-content: center;
    position: relative; 
}

.delete-button::before {
    content: '×';
    position: absolute; 
    top: 4px; 
    font-size: 16px; 
}

.delete-button:hover {
    background-color: #9c0000;
}

.delete-cell {
    width: 34.5px;
    padding: 0;
    text-align: center; 
}

.edit-button {
    background-color: yellow;
    color: white;
    border: none;
    border-radius: 50%; 
    width: 30px; 
    height: 30px;
    font-size: 16px;
    cursor: pointer;
    display: flex; 
    align-items: center;
    justify-content: center;
    position: relative;
}

.edit-button::before {
    content: 'o'; 
    position: absolute;
    top: 4px; 
    font-size: 16px; 
}

.edit-button:hover {
    background-color: #9c8a00;
}

.edit-cell {
    width: 34.5px; 
    padding: 0; 
    text-align: center; 
}

}
    </style>

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
            cellData2.removeChild(cellData.querySelector('.edit-button'));
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
    
            const productId = row.querySelector('td:first-child').textContent; 
    
    
           
            fetch('/CRUD/product_buy?id=' + productBuyId, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                   
                    row.remove();
                    selectedRow = null;
                    alert('Product deleted successfully!');
                } else {
                    alert('Failed to delete the Product.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while deleting the Product.');
            });
        }
    }
    
    function editRow(event, row) {
        event.stopPropagation(); 
        const columns = row.querySelectorAll('td');
        const columnNames = ['id', 'producto_id', 'proveedor_id', 'fecha', 'cantidad', 'monto', 'descripcion'];
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
    
    <h1 id="mi-titulo">Gestion de Productos</h1>
    
    <button class="boton-agregar" onclick="showModal()">Agregar nuevo Producto compra</button>
    <div id="modal-content">
        <%@ include file="/WEB-INF/CRUD/product_buy_add_modal.jsp" %>
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
        <th></th>
        <th></th>
    </tr>
    </thead>
    <tbody>
        <%
            List<ProductBuyEntity> productsBuy = (List<ProductBuyEntity>) request.getAttribute("productsBuy");
            for (ProductBuyEntity productBuy : productsBuy) {
        %>
        <tr onclick="toggleButtons(this)">
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
<div class="search-container">
    <form action="/CRUD/product_buy" method="get">
    <input type="text" name="search" class="search-input" placeholder="Buscar...">
    <button type="submit" class="search-button">Buscar</button>
</form>
</div>

</body>
</html>