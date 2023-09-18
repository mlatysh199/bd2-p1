package tec.bd2.proyectos.ui.servlet.CRUD;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.db.DatabaseContext;
import tec.bd2.proyectos.db.entities.ClientEntity;
import tec.bd2.proyectos.db.entities.ProviderEntity;
import tec.bd2.proyectos.logic.SessionManager;

public class ProviderPage extends CRUDPage {

    public ProviderPage(SessionManager sessionManager, DatabaseContext databaseContext) {
        super(sessionManager, databaseContext);
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
            redirect("/login", resp);
            return;
        }

        showData("username", this.getSessionManager().getUsername(req.getSession().getId()), req);

        try {
            String search = req.getParameter("search");
            List<ProviderEntity> providers = new ArrayList<>();
            if (search != null) {
                // determine if search can be converted to a number
                try {
                    int id = Integer.parseInt(search);
                    providers.add(this.getDatabaseContext().getProviderRepository().findById(id));
                } catch (NumberFormatException e) {
                    providers = this.getDatabaseContext().getProviderRepository().findAll();
                    showData("providers", this.getDatabaseContext().getProviderRepository().findAll(), req);
                }
            } else providers = this.getDatabaseContext().getProviderRepository().findAll(); 
            showData("providers", providers, req);
        } catch (SQLException e) {
            e.printStackTrace();
            showData("providers", new ArrayList<>(), req);
        }

        showPage("CRUD/provider.jsp", req, resp);
    }
    
}
