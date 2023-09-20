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
import tec.bd2.proyectos.logic.SessionManager;

public class ClientPage extends CRUDPage {

    public ClientPage(SessionManager sessionManager, DatabaseContext databaseContext) {
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
            ClientEntity client = new ClientEntity(
                id,
                req.getParameter("nombre"),
                req.getParameter("fecha de ultima compra"),
                req.getParameter("correo"),
                req.getParameter("direccion"),
                Integer.parseInt(req.getParameter("cantidad de compras"))
            );
            if (isSave)
                this.getDatabaseContext().getClientRepository().save(client);
            else
                this.getDatabaseContext().getClientRepository().update(client);
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
            List<ClientEntity> clients = new ArrayList<>();
            if (search != null && !search.isEmpty()) {
                // determine if search can be converted to a number
                try {
                    int id = Integer.parseInt(search);
                    ClientEntity client = this.getDatabaseContext().getClientRepository().findById(id);
                    if (client != null) clients.add(this.getDatabaseContext().getClientRepository().findById(id));
                } catch (NumberFormatException e) {
                }
            } else clients = this.getDatabaseContext().getClientRepository().findAll(); 
            showData("clients", clients, req);
        } catch (SQLException e) {
            showData("clients", new ArrayList<>(), req);
        }

        showPage("CRUD/client.jsp", req, resp);
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
