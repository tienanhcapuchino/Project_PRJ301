

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Vector"%>
<%@page import="model.DAOEmployee"%>
<%@page import="entity.employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List all Employees</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                try {
                    employee emp = (employee) session.getAttribute("username");
                    DAOEmployee dao = new DAOEmployee();
                    Vector<employee> vector = (Vector<employee>) request.getAttribute("LIST");
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
                    <a href='EmployeeController?service=insertEmployee'><button>Insert Employee</button></a>&emsp;
                    <a href='index.jsp'><button>Return Home</button></a>
                    <hr>
                    <table border='1'>
                        <caption><%= request.getAttribute("TABLE_TITLE")%></caption>
                        <thead class="text-center table-dark">
                            <tr>
                                <th>Employee ID</th>
                                <th>First Name</th>
                                <th>Middle Letter</th>
                                <th>Last Name</th>
                                <th>Job</th>
                                <th>Job lvl</th>
                                <th>Publisher</th>
                                <th>Hire Date</th>
                                <th>update</th>
                                <th>delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (employee temp : vector) {%>
                            <tr>
                                <td><%=temp.getEmp_id()%></td>
                                <td><%=temp.getFname()%></td>
                                <td><%=temp.getMinit()%></td>
                                <td><%=temp.getLname()%></td>
                                <%ResultSet rs1 = dao.getData("select * from jobs where job_id = " + temp.getJob_id());
                                    if (rs1.next()) {%>
                                <td><%=rs1.getString(2)%></td>
                                <%}%>
                                <td><%=temp.getJob_lvl()%></td>
                                <% rs1 = dao.getData("select * from publishers where pub_id= " + temp.getPub_id());
                                    if (rs1.next()) {%>
                                <td><%=rs1.getString(2)%></td>
                                <%}
                                    try {%>
                                <td><%=new SimpleDateFormat("dd MMM yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(temp.getHire_date()))%></td>
                                <%} catch (Exception ex) {
                                        ex.printStackTrace();
                                    }%>
                                <td><a href='EmployeeController?service=updateEmployee&employeeID=<%=temp.getEmp_id()%>'>update</a></td>
                                <td><a href='EmployeeController?service=deleteEmployee&employeeID=<%=temp.getEmp_id()%>'>Delete</a></td>
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