<%--
  Created by IntelliJ IDEA.
  User: Bazzman
  Date: 13/02/2023
  Time: 18:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>liste des medcin</title>
    <style><%@ include file="/WEB-INF/css/style.css"%>#error{display: block}#success{display: block}</style>
    <style><%@ include file="/WEB-INF/css/form.css"%></style>
    <script src="https://kit.fontawesome.com/d97b87339f.js" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="/WEB-INF/pages/menu.jsp"%>
<% if (session.getAttribute("errorRemove") != null){%>
    <div class="alert alert-danger text-center" id="error" role="alert">
        ${sessionScope.errorRemove}
    </div>
<%} %>
<% if (session.getAttribute("successRemove") != null){%>
    <div class="alert alert-success text-center" role="alert" id="success">
            ${sessionScope.successRemove}
    </div>
<%}%>

<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
<div class="mx-5 mt-5 pt-3 border-top d-flex flex-row justify-content-between align-items-center">
    <div><h4 id="tittle" class="tittle print"> Liste des services</h4></div>
    <div><h4 id="tittleVide" class="tittle">Aucun Service pour ce nom!</h4></div>

    <div class="search-box">
        <input class="search-input" oninput="checkItems()" id="search-input" type="text" placeholder="Nom du service..">
    </div>

    <div><a id="openModal" class="btn btn-success">Nouveau Service</a></div>
</div>

<div class="table-content-table">
    <table class="w-100">

        <tr class="table-thead-tr hiddenTr print" id="hiddenTr">
            <th>Libelle</th>
            <th class="th-actions">Actions</th>
        </tr>

        <c:forEach items="${requestScope.serviceList}" var="service">
            <tr class="table-tbody-tr search-result" value="${service.libelle}">
                <td>${service.libelle}</td>
                <td class="text-center">
                    <a  class="edit btn btn-warning">modifier</a>
                    <a  class="delete btn btn-danger">supprimer</a>
                    <div class="remove-item" id="remove-item">
                        <div class="form-remove text-center">
                            <h4 class="mb-4">Êtes-vous sûr de vouloir supprimer</h4>
                            <div class="d-flex flex-row justify-content-around">
                                <a href="${pageContext.request.contextPath}/service/remove?id=${service.id}" class="btn btn-success">OUI</a>
                                <a class="non-button btn btn-danger">NON</a>
                            </div>
                        </div>
                    </div>
                    <div class="update" id="update">
                        <form class="formService" method="post" action="${pageContext.request.contextPath}/service/save">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${service.id}">
                            <div class="form-controle">
                                <label for="nom">Libelle</label>
                                <input type="text" name="libelleService" class="nom w-100" value="${service.libelle}">
                                <small></small>
                            </div>
                            <input type="submit" class="submit" value="valider">
                        </form>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<%--Form--%>
    <div class="info-client" id="info-client">
    <form id="formService" method="post" action="${pageContext.request.contextPath}/service/add">
        <input type="hidden" name="action" value="save">
        <input type="hidden" name="id" value="">
        <div class="form-controle">
            <label for="nom">Libelle</label>
            <input type="text" name="libelleService" class="w-100" id="nom" value="">
            <small></small>
        </div>
        <input type="submit" class="submit" value="valider">
    </form>
</div>
<%--Form end--%>





<% session.removeAttribute("errorRemove");%>
<% session.removeAttribute("successRemove");%>
<script type="text/javascript"><%@ include file="/WEB-INF/js/list.js"%></script>
<script type="text/javascript"><%@ include file="/WEB-INF/js/validator.js"%></script>
</body>
</html>
