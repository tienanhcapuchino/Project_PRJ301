
<%@page import="entity.employee"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Discounts</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                try {
                    employee emp = (employee) session.getAttribute("username");
        %>

        <header>
            <div>TIẾN ANH CAPUCHINO</div>
        </header>
        <div>
            <div>
                <h2>Update Discount</h2>
                <div>
                    <form action="UserController" method="POST">
                        
                        <input disabled value="Welcome <%= emp.getUserName()%>">
                        <input hidden="" name="username" value="<%= emp.getUserName()%>">
                        <button type="submit" name="service" value="Logout">Logout</button>
                    </form>
                </div>
            </div>
            <div>
                <div>
                    <a href="AuthorController">Authors</a>
                    <a href="DiscountController">Discount</a>
                    <a href="EmployeeController">Employee</a>
                    <a href="JobController">Jobs</a>
                    <a href="PubInfoController">Publisher Info</a>
                    <a href="PublisherController">Publisher</a>
                    <a href="RoyschedController">Roysched</a>
                    <a href="SaleController">Sale</a>
                    <a href="StoreController">Stores</a>
                    <a href="TitleController">Title</a>
                    <a href="TitleAuthorController">Title Author</a>
                </div>
                <div>
                    <form action='DiscountController' method = 'POST'>
                <input type="hidden" value="updateDiscount" name="service">
                <table border='1'>
                    <%
                        ResultSet rsDiscount = (ResultSet) request.getAttribute("rsDiscount"),
                                rsStore = (ResultSet) request.getAttribute("rsStore");
                        if (rsDiscount.next()) {
                    %>
                    <tbody>

                        <tr>
                            <td><label for='discountType'>Order Date</label></td>
                            <td>
                                <input discountType value='<%=rsDiscount.getString(1)%>'>
                                <input type='hidden' id ='discountType' name='discountType' value='<%=rsDiscount.getString(1)%>'>
                            </td>
                        </tr>
                        <tr>
                            <td><label for='storeId'>Store</label></td>
                            <td>
                                <select class='form-select border-0 bg-transparent' name='storeId' id='storeId'  >
                                    <%if (rsDiscount.getString(2) == null) {%>
                                    <option value="" >null</option>
                                    <%}%>
                                    <%while (rsStore.next()) {
                                            if (rsStore.getString(1).equals(rsDiscount.getString(2))) {%>
                                    <option  value ='<%=rsStore.getString(1)%>' selected><%=rsStore.getString(2)%></option>
                                    <%} else {%>
                                    <option  value ='<%=rsStore.getString(1)%>' ><%=rsStore.getString(2)%></option>
                                    <%}%>
                                    <%}%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label for='lowQty'>Low Quantity</label></td>
                            <td>
                                <%if (rsDiscount.getString(3) == null) {%>
                                <input type='number' id ='lowQty' name='lowQty' value='-1'>
                                <%} else {%>
                                <input type='number' id ='lowQty' name='lowQty' value='<%=rsDiscount.getString(3)%>'>
                                <%}%>
                            </td>
                        </tr>
                        <tr>
                            <td><label for='highQty'>High Quantity</label></td>
                            <td>
                                <%if (rsDiscount.getString(4) == null) {%>
                                <input type='number' id ='highQty' name='highQty' value='-1'>
                                <%} else {%>
                                <input type='number' id ='highQty' name='highQty' value='<%=rsDiscount.getString(4)%>'>
                                <%}%>
                            </td>
                        </tr>
                        <tr>
                            <td><label for='discount'>Discount</label></td>
                            <td>
                                <input type='hidden' id ='discount' name='discount' value='<%=rsDiscount.getString(5)%>'>
                                <input id ='discount' disabled value='<%=rsDiscount.getString(5)%>'>
                            </td>
                        </tr>
                    </tbody>
                    <%}%>
                </table>
                <div>
                    <input type="submit" value="Update to Database" name="submitUpdate">
                    <div></div>
                    <input type="reset" value="Reset">
                </div>
            </form>
                </div>
            </div>
        </div> 
   
        <%
                } catch (Exception e) {
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            }
        %>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'/>
        <script src='https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js'/>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js'/>

    </body>
</html>
