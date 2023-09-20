package tec.bd2.proyectos.ui.servlet.CRUD;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.db.DatabaseContext;
import tec.bd2.proyectos.db.entities.ProductEntity;
import tec.bd2.proyectos.logic.SessionManager;

public class ProductPage extends CRUDPage {

    public ProductPage(SessionManager sessionManager, DatabaseContext databaseContext) {
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
            ProductEntity product = new ProductEntity(
                id,
                req.getParameter("nombre"),
                req.getParameter("descripcion"),
                Integer.parseInt(req.getParameter("precio")),
                req.getParameter("categoria"),
                Integer.parseInt(req.getParameter("inventario"))
            );
            if (isSave)
                this.getDatabaseContext().getProductRepository().save(product);
            else
                this.getDatabaseContext().getProductRepository().update(product);
            resp.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            e.printStackTrace();
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
            List<ProductEntity> products = new ArrayList<>();
            if (search != null && !search.isEmpty()) {
                // determine if search can be converted to a number
                try {
                    int id = Integer.parseInt(search);
                    ProductEntity product = this.getDatabaseContext().getProductRepository().findById(id);
                    if (product != null) products.add(this.getDatabaseContext().getProductRepository().findById(id));
                } catch (NumberFormatException e) {
                }
            } else products = this.getDatabaseContext().getProductRepository().findAll(); 
            showData("products", products, req);
        } catch (SQLException e) {
            showData("products", new ArrayList<>(), req);
        }

        showPage("CRUD/product.jsp", req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) {
            try {
                this.getDatabaseContext().getProductRepository().delete(Integer.parseInt(id));
                resp.setStatus(HttpServletResponse.SC_OK); 
                return;
            } catch (NumberFormatException | SQLException e) {
            }
        }
        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
}


    

