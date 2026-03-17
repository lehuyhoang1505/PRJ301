<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.UserAddress, models.Province, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<<<<<<< HEAD
    <title>${i18n.get('address.formTitle')}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { margin-bottom: 20px; }
        .form-group { margin-bottom: 12px; }
        label { display: block; margin-bottom: 4px; font-weight: bold; }
        input[type="text"], select { padding: 6px 8px; width: 300px; box-sizing: border-box; }
        .checkbox-row { display: flex; align-items: center; gap: 8px; }
        .checkbox-row input { width: auto; }
        .msg-error { color: red; margin-bottom: 12px; padding: 8px 12px; background: #ffebee; border-left: 4px solid #f44336; }
        .actions { margin-top: 16px; }
        .btn { display: inline-block; padding: 7px 18px; border-radius: 3px; cursor: pointer; font-size: 14px; border: 1px solid #999; text-decoration: none; }
        .btn-save   { background: #2e7d32; color: white; border-color: #2e7d32; }
        .btn-cancel { background: #555; color: white; border-color: #555; }
        .note { color: #666; font-size: 12px; margin-top: 2px; }
=======
    <title><%= request.getAttribute("address") != null ? "Edit" : "Add" %> Address</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { margin-bottom: 10px; }
        .container { max-width: 600px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="tel"], select, textarea { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .btn { display: inline-block; padding: 8px 16px; text-decoration: none; border: 1px solid #999; border-radius: 3px; cursor: pointer; font-size: 14px; }
        .btn-save { background: #2e7d32; color: white; border: none; }
        .btn-cancel { background: #666; color: white; margin-left: 10px; }
        .error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        .checkbox-group { display: flex; align-items: center; }
        .checkbox-group input { width: auto; margin-right: 8px; }
>>>>>>> 2629b53241cb20e43abad513f899512798e38315
    </style>
</head>
<body>
<%
<<<<<<< HEAD
    @SuppressWarnings("unchecked")
    List<Province> provinces = (List<Province>) request.getAttribute("provinces");
    UserAddress address = (UserAddress) request.getAttribute("address");
    String lang  = (String) request.getAttribute("lang");
    if (lang == null) lang = "vi";
    boolean isEdit = (address != null && address.getId() != null);
    String formAction = isEdit ? "edit" : "add";
%>

<h1><%= isEdit ? "${i18n.get('address.editTitle')}" : "${i18n.get('address.addTitle')}" %></h1>
<nav>
    <%@ include file="/WEB-INF/includes/language-switcher.jsp" %>
    <a href="${pageContext.request.contextPath}/users/addresses">← ${i18n.get('address.backToList')}</a>
</nav>
<br>

<% if (request.getAttribute("error") != null) { %>
<div class="msg-error"><%= request.getAttribute("error") %></div>
<% } %>

<form method="post" action="${pageContext.request.contextPath}/users/addresses">
    <input type="hidden" name="action" value="<%= formAction %>">
    <% if (isEdit) { %><input type="hidden" name="id" value="<%= address.getId() %>"><% } %>

    <div class="form-group">
        <label for="fullName">${i18n.get('address.fullName')} *</label>
        <input type="text" id="fullName" name="fullName" required maxlength="100"
               value="<%= address != null && address.getFullName() != null ? address.getFullName() : "" %>">
    </div>

    <div class="form-group">
        <label for="phone">${i18n.get('address.phone')} *</label>
        <input type="text" id="phone" name="phone" required maxlength="15"
               placeholder="0xxxxxxxxx"
               value="<%= address != null && address.getPhone() != null ? address.getPhone() : "" %>">
        <div class="note">${i18n.get('address.phoneNote')}</div>
    </div>

    <div class="form-group">
        <label for="provinceId">${i18n.get('address.province')} *</label>
        <select id="provinceId" name="provinceId" required>
            <option value="">${i18n.get('address.selectProvince')}</option>
            <% if (provinces != null) {
                for (Province p : provinces) {
                    boolean selected = address != null && p.getId().equals(address.getProvinceId());
            %>
            <option value="<%= p.getId() %>" <%= selected ? "selected" : "" %>>
                <%= p.getLocalizedName(lang) %>
            </option>
            <% } } %>
        </select>
    </div>

    <div class="form-group">
        <label for="district">${i18n.get('address.district')} *</label>
        <input type="text" id="district" name="district" required maxlength="100"
               value="<%= address != null && address.getDistrict() != null ? address.getDistrict() : "" %>">
    </div>

    <div class="form-group">
        <label for="ward">${i18n.get('address.ward')} *</label>
        <input type="text" id="ward" name="ward" required maxlength="100"
               value="<%= address != null && address.getWard() != null ? address.getWard() : "" %>">
    </div>

    <div class="form-group">
        <label for="addressDetail">${i18n.get('address.detail')} *</label>
        <input type="text" id="addressDetail" name="addressDetail" required maxlength="255"
               placeholder="${i18n.get('address.detailPlaceholder')}"
               value="<%= address != null && address.getAddressDetail() != null ? address.getAddressDetail() : "" %>">
    </div>

    <div class="form-group">
        <div class="checkbox-row">
            <input type="checkbox" id="isDefault" name="isDefault"
                   <%= (address != null && address.isDefault()) ? "checked" : "" %>>
            <label for="isDefault" style="font-weight: normal;">${i18n.get('address.isDefault')}</label>
        </div>
    </div>

    <div class="actions">
        <button type="submit" class="btn btn-save">${i18n.get('address.save')}</button>
        <a href="${pageContext.request.contextPath}/users/addresses" class="btn btn-cancel">${i18n.get('action.cancel')}</a>
    </div>
</form>
=======
    UserAddress address = (UserAddress) request.getAttribute("address");
    @SuppressWarnings("unchecked")
    List<Province> provinces = (List<Province>) request.getAttribute("provinces");
    String error = (String) request.getAttribute("error");
    boolean isEdit = (address != null && address.getId() != null);
%>

<div class="container">
    <h1><%= isEdit ? "Edit" : "Add New" %> Address</h1>

    <% if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/users/addresses" method="post">
        <% if (isEdit) { %>
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="<%= address.getId() %>">
        <% } %>

        <div class="form-group">
            <label for="fullName">Full Name:</label>
            <input type="text" id="fullName" name="fullName"
                   value="<%= address != null ? address.getFullName() : "" %>" required>
        </div>

        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="tel" id="phone" name="phone"
                   value="<%= address != null ? address.getPhone() : "" %>"
                   pattern="^0\d{9}$" title="Phone must be 10 digits starting with 0" required>
        </div>

        <div class="form-group">
            <label for="provinceId">Province/City:</label>
            <select id="provinceId" name="provinceId" required>
                <option value="">-- Select Province --</option>
                <% if (provinces != null) {
                    for (Province prov : provinces) { %>
                        <option value="<%= prov.getId() %>"
                            <%= address != null && address.getProvinceId() != null && address.getProvinceId().equals(prov.getId()) ? "selected" : "" %>>
                            <%= prov.getNameVi() %>
                        </option>
                    <% }
                } %>
            </select>
        </div>

        <div class="form-group">
            <label for="district">District:</label>
            <input type="text" id="district" name="district"
                   value="<%= address != null ? address.getDistrict() : "" %>" required>
        </div>

        <div class="form-group">
            <label for="ward">Ward/Commune:</label>
            <input type="text" id="ward" name="ward"
                   value="<%= address != null ? address.getWard() : "" %>" required>
        </div>

        <div class="form-group">
            <label for="addressDetail">Address Detail (Street, House Number):</label>
            <textarea id="addressDetail" name="addressDetail" rows="2" required><%= address != null ? address.getAddressDetail() : "" %></textarea>
        </div>

        <div class="form-group checkbox-group">
            <input type="checkbox" id="isDefault" name="isDefault"
                <%= address != null && address.isDefault() ? "checked" : "" %>>
            <label for="isDefault" style="margin-bottom: 0;">Set as default address</label>
        </div>

        <button type="submit" class="btn btn-save">Save Address</button>
        <a href="${pageContext.request.contextPath}/users/addresses" class="btn btn-cancel">Cancel</a>
    </form>
</div>

>>>>>>> 2629b53241cb20e43abad513f899512798e38315
</body>
</html>
