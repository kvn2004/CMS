package lk.vihanganimsara.cms.controler;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.vihanganimsara.cms.dto.UserDto;
import lk.vihanganimsara.cms.model.SigninModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * --------------------------------------------
 * Author: Vihanga Nimsara(kvn2004)
 * GitHub: https://github.com/kvn2004
 * --------------------------------------------
 * Created: 6/18/2025 2:29 AM
 * Project: CMS
 * --------------------------------------------
 **/
@WebServlet("/signin")
@MultipartConfig
public class SigninController extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/TaskDB")
    private DataSource dataSource;
    SigninModel signinModel = new SigninModel();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDto userDto = new UserDto();
        userDto.setEmail(email);
        userDto.setPassword(password);

        UserDto result = signinModel.userSignin(userDto, dataSource);
        String role = result.getRole();
        PrintWriter out = resp.getWriter();
        if (result != null) {
            // ✅ Save to session
            HttpSession session = req.getSession();
            session.setAttribute("user", result);
            switch (role.toLowerCase()) {
                case "admin":
                    resp.sendRedirect("adminDash.jsp");
                    break;
                case "employee":
                    resp.sendRedirect("addComplaint.jsp");
                    break;
                default:
                    // fallback
                    resp.sendRedirect("signin.jsp");
                    break;
            }
        } else {
            req.setAttribute("error", "Invalid credentials");
            req.getRequestDispatcher("signin.jsp").forward(req, resp);
        }

    }
}
