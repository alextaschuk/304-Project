<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Sam & Alex's Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
        String orderId = request.getParameter("orderId");
	
	// TODO: Check if valid order id in database
	if (orderId == null || orderId.trim().isEmpty()) {
		throw new IllegalArgumentException("Invalid order ID.");
	}

	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";

	
	Connection con = null;
	int productId = 0;
	try {
		con = DriverManager.getConnection(url, uid, pw);

		// TODO: Start a transaction (turn-off auto-commit)
		con.setAutoCommit(false);
		
		// TODO: Retrieve all items in order with given id
		String selectAllOrderProductsWithGivenId = "SELECT * FROM orderproduct WHERE orderId = ?";
		PreparedStatement orderedProductsStatement = con.prepareStatement(selectAllOrderProductsWithGivenId);
		orderedProductsStatement.setString(1, orderId);
		ResultSet orderedProducts = orderedProductsStatement.executeQuery();

		if (!orderedProducts.isBeforeFirst()) {
			throw new IllegalArgumentException("No products found for the given order ID.");
		}

		// TODO: Create a new shipment record.
		String createNewShipment = "INSERT INTO shipment (shipmentDate, warehouseId) VALUES (GETDATE(), 1)";
		PreparedStatement pstmt = con.prepareStatement(createNewShipment, Statement.RETURN_GENERATED_KEYS);
		pstmt.executeUpdate();



		// TODO: For each item verify sufficient quantity available in warehouse 1.
		String getInventoryInWarehouse = "SELECT quantity FROM productinventory WHERE warehouseId = 1 AND productId = ?";
		int inWarehouseInventory = 0;
		int orderQuantityRequest = 0;
		int newInventory = 0;
		while(orderedProducts.next()) {

			productId = orderedProducts.getInt("productId");
			orderQuantityRequest = orderedProducts.getInt("quantity");

			PreparedStatement getInventoryInWarehouseStatement = con.prepareStatement(getInventoryInWarehouse);
			getInventoryInWarehouseStatement.setInt(1, productId);
			
			ResultSet rs = getInventoryInWarehouseStatement.executeQuery();

			rs.next();
			inWarehouseInventory = rs.getInt("quantity");

			// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
			if(inWarehouseInventory < orderQuantityRequest) throw new SQLException();
			else {
				newInventory = inWarehouseInventory - orderQuantityRequest;
				out.println("<p>Ordered Product ID: " + productId + " Qty: " + orderQuantityRequest + " Previous inventory: " + inWarehouseInventory + " New Inventory: " + (newInventory) + "</p>");

				// Update the prouctID's quantity with newInventory in productinventory table
				String updateQuantity = "UPDATE productinventory SET quantity = ? WHERE productId = ?";
				PreparedStatement update = con.prepareStatement(updateQuantity);
				update.setInt(1, newInventory);
				update.setInt(2, orderedProducts.getInt("productId"));
				pstmt.executeUpdate();

			}

		}

		
		con.commit();

	} catch (SQLException e){
		if(con != null) {
			con.rollback();
			out.println("<h1>Shipment unsuccessful. Insufficient product inventory for product id: " + productId +  "</h1>");
		}
		
		e.printStackTrace();
	} catch (IllegalArgumentException e) {
		out.println("<p>Invalid order ID.</p>");
	} finally {
		if(con != null) {
			con.setAutoCommit(true);
			con.close();
		}
	}
	

%>                       				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
