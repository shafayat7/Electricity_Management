<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Details</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
	<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("userID") == null) {
        response.sendRedirect("index.jsp");
    }
    String cid = (String) session.getAttribute("userID"); %>

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

    <div class="container">
        <h1>Payment Successful</h1>
        
        <p>Name : <%= request.getAttribute("cardholdername") %></p>
        
        <p>Amount : ₹<%= request.getAttribute("total") %></p>
        
        
        <p>Transaction ID: <%= request.getAttribute("transactionId") %></p>

        <h3>Paid Bills</h3>
        <ul>
            <% 
                ArrayList<String> billNumbers = (ArrayList<String>) request.getAttribute("billNumbers");
                if (billNumbers != null) {
                    for (String billNumber : billNumbers) {
            %>
                        <li>Bill Number: <%= billNumber %></li>
            <% 
                    }
                } 
            %>
        </ul>
        <button onclick="window.print()">Print Transaction Details</button>
    </div>
 </div>
</body>
</html>