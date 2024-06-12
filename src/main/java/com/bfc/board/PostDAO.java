package com.bfc.board;

import java.util.*;
import java.sql.*;

public class PostDAO {
	 private Connection getConnection() {
		 String dbUrl = "jdbc:oracle:thin:@localhost:1521:XE";
		 String id = "scott";
		 String pw = "tiger";
	     Connection conn = null;
	     try {
	    	 Class.forName("oracle.jdbc.driver.OracleDriver");
	    	 conn = DriverManager.getConnection(dbUrl, id, pw);
	     } catch (Exception e) {
	         e.printStackTrace();
	     }
	     return conn;
	 }
	 
	 public List<SimplePostDTO> getMyPosts(int userId) {
	     List<SimplePostDTO> simplePosts = new ArrayList<>();
	     String sql = "SELECT * FROM Post WHERE userId = " + userId;
	     try (Connection conn = getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ResultSet rs = ps.executeQuery()) {
	         while (rs.next()) {
	        	 SimplePostDTO simplePost = new SimplePostDTO();
	        	 simplePost.setUserId(rs.getInt("UserId"));
	        	 simplePost.setPostId(rs.getInt("PostId"));
	        	 simplePost.setTitle(rs.getString("title"));
	        	 simplePost.setImage(getImage(simplePost.getPostId()));
	        	 simplePosts.add(simplePost);
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
	     return simplePosts;
	 }
	 
	 public String getImage(int PostId) {
	     String image = "";
	     String sql = "SELECT * FROM Content WHERE PostId = " + PostId;
	     try (Connection conn = getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ResultSet rs = ps.executeQuery()) {
	         while (rs.next()) {
	        	 image = rs.getString("image");
	        	 break;
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
	     return image;
	 }
}