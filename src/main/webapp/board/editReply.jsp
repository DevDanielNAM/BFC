<%@ page import="java.util.*, java.sql.*, com.bfc.board.ReplyDTO, com.bfc.board.ReplyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
        String replyIdStr = request.getParameter("replyId");
        String replyContent = request.getParameter("replyContent");

        if (replyIdStr != null && !replyIdStr.trim().isEmpty() && replyContent != null && !replyContent.trim().isEmpty()) {
            int replyId = Integer.parseInt(replyIdStr);
            ReplyDAO replyDAO = new ReplyDAO();
            replyDAO.updateReply(replyId, replyContent);
            response.sendRedirect("boardDetail.jsp");
        } else {
            out.println("<script>alert('잘못된 요청입니다.'); history.back();</script>");
        }
    %>
</body>
</html>