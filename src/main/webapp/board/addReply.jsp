<%@ page import="java.util.*, java.sql.*, com.bfc.board.ReplyDTO, com.bfc.board.ReplyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="reply" class="com.bfc.board.ReplyDTO" scope="request" />
<jsp:useBean id="replyDAO" class="com.bfc.board.ReplyDAO" scope="request" />
<jsp:useBean id="userDAO" class="com.bfc.member.UserDAO" />
<jsp:useBean id="postDAO" class="com.bfc.board.PostDAO" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 추가</title>
</head>
<body>
	<%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            request.setCharacterEncoding("UTF-8");
            int postId = Integer.parseInt(request.getParameter("postId"));
            
            String content = request.getParameter("replyContent");
            if (content != null && !content.trim().isEmpty()) {
            	int userId = (Integer) session.getAttribute("userId");
                int writerId = userId;
                String writerNickname = userDAO.getUserInfo(userId).getNickname();
                reply.setPostId(postId);
                reply.setUserId(postDAO.getPostDetail(postId).getUserId());
                reply.setContent(content);
                reply.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                reply.setWriterId(writerId);
                reply.setWriterNickname(writerNickname);

                replyDAO.addReply(reply);

                // 추가된 후 상세페이지로 리다이렉트
                response.sendRedirect("boardDetail.jsp?postId=" + postId);
            } else {
                out.println("<script>alert('댓글 내용을 입력하세요.');history.back();</script>");
            }
        }
    %>
</body>
</html>