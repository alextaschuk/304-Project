<!DOCTYPE html>
<html>
<head>
<title>Sam and Alex's- Checkout</title>
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

<h1>Enter your customer id to complete the transaction:</h1>

<form method="get" action="order.jsp">
<input type="text" name="customerId" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

</body>
</html>

