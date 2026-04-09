<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Complaint/Service</title>
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

    
        <div class="form-header"><b>File New Complaint</b></div>
        <form action="ComplaintServlet" method="POST" id="complaintForm">
            <div class="form-grid">
                <div>
                    <label for="complaintType" class="required">Complaint/Service Type:</label>
                    <select name="complaintType" id="complaintType" onchange="populateCategories()" required>
                        <option value="">Select Type</option>
                        <option value="billing">Billing Related</option>
                        <option value="voltage">Voltage Related</option>
                        <option value="disruption">Frequent Disruption</option>
                        <option value="street_light">Street Light Related</option>
                        <option value="pole">Pole Related</option>
                    </select>
                </div>
                <div>
                    <label for="category" class="required">Category:</label>
                    <select name="category" id="category" required>
                        <option value="">Select Category</option>
                    </select>
                </div>

                <div>
                    <label for="contactPerson">Contact Person:</label>
                    <input type="text" name="contactPerson" id="contactPerson" placeholder="Contact Person">
                </div>
                <div>
                    <label for="landmark">Landmark:</label>
                    <input type="text" name="landmark" id="landmark" placeholder="Landmark">
                </div>

                <div>
                    <label for="consumerNo" class="required">Consumer Number:</label>
                    <input type="text" name="consumerNo" id="consumerNo" maxlength="13" placeholder="Consumer Number" required>
                </div>
                <div>
                    <label for="problemDescription" class="required">Problem Description:</label>
                    <textarea name="problemDescription" id="problemDescription" rows="2" placeholder="Problem Description" required></textarea>
                </div>

                <div>
                    <label for="mobileNumber" class="required">Mobile Number:</label>
                    <input type="number" name="mobileNumber" id="mobileNumber" placeholder="Mobile Number" pattern=".{9}" required>
                </div>
                <div>
                    <label for="address" class="required">Address:</label>
                    <textarea name="address" id="address" rows="2" placeholder="Address" required></textarea>
                </div>
            </div>

            <div class="button-container">
                <button type="submit" class="submit-btn">Submit Complaint</button>
                <button type="reset" class="cancel-btn">Cancel</button>
            </div>
        </form>
    </div>

    <script>
        function populateCategories() {
            const complaintType = document.getElementById('complaintType').value;
            const category = document.getElementById('category');
            category.innerHTML = '';

            const categories = {
                billing: ['Incorrect Bill', 'Late Payment'],
                voltage: ['Low Voltage', 'High Voltage'],
                disruption: ['Power Outage', 'Intermittent Supply'],
                street_light: ['Non-functional Light', 'Light Flickering'],
                pole: ['Leaning Pole', 'Broken Pole']
            };

            if (categories[complaintType]) {
                categories[complaintType].forEach(cat => {
                    const option = document.createElement('option');
                    option.value = cat;
                    option.textContent = cat;
                    category.appendChild(option);
                });
            }
        }

       

    </script>
</body>
</html>