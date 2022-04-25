
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign up</title>
    </head>
    <body>
        <%
            ResultSet rs = (ResultSet) request.getAttribute("rs");
        %>

        <form action="StoreController" method="post"> 
            
            <div class="container">
                <label>Choose Your Available Store: </label>
                <select name="storid">
                    <%
                        while (rs.next()) {
                    %>
                    <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                    <%}%>
                </select>
                <br>
                <input type="hidden" name="service" value="register">
                <label>Username : </label>   
                <input type="text" placeholder="Enter Username" name="username" required>  
                <label>Password : </label>   
                <input type="password" placeholder="Enter New Password" name="password" required>  
                <button type="submit" name="submit">Register</button>    
            </div>   
        </form>
    </body>
</html>
