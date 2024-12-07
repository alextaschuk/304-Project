<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<%
    session = request.getSession(true);
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";

    String id = request.getParameter("productId");
    String name = request.getParameter("productName");
    String desc = request.getParameter("productDesc");
    double price = Double.parseDouble(request.getParameter("productPrice"));
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));

    try (Connection con = DriverManager.getConnection(url, uid, pw);) {
        String updateProductSQL = "UPDATE product SET productName = ?, productDesc = ?, productPrice = ?, categoryId = ? WHERE productId = ?";
        PreparedStatement pstmt = con.prepareStatement(updateProductSQL);
        pstmt.setString(1, name);
        pstmt.setString(2, desc);
        pstmt.setDouble(3, price);
        pstmt.setInt(4, categoryId);
        pstmt.setInt(5, Integer.parseInt(id));
        pstmt.executeUpdate();

        out.println("<p>Product updated successfully!</p>");
    } catch (NumberFormatException e) {
        e.printStackTrace();
        out.println("<p>Error: Invalid number format.</p>");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error updating product. Please try again.</p>" + e);
    }
%>