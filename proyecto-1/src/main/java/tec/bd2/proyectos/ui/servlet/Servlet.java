package tec.bd2.proyectos.ui.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.logic.SessionManager;

public abstract class Servlet extends HttpServlet {
    private final SessionManager sessionManager;

    public Servlet(SessionManager sessionManager) {
        super();
        this.sessionManager = sessionManager;
    }

    // doPost is generally used when you want to create something on the server
    @Override
    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException;

    // doGet is generally used when you want to retrieve something from the server
    @Override
    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException;

    protected void showPage(String path, HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/WEB-INF/" + path).forward(req, resp);
    }

    protected void showData(String attribute, Object o, HttpServletRequest req) throws IOException {
        req.setAttribute(attribute, o);
    }

    public SessionManager getSessionManager() {
        return this.sessionManager;
    }

    protected boolean loggedIn(HttpServletRequest req) {
        return getSessionManager().isValidSession(req.getSession().getId());
    }

    protected boolean login(HttpServletRequest req, String username, String password) {
        return getSessionManager().attemptAddSession(req.getSession().getId(), username, password);
    }

    protected void logout(HttpServletRequest req) {
        getSessionManager().removeSession(req.getSession().getId());
    }

    protected void redirect(String path, HttpServletResponse resp) throws IOException {
        resp.sendRedirect(path);
    }
}
