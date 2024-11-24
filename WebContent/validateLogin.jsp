<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		String sql = "SELECT userid, password FROM customer WHERE userid = ? AND password = ? AND customerId = (SELECT customerId FROM customer WHERE userid = ? AND password = ?)";
	
		try 
		{
			getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, username);
			pstmt.setString(4, password);

			ResultSet rs = pstmt.executeQuery();

			if(!rs.next()){ // if there is no match (i.e., not a valid username)
				return null; // don't login
			} else {
				retStr = username; // login
			}

		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}
		
		if(retStr != null){	
			session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		} else {
			session.setAttribute("loginMessage", "Could not connect to the system using that username/password.");
		}
		return retStr;
	}
%>

