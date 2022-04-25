package controller;

import model.DAOSalesDetail;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ConnectDB;

@WebServlet(name = "SalesDetailController", urlPatterns = {"/SalesDetailController"})
public class SalesDetailController extends HttpServlet {

    ConnectDB dao = new ConnectDB();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            DAOSalesDetail dao = new DAOSalesDetail();
            String storeId = request.getParameter("storeID"), StoreName = "";
            ResultSet name = dao.getData("select stor_name from Stores where stor_id = '" + storeId + "'");
            if (name.next()) {
                StoreName = name.getString(1);
            }
            String service = request.getParameter("service");
            if (service != null && service.equalsIgnoreCase("updateStatus")) {
                String OrderNumber = request.getParameter("OrderNumber");
                int status = Integer.parseInt(request.getParameter("status"));
                int n = dao.updateSalesDetail(storeId, OrderNumber, status);
                System.out.println(n);
            }
            String sql = "SELECT sales.ord_num,titles.title,dbo.titles.price,sales.qty,dbo.sales.qty * dbo.titles.price AS Total,sales.status,titles.title_id"
                    + "                     FROM Sales "
                    + "                     INNER JOIN Titles ON titles.title_id=sales.title_id "
                    + "                     INNER JOIN stores ON stores.stor_id=sales.stor_id "
                    + "                     INNER JOIN Publishers ON publishers.pub_id=titles.pub_id"
                    + "			    WHERE dbo.stores.stor_id = '" + storeId + "' ";
            ResultSet rs = dao.getData(sql);
            String[] status = {"", "Wait", "Process", "Done"};
            request.setAttribute("status", status);
            request.setAttribute("rsSalesDetail", rs);
            request.setAttribute("storeId", storeId);
            request.setAttribute("storeName", StoreName);
            if (request.getParameter("previous") != null) {
                response.sendRedirect("SaleController");
            } else {
                RequestDispatcher dispath = request.getRequestDispatcher("/JSP/Admin/Display/DisplaySaleDetail.jsp");
                dispath.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
