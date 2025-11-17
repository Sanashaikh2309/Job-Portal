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
<title>User: Home</title>
<%@include file="all_component/all_css.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- ================= APPLY FUNCTION ================= -->
<script>
document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".apply-btn").forEach(btn => {
        btn.addEventListener("click", async function () {
            const jobId = this.getAttribute("data-jobid");
            let button = this;

            const response = await fetch("apply-job", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "jobId=" + jobId
            });

            const result = await response.text();

            if (result === "SUCCESS") {
                Swal.fire({
                  icon: "success",
                  title: "Application Submitted!",
                  text: "You applied successfully 🎉"
                });

                button.disabled = true;
                button.innerText = "Applied ✔";
                button.classList.remove("btn-primary");
                button.classList.add("btn-success");

            } else if (result === "ALREADY_APPLIED") {
                Swal.fire({
                  icon: "warning",
                  title: "Already Applied",
                  text: "You have already applied for this job."
                });

                button.disabled = true;
                button.innerText = "Applied ✔";
                button.classList.remove("btn-primary");
                button.classList.add("btn-secondary");

            } else if (result === "NOT_LOGGED_IN") {
                Swal.fire({
                  icon: "info",
                  title: "Login Required",
                  text: "Please login to apply."
                }).then(() => {
                    window.location = "login.jsp";
                });

            } else {
                Swal.fire({
                  icon: "error",
                  title: "Failed!",
                  text: "Something went wrong. Try again."
                });
            }
        });
    });
});
</script>

<style>
.job-card {
    border-radius: 10px;
    transition: 0.2s;
}
.job-card:hover {
    transform: scale(1.01);
    box-shadow: 0px 0px 10px rgba(0,0,0,0.12);
}
</style>

</head>
<body style="background-color: #f0f1f2;">

<c:if test="${empty userobj}">
    <c:redirect url="login.jsp"/>
</c:if>

<%@include file="all_component/navbar.jsp" %>

<div class="container mt-4" style="max-width: 850px;">

    <h4 class="text-center text-primary">All Jobs</h4>

    <c:if test="${not empty succMsg}">
        <h4 class="text-center text-danger">${succMsg}</h4>
        <c:remove var="succMsg"/>
    </c:if>

    <!-- ======== FILTER UI (Optional) ======== -->
    <div class="card mt-3 shadow-sm">
        <div class="card-body">

            <form class="form-inline" action="more_view.jsp" method="get">

                <div class="form-group col-md-5 mt-1">
                    <h5>Location</h5>
                    <select name="loc" class="custom-select">
                        <option selected value="">Choose...</option>
                        <option>Maharashtra</option>
                        <option>Karnataka</option>
                        <option>Tamil Nadu</option>
                        <option>Delhi</option>
                        <option>Uttar Pradesh</option>
                        <option>Telangana</option>
                        <option>Haryana</option>
                        <option>Gujarat</option>
                        <option>West Bengal</option>
                        <option>Madhya Pradesh</option>
                    </select>
                </div>

                <div class="form-group col-md-4 mt-1">
                    <h5>Category</h5>
                    <select name="cat" class="custom-select">
                        <option selected value="">Choose...</option>
                        <option>IT</option>
                        <option>Finance</option>
                        <option>Marketing</option>
                        <option>HR</option>
                        <option>Sales</option>
                    </select>
                </div>

                <div class="form-group col-md-2 mt-4">
                    <button class="btn btn-success col-md-12">Submit</button>
                </div>

            </form>

        </div>
    </div>

    <!-- ================= JOB CARDS ================= -->
    <%
        JobDAO dao = new JobDAO(DBConnect.getConn());
        List<Jobs> list = dao.getAllJobsForUser();
        for (Jobs j : list) {
    %>

    <div class="card job-card mt-3 p-3 shadow-sm">

        <div class="text-center text-primary mb-2">
            <i class="fa fa-clipboard fa-2x"></i>
        </div>

        <h5 class="fw-bold"><%= j.getTitle() %></h5>

        <p class="text-muted">
            <%= (j.getDescription() != null && j.getDescription().length() <= 120)
                    ? j.getDescription()
                    : j.getDescription().substring(0, 120) + "..." %>
        </p>

        <small class="text-muted d-block mb-2">
            <b>Location:</b> <%= j.getLocation() %> <br>
            <b>Category:</b> <%= j.getCategory() %> <br>
            <b>Publish Date:</b> <%= j.getPdate().toString() %>
        </small>

        <div class="text-center mt-2">
            <a href="one_view.jsp?id=<%= j.getId() %>" 
                class="btn btn-success btn-sm px-4">View More</a>

            <button class="btn btn-primary apply-btn btn-sm px-4"
                data-jobid="<%= j.getId() %>">
                Apply
            </button>
        </div>

    </div>

    <% } %>

</div>

</body>
</html>
