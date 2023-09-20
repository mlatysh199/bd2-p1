<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Recibos</title>
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

        #id-recibo{

            position: absolute;
            top: 180px;
            left: 100px;

        }

        #fecha-recibo{

            position: absolute;
            top: 180px;
            left: 200px;

        }


        #cliente-id-recibo{

            position: absolute;
            top: 180px;
            left: 350;

        }

        #producto-recibo{

            position: absolute;
            top: 180px;
            left: 550px;

        }

        #monto-recibo{

            position: absolute;
            top: 180px;
            left: 800px;

        }   

        #cantidad-recibo{

            position: absolute;
            top: 180px;
            left: 950px;

        }

        #pago-recibo{

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
            top: 250px;
            left: 1275px;
        }   

        .boton-eliminar{

            background-color: red;
            color: white; 
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
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

        ul {
            list-style-type: none;
            padding: 0; 
            position: absolute;
            top: 210px; 
            left: 100px;
        }

 
        li {
            margin: 0; 
            padding: 20px 0; 
            border-bottom: 1px solid gray;
        }

        .search-container {
            text-align: center;
            margin-top: 75px;
            margin-left: 900px;
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

 
        select {
            font-size: 1em; 
            text-align: center;
            color: white;
            padding: 8px; 
            border: none;
            background-color: #d66000e7;
            border-radius: 5px; 
            appearance: none;
            outline: none;
            box-shadow: none;
            margin-top: 100px;
            margin-left: 520px;

        }

     
        select option {
        font-size: 1em; 
        padding: 8px; 
        border: none; 
        background-color: #ff9254;
        border-radius: 5px; 
        }


    </style>
</head>
<body>
    
    <h1 id="mi-titulo">Gestion de Recibos</h1>
    
    <button class="boton-agregar">Agregar nuevo recibo</button>

    <button class="boton-editar">Editar</button>

    <button class="boton-eliminar">Eliminar</button>

    <ul>
        <li>Elemento 1 </li>
        <li>Elemento 2 </li>
        <li>Elemento 3 </li>
        <li>Elemento 4 </li>
    </ul>
    
    <p id="id-recibo">ID</p>
    <p id="fecha-recibo">Fecha</p>
    <p id="cliente-id-recibo"> ID Cliente</p>
    <p id="producto-recibo"> Productos</p>
    <p id="monto-recibo"> Monto</p>
    <p id="cantidad-recibo"> Cantidad de Productos</p>
    <p id="pago-recibo"> Método de Pago</p>
    <div class="search-container">
        <input type="text" class="search-input" placeholder="Buscar...">
        <button class="search-button">Buscar</button>
    </div>
    
    
    <select id="opciones" name="opciones">
        <option value="opcion1">4 Peras</option>
        <option value="opcion2">1 Coca Cola</option>
        <option value="opcion3">2 Empanadas</option>
    </select>

</body>
</html>