<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
if (productList != null) {
    for (String key : productList.keySet()) {
        String paramName = "quantity_" + key;
        String newQuantityStr = request.getParameter(paramName);
        if (newQuantityStr != null) {
            int newQuantity = Integer.parseInt(newQuantityStr);
            ArrayList<Object> product = productList.get(key);
            product.set(3, newQuantity); // Update quantity
        }
    }
}
response.sendRedirect("showcart.jsp");
%>