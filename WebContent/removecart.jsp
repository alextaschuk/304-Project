<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%
String productId = request.getParameter("productId");
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
if (productList != null && productId != null) {
    productList.remove(productId);
}
response.sendRedirect("showcart.jsp");
%>