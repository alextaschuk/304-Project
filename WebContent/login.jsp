<!DOCTYPE html>
<html>
<head>
<title>Sign In Screen</title>
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">
<%@ include file="header.jsp" %>

<h3>Sign In To Account</h3>

<%
String user = (String)session.getAttribute("authenticatedUser");
boolean authenticated = session.getAttribute("authenticatedUser") == null ? false : true;

// Print prior error login message if present
 if (session.getAttribute("redirectedToLogin") != null && (boolean) session.getAttribute("redirectedToLogin") && session.getAttribute("loginMessage") != null) {
        out.println("<p>" + session.getAttribute("loginMessage").toString() + "</p>");
        // Reset the redirected flag
        session.setAttribute("redirectedToLogin", false);
    } else 
		out.println("<p>" + session.getAttribute("loginMessage").toString() + "</p>");

%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>

</body>
</html>

