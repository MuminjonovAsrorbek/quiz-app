package uz.dev.lesson9.config;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import javax.swing.text.html.parser.Entity;

/**
 * Created by: asrorbek
 * DateTime: 4/28/25 13:40
 **/

@WebListener
public class StartStopListener implements ServletContextListener {

    public static EntityManagerFactory sessionFactory;

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        sessionFactory = Persistence.createEntityManagerFactory("ORM_TEST");

    }

}
