<!DOCTYPE html>
<html>
<head>
    <title>Edit Inventory</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        h1 {
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 10px;
            font-weight: bold;
        }
        input, button {
            margin-bottom: 20px;
            padding: 10px;
            font-size: 16px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <%@ include file="auth.jsp" %>
    <%@ include file="jdbc.jsp" %>
    <%@ include file="header.jsp" %>




    <div class="container">
        <h1>Edit Inventory</h1>
        <form action="updateInventory.jsp" method="POST">


        <%

            String warehouseName = request.getParameter("warehouseName");
            request.setAttribute("warehouseName", warehouseName);

            String productName = request.getParameter("productName");
            request.setAttribute("productName", productName);

            String oldQuant = request.getParameter("quantity") ;

            out.print("<div> Changing the quantity of product <b>"+productName+"</b> in warehouse <b>"+warehouseName);
            out.print("</b> from "+oldQuant+" to... </div>");

            out.print("<label for=\"quantity\">Quantity</label>");

            %>

                <input type="number" id="quantity" name="quantity" value="${quantity}" min="0" required />

                <input type="hidden" name="warehouseName" value="${warehouseName}" />
                <input type="hidden" name="productName" value="${productName}" />
                <input type="hidden" name="quantity" value="${quantity}" />

            <button type="submit">Update Inventory</button>
        </form>
    </div>
</body>
</html>
