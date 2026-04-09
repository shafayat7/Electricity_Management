<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Electricity Management System</title>
    
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

        h1, h2 {
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-top: 10px;
        }

        input, select {
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

        .success {
            color: green;
        }

        .error {
            color: red;
        }
.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #4CAF50;
    padding: 10px;
    color: white;
}
       
    </style>
</head>
<body>

   <div class="container">
     <div class="top-bar">
            <h1>Electricity Management System</h1>
           
         
        </div>
      <div>
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            User ID: <input type="text" name="userID" required><br>
            Password: <input type="password" name="password" required><br>
            <button type="submit">Login</button>
        </form>
    </div>
    </div>
    
     <!-- Display Messages -->
     <div class="container">
    <div>
        <% 
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null) {
                out.print("<p class='" + messageType + "'>" + message + "</p>");
            }
        %>
    </div>
    </div>
    
    <div class="container">
    <div>
        <h2>New User? Register Below</h2>
        <form action="RegistrationServlet" method="post">
            Consumer ID: <input type="text" name="consumerID" minlength="13" maxlength="13" required><br>
            Title: 
            <select name="title">
                <option>Mr.</option>
                <option>Ms.</option>
                <option>Mrs.</option>
            </select><br>
            Customer Name: <input type="text" name="customerName" maxlength="50" required><br>
            Email: <input type="email" name="email" required><br>
            Mobile Number: 
            <select name="countryCode">
                <option value="+91">+91</option>
                <option value="+1">+1</option>
            </select>
            <input type="text" name="mobileNumber" maxlength="10" required><br>
            User ID: <input type="text" name="userID" minlength="5" maxlength="20" required><br>
            Password: <input type="password" name="password" maxlength="30" required><br>
            Confirm Password: <input type="password" name="confirmPassword" maxlength="30" required><br>
            <button type="submit">Submit</button>
            <button type="reset">Reset</button>
        </form>
    </div>

   

   
    
    </div>
</body>
</html>