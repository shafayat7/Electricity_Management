<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "com.model.Complaint" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Active Complaints</title>
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
   
    flex-direction: column;
}
        
        h2.success {
            color: green;
        }
        h2.error {
            color: red;
        }
       
        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table th, table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        table th {
            background-color: black;
            color: white;
        }
       	table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
       
        .error {
            color: red;
            margin-top: 10px;
        }
        .search-bar {
            margin: 20px 0;
        }
        .log-out{
        
        width: 125px
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
            <h1>Active Complaints</h1>
             <div class="welcome">
        
                <div style="color:black;">
                    <b>Welcome, <span id="usernameDisplay"><%= session.getAttribute("userID") %></span><br></b>
                </div>
                <form action="LogoutServlet">
                    <button class="log-out" type="submit" >Logout</button>
                </form>
            </div>
            
        </div>

     <div class="nav-bar">
            <ul>
                <li><a href="home">Home</a></li>
                <li><a href="active.jsp">Active Complaints</a></li>
                <li><a href="adminStatus.jsp">Complaint Status</a></li>
               <li><a href="feedback.jsp">Feedback</a></li>
            </ul>
        </div>



    <div class="search-bar">
        <form action="ActiveServlet" method="GET">
            <label for="search">Search by Complaint ID:</label>
            <input type="text" id="search" name="search" placeholder="Enter name or date...">
            <button type="submit">Search</button>
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th>Complaint ID</th>
                <th>Problem</th>
                <th>Consumer No</th>
                <th>Address</th>
                <th>Complaint Type</th>
                <th>Category</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Complaint> complaints = (List<Complaint>) session.getAttribute("activeComplaints");
                if (complaints != null && !complaints.isEmpty()) {
                    for (Complaint complaint : complaints) {
            %>
            <tr>
                <td><%= complaint.getComplaintId() %></td>
                <td><%= complaint.getProblem() %></td>
                <td><%= complaint.getConsumerNo() %></td>
                <td><%= complaint.getAddress() %></td>
                <td><%= complaint.getComplaintType() %></td>
                <td><%= complaint.getCategory() %></td>
                <td><%= complaint.getStatus() %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7">No active complaints found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <script>
        function logout() {
            alert('Logged out successfully.');
            window.location.href = 'login.jsp';
        }
    </script>
    
    </div>
</body>
</html>