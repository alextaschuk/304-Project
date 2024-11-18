<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

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

out.println("<table>");
out.println("<tr>");
	out.println("<th></th>");
	out.println("<th>Product Name</th>");
	out.println("<th>Price</th>");
out.println("</tr>");

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

			String link = "addcart.jsp?id=" + rs.getInt("productId") + "&name=" +rs.getString("productName") + "&price=" + rs.getDouble("productPrice");

			out.println("<tr>");
				out.println("<td><a href=\"" + link + "\">Add to Cart</a></td>");
				out.println("<td>" + rs.getString("productName") + "</td>");
				out.println("<td>" + currFormat.format(rs.getDouble("productPrice")) + "</td>");
			out.println("</tr>");

		}

		out.println("</table>");


	}
	catch (SQLException ex)
	{
		out.println("We ran into some trouble. Please try again later.");
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