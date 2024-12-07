<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<%
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
StringBuilder errorMessage = new StringBuilder();
boolean hasError = false;

if (productList != null) {
    for (String key : productList.keySet()) {
        String paramName = "quantity_" + key;
        String newQuantityStr = request.getParameter(paramName);
        if (newQuantityStr != null) {
            int newQuantity = Integer.parseInt(newQuantityStr);
            ArrayList<Object> product = productList.get(key);
            int oldQuantity = (int) product.get(3); // Get the old quantity

            // Check available inventory
            int availableInventory = 0;
            try (Connection con = DriverManager.getConnection("jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True", "sa", "304#sa#pw");
                 PreparedStatement pstmt = con.prepareStatement("SELECT quantity FROM productinventory WHERE productId = ?")) {
                pstmt.setString(1, key);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    availableInventory = rs.getInt("quantity");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (newQuantity > availableInventory) {
                hasError = true;
                errorMessage.append("Error: Only ").append(availableInventory).append(" units of ").append(product.get(1)).append(" are available.<br>");
                newQuantity = oldQuantity; // Set newQuantity to oldQuantity if it exceeds availableInventory
            }
            product.set(3, newQuantity); // Update quantity
        }
    }
}

if (hasError) {
    session.setAttribute("errorMessage", errorMessage.toString());
} else {
    session.removeAttribute("errorMessage");
}

response.sendRedirect("showcart.jsp");
%>