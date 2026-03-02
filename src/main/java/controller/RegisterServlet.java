package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import services.UserService;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

@WebServlet(urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username        = request.getParameter("username");
        String password        = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String name            = request.getParameter("name");
        String gender          = request.getParameter("gender");
        String dobStr          = request.getParameter("dateOfBirth");
        String phone           = request.getParameter("phone");
        String email           = request.getParameter("email");

        if (password != null && !password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        LocalDate dateOfBirth = null;
        try {
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                dateOfBirth = LocalDate.parse(dobStr);
            }
        } catch (DateTimeParseException e) {
            request.setAttribute("error", "Invalid date of birth format.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            userService.register(username, password, name, gender, dateOfBirth, phone, email);
            request.getSession().setAttribute("successMessage", "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
