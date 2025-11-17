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
<title>Admin: View Jobs</title>
<%@include file="all_component/all_css.jsp" %>
</head>
<body style="background-color: #f0f1f2;">
<c:if test="${userobj.role ne 'admin' }">
<c:redirect url="login.jsp"></c:redirect>
</c:if>
<%@include file="all_component/navbar.jsp" %>

<div class="container mt-3">
<c:if test="${not empty sessionScope.succMsg}">
    <div class="alert alert-success" role="alert">${sessionScope.succMsg}</div>
    <c:remove var="succMsg" scope="session"/>
</c:if>
  <h5 class="text-center text-primary">All Jobs</h5>
  <div class="row">

    <%
      JobDAO dao = new JobDAO(DBConnect.getConn());
      List<Jobs> list = dao.getAllJobs();
      for (Jobs j : list) {
    %>

      <!-- Full width card -->
      <div class="col-md-12 mb-3">
        <div class="card shadow-sm">
          <div class="card-body">
            <div class="text-center text-primary mb-2">
              <i class="far fa-clipboard fa-2x"></i>
            </div>

            <!-- Job Title -->
            <h6 class="fw-bold"><%= j.getTitle() %></h6>

            <!-- Job Description -->
            <p class="text-muted">
              <%= j.getDescription() %>
            </p>

            <!-- Job Details -->
            <div class="row mb-2">
              <div class="col-md-3">
                <input type="text" class="form-control form-control-sm"
                       value="Location: <%= j.getLocation() %>" readonly>
              </div>
              <div class="col-md-3">
                <input type="text" class="form-control form-control-sm"
                       value="Category: <%= j.getCategory() %>" readonly>
              </div>
              <div class="col-md-3">
                <input type="text" class="form-control form-control-sm"
                       value="Status: <%= j.getStatus() %>" readonly>
              </div>
            </div>

            <!-- Publish Date -->
            <h6 class="text-secondary">Publish Date: <%= j.getPdate() %></h6>

            <!-- Action Buttons -->
            <div class="text-center mt-2">
              <a href="edit_job.jsp?id=<%=j.getId() %>" class="btn btn-sm bg-success text-white">Edit</a>
              <a href="delete?id=<%=j.getId() %>" class="btn btn-sm bg-danger text-white">Delete</a>
            </div>
          </div>
        </div>
      </div>

    <% } %>

  </div>
</div>

</body>
</html>
