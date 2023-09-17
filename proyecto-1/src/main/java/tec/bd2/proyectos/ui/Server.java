package tec.bd2.proyectos.ui;

import java.io.File;

import javax.servlet.ServletException;

import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;

import tec.bd2.proyectos.ui.servlet.ServletTest;

public class Server {
    private Tomcat tomcat;
    private Context context;
    private static final int port = 8080;


    private void initServlets() {
        tomcat.addServlet("", "MyServlet", new ServletTest());
        context.addServletMappingDecoded("/hello", "MyServlet");
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

        tomcat.getServer().await();
    } 
}
