<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SignUp Page</title>
<%@include file="all_component/all_css.jsp" %>
</head> 
 <body style="background-color: #f0f1f2;">
    <%@ include file="all_component/navbar.jsp" %>
    
    <div class="container-fluid">
        <div class="row p-4">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-body">
                        <div class="text-center">
                            <i class="fa fa-user-plus fa-2x" aria-hidden="true"></i>
                            <h5>Registration</h5>
                        </div>

                   <c:if test="${not empty sessionScope.succMsg}">
                     <div class="alert alert-success" role="alert">${sessionScope.succMsg}</div>
                      <c:remove var="succMsg" scope="session"/>
                 </c:if>
                        <form action="add_user" method="post">
                            <div class="form-group">
                                <label>Enter Full name</label>
                                <input type="text" required="required" class="form-control"
                                       id="exampleInputEmail" aria-describedby="emailHelp"
                                       name="name">
                            </div>
                            
                            <div class="form-group">
                                <label>Enter Qualification</label>
                                <input type="text" required="required" class="form-control"
                                       id="exampleInputEmail1" aria-describedby="emailHelp"
                                       name="qua">
                            </div>
                            

                            <div class="form-group">
                                <label>Enter Email</label>
                                <input type="email" required="required" class="form-control"
                                       id="exampleInputEmail1" aria-describedby="emailHelp"
                                       name="email">
                            </div>
                            

                            <div class="form-group">
                                <label>Enter Password</label>
                                <input type="password" required="required" class="form-control"
                                       id="exampleInputPassword1" name="ps">
                            </div>


                            <button type="submit" class="btn btn-primary btn-block ">
                                Register
                            </button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>