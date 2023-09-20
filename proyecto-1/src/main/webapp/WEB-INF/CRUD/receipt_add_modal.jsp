<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  %>
<!DOCTYPE html>
<html>
<head>
    <title>Modal</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/crud_add_style.css">
    <script src="<%= request.getContextPath() %>/scripts/crud_add_script.js"></script>
    <style>

    </style>
    <script>

function subShowEditModal(rowData) {
    document.getElementById("e1").value = rowData[columnNames[1]];
    document.getElementById("e2").value = rowData[columnNames[2]];
    document.getElementById("e3").value = rowData[columnNames[3]];
    document.getElementById("e4").value = rowData[columnNames[4]];
    document.getElementById("e5").value = rowData[columnNames[5]];
    document.getElementById("e6").value = rowData[columnNames[6]];
    document.getElementById("e7").value = rowData[columnNames[7]];
    document.getElementById("e7").value = rowData[columnNames[8]];
}
    </script>
</head>
<body>
    <div class="modal-header">
        <h1 class="modal-title" id="e0">Insertar Cliente</h1>
        <button class="close-button" onclick="hideModal()">Close</button>
    </div>
    <table id="waka" style="border: 2px solid #000; transform: scale(0.9);">
        <thead>
            <tr>
                <th>fecha</th>
                <th>cliente_id</th>
                <th>detalle_id</th>
                <th>total</th>
                <th>cantidad total</th>
                <th>metodo de pago</th>
                <th>descripcion</th>
                <th>cantidad productos</th>
                <th>Mandar</th>
                <!-- Add more column headers as needed -->
            </tr>
        </thead>
        <tbody>
            <tr data-rowid="1">
                <td><input type="text" id="e1" value="Value 1" class="editable-cell"></td>
                <td><input type="text" id="e2" value="Value 2" class="editable-cell"></td>
                <td><input type="text" id="e3" value="-1" class="editable-cell" readonly></td>
                <td><input type="text" id="e4" value="Value 3" class="editable-cell"></td>
                <td><input type="text" id="e5" value="Value 4" class="editable-cell"></td>
                <td><input type="text" id="e6" value="Value 5" class="editable-cell"></td>
                <td><input type="text" id="e7" value="Value 6" class="editable-cell"></td>
                <td><input type="text" id="e8" value="Value 7" class="editable-cell"></td>
                <td><button onclick="sendRowData(1)" class="save-button">Save</button></td>
                <!-- Add more cells as needed -->
            </tr>
            <!-- Add more rows as needed -->
        </tbody>
    </table>
</body>
</html>