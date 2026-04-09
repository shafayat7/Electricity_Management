<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.model.Bill" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pay Bill</title>
    <link rel="stylesheet" href="style.css">
    <script>
        function updateTotal() {
            let checkboxes = document.querySelectorAll('.bill-checkbox');
            let totalAmount = 0;
            let sendbills="";
            checkboxes.forEach(checkbox => {
                if (checkbox.checked) {
                	sendbills += (checkbox.value+",");
                    totalAmount += parseFloat(checkbox.dataset.amount);
                }
            });

            document.getElementById('totalAmount').innerText = totalAmount.toFixed(2);
            document.getElementById('sendbills').innerText = sendbills;
        }
    </script>
    <style>
    	body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.container {
    width: 80%;
    margin: 0 auto;
    padding: 20px;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1, h2, h3 {
    color: #333;
}

form {
    display: flex;
    flex-direction: column;
}

label {
    margin-top: 10px;
}

input, select, textarea {
    padding: 8px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

button {
    margin-top: 15px;
    padding: 10px;
    background-color: #000000;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #45a049;
}

button.cancel {
    background-color: #f44336;
}

button.cancel:hover {
    background-color: #e53935;
}

.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #4CAF50;
    padding: 10px;
    color: white;
}

.top-bar .welcome {
    text-align: right;
}


.nav-bar {
    background-color: #333;
    padding: 10px;
}

.nav-bar ul {
    list-style: none;
    margin: 0;
    padding: 0;
    display: flex;
}

.nav-bar li {
    margin-right: 20px;
}

.nav-bar a {
    color: white;
    text-decoration: none;
    padding: 10px;
    display: block;
}

.nav-bar a:hover {
    background-color: #4CAF50;
}

.welcome {
    text-align: right;
}

.hidden {
    display: none;
}

/* Tables */
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

table th, table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

table th {
    background-color: #4CAF50;
    color: white;
}

table tr:hover {
    background-color: #f1f1f1;
}

/* Receipt Page */
.receipt-container {
    text-align: center;
    margin-top: 30px;
}

.receipt-container h3 {
    color: #4CAF50;
    margin-bottom: 20px;
}

.receipt-container p {
    font-size: 1.2rem;
    margin-bottom: 10px;
}

.receipt-container .receipt-actions {
    margin-top: 20px;
}

.receipt-container .receipt-actions button {
    padding: 10px 20px;
    font-size: 1.1rem;
    color: white;
    background-color: #4CAF50;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.receipt-container .receipt-actions button:hover {
    background-color: #45a049;
}

.receipt-container .receipt-actions button.download {
    background-color: #28a745;
}

.receipt-container .receipt-actions button.download:hover {
    background-color: #218838;
}


#statusMessage {
    margin-top: 20px;
    padding: 15px;
    font-size: 1.2rem;
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    border-radius: 4px;
}
    </style>
</head>
<body>
	<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("userID") == null) {
        response.sendRedirect("index.jsp");
    }
	String cid=(String) session.getAttribute("userID"); 
	%>
	
	<div class="container">
        <div class="top-bar">
            <h1>E-Bill</h1>
            <div class="welcome">
        
                <div style="color:black;">
                    <b>Welcome, <span id="usernameDisplay"><%= session.getAttribute("userID") %></span><br></b>
                </div>
                <form action="LogoutServlet">
                    <button type="submit" >Logout</button>
                </form>
            </div>
            
        </div>

        <div class="nav-bar">
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="BillServlet">Pay Bill</a></li>
                <li><a href="complaintRegister.jsp">Register Complaint</a></li>
               <li> <a href="complaintStatus.jsp">Complaint Status</a></li>
            </ul>
        </div>

        <main>
            <h3>Available Bills for User ID: <%= cid!=null?cid:"N/A" %></h3>
            <form id="billForm" action="PaymentServlet" method="get">
                <table border="1">
                    <tr>
                        <th>Select</th>
                        <th>Bill Number</th>
                        <th>Month</th>
                        <th>Due Amount</th>
                        <th>Payable Amount</th>
                    </tr>
                    <%
                    
                	ArrayList<Bill> bills = (ArrayList<Bill>) request.getAttribute("bills");
                	if (bills != null && !bills.isEmpty()) {
                    for (Bill bill : bills) { 
           			 %>
                        <tr>
                            <td><input type="checkbox" class="bill-checkbox" name="selectedBills" value="<%= bill.getBillNumber() %>" data-amount="<%= bill.getPayableAmt() %>" onclick="updateTotal()"></td>
                            <td><%= bill.getBillNumber() %></td>
                            <td><%= bill.getMonth() %></td>
                            <td><%= bill.getDueAmount() %></td>
               				<td><%= bill.getPayableAmt() %></td>
                        </tr>
                    <%  }
                    } else {
                        %>
                        <tr>
                            <td colspan="5">No bills found for the given consumer.</td>
                        </tr>
                        <%
                            }
                    %>
                    
                </table>
                
                <p>Total Amount: ₹<span id="totalAmount">0.00</span></p>
                <p>Bills Selected: <span id="sendbills"></span></p>
                <button type="submit">Proceed to Pay</button>
        	</form>
        </main>
    </div>
</body>
</html>
