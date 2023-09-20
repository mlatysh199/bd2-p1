package tec.bd2.proyectos.ui.servlet.CRUD;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.db.DatabaseContext;
import tec.bd2.proyectos.db.entities.ProviderEntity;
import tec.bd2.proyectos.logic.SessionManager;

public class ProviderPage extends CRUDPage {

    public ProviderPage(SessionManager sessionManager, DatabaseContext databaseContext) {
        super(sessionManager, databaseContext);
        //TODO Auto-generated constructor stub
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        int id = 0;
        boolean isSave = req.getParameter("id") == null || req.getParameter("id").isEmpty();
        if (!isSave) {
            try {
                id = Integer.parseInt(req.getParameter("id"));
            } catch (NumberFormatException e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        }
        // Object { nombre: "Value 1", "fecha de ultima compra": "2023", correo: "Value 3", direccion: "Value 4", "cantidad de compras": "5" }
        try {
            ProviderEntity provider = new ProviderEntity(
                id,
                req.getParameter("nombre"),
                req.getParameter("descripcion"),
                req.getParameter("direccion")
            );
            if (isSave)
                this.getDatabaseContext().getProviderRepository().save(provider);
            else
                this.getDatabaseContext().getProviderRepository().update(provider);
            resp.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
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
                    ProviderEntity provider = this.getDatabaseContext().getProviderRepository().findById(id);
                    if (provider != null) providers.add(provider);
                } catch (NumberFormatException e) {
                    providers = this.getDatabaseContext().getProviderRepository().findAll();
                    showData("providers", this.getDatabaseContext().getProviderRepository().findAll(), req);
                }
            } else providers = this.getDatabaseContext().getProviderRepository().findAll(); 
            showData("providers", providers, req);
        } catch (SQLException e) {
            showData("providers", new ArrayList<>(), req);
        }

        showPage("CRUD/provider.jsp", req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String id = request.getParameter("id");
        if (id != null) {
            try {
                this.getDatabaseContext().getClientRepository().delete(Integer.parseInt(id));
                response.setStatus(HttpServletResponse.SC_OK); 
                return;
            } catch (NumberFormatException | SQLException e) {
            }
        }
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

    }


}
