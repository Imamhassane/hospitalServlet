<%--
  Created by IntelliJ IDEA.
  User: Bazzman
  Date: 09/02/2023
  Time: 19:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>connexion</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<section class="vh-100">
    <div class="container-fluid h-custom">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-md-9 col-lg-6 col-xl-5">
                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                     class="img-fluid" alt="Sample image">
            </div>


            <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                <div class="text-danger mb-5">
                    <h3>${requestScope.errorLogin}</h3>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/">
                    <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                        <p class="lead fw-normal mb-3 me-3">Se connecter</p>
                        <%--<button type="button" class="btn btn-primary btn-floating mx-1">
                            <i class="fab fa-facebook-f"></i>
                        </button>

                        <button type="button" class="btn btn-primary btn-floating mx-1">
                            <i class="fab fa-twitter"></i>
                        </button>

                        <button type="button" class="btn btn-primary btn-floating mx-1">
                            <i class="fab fa-linkedin-in"></i>
                        </button>--%>
                    </div>


                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <label class="form-label" for="form3Example3">Login</label>
                        <input type="text" id="form3Example3" class="form-control form-control-lg" name="email"
                               placeholder="Enter a valid email address" />
                    </div>

                    <!-- Password input -->
                    <div class="form-outline mb-3">
                        <label class="form-label" for="form3Example4">Password</label>
                        <input type="password" id="form3Example4" class="form-control form-control-lg" name="password"
                               placeholder="Enter password" />
                    </div>

                    <button type="submit"  class="btn bg-dark text-white btn-floating mx-1">
                        Se connecter
                    </button>

                </form>
            </div>
        </div>
    </div>
</section>
</body>
</html>
