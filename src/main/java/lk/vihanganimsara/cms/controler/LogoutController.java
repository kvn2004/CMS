package lk.vihanganimsara.cms.controler;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * --------------------------------------------
 * Author: Vihanga Nimsara(kvn2004)
 * GitHub: https://github.com/kvn2004
 * --------------------------------------------
 * Created: 6/20/2025 5:38 PM
 * Project: CMS
 * --------------------------------------------
 **/

@WebServlet("/logout")
public class LogoutController extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.getSession().invalidate(); // 🔥 Kill the session
        resp.sendRedirect("signin.jsp"); // 🔁 Back to login
    }
}