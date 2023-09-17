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
<body>

    <header>
        <div class="Logo">
            <img src="https://i.kym-cdn.com/photos/images/newsfeed/002/652/426/725.jpg">

        </div>
        
        <div class="Nombre">
                <h1>Probabilidades G90</h1>
        </div>
    
        <div>
            <nav am-layout="horizontal">
            <a href="#">Home</a>
            <a href="#">About</a>
            <a href="#">Products</a>
            <a href="#">Contact</a>
            </nav>
        </div>
    </header>
    <div class="cuerpo">

        <div class="mensaje-bienvenida">
            
          <h2>Bienvenido nuevamente al sistema</h2>
          
        </div>
        <button>menu1</button>
        <button>menu2</button>
        <button>menu3</button>
        <button>menu4</button>
        <button>menu5</button>
    </div>
        
      
</body>
</head>
</html>