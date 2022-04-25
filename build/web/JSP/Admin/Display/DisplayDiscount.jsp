
<%@page import="entity.employee"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.Discount"%>
<%@page import="model.DAODiscount"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List all Discounts</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                try {
                    DAODiscount dao = new DAODiscount();
                    employee emp = (employee) session.getAttribute("username");
                    Vector<Discount> vector = (Vector<Discount>) request.getAttribute("LIST");
        %>

        <header>
            <div>TIẾN ANH CAPUCHINO</div>
        </header>
        <div>
            <div>
                <h2><%= request.getAttribute("TITLE")%></h2>
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
                    <a href='DiscountController?service=insertDiscount'><button>Insert Discount</button></a>&emsp;
                    <a href='index.jsp'><button>Return Home</button></a>
                    <hr>
                    <table border='1'>
                        <caption><%= request.getAttribute("TABLE_TITLE")%></caption>
                        <thead>
                            <tr>
                                <th>Discount Type</th>
                                <th>Store</th>
                                <th>Low Quantity</th>
                                <th>High Quantity</th>
                                <th>Discount</th>
                                <th>Update</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (Discount temp : vector) {%>
                            <tr>
                                <td><%=temp.getDiscounttype()%></td>
                                <td><% ResultSet rs1 = dao.getData("SELECT  * FROM dbo.stores WHERE stor_id like '" + temp.getStor_id() + "'");
                            if (rs1.next()) {%>
                                    <%=rs1.getString(2)%>
                                    <%} else {%>
                                    null
                                    <%}%></td>
                                <td><%=temp.getLowqty()%></td>
                                <td><%=temp.getHighqty()%> </td>
                                <td><%=temp.getDiscount()%></td>
                        <form action="DiscountController" method="POST">
                            <td>
                                <input type="hidden" name="discount" value="<%=temp.getDiscount()%>">
                                <input type="hidden" name="discountType" value="<%=temp.getDiscounttype()%>">
                                <button name="service" value="updateDiscount">Update</button>
                            </td>
                            <td><button name="service" value="deleteDiscount">Delete</button></td>
                        </form>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%
                } catch (Exception e) {
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            }
        %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" ></script>
    </body>
</html>