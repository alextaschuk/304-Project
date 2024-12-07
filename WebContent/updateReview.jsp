<!DOCTYPE html>
<html>
<head>
    <title>Review completed</title>
</head>
<body>

<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>




<%

    // Get the form data
    String customerId = request.getParameter("customerId");
    String productId = request.getParameter("product_id");
    String rating = request.getParameter("rating");
    String reviewText = request.getParameter("review_text");

    // Query to insert the review into the database
    String insertReviewQuery = "INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) " +
                               "VALUES (?, CURRENT_TIMESTAMP, ?, ?, ?)";

    try (Connection connection = DriverManager.getConnection(url, uid, pw);
            PreparedStatement preparedStatement = connection.prepareStatement(insertReviewQuery)) {

        // Set the parameters for the query
        preparedStatement.setInt(1, Integer.parseInt(rating));  // Set the rating
        preparedStatement.setInt(2, Integer.parseInt(customerId));  // Set the customerId
        preparedStatement.setInt(3, Integer.parseInt(productId));  // Set the productId
        preparedStatement.setString(4, reviewText);  // Set the review comment

        // Execute the update
        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<p>Thank you for your review! It has been successfully submitted.</p>");
        } else {
            out.println("<p>There was an issue submitting your review. Please try again later.</p>");
        }
        
    } catch (SQLException e) {
        out.print(e.getMessage());
    }

%>

</body>
</html>