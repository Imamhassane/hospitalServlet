<%--
  Created by IntelliJ IDEA.
  User: Bazzman
  Date: 13/02/2023
  Time: 18:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String form = (String) request.getAttribute("form");
    long count = (long) request.getAttribute("count");
%>

<html>
<head>
    <title>liste des medcin</title>
    <style><%@ include file="/WEB-INF/css/style.css"%><%@ include file="/WEB-INF/css/form.css"%></style>
    <!-- jquery -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

    <!-- select2 -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body>
<%@ include file="/WEB-INF/pages/menu.jsp"%>
<% if (session.getAttribute("successRemoveMedcin") != null){%>
    <div class="alert alert-success text-center" role="alert" id="success">
        ${sessionScope.successRemoveMedcin}
    </div>
<%}%>
<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
<div class="mx-5 mt-5 pt-3 border-top d-flex flex-row justify-content-between align-items-center">
    <div><h4 id="tittle" class="tittle print">${requestScope.tittle}</h4></div>
    <div><h4 id="tittleVide" class="tittle">Aucun medcin correspondant!</h4></div>

    <div class="search-box">
        <input class="search-input" oninput="checkItems()" id="search-input" type="text" placeholder="Matricule../Prenom../Nom..">
    </div>

    <div><a id="openModal" class="btn btn-success">Nouveau medcin</a></div>
</div>
<%-- Table --%>
    <% if(count > 0){ %>
    <div class="table-content-table">
        <table class="w-100">

            <tr class="table-thead-tr hiddenTr print" id="hiddenTr">
                <th>Nom Complet</th>
                <th>Matricule</th>
                <th>Date naissance</th>
                <th>Date d'embauche</th>
                <th>salaire</th>
                <th>Specialite</th>
                <th>Service</th>

                <th class="th-actions">Actions</th>
            </tr>

            <c:forEach items="${requestScope.medcinList}" var="medcin">

                <tr class="table-tbody-tr search-result"
                    value="${medcin.matricule}"
                    nom="${medcin.nom}"
                    prenom="${medcin.prenom}"
                >
                    <td>${medcin.prenom} ${medcin.nom}</td>
                    <td>${medcin.matricule}</td>
                    <td><fmt:formatDate value="${medcin.datenaissance}" pattern="dd-MM-YYYY" /></td>
                    <td><fmt:formatDate value="${medcin.dateembauche}" pattern="dd-MM-YYYY" /></td>
                    <td>${medcin.salaire}</td>
                    <td>
                        <c:forEach items="${medcin.specialites}" var="specialite">
                            ${specialite.libelle}
                        </c:forEach>
                    </td>
                    <td>${medcin.service.libelle}</td>
                    <td class="text-center">
                        <a class="edit btn btn-warning">modifier</a>
                        <a  class="delete btn btn-danger">supprimer</a>
                        <div class="remove-item" id="remove-item">
                            <div class="form-remove text-center">
                                <h4 class="mb-4">Êtes-vous sûr de vouloir supprimer</h4>
                                <div class="d-flex flex-row justify-content-around">
                                    <a href="${pageContext.request.contextPath}/medcin/remove?id=${medcin.id}" class="btn btn-success">OUI</a>
                                    <a class="non-button btn btn-danger">NON</a>
                                </div>
                            </div>
                        </div>
                        <div class="update" id="update">
                            <form class="formMedcin" method="post" action="${pageContext.request.contextPath}/medcin/save">
                                <input type="hidden" name="action" id="action" value="update">
                                <input type="hidden" name="id" value="${medcin.id}">

                                <c:forEach items="${requestScope.emails}" var="email">
                                    <input type="hidden" class="allEmails" value="${email}">
                                </c:forEach>
                                <div class="d-flex">
                                    <div class="form-controle">
                                        <label for="prenom">Prenom</label>
                                        <input type="text" name="prenom" class="prenom" value="${medcin.prenom}">
                                        <small></small>
                                    </div>
                                    <div class="form-controle">
                                        <label for="nom">Nom</label>
                                        <input type="text" name="nom" class="nom" value="${medcin.nom}">
                                        <small></small>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <div class="form-controle">
                                        <label for="email">Email</label>
                                        <input type="text" name="email" class="email" value="${medcin.email}">
                                        <small></small>
                                    </div>
                                    <div class="form-controle">
                                        <label for="password">Mot de passe</label>
                                        <input type="password" name="password" class="password" value="${medcin.password}">
                                        <small></small>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <div class="form-controle">
                                        <label for="salaire">Salaire</label>
                                        <input type="text" name="salaire" class="salaire" value="${medcin.salaire}">
                                        <small></small>
                                    </div>

                                    <div class="form-controle">
                                        <label for="adresse">Adresse</label>
                                        <input type="text" name="adresse" class="adresse" value="${medcin.adresse}">
                                        <small></small>
                                    </div>
                                </div>

                                <div class="d-flex">
                                    <div class="form-controle">
                                        <label for="naissance">Date de naissance</label>
                                        <input type="date" name="naissance" class="naissance" value="${medcin.datenaissance}">
                                        <small></small>
                                    </div>

                                    <div class="form-controle">
                                        <label for="embauche">Date d'embauche</label>
                                        <input type="date" name="embauche" class="embauche" value="${medcin.dateembauche}">
                                        <small></small>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <div class="form-controle">
                                        <label>Specialite</label>
                                        <select class="specialite js-example-basic-multiple" name="specialite[]" multiple="multiple">
                                            <c:forEach items="${medcin.specialites}" var="specialite">
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
                                        <select class="service js-example-basic-single" name="service">
                                            <option value="${medcin.service.id}"selected>${medcin.service.libelle}</option>
                                            <c:forEach items="${requestScope.serviceList}" var="service">
                                                <option value="${service.id}">${service.libelle}</option>
                                            </c:forEach>
                                        </select>
                                        <small></small>
                                    </div>
                                </div>
                                <input type="submit" class="submit" value="valider">
                            </form>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <%}%>
