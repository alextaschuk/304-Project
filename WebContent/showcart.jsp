<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sam and Alex's - Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container text-center mt-4">
    <h1 class="d-inline-flex align-items-center">
        Your Shopping Cart
        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-basket2 ms-2" viewBox="0 0 16 16">
            <path d="M4 10a1 1 0 0 1 2 0v2a1 1 0 0 1-2 0zm3 0a1 1 0 0 1 2 0v2a1 1 0 0 1-2 0zm3 0a1 1 0 1 1 2 0v2a1 1 0 0 1-2 0z"/>
            <path d="M5.757 1.071a.5.5 0 0 1 .172.686L3.383 6h9.234L10.07 1.757a.5.5 0 1 1 .858-.514L13.783 6H15.5a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-.623l-1.844 6.456a.75.75 0 0 1-.722.544H3.69a.75.75 0 0 1-.722-.544L1.123 8H.5a.5.5 0 0 1-.5-.5v-1A.5.5 0 0 1 .5 6h1.717L5.07 1.243a.5.5 0 0 1 .686-.172zM2.163 8l1.714 6h8.246l1.714-6z"/>
        </svg>
    </h1>
</div>

<%
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null) {
    out.println("<h1 class='text-center'>Your shopping cart is empty!</h1>");
    productList = new HashMap<String, ArrayList<Object>>();
} else {
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    double total = 0;
    boolean hasError = false;
    StringBuilder errorMessage = new StringBuilder();

    // Display error message if it exists
    String sessionErrorMessage = (String) session.getAttribute("errorMessage");
    if (sessionErrorMessage != null) {
        out.println("<div class='alert alert-danger mt-3'>" + sessionErrorMessage + "</div>");
        session.removeAttribute("errorMessage");
    }

    out.println("<form action=\"updatecart.jsp\" method=\"post\">");
    out.print("<table class=\"table\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th><th>Action</th></tr>");

    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
    while (iterator.hasNext()) {
        Map.Entry<String, ArrayList<Object>> entry = iterator.next();
        ArrayList<Object> product = entry.getValue();
        if (product.size() < 4) {
            out.println("Expected product with four entries. Got: " + product);
            continue;
        }

        String productId = (String) product.get(0);
        String productName = (String) product.get(1);
        double price = Double.parseDouble(product.get(2).toString());
        int quantity = Integer.parseInt(product.get(3).toString());

        // Check available inventory
        int availableInventory = 0;
        try (Connection con = DriverManager.getConnection("jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True", "sa", "304#sa#pw");
             PreparedStatement pstmt = con.prepareStatement("SELECT quantity FROM productinventory WHERE productId = ?")) {
            pstmt.setString(1, productId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                availableInventory = rs.getInt("quantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (quantity > availableInventory) {
            hasError = true;
            errorMessage.append("Error: Only ").append(availableInventory).append(" units of ").append(productName).append(" are available.<br>");
        }

        double subtotal = price * quantity;
        total += subtotal;

        out.print("<tr>");
        out.print("<td>" + productId + "</td>");
        out.print("<td>" + productName + "</td>");
        out.print("<td><input type=\"number\" name=\"quantity_" + productId + "\" value=\"" + quantity + "\" min=\"1\" class=\"form-control\" style=\"width: 80px;\"></td>");
        out.print("<td align=\"right\">" + currFormat.format(price) + "</td>");
        out.print("<td align=\"right\">" + currFormat.format(subtotal) + "</td>");
        out.print("<td><a href=\"removecart.jsp?productId=" + productId + "\" class=\"btn btn-danger btn-sm\">Remove</a></td>");
        out.print("</tr>");
    }

    out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
            + "<td align=\"right\">" + currFormat.format(total) + "</td><td></td></tr>");
    out.println("</table>");

    // Update Cart Button
    if (!hasError) {
        out.println("<button type=\"submit\" class=\"btn btn-primary\">Update Cart</button>");
    }
    out.println("</form>");

    // Checkout and Continue Shopping Buttons
    out.println("<div class=\"d-flex justify-content-between mt-3\">");
    out.println("<a href=\"checkout.jsp\" class=\"btn btn-success\">Checkout</a>");
    out.println("<a href=\"listprod.jsp\" class=\"btn btn-secondary\">Continue Shopping</a>");
    out.println("</div>");

    if (hasError) {
        out.println("<div class='alert alert-danger mt-3'>" + errorMessage.toString() + "</div>");
    }
}
%>
</body>
</html>