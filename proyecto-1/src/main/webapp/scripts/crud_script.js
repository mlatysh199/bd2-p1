let selectedRow = null;

        function toggleButtons(row) {
            if (isModalOpen()) return;
            if (selectedRow === row) {
                
                const cellData = row.querySelector('.delete-cell');
                cellData.removeChild(cellData.querySelector('.delete-button'));
                const cellData2 = row.querySelector('.edit-cell');
                cellData2.removeChild(cellData2.querySelector('.edit-button'));
                row.classList.remove('selected-row');
                selectedRow = null;
            } else {
                if (selectedRow) {
                    const cellData = selectedRow.querySelector('.delete-cell');
                    cellData.removeChild(cellData.querySelector('.delete-button'));
                    const cellData2 = selectedRow.querySelector('.edit-cell');
                    cellData2.removeChild(cellData2.querySelector('.edit-button'));
                    selectedRow.classList.remove('selected-row');
                }

                selectedRow = row;

                const deleteButton = document.createElement('button');
                deleteButton.onclick = (event) => deleteRow(event, row);
                row.querySelector('.delete-cell').appendChild(deleteButton);
                deleteButton.classList.add('delete-button');
                const editButton = document.createElement('button');
                editButton.onclick = (event) => { toggleButtons(row); editRow(event, row) };
                row.querySelector('.edit-cell').appendChild(editButton);
                editButton.classList.add('edit-button');
                row.classList.add('selected-row'); 
            }
        }

        function deleteRow(event, row) {
            event.stopPropagation(); 
            if (confirm("Are you sure you want to delete this client?")) {

                const clientId = row.querySelector('td:first-child').textContent; 


                fetch(pathName + '?id=' + clientId, {
                    method: 'DELETE'
                })
                    .then(response => {
                        if (response.ok) {
                            row.remove();
                            selectedRow = null;
                            alert('Client deleted successfully!');
                        } else {
                            alert('Failed to delete the client.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('An error occurred while deleting the client.');
                    });
            }
        }

        document.addEventListener('modalOpened', function () {
            toggleButtons(selectedRow);
        });

        document.addEventListener('modalClosed', function () {
            window.location.reload();
        });

        function editRow(event, row) {
            event.stopPropagation(); 
            const columns = row.querySelectorAll('td');
            
            const rowData = {};
            for (var i = 0; i < columns.length; i++) {
                const cell = columns[i];
                rowData[columnNames[i]] = cell.textContent;
            }
            showEditModal(rowData);
        }