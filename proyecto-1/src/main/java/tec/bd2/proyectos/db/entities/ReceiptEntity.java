package tec.bd2.proyectos.db.entities;

import java.util.Map;

public class ReceiptEntity implements Entity {
    /*
     * CREATE TABLE RECIBO(
    id NUMBER(10) NOT NULL,
    fecha DATE NOT NULL,
    cliente_id NUMBER(10) NOT NULL,
    CONSTRAINT pk_recibo PRIMARY KEY(id),
    CONSTRAINT fk_cliente FOREIGN KEY(cliente_id) REFERENCES CLIENTE(id)
);

CREATE TABLE PRODUCTO_RECIBO(
    producto_id NUMBER(10) NOT NULL,
    recibo_id NUMBER(10) NOT NULL,
    cantidad NUMBER(10) NOT NULL,
    CONSTRAINT pk_producto_recibo PRIMARY KEY(producto_id, recibo_id),
    CONSTRAINT fk_producto_recibo_producto FOREIGN KEY(producto_id) REFERENCES PRODUCTO(id),
    CONSTRAINT fk_producto_recibo_recibo FOREIGN KEY(recibo_id) REFERENCES RECIBO(id)
);

CREATE TABLE RECIBO_DETALLE(
    id NUMBER(10) NOT NULL,
    recibo_id NUMBER(10) NOT NULL,
    monto NUMBER(10,2) NOT NULL,
    cantidad NUMBER(10) NOT NULL,
    metodo_pago VARCHAR2(30) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_recibo_detalle PRIMARY KEY(id),
    CONSTRAINT fk_recibo_detalle_recibo FOREIGN KEY(recibo_id) REFERENCES RECIBO(id)
);
     */
    private int id;
    private String date;
    private int clientId;
    private int detailId;
    private int total;
    private int totalAmount;
    private String paymentMethod;
    private String description;
    private Map<Integer, Integer> productsAmounts;

    public ReceiptEntity() {
    }

    public ReceiptEntity(String date, int clientId, int total, int totalAmount, String paymentMethod, String description, Map<Integer, Integer> productsAmounts) {
        this.date = date;
        this.clientId = clientId;
        this.total = total;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.description = description;
        this.productsAmounts = productsAmounts;
    }

    public ReceiptEntity(int id, String date, int clientId, int detailId, int total, int totalAmount, String paymentMethod, String description, Map<Integer, Integer> productsAmounts) {
        this.id = id;
        this.date = date;
        this.clientId = clientId;
        this.detailId = detailId;
        this.total = total;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.description = description;
        this.productsAmounts = productsAmounts;
    }

    @Override
    public String toString() {
        String products = "";
        for (Map.Entry<Integer, Integer> entry : productsAmounts.entrySet()) {
            products += entry.getKey() + " " + entry.getValue() + ", ";
        }
        return "ReceiptEntity [clientId=" + clientId + ", date=" + date + ", description=" + description + ", detailId="
                + detailId + ", id=" + id + ", paymentMethod=" + paymentMethod + ", productsAmounts=" + productsAmounts
                + ", total=" + total + ", totalAmount=" + totalAmount + " [" + products +  "]]";
    }
    
    public int getId() {
        return id;
    }

    public String getDate() {
        return date;
    }

    public int getClientId() {
        return clientId;
    }

    public int getDetailId() {
        return detailId;
    }

    public int getTotal() {
        return total;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public String getDescription() {
        return description;
    }

    public Map<Integer, Integer> getProductsAmounts() {
        return productsAmounts;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setProductsAmounts(Map<Integer, Integer> productsAmounts) {
        this.productsAmounts = productsAmounts;
    }
}
