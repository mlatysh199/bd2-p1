package tec.bd2.proyectos.ui.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.logic.SessionManager;

public class MenuPage extends Servlet {

    public MenuPage(SessionManager sessionManager) {
        super(sessionManager);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        throw new UnsupportedOperationException("Unimplemented method 'doPost'");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!loggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        showData("username", this.getSessionManager().getUsername(req.getSession().getId()), req);

        showPage("menu.jsp", req, resp);
    }
    
}
