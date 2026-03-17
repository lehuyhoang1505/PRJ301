<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<<<<<<< HEAD
<%@ page import="models.UserAddress, java.util.List" %>
<%!private static String esc(String s) {
    if (s == null) return "";
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
            .replace("\"", "&quot;").replace("'", "&#x27;");
}%>
=======
<%@ page import="models.User, models.UserAddress, java.util.List" %>
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<<<<<<< HEAD
    <title>${i18n.get('address.title')}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { margin-bottom: 6px; }
        nav { margin-bottom: 20px; }
        nav a { margin-right: 10px; }
        .msg-success { color: green; margin-bottom: 14px; padding: 8px 12px; background: #e8f5e9; border-left: 4px solid #4caf50; }
        .msg-error   { color: red;   margin-bottom: 14px; padding: 8px 12px; background: #ffebee; border-left: 4px solid #f44336; }
        .addr-list { display: flex; flex-direction: column; gap: 14px; max-width: 640px; }
        .addr-card {
            border: 1px solid #ccc; border-radius: 6px; padding: 14px 16px;
            position: relative; background: #fafafa;
        }
        .addr-card.default-card { border-color: #2196f3; background: #e3f2fd; }
        .badge-default {
            display: inline-block; font-size: 11px; font-weight: bold;
            background: #2196f3; color: white; padding: 2px 8px;
            border-radius: 10px; margin-left: 8px; vertical-align: middle;
        }
        .addr-name { font-weight: bold; font-size: 15px; margin-bottom: 4px; }
        .addr-detail { color: #555; font-size: 14px; margin-bottom: 2px; }
        .addr-actions { margin-top: 10px; display: flex; gap: 10px; flex-wrap: wrap; }
        .btn { display: inline-block; padding: 5px 14px; border-radius: 3px; text-decoration: none; font-size: 13px; border: 1px solid #999; cursor: pointer; }
        .btn-edit   { background: #2196f3; color: white; border-color: #2196f3; }
        .btn-del    { background: #f44336; color: white; border-color: #f44336; }
        .btn-def    { background: #ff9800; color: white; border-color: #ff9800; }
        .btn-add    { background: #4caf50; color: white; border-color: #4caf50; font-size: 14px; padding: 7px 18px; }
        .empty-state { color: #777; font-style: italic; margin-bottom: 16px; }
        .checkout-notice {
            background: #fff3e0; border-left: 4px solid #ff9800; padding: 10px 14px;
            margin-bottom: 16px; font-size: 14px;
        }
=======
    <title>My Addresses</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { margin-bottom: 10px; }
        nav { margin-bottom: 20px; }
        nav a { margin-right: 10px; }
        .btn { display: inline-block; padding: 8px 16px; text-decoration: none; border: 1px solid #999; border-radius: 3px; cursor: pointer; font-size: 14px; }
        .btn-add { background: #2e7d32; color: white; border-color: #2e7d32; }
        .btn-edit { background: #1976d2; color: white; border-color: #1976d2; }
        .btn-delete { background: #d32f2f; color: white; border-color: #d32f2f; }
        .btn-default { background: #666; color: white; border-color: #666; }
        .address-list { margin-top: 20px; }
        .address-card { border: 1px solid #ddd; border-radius: 4px; padding: 15px; margin-bottom: 15px; background: #f9f9f9; }
        .address-card.default { border-color: #2e7d32; background: #e8f5e9; }
        .badge { display: inline-block; padding: 3px 8px; font-size: 12px; border-radius: 3px; }
        .badge-default { background: #2e7d32; color: white; }
        .success { background: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        .error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        .info { background: #d1ecf1; color: #0c5460; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        .actions { margin-top: 10px; }
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
    </style>
</head>
<body>
<%
<<<<<<< HEAD
    @SuppressWarnings("unchecked")
    List<UserAddress> addresses = (List<UserAddress>) request.getAttribute("addresses");
    String lang     = (String) request.getAttribute("lang");
    String success  = request.getParameter("success");
    String errorMsg = request.getParameter("error");
    boolean noAddress = "1".equals(request.getParameter("noAddress"));
    if (lang == null) lang = "vi";
%>

<h1>${i18n.get('address.title')}</h1>
<nav>
    <%@ include file="/WEB-INF/includes/language-switcher.jsp" %>
    <a href="${pageContext.request.contextPath}/users">${i18n.get('nav.myProfile')}</a> |
    <a href="${pageContext.request.contextPath}/orders">${i18n.get('nav.myOrders')}</a> |
    <a href="${pageContext.request.contextPath}/products">${i18n.get('nav.products')}</a> |
    <a href="${pageContext.request.contextPath}/logout">${i18n.get('nav.logout')}</a>
</nav>

<% if (noAddress) { %>
<div class="checkout-notice">${i18n.get('address.noAddressForCheckout')}</div>
<% } %>

<% if ("added".equals(success))      { %><div class="msg-success">${i18n.get('address.added')}</div><% } %>
<% if ("updated".equals(success))    { %><div class="msg-success">${i18n.get('address.updated')}</div><% } %>
<% if ("deleted".equals(success))    { %><div class="msg-success">${i18n.get('address.deleted')}</div><% } %>
<% if ("defaultSet".equals(success)) { %><div class="msg-success">${i18n.get('address.defaultSet')}</div><% } %>
<% if ("notfound".equals(errorMsg))  { %><div class="msg-error">${i18n.get('address.notFound')}</div><% } %>

<a href="${pageContext.request.contextPath}/users/addresses?action=add" class="btn btn-add">+ ${i18n.get('address.addNew')}</a>
<br><br>

<div class="addr-list">
<% if (addresses == null || addresses.isEmpty()) { %>
    <p class="empty-state">${i18n.get('address.noAddresses')}</p>
<% } else {
    for (UserAddress addr : addresses) {
        String provinceName = addr.getProvince() != null ? addr.getProvince().getLocalizedName(lang) : "";
%>
    <div class="addr-card <%= addr.isDefault() ? "default-card" : "" %>">
        <div class="addr-name">
            <%= esc(addr.getFullName()) %>
            <% if (addr.isDefault()) { %>
            <span class="badge-default">${i18n.get('address.default')}</span>
            <% } %>
        </div>
        <div class="addr-detail">📞 <%= esc(addr.getPhone()) %></div>
        <div class="addr-detail">
            📍 <%= esc(addr.getAddressDetail()) %>, <%= esc(addr.getWard()) %>, <%= esc(addr.getDistrict()) %>, <%= esc(provinceName) %>
        </div>
        <div class="addr-actions">
            <a href="${pageContext.request.contextPath}/users/addresses?action=edit&id=<%= addr.getId() %>" class="btn btn-edit">${i18n.get('address.edit')}</a>
            <% if (!addr.isDefault()) { %>
            <a href="${pageContext.request.contextPath}/users/addresses?action=setDefault&id=<%= addr.getId() %>" class="btn btn-def">${i18n.get('address.setDefault')}</a>
            <a href="${pageContext.request.contextPath}/users/addresses?action=delete&id=<%= addr.getId() %>"
               class="btn btn-del"
               data-confirm="${i18n.get('address.deleteConfirm')}"
               onclick="return confirm(this.dataset.confirm)">${i18n.get('address.delete')}</a>
            <% } %>
        </div>
    </div>
<% } } %>
=======
    User currentUser = (User) session.getAttribute("user");
    @SuppressWarnings("unchecked")
    List<UserAddress> addresses = (List<UserAddress>) request.getAttribute("addresses");
    String success = request.getParameter("success");
    String error = request.getParameter("error");
    Boolean fromCheckout = (Boolean) request.getAttribute("fromCheckout");
%>

<h1>My Shipping Addresses</h1>
<nav>
    <a href="${pageContext.request.contextPath}/">Home</a> |
    <a href="${pageContext.request.contextPath}/users/profile">Profile</a> |
    <a href="${pageContext.request.contextPath}/orders">Orders</a> |
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
</nav>

<% if (fromCheckout != null && fromCheckout) { %>
    <div class="info">
        <strong>Note:</strong> You need at least one shipping address to checkout. Please add an address below.
    </div>
<% } %>

<% if (success != null) { %>
    <div class="success">
        <% if ("added".equals(success)) { %>
            Address added successfully!
        <% } else if ("updated".equals(success)) { %>
            Address updated successfully!
        <% } else if ("deleted".equals(success)) { %>
            Address deleted successfully!
        <% } else if ("defaultSet".equals(success)) { %>
            Default address updated!
        <% } %>
    </div>
<% } %>

<% if (error != null) { %>
    <div class="error">
        <% if ("notfound".equals(error)) { %>
            Address not found or unauthorized!
        <% } else { %>
            An error occurred!
        <% } %>
    </div>
<% } %>

<a href="${pageContext.request.contextPath}/users/addresses?action=add" class="btn btn-add">+ Add New Address</a>

<div class="address-list">
    <% if (addresses == null || addresses.isEmpty()) { %>
        <p>No addresses found. Please add your first shipping address.</p>
    <% } else { %>
        <% for (UserAddress addr : addresses) { %>
            <div class="address-card <%= addr.isDefault() ? "default" : "" %>">
                <strong><%= addr.getFullName() %></strong>
                <% if (addr.isDefault()) { %>
                    <span class="badge badge-default">DEFAULT</span>
                <% } %>
                <br>
                Phone: <%= addr.getPhone() %><br>
                Address: <%= addr.getFormattedAddress() %>

                <div class="actions">
                    <a href="${pageContext.request.contextPath}/users/addresses?action=edit&id=<%= addr.getId() %>" class="btn btn-edit">Edit</a>

                    <% if (!addr.isDefault()) { %>
                        <a href="${pageContext.request.contextPath}/users/addresses?action=delete&id=<%= addr.getId() %>"
                           onclick="return confirm('Are you sure you want to delete this address?');"
                           class="btn btn-delete">Delete</a>

                        <a href="${pageContext.request.contextPath}/users/addresses?action=setDefault&id=<%= addr.getId() %>"
                           class="btn btn-default">Set as Default</a>
                    <% } %>
                </div>
            </div>
        <% } %>
    <% } %>
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
</div>

</body>
</html>
