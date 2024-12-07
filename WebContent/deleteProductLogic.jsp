<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<%
    session = request.getSession(true);
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";

    String id = request.getParameter("productId");
    Connection con = null;

    
    try {
        con = DriverManager.getConnection(url, uid, pw);
        // Start a transaction
        con.setAutoCommit(false);

        // Delete related rows in orderproduct table
        String deleteOrderProductSQL = "DELETE FROM orderproduct WHERE productId = ?";
        PreparedStatement pstmtOrderProduct = con.prepareStatement(deleteOrderProductSQL);
        pstmtOrderProduct.setString(1, id);
        pstmtOrderProduct.executeUpdate();

        // Delete related rows in productinventory table
        String deleteProductInventorySQL = "DELETE FROM productinventory WHERE productId = ?";
        PreparedStatement pstmtProductInventory = con.prepareStatement(deleteProductInventorySQL);
        pstmtProductInventory.setString(1, id);
        pstmtProductInventory.executeUpdate();

         // Delete the product from the product table (done last because of FK contstraints in the above tables)
        String deleteProductSQL = "DELETE FROM product WHERE productId = ?";
        PreparedStatement pstmtProduct = con.prepareStatement(deleteProductSQL);
        pstmtProduct.setString(1, id);
        pstmtProduct.executeUpdate();
        
        out.println("<p>Product deleted successfully!</p>");

        // Commit the transaction
        con.commit();

    } catch (SQLException e) {
        if(con != null){
            con.rollback();
                    out.println("<p>Error deleting product. Please try again.</p>" + e);
        }
        e.printStackTrace();
    } finally {
        if(con != null) {
            con.setAutoCommit(true);
            con.close();
        }
    }
%>
