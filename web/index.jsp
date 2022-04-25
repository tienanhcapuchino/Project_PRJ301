
<%@page import="entity.Stores"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="entity.Titles"%>
<%@page import="java.util.Vector"%>
<%@page import="model.DAOTitles"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Main Menu</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <header class="bg-dark text-center text-lg-start">
            <div class="text-center p-3 text-white">TIẾN ANH CAPUCHINO</div>
        </header>
        <%
            DAOTitles dao = new DAOTitles();
            Vector<Titles> vector = (Vector<Titles>) request.getAttribute("LIST");
            if (vector == null) {
                vector = dao.viewAllTitles();
            }
        %>
        <div class="container">
            <div class="row">
                <h1 class="col">SE1609:</h1>
                <div class="text-end col">
                    <a href="CartController">Show Cart</a>
                    <%
                        if (session.getAttribute("username") != null) {
                            try {
                                    Stores st = (Stores)session.getAttribute("username");           
                    %>
                    <a>Welcome <%= st.getUserName()%></a>
                    <a name="link" href="UserController?service=Logout">Logout</a>
                    <a name="link" href="SaleController?username=<%= st.getUserName() %>">Bill History</a>
                    <%} catch (Exception e) {request.getRequestDispatcher("Admin.jsp").forward(request, response);} %>
                    <%} else {%>
                    <a name="link" href="Login.jsp">Login</a>
                    <%}%>
                </div>
            </div>
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
            <div class="row row-cols-4 justify-content-md-center">
                <table border='1'>
                    <caption>Product</caption>
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
                            <th>Buy</th>
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
                            <td><%=temp.getPubdate()%></td>
                            <%} catch (Exception ex) {
                                    ex.printStackTrace();
                                }%>
                            <td><img width ="100px" height="100px" src = "<%=temp.getImage()%>"></td>
                            <td><a href='CartController?service=addToCart&titleID=<%=temp.getTitle_id()%>'>Add</a></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" ></script>
    </body>
</html>