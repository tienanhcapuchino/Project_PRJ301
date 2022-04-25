
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
        <title>Insert Author</title>
    </head>
    <body>
        <form action="AuthorController" method=POST>
            <input type="hidden" name="service" value="insertAuthor" />
            <table class="table" border="1">
                <tr>
                    <td><label for="auId">AuthorID (xxx-xx-xxxx)</label></td>
                    <td><input class="form-control" type="text" id="auId" name="auId" pattern="[0-9]{3}-[0-9]{2}-[0-9]{4}"></td>
                </tr>
                <tr>
                    <td><label for="auLname">Last Name</label></td>
                    <td><input class="form-control" type="text" id="auLname" name="auLname" maxlength="40"></td>
                </tr>
                <tr>
                    <td><label for="auFname">First Name</label></td>
                    <td><input class="form-control" type="text" id="auFname" name="auFname" maxlength="40"></td>
                </tr>
                <tr>
                    <td><label for="phone">Phone (xxx-xxx-xxxx)</label></td>
                    <td><input class="form-control" type="tel" id="phone" name="phone" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"></td>
                </tr>
                <tr>
                    <td><label for="address">Address</label></td>
                    <td><input class="form-control" type="text" id="address" name="address" maxlength="40"></td>
                </tr>
                <tr>
                    <td><label for="city">City</label></td>
                    <td><input class="form-control" type="text" id="city" name="city" maxlength="20"></td>
                </tr>
                <tr>
                    <td><label for="state">State (2 letters)</label></td>
                    <td><input class="form-control" type="text" id="state" name="state" pattern="[A-Z]{2}"></td>
                </tr>
                <tr>
                    <td><label for="zip">Zip (xxxxx)</label></td>
                    <td><input class="form-control" type="text" id="zip" name="zip" pattern="[0-9]{5}"></td>
                </tr>
                <tr>
                    <td><label for="contract">Contract (0/1)</label></td>
                    <td>
                        <select class="form-select" id="contract" name="contract">
                            <option value = "1">True</option>
                            <option value = "0">False</option>
                        </select>
                    </td>
                </tr>
                <td>
                    <input class="btn btn-outline-dark" type="submit" name="submitInsert" value="Insert to Database">
                </td>
                <td>
                    <a href="AuthorController">Go back</a>
                </td>
                <td>
                    <input class="btn btn-outline-dark" type="reset" value="Reset">
                </td>
                </tr>
            </table>
        </form>
    </body>
</html>
