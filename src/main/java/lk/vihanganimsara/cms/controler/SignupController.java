package lk.vihanganimsara.cms.controler;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.vihanganimsara.cms.dto.UserDto;
import lk.vihanganimsara.cms.model.SignupModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

/**
 * --------------------------------------------
 * Author: Vihanga Nimsara(kvn2004)
 * GitHub: https://github.com/kvn2004
 * --------------------------------------------
 * Created: 6/16/2025 4:45 PM
 * Project: CMS
 * --------------------------------------------
 **/
@WebServlet("/signup")
public class SignupController extends HttpServlet {
    SignupModel signupModel = new SignupModel();
    @Resource(name = "java:comp/env/jdbc/TaskDB")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        ObjectMapper mapper = new ObjectMapper();
//        Map<String, String> users = mapper.readValue(req.getInputStream(), Map.class);
//        String username = users.get("username");
//        String password = users.get("password");
//        String email = users.get("email");
//        String role = users.get("role");
//        resp.setContentType("application/json");
//        UserDto userDto = new UserDto(username, password, email, role);
//        boolean isDone = signupModel.userSignup(userDto ,dataSource);
//        // Prepare response
//        try (PrintWriter out = resp.getWriter()) {
//            if (isDone) {
//                out.write("{\"status\": \"success\", \"message\": \"User registered successfully.\"}");
//                resp.setStatus(HttpServletResponse.SC_OK); // 200
//            } else {
//                out.write("{\"status\": \"error\", \"message\": \"Failed to register user.\"}");
//                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
//            }
//        }
//    }
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String role = req.getParameter("role");

        UserDto dto = new UserDto(username, password, email, role);
        boolean result = signupModel.userSignup(dto, dataSource);

        // Tell the JSP what happened
        if (result) {
            req.setAttribute("message", "User registered successfully!");
        } else {
            req.setAttribute("message", "Failed to register user.");
        }

        // Show signup.jsp again with the message
        req.getRequestDispatcher("signup.jsp").forward(req, resp);
    }
}
