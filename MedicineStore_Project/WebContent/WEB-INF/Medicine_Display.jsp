<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Medicine List</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .medicine-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }
        .medicine-card img {
            max-height: 100px;
            cursor: pointer;
        }
    </style>
    <script>
        function toggleEdit(rowId) {
            var quantityInput = document.getElementById("quantity_" + rowId);
            var priceInput = document.getElementById("price_" + rowId);

            quantityInput.disabled = !quantityInput.disabled;
            priceInput.disabled = !priceInput.disabled;
        }

        function removeRow(button) {
            var row = button.parentNode.parentNode;
            row.parentNode.removeChild(row);
        }

        
        
        function searchMedicine() {
        	console.log("hiii");
            var medicinePopup = document.getElementById("medicinePopup");
            medicinePopup.style.display = "block";

            var dropdown = document.getElementById("medicineDropdown");
            var searchInput = document.getElementById("searchMedicineName");

            // Get the selected option from the dropdown
            var selectedMedicine = dropdown.options[dropdown.selectedIndex].value;

            // Set the selected medicine as the value of the search input
            searchInput.value = selectedMedicine;
        }


        
    </script>
</head>
<body>
    <div class="container">
        <h2>Medicine List</h2>
        <div class="row">
            <div class="col-md-6 text-right">
                <input type="text" id="searchMedicineName" name="searchMedicineName" placeholder="Search Medicine">

                <button class="btn btn-primary">Search</button>
            </div>
        </div>
        <table class="table table-striped">
            <thead>
                <!-- Table headers here -->
            </thead>
            <tbody id="medicineTableBody">
                <c:forEach items="${medicines}" var="medicine" varStatus="status">
                    <tr>
                        <form action="update" method="post">
                            <td>${medicine.getId()}</td>
                            <td>${medicine.getBillNo()}</td>
                            <td>${medicine.getMedicineName()}</td>
							<input type="hidden" name="id" value="${medicine.getId()}">
							
                            <td><input name="quantity" id="quantity_${status.index}" type="text" value="${medicine.getQuantity()}" disabled></td>
                            <td><input name="price" id="price_${status.index}" type="text" value="${medicine.getPrice()}" disabled></td>

                            <td><a href="#" class="btn btn-warning" onclick="toggleEdit(${status.index});">Edit</a></td>
                            <td><a href="#" class="btn btn-danger">Delete</a></td>
                            <td><button type="submit" class="btn btn-success">Save</button></td>
                        </form>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
<div id="medicinePopup">
    <h3>Select a Medicine</h3>
    <form action="adding" method="post" id="medicineForm">
        <input type="hidden" id="selectedMedicineId" name="selectedMedicineId">
        <select name="selectedMedicine" id="medicineDropdown">
            <c:forEach items="${medicineNames}" var="medicineName">
                <option value="${medicineName}" <c:if test="${medicineName == selectedMedicineName}">selected</c:if>>${medicineName}</option>
            </c:forEach>
        </select>
        <button type="button" class="btn btn-primary" onclick="add()">selected</button>
    </form>
</div>

<script>
    function add() {
        // Stop the form submission
        event.preventDefault();

        // Get the selected medicine from the dropdown
        var selectedMedicine = document.getElementById("medicineDropdown").value;
        
        // Set the selected medicine name in the hidden input field
        document.getElementById("selectedMedicineId").value = selectedMedicine;

        // Set the selected medicine in the search input field
        document.getElementById("searchMedicineName").value = selectedMedicine;

        // Now you can submit the form to the controller
        document.getElementById("medicineForm").submit();
    }
</script>




        
        
    </div>
    
    
    
</div>

    </div>
</body>
</html>
