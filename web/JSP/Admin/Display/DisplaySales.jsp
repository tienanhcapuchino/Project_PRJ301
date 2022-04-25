

<%@page import="entity.Stores"%>
<%@page import="entity.employee"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Vector"%>
<%@page import="model.DAOSales, entity.Sales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List all Sales</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                DAOSales dao = new DAOSales();
                Vector<Sales> vector = (Vector<Sales>) request.getAttribute("LIST");
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
                <h2><%= request.getAttribute("TITLE")%></h2>
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
                    <table border='1'>
                        <caption><%= request.getAttribute("TABLE_TITLE")%></caption>
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Quantity</th>
                                <th>Order Date</th>
                                <th>Payterm</th>
                                <th>Status</th>
                                <th>Update</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String orderNum = "", Store = "";
                                for (int i = 0; i < vector.size(); i++) {
                                    Sales temp = vector.get(i);
                                    if (!orderNum.equals(temp.getOrd_num())) {
                                        orderNum = temp.getOrd_num();
                                        ResultSet rs1 = dao.getData("SELECT  * FROM dbo.stores WHERE stor_id like '" + temp.getStor_id() + "'");
                                        if (rs1.next()) {
                                            Store = rs1.getString(2);
                                        }
                            %>
                            <tr>
                                <td colspan="8" style="text-align: center;"><strong>Order Number:</strong> <%= temp.getOrd_num()%> <strong>Store Name:</strong> <%= Store%> <strong>Status:</strong> <%=status[temp.getStatus()]%></td>
                            </tr>
                            <%
                                i--;
                            } else {
                            %>
                            <tr>
                                <% ResultSet rs1 = dao.getData("select * from titles where title_id = '" + temp.getTitle_id() + "'");
                                    if (rs1.next()) {%>
                                <td><%=rs1.getString(2)%></td>
                                <%}%>
                                <td><%=temp.getQty()%></td>
                                <%try {%>
                                <td><%=new SimpleDateFormat("dd MMM yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(temp.getOrd_date()))%></td>
                                <%} catch (Exception ex) {
                                        ex.printStackTrace();
                                    }%>
                                <td><%=temp.getPayterms()%></td>
                                <td>
                                    <%if (admin) {%>
                                    <form action="/SalesDetailController" class="updateStatus" method="GET">
                                        <input hidden="" name="storeID" value="<%=temp.getStor_id()%>">
                                        <input hidden="" name="service" value="updateStatus">
                                        <input hidden="" name="previous" value="Sale">
                                        <input hidden="" name="OrderNumber" value="<%=orderNum%>">
                                        <select onchange="this.parentNode.submit()" name="status">
                                            <%for (int id = 1; id < status.length; id++) {
                                                    if (temp.getStatus() == id) {
                                            %>
                                            <option selected value="<%=id%>"><%=status[id]%></option>
                                            <%
                                            } else {%>
                                            <option value="<%=id%>"><%=status[id]%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </form>
                                    <%} else {
                                    %><%=status[temp.getStatus()]%>
                                    <%
                                        }
                                    %>
                                </td>
                                <%
                                    if (temp.getStatus() == 1) {
                                %>
                                <td><a href='/SaleController?service=updateSales&storeID=<%=temp.getStor_id()%>&orderNum=<%=temp.getOrd_num()%>&titleID=<%=temp.getTitle_id()%>'>Update</a></td>
                                <td><a href='/SaleController?service=deleteSales&storeID=<%=temp.getStor_id()%>&orderNum=<%=temp.getOrd_num()%>&titleID=<%=temp.getTitle_id()%>'>Delete</a></td>
                                <%
                                    }
                                %>
                            </tr>
                            <%}
                                }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div> 
        <%
            }
        %>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js' integrity='sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM' crossorigin='anonymous'></script>
        <script src='https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js' integrity='sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p' crossorigin='anonymous'></script>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js' integrity='sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF' crossorigin='anonymous'></script>
    </body>
</html>
