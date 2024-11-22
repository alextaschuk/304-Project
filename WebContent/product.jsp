<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

// Get product name to search for
String productId = request.getParameter("productId");

// TODO: Retrieve and display info for the product
String sql = "SELECT * FROM product WHERE productId = ?";


try (Connection con = DriverManager.getConnection(url, uid, pw);) {



    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, productId);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        String productName = rs.getString("productName");

        out.println("<h1>" + productName + "</h1>");

        double productPrice = rs.getDouble("productPrice"); 

        // TODO: If there is a productImageURL, display using IMG tag
        String productImageURL = rs.getString("productImageURL");

        if (productImageURL != null) out.println("<img src=\"" + productImageURL + "\" alt=\"" + productName + "\">");

        byte[] productImage = rs.getBytes("productImage");
        if(productImage != null) out.println("<img src=\"displayImage.jsp?id=" + productId + "\" alt=\"" + productName + "\">");
        
        NumberFormat currFormat = NumberFormat.getCurrencyInstance();
        out.println("<p><b>Id:</b> " + productId + "</p>");
        out.println("<p><b>Price:</b> " + currFormat.format(productPrice) + "</p>");

        // TODO: Add links to Add to Cart and Continue Shopping
        String addCartLink = "addcart.jsp?id=" + rs.getInt("productId") + "&name=" +rs.getString("productName") + "&price=" + rs.getDouble("productPrice");
        out.println("<h3><a href=\"" + addCartLink + "\">Add to Cart</a> <br />");
        out.println("<a href=\"listprod.jsp\">Continue Shopping</a></h3>");

    } else {
        out.println("Product not found");
    }



}
catch (SQLException ex) {
    out.println("SQLException: " + ex);
}




%>

</body>
</html>

