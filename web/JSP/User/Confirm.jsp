
<%@page import="entity.Stores"%>
<%@page import="model.DAOTitles"%>
<%@page import="entity.Titles"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Cart</title>
    </head>
    <body><header class="bg-dark text-center text-lg-start">
            <div class="text-center p-3 text-white">TIẾN ANH CAPUCHINO</div>
        </header>
        <div class="container">
            <div class="row">
                <h2 class="col">Show Cart</h2>
                <div class="col text-end">
                    <%
                        Stores username = (Stores) session.getAttribute("username");
                        if (username != null) {
                    %>
                    <div class="text-end col">
                        <a href="ShowCart.jsp">Show Cart</a>
                        <%
                            if (session.getAttribute("username") != null) {
                                try {
                                    Stores st = (Stores) session.getAttribute("username");
                        %>
                        <a style=" margin:  1rem;" >Welcome <%= st.getUserName()%></a>
                        <a style=" margin:  1rem;" name="link" class="col btn btn-outline-dark" href="../../UserController?service=Logout">Logout</a>
                        <%} catch (Exception e) {
                            request.getRequestDispatcher("Admin.jsp").forward(request, response);
                        } %>
                        <%} else {%>
                        <a style=" margin:  1rem;" name="link" class="col btn btn-outline-dark" href="Login.jsp">Login</a>
                        <%}%>
                    </div>
                    <%
                    } else {
                    %>
                    <a href="ShowCart.jsp">Show Cart</a>
                    <a href="../../Login.jsp">Login</a>
                    <%}%>
                </div>
            </div>
            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger alert-dismissible" role="alert">
                <%=request.getAttribute("error")%>
            </div>
            <%}%>
            <a href='../../index.jsp'><button class='btn btn-outline-dark'>View Titles</button></a>&emsp;

            <hr>
            <%
                if (session == null) {%>

            <%} else {
                java.util.Enumeration em = session.getAttributeNames();
                double sum = 0, total = 0;
            %>
            <table border="1" class='table-striped table table-fit table-hover'>
                <thead class="text-center table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (em.hasMoreElements()) {
                            try {
                                String key = em.nextElement().toString();
                                Titles title = (Titles) session.getAttribute(key);
                                sum = title.getPrice() * title.getQuantity();
                                total += sum;
                    %>
                    <tr class="text-center">
                        <td><%= key%></td>
                        <td class="text-start"><%= title.getTitle()%></td>
                        <td><%= title.getQuantity()%></td>
                        <td><%= title.getPrice()%></td>
                        <td><%= sum%></td>
                    </tr>
                    <%
                            } catch (Exception e) {

                            }
                        }
                    %>
                </tbody>
                <tfoot class="text-center">
                    <tr>
                        <th>Total</th>
                        <td><%= Math.round(total * 100.0) / 100.0%></td>
                    </tr>
                </tfoot>
            </table> 
            <h2>Are you sure to check out?</h2>
            <div>
                <form action="/CartController" method="POST">
                    <input hidden="" name="username" value="<%= username%>">
                    <button type="submit" name="service" value="Checkout">Yes</button>
                </form>
                <a href="ShowCart.jsp"><button>Return to Cart</button></a>
            </div>
            <%
                }
            %>

        </div>

        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js' crossorigin='anonymous'></script>
        <script src='https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js' crossorigin='anonymous'></script>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js' crossorigin='anonymous'></script>
    </body>
</html>