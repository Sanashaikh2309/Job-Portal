<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
<%@include file="all_component/all_css.jsp" %>
</head>
   <body style="background-color: #f0f1f2;">
    <%@include file="all_component/navbar.jsp" %>
     <div class="container-fluid">
        <div class="row p-5">
            <div class="col-md-4 offset-md-4">
                <div class="card ">
                    <div class="card-body">

                        <!-- Page title -->
                        <div class="text-center ">
                            <i class="fa fa-user-plus fa-2x" aria-hidden="true"></i>
                            <h5 class="mt-2">Login Page</h5>
                        </div>
                        <c:if test="${not empty sessionScope.succMsg}">
    <div class="alert alert-success" role="alert">${sessionScope.succMsg}</div>
    <c:remove var="succMsg" scope="session"/>
</c:if>
                       
                        <!-- Login form -->
                        <form action="login" method="post">
                            <div class="form-group ">
                                <label>Enter Email</label>
                                <input type="email" id="exampleInputEmail1" name="email"
                                       class="form-control" required="required"
                                       aria-describedby="emailHelp">
                            </div>

                            <div class="form-group">
                                <label for="exampleInputPassword1">Enter Password</label>
                                <input type="password" id="exampleInputPassword1" name="password"
                                       class="form-control" required="required">
                            </div>

                            <button type="submit" class="btn btn-primary badge=pill btn-block">
                                Login
                            </button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
   
</body>
</html>