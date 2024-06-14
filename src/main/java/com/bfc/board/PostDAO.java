package com.bfc.board;
import java.util.*;
import java.sql.*;

public class PostDAO {
	 private Connection getConnection() {
		 String dbUrl = "jdbc:mysql://localhost:3306/bfc?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
		 String id = "root";
		 String pw = "비밀번호 변경해주세요";
	     Connection conn = null;
	     try {
	    	 Class.forName("com.mysql.cj.jdbc.Driver");
	    	 conn = DriverManager.getConnection(dbUrl, id, pw);
	     } catch (Exception e) {
	         e.printStackTrace();
	     }
	     return conn;
	 }
	 
	 public List<SimplePostDTO> getMyPosts(int userId) {  // �Խñ� ��� �� PostDTO ����Ʈ ��������
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
	        	 simplePost.setTags(getHashtagsByPostId(simplePost.getPostId()));
	        	 simplePosts.add(simplePost);
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
	     return simplePosts;
	 }
	 
	 public String getImage(int PostId) {  // ����Ϸ� ����� ���� ��������
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
	 
	 public PostDTO getPostDetail(int postId) {   // �Խñ� �� ���������� ����� PostDTO
		 PostDTO postDTO = new PostDTO();
		 String sql = "SELECT * FROM Post WHERE PostId = " + postId;
	     try (Connection conn = getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ResultSet rs = ps.executeQuery()) {
	         while (rs.next()) {
	        	 postDTO.setUserId(rs.getInt("UserId"));
	        	 postDTO.setPostId(rs.getInt("PostId"));
	        	 postDTO.setTitle(rs.getString("title"));
	        	 postDTO.setCreatedAt(rs.getTimestamp("createdAt"));
	        	 postDTO.setContents(getContentDetail(postId));
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
		 return postDTO;
	 }
	 
	 public List<ContentDTO> getContentDetail(int postId) {  // �ش� Post���� �ڽ��� ����Ʈ�� ��������
		 List<ContentDTO> contents = new ArrayList<>();
		 String sql = "SELECT * FROM Content WHERE PostId = " + postId;
	     try (Connection conn = getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ResultSet rs = ps.executeQuery()) {
	         while (rs.next()) {
	        	 ContentDTO contentDTO = new ContentDTO();
	        	 contentDTO.setContentId(rs.getInt("contentId"));
	        	 contentDTO.setPostId(rs.getInt("PostId"));
	        	 contentDTO.setUserId(rs.getInt("UserId"));
	        	 contentDTO.setLocation(rs.getString("location"));
	        	 contentDTO.setContentTitle(rs.getString("contentTitle"));
	        	 contentDTO.setContent(rs.getString("content"));
	        	 contentDTO.setImage(rs.getString("image"));
	        	 contentDTO.setTags(getHashtags(contentDTO.getContentId()));
	        	 contents.add(contentDTO);
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
		 return contents;
	 }
	 
	 public List<HashtagDTO> getHashtags(int contendId) {  // �� �ڽ��� �ؽ��±� ��Ʈ�� ��������
		 List<HashtagDTO> tags = new ArrayList<>();
		 String sql = "SELECT * FROM Hashtag WHERE ContentId = " + contendId;
	     try (Connection conn = getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ResultSet rs = ps.executeQuery()) {
	         while (rs.next()) {
	        	 HashtagDTO hashtagDTO = new HashtagDTO();
	        	 hashtagDTO.setTagId(rs.getInt("tagId"));
	        	 hashtagDTO.setContentId(rs.getInt("contentId"));
	        	 hashtagDTO.setUserId(rs.getInt("userId"));
	        	 hashtagDTO.setTag(rs.getString("tag"));
	        	 tags.add(hashtagDTO);
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
		 return tags;
	 }
	 
	 public List<HashtagDTO> getHashtagsByPostId(int postId) {  // PostId�� �ش� �Խñ��� ��� �ؽ��±� ����Ʈ ��������
		 List<HashtagDTO> tags = new ArrayList<>();
		 String sql = "SELECT * FROM Hashtag WHERE PostId = " + postId;
	     try (Connection conn = getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ResultSet rs = ps.executeQuery()) {
	         while (rs.next()) {
	        	 HashtagDTO hashtagDTO = new HashtagDTO();
	        	 hashtagDTO.setTagId(rs.getInt("tagId"));
	        	 hashtagDTO.setContentId(rs.getInt("contentId"));
	        	 hashtagDTO.setUserId(rs.getInt("userId"));
	        	 hashtagDTO.setTag(rs.getString("tag"));
	        	 tags.add(hashtagDTO);
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
		 return tags;
	 }
	 
	 public boolean uploadPost(PostDTO postDTO) {   // Post ���ε�
		 String sql = "INSERT INTO Post (title, userId, createdAt) VALUES (?, ?, ?)";
		 try (Connection conn = getConnection();
				 PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
			 ps.setString(1, postDTO.getTitle());
			 ps.setInt(2, postDTO.getUserId());
			 ps.setTimestamp(3, postDTO.getCreatedAt());
			 ps.executeUpdate();
			 
			 ResultSet generatedKeys = ps.getGeneratedKeys();
			 if (generatedKeys.next()) {
			    int postId = generatedKeys.getInt(1);
			    postDTO.setPostId(postId);
			 }
			 
			 return uploadContent(postDTO);
		 } catch (SQLException e) {
		     e.printStackTrace();
		     return false;
		 }
	 }
	 
	 public boolean uploadContent(PostDTO postDTO) {  // �ش� post�� content ���ε�
		 String sql = "INSERT INTO Content (postId,userId, contentTitle, location, content, image) VALUES (?, ?, ?, ?, ?, ?)";
		 try (Connection conn = getConnection();
				 PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
			 for(ContentDTO contentDTO : postDTO.getContents()) {
					ps.setInt(1, postDTO.getPostId());
					ps.setInt(2, postDTO.getUserId());
					ps.setString(3, contentDTO.getContentTitle());
					ps.setString(4, contentDTO.getLocation());
					ps.setString(5, contentDTO.getContent());
					ps.setString(6, contentDTO.getImage());
					ps.executeUpdate();
					
					ResultSet generatedKeys = ps.getGeneratedKeys();
					if (generatedKeys.next()) {
						int contentId = generatedKeys.getInt(1);
						contentDTO.setContentId(contentId);
					}
					contentDTO.setPostId(postDTO.getPostId());
					uploadHashtag(contentDTO);
			 }
			 return true;
		 } catch (SQLException e) {
		     e.printStackTrace();
		     return false;
		 }
	 }
	 
	 public void uploadHashtag(ContentDTO contentDTO) {   // �� content���� �ؽ��±� ���ε�
		 String sql = "INSERT INTO Hashtag (userId, contentId, postId, tag) VALUES (?, ?, ?, ?)";
		 try (Connection conn = getConnection();
				 PreparedStatement ps = conn.prepareStatement(sql)){
			 ps.setInt(1, contentDTO.getUserId());
			 ps.setInt(2, contentDTO.getContentId());
			 ps.setInt(3, contentDTO.getPostId());
			 for(HashtagDTO tags : contentDTO.getTags()) {
				 ps.setString(4, tags.getTag());
				 ps.executeUpdate();
			 }
			 return;
		 } catch (SQLException e) {
		     e.printStackTrace();
		     return;
		 }
	 }
	 
	 public boolean updatePost(PostDTO postDTO) {   // Post ������Ʈ
		    String sql = "UPDATE Post SET title = ?, createdAt = ? WHERE postId = ?";
		    try (Connection conn = getConnection();
		         PreparedStatement ps = conn.prepareStatement(sql)) {
		        ps.setString(1, postDTO.getTitle());
		        ps.setTimestamp(2, postDTO.getCreatedAt());
		        ps.setInt(3, postDTO.getPostId());
		        ps.executeUpdate();
		        return updateContent(postDTO, getPostDetail(postDTO.getPostId()));
		    } catch (SQLException e) {
		        e.printStackTrace();
		        return false;
		    }
		}

		public boolean updateContent(PostDTO postDTO, PostDTO prePostDTO) {  // �ش� post�� content ������Ʈ
		    String sql = "UPDATE Content SET contentTitle = ?,location = ?, content = ?, image = ? WHERE contentId = ?";
		    int idx = 0;
		    List<ContentDTO> preContent = prePostDTO.getContents();
		    try (Connection conn = getConnection();
		         PreparedStatement ps = conn.prepareStatement(sql)) {
		        for (ContentDTO contentDTO : postDTO.getContents()) {
		            ps.setString(1, contentDTO.getContentTitle());
		            ps.setString(2, contentDTO.getLocation());
		            ps.setString(3, contentDTO.getContent());
		            ps.setString(4, contentDTO.getImage());
		            ps.setInt(5, preContent.get(idx).getContentId());
		            ps.executeUpdate();
		           
		            contentDTO.setPostId(prePostDTO.getPostId());
		            contentDTO.setContentId(preContent.get(idx).getContentId());
		            updateHashtag(contentDTO);
		            idx++;
		        }
		        return true;
		    } catch (SQLException e) {
		        e.printStackTrace();
		        return false;
		    }
		}

		public void updateHashtag(ContentDTO contentDTO) {   // �� content���� �ؽ��±� ������Ʈ
			deleteHashtagsByContentId(contentDTO.getContentId());
			uploadHashtag(contentDTO);
//		    String sql = "UPDATE Hashtag SET tag = ? WHERE tagId = ? ";
//		    try (Connection conn = getConnection();
//		         PreparedStatement ps = conn.prepareStatement(sql)) {
//		        for (HashtagDTO tags : contentDTO.getTags()) {
//		            ps.setString(1, tags.getTag());
//		            ps.executeUpdate();
//		        }
//		        return;
//		    } catch (SQLException e) {
//		        e.printStackTrace();
//		        return;
//		    }
		}
		
	    public void deleteHashtagsByContentId(int contentId) {
	        String sql = "DELETE FROM Hashtag WHERE contentId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, contentId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public void deleteHashtagsByPodtId(int postId) {   // �ؽ��±� ����
	        String sql = "DELETE FROM Hashtag WHERE postId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, postId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public void deleteContentByPodtId(int postId) {   // �ڽ� ����
	        String sql = "DELETE FROM Content WHERE postId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, postId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public void deletePostByPodtId(int postId) {   // PostId�� ����Ʈ ����
	    	deleteHashtagsByPodtId(postId);
	    	deleteContentByPodtId(postId);
	        String sql = "DELETE FROM Post WHERE postId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, postId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    

	 
}