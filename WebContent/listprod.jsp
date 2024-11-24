<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Sam and Alex's- Products</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>


<h1 align="center">Search for the Products You Want to Buy</h1>
<div align="center">
<form method="get" action="listprod.jsp">
<input type="text" placeholder="Leave blank for all products" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>
</div>


<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
String searchString = request.getParameter("productName");

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

String sql;
if (searchString == null) {
	sql = "SELECT * FROM product";
} else {
	out.println("<h1>Products containing '" + searchString + "'</h1>");
	sql = "SELECT * FROM product WHERE productName LIKE '%' + ? + '%'";
}

out.println("<table class='table table-striped'>");
out.println("<thead>");
out.println("<tr>");
	out.println("<th>Product Name</th>");
	out.println("<th>Price</th>");
	out.println("<th></th>");
out.println("</tr>");
out.println("</thead>");
out.println("<tbody>");

try (Connection con = DriverManager.getConnection(url, uid, pw);)
	{			
		PreparedStatement pstmt = con.prepareStatement(sql);

		if (searchString != null)
		{
			pstmt.setString(1, searchString);
		}

		ResultSet rs = pstmt.executeQuery();

		while (rs.next())
		{

			String addCartLink = "addcart.jsp?id=" + rs.getInt("productId") + "&name=" +rs.getString("productName") + "&price=" + rs.getDouble("productPrice");
			String productLink = "product.jsp?productId=" + rs.getInt("productId");

			out.println("<tr>");
				out.println("<td><a href=\"" + productLink + "\">" + rs.getString("productName") + "</a></td>");
				out.println("<td>" + currFormat.format(rs.getDouble("productPrice")) + "</td>");
				out.println("<td>");
				out.println("<form method=\"get\" action=\"addcart.jsp\">");
				out.println("<input type=\"hidden\" name=\"id\" value=\"" + rs.getInt("productId") + "\">");
				out.println("<input type=\"hidden\" name=\"name\" value=\"" + rs.getString("productName") + "\">");
				out.println("<input type=\"hidden\" name=\"price\" value=\"" + rs.getDouble("productPrice") + "\">");
				out.println("<input type=\"submit\" value=\"Add to Cart\" class=\"btn btn-primary\">");
				out.println("</form>");
				out.println("</td>");
			out.println("</tr>");

		}

		out.println("</tbody>");
		out.println("</table>");


	}
	catch (SQLException ex)
	{
		out.println("We ran into some trouble. Please try again later.");
		out.println("SQLException: " + ex);
		System.err.println("SQLException: " + ex);
	}


// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>