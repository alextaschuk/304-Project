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
            <span class="navbar-text ms-auto">
            <%
			String userNameK = (String) session.getAttribute("authenticatedUser");
                if(userNameK != null){
					out.println("<a align=\"center\">Welcome, "+userNameK+"</a>");

						
            
			
                    
            
                } else {
            %>
                    <form method="get" action="login.jsp">
                        <input type="submit" value="Login">
                    </form>
            <%
                }
            %>
            </span>
        </div>
    </div>
</nav>