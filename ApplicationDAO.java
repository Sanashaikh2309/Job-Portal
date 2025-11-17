package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ApplicationDAO {
	private Connection conn;

    public ApplicationDAO(Connection conn) {
        this.conn = conn;
    }

    // Apply for a job
    public boolean applyJob(int userId, int jobId) {
        boolean f = false;
        try {
            String sql = "INSERT INTO applications(user_id, job_id) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, jobId);

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }

        } catch (Exception e) {
            if (e.getMessage().contains("Duplicate")) {
                // duplicate entry = already applied
                return false;
            }
            e.printStackTrace();
        }
        return f;
    }

    // Check if user already applied
    public boolean isApplied(int userId, int jobId) {
        boolean f = false;
        try {
            String sql = "SELECT * FROM applications WHERE user_id=? AND job_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, jobId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

}
