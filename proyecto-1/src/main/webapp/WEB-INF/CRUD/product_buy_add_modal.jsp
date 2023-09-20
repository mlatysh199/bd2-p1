<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  %>
<!DOCTYPE html>
<html>
<head>
    <title>Modal</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/crud_add_style.css">
    <script src="<%= request.getContextPath() %>/scripts/crud_add_script.js"></script>
    <script>

function subShowEditModal(rowData) {
    document.getElementById("e1").value = rowData[columnNames[1]];
    document.getElementById("e2").value = rowData[columnNames[2]];
    document.getElementById("e3").value = rowData[columnNames[3]];
    document.getElementById("e4").value = rowData[columnNames[4]];
    document.getElementById("e5").value = rowData[columnNames[5]];
    document.getElementById("e6").value = rowData[columnNames[6]];
}
    </script>
</head>
<body>
    <div class="modal-header">
        <h1 class="modal-title" id="e0">Insertar Compra Producto</h1>
        <button class="close-button" onclick="hideModal()">Close</button>
    </div>
    <table id="waka" style="border: 2px solid #000;">
        <thead>
            <tr>
                <th>producto</th>
                <th>proveedor</th>
                <th>fecha</th>
                <th>cantidad</th>
                <th>monto</th>
                <th>descripcion</th>
                <th>Mandar</th>
                <!-- Add more column headers as needed -->
            </tr>
        </thead>
        <tbody>
            <tr data-rowid="1">
                <td><input type="text" id="e1" value="Value 1" class="editable-cell"></td>
                <td><input type="text" id="e2" value="Value 2" class="editable-cell"></td>
                <td><input type="text" id="e3" value="Value 3" class="editable-cell"></td>
                <td><input type="text" id="e4" value="Value 4" class="editable-cell"></td>
                <td><input type="text" id="e5" value="Value 5" class="editable-cell"></td>
                <td><input type="text" id="e6" value="Value 6" class="editable-cell"></td>
                <td><button onclick="sendRowData(1)" class="save-button">Save</button></td>
                <!-- Add more cells as needed -->
            </tr>
            <!-- Add more rows as needed -->
        </tbody>
    </table>


    

</body>
</html>