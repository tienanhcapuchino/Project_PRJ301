package controller;

import model.DAOAuthor;
import entity.Authors;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Vector;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AuthorController", urlPatterns = {"/AuthorController"})
public class AuthorController extends HttpServlet {

    DAOAuthor dao = new DAOAuthor();

    public boolean checkString(String string) {
        if (string == null || string.isEmpty()) {
            return false;
        } else {
            return true;
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            if (service == null) { // call controller direct
                service = "listAllAuthors";
            }
            switch (service) {
                default:
                    Vector<Authors> vector = dao.viewAllAuthors();
                    request.setAttribute("LIST", vector);
                    request.setAttribute("TITLE", "Authors Manage");
                    request.setAttribute("TABLE_TITLE", "List All Authors");
                    dispath(request, response, "/JSP/Admin/Display/DisplayAuthor.jsp");
                    break;
                case "insertAuthor":
                    String submitInsert = request.getParameter("submitInsert");
                    if (submitInsert == null) {
                        dispath(request, response, "/JSP/Admin/Insert/InsertAuthor.jsp");
                    } else {
                        switch (submitInsert) {
                            case "Insert to Database":
                                String au_id = request.getParameter("auId");
                                String au_lname = request.getParameter("auLname");
                                String au_fname = request.getParameter("auFname");
                                String phone = request.getParameter("phone");
                                String address = request.getParameter("address");
                                String city = request.getParameter("city");
                                String state = request.getParameter("state");
                                String zip = request.getParameter("zip");
                                String contract = request.getParameter("contract");
                                if (!checkString(address) || !checkString(city)) {
                                    out.print("<h2>Empty input!</h2>");
                                    return;
                                }
                                Authors au = new Authors(au_id, au_lname, au_fname, phone, address, city, state, zip, Integer.parseInt(contract));
                                int n = dao.addAuthors(au);
                                response.sendRedirect("AuthorController");
                        }
                    }
                    break;
                case "updateAuthor":
                    String submitUpdate = request.getParameter("submitUpdate");
                    if (submitUpdate == null) {
                        String auID = request.getParameter("AuthorID");
                        String sql = "select * from authors where au_id = '" + auID + "'";
                        ResultSet rs = dao.getData(sql);
                        request.setAttribute("rsAuthor", rs);
                        dispath(request, response, "/JSP/Admin/Update/UpdateAuthor.jsp");
                    } else {
                        switch (submitUpdate) {
                            case "Update to Database":
                                String auID = request.getParameter("auId");
                                String au_lname = request.getParameter("auLname");
                                String au_fname = request.getParameter("auFname");
                                String phone = request.getParameter("phone");
                                String address = request.getParameter("address");
                                String city = request.getParameter("city");
                                String state = request.getParameter("state");
                                String zip = request.getParameter("zip");
                                String contract = request.getParameter("contract");

                                if (!checkString(address) || !checkString(city)) {
                                    out.print("<h2>Empty input!</h2>");
                                    return;
                                }
                                Authors obj = new Authors(auID, au_lname, au_fname, phone, address, city, state, zip, Integer.parseInt(contract));
                                int n = dao.updateAuthors(obj);
                                response.sendRedirect("AuthorController");
                                break;
                            default:
                                response.sendRedirect("AuthorController");
                                break;
                        }

                    }
                    break;

                case "deleteAuthor":
                    String submitDelete = request.getParameter("submitDelete");
                    if (submitDelete == null) {
                        String auID = request.getParameter("AuthorID");
                        String sql = "select * from authors where au_id = '" + auID + "'";
                        ResultSet rs = dao.getData(sql);
                        request.setAttribute("rs", rs);
                        dispath(request, response, "/JSP/Admin/Delete/DeleteAuthor.jsp");
                    } else {
                        switch (submitDelete) {
                            default:
                                response.sendRedirect("AuthorController");
                                break;
                            case "Yes":
                                String auID = request.getParameter("auId");

                                dao.removeAuthors(auID);
                                response.sendRedirect("AuthorController");
                                break;
                        }
                    }
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void dispath(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
        RequestDispatcher dispath = request.getRequestDispatcher(path);
        dispath.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
