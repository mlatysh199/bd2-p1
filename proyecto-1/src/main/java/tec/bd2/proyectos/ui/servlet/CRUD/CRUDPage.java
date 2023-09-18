package tec.bd2.proyectos.ui.servlet.CRUD;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.db.DatabaseContext;
import tec.bd2.proyectos.logic.SessionManager;
import tec.bd2.proyectos.ui.servlet.Servlet;

public abstract class CRUDPage extends Servlet {

    private final DatabaseContext databaseContext;

    public CRUDPage(SessionManager sessionManager, DatabaseContext databaseContext) {
        super(sessionManager);
        this.databaseContext = databaseContext;
        //TODO Auto-generated constructor stub
    }

    protected DatabaseContext getDatabaseContext() {
        return this.databaseContext;
    }

    protected abstract void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException;
}
