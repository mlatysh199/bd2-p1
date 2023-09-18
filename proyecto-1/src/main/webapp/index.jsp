<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="es">
<!-- Welcome page with button to enter into the system -->
<head>
    <title>Proyecto 1</title>
    <style>
        body {
            background-image: url(resources/welcome.jpg);
            background-repeat: no-repeat;
        }

        #title {
            position: absolute; /* Esto establece la posición absoluta para el título */
            top: 50px; /* Ajusta la distancia desde la parte superior */
            left:50%; /* Ajusta la distancia desde la izquierda */
            transform: translateX(-50%);
        }

        #button {
            position: absolute;
            top: 180px;
            left: 50%;
            transform: translateX(-50%);
        }
    </style>
</head>
<body>
<h1 id="title">Bienvenido al Sistema de Gestion de Clientes, Proveedores, Inventario y Compras</h1>
    <form action="/login">
        <input id="button" type="submit" value="Ingresar">
    </form>
</body>

</html>