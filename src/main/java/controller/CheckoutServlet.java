package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Cart;
import models.CartItem;
import models.Order;
import models.OrderDetail;
import models.User;
import services.OrderService;
import services.OrderServiceImpl;
import java.io.IOException;

/**
 * Checkout flow at /checkout.
 *
 * GET  → show order summary + payment form (requires non-empty cart and logged-in user)
 * POST → place the order, clear cart, redirect to success page
 */
@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private final OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Cart cart = (session != null) ? (Cart) session.getAttribute("cart") : null;

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Cart cart = (session != null) ? (Cart) session.getAttribute("cart") : null;

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null) paymentMethod = "COD";

        // Calculate total
        double total = cart.getTotalCost();

        // Create order
        Order order = new Order(user.getUserId(), total, "Pending");
        Integer orderId = orderService.createOrder(order);

        // Add order details
        for (CartItem item : cart) {
            OrderDetail detail = new OrderDetail(
                    orderId,
                    item.getProduct().getId(),
                    item.getProduct().getName(),
                    item.getQuantity(),
                    item.getProduct().getPrice()
            );
            orderService.addOrderDetail(detail);
        }

        // Store order id in session for the success page
        session.setAttribute("lastOrderId", orderId);
        session.setAttribute("lastPaymentMethod", paymentMethod);

        // Clear cart
        session.removeAttribute("cart");

        response.sendRedirect(request.getContextPath() + "/cart/success.jsp");
    }
}
