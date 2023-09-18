package tec.bd2.proyectos.ui;

import java.io.File;
import java.sql.SQLException;

import javax.servlet.ServletException;

import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;

import tec.bd2.proyectos.db.DatabaseContext;
import tec.bd2.proyectos.logic.PasswordController;
import tec.bd2.proyectos.logic.SessionManager;
import tec.bd2.proyectos.ui.servlet.LoginPage;
import tec.bd2.proyectos.ui.servlet.MenuPage;
import tec.bd2.proyectos.ui.servlet.CRUD.ClientPage;
import tec.bd2.proyectos.ui.servlet.CRUD.ProductBuyPage;
import tec.bd2.proyectos.ui.servlet.CRUD.ProductPage;
import tec.bd2.proyectos.ui.servlet.CRUD.ReceiptPage;
import tec.bd2.proyectos.ui.servlet.CRUD.SummaryPage;

public class Server {
    private Tomcat tomcat;
    private final SessionManager sessionManager;
    private final DatabaseContext databaseContext;
    private Context context;
    public static final int port = 8080;

    public Server(DatabaseContext databaseContext) {
        this.databaseContext = databaseContext;
        sessionManager = new SessionManager(new PasswordController(databaseContext));
    }

    private void initServlets() {
        tomcat.addServlet("", "LoginServlet", new LoginPage(sessionManager));
        context.addServletMappingDecoded("/login", "LoginServlet");

        tomcat.addServlet("", "MenuServlet", new MenuPage(sessionManager));
        context.addServletMappingDecoded("/menu", "MenuServlet");

        tomcat.addServlet("", "ClientServlet", new ClientPage(sessionManager, databaseContext));
        context.addServletMappingDecoded("/CRUD/client", "ClientServlet");

        tomcat.addServlet("", "ProductBuyServlet", new ProductBuyPage(sessionManager, databaseContext));
        context.addServletMappingDecoded("/CRUD/productBuy", "ProductBuyServlet");

        tomcat.addServlet("", "ProductServlet", new ProductPage(sessionManager, databaseContext));
        context.addServletMappingDecoded("/CRUD/product", "ProductServlet");

        tomcat.addServlet("", "ReceiptServlet", new ReceiptPage(sessionManager, databaseContext));
        context.addServletMappingDecoded("/CRUD/receipt", "ReceiptServlet");

        tomcat.addServlet("", "SummaryServlet", new SummaryPage(sessionManager, databaseContext));
        context.addServletMappingDecoded("/CRUD/summary", "SummaryServlet");
    }

    public void start() throws LifecycleException {
        tomcat = new Tomcat();
        tomcat.setPort(port);

        String docBase = new File(".").getAbsolutePath();
         
        try {
            context = tomcat.addWebapp("", docBase);
        } catch (ServletException e) {
            e.printStackTrace();
        }

        initServlets();

        tomcat.start();
    }

    public void kill() throws LifecycleException, SQLException {
        tomcat.stop();
        tomcat.destroy();
        databaseContext.getJdbcController().closeConnection();
    }
}
