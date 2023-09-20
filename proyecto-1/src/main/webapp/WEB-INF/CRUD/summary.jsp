<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  %>
<%@ page import="java.util.List" %>
<%@ page import="tec.bd2.proyectos.db.entities.LogEntity" %>
<%@ page import="tec.bd2.proyectos.db.entities.MetricEntity" %>
<!DOCTYPE html>
<html>

<head>
    <title>Gestion de Clientes</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/crud_style.css">
    <script src="<%= request.getContextPath() %>/scripts/crud_script.js"></script>
    <script>
        const columnNames = ['id', 'fecha', 'descripcion', 'usuario db'];
        const pathName = '/CRUD/summary';
    </script>
</head>

<body>
    <div class="container">
    <h1>Gestion de Clientes</h1>
    <div class="sub-header">
    <div class="user-button">
        <a href="/menu">
            USUARIO : <%= request.getAttribute("username") %>
        </a>
    </div>
    <div class="search-container">
        <form action="/CRUD/summary" method="get">
            <input type="text" name="search" class="search-input" placeholder="Buscar...">
            <button type="submit" class="search-button">Buscar</button>
        </form>
    </div>
</div>
    <table>
        <thead>
            <tr>
                <th>id</th>
                <th>fecha</th>
                <th>descripcion</th>
                <th>usuario db</th>
            </tr>
        </thead>
        <tbody>
            <% List<LogEntity> logs = (List<LogEntity>) request.getAttribute("logs");
                    for (LogEntity log : logs) {
                    %>
                    <tr onclick="toggleButtons(this)" class="trara">
                        <td><%= log.getId() %></td>
                        <td><%= log.getFecha() %></td>
                        <td><%= log.getDescripcion() %></td>
                        <td><%= log.getUsuarioDb() %></td>
                    </tr>
                    <% } %>
        </tbody>
    </table>
    <div class="sub-header" style="justify-content: center;">

    <div class="search-container" >
        <form action="/CRUD/summary" method="get" >
            <input type="text" name="searchp" class="search-input" placeholder="Buscar...">
            <label for="datepicker">Escoge una fecha:</label>
            <input type="date" id="datepicker" name="date">
            <button type="submit" class="search-button">Buscar</button>

        </form>
    </div>
</div>
    <table>
        <thead>
            <tr>
                <th>fecha</th>
                <th>id producto</th>
                <th>cantidad comprado</th>
            </tr>
        </thead>
        <tbody>
            <% List<MetricEntity> metrics = (List<MetricEntity>) request.getAttribute("metrics");
                    for (MetricEntity metric : metrics) {
                    %>
                    <tr onclick="toggleButtons(this)" class="trara">
                        <td><%= metric.getDate() %></td>
                        <td><%= metric.getProduct_id() %></td>
                        <td><%= metric.getTotal() %></td>
                    </tr>
                    <% } %>
        </tbody>
    </table>
</div>
</body>

</html>