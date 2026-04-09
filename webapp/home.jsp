<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.dao.MonthlyUnitsDAO" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="style.css">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Month', 'Units Consumed'],
                <%
                    // Fetch units consumed for the last 5 months from the database
                    String userID = (String) session.getAttribute("userID");
                    if (userID != null) {
                        MonthlyUnitsDAO dao = new MonthlyUnitsDAO();
                        List<Map<String, Object>> monthlyData = dao.getLastFiveMonthsUnits(userID);
                        String[] monthNameArr={"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
                        for (int i = 0; i < monthlyData.size(); i++) {
                            Map<String, Object> row = monthlyData.get(i);
                            int month = (int) row.get("month");
                            int units = (int) row.get("units");
                            String monthName = monthNameArr[month-1]; // Helper function to convert month number to name

                            if (i == monthlyData.size() - 1) {
                                out.print("['" + monthName + "', " + units + "]");
                            } else {
                                out.print("['" + monthName + "', " + units + "],");
                            }
                        }
                    } else {
                        out.print("['No Data', 0]");
                    }
                %>
            ]);

            var options = {
                title: '',
                is3D: true
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart'));

            chart.draw(data, options);
        }

     
    </script>
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
            <h1>Electricity Management System</h1>
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
                <li><a href="BillServlet">PayBill</a></li>
                <li><a href="complaintRegister.jsp">Register Complaint</a></li>
               <li> <a href="complaintStatus.jsp">Complaint Status</a></li>
            </ul>
        </div>

        <div class="content">
            <h2>Units Consumed in Last 5 Months</h2>
            <div id="piechart" style="width: 900px; height: 500px;"></div>
        </div>
    </div>
</body>
</html>
