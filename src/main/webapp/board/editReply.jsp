<%@ page import="java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="replyDAO" class="com.bfc.board.ReplyDAO" scope="request" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		int postId = Integer.parseInt(request.getParameter("postId"));
        String replyIdStr = request.getParameter("replyId");
        String replyContent = request.getParameter("replyContent");
        int writerId = Integer.parseInt(request.getParameter("writerId"));
        int userId = (Integer) (session.getAttribute("userId") != null? session.getAttribute("userId"): -1);
        boolean isWriter = writerId == userId;

        if (isWriter && replyIdStr != null && !replyIdStr.trim().isEmpty() && replyContent != null && !replyContent.trim().isEmpty()) {
            int replyId = Integer.parseInt(replyIdStr);
            
            replyDAO.updateReply(replyId, replyContent);
            response.sendRedirect("boardDetail.jsp?postId=" + postId);
        } else {
            out.println("<script>alert('잘못된 요청입니다.'); history.back();</script>");
        }
    %>
</body>
</html>