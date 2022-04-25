
package controller;

import model.DAOEmployee;
import model.DAOStores;
import entity.Stores;
import entity.employee;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            HttpSession session = request.getSession();
            if (service.equals("login")) {
                String userName = request.getParameter("username");
                String password = request.getParameter("password");
                DAOEmployee daoE = new DAOEmployee();
                employee e = daoE.login(userName, password);
                if (e != null) {
                    session.setAttribute("username", e);
                    dispath(request, response, "Admin.jsp");
                } else {
                    DAOStores daoS = new DAOStores();
                    Stores s = daoS.login(userName, password);
                    if (s != null) {
                        session.setAttribute("username", s);
                        dispath(request, response, "index.jsp");
                    } else {
                        request.setAttribute("error", "Login wrong");
                        dispath(request, response, "Login.jsp");
                    }
                }
            } else if (service.equals("Logout")) {
                session.invalidate();
                dispath(request, response, "index.jsp");
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
