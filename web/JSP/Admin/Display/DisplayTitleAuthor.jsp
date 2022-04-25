
<%@page import="entity.employee"%>
<%@page import="model.DAOTitleAuthor"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="entity.TitleAuthor"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List All TitleAuthors</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                try {
                    DAOTitleAuthor dao = new DAOTitleAuthor();
                    Vector<TitleAuthor> vector = (Vector<TitleAuthor>) request.getAttribute("LIST");
                    employee emp = (employee) session.getAttribute("username");
        %>

        <header>
            <div>TIẾN ANH CAPUCHINO</div>
        </header>
        <div>
            <div>
                <h><%= request.getAttribute("TITLE")%></h2>
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
                    <a href='TitleAuthorController?service=insertTitleAuthor'><button>Insert TitleAuthor</button></a>&emsp;
                    <a href='index.jsp'><button>Return Home</button></a>
                    <hr>
                    <table border='1'>
                        <caption><%= request.getAttribute("TABLE_TITLE")%></caption>
                        <thead>
                            <tr>
                                <th>Author Name</th>
                                <th>Title</th>
                                <th>Author Order</th>
                                <th>Royal Typer</th>
                                <th>update</th>
                                <th>delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (TitleAuthor temp : vector) {%>
                            <tr>
                                <% ResultSet rs1 = dao.getData("select * from authors where au_id = '" + temp.getAu_id() + "'");
                            if (rs1.next()) {%>
                                <td><%=rs1.getString(2)%> <%=rs1.getString(3)%></td>
                                <%}
                                    rs1 = dao.getData("select * from titles where title_id = '" + temp.getTitle_id() + "'");
                                    if (rs1.next()) {%>
                                <td><%=rs1.getString(2)%></td>
                                <%}%>
                                <td><%=temp.getAu_ord()%></td>
                                <td><%=temp.getRoyaltyper()%></td>
                                <td><a href='TitleAuthorController?service=updateTitleAuthor&authorID=<%=temp.getAu_id()%>&titleID=<%=temp.getTitle_id()%>'>Update</a></td>
                                <td><a href='TitleAuthorController?service=deleteTitleAuthor&authorID=<%=temp.getAu_id()%>&titleID=<%=temp.getTitle_id()%>'>Delete</a></td>
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
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js' integrity='sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM' crossorigin='anonymous'></script>
        <script src='https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js' integrity='sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p' crossorigin='anonymous'></script>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js' integrity='sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF' crossorigin='anonymous'></script>

    </body>
</html>
