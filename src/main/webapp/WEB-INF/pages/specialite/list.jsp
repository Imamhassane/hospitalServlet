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
    <%--Css--%>
    <style><%@ include file="/WEB-INF/css/style.css"%></style>
    <style><%@ include file="/WEB-INF/css/form.css"%></style>
    <!-- jquery -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

    <!-- select2 -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
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
    <div><h4 id="tittle" class="tittle print">Liste des specialites</h4></div>
    <div><h4 id="tittleVide" class="tittle">Aucune specialite pour ce nom!</h4></div>

    <div class="search-box">
        <input class="search-input" oninput="checkItems()" id="search-input" type="text" placeholder="Nom de la specialite..">
    </div>

    <div><a id="openModal" class="btn btn-success">Nouvelle specialite</a></div>
</div>

<div class="table-content-table">
    <table class="w-100">
        <tr class="table-thead-tr hiddenTr print" id="hiddenTr">
            <th>Libelle</th>
            <th>Service</th>

            <th class="th-actions">Actions</th>
        </tr>

        <c:forEach items="${requestScope.specialiteList}" var="specialite">
            <tr class="table-tbody-tr search-result" value="${specialite.libelle}">
                <td>${specialite.libelle}</td>
                <td>${specialite.service.libelle}</td>
                <td class="text-center">
                    <a class="edit btn btn-warning">modifier</a>
                    <a  class="delete btn btn-danger">supprimer</a>
                    <div class="remove-item" id="remove-item">
                        <div class="form-remove text-center">
                            <h4 class="mb-4">Êtes-vous sûr de vouloir supprimer</h4>
                            <div class="d-flex flex-row justify-content-around">
                                <a href="${pageContext.request.contextPath}/specialite/remove?id=${specialite.id}" class="btn btn-success">OUI</a>
                                <a class="non-button btn btn-danger">NON</a>
                            </div>
                        </div>
                    </div>
                    <div class="update" id="update">
                        <form method="post" class="formSpecialite" action="${pageContext.request.contextPath}/specialite/save">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${specialite.id}">
                            <div class="form-controle">
                                <label for="nom">Libelle</label>
                                <input type="text" name="LibelleSpecialite" class="nom w-100" value="${specialite.libelle}">
                                <small></small>
                            </div>
                            <div class="form-controle">
                                <label>Service</label>
                                <select class="service js-example-basic-single" name="service">
                                    <option value="${specialite.service.id}" selected>${specialite.service.libelle}</option>
                                    <c:forEach items="${requestScope.serviceList}" var="service">
                                        <option value="${service.id}">${service.libelle}</option>
                                    </c:forEach>
                                </select>
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
    <form method="post" id="formSpecialite" action="${pageContext.request.contextPath}/specialite/add">
        <input type="hidden" name="action" value="save">
        <input type="hidden" name="id" value="">
        <div class="form-controle">
            <label for="nom">Libelle</label>
            <input type="text" name="LibelleSpecialite" class="w-100" id="nom" value="">
            <small></small>
        </div>
        <div class="form-controle">
            <label>Service</label>
            <select class="js-example-basic-single" name="service" id="service">
                <c:forEach items="${requestScope.serviceList}" var="service">
                    <option value="${service.id}">${service.libelle}</option>
                </c:forEach>
            </select>
            <small></small>
        </div>
        <input type="submit" class="submit" value="valider">
    </form>
</div>
<%--Form end--%>




<% session.removeAttribute("errorRemove");%>
<% session.removeAttribute("successRemove");%>
<script type="text/javascript"><%@ include file="/WEB-INF/js/list.js"%></script>
<script type="text/javascript">
    // In your Javascript (external .js resource or <script> tag)
    $(document).ready(function() {
        $('.js-example-basic-single').select2();
    });
</script>
<script type="text/javascript"><%@ include file="/WEB-INF/js/validator.js"%></script>
<% session.removeAttribute("errorRemove");%>
<% session.removeAttribute("successRemove");%>
</body>
</html>
