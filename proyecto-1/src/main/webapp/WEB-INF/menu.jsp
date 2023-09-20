<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página con Imagen de Fondo</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-image: url("${pageContext.request.contextPath}/images/menu.png");
            background-repeat: no-repeat;
            background-size: cover;
            font-family: Arial, sans-serif;
        }

        header {
            background-color: rgba(0, 0, 0, 0.7);
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.2);
        }

        .Logo img {
            max-width: 100px;
            height: auto;
        }

        .Nombre {
            font-size: 24px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .user-button a {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
        }

        .user-button a:hover {
            background-color: #0056b3;
        }

        .cuerpo {
            text-align: center;
            margin-top: 100px;
        }

        .mensaje-bienvenida {
            font-size: 24px;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.4);
        }

        .menu-button a {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            margin: 10px;
        }

        .menu-button a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <header>
        <div class="Logo">
            <img src="https://i.kym-cdn.com/photos/images/newsfeed/002/652/426/725.jpg">
        </div>
        <div class="Nombre">
            <h1>Probabilidades G90</h1>
        </div>
        <div class="user-button">
            <a href="/menu"><%= request.getAttribute("username") %></a>
        </div>
    </header>
    <div class="cuerpo">
        <div class="mensaje-bienvenida">
            <h2>Bienvenido nuevamente al sistema</h2>
        </div>
        <div class="menu-button">
            <a href="/CRUD/client">Cliente</a>
            <a href="/CRUD/productBuy">Compra de Productos</a>
            <a href="/CRUD/product">Producto</a>
            <a href="/CRUD/provider">Proveedor</a>
            <a href="/CRUD/receipt">Recibo</a>
            <a href="/CRUD/summary">Métrica</a>
        </div>
    </div>
</body>
</html>
