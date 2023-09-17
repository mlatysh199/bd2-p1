<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Productos</title>
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

        #id-producto{

            position: absolute;
            top: 180px;
            left: 100px;

        }

        #nombre-producto{

            position: absolute;
            top: 180px;
            left: 250px;

        }


        #descripcion-producto{

            position: absolute;
            top: 180px;
            left: 500px;

        }

        #precio-producto{

            position: absolute;
            top: 180px;
            left: 750px;

        }

        #categoria-producto{

            position: absolute;
            top: 180px;
            left: 950px;

        }   

        #inventario-producto{

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
        ul {
            list-style-type: none; /* Quita los marcadores de lista (viñetas) */
            padding: 0; /* Elimina el espacio de relleno predeterminado */
            position: absolute; /* Esto establece la posición absoluta para el título */
            top: 210px; /* Ajusta la distancia desde la parte superior */
            left: 100px;
        }

        /* Estilo para los elementos de la lista */
        li {
            margin: 0; /* Elimina el margen predeterminado */
            padding: 20px 0; /* Espaciado vertical entre elementos */
            border-bottom: 1px solid gray;
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
    
    <h1 id="mi-titulo">Gestion de Productos</h1>

    <button class="boton-agregar">Agregar nuevo producto</button>

    <button class="boton-editar">Editar</button>

    <button class="boton-eliminar">Eliminar</button>

    <ul>
        <li>Elemento 1 blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablalablablablablablablablablablablablablablablablablablalablablabla</li>
        <li>Elemento 2 blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablalablablablablablablablablablablablablablablablablablalablablabla</li>
        <li>Elemento 3 blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablalablablablablablablablablablablablablablablablablablalablablabla</li>
        <li>Elemento 4 blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablalablablablablablablablablablablablablablablablablablalablablabla</li>
    </ul>
    <p id="id-producto">ID</p>
    <p id="nombre-producto">Nombre</p>
    <p id="descripcion-producto">Descripcion</p>
    <p id="precio-producto">Precio</p>
    <p id="categoria-producto">Categoria</p>
    <p id="inventario-producto">Inventario</p>

    <div class="search-container">
        <input type="text" class="search-input" placeholder="Buscar...">
        <button class="search-button">Buscar</button>
    </div>

</body>
</html>