<!DOCTYPE html>
<html>
<head>
    <title>Leave a Review</title>
</head>
<body>

<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<%@ include file="auth.jsp" %>

<h2>Leave a Review</h2>
<div> Note, you may only leave reviews for products you have bought and have not left a review already on! But dont worry the dropdown already sorts based on this!</div>



<form method="get" action="updateReview.jsp">
    <!-- Product Selection -->
    <label for="product">Select Product:</label>
    <select id="product" name="product_id">
<%

    String user = (String)session.getAttribute("authenticatedUser");


    try (Connection connection = DriverManager.getConnection(url, uid, pw)) {

        String custID = "";


        String query = "SELECT customerId FROM customer WHERE userId = ?";

        PreparedStatement ps = connection.prepareStatement(query);

        ps.setString(1, user);  // Set the userId parameter

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                custID = rs.getString("customerId"); // Retrieve customerId
            } else {
                out.println("<p>No customer found for the provided userId.</p>");
            }
        }


        query = "SELECT p.productId, p.productName " +
                "FROM ordersummary os " +
                "JOIN orderproduct op ON os.orderId = op.orderId " +
                "JOIN product p ON op.productId = p.productId " +
                "LEFT JOIN review r ON p.productId = r.productId AND r.customerId = ? " +
                "WHERE os.customerId = ? " +
                "AND r.reviewId IS NULL";



        PreparedStatement preparedStatement = connection.prepareStatement(query);

        // Set the userId parameter
        preparedStatement.setString(1, custID);
        preparedStatement.setString(2, custID);

        // Execute the query
        try (ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                out.print(resultSet.getInt("productId") + " " + resultSet.getString("productName") );

                out.print("<option value=\""+resultSet.getInt("productId")+"\">"+resultSet.getString("productName")+"</option>");

            }
        }


        out.print("</select>");
        out.print("<input type=\"hidden\" name=\"customerId\" value=\""+custID+"\">");
    } catch (SQLException e) {
        out.print(e.getMessage());
    }

%>



    
    

    <!-- Rating -->
    <label for="rating">Rating:</label>
    <select id="rating" name="rating">
    <option value="1">1 Star</option>
    <option value="2">2 Stars</option>
    <option value="3">3 Stars</option>
    <option value="4">4 Stars</option>
    <option value="5">5 Stars</option>
    </select>

    

    <!-- Review Text -->
    <label for="review_text">Write your review:</label>
    <textarea id="review_text" name="review_text" rows="4" cols="50"></textarea>

    <!-- Submit Button -->
    <button type="submit">Submit Review</button>
</form>



</body>
</html>