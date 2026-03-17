package dao;

<<<<<<< HEAD
=======
import jakarta.persistence.NoResultException;
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
import models.UserAddress;
import util.JpaHelper;
import java.util.List;

public class AddressDAO {

<<<<<<< HEAD
    public List<UserAddress> findByUserId(int userId) {
        return JpaHelper.query(em ->
            em.createQuery(
                "SELECT a FROM UserAddress a WHERE a.userId = :uid ORDER BY a.isDefault DESC, a.createdAt DESC",
                UserAddress.class)
              .setParameter("uid", userId)
=======
    public List<UserAddress> findByUserId(Integer userId) {
        return JpaHelper.query(em ->
            em.createQuery(
                "SELECT a FROM UserAddress a WHERE a.userId = :userId ORDER BY a.isDefault DESC, a.id DESC",
                UserAddress.class)
              .setParameter("userId", userId)
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
              .getResultList()
        );
    }

<<<<<<< HEAD
    public UserAddress findById(int id) {
        return JpaHelper.query(em -> em.find(UserAddress.class, id));
    }

    public UserAddress findDefaultByUserId(int userId) {
        List<UserAddress> result = JpaHelper.query(em ->
            em.createQuery(
                "SELECT a FROM UserAddress a WHERE a.userId = :uid AND a.isDefault = true",
                UserAddress.class)
              .setParameter("uid", userId)
              .setMaxResults(1)
              .getResultList()
        );
        return result.isEmpty() ? null : result.get(0);
    }

    public long countByUserId(int userId) {
        return JpaHelper.query(em ->
            em.createQuery("SELECT COUNT(a) FROM UserAddress a WHERE a.userId = :uid", Long.class)
              .setParameter("uid", userId)
=======
    public UserAddress findById(Integer id) {
        return JpaHelper.query(em -> em.find(UserAddress.class, id));
    }

    public UserAddress findDefaultByUserId(Integer userId) {
        return JpaHelper.query(em -> {
            try {
                return em.createQuery(
                    "SELECT a FROM UserAddress a WHERE a.userId = :userId AND a.isDefault = true",
                    UserAddress.class)
                  .setParameter("userId", userId)
                  .getSingleResult();
            } catch (NoResultException e) {
                return null;
            }
        });
    }

    public long countByUserId(Integer userId) {
        return JpaHelper.query(em ->
            em.createQuery(
                "SELECT COUNT(a) FROM UserAddress a WHERE a.userId = :userId", Long.class)
              .setParameter("userId", userId)
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
              .getSingleResult()
        );
    }

    public void insert(UserAddress address) {
        JpaHelper.execute(em -> em.persist(address));
    }

    public void update(UserAddress address) {
        JpaHelper.execute(em -> em.merge(address));
    }

<<<<<<< HEAD
    public void delete(int id) {
        JpaHelper.execute(em -> {
            UserAddress a = em.find(UserAddress.class, id);
            if (a != null) em.remove(a);
        });
    }

    /** Sets isDefault = false for all addresses belonging to the user. */
    public void clearDefault(int userId) {
        JpaHelper.execute(em ->
            em.createQuery("UPDATE UserAddress a SET a.isDefault = false WHERE a.userId = :uid")
              .setParameter("uid", userId)
=======
    public void delete(Integer id) {
        JpaHelper.execute(em -> {
            UserAddress address = em.find(UserAddress.class, id);
            if (address != null) em.remove(address);
        });
    }

    public void clearDefault(Integer userId) {
        JpaHelper.execute(em ->
            em.createQuery("UPDATE UserAddress a SET a.isDefault = false WHERE a.userId = :userId")
              .setParameter("userId", userId)
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
              .executeUpdate()
        );
    }
}
