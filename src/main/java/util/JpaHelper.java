package util;

import jakarta.persistence.*;
import java.util.function.Consumer;
import java.util.function.Function;

public class JpaHelper {

    private static final EntityManagerFactory factory =
            Persistence.createEntityManagerFactory("my_persistence_unit");

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }

    public static void execute(Consumer<EntityManager> action) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            action.accept(em);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public static <R> R query(Function<EntityManager, R> action) {
        EntityManager em = getEntityManager();
        try {
            return action.apply(em);
        } finally {
            em.close();
        }
    }

    public static void close() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}