<%--Table end--%>

<%--Form--%>
    <div class="info-client" id="info-client">
        <form id="formMedcin" method="post" action="${pageContext.request.contextPath}/medcin/add">
            <input type="hidden" name="action" id="action" value="save">
            <input type="hidden" name="id" value="">

            <c:forEach items="${requestScope.emails}" var="email">
                <input type="hidden" class="allEmails" value="${email}">
            </c:forEach>
            <div class="d-flex">
                <div class="form-controle">
                    <label for="prenom">Prenom</label>
                    <input type="text" name="prenom" id="prenom">
                    <small></small>
                </div>
                <div class="form-controle">
                    <label for="nom">Nom</label>
                    <input type="text" name="nom" id="nom">
                    <small></small>
                </div>
            </div>
            <div class="d-flex">
                <div class="form-controle">
                    <label for="email">Email</label>
                    <input type="text" name="email" id="email">
                    <small></small>
                </div>
                <div class="form-controle">
                    <label for="password">Mot de passe</label>
                    <input type="password" name="password" id="password">
                    <small></small>
                </div>
            </div>
            <div class="d-flex">
                <div class="form-controle">
                    <label for="salaire">Salaire</label>
                    <input type="text" name="salaire" id="salaire">
                    <small></small>
                </div>

                <div class="form-controle">
                    <label for="adresse">Adresse</label>
                    <input type="text" name="adresse" id="adresse">
                    <small></small>
                </div>
            </div>

            <div class="d-flex">
                <div class="form-controle">
                    <label for="naissance">Date de naissance</label>
                    <input type="date" name="naissance" id="naissance">
                    <small></small>
                </div>

                <div class="form-controle">
                    <label for="embauche">Date d'embauche</label>
                    <input type="date" name="embauche" id="embauche">
                    <small></small>
                </div>
            </div>
            <div class="d-flex">
                <div class="form-controle">
                    <label>Specialite</label>
                    <select class="js-example-basic-multiple" name="specialite[]" id="specialite" multiple="multiple">
                        <c:forEach items="${requestScope.specialiteList}" var="specialite">
                            <option value="${specialite.id}">${specialite.libelle}</option>
                        </c:forEach>
                    </select>
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
            </div>
            <input type="submit" class="submit" value="valider">
        </form>
    </div>
<%--Form end--%>

<%--Js src--%>
    <script type="text/javascript">
        // In your Javascript (external .js resource or <script> tag)
        $(document).ready(function() {
            $('.js-example-basic-single').select2();
            $('.js-example-basic-multiple').select2();
        });
    </script>
    <script type="text/javascript"><%@ include file="/WEB-INF/js/validator.js"%></script>
    <script type="text/javascript"><%@ include file="/WEB-INF/js/list.js"%></script>
<%--Js end--%>
<% session.removeAttribute("successRemove");%>
</body>
</html>
