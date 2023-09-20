<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  %>
<!DOCTYPE html>
<html>
<head>
    <title>Modal</title>
    <style>
        #modal-content {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 950px;
            height: 300px;
            background-color: rgb(123, 141, 240);
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        .editable-cell {
            border: 1px solid black;
            padding: 0px;
            max-width: 150px;
        }
    </style>
    <script>
        const modalContent = document.getElementById("modal-content");
const closeModalButton = document.getElementById("close-modal");
var isEditing = false;
var rowEditID = -1;
const columnNames = ['id', 'producto_id', 'proveedor_id', 'fecha', 'cantidad', 'monto', 'descripcion'];
function showModal() {
    modalContent.style.display = "block";
    isEditing = false;
}

function showEditModal(rowData) {
    showModal();
    isEditing = true;
    rowEditID = rowData['id'];
    document.getElementById("e1").value = rowData[columnNames[0]];
    document.getElementById("e2").value = rowData[columnNames[1]];
    document.getElementById("e3").value = rowData[columnNames[2]];
    document.getElementById("e4").value = rowData[columnNames[3]];
    document.getElementById("e5").value = rowData[columnNames[4]];
    document.getElementById("e5").value = rowData[columnNames[5]];
    document.getElementById("e5").value = rowData[columnNames[6]];
}

function hideModal() {
    modalContent.style.display = "none";
    const modalClosedEvent = new Event('modalClosed');
    document.dispatchEvent(modalClosedEvent);
}

const editableCells = document.querySelectorAll('.editable-cell');

editableCells.forEach(cell => {
    cell.addEventListener('click', () => {
        const currentValue = cell.innerText;
        const inputElement = document.createElement('input');
        inputElement.value = currentValue;
        cell.innerHTML = '';
        cell.appendChild(inputElement);
        inputElement.focus();


        inputElement.addEventListener('blur', () => {
            const newValue = inputElement.value;
            cell.innerHTML = newValue;
        });
    });
});

function sendRowData(rowID) {
    const row = document.querySelector('tr[data-rowid="'+rowID+ '"]');
    const columns = row.querySelectorAll('.editable-cell');
    const rowData = {};
    var data = "";

    if (isEditing) {
        data += "id=" + rowEditID + "&";
    }

    for (var i = 0; i < columns.length; i++) {
        const cell = columns[i];
        if (data != "") data += "&";
        data += columnNames[i] + "=" + cell.value;
        rowData[columnNames[i]] = cell.value;
    }




    fetch('/CRUD/product_buy?' + data, {
        method: 'POST',
        body: JSON.stringify(rowData),
    })
    .then(response => {
        if (response.ok) {
           
            alert('El procedimiento se ejecutó exitósamente!');
        } else {
            alert('No se logró ejecutar el procedimiento.');
        }
        hideModal();
    })
    .catch(error => {
        console.error('Error:', error);
        alert('No se logró ejecutar el procedimiento.');
        hideModal();
    });
}

    </script>
</head>
<body>
    <h1>Insertar Producto</h1>
    <button id="close-modal" onclick="hideModal()">Close</button>
    <table id="waka">
        <thead>
            <tr>
                <th>producto</th>
                <th>proveedor</th>
                <th>fecha</th>
                <th>cantidad</th>
                <th>monto</th>
                <th>descripcion</th>
                <th>Mandar</th>

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
                <td><input type="text" id="e7" value="Value 7" class="editable-cell"></td>
                <td><button onclick="sendRowData(1)">Save</button></td>

            </tr>

        </tbody>
    </table>


    

</body>
</html>