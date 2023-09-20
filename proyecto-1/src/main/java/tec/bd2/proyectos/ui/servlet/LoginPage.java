package tec.bd2.proyectos.ui.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.logic.SessionManager;

public class LoginPage extends Servlet {

    public LoginPage(SessionManager sessionManager) {
        super(sessionManager);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!login(req, req.getParameter("username"), req.getParameter("password"))) {
            req.setAttribute("error", "Usuario o contraseña incorrectos");
            showPage("login.jsp", req, resp);
            return;
        }
        redirect("/menu", resp); 
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (loggedIn(req)) {
            redirect("/menu", resp);
            return;
        }
        showPage("login.jsp", req, resp);
    }
    
}
