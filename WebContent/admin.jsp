<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<form method="get" action="createNewProduct.jsp">
<input type="submit" value="Add Product">
</form>
<%

String user = (String)session.getAttribute("authenticatedUser");

// TODO: Write SQL query that prints out total order amount by day\
String sql = "SELECT YEAR(orderDate) AS Y, MONTH(orderDate) AS M, DAY(orderDate) AS D, SUM(totalAmount) as total FROM ordersummary GROUP BY YEAR(orderDate), MONTH(orderDate), DAY(orderDate)";

try (Connection con = DriverManager.getConnection(url, uid, pw);) {

    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(sql);

    out.println("<h1 align=\"center\">Total Order Amount by Day</h1>");
    out.println("<table border=\"1\" align=\"center\">");
    out.println("<tr><th>Order Date</th><th>Total</th></tr>");

    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    while (rs.next())
    {
        out.println("<tr>");
        out.println("<td>"+ rs.getString("Y") + "-" + rs.getString("M") + "-" + rs.getString("D") + "</td>");
        out.println("<td>"+ currFormat.format(rs.getDouble("total"))+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");

// List all customers
    String getCustomers = "SELECT customerId, firstName, lastName FROM customer";
    PreparedStatement pstmt = con.prepareStatement(getCustomers);
    ResultSet results = pstmt.executeQuery();
    out.println("<h1 align=\"center\">All Customers</h1>");
    out.println("<table border=\"1\" align=\"center\" style=\"border-collapse: collapse;\">");
    out.println("<tr>");
    out.println("<th style=\"width: 30%; text-align: center; vertical-align: middle;\">ID</th>");
    out.println("<th style=\"text-align: center; vertical-align: middle;\">Customer Name</th>");
    out.println("</tr>");
    while(results.next())
	 {
	  out.print("<tr style='border: 2px solid rgb(184, 184, 184)'><td style='text-align: center; border: 2px solid rgb(184, 184, 184)'>"+results.getString(1)+"</td>");
	  out.println("<td style='text-align: center; border: 2px solid rgb(184, 184, 184)'>"+results.getString(2)+" "+results.getString(3)+"</td></tr>");
	 }
    out.print("</table>");
    }
    catch (SQLException e) {
        out.println("Error: "+e);
    }   
%>
</body>
</html>

