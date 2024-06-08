<%@ page import="java.util.*, java.sql.*, com.bfc.board.ReplyDTO, com.bfc.board.ReplyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            request.setCharacterEncoding("UTF-8");
            
            String content = request.getParameter("replyContent");
            if (content != null && !content.trim().isEmpty()) {
            	// 일단은 하드코딩
                int writerId = 1;
                String writerNickname = "nickname";

                ReplyDTO reply = new ReplyDTO();
                reply.setContent(content);
                reply.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                reply.setWriterId(writerId);
                reply.setWriterNickname(writerNickname);

                ReplyDAO replyDAO = new ReplyDAO();
                replyDAO.addReply(reply);

                // 추가된 후 상세페이지로 리다이렉트
                response.sendRedirect("boardDetail.jsp");
            } else {
                out.println("<script>alert('댓글 내용을 입력하세요.');history.back();</script>");
            }
        }
    %>
</body>
</html>