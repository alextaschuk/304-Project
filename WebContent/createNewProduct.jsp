<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create New Product</title>
</head>
<body>
    <h2>Create New Product</h2>
    <form action="createProductLogic.jsp" method="post">
        <label for="productName">Product Name:</label>
        <input type="text" id="productName" name="productName" required><br><br>
        
        <label for="productDescription">Product Description:</label>
        <textarea id="productDescription" name="productDescription" required></textarea><br><br>
        
        <label for="productPrice">Price:</label>
        <input type="number" id="productPrice" name="productPrice" step="0.01" required><br><br>
        
        <label for="categoryId">Category ID:</label>
        <input type="text" id="categoryId" name="categoryId" required><br><br>
        
        <input type="submit" value="Add Product">
    </form>
</body>
</html>