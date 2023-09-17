package tec.bd2.proyectos.ui.servlet.CRUD;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.logic.SessionManager;
import tec.bd2.proyectos.ui.servlet.Servlet;

public class ClientPage extends Servlet {

    public ClientPage(SessionManager sessionManager) {
        super(sessionManager);
        //TODO Auto-generated constructor stub
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'doPost'");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!loggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        showPage("CRUD/client.jsp", req, resp);
    }
    
}
