package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Jobs;

public class JobDAO {
	
	private Connection conn;

	public JobDAO(Connection conn) {
		super();
		this.conn = conn;
	}
	
	public boolean addJobs(Jobs j) 
	{
		boolean f=false;
		try 
		{
			String sql="insert into jobs(title,description,category,status,location) values(?,?,?,?,?)";
			PreparedStatement ps=conn.prepareStatement(sql);
			
			ps.setString(1,j.getTitle());
			ps.setString(2, j.getDescription());
			ps.setString(3, j.getCategory());
			ps.setString(4, j.getStatus());
			ps.setString(5, j.getLocation());
			
			int i=ps.executeUpdate();
			
			if(i==1)
			{
				f=true;
			}
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	
		return f;
		
	}
	
	public List<Jobs> getAllJobs()
	{
		List<Jobs> list=new ArrayList<Jobs>();
		Jobs j=null;
		
		try {
			
			String sql ="select * from jobs order by id desc";
			PreparedStatement ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				
				j= new Jobs();
				j.setId(rs.getInt("id"));
				j.setTitle(rs.getString("title"));
				j.setDescription(rs.getString("description"));
				j.setCategory(rs.getString("category"));
				j.setStatus(rs.getString("status"));
				j.setLocation(rs.getString("location"));
				j.setPdate(rs.getTimestamp("pdate")+"");
				list.add(j);
			}
			
			
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return list;
		
	}
	
	public List<Jobs> getAllJobsForUser()
	{
		List<Jobs> list=new ArrayList<Jobs>();
		Jobs j=null;
		
		try {
			
			String sql ="select * from jobs where status=? order by id desc";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setString(1, "Active");
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				
				j= new Jobs();
				j.setId(rs.getInt("id"));
				j.setTitle(rs.getString("title"));
				j.setDescription(rs.getString("description"));
				j.setCategory(rs.getString("category"));
				j.setStatus(rs.getString("status"));
				j.setLocation(rs.getString("location"));
				j.setPdate(rs.getTimestamp("pdate")+"");
				list.add(j);
			}
			
			
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return list;
		
	}
	
	public Jobs getJobById(int id) {
	    Jobs j = null;

	    try {
	        String sql = "select * from jobs where id=?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) { // Use if instead of while because ID is unique
	            j = new Jobs();
	            j.setId(rs.getInt("id"));
	            j.setTitle(rs.getString("title"));
	            j.setDescription(rs.getString("description"));
	            j.setCategory(rs.getString("category"));
	            j.setStatus(rs.getString("status"));
	            j.setLocation(rs.getString("location"));
	            j.setPdate(rs.getTimestamp("pdate") + "");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return j; // Now returning a single Jobs object
	}
	
	public boolean updateJob(Jobs j)
	{
		boolean f=false;
		try 
		{
			String sql="update  jobs set title=?,description=?,category=?,status=?,location=? where id=?";
			PreparedStatement ps=conn.prepareStatement(sql);
			
			ps.setString(1,j.getTitle());
			ps.setString(2, j.getDescription());
			ps.setString(3, j.getCategory());
			ps.setString(4, j.getStatus());
			ps.setString(5, j.getLocation());
			ps.setInt(6, j.getId());
			
			int i=ps.executeUpdate();
			
			if(i==1)
			{
				f=true;
			}
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	
		return f;
		
	}
	
	public boolean deleteJobs(int id)
	{
		boolean f= false;
		
		try {
			String sql="delete from Jobs where id=?";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setInt(1, id);
			
            int i=ps.executeUpdate();
			
			if(i==1)
			{
				f=true;
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return f;
	}
	
	public List<Jobs> getJobsAndLocationAndCate(String category, String location) {
	    List<Jobs> list = new ArrayList<>();
	    Jobs j = null;

	    try {
	        String sql = "SELECT * FROM jobs " +
	                     "WHERE LOWER(category) = LOWER(?) " +
	                     "AND LOWER(location) = LOWER(?) " +
	                     "ORDER BY id DESC";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, category.trim());
	        ps.setString(2, location.trim());

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            j = new Jobs();
	            j.setId(rs.getInt("id"));
	            j.setTitle(rs.getString("title"));
	            j.setDescription(rs.getString("description"));
	            j.setCategory(rs.getString("category"));
	            j.setStatus(rs.getString("status"));
	            j.setLocation(rs.getString("location"));
	            j.setPdate(rs.getTimestamp("pdate") + "");
	            list.add(j);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public List<Jobs> getJobsORLocationAndCate(String category, String location) {
	    List<Jobs> list = new ArrayList<>();
	    Jobs j = null;

	    try {
	        StringBuilder sql = new StringBuilder("SELECT * FROM jobs WHERE ");
	        boolean hasCategory = (category != null && !category.trim().isEmpty());
	        boolean hasLocation = (location != null && !location.trim().isEmpty());

	        if (hasCategory && hasLocation) {
	            sql.append("LOWER(category) = LOWER(?) OR LOWER(location) = LOWER(?)");
	        } else if (hasCategory) {
	            sql.append("LOWER(category) = LOWER(?)");
	        } else if (hasLocation) {
	            sql.append("LOWER(location) = LOWER(?)");
	        }

	        sql.append(" ORDER BY id DESC");

	        PreparedStatement ps = conn.prepareStatement(sql.toString());

	        if (hasCategory && hasLocation) {
	            ps.setString(1, category.trim());
	            ps.setString(2, location.trim());
	        } else if (hasCategory) {
	            ps.setString(1, category.trim());
	        } else if (hasLocation) {
	            ps.setString(1, location.trim());
	        }

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            j = new Jobs();
	            j.setId(rs.getInt("id"));
	            j.setTitle(rs.getString("title"));
	            j.setDescription(rs.getString("description"));
	            j.setCategory(rs.getString("category"));
	            j.setStatus(rs.getString("status"));
	            j.setLocation(rs.getString("location"));
	            j.setPdate(rs.getTimestamp("pdate") + "");
	            list.add(j);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
 }




