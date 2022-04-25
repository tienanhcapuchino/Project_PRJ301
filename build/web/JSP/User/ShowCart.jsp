
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
                        <a href="/JSP/User/ShowCart.jsp">Show Cart</a>
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
                        <th>Submit</th>
                        <th>Remove</th>
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
                <form action="CartController" method="POST">
                    <tr class="text-center">
                        <td><%= key%></td>
                        <td class="text-start"><%= title.getTitle()%></td>
                        <td>
                            <input type="number" name="quantity" value="<%= title.getQuantity()%>" class="bg-transparent form-control">
                            <input hidden="" name="titleID" value="<%=key%>">
                        </td>
                        <td><%= title.getPrice()%></td>
                        <td><%= sum%></td>
                        <td><button type="submit" name="service" value="updateQty">Update</button></td>
                        <td><button type="submit" name="service" value="removeCart">Remove</button></td>

                </form>

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
                        <td><a class='btn btn-outline-dark' href='CartController?service=removeAll'>Remove All</a></td>
                    </tr>
                </tfoot>
            </table> 
            <div class=" text-end">
                <button><a href="/JSP/User/Confirm.jsp">Checkout</a></button>
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