

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            ResultSet rs = (ResultSet)request.getAttribute("rs");
        %>
        <%if (rs.next()){%>
        <form action="AuthorController" method="post">
            <input  type="hidden" name="service" value="deleteAuthor">
            <table class="table">
                <tr>
                    <td><label for="auId">AuthorID</label></td>
                    <td>
                        <input  type="text" id ="auId" disabled value= "<%=rs.getString(1)%>">
                        <input  type="hidden" id ="auId" name="auId" value= "<%=rs.getString(1)%>">
                    </td>
                </tr>
                <tr>
                    <td><label for="auLname">Last Name</label></td>
                    <td><input  disabled type="text" id ="auLname" name="auLname" maxlength="40" value= "<%=rs.getString(2)%>"></td>
                </tr>
                <tr>
                    <td><label for="auFname">First Name</label></td>
                    <td><input  disabled type="text" id ="auFname" name="auFname" maxlength="40" value= "<%=rs.getString(3)%>"></td>
                </tr>
                <tr>
                    <td><label for="phone">Phone</label></td>
                    <td><input  disabled type="tel" id ="phone" name="phone" pattern="[0-9]{3} [0-9]{3}-[0-9]{4}" placeholder="xxx xxx-xxxx" value= "<%=rs.getString(4)%>"></td>
                </tr>
                <tr>
                    <td><label for="address">Address</label></td>
                    <td><input  disabled type="text" id ="address" name="address" maxlength="40" value="<%=rs.getString(5)%>"></td>
                </tr>
                <tr>
                    <td><label for="city">City</label></td>
                    <td><input  disabled type="text" id ="city" name="city" maxlength="20" value="<%=rs.getString(6)%>"></td>
                </tr>
                <tr>
                    <td><label for="state">State</label></td>
                    <td><input  disabled type="text" id ="state" name="state" pattern="[A-Z]{2}" placeholder="2 letters" value="<%=rs.getString(7)%>"></td>
                </tr>
                <tr>
                    <td><label for="zip">Zip</label></td>
                    <td><input  disabled type="text" id ="zip" name="zip" pattern="[0-9]{5}" placeholder="xxxxx" value="<%=rs.getString(8)%>"></td>
                </tr>
                <tr>
                    <td><label for="contract">Contract</label></td>
                    <td>
                        <select class="form-select" disabled id="contract" name="contract">
                            <%if (Integer.parseInt(rs.getString(9)) == 1) {%>
                            <option selected value = "1">True</option>
                            <option value = "0">False</option>
                            <%} else {%>
                            <option value = "1">True</option>
                            <option selected value = "0">False</option>
                            <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h2>Do you want to delete this Author ?</h2>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input class="btn btn-outline-dark" type="submit" value="Yes" name="submitDelete">
                    </td>
                    <td>
                        <input class="btn btn-outline-dark" type="submit" value="No & Back" name="submitDelete">
                    </td>
                    </tr> 
                </tbody>
                </table>
        </form>
        <%}%>
    </body>
</html>
