package com.bfc.board;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReplyDAO {
 private Connection getConnection() {
     Connection conn = null;
     try {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");
     } catch (Exception e) {
         e.printStackTrace();
     }
     return conn;
 }

 public List<ReplyDTO> getAllReplies() {
     List<ReplyDTO> replies = new ArrayList<>();
     String sql = "SELECT * FROM Reply ORDER BY REPLYID ASC";
     try (Connection conn = getConnection();
          PreparedStatement ps = conn.prepareStatement(sql);
          ResultSet rs = ps.executeQuery()) {
         while (rs.next()) {
             ReplyDTO reply = new ReplyDTO();
             reply.setReplyId(rs.getInt("replyId"));
             reply.setContent(rs.getString("content"));
             reply.setCreatedAt(rs.getTimestamp("createdAt"));
             reply.setWriterId(rs.getInt("writerId"));
             reply.setWriterNickname(rs.getString("writerNickname"));
             replies.add(reply);
         }
     } catch (SQLException e) {
         e.printStackTrace();
     }
     return replies;
 }

 public void addReply(ReplyDTO reply) {
     String sql = "INSERT INTO Reply (content, createdAt, writerId, writerNickname) VALUES (?, ?, ?, ?)";
     try (Connection conn = getConnection();
          PreparedStatement ps = conn.prepareStatement(sql)) {
         ps.setString(1, reply.getContent());
         ps.setTimestamp(2, reply.getCreatedAt());
         ps.setInt(3, reply.getWriterId());
         ps.setString(4, reply.getWriterNickname());
         ps.executeUpdate();
     } catch (SQLException e) {
         e.printStackTrace();
     }
 }
}

