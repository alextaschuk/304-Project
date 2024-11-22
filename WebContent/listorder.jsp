<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Sam and Alex's- Order List</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		table {
			border-collapse: collapse;
			border: 1px solid black;
		}
		th, td {
			border: 1px solid black;
			padding: 5px;
		}

	</style>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
                <div class="container-fluid">
                
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
			  
<h1>Order List</h1>

<table>

<tr>

	<th> Order ID </th>
	<th> Order Date </th>
	<th> Customer ID </th>
	<th> Customer Name </th>
	<th> Total Amount </th>
</tr>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0));  // Prints $5.00

// Make connection

	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	try (Connection con = DriverManager.getConnection(url, uid, pw);
	          Statement stmt = con.createStatement();) 
	    {
			// Write query to retrieve all order summary records
			ResultSet rst = stmt.executeQuery("SELECT * FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId");

			//Use PreparedStatement as will repeat this query many times
			PreparedStatement pstmt = con.prepareStatement("SELECT * FROM orderproduct WHERE orderId = ?");

			// Write a query to retrieve the products in the order
			// For each order in the ResultSet
			while (rst.next())
			{	
				int orderId = rst.getInt("orderId");

				// Print out the order summary information
				out.println("<tr>");
				out.println("<td>" + orderId + "</td>");
				out.println("<td>" + rst.getDate("orderDate") + "</td>");
				out.println("<td>" + rst.getInt("customerId") + "</td>");
				out.println("<td>" + rst.getString("firstName") + " " + rst.getString("lastName") + "</td>");
				out.println("<td>" + currFormat.format(rst.getDouble("totalAmount")) + "</td>");
				out.println("</tr>");

				// Write out product information 
				out.println("<tr>");
				out.println("<td></td>");
				out.println("<td></td>");
				out.println("<td></td>");
				out.println("<td>");
					out.println("<table>");
						out.println("<tr>");
							out.println("<th> Product ID </th>");
							out.println("<th> Quantity </th>");
							out.println("<th> Price </th>");
							out.println("</tr>");

				// For each product in the order
				pstmt.setInt(1, orderId);
								
				ResultSet rst2 = pstmt.executeQuery();
				while (rst2.next())
				{
					// Write out product information 
					out.println("<tr>");
						out.println("<td>" + rst2.getInt("productId") + "</td>");
						out.println("<td>" + rst2.getInt("quantity") + "</td>");
						out.println("<td>" + currFormat.format(rst2.getDouble("price")) + "</td>");
					out.println("</tr>");

				}

				out.println("</table>");
				out.println("</td>");
				out.println("</tr>");


			}
		}
		catch (SQLException ex)
		{
			out.println("We ran into some trouble. Please try again later.");
			System.err.println("SQLException: " + ex);
		}
%>

</table>
</body>
</html>

