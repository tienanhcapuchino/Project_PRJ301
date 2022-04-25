
<%@page import="entity.employee"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update PubInfos</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                try {
                    employee emp = (employee) session.getAttribute("username");
        %>

        <header class="bg-dark text-center text-lg-start">
            <div class="text-center p-3 text-white">TIẾN ANH CAPUCHINO</div>
        </header>
        <div class="container">
            <div class="row">
                <h2 class="col">Update PubInfo</h2>
                <div class="text-end col">
                    <form action="UserController" method="POST">
                        <input disabled class="border-0 bg-transparent" style=" margin:  1rem; width: 75px;" value="Welcome <%= emp.getUserName()%>">
                        <input hidden="" name="username" class="border-0 bg-transparent" value="<%= emp.getUserName()%>">
                        <button type="submit" style=" margin:  1rem;" name="service" value="Logout" class="btn btn-outline-dark">Logout</button>
                    </form>
                </div>
            </div>
            <div class="row">
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
                <div class="col-md-9">
                    <form action='PubInfoController' method = 'POST'>
                        <input class="form-control border-0 bg-transparent" type="hidden" value="updatePubInfo" name="service">
                        <table class='table-striped table table-fit table-hover' border='1'>
                            <%
                                ResultSet rsPubInfo = (ResultSet) request.getAttribute("rsPubInfo"),
                                        rspush = (ResultSet) request.getAttribute("rsPublisher");
                                if (rsPubInfo.next()) {
                            %>
                            <tbody>
                                <tr>
                                    <td><label for="pubid">Publisher</label></td>
                                    <td>
                                        <select class="form-select border-0 bg-transparent" disabled="" id="pubid">
                                            <% while (rspush.next()) {
                                            if (rsPubInfo.getString(1).equals(rspush.getString(1))) {%>
                                            <option value='<%=rspush.getString(1)%>' selected=""><%=rspush.getString(2)%></option>
                                            <%} else {%>
                                            <option value='<%=rspush.getString(1)%>'><%=rspush.getString(2)%></option>
                                            <%}%>
                                            <%}%>
                                        </select>
                                        <input class='form-control border-0 bg-transparent' type='text' name="pubid" hidden value='<%=rsPubInfo.getString(1)%>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for='logo'>Logo</label></td>
                                    <td><input class='form-control border-0 bg-transparent' type='text' id ='logo' name='logo' value='<%=rsPubInfo.getString(2)%>'></td>
                                </tr>
                                <tr>
                                    <td><label for='prdesc'>Describe</label></td>
                                    <td><textarea class='form-control border-0 bg-transparent' rows="10" id ='prdesc' name='prdesc'><%=rsPubInfo.getString(3)%></textarea></td>
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
