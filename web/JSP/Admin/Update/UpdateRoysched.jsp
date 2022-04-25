
<%@page import="entity.employee"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Roysched</title>
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
                <h2 class="col">Update Roysched</h2>
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
                    <form action='RoyschedController' method = 'POST'>
                        <input class="form-control border-0 bg-transparent" type="hidden" value="updateRoysched" name="service">
                        <table class='table-striped table table-fit table-hover' border='1'>
                            <%
                                ResultSet rsRoysched = (ResultSet) request.getAttribute("rsRoysched");
                                ResultSet rsTitle = (ResultSet) request.getAttribute("rsTitle");
                                if (rsRoysched.next()) {
                            %>
                            <tbody>
                                <tr>
                                    <td><label for='title_id'>Title</label></td>
                                    <td>
                                        <select disabled class='form-select bg-transparent' name='title_id' id='title_id'>
                                            <%while (rsTitle.next()) {
                                            if (rsTitle.getString(1).equals(rsRoysched.getString(1))) {%>
                                            <option value='<%=rsTitle.getString(1)%>' selected=""><%=rsTitle.getString(2)%></option>
                                            <%  } else {%>
                                            <option value='<%=rsTitle.getString(1)%>'><%=rsTitle.getString(2)%></option>
                                            <%  }%>
                                            <%}%>
                                        </select>
                                        <input class='form-control bg-transparent' type='text' hidden id ='royalty' name='title_id' value='<%=rsRoysched.getString(1)%>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for='lorange'>Lorange</label></td>
                                    <td>
                                        <input class='form-control bg-transparent' type='number' id ='lorange' name='lorange' value='<%=rsRoysched.getInt(2)%>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for='hirange'>Hirange</label></td>
                                    <td>
                                        <input class='form-control bg-transparent' type='number' id ='hirange' name='hirange' value='<%=rsRoysched.getInt(3)%>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for='royalty'>Royalty</label></td>
                                    <td>
                                        <%=rsRoysched.getInt(4)%>
                                        <input class='form-control bg-transparent' type='text' hidden id ='royalty' name='royalty' value='<%=rsRoysched.getInt(4)%>'>
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