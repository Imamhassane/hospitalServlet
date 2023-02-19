<%@ page import="model.Specialite" %><%--
  Created by IntelliJ IDEA.
  User: Bazzman
  Date: 14/02/2023
  Time: 02:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<% String form = (String) request.getAttribute("form");  %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>formulaire</title>
    <style><%@ include file="/WEB-INF/css/form.css"%></style>
    <!-- jquery -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

    <!-- select2 -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body>
<%@ include file="/WEB-INF/pages/menu.jsp"%>

<div class="info-client" id="info-client">

        <% if (form.equals("medcin")) { %>
            <form id="form" method="post" action="">
                <input type="hidden" name="action" value="${requestScope.action}">
                <input type="hidden" name="id" value="${sessionScope.medcin.id}">
                <c:forEach items="${requestScope.emails}" var="email">
                <input type="hidden" class="allEmails" value="${email}">
                </c:forEach>
                <div class="d-flex">
                    <div class="form-controle">
                        <label for="prenom">Prenom</label>
                        <input type="text" name="prenom" id="prenom" value="${sessionScope.medcin.prenom}">
                        <small></small>
                    </div>
                    <div class="form-controle">
                        <label for="nom">Nom</label>
                        <input type="text" name="nom" id="nom" value="${sessionScope.medcin.nom}">
                        <small></small>
                    </div>
                </div>
                <div class="d-flex">
                    <div class="form-controle">
                        <label for="email">Email</label>
                        <input type="text" name="email" id="email" value="${sessionScope.medcin.email}">
                        <small></small>
                    </div>
                    <div class="form-controle">
                        <label for="password">Mot de passe</label>
                        <input type="text" name="password" id="password" value="${sessionScope.medcin.password}">
                        <small></small>
                    </div>
                </div>
                <div class="d-flex">
                    <div class="form-controle">
                        <label for="salaire">Salaire</label>
                        <input type="text" name="salaire" id="salaire" value="${sessionScope.medcin.salaire}">
                        <small></small>
                    </div>

                    <div class="form-controle">
                        <label for="adresse">Adresse</label>
                        <input type="text" name="adresse" id="adresse" value="${sessionScope.medcin.adresse}">
                        <small></small>
                    </div>
                </div>

                <div class="d-flex">
                    <div class="form-controle">
                        <label for="naissance">Date de naissance</label>
                        <input type="date" name="naissance" id="naissance" value="${sessionScope.medcin.datenaissance}">
                        <small></small>
                    </div>

                    <div class="form-controle">
                        <label for="embauche">Date d'embauche</label>
                        <input type="date" name="embauche" id="embauche" value="${sessionScope.medcin.dateembauche}">
                        <small></small>
                    </div>
                </div>
                <div class="d-flex">
                    <div class="form-controle">
                        <label>Specialite</label>
                        <select class="js-example-basic-multiple" name="specialite[]" id="specialite" multiple="multiple">
                                <c:forEach items="${sessionScope.medcin.specialites}" var="specialite">
                                    <option value="${specialite.id}" selected>${specialite.libelle}</option>
                                </c:forEach>
                                <c:forEach items="${requestScope.specialiteList}" var="specialite">
                                    <option value="${specialite.id}">${specialite.libelle}</option>
                                </c:forEach>
                        </select>
                        <small></small>
                    </div>
                    <div class="form-controle">
                        <label>Service</label>
                        <select class="js-example-basic-single" name="service" id="service">
                            <option value="${sessionScope.medcin.service.id}"selected>${sessionScope.medcin.service.libelle}</option>
                            <c:forEach items="${requestScope.serviceList}" var="service">
                                <option value="${service.id}">${service.libelle}</option>
                            </c:forEach>
                        </select>
                        <small></small>
                    </div>
                </div>


                <input type="submit" class="submit" value="valider">

            </form>
        <%}%>

        <% if (form.equals("service")) { %>
            <form method="post">
                <input type="hidden" name="action" value="${requestScope.action}">
                <input type="hidden" name="id" value="${sessionScope.service.id}">
                <div class="form-controle">
                    <label for="libelleService">Libelle</label>
                    <input type="text" name="libelleService" class="w-100" id="libelleService" value="${sessionScope.service.libelle}">
                    <small></small>
                </div>
                <input type="submit" class="submit" value="valider">
            </form>
        <%}%>

        <% if (form.equals("specialite")) { %>
            <form method="post">
                <input type="hidden" name="action" value="${requestScope.action}">
                <input type="hidden" name="id" value="${sessionScope.specialite.id}">
                <div class="form-controle">
                    <label for="prenom">Libelle</label>
                    <input type="text" name="LibelleSpecialite" class="w-100" id="LibelleSpecialite" value="${sessionScope.specialite.libelle}">
                    <small></small>
                </div>
                <div class="form-controle">
                    <label>Service</label>
                    <select class="js-example-basic-single" name="service">
                        <option value="${sessionScope.specialite.service.id}">${sessionScope.specialite.service.libelle}</option>
                        <c:forEach items="${requestScope.serviceList}" var="service">
                            <option value="${service.id}">${service.libelle}</option>
                        </c:forEach>
                    </select>
                    <small></small>
                </div>
                <input type="submit" class="submit" value="valider">
            </form>
        <%}%>


</div>
<script type="text/javascript">
    // In your Javascript (external .js resource or <script> tag)
    $(document).ready(function() {
        $('.js-example-basic-single').select2();
        $('.js-example-basic-multiple').select2();
    });
</script>
<script type="text/javascript"><%@ include file="/WEB-INF/js/validator.js"%></script>
</body>
</html>
