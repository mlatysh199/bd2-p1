<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.ProviderEntity" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Proveedores</title>
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

        #id-proveedor{

            position: absolute;
            top: 180px;
            left: 100px;

        }

        #nombre-proveedor{

            position: absolute;
            top: 180px;
            left: 250px;

        }


        #descripcion-proveedor{

            position: absolute;
            top: 180px;
            left: 500px;

        }

        #direccion-proveedor{

            position: absolute;
            top: 180px;
            left: 750px;

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

        .boton-eliminar{

        background-color: red; /* Color de fondo verde */
        color: white; /* Color del texto en blanco */
        padding: 10px 20px; /* Espaciado interno para el botón */
        border: none; /* Sin borde */
        border-radius: 5px; /* Bordes redondeados */
        cursor: pointer; /* Cambiar el cursor al pasar el ratón */
        position: absolute;
        top: 200px;
        left: 1650px;


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



    </style>
</head>
<body>
    
    <h1 id="mi-titulo">Gestion de Proveedores</h1>
    
    <button class="boton-agregar">Agregar nuevo proveedor</button>

    <button class="boton-editar">Editar</button>

    <button class="boton-eliminar">Eliminar</button>

    <table>
        <thead>
        <tr>
            <th>id</th>
            <th>nombre</th>
            <th>direccion</th>
            <th>descripcion</th>
        </tr>
        </thead>
        <tbody>
            <%
                List<ProviderEntity> providers = (List<ProviderEntity>) request.getAttribute("providers");
                for (ProviderEntity provider : providers) {
            %>
            <tr>
                <td><%= provider.getId() %></td>
                <td><%= provider.getName() %></td>
                <td><%= provider.getAddress() %></td>
                <td><%= provider.getDescription() %></td>
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
