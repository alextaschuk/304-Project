<!DOCTYPE html>
<html>
<head>
    <title>Sam and Alex's- Main Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-top: 50px;
        }
        h1, h2, h3, h4 {
            margin-bottom: 20px;
        }
        .btn-custom {
            margin: 10px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container text-center">
        <h1>Welcome to Sam and Alex's Grocery Depot</h1>

        <div class="d-grid gap-2 d-md-block">
            <a href="login.jsp" class="btn btn-primary btn-custom">Login</a>
            <a href="listprod.jsp" class="btn btn-success btn-custom">Begin Shopping</a>
            <a href="listorder.jsp" class="btn btn-info btn-custom">List All Orders</a>
            <a href="listCustOrder.jsp" class="btn btn-warning btn-custom">List All Orders for a Given Customer</a>
            <a href="customer.jsp" class="btn btn-secondary btn-custom">Customer Info</a>
            <a href="admin.jsp" class="btn btn-danger btn-custom">Administrators</a>
            <a href="logout.jsp" class="btn btn-dark btn-custom">Log out</a>
        </div>

        <%
            String userName = (String) session.getAttribute("authenticatedUser");
            session.setAttribute("loginMessage", "");
            session.setAttribute("redirectedToLogin", false);

            if (userName != null) {
                out.println("<h3>Signed in as: " + userName + "</h3>");
            }
        %>

        <div class="mt-4">
            <h4><a href="ship.jsp?orderId=1" class="btn btn-outline-primary">Test Ship orderId=1</a></h4>
            <h4><a href="ship.jsp?orderId=3" class="btn btn-outline-primary">Test Ship orderId=3</a></h4>
        </div>
    </div>
</body>
</html>