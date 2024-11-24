<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<style>
	body {
		text-align: center;
	}
	table {
		margin: 0 auto;
	}
</style>
</head>
<body>
<h3>Sign In To Account</h3>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%
	authenticated = session.getAttribute("authenticatedUser") == null ? false : true; // if user is not logged in, show this message
	if(!authenticated){
		session.setAttribute("loginMessage","Please log in to view customer info.");        
	} else { 
		String userName = (String) session.getAttribute("authenticatedUser"); // otherwise, print customer info.
	}

String sql = "SELECT customerId AS Id, firstName AS \"First Name\", lastName AS LastName, email AS Email, phonenum AS Phone, address AS Adress, city AS City, state AS State, postalCode AS \"Postal Code\", country AS Country, userid AS \"User id\" FROM customer WHERE userid LIKE ?";

try 
		{
			String userName = (String) session.getAttribute("authenticatedUser"); 
			getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userName);

			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				out.println("<table border='1'>");
				out.println("<tr><td>Id</td><td>" + rs.getInt("Id") + "</td></tr>");
				out.println("<tr><td>First Name</td><td>" + rs.getString("First Name") + "</td></tr>");
				out.println("<tr><td>Last Name</td><td>" + rs.getString("LastName") + "</td></tr>");
				out.println("<tr><td>Email</td><td>" + rs.getString("Email") + "</td></tr>");
				out.println("<tr><td>Phone</td><td>" + rs.getString("Phone") + "</td></tr>");
				out.println("<tr><td>Address</td><td>" + rs.getString("Adress") + "</td></tr>");
				out.println("<tr><td>City</td><td>" + rs.getString("City") + "</td></tr>");
				out.println("<tr><td>State</td><td>" + rs.getString("State") + "</td></tr>");
				out.println("<tr><td>Postal Code</td><td>" + rs.getString("Postal Code") + "</td></tr>");
				out.println("<tr><td>Country</td><td>" + rs.getString("Country") + "</td></tr>");
				out.println("<tr><td>User id</td><td>" + rs.getString("User id") + "</td></tr>");
				out.println("</table>");
			}
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}

%>

</body>
</html>
