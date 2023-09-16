package tec.bd2.proyectos.ui;

import java.io.File;

import javax.servlet.ServletException;

import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;

public class Server {
    public void start() throws ServletException, LifecycleException {
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);

        String docBase = new File(".").getAbsolutePath();
         
        Context context = tomcat.addWebapp("/", docBase);
        File additionWebInfClasses = new File("target/classes");
        WebResourceRoot resources = new StandardRoot(context);
        resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                additionWebInfClasses.getAbsolutePath(), "/"));
        context.setResources(resources);

        tomcat.start();

        tomcat.getServer().await();
    } 
}
