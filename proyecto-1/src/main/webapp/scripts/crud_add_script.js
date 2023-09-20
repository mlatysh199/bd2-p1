const modalContent = document.getElementById("modal-content");
const closeModalButton = document.getElementById("close-modal");
var isEditing = false;
var rowEditID = -1;

function showModal() {
    modalContent.style.width = calculateTableWidth() + "px";
    modalContent.style.display = "block";
    isEditing = false;
    document.getElementById("e0").textContent = "Insertar Cliente";
    const modalOpenedEvent = new Event('modalOpened');
    document.dispatchEvent(modalOpenedEvent);
}

function showEditModal(rowData) {
    showModal();
    isEditing = true;
    rowEditID = rowData['id'];

    document.getElementById("e0").textContent = "Modificar Cliente";
    subShowEditModal(rowData);
}

function hideModal() {
    modalContent.style.display = "none";
    const modalClosedEvent = new Event('modalClosed');
    document.dispatchEvent(modalClosedEvent);
}

function isModalOpen() {
    return modalContent.style.display == "block";
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
        data += columnNames[i + 1] + "=" + cell.value;
        rowData[columnNames[i + 1]] = cell.value;
    }

    fetch(pathName + '?' + data, {
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
function calculateTableWidth() {
    const table = document.getElementById('waka');
    const rows = table.querySelectorAll('tr');
    const firstRow = rows[1];
    const cells = firstRow.querySelectorAll('td');

    let totalWidth = 0;

    cells.forEach(cell => {
        totalWidth += 180;
    });

    totalWidth += 50;

    return totalWidth;
}