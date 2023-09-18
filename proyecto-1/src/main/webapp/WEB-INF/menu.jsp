<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página con Imagen de Fondo</title>
    <style>

    header {
        background-color: #333; /* Cambia el color de fondo según tu diseño */
        color: #fff; /* Cambia el color de texto según tu diseño */
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 20px; /* Añade relleno para espaciado interno */
        
    }
    .Logo img {
    max-width: 100px; /* Ajusta el tamaño del logo según tus necesidades */
    height: auto;
    }

    body{
        
        margin: 0;
        padding: 0;
    }

    nav{
        text-align: center;
        margin-top: 10px;
    }

    .cuerpo{
        text-align: center;
        margin-top: 325px;


       
    }



    button{
        background-color: blue;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        border: none;
        cursor: pointer;
        margin: 10px;
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

        <div>
            <a href="/menu"><%= request.getAttribute("username") %></a>
        </div>
    </header>
    <div class="cuerpo">

        <div class="mensaje-bienvenida">
            
          <h2>Bienvenido nuevamente al sistema</h2>
          
        </div>
        <a href="/CRUD/client"><button>Cliente</button></a>
        <a href="/CRUD/productBuy"><button>Compra de Productos</button></a>
        <a href="/CRUD/product"><button>Producto</button></a>
        <a href="/CRUD/provider"><button>Proveedor</button></a>
        <a href="/CRUD/receipt"><button>Recibo</button></a>
        <a href="/CRUD/summary"><button>Métrica</button></a>
    </div>
        
      
</body>

</html>