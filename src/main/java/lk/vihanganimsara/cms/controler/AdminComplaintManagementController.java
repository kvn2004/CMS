package lk.vihanganimsara.cms.controler;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.vihanganimsara.cms.dto.ComplainDto;
import lk.vihanganimsara.cms.model.AdminComplaintManagementModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

@WebServlet("/adminDashboard")
public class AdminComplaintManagementController extends HttpServlet {

    AdminComplaintManagementModel model = new AdminComplaintManagementModel();

    @Resource(name = "java:comp/env/jdbc/TaskDB")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<ComplainDto> complaints = model.getAllComplaints(dataSource);
            req.setAttribute("complaints", complaints);
            req.getRequestDispatcher("adminDash.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String mode = req.getParameter("mode");

        try {
            switch (mode) {
                case "update":
                    int updateId = Integer.parseInt(req.getParameter("id"));
                    String newStatus = req.getParameter("status");

                    ComplainDto updatedComplaint = new ComplainDto();
                    updatedComplaint.setId(updateId);
                    updatedComplaint.setStatus(newStatus);
                    model.updateComplaintStatus(updatedComplaint, dataSource);
                    break;

                case "delete":
                    int deleteId = Integer.parseInt(req.getParameter("id"));
                    model.deleteComplaint(deleteId, dataSource);
                    break;
            }

            resp.sendRedirect("adminDashboard");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
