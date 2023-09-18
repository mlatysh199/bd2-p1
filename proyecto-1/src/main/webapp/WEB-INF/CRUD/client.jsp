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
            top: 250px;
            left: 1275px;
        }   

        .boton-eliminar{

            background-color: red; /* Color de fondo verde */
            color: white; /* Color del texto en blanco */
            padding: 10px 20px; /* Espaciado interno para el botón */
            border: none; /* Sin borde */
            border-radius: 5px; /* Bordes redondeados */
            cursor: pointer; /* Cambiar el cursor al pasar el ratón */
            position: absolute;
            top: 250px;
            left: 1375px;


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
        

        /* Estilo para la lista */
        table {
            list-style-type: none; /* Quita los marcadores de lista (viñetas) */
            padding: 0; /* Elimina el espacio de relleno predeterminado */
            position: absolute; /* Esto establece la posición absoluta para el título */
            top: 210px; /* Ajusta la distancia desde la parte superior */
            left: 100px;
        }

        .search-container {
            text-align: center; /* Centra el contenido horizontalmente */
            margin-top: 75px;
            margin-left: 900px;
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

    </style>
</head>
<body>
    
    <h1 id="mi-titulo">Gestion de Clientes</h1>
    
    <button class="boton-agregar">Agregar nuevo cliente</button>

    <button class="boton-editar">Editar</button>

    <button class="boton-eliminar">Eliminar</button>

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
        </tr>
        </thead>
        <tbody>
            <%
                List<ClientEntity> clients = (List<ClientEntity>) request.getAttribute("clients");
                for (ClientEntity client : clients) {
            %>
            <tr>
                <td><%= client.getId() %></td>
                <td><%= client.getNombre() %></td>
                <td><%= client.getFechaUltimaCompra() %></td>
                <td><%= client.getCorreo() %></td>
                <td><%= client.getDireccion() %></td>
                <td><%= client.getCantidadCompras() %></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <div class="search-container">
        <input type="text" class="search-input" placeholder="Buscar...">
        <button class="search-button">Buscar</button>
    </div>

</body>
</html>
