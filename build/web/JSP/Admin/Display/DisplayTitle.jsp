
<%@page import="entity.employee"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="entity.Titles"%>
<%@page import="model.DAOTitles"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List all Titles</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null) {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                try {
                    DAOTitles dao = new DAOTitles();
                    Vector<Titles> vector = (Vector<Titles>) request.getAttribute("LIST");
                    employee emp = (employee) session.getAttribute("username");
                    int count = vector.size();
        %>

        <header>
            <div>TIẾN ANH CAPUCHINO</div>
        </header>
        <div>
            <h2><%=count%></h2>
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
                <div class="text-start col-md-3 row row-cols-1">
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
                    <a href='TitleController?service=insertTitle'><button>Insert Title</button></a>&emsp;
                    <a href='index.jsp'><button>Return Home</button></a>
                    <hr>
                    <form action="TitleController">
                        <input type="text" name="name" placeholder="Name">
                        <input name="submit" type="submit" value="Search By Name">
                    </form>
                    <hr>
                    <form action="TitleController">
                        <input type="number" name="from" placeholder="From">
                        <input type="number" name="to" placeholder="To">
                        <input name="submit" type="submit" value="Search By Price">
                    </form>
                    <table border='1'>
                        <caption><%= request.getAttribute("TABLE_TITLE")%></caption>
                        <thead>
                            <tr>
                                <th>Title_id</th>
                                <th>Title</th>
                                <th>Type</th>
                                <th>Publisher</th>
                                <th>Price</th>
                                <th>Advance</th>
                                <th>Royalty</th>
                                <th>ytd_sales</th>
                                <th>Notes</th>
                                <th>PubishDate</th>
                                <th>Image</th>
                                <th>Update</th>
                                <th>Delete</th>
                                <!--<th>Cart</th>-->
                            </tr>
                        </thead>
                        <tbody>
                            <%for (Titles temp : vector) {%>
                            <tr>
                                <td><%=temp.getTitle_id()%></td>
                                <td><%=temp.getTitle()%></td>
                                <td><%=temp.getType()%></td>
                                <%ResultSet rs1 = dao.getData("select * from publishers where pub_id = '" + temp.getPub_id() + "'");
                                    if (rs1.next()) {%>
                                <td><%=rs1.getString(2)%></td>
                                <%}%>
                                <td><%=temp.getPrice()%></td>
                                <td><%=temp.getAdvance()%></td>
                                <td><%=temp.getRoyalty()%></td>
                                <td><%=temp.getYtd_sales()%></td>
                                <td><%=temp.getNotes()%></td>
                                <%try {%>
                                <td><%=new SimpleDateFormat("dd MMM yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(temp.getPubdate()))%></td>
                                <%} catch (Exception ex) {
                                        ex.printStackTrace();
                                    }%>
                                <td><img width ="100px" height="100px" src = "<%=temp.getImage()%>"></td>
                                <td><a href='TitleController?service=updateTitle&titleID=<%=temp.getTitle_id()%>'>Update</a></td>
                                <td><a href='TitleController?service=deleteTitle&titleID=<%=temp.getTitle_id()%>'>Delete</a></td>
                                
                                <!--<td><a href='CartController?service=addToCart&titleID=<%=temp.getTitle_id()%>'>Add</a></td>-->
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                    <%
                            } catch (Exception e) {
                                request.getRequestDispatcher("index.jsp").forward(request, response);
                            }
                        }
                    %>
                </div>
            </div>
        </div> 

        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js' integrity='sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM' crossorigin='anonymous'></script>
        <script src='https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js' integrity='sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p' crossorigin='anonymous'></script>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js' integrity='sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF' crossorigin='anonymous'></script>

    </body>
</html>
