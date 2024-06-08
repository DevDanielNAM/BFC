<%@ page import="java.util.*, java.sql.*, com.bfc.board.ReplyDTO, com.bfc.board.ReplyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 삭제</title>
</head>
<body>
	<%
		String replyIdStr = request.getParameter("replyId");
	    if (replyIdStr != null && !replyIdStr.trim().isEmpty()) {
	        int replyId = Integer.parseInt(replyIdStr);
	        ReplyDAO replyDAO = new ReplyDAO();
	        replyDAO.deleteReply(replyId);
	        response.sendRedirect("boardDetail.jsp");
	    } else {
	        out.println("<script>alert('잘못된 요청입니다.'); history.back();</script>");
	    }
    %>
</body>
</html>