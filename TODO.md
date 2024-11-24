**Marking Guide (product page): (10 marks)**

- ~~+1 mark - for modifying product listing page to go to product detail page when click on product name~~
- ~~+3 marks - for using PreparedStatement to retrieve and display product information by id~~
- ~~+2 marks - for displaying an image using an HTML img tag based on productImageURL field~~
- +3 marks - for displaying an image from the binary field productImage by providing an img tag and modifying the displayImage.jsp/php file.
- ~~+1 mark - for adding link to "add to cart" and to "continue shopping"~~

**Marking Guide (admin and login page): (5 marks)**

- +1 mark - for checking user is logged in before accessing page
- +2 marks - for displaying a report that list the total sales for each day. Hint: May need to use date functions like year, month, day.
- +1 mark - for displaying current user on main page (index.jsp/php)
- +2 marks - for modifying validateLogin to check correct user id and password

**Marking Guide (customer page): (5 marks)**

- +1 mark - for displaying error message if attempt to access page and not logged in
- +4 marks - for retrieving customer information by id and displaying it

**Marking Guide (shipment page): (5 marks)**

- +3 mark -for using transactions to either process the shipment and ship all items (up to 3) or generate an error
- +2 marks - for checking that there is enough of each item to ship from the warehouse. Rollback transaction if any item does not have enough inventory.
Test by entering URL like: http://localhost/shop/ship.jsp?orderId=1