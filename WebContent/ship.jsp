<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>

<html>
<head>
    <title>Grocery Shipment Processing</title>
</head>
<body>

<%
    String orderId = request.getParameter("orderId");
    if (orderId == null || orderId.trim().isEmpty()) {
        out.println("<p>Error: Invalid or missing Order ID.</p>");
        return;
    }

    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";

    try (Connection con = DriverManager.getConnection(url, uid, pw)) {
        con.setAutoCommit(false);

        // Check if order exists
        String checkOrderSQL = "SELECT productId, quantity FROM orderproduct WHERE orderID = ?";
        PreparedStatement checkOrderStmt = con.prepareStatement(checkOrderSQL);
        checkOrderStmt.setString(1, orderId);
        ResultSet orderItems = checkOrderStmt.executeQuery();
        if (!orderItems.isBeforeFirst()) {
            out.println("<p>Error: Order ID not found in the database.</p>");
            return;
        }

        // Insert a new shipment row
        String insertShipmentSQL = "INSERT INTO shipment (shipmentId, shipmentDate, shipmentDesc, warehouseId) VALUES (?, ?, ?, ?)";
        PreparedStatement insertShipmentStmt = con.prepareStatement(insertShipmentSQL, Statement.RETURN_GENERATED_KEYS);
        insertShipmentStmt.setDate(1, new java.sql.Date(new Date().getTime()));
        insertShipmentStmt.setString(2, "Shipment for Order ID: " + orderId);
        insertShipmentStmt.setInt(3, 1);
        insertShipmentStmt.executeUpdate();

        ResultSet generatedKeys = insertShipmentStmt.getGeneratedKeys();
        int shipmentId;
        if (generatedKeys.next()) {
            shipmentId = generatedKeys.getInt(1);
        } else {
            out.println("<p>Error: Could not create shipment record.</p>");
            con.rollback();
            return;
        }
		int currentQuantity = 0;
		int orderQuantity = 0;
        // Validate inventory and update quantities
        boolean hasError = false;
        while (orderItems.next()) {
            int productId = orderItems.getInt("productId");
            orderQuantity = orderItems.getInt("quantity");

            String checkInventorySQL = "SELECT quantity FROM productInventory WHERE productId = ?";
            PreparedStatement checkInventoryStmt = con.prepareStatement(checkInventorySQL);
            checkInventoryStmt.setInt(1, productId);
            ResultSet inventoryResult = checkInventoryStmt.executeQuery();

            if (inventoryResult.next()) {
                currentQuantity = inventoryResult.getInt("quantity");
                if (currentQuantity < orderQuantity) {
                    hasError = true;
                    break;
                } else {
                    String updateInventorySQL = "UPDATE productInventory SET quantity = quantity - ? WHERE productId = ?";
                    PreparedStatement updateInventoryStmt = con.prepareStatement(updateInventorySQL);
                    updateInventoryStmt.setInt(1, orderQuantity);
                    updateInventoryStmt.setInt(2, productId);
                    updateInventoryStmt.executeUpdate();
                }
            } else {
                hasError = true;
                break;
            }
        }

        if (hasError) {
            // Rollback transaction and delete shipment row
            String deleteShipmentSQL = "DELETE FROM shipment WHERE shipmentId = ?";
            PreparedStatement deleteShipmentStmt = con.prepareStatement(deleteShipmentSQL);
            deleteShipmentStmt.setInt(1, shipmentId);
            deleteShipmentStmt.executeUpdate();

            con.rollback();
            out.println("<p>Error: Insufficient inventory for one or more products. Shipment canceled.</p>");
            return;
        }

        // Commit transaction if everything is successful
        con.commit();
		int newInventory = currentQuantity - orderQuantity;
        out.println("<p>Ordered Product: " + shipmentId + " Qty: " + orderQuantity + " Previous Inventory: " + currentQuantity + " New Inventory:" + newInventory + " </p>");

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error processing shipment. Please try again later.</p>");
    }
%>

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>