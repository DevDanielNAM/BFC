<%@ page import="java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="replyDAO" class="com.bfc.board.ReplyDAO" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 삭제</title>
</head>
<body>
	<%
		String postId = request.getParameter("postId");
		String replyIdStr = request.getParameter("replyId");
		int writerId = Integer.parseInt(request.getParameter("writerId"));
        int userId = (Integer) (session.getAttribute("userId") != null? session.getAttribute("userId"): -1);
        boolean isWriter = writerId == userId;
		
	    if (isWriter && replyIdStr != null && !replyIdStr.trim().isEmpty()) {
	        int replyId = Integer.parseInt(replyIdStr);
	        replyDAO.deleteReply(replyId);
	        response.sendRedirect("boardDetail.jsp?postId=" + postId);
	    } else {
	        out.println("<script>alert('잘못된 요청입니다.'); history.back();</script>");
	    }
    %>
</body>
</html>