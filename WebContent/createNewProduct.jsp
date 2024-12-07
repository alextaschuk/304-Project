<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<% 
 // Page for creating a new product and adding it to the DB 
%>
<!DOCTYPE html>
<html>
<head>
    <title>Create New Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 50%;
            margin: auto;
            overflow: hidden;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin: 10px 0 5px;
            color: #333;
        }
        input[type="text"], input[type="number"], textarea {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
        }
        input[type="submit"] {
            padding: 10px;
            background: #5cb85c;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background: #4cae4c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create New Product</h2>
        <form action="createProductLogic.jsp" method="post">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" required>
            
            <label for="productDescription">Product Description:</label>
            <textarea id="productDescription" name="productDescription" required></textarea>
            
            <label for="productPrice">Price:</label>
            <input type="number" id="productPrice" name="productPrice" step="0.01" required>
            
            <label for="categoryId">Category ID:</label>
            <input type="text" id="categoryId" name="categoryId" required>
            
            <input type="submit" value="Add Product">
        </form>
    </div>
</body>
</html>