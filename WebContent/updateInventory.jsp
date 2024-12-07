<!DOCTYPE html>
<html>
<head>
    <title>Edit Inventory</title>
</head>
<body>

    <%@ include file="auth.jsp" %>
    <%@ include file="jdbc.jsp" %>
    <%@ include file="header.jsp" %>

    <%

        String warehouseName = request.getParameter("warehouseName");
        String productName = request.getParameter("productName");
        int oldQuant = Integer.parseInt(request.getParameter("quantity"));


        // SQL query to update the product's inventory quantity
String updateQuery = "UPDATE pi " +
                     "SET pi.quantity = ? " +
                     "FROM productinventory pi " +
                     "JOIN warehouse w ON pi.warehouseId = w.warehouseId " +
                     "JOIN product p ON pi.productId = p.productId " +
                     "WHERE w.warehouseName = ? AND p.productName = ?";


        try (Connection con = DriverManager.getConnection(url, uid, pw);) {


            PreparedStatement pstmt = con.prepareStatement(updateQuery);

            // Set parameters for the query
            pstmt.setInt(1, oldQuant);  // The new quantity
            pstmt.setString(2, warehouseName);  // The warehouse name
            pstmt.setString(3, productName);  // The product name

            // Execute the update query
            int rowsAffected = pstmt.executeUpdate();

            // Check if the update was successful
            if (rowsAffected > 0) {
                out.print("<div> Successfully changed " + warehouseName + "'s inventory of product " + productName + " to now " + oldQuant + " units.</div>");
            } else {
                out.print("<div> No records updated. Please check the warehouse and product names.</div>");
            }


        } catch (SQLException e) {
            out.print(e.getMessage());

        }


    %>
</body>