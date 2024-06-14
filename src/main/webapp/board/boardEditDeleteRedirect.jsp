<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="postDAO" class="com.bfc.board.PostDAO" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
	String type = request.getParameter("type");
	String postId = request.getParameter("postId");
	
	if (type.equals("수정")) {
		response.sendRedirect("boardUpdate.jsp?postId=" + postId);
	} else if(type.equals("삭제")) {
		postDAO.deletePostByPostId(Integer.parseInt(postId));
		response.sendRedirect("../main/main.jsp");
	}
	%>
</body>
</html>