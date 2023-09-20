package tec.bd2.proyectos.ui.servlet.CRUD;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.db.DatabaseContext;
import tec.bd2.proyectos.db.entities.ProductBuyEntity;
import tec.bd2.proyectos.logic.SessionManager;

public class ProductBuyPage extends CRUDPage {

    public ProductBuyPage(SessionManager sessionManager, DatabaseContext databaseContext) {
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
            ProductBuyEntity productBuy = new ProductBuyEntity(
                id,
                Integer.parseInt(req.getParameter("producto_id")),
                Integer.parseInt(req.getParameter("proveedor_id")),
                req.getParameter("fecha"),
                Integer.parseInt(req.getParameter("cantidad")),
                Integer.parseInt(req.getParameter("monto")),
                req.getParameter("descripcion")
            );
            if (isSave)
                this.getDatabaseContext().getProductBuyRepository().save(productBuy);
            else
                this.getDatabaseContext().getProductBuyRepository().update(productBuy);
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
            List<ProductBuyEntity> productsBuyEntities = new ArrayList<>();
            if (search != null && !search.isEmpty()) {
                // determine if search can be converted to a number
                try {
                    int id = Integer.parseInt(search);
                    ProductBuyEntity productBuy = this.getDatabaseContext().getProductBuyRepository().findById(id);
                    if (productBuy != null) productsBuyEntities.add(productBuy);
                } catch (NumberFormatException e) {
                }
            } else productsBuyEntities = this.getDatabaseContext().getProductBuyRepository().findAll(); 
            showData("productsBuy", productsBuyEntities, req);
        } catch (SQLException e) {
            showData("productsBuy", new ArrayList<>(), req);
        }

        showPage("CRUD/product_buy.jsp", req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) {
            try {
                this.getDatabaseContext().getProductBuyRepository().delete(Integer.parseInt(id));
                resp.setStatus(HttpServletResponse.SC_OK); 
                return;
            } catch (NumberFormatException | SQLException e) {
            }
        }
        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
    }


    

