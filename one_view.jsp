<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.dao.JobDAO" %>
<%@ page import="com.entity.Jobs" %>
<%@ page import="java.util.List" %>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@include file="all_component/all_css.jsp" %>
</head>
<body style="background-color: #f0f1f2;">

<c:if test="${empty userobj }">
<c:redirect url="login.jsp"/>
</c:if>
   
   <%@include file="all_component/navbar.jsp" %>
   
   <div class="container">
    <div class="row">
        <div class="col-md-12">

            <%
                // Scriptlet for Java logic
                int id = Integer.parseInt(request.getParameter("id"));
                JobDAO dao = new JobDAO(DBConnect.getConn());
                Jobs j = dao.getJobById(id);
            %>

            <div class="card mt-5">
                <div class="card-body">

                    <div class="text-center text-primary">
                        <i class="fa fa-clipboard fa-2x"></i>
                    </div>

                    <h5><%=j.getTitle()%></h5>
                    <p><%=j.getDescription()%></p>
                    
                    <div class="form-row">
                    
                        <div class="form-group col-md-3">
                            <input type="text" class="form-control form-control-sm"
                                value=" Location: <%=j.getLocation()%>" readonly>
                        </div>
                        
                        <div class="form-group col-md-3">
                            <input type="text" class="form-control form-control-sm"
                                value=" Category: <%=j.getCategory()%>" readonly>
                        </div>
                      </div>

          
                    <h6>
                    Publish Date:
                    <%=j.getPdate().toString() %></h6>
                     <div class="text-center ">
                       <a href="one_view.jsp?id=<%= j.getId() %>" 
                       class="btn btn-sm bg-success text-white ">View More</a>
                     </div>
                </div>
            </div>
            
            
            
            
          </div>
     </div>
  </div>


</body>
</html>