package lk.vihanganimsara.cms.controler;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

        boolean result = signinModel.userSignin(userDto, dataSource);
        PrintWriter out = resp.getWriter();
        if (result) {
            out.print("Success");
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.sendRedirect("addComplaint.jsp");
            req.setAttribute("message", "User registered successfully!");
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            req.setAttribute("message", "Failed to register user.");
        }

    }
}
