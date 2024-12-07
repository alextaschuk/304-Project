<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%
// Page to view all orders for a given customer
%>

<!DOCTYPE html>
<html>
<head>
    <title>Sam and Alex's- Customer Order</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-top: 50px;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            margin-bottom: 20px;
        }
        th, td {
            text-align: center;
            padding: 10px;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .btn-primary {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Sam and Alex's</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="listprod.jsp">View Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="listorder.jsp">List All Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="showcart.jsp">View Cart</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
              
<div class="container">
    <h1>Order List</h1>

    <form method="get" action="listCustOrder.jsp" class="mb-4">
        <div class="mb-3">
            <label for="customerId" class="form-label">Select Customer:</label>
            <select name="customerId" id="customerId" class="form-select" required>
                <option value="">--Select Customer--</option>
                <%
                    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
                    String uid = "sa";
                    String pw = "304#sa#pw";

                    try (Connection con = DriverManager.getConnection(url, uid, pw);
                         Statement stmt = con.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT customerId, firstName, lastName FROM customer")) {

                        while (rs.next()) {
                            int customerId = rs.getInt("customerId");
                            String customerName = rs.getString("firstName") + " " + rs.getString("lastName");
                            out.println("<option value=\"" + customerId + "\">" + customerName + "</option>");
                        }
                    } catch (SQLException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">View Orders</button>
    </form>

    <%
        String selectedCustomerId = request.getParameter("customerId");
        if (selectedCustomerId != null && !selectedCustomerId.isEmpty()) {
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();

            try (Connection con = DriverManager.getConnection(url, uid, pw);
                 PreparedStatement pstmt = con.prepareStatement("SELECT * FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId WHERE customer.customerId = ?")) {

                pstmt.setInt(1, Integer.parseInt(selectedCustomerId));
                ResultSet rst = pstmt.executeQuery();

                PreparedStatement pstmtOrderProduct = con.prepareStatement("SELECT * FROM orderproduct WHERE orderId = ?");

                while (rst.next()) {
                    int orderId = rst.getInt("orderId");

                    out.println("<table class='table table-bordered'>");
                    out.println("<thead>");
                    out.println("<tr>");
                    out.println("<th>Order ID</th>");
                    out.println("<th>Order Date</th>");
                    out.println("<th>Customer ID</th>");
                    out.println("<th>Customer Name</th>");
                    out.println("<th>Total Amount</th>");
                    out.println("</tr>");
                    out.println("</thead>");
                    out.println("<tbody>");
                    out.println("<tr>");
                    out.println("<td>" + orderId + "</td>");
                    out.println("<td>" + rst.getDate("orderDate") + "</td>");
                    out.println("<td>" + rst.getInt("customerId") + "</td>");
                    out.println("<td>" + rst.getString("firstName") + " " + rst.getString("lastName") + "</td>");
                    out.println("<td>" + currFormat.format(rst.getDouble("totalAmount")) + "</td>");
                    out.println("</tr>");
                    out.println("</tbody>");
                    out.println("</table>");

                    out.println("<table class='table table-sm table-bordered'>");
                    out.println("<thead>");
                    out.println("<tr>");
                    out.println("<th>Product ID</th>");
                    out.println("<th>Quantity</th>");
                    out.println("<th>Price</th>");
                    out.println("</tr>");
                    out.println("</thead>");
                    out.println("<tbody>");

                    pstmtOrderProduct.setInt(1, orderId);
                    ResultSet rst2 = pstmtOrderProduct.executeQuery();
                    while (rst2.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rst2.getInt("productId") + "</td>");
                        out.println("<td>" + rst2.getInt("quantity") + "</td>");
                        out.println("<td>" + currFormat.format(rst2.getDouble("price")) + "</td>");
                        out.println("</tr>");
                    }

                    out.println("</tbody>");
                    out.println("</table>");
                }
            } catch (SQLException ex) {
                out.println("We ran into some trouble. Please try again later.");
                System.err.println("SQLException: " + ex);
            }
        }
    %>
</div>

</body>
</html>