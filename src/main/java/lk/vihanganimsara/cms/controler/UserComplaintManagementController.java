package lk.vihanganimsara.cms.controler;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.vihanganimsara.cms.dto.ComplainDto;
import lk.vihanganimsara.cms.dto.UserDto;
import lk.vihanganimsara.cms.model.UserComplaintManagementModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

/**
 * --------------------------------------------
 * Author: Vihanga Nimsara(kvn2004)
 * GitHub: https://github.com/kvn2004
 * --------------------------------------------
 * Created: 6/20/2025 11:11 PM
 * Project: CMS
 * --------------------------------------------
 **/
@WebServlet("/usercomplaint")
@MultipartConfig
public class UserComplaintManagementController extends HttpServlet {
    UserComplaintManagementModel UCMModel = new UserComplaintManagementModel();
    @Resource(name = "java:comp/env/jdbc/TaskDB")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDto user = (UserDto) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("signin.jsp");
            return;
        }

        String mode = req.getParameter("mode");

        try {
            switch (mode == null ? "save" : mode) {
                case "delete":
                    int deleteId = Integer.parseInt(req.getParameter("id"));
                    UCMModel.deleteComplaint(deleteId, dataSource);
                    break;

                case "update":
                    int updateId = Integer.parseInt(req.getParameter("id"));
                    String updatedTitle = req.getParameter("cTitle");
                    String updatedDesc = req.getParameter("cDescription");
                    String updatedStatus = req.getParameter("status");

                    ComplainDto updatedComplain = new ComplainDto();
                    updatedComplain.setId(updateId);
                    updatedComplain.setTitle(updatedTitle);
                    updatedComplain.setDescription(updatedDesc);
                    updatedComplain.setStatus(updatedStatus);

                    UCMModel.updateComplaint(updatedComplain, dataSource);
                    break;

                case "save":
                default:
                    String Title = req.getParameter("cTitle");
                    String Description = req.getParameter("cDescription");
                    String status = "PENDING";
                    int userId = user.getId();

                    ComplainDto complain = new ComplainDto();
                    complain.setTitle(Title);
                    complain.setDescription(Description);
                    complain.setStatus(status);
                    complain.setUserID(String.valueOf(userId));

                    UCMModel.saveComplain(complain, dataSource);
                    break;
            }

            resp.sendRedirect("usercomplaint");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDto user = (UserDto) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("signin.jsp");
            return;
        }

        try {
            int userId = user.getId();
            List<ComplainDto> allComplaints = UCMModel.getAllComplaints(userId, dataSource);
            System.out.println("doGet: Retrieved " + allComplaints.size() + " complaints for userId: " + userId);
            req.setAttribute("complaints", allComplaints);
            req.getRequestDispatcher("addComplaint.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
