package controller;

import model.DAOSales;
import entity.Sales;
import entity.Stores;
import entity.Titles;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CartController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            String titleID = request.getParameter("titleID");
            if (service == null) { // call controller direct
                service = "showCart";
            }
            DAOSales dao = new DAOSales();
            HttpSession session = request.getSession();
            java.util.Enumeration em = session.getAttributeNames();
            switch (service) {
                default:
                    dispath(request, response, "./JSP/User/ShowCart.jsp");
                    break;
                case "addToCart":
                    Titles title = (Titles) session.getAttribute(titleID);
                    if (title == null) {
                        ResultSet rs = dao.getData("Select * from Titles where title_id='" + titleID + "'");
                        if (rs.next()) {
                            String titleName = rs.getString(2);
                            double price = rs.getDouble(5);
                            title = new Titles(titleID, titleName, price, 1);
                        }
                    } else {
                        title.setQuantity(title.getQuantity() + 1);
                    }
                    session.setAttribute(titleID, title);
                    request.setAttribute("title", title.getTitle());
                    dispath(request, response, "index.jsp");
                    break;
                case "updateQty":
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    title = (Titles) session.getAttribute(titleID);
                    title.setQuantity(quantity);
                    session.setAttribute(titleID, title);
                    response.sendRedirect("CartController");
                    break;
                case "removeCart":
                    session.removeAttribute(titleID);
                    dispath(request, response, "./JSP/User/ShowCart.jsp");
                    break;
                case "removeAll":
                    while (em.hasMoreElements()) {
                        try {
                            String key = em.nextElement().toString();
                            Titles get = (Titles) session.getAttribute(key);
                            if (get != null) {
                                session.removeAttribute(key);
                            }
                        } catch (Exception e) {
                            continue;
                        }
                    }
                    dispath(request, response, "./JSP/User/ShowCart.jsp");
                    break;
                case "Checkout":
                    Stores username = (Stores) session.getAttribute("username");
//                    if ("null".equals(username) || username == null || username.isEmpty()) {
                    if (username == null) {
                        dispath(request, response, "Login.jsp");
                    } else {
                        String user = username.getUserName();
                        String storeID = "";
                        ResultSet rs = dao.getData("select stor_id from stores where username like '" + user + "'");
                        if (rs.next()) {
                            storeID = rs.getString(1);
                        }
                        if (storeID.isEmpty() || storeID.equals("")) {
                            request.setAttribute("error", "You are admin so you are not allow to buy anything! This is just for check");
                            dispath(request, response, "./JSP/User/ShowCart.jsp");
                        } else {
                            Random rand=new Random();
                            String[] alpha = "abcdefghiklmnopqstvuw1234567890".toUpperCase().split("");
                            for (int i = 0; i < 5; i++) {
                                user+=alpha[rand.nextInt(alpha.length)];
                            }
                            while (em.hasMoreElements()) {
                                try {
                                    String key = em.nextElement().toString();
                                    Titles get = (Titles) session.getAttribute(key);
                                    Sales sale = new Sales(storeID, user, LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME), get.getQuantity(), "ON invoice", key);
                                    if (dao.addSales(sale) > 0) {
                                        session.removeAttribute(key);
                                    }
                                } catch (Exception e) {
                                    continue;
                                }
                            }
                            response.sendRedirect("SaleController?username="+user);
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
