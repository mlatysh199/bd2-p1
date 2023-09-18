<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  %>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.ClientEntity" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Clientes</title>
    <style>
        
        body {
            background-color: white;
        }

       

        #mi-titulo {
            position: absolute; /* Esto establece la posición absoluta para el título */
            top: 50px; /* Ajusta la distancia desde la parte superior */
            left:50%; /* Ajusta la distancia desde la izquierda */
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

            background-color: green; /* Color de fondo verde */
            color: white; /* Color del texto en blanco */
            padding: 10px 20px; /* Espaciado interno para el botón */
            border: none; /* Sin borde */
            border-radius: 5px; /* Bordes redondeados */
            cursor: pointer; /* Cambiar el cursor al pasar el ratón */
            position: absolute;
            top: 75px;
            left: 100px;

        }

        .boton-editar{

            background-color: yellow; /* Color de fondo verde */
            color: black; /* Color del texto en blanco */
            padding: 10px 20px; /* Espaciado interno para el botón */
            border: none; /* Sin borde */
            border-radius: 5px; /* Bordes redondeados */
            cursor: pointer; /* Cambiar el cursor al pasar el ratón */
            position: absolute;
            top: 200px;
            left: 1550px;
        }   
        
        .boton-agregar:hover {
            background-color: #024900;
        }

        .boton-editar:hover {
            background-color: #96b101;
        }

        .boton-eliminar:hover {
            background-color: #9c0000;
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
            text-align: center; /* Centra el contenido horizontalmente */
            margin-top: 75px;
            margin-left: 1000px;
            position: absolute;
            top: 0;
            right: 0;
        }

        /* Estilo para la entrada de búsqueda */
        .search-input {
            padding: 10px; /* Espaciado interno */
            width: 300px; /* Ancho de la barra de búsqueda */
            border: 1px solid #ccc; /* Borde con color gris claro */
            border-radius: 5px; /* Bordes redondeados */
        }

        /* Estilo para el botón de búsqueda */
        .search-button {
            padding: 10px 20px; /* Espaciado interno */
            background-color: #007bff; /* Color de fondo azul (puedes cambiarlo) */
            color: white; /* Color del texto en blanco */
            border: none; /* Sin borde */
            border-radius: 5px; /* Bordes redondeados */
            cursor: pointer; /* Cambiar el cursor al pasar el ratón */
        }

	  .search-button:hover {
            background-color: #006797;
        }

        .selected-row {
    background-color: #e0e0e0; /* Change the background hue as desired */

    .delete-button {
    background-color: red;
    color: white;
    border: none;
    border-radius: 50%; /* Make it a circle */
    width: 30px; /* Set the width and height to make it a circle */
    height: 30px;
    font-size: 16px;
    cursor: pointer;
    display: flex; /* Center the "×" character horizontally and vertically */
    align-items: center;
    justify-content: center;
    position: relative; /* Enable relative positioning */
}

.delete-button::before {
    content: '×'; /* Use ::before pseudo-element for "×" symbol */
    position: absolute; /* Enable absolute positioning */
    top: 4px; /* Adjust the top position as needed to vertically align it */
    font-size: 16px; /* Match the font size of the circular button */
}

.delete-button:hover {
    background-color: #9c0000;
}

.delete-cell {
    width: 34.5px; /* Set a fixed width for the delete cell */
    padding: 0; /* Remove padding to avoid increasing cell size */
    text-align: center; /* Center the button horizontally */
}
}

    </style>
    <script>
let selectedRow = null; // Keep track of the currently selected row

function toggleDeleteButton(row) {
    // Check if this row is already selected
    if (selectedRow === row) {
        // Unselect the row and remove the delete button
        selectedRow = null;
        const cellData = row.querySelector('.delete-cell');
        cellData.removeChild(cellData.querySelector('.delete-button'));
        row.classList.remove('selected-row'); // Remove the selected-row class
    } else {
        // Unselect the previously selected row, if any
        if (selectedRow) {
            const deleteButton = selectedRow.querySelector('.delete-button');
            if (deleteButton) {
                deleteButton.remove();
            }
            selectedRow.classList.remove('selected-row'); // Remove the selected-row class
        }
        
        // Select the new row
        selectedRow = row;
        
        // Add the delete button with the "×" character
        const deleteButton = document.createElement('button');
        //deleteButton.innerHTML = '&times;'; // Use the "×" character
        deleteButton.onclick = (event) => deleteRow(event, row);
        row.querySelector('.delete-cell').appendChild(deleteButton);
        deleteButton.classList.add('delete-button');
        row.classList.add('selected-row'); // Add the selected-row class
    }
}
function deleteRow(event, row) {
    event.stopPropagation(); // Prevent the row click event from firing
    if (confirm("Are you sure you want to delete this client?")) {

        const clientId = row.querySelector('td:first-child').textContent; // Extract client ID


        // Send an AJAX request to delete the client record
        fetch('/CRUD/client?id=' + clientId, {
            method: 'DELETE'
        })
        .then(response => {
            if (response.ok) {
                // Remove the deleted row from the table
                row.remove();
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

document.addEventListener('modalClosed', function() {
    // Refresh the page when the modal is closed
    window.location.reload();
});
    </script>
</head>
<body>
    
    <h1 id="mi-titulo">Gestion de Clientes</h1>
    
    <button class="boton-agregar" onclick="showModal()">Agregar nuevo cliente</button>
    <div id="modal-content">
        <%@ include file="/WEB-INF/CRUD/client_add_modal.jsp" %>
    </div>

    <button class="boton-editar">Editar</button>

    <!--<ul>
        <li>Elemento 1 blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablalablablablablablablablablablablablablablablablablablalablablabla</li>
        <li>Elemento 2 blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablalablablablablablablablablablablablablablablablablablalablablabla</li>
        <li>Elemento 3 blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablalablablablablablablablablablablablablablablablablablalablablabla</li>
        <li>Elemento 4 blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablalablablablablablablablablablablablablablablablablablalablablabla</li>
    </ul>
    
    <p id="id-cliente">ID</p>
    <p id="nombre-cliente">Nombre</p>
    <p id="fecha-ultima-compra-cliente">Fecha de última compra</p>
    <p id="correo-cliente">Correo</p>
    <p id="direccion-cliente">Dirección</p>
    <p id="cantidad-compras-cliente">Cantidad de compras</p>-->

    <table>
        <thead>
        <tr>
            <th>id</th>
            <th>nombre</th>
            <th>fecha de ultima compra</th>
            <th>correo</th>
            <th>direccion</th>
            <th>cantidad de compras</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
            <%
                List<ClientEntity> clients = (List<ClientEntity>) request.getAttribute("clients");
                for (ClientEntity client : clients) {
            %>
            <tr onclick="toggleDeleteButton(this)">
                <td><%= client.getId() %></td>
                <td><%= client.getNombre() %></td>
                <td><%= client.getFechaUltimaCompra() %></td>
                <td><%= client.getCorreo() %></td>
                <td><%= client.getDireccion() %></td>
                <td><%= client.getCantidadCompras() %></td>
                <td class="delete-cell">
                    <!--<button class="delete-button" onclick="deleteRow(event, this)">×</button>-->
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <div class="search-container">
        <form action="/CRUD/client" method="get">
        <input type="text" name="search" class="search-input" placeholder="Buscar...">
        <button type="submit" class="search-button">Buscar</button>
    </form>
    </div>

</body>
</html>
