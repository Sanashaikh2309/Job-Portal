<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin</title>
<%@include file="all_component/all_css.jsp" %>
<style type="text/css">
.back-img {
            background: url("img/ad.png") center center / cover no-repeat;
            min-height: 90vh;
            width: 100%;
        }

</style>


</head>
<body>

<c:if test="${userobj.role ne 'admin' }">
<c:redirect url="login.jsp"></c:redirect>
</c:if>

     <%@include file="all_component/navbar.jsp" %>
  
     <div class="container-fluid back-img">
       <div class="text-center">
           <h1 class="text-white p-4"> Welcome Admin </h1>
       </div>
    </div>
     

</body>
</html>