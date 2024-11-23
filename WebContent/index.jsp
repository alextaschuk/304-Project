<!DOCTYPE html>
<html>
<head>
        <title>Sam and Alex's- Main Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
                <div class="container-fluid">
                
                  <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" href="listprod.jsp">View Products</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" href="listorder.jsp">List All Orders</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" href="showcart.jsp">View Cart</a>
                      </li>
                    </ul>
                  </div>
                </div>
              </nav>
<h1 align="center">Welcome to Sam and Alex's Grocery Depot</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>

<h4 align="center"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

<h4 align="center"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>

</body>
</head>


