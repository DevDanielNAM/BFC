package com.bfc.board;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReplyDAO {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/scott";
    private static final String DB_USER = "scott";
    private static final String DB_PASSWORD = "tiger";

    private Connection getConnection() throws SQLException {
    	Connection conn = null;
    	try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        return conn;
    }
	

    public List<ReplyDTO> getAllReplies() {
        List<ReplyDTO> replies = new ArrayList<>();
        String sql = "SELECT * FROM Reply ORDER BY replyId ASC";

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

    public void updateReply(int replyId, String content) {
        String sql = "UPDATE Reply SET content = ? WHERE replyId = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, content);
            ps.setInt(2, replyId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteReply(int replyId) {
        String sql = "DELETE FROM Reply WHERE replyId = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, replyId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
