package com.bfc.board;

import java.util.*;
import java.sql.*;

public class PostDAO {
	 private Connection getConnection() {
		 String dbUrl = "jdbc:mysql://localhost:3306/scott";
		 String id = "scott";
		 String pw = "tiger";
	     Connection conn = null;
	     try {
	    	 Class.forName("com.mysql.cj.jdbc.Driver");
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

	 	 public PostDTO getPostDetail(int postId) {
		 PostDTO postDTO = new PostDTO();
		 String sql = "SELECT * FROM Post WHERE PostId = " + postId;
	     try (Connection conn = getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ResultSet rs = ps.executeQuery()) {
	         while (rs.next()) {
	        	 postDTO.setUserId(rs.getInt("UserId"));
	        	 postDTO.setPostId(rs.getInt("PostId"));
	        	 postDTO.setTitle(rs.getString("title"));
	        	 postDTO.setCreatedAt(rs.getDate("createdAt"));
	        	 postDTO.setContents(getContentDetail(postId));
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
		 return postDTO;
	 }
	 
	 public List<ContentDTO> getContentDetail(int postId) {
		 List<ContentDTO> contents = new ArrayList<>();
		 String sql = "SELECT * FROM Content WHERE PostId = " + postId;
	     try (Connection conn = getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ResultSet rs = ps.executeQuery()) {
	         while (rs.next()) {
	        	 ContentDTO contentDTO = new ContentDTO();
	        	 contentDTO.setContent(rs.getString("content"));
	        	 contentDTO.setImage(rs.getString("image"));
	        	 contents.add(contentDTO);
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
		 return contents;
	 }
	 
	 public List<SimplePostDTO> getAllPosts() {
	        List<SimplePostDTO> simplePosts = new ArrayList<>();
	        String sql = "SELECT * FROM Post";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql);
	             ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                SimplePostDTO simplePost = new SimplePostDTO();
	                simplePost.setUserId(rs.getInt("userId"));
	                simplePost.setPostId(rs.getInt("postId"));
	                simplePost.setTitle(rs.getString("title"));
	                simplePost.setImage(getImage(simplePost.getPostId()));
	                simplePosts.add(simplePost);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return simplePosts;
	    }
	 
	 public List<SimplePostDTO> searchPosts(String query) {
	        List<SimplePostDTO> searchedPosts = new ArrayList<>();
	        String sql = "SELECT p.postId, p.title, c.image FROM Post p JOIN Content c ON p.postId = c.postId WHERE p.title LIKE ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setString(1, "%" + query + "%");
	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    SimplePostDTO post = new SimplePostDTO();
	                    post.setPostId(rs.getInt("postId"));
	                    post.setTitle(rs.getString("title"));
	                    post.setImage(getImage(post.getPostId()));
	                    searchedPosts.add(post);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return searchedPosts;
	    }
}