package tec.bd2.proyectos.ui.servlet.CRUD;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.db.DatabaseContext;
import tec.bd2.proyectos.db.entities.ReceiptEntity;
import tec.bd2.proyectos.logic.SessionManager;

public class ReceiptPage extends CRUDPage {

    public ReceiptPage(SessionManager sessionManager, DatabaseContext databaseContext) {
        super(sessionManager, databaseContext);
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
        try {
            /*
             *     private int id;
    private String date;
    private int clientId;
    private int detailId;
    private int total;
    private int totalAmount;
    private String paymentMethod;
    private String description;
    private Map<Integer, Integer> productsAmounts;
             */
            ReceiptEntity receipt = new ReceiptEntity(
                id,
                req.getParameter("fecha"),
                Integer.parseInt(req.getParameter("cliente_id")),
                Integer.parseInt(req.getParameter("detalle_id")),
                Integer.parseInt(req.getParameter("total")),
                Integer.parseInt(req.getParameter("cantidad total")),
                req.getParameter("metodo de pago"),
                req.getParameter("descripcion"),
                req.getParameter("cantidad productos")
            );

            if (isSave)
                this.getDatabaseContext().getReceiptRepository().save(receipt);
            else
                this.getDatabaseContext().getReceiptRepository().update(receipt);
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
            List<ReceiptEntity> receipts = new ArrayList<>();
            if (search != null && !search.isEmpty()) {
                try {
                    int id = Integer.parseInt(search);
                    ReceiptEntity receipt = this.getDatabaseContext().getReceiptRepository().findById(id);
                    if (receipt != null) receipts.add(receipt);
                } catch (NumberFormatException e) {
                }
            } else receipts = this.getDatabaseContext().getReceiptRepository().findAll(); 
            showData("receipts", receipts, req);
        } catch (SQLException e) {
            showData("receipts", new ArrayList<>(), req);
        }

        showData("username", this.getSessionManager().getUsername(req.getSession().getId()), req);
        showPage("CRUD/receipt.jsp", req, resp);
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
