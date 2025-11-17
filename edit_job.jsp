<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.entity.Jobs" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.dao.JobDAO" %> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Jobs </title>
<%@include file="all_component/all_css.jsp" %>

</head>
<body style="background-color: #f0f1f2;">
<c:if test="${userobj.role ne 'admin' }">
<c:redirect url="login.jsp"></c:redirect>
</c:if>
   <%@include file="all_component/navbar.jsp" %>
 
   
   <div class="container p-2">
        <div class="col-md-10 offset-md-1">
            <div class="card">
                <div class="card-body">
                    <div class="text-center text-success">
                        <i class="fas fa-user-friends fa-3x"></i>
                    </div>
                    <% 
                     int id=Integer.parseInt(request.getParameter("id"));
                     JobDAO dao= new JobDAO(DBConnect.getConn());
                     Jobs j=dao.getJobById(id);
                    %>


                    <h5>Edit Jobs</h5>
                    <form action="update" method="post">
                        <input type="hidden" name="id" value="<%=j.getId() %>">

                        <div class="form-group">
                            <label>Enter Title</label>
                            <input type="text" required="required" class="form-control"
                                   name="title"  value="<%=j.getTitle()%>">
                        </div>

                        <div class="form-row">
    <div class="form-group col-md-4">
        <label>Select Location</label>
        <select class="form-control" name="location" required="required">
            <option value="<%=j.getLocation()%>"><%=j.getLocation()%></option>
            <option value="Maharashtra">Maharashtra</option>
            <option value="Karnataka">Karnataka</option>
            <option value="Tamil Nadu">Tamil Nadu</option>
            <option value="Delhi">Delhi (NCT)</option>
            <option value="Uttar Pradesh">Uttar Pradesh</option>
            <option value="Telangana">Telangana</option>
            <option value="Haryana">Haryana</option>
            <option value="Gujarat">Gujarat</option>
            <option value="West Bengal">West Bengal</option>
            <option value="Madhya Pradesh">Madhya Pradesh</option>
        </select>
    </div>

    <div class="form-group col-md-4">
        <label>Enter Category</label>
        <select class="form-control" name="category" required="required">
            <option value="<%=j.getCategory() %>"><%=j.getCategory() %></option>
            <option value="IT">IT</option>
            <option value="Finance">Finance</option>
            <option value="Marketing">Marketing</option>
            <option value="HR">HR</option>
            <option value="Sales">Sales</option>
        </select>
    </div>

    <div class="form-group col-md-4">
        <label>Enter Status</label>
        <select class="form-control" name="status" required="required">
            <option value="<%=j.getStatus() %>"><%=j.getStatus() %></option>
            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>
        </select>
    </div>
</div>
                        <div class="form-group">
                            <label>Enter Description</label>
                            <textarea required="required" rows="5" class="form-control"
                                      name="description"><%=j.getDescription() %></textarea>
                        </div>

                        <button type="submit" class="btn btn-success btn-block mt-3">
                           Update Job
                        </button>
                    </form>

                </div>
            </div>
        </div>
    </div>

</body>
</html>