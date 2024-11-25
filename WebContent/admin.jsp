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
}
catch (SQLException e)
{
    out.println("Error: "+e);
}

%>

</body>
</html>

