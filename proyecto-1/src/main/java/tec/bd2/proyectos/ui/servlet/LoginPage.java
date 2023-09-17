package tec.bd2.proyectos.ui.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.logic.SessionManager;

public class LoginPage extends Servlet {

    public LoginPage(SessionManager sessionManager) {
        super(sessionManager);
        //TODO Auto-generated constructor stub
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.sendRedirect("menu"); //si usuario es valido y contraseña tambien
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (loggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        showPage("login.jsp", req, resp);
    }
    
}
