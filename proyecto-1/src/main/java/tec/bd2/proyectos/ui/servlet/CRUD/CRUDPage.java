package tec.bd2.proyectos.ui.servlet.CRUD;

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
}
