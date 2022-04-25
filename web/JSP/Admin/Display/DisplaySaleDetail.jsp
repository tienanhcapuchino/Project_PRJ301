

<%@page import="entity.employee"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List all Stores</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null) {
                request.getRequestDispatcher("../../../Login.jsp").forward(request, response);
            } else {
                try {
                    ResultSet rsSalesDetail = (ResultSet) request.getAttribute("rsSalesDetail");
                    double total = 0;
                    String storeName = (String) request.getAttribute("storeName"), storeID = (String) request.getAttribute("storeId");
                    String[] status = (String[]) request.getAttribute("status");
                    employee emp = (employee) session.getAttribute("username");
        %>

        <header>
        </header>
        <div class="container">
            <div>
                <h2>List Sale Detail<br>By Store <%=storeName%></h2>
                <div>
                    <form action="UserController" method="POST">
                        <input disabled  value="Welcome <%= emp.getUserName()%>">
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
                
                <form action="SaleDetailController">
                <div>
                    <a href='StoreController'><button>View Stores</button></a>&emsp;
                    <a href='Admin.jsp'><button>Return Home</button></a>
                    <hr>
                    <div>
                        <div><strong>Store ID:</strong> <%=storeID%></div>
                        <div><strong>Store Name:</strong> <%=storeName%></div>
                    </div>
                    <hr>
                    <table border='1'>
                        <thead>
                            <tr>
                                <th>Order Number</th>
                                <th>Title</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Update</th>
                                <th>Delete</th>
                            </tr
                        </thead>
                        <tbody>
                            <%
                                while (rsSalesDetail.next()) {
                                    total += rsSalesDetail.getDouble(5);
                                    String orderNum = rsSalesDetail.getString(1);
                            %>  
                            <tr>
                                <td><%=rsSalesDetail.getString(1)%></td>
                                <td><%=rsSalesDetail.getString(2)%></td>
                                <td><%=rsSalesDetail.getInt(4)%></td>
                                <td><%=rsSalesDetail.getDouble(3)%></td>
                                <td><%=rsSalesDetail.getDouble(5)%></td>
                                <td>
                                    <form action="SalesDetailController" class="updateStatus" method="GET">
                                        <input hidden="" name="storeID" value="<%=storeID%>">
                                        <input hidden="" name="service" value="updateStatus">
                                        <input hidden="" name="previous" value="getStores">
                                        <input hidden="" name="OrderNumber" value="<%=orderNum%>">
                                        <select onchange="this.parentNode.submit()" name="status" class="form-select text-center bg-transparent statusComboBox">
                                            <%for (int i = 1; i < status.length; i++) {
                                                    if (rsSalesDetail.getInt(6) == i) {
                                            %>
                                            <option selected value="<%=i%>"><%=status[i]%></option>
                                            <%
                                            } else {%>
                                            <option value="<%=i%>"><%=status[i]%></option>
                                            <%
                                                    }
                                                }%>
                                        </select>
                                    </form>
                                </td>
                                <td><a href='SalesDetailController?service=updateSales&orderNum=<%=orderNum%>&titleID=<%=rsSalesDetail.getString(7)%>'>Update</a></td>
                                <td><a href='SalesDetailController?service=deleteSales&orderNum=<%=orderNum%>&titleID=<%=rsSalesDetail.getString(7)%>'>Delete</a></td>
                            </tr>
                            <%}%>
                        </tbody>
                        <tfoot class="text-end">
                            <tr>
                                <th colspan="4">Total</th>
                                <td><%= Math.round(total * 100.0) / 100.0%></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div> 
        <footer>
        </footer>
        <%
                } catch (Exception e) {
                    response.sendRedirect("TitleController");
                }
            }
        %>
    </body>
</html>