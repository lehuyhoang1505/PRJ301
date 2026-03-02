package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.User;
import services.UserService;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

/**
 * User's own profile management at /users.
 * Each user can view, edit, and delete their own account.
 *
 * GET  (default) → view own profile
 * GET  action=edit    → show edit form
 * GET  action=delete  → delete own account, logout
 * POST action=edit    → update own profile
 */
@WebServlet(urlPatterns = {"/users"})
public class UserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteOwnAccount(request, response);
                break;
            default:
                showProfile(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            updateProfile(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/users");
        }
    }

    // ── Private helpers ─────────────────────────────────────────────────────

    private User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (User) session.getAttribute("user") : null;
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request);
        // Re-fetch from DB to get latest info
        User fresh = userService.findById(currentUser.getUserId());
        request.setAttribute("profileUser", fresh);
        request.getRequestDispatcher("/users/profile.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request);
        User fresh = userService.findById(currentUser.getUserId());
        request.setAttribute("profileUser", fresh);
        request.getRequestDispatcher("/users/edit.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request);
        String username    = request.getParameter("username");
        String password    = request.getParameter("password");
        String name        = request.getParameter("name");
        String gender      = request.getParameter("gender");
        String dobStr      = request.getParameter("dateOfBirth");
        String phone       = request.getParameter("phone");
        String email       = request.getParameter("email");

        LocalDate dateOfBirth = null;
        try {
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                dateOfBirth = LocalDate.parse(dobStr.trim());
            }
        } catch (DateTimeParseException e) {
            User fresh = userService.findById(currentUser.getUserId());
            request.setAttribute("profileUser", fresh);
            request.setAttribute("error", "Invalid date format (use YYYY-MM-DD)");
            request.getRequestDispatcher("/users/edit.jsp").forward(request, response);
            return;
        }

        try {
            userService.updateOwnProfile(currentUser.getUserId(), username, password,
                    name, gender, dateOfBirth, phone, email);
            // Refresh session with updated user
            User updated = userService.findById(currentUser.getUserId());
            request.getSession().setAttribute("user", updated);
            response.sendRedirect(request.getContextPath() + "/users?success=updated");
        } catch (IllegalArgumentException e) {
            User fresh = userService.findById(currentUser.getUserId());
            request.setAttribute("profileUser", fresh);
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/users/edit.jsp").forward(request, response);
        }
    }

    private void deleteOwnAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        userService.deleteOwnAccount(currentUser.getUserId());

        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();
        response.sendRedirect(request.getContextPath() + "/login?msg=account_deleted");
    }
}
