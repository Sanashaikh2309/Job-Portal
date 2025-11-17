package com.servlet;

import com.dao.ApplicationDAO;
import com.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.DB.DBConnect;


import java.io.IOException;
import java.io.PrintWriter;

@WebServlet		("/apply-job")
public class ApplyJobServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/plain");
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(false);
        User u = (session != null) ? (User) session.getAttribute("userobj") : null;

        if (u == null) {
            out.print("NOT_LOGGED_IN");
            return;
        }

        int jobId = Integer.parseInt(req.getParameter("jobId"));
        int userId = u.getId();

        ApplicationDAO dao = new ApplicationDAO(DBConnect.getConn());

        if (dao.isApplied(userId, jobId)) {
            out.print("ALREADY_APPLIED");
        } else {
            boolean f = dao.applyJob(userId, jobId);
            out.print(f ? "SUCCESS" : "FAILED");
        }
    }
}

