package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.User;
import services.EmailService;
import services.UserService;
import java.io.IOException;

/**
<<<<<<< HEAD
 * Handles password reset request (forgot password). GET: Show the forgot
 * password form POST: Process email and send reset link
=======
 * Handles password reset request (forgot password).
 * GET: Show the forgot password form
 * POST: Process email and send reset link
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
 */
@WebServlet(urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        try {
            User user = userService.initiatePasswordReset(email.trim());

<<<<<<< HEAD
=======
            if (user == null) {
                // Don't reveal whether email exists or not (security best practice)
                request.setAttribute("success", "If an account with that email exists, a password reset link has been sent.");
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }

>>>>>>> 2629b53241cb20e43abad513f899512798e38315
            // Build reset link
            String contextPath = request.getContextPath();
            String baseUrl = request.getScheme() + "://" + request.getServerName();
            if (request.getServerPort() != 80 && request.getServerPort() != 443) {
                baseUrl += ":" + request.getServerPort();
            }
            String resetLink = baseUrl + contextPath + "/reset-password?token=" + user.getResetToken();

<<<<<<< HEAD
            // Send reset email in user's preferred language
            String language = user.getPreferredLanguage() != null ? user.getPreferredLanguage() : "en";
            boolean sent = EmailService.sendPasswordResetEmail(
                    user.getEmail(),
                    user.getName(),
                    resetLink,
                    language
=======
            // Send reset email
            boolean sent = EmailService.sendPasswordResetEmail(
                    user.getEmail(),
                    user.getName(),
                    resetLink
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
            );

            if (sent) {
                request.setAttribute("success", "Password reset link has been sent to your email. Please check your inbox.");
            } else {
                request.setAttribute("error", "Failed to send reset email. Please try again later.");
            }

<<<<<<< HEAD
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred. Please try again.");
            // Log error for debugging
=======
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred. Please try again.");
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
            request.getServletContext().log("Error in forgot password", e);
        }

        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }
}
