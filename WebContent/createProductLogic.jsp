<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<%
    session = request.getSession(true);
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";

    String name = request.getParameter("productName");
    double price = Double.parseDouble(request.getParameter("productPrice"));
    String desc = request.getParameter("productDescription");
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));

    if (name == null || name.isEmpty() || desc == null || desc.isEmpty()) {
        out.println("<p>Error: All fields are required.</p>");
    } else {
        try (Connection con = DriverManager.getConnection(url, uid, pw);) {
            String insertProductSQL = "INSERT INTO product (productName, productPrice, productDesc, categoryId) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(insertProductSQL);
            pstmt.setString(1, name);
            pstmt.setDouble(2, price);
            pstmt.setString(3, desc);
            pstmt.setInt(4, categoryId);
            pstmt.executeUpdate();

            out.println("<p>Product added successfully!</p>");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            out.println("<p>Error: Invalid number format.</p>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error adding product. Please try again.</p>" + e);
        }
    }
%>