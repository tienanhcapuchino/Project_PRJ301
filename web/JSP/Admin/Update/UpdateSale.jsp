
<%@page import="entity.Stores"%>
<%@page import="entity.employee"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Sales</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                String user = "";
                boolean admin = false;
                String[] status = (String[]) request.getAttribute("status");
                try {
                    employee emp = (employee) session.getAttribute("username");
                    user = emp.getUserName();
                    admin = true;
                } catch (Exception e) {
                    Stores store = (Stores) session.getAttribute("username");
                    user = store.getUserName();
                }
        %>

        <header>
            <div>TIẾN ANH CAPUCHINO</div>
        </header>
        <div>
            <div>
                <h2>Update Sales</h2>
                <div>
                    <form action="UserController" method="POST">

                        <input disabled value="Welcome <%= user%>">
                        <input hidden="" name="username" value=" <%= user%>">
                        <button type="submit" name="service" value="Logout">Logout</button>
                    </form>
                </div>
            </div>
            <div>
                <%
                    if (admin) {
                %>
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
                    <a href='SaleController?service=insertSale'><button>Insert Sale</button></a>&emsp;
                    <a href='Admin.jsp'><button>Return Home</button></a>
                    <hr>

                    <%
                    } else {
                    %>
                    <a href='CartController'><button>Show Cart</button></a>
                    <a href='index.jsp'><button>Return Home</button></a>
                    <%}%>
                    <form action='SaleController' method = 'POST'>
                        <input class="form-control border-0 bg-transparent" type="hidden" value="updateSales" name="service">
                        <table class='table-striped table table-fit table-hover' border='1'>
                            <%
                                ResultSet rsSale = (ResultSet) request.getAttribute("rsSale");
                                ResultSet rsTitle = (ResultSet) request.getAttribute("rsTitle");
                                ResultSet payterm = (ResultSet) request.getAttribute("payterm");
                                ResultSet rsStore = (ResultSet) request.getAttribute("rsStore");
                                if (rsSale.next()) {
                            %>
                            <tbody>
                                <tr>
                                    <td><label for='storeId'>Store</label></td>
                                    <td>
                                        <select disabled class='form-select bg-transparent' name='storeId' id='storeId'>
                                            <%while (rsStore.next()) {
                                            if (rsStore.getString(1).equals(rsSale.getString(1))) {%>
                                            <option value='<%=rsStore.getString(1)%>' selected=""><%=rsStore.getString(2)%></option>
                                            <%  } else {%>
                                            <option value='<%=rsStore.getString(1)%>'><%=rsStore.getString(2)%></option>
                                            <%  }%>
                                            <%}%>
                                        </select>
                                        <input class='form-control bg-transparent' type='text' hidden id ='royalty' name='storeId' value='<%=rsSale.getString(1)%>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for='ordnum'>Order Number</label></td>
                                    <td>
                                        <input class='form-control border-0 bg-transparent' type='text' disabled id ='ordnum' value='<%=rsSale.getString(2)%>'>
                                        <input class='form-control border-0 bg-transparent' type='hidden' name='ordnum' value='<%=rsSale.getString(2)%>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for='orddate'>Order Date</label></td>
                                    <td>
                                        <input class='form-control border-0 bg-transparent' type='date' id ='orddate' name='orddate' value='<%=rsSale.getString(3).split(" ")[0]%>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for='qty'>Quantity</label></td>
                                    <td>
                                        <input class='form-control border-0 bg-transparent' type='number' name="qty" id ='qty' value='<%=rsSale.getInt(4)%>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for='payterms'>Payterms</label></td>
                                    <td>
                                        <select class='form-select bg-transparent' name='payterms' id='payterms'>
                                            <%while (payterm.next()) {
                                            if (payterm.getString(1).equals(rsSale.getString(5))) {%>
                                            <option value='<%=payterm.getString(1)%>' selected=""><%=payterm.getString(1)%></option>
                                            <%  } else {%>
                                            <option value='<%=payterm.getString(1)%>'><%=payterm.getString(1)%></option>
                                            <%  }%>
                                            <%}%>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for='titleId'>Title</label></td>
                                    <td>
                                        <select disabled class='form-select bg-transparent' name='titleId' id='titleId'>
                                            <%while (rsTitle.next()) {
                                            if (rsTitle.getString(1).equals(rsSale.getString(6))) {%>
                                            <option value='<%=rsTitle.getString(1)%>' selected=""><%=rsTitle.getString(2)%></option>
                                            <%  } else {%>
                                            <option value='<%=rsTitle.getString(1)%>'><%=rsTitle.getString(2)%></option>
                                            <%  }%>
                                            <%}%>
                                        </select>
                                        <input class='form-control bg-transparent' type='text' hidden id ='titleId' name='titleId' value='<%=rsSale.getString(6)%>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Status</td>
                                    <td>
                                        <select disabled="" name="status" class="form-select bg-transparent statusComboBox">
                                            <%for (int i = 1; i < status.length; i++) {
                                            if (rsSale.getInt(7) == i) {%>
                                            <option selected value="<%=i%>"><%=status[i]%></option>
                                            <%} else {%>
                                            <option value="<%=i%>"><%=status[i]%></option>
                                            <%}%>
                                            <%}%>
                                        </select>
                                    </td>
                                </tr>
                            </tbody>
                            <%}%>
                        </table>
                        <div class="row float-end">
                            <input class="btn btn-dark col" type="submit" value="Update to Database" name="submitUpdate">
                            <div class="col"></div>
                            <input class="btn btn-dark col" type="reset" value="Reset">
                        </div>
                    </form>
                </div>
            </div>
        </div> 
        <%
            }
        %>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'/>
        <script src='https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js'/>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js'/>

    </body>
</html>
