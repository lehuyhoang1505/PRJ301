package listener;

import util.JpaHelper;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Closes the JPA EntityManagerFactory when the application stops.
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Application started. JPA EntityManagerFactory initialized.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        JpaHelper.close();
        System.out.println("Application stopped. JPA EntityManagerFactory closed.");
    }
}
