<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Sam and Alex's- Order Processing</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
                <div class="container-fluid">
                
                  <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="shop.html">Home</a>
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

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

// Determine if there are products in the shopping cart
// If either are not true, display an error message
if (productList == null || productList.size() == 0) {
	out.println("<h1>No products in shopping cart. Go back to the previous page and add items.</h1>");
} else if( custId == null || custId.isEmpty() ) {
	out.println("<h1>Invalid customer id. Go back to the previous page and try again.</h1>");
} else {
	// Make connection
	try (Connection con = DriverManager.getConnection(url, uid, pw);) {
		// Check if customer id is valid
		String sql = "SELECT * FROM customer WHERE customerId=?";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, custId);

		ResultSet rs = pstmt.executeQuery();
		if(!rs.next())
		{
			out.println("<h1>Invalid customer id: " + custId + "</h1>");
		}
		else
		{
			String customerName = rs.getString("firstName") + " " + rs.getString("lastName");

			out.println("<h1>Order Summary</h1>");
			
			// Save order information to database
			// Use retrieval of auto-generated keys.
			sql = "INSERT INTO ordersummary (orderDate, customerId) VALUES (GETDATE(), ?)";
			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
			pstmt.setString(1, custId);
			pstmt.executeUpdate();

			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);


			// Insert each item into OrderProduct table using OrderId from previous INSERT
			sql = "INSERT INTO orderproduct(orderId, productId, quantity, price) VALUES (?,?,?,?)";
			out.println("<table>");


			out.println("<tr>");
				out.println("<th>Product ID</th>");
				out.println("<th>Product Name</th>");
				out.println("<th>Quantity</th>");
				out.println("<th>Price</th>");
				out.println("<th>Subtotal</th>");
			out.println("</tr>");

			double total = 0.0;
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext()) { 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
				String productName = (String) product.get(1);
				String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ( (Integer)product.get(3)).intValue();
				double subtotal = pr * qty;
				total += subtotal;

				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, orderId);
				pstmt.setString(2, productId);
				pstmt.setInt(3, qty);
				pstmt.setDouble(4, pr);
				pstmt.executeUpdate();

				out.println("<tr>");
					out.println("<td>" + productId + "</td>");
					out.println("<td>" + productName + "</td>");
					out.println("<td>" + qty + "</td>");
					out.println("<td>" + NumberFormat.getCurrencyInstance().format(pr) + "</td>");
					out.println("<td>" + NumberFormat.getCurrencyInstance().format(subtotal) + "</td>");
				out.println("</tr>");
			}
			
			out.println("<tr>");
				out.println("<td></td>");
				out.println("<td></td>");
				out.println("<td></td>");
				out.println("<td>Total</td>");
				out.println("<td>" + NumberFormat.getCurrencyInstance().format(total) + "</td>");
			out.println("</tr>");

			out.println("</table>");

			// Update total amount for order record
			sql = "UPDATE ordersummary SET totalAmount=? WHERE orderId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setDouble(1, total);
			pstmt.setInt(2, orderId);
			pstmt.executeUpdate();

			// Clear cart
			session.removeAttribute("productList");

			out.println("<h1>Order completed. Will be shipped soon...</h1>");
			out.println("<h1>Your order reference number is:" + orderId + " </h1>");
			out.println("<h1>Shipping to customer: " + custId + " Name:" + customerName + "</h1>");

		}
	}
	catch (SQLException e)
	{
		out.println("SQL Exception: " + e.getMessage());
	}
}
%>
</BODY>
</HTML>

