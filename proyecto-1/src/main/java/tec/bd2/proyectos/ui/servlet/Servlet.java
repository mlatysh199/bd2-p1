package tec.bd2.proyectos.ui.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class Servlet extends HttpServlet {
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

    protected void redirect(String path, HttpServletResponse resp) throws IOException {
        resp.sendRedirect(path);
    }
}
