package tec.bd2.proyectos.ui;

import java.io.File;

import javax.servlet.ServletException;

import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;

import tec.bd2.proyectos.logic.SessionManager;
import tec.bd2.proyectos.ui.servlet.AboutPage;
import tec.bd2.proyectos.ui.servlet.LoginPage;
import tec.bd2.proyectos.ui.servlet.MenuPage;
import tec.bd2.proyectos.ui.servlet.CRUD.ClientPage;
import tec.bd2.proyectos.ui.servlet.CRUD.ProductBuyPage;
import tec.bd2.proyectos.ui.servlet.CRUD.ProductPage;
import tec.bd2.proyectos.ui.servlet.CRUD.ReceiptPage;
import tec.bd2.proyectos.ui.servlet.CRUD.SummaryPage;

public class Server {
    private Tomcat tomcat;
    private SessionManager sessionManager;
    private Context context;
    public static final int port = 8080;

    public Server() {
        sessionManager = new SessionManager();
    }

    private void initServlets() {
        tomcat.addServlet("", "AboutServlet", new AboutPage(sessionManager));
        context.addServletMappingDecoded("/", "AboutServlet");

        tomcat.addServlet("", "LoginServlet", new LoginPage(sessionManager));
        context.addServletMappingDecoded("/login", "LoginServlet");

        tomcat.addServlet("", "MenuServlet", new MenuPage(sessionManager));
        context.addServletMappingDecoded("/menu", "MenuServlet");

        tomcat.addServlet("", "ClientServlet", new ClientPage(sessionManager));
        context.addServletMappingDecoded("/CRUD/client", "ClientServlet");

        tomcat.addServlet("", "ProductBuyServlet", new ProductBuyPage(sessionManager));
        context.addServletMappingDecoded("/CRUD/productBuy", "ProductBuyServlet");

        tomcat.addServlet("", "ProductServlet", new ProductPage(sessionManager));
        context.addServletMappingDecoded("/CRUD/product", "ProductServlet");

        tomcat.addServlet("", "ReceiptServlet", new ReceiptPage(sessionManager));
        context.addServletMappingDecoded("/CRUD/receipt", "ReceiptServlet");

        tomcat.addServlet("", "SummaryServlet", new SummaryPage(sessionManager));
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

    public void kill() throws LifecycleException {
        tomcat.stop();
        tomcat.destroy();
    }
}
