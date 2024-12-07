<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<% 
 // Page for updating and deleting a product from DB
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update or Delete Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #fff;
            background-color: #5cb85c;
            border: none;
            border-radius: 5px;
            box-shadow: 0 4px #999;
        }
        .btn:hover {
            background-color: #4cae4c;
        }
        .btn:active {
            background-color: #4cae4c;
            box-shadow: 0 2px #666;
            transform: translateY(2px);
        }
        .btn-delete {
            background-color: #d9534f;
        }
        .btn-delete:hover {
            background-color: #c9302c;
        }
        .btn-delete:active {
            background-color: #c9302c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update or Delete a Product</h2>
        <table>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Product Description</th>
                <th>Price</th>
                <th>Category ID</th>
                <th>Action</th>
            </tr>
            <%
                String getProducts = "SELECT productId, productName, productDesc, productPrice, categoryId FROM product";
                try (Connection con = DriverManager.getConnection(url, uid, pw);
                     PreparedStatement pstmt = con.prepareStatement(getProducts);
                     ResultSet rs = pstmt.executeQuery()) {

                    while (rs.next()) {
                        int productId = rs.getInt("productId");
                        String productName = rs.getString("productName");
                        String productDesc = rs.getString("productDesc");
                        double productPrice = rs.getDouble("productPrice");
                        int categoryId = rs.getInt("categoryId");
            %>
            <tr>
                <form action="updateProductLogic.jsp" method="post">
                    <td><%= productId %></td>
                    <td><input type="text" name="productName" value="<%= productName %>" required></td>
                    <td><textarea name="productDesc" required><%= productDesc %></textarea></td>
                    <td><input type="number" name="productPrice" value="<%= productPrice %>" step="0.01" required></td>
                    <td><input type="number" name="categoryId" value="<%= categoryId %>" required></td>
                    <td>
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <input type="submit" value="Update Product" class="btn">
                    </td>
                </form>
                <td>
                    <form action="deleteProductLogic.jsp" method="post">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <input type="submit" value="Delete Product" class="btn btn-delete">
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            %>
        </table>
    </div>
</body>
</html>