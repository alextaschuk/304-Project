<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>


<%

String user = (String)session.getAttribute("authenticatedUser");

// TODO: Write SQL query that prints out total order amount by day
String sql = "";

%>

</body>
</html>

