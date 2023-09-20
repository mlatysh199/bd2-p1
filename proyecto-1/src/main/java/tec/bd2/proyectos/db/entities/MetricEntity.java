package tec.bd2.proyectos.db.entities;

public class MetricEntity implements Entity{
    private String date;
    private int product_id;
    private int total;

    public MetricEntity() {
    }

    public MetricEntity(String date, int product_id, int total) {
        this.date = date;
        this.product_id = product_id;
        this.total = total;
    }

    public String getDate() {
        return date;
    }

    public int getProduct_id() {
        return product_id;
    }


    public int getTotal() {
        return total;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    @Override
    public String toString(){
        return "MetricEntity{" +
                "date='" + date + '\'' +
                ", product_id=" + product_id +
                ", total=" + total +
                '}';
    }
}
