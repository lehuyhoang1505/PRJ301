<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Placed</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; text-align: center; }
        .box { display: inline-block; border: 1px solid #ccc; border-radius: 6px;
               padding: 40px 60px; margin-top: 60px; }
        .tick { font-size: 60px; color: #2e7d32; }
        h1   { color: #2e7d32; }
        p    { color: #555; margin-bottom: 20px; }
        .btn { display: inline-block; padding: 8px 20px; background: #1565c0;
               color: white; text-decoration: none; border-radius: 4px; margin: 4px; }
    </style>
</head>
<body>
<%
    Integer orderId    = (Integer) session.getAttribute("lastOrderId");
    String  payment    = (String)  session.getAttribute("lastPaymentMethod");
    session.removeAttribute("lastOrderId");
    session.removeAttribute("lastPaymentMethod");
%>

<div class="box">
    <div class="tick">&#10004;</div>
    <h1>Order Placed Successfully!</h1>
    <% if (orderId != null) { %>
        <p>Your order <strong>#<%= orderId %></strong> has been received.</p>
    <% } else { %>
        <p>Your order has been received.</p>
    <% } %>
    <% if (payment != null) { %>
        <p>Payment method: <strong><%= payment %></strong></p>
    <% } %>
    <p>We will process it shortly. Thank you for shopping with us!</p>
    <a href="${pageContext.request.contextPath}/orders" class="btn">My Orders</a>
    <a href="${pageContext.request.contextPath}/products" class="btn">Continue Shopping</a>
</div>

</body>
</html>
