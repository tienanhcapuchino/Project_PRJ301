
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
        <title>Update Titles</title>
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
                <h2 class="col">Update Title</h2>
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
                    <form action='TitleController' method = 'POST'>
                        <input class="form-control border-0 bg-transparent" type="hidden" value="updateTitle" name="service">
                        <table class='table-striped table table-fit table-hover' border='1'>
                            <%
                                ResultSet rsTitle = (ResultSet) request.getAttribute("rsTitle"),
                                        rspush = (ResultSet) request.getAttribute("rsPublisher");
                                if (rsTitle.next()) {
                            %>
                            <tbody>
                                <tr>
                                    <td><label for="titleId">TitleID</label></td>
                                    <td>
                                        <input class="form-control border-0 bg-transparent" type="text" disabled value="<%=rsTitle.getString(1)%>" id ="titleId">
                                        <input class="form-control border-0 bg-transparent" type="hidden" value="<%=rsTitle.getString(1)%>" name="titleId">
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for="title">Title</label></td>
                                    <td><input class="form-control border-0 bg-transparent" type="text" value="<%=rsTitle.getString(2)%>" id ="title" name="title" maxlength="80"></td>
                                </tr>
                                <tr>
                                    <td><label for="type">Type</label></td>
                                    <td><input class="form-control border-0 bg-transparent" type="text" value="<%=rsTitle.getString(3)%>" id ="type" name="type" maxlength="12"></td>
                                </tr>
                                <tr>
                                    <td><label for="pubid">Publisher</label></td>
                                    <td><select class="form-select border-0 bg-transparent" name="pubid" id="pubid">
                                            <% while (rspush.next()) {
                                            if (rsTitle.getString(4).equals(rspush.getString(1))) {%>
                                            <option value='<%=rspush.getString(1)%>' selected=""><%=rspush.getString(2)%></option>
                                            <%} else {%>
                                            <option value='<%=rspush.getString(1)%>'><%=rspush.getString(2)%></option>
                                            <%}%>
                                            <%}%>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td><label for="price">Price</label></td>
                                    <td><input class="form-control border-0 bg-transparent" type="number" value="<%=rsTitle.getDouble(5)%>" step="any" id ="price" name="price" value="0" min="0"></td>
                                </tr>
                                <tr>
                                    <td><label for="advanced">Advanced</label></td>
                                    <td><input class="form-control border-0 bg-transparent" type="number" value="<%=rsTitle.getDouble(6)%>" step="any" id ="advanced" name="advanced" value="0" min="0"></td>
                                </tr>
                                <tr>
                                    <td><label for="royalty">Royalty</label></td>
                                    <td><input class="form-control border-0 bg-transparent" type="number" value="<%=rsTitle.getInt(7)%>" step="any" id ="royalty" name="royalty" value="0" min="0"></td>
                                </tr>
                                <tr>
                                    <td><label for="ytdsales">Year to Date sales</label></td>
                                    <td><input class="form-control border-0 bg-transparent" type="number" value="<%=rsTitle.getInt(8)%>" step="any" id ="ytdsales" name="ytdsales" value="0" min="0"></td>
                                </tr>
                                <tr>
                                    <td><label for="notes">Notes:</label></td>
                                    <td><textarea id="notes" class="form-control border-0 bg-transparent" name="notes" rows="4" cols="50"><%=rsTitle.getString(9)%></textarea></td>
                                </tr>
                                <tr>
                                    <td><label for="pubdate">Publish Date</label></td>
                                    <td><input class="form-control border-0 bg-transparent" type="date" value="<%=rsTitle.getString(10).split(" ")[0]%>" id ="pubdate" name="pubdate"></td>
                                </tr>
                                <tr>
                                    <td><label for="image">Image</label></td>
                                    <td><input type="text" value="<%=rsTitle.getString(11)%>" id ="image" name="image"></td>
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
