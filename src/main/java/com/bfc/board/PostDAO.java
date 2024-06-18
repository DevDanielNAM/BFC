package com.bfc.board;
import java.util.*;
import java.sql.*;

public class PostDAO {
	 private Connection getConnection() {
		 String dbUrl = "jdbc:mysql://localhost:3306/bfc?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
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
	     String sql = "SELECT * FROM Image WHERE PostId = " + PostId;
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
	        	 contentDTO.setImages(getImageList(contentDTO.getContentId()));
	        	 contentDTO.setTags(getHashtags(contentDTO.getContentId()));
	        	 contents.add(contentDTO);
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
		 return contents;
	 }
	 
	 public List<ImageDTO> getImageList(int contentId){
		 List<ImageDTO> images = new ArrayList<>();
		 String sql = "SELECT * FROM Image WHERE ContentId = " + contentId;
	     try (Connection conn = getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ResultSet rs = ps.executeQuery()) {
	         while (rs.next()) {
	        	 ImageDTO imageDTO = new ImageDTO();
	        	 imageDTO.setContentId(rs.getInt("contentId"));
	        	 imageDTO.setPostId(rs.getInt("PostId"));
	        	 imageDTO.setUserId(rs.getInt("UserId"));
	        	 imageDTO.setImageId(rs.getInt("ImageId"));
	        	 imageDTO.setImage(rs.getString("image"));
	        	 images.add(imageDTO);
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
		 return images;
	 }
	 
	 public Map<String, List<String>> getContentImagesTitlesLocations(int postId) {
		 	List<String> contentIds = new ArrayList<>();
		 	List<String> contents = new ArrayList<>();
		    List<String> contentTitles = new ArrayList<>();
		    List<String> locations = new ArrayList<>();
		    List<String> images = new ArrayList<>();
		    
		    String sql = "SELECT contentId, content, contentTitle, location FROM Content WHERE PostId = " + postId;
		    try (Connection conn = getConnection();
		         PreparedStatement ps = conn.prepareStatement(sql);
		         ResultSet rs = ps.executeQuery()) {
		        while (rs.next()) {
		        	contentIds.add(rs.getString("contentId"));
		        	contents.add(rs.getString("content"));
		            contentTitles.add(rs.getString("contentTitle"));
		            locations.add(rs.getString("location"));
		            images.add(getImage(postId));
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    
		    Map<String, List<String>> result = new HashMap<>();
		    result.put("contentIds", contentIds);
		    result.put("contents", contents);
		    result.put("contentTitles", contentTitles);
		    result.put("locations", locations);
		    result.put("images", images);
		    
		    return result;
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
		 String sql = "INSERT INTO Content (postId,userId, contentTitle, location, content) VALUES (?, ?, ?, ?, ?)";
		 try (Connection conn = getConnection();
				 PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
			 for(ContentDTO contentDTO : postDTO.getContents()) {
					ps.setInt(1, postDTO.getPostId());
					ps.setInt(2, postDTO.getUserId());
					ps.setString(3, contentDTO.getContentTitle());
					ps.setString(4, contentDTO.getLocation());
					ps.setString(5, contentDTO.getContent());
					ps.executeUpdate();
					
					ResultSet generatedKeys = ps.getGeneratedKeys();
					if (generatedKeys.next()) {
						int contentId = generatedKeys.getInt(1);
						contentDTO.setContentId(contentId);
					}
					contentDTO.setPostId(postDTO.getPostId());
					uploadImage(contentDTO);
					uploadHashtag(contentDTO);
			 }
			 return true;
		 } catch (SQLException e) {
		     e.printStackTrace();
		     return false;
		 }
	 }
	 
	 public void uploadImage(ContentDTO contentDTO) {   // �� content���� �ؽ��±� ���ε�
		 String sql = "INSERT INTO Image (userId, contentId, postId, image) VALUES (?, ?, ?, ?)";
		 try (Connection conn = getConnection();
				 PreparedStatement ps = conn.prepareStatement(sql)){
			 ps.setInt(1, contentDTO.getUserId());
			 ps.setInt(2, contentDTO.getContentId());
			 ps.setInt(3, contentDTO.getPostId());
			 for(ImageDTO images : contentDTO.getImages()) {
				 ps.setString(4, images.getImage());
				 ps.executeUpdate();
			 }
			 return;
		 } catch (SQLException e) {
		     e.printStackTrace();
		     return;
		 }
	 }

	 public boolean uploadNewContent(ContentDTO contentDTO) {  // 占쌔댐옙 post占쏙옙 content 占쏙옙占싸듸옙
		 String sql = "INSERT INTO Content (postId,userId, contentTitle, location, content) VALUES (?, ?, ?, ?, ?)";
		 try (Connection conn = getConnection();
				 PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
				ps.setInt(1, contentDTO.getPostId());
				ps.setInt(2, contentDTO.getUserId());
				ps.setString(3, contentDTO.getContentTitle());
				ps.setString(4, contentDTO.getLocation());
				ps.setString(5, contentDTO.getContent());
				ps.executeUpdate();

				ResultSet generatedKeys = ps.getGeneratedKeys();
				if (generatedKeys.next()) {
					int contentId = generatedKeys.getInt(1);
					contentDTO.setContentId(contentId);
				}
				uploadImage(contentDTO);
				uploadHashtag(contentDTO);
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
		    String sql = "UPDATE Content SET contentTitle = ?,location = ?, content = ?WHERE contentId = ?";
		    int idx = 0;
		    List<ContentDTO> preContent = prePostDTO.getContents();
		    try (Connection conn = getConnection();
		         PreparedStatement ps = conn.prepareStatement(sql)) {
		        for (ContentDTO contentDTO : postDTO.getContents()) {
		            ps.setString(1, contentDTO.getContentTitle());
		            ps.setString(2, contentDTO.getLocation());
		            ps.setString(3, contentDTO.getContent());
		            ps.setInt(4, preContent.get(idx).getContentId());
		            ps.executeUpdate();
		           
		            contentDTO.setPostId(prePostDTO.getPostId());
		            contentDTO.setContentId(preContent.get(idx).getContentId());
		            updateImage(contentDTO);
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
		}
		
		public void updateImage(ContentDTO contentDTO) {   // �� content���� �ؽ��±� ������Ʈ
			deleteImagesByContentId(contentDTO.getContentId());
			uploadImage(contentDTO);
		}
		
	    public void deleteImagesByContentId(int contentId) {
	        String sql = "DELETE FROM Image WHERE contentId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, contentId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public void deleteImageByPostId(int postId) {
	        String sql = "DELETE FROM Image WHERE postId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, postId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
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
	    
	    public void deleteHashtagsByPostId(int postId) {   // �ؽ��±� ����
	        String sql = "DELETE FROM Hashtag WHERE postId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, postId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public void deleteReplyByPostId(int postId) {   // �ڽ� ����
	        String sql = "DELETE FROM Reply WHERE postId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, postId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public void deleteContentByPostId(int postId) {   // �ڽ� ����
	        String sql = "DELETE FROM Content WHERE postId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, postId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public void deletePostByPostId(int postId) {   // PostId�� ����Ʈ ����
	    	deleteHashtagsByPostId(postId);
	    	deleteImageByPostId(postId);
	    	deleteReplyByPostId(postId);
	    	deleteContentByPostId(postId);
	        String sql = "DELETE FROM Post WHERE postId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, postId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    public void deleteImageByUserId(int userId) {
	        String sql = "DELETE FROM Image WHERE userId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, userId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public void deleteHashtagsByUserId(int userId) {   // �ؽ��±� ����
	        String sql = "DELETE FROM Hashtag WHERE userId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, userId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    public void deleteReplyByUserId(int userId) {   // �ڽ� ����
	        String sql = "DELETE FROM Reply WHERE userId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, userId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public void deleteContentByUserId(int userId) {   // �ڽ� ����
	        String sql = "DELETE FROM Content WHERE userId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, userId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public void deletePostByUserId(int userId) {   // PostId�� ����Ʈ ����
	    	deleteHashtagsByUserId(userId);
	    	deleteImageByUserId(userId);
	    	deleteContentByUserId(userId);
	    	deleteReplyByUserId(userId);
	        String sql = "DELETE FROM Post WHERE userId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, userId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
      public int getLastPostId() {
          int lastPostId = 0;
          String query = "SELECT MAX(postId) AS lastPostId FROM Post";

          try (Connection conn = getConnection();
               PreparedStatement pstmt = conn.prepareStatement(query);
               ResultSet rs = pstmt.executeQuery()) {

              if (rs.next()) {
                  lastPostId = rs.getInt("lastPostId");
              }

          } catch (SQLException e) {
              e.printStackTrace();
          }

          return lastPostId;
      }	 

	    public List<SimplePostDTO> getAllPosts() {
	        List<SimplePostDTO> simplePosts = new ArrayList<>();
	        String sql = "SELECT * FROM Post";
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
	    
	    public List<SimplePostDTO> searchPosts(String query) {
	        List<SimplePostDTO> searchedPosts = new ArrayList<>();
	        String sql = "SELECT p.postId, p.title" +
	                     "FROM Post p " +
	                     "JOIN Content c ON p.postId = c.postId " +
	                     "WHERE p.title LIKE ? " +
	                     "AND c.contentId = (SELECT MAX(c2.contentId) " +
	                                        "FROM Content c2 " +
	                                        "WHERE c2.postId = p.postId)";

	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setString(1, "%" + query + "%");

	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    int postId = rs.getInt("postId");
	                    String title = rs.getString("title");

	                    SimplePostDTO simplePost = new SimplePostDTO();
	                    simplePost.setPostId(postId);
	                    simplePost.setTitle(title);
	                    simplePost.setImage(getImage(simplePost.getPostId()));
	                    simplePost.setTags(getHashtagsByPostId(postId)); // 여행지의 해시태그 설정

	                    searchedPosts.add(simplePost);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return searchedPosts;
	    }
	    
	    public List<SimplePostDTO> searchPostsByTag(String tagQuery) {
	        List<SimplePostDTO> searchedPosts = new ArrayList<>();
	        String sql = "SELECT p.postId, p.title " +
	                     "FROM Post p " +
	                     "JOIN Content c ON p.postId = c.postId " +
	                     "JOIN HashTag h ON c.contentId = h.contentId " +
	                     "WHERE h.tag LIKE ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setString(1, "%" + tagQuery + "%");

	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    int postId = rs.getInt("postId");
	                    String title = rs.getString("title");

	                    SimplePostDTO simplePost = new SimplePostDTO();
	                    simplePost.setPostId(postId);
	                    simplePost.setTitle(title);
	                    simplePost.setImage(getImage(simplePost.getPostId()));
	                    simplePost.setTags(getHashtagsByPostId(postId)); // 여행지의 해시태그 설정

	                    searchedPosts.add(simplePost);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return searchedPosts;
	    }

	    
	    public List<String> getRandomHashtags(int count) {
	        List<String> hashtags = new ArrayList<>();
	        String sql = "SELECT DISTINCT tag FROM HashTag ORDER BY RAND() LIMIT ?";

	        try (Connection conn = getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            pstmt.setInt(1, count);

	            try (ResultSet rs = pstmt.executeQuery()) {
	                while (rs.next()) {
	                    hashtags.add(rs.getString("tag"));
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return hashtags;
	    }
	    
	    public int getContentCount(int postId) {
	        int count = 0;
	        String sql = "SELECT COUNT(*) AS contentCount FROM Content WHERE PostId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, postId);
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    count = rs.getInt("contentCount");
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return count;
	    }

}