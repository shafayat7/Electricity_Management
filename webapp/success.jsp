<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Success</title>
    <style>
     body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #f0f0f0;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header div {
            font-weight: bold;
        }
        .nav-bar {
    background-color: #333;
    padding: 10px;
}
h1, h2, h3 {
    color: #333;
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
        .container {
           width: 80%;
    margin: 0 auto;
    padding: 20px;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-header {
            
            color: black;
            padding: 10px;
            margin-bottom: 20px;
            font-size: 18px;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
        }
        .required:before {
            content: " *";
            color: red;
        }
        input, textarea, select {
            width: 80%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .button-container {
            margin-top: 20px;
        }
     
        .submit-btn {
            background-color: black;
            color: white;
        }
        .cancel-btn {
            background-color: grey;
            color: white;
            margin-left: 10px;
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
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
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
.welcome {
    text-align: right;
}

form {
    display: flex;
    flex-direction: column;
}
        h2.success {
            color: green;
        }
        h2.error {
            color: red;
        }
    </style>
</head>
<body>

    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        if (session.getAttribute("userID") == null) {
            response.sendRedirect("index.jsp");
        }
    %>
    
    <div class="container">
     <div class="top-bar">
            <h1>Register Complaint</h1>
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

    
        <h2 class="<% 
            HttpSession sess = request.getSession(false);
            if (sess != null && sess.getAttribute("messageType") != null) {
                out.print(sess.getAttribute("messageType"));  // Set the class as 'success' or 'error'
            } %>">
            <%
                if (sess != null && sess.getAttribute("message") != null) {
                    out.print(sess.getAttribute("message"));  // Print the actual message
                }
            %>
        </h2>
        <%
            if (sess != null && sess.getAttribute("messageType") != null && sess.getAttribute("messageType").equals("success")) {
        %>
            <p>Your Complaint ID: 
                <strong>
                    <%
                        if (sess.getAttribute("complaintId") != null) {
                            out.print(sess.getAttribute("complaintId"));
                        }
                    %>
                </strong>
            </p>
        <%
            }
        %>
        <div class="button-container">
            <a href="complaintRegister.jsp"><button>Register New Complaint</button></a>
        </div>
    </div>
   
</body>

<script>
   
</script>
</html>