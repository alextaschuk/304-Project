<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<html>
<head>
    <title>Sam and Alex's - Product Information</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1 class="text-center">Product Information</h1>
            <hr>
            <%
            String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
            String uid = "sa";
            String pw = "304#sa#pw";

            // Get product name to search for
            String productId = request.getParameter("productId");

            // TODO: Retrieve and display info for the product
            String sql = "SELECT * FROM product WHERE productId = ?";

            try (Connection con = DriverManager.getConnection(url, uid, pw);) {
                PreparedStatement ps = con.prepareStatement(sql); // use prepared statement to retrieve and display product info
                ps.setString(1, productId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String productName = rs.getString("productName");
                    double productPrice = rs.getDouble("productPrice");
                    String productDesc = rs.getString("productDesc");
                    String productImageURL = rs.getString("productImageURL");
                    byte[] productImage = rs.getBytes("productImage");

                    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

                    out.println("<div class='card'>");
                    out.println("<div class='card-header'><h2>" + productName + "</h2></div>");
                    out.println("<div class='card-body'>");

                    if (productImageURL != null) {
                        out.println("<img src=\"" + productImageURL + "\" alt=\"" + productName + "\" class='img-fluid'>");
                    } else if (productImage != null) {
                        out.println("<img src=\"displayImage.jsp?id=" + productId + "\" alt=\"" + productName + "\" class='img-fluid'>");
                    }

                    out.println("<p class='mt-3'><b>Description: </b>" + productDesc + "</p>");
                    out.println("<p><b>SKU (Product ID): </b> " + productId + "</p>");
                    out.println("<p><b>Price: </b> " + currFormat.format(productPrice) + "</p>");

                    // TODO: Add links to Add to Cart and Continue Shopping
                    String addCartLink = "addcart.jsp?id=" + rs.getInt("productId") + "&name=" + rs.getString("productName") + "&price=" + rs.getDouble("productPrice");
                    out.println("<a href='" + addCartLink + "' class='btn btn-primary'>Add to Cart</a>");
                    out.println("<a href='listprod.jsp' class='btn btn-secondary ml-2'>Continue Shopping</a>");

                    out.println("</div>");
                    out.println("</div>");
                } else {
                    out.println("<div class='alert alert-danger'>Product not found</div>");
                }
            } catch (SQLException ex) {
                out.println("<div class='alert alert-danger'>SQLException: " + ex + "</div>");
            }
            %>
        </div>
    </div>
</div>
</body>
</html>
