<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="es">
<!-- Welcome page with button to enter into the system -->
<head>
    <title>Proyecto 1</title>
    <style>
        body {
            background-image: url("${pageContext.request.contextPath}/images/welcome.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        #container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }

        #title {
            font-size: 36px;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.4);
        }

        #button {
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        #button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div id="container">
    <h1 id="title">Bienvenido al Sistema de Gestión de Clientes, Proveedores, Inventario y Compras</h1>
    <form action="/login">
        <button id="button" type="submit">Ingresar</button>
    </form>
</div>
</body>
</html>
