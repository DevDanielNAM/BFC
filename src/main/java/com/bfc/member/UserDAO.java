package com.bfc.member;
import java.util.*;
import java.sql.*;

public class UserDAO {
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
	 
	 public UserDTO getUserInfo(int UserId) {
		 UserDTO userDTO = new UserDTO();
		 userDTO.setUserId(UserId);
	     String sql = "SELECT * FROM Users WHERE UserId = " + UserId;
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
			String sql = "UPDATE users SET nickname = ?, password = ? WHERE userId = ?";
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
}