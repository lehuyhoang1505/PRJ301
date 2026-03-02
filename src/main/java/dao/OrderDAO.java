package dao;

import models.Order;
import models.OrderDetail;
import util.JpaHelper;
import java.util.List;

public class OrderDAO {

    // ── Queries ──────────────────────────────────────────────────────────

    public List<Order> findAll() {
        return JpaHelper.query(em ->
            em.createQuery(
                "SELECT o FROM Order o WHERE o.status <> 'Deleted' ORDER BY o.id DESC",
                Order.class
            ).getResultList()
        );
    }

    public List<Order> findByUserId(Integer userId) {
        return JpaHelper.query(em ->
            em.createQuery(
                "SELECT o FROM Order o WHERE o.userId = :uid AND o.status <> 'Deleted' ORDER BY o.id DESC",
                Order.class
            ).setParameter("uid", userId).getResultList()
        );
    }

    public Order findById(Integer id) {
        return JpaHelper.query(em ->
            em.createQuery(
                "SELECT o FROM Order o WHERE o.id = :id AND o.status <> 'Deleted'",
                Order.class
            ).setParameter("id", id).getResultStream().findFirst().orElse(null)
        );
    }

    public List<OrderDetail> findDetailsByOrderId(Integer orderId) {
        return JpaHelper.query(em ->
            em.createQuery(
                "SELECT d FROM OrderDetail d WHERE d.orderId = :oid ORDER BY d.id",
                OrderDetail.class
            ).setParameter("oid", orderId).getResultList()
        );
    }

    // ── Mutations ─────────────────────────────────────────────────────────

    /**
     * Persists a new Order and returns its generated id.
     * After calling this, {@code order.getId()} is populated.
     */
    public Integer insert(Order order) {
        JpaHelper.execute(em -> em.persist(order));
        return order.getId();
    }

    public void insertDetail(OrderDetail detail) {
        JpaHelper.execute(em -> em.persist(detail));
    }

    public void update(Order order) {
        JpaHelper.execute(em -> em.merge(order));
    }

    /** Soft-deletes: sets status to 'Deleted'. */
    public void delete(Integer id) {
        JpaHelper.execute(em -> {
            Order o = em.find(Order.class, id);
            if (o != null) {
                o.setStatus("Deleted");
                em.merge(o);
            }
        });
    }
}
