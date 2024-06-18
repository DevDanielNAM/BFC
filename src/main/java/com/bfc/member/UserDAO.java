package com.bfc.member;
import java.util.*;
import com.bfc.board.PostDAO;
import java.sql.*;

public class UserDAO {
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
	 
	 public UserDTO getUserInfo(int UserId) {
		 UserDTO userDTO = new UserDTO();
		 userDTO.setUserId(UserId);
	     String sql = "SELECT * FROM User WHERE UserId = " + UserId;
	     try (Connection conn = getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ResultSet rs = ps.executeQuery()) {
	         while (rs.next()) {
	        	 userDTO.setNickname(rs.getString("nickname"));
	        	 userDTO.setLogin(rs.getString("login"));
	        	 userDTO.setPassword(rs.getString("password"));
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
	     return userDTO;
	 }
	 
	 public boolean updateUserInfo(UserDTO userDTO) {
			boolean success = false;
			String sql = "UPDATE user SET nickname = ?, password = ? WHERE userId = ?";
			try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setString(1, userDTO.getNickname());
				ps.setString(2, userDTO.getPassword());
				ps.setInt(3, userDTO.getUserId());
				ps.executeUpdate();
				success = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return success;
		} 
	 
	 public boolean registerUser(UserDTO user) {
		    boolean isSuccess = false;
		    String sql = "INSERT INTO User (nickname, login, password) VALUES (?, ?, ?)";
		    try (Connection conn = getConnection();
		         PreparedStatement ps = conn.prepareStatement(sql)) {

		        ps.setString(1, user.getNickname());
		        ps.setString(2, user.getLogin());
		        ps.setString(3, user.getPassword());

		        ps.executeUpdate(); 
		        isSuccess = true;
		        
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return isSuccess;
		}

	 // 로그인 검증 메서드
	    public UserDTO validateUser(String login, String password) {
	        UserDTO user = null;
	        String sql = "SELECT * FROM User WHERE login = ? AND password = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {

	            ps.setString(1, login);
	            ps.setString(2, password);

	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    user = new UserDTO();
	                    user.setUserId(rs.getInt("userId"));
	                    user.setNickname(rs.getString("nickname"));
	                    user.setLogin(rs.getString("login"));
	                    user.setPassword(rs.getString("password"));
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return user;
	    }
	    
	    public void deleteUser(int userId) {   // PostId�� ����Ʈ ����
	    	PostDAO postDAO = new PostDAO();
	    	postDAO.deletePostByUserId(userId);
	        String sql = "DELETE FROM User WHERE userId = ?";
	        try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, userId);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
}