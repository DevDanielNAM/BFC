<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.bfc.member.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
	String type = request.getParameter("type");
	if (type.equals("수정")) {
	    response.sendRedirect("userEdit.jsp");
	} 
	else if (type.equals("로그아웃")){
		/* 로그아웃 로직 추가.  */
		response.sendRedirect("$../index.jsp");
	}
	else if (type.equals("탈퇴")){
		if (session.getAttribute("user") == null || session.getAttribute("userId") == null) {
            response.sendRedirect("../member/login.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");
        
        if (session != null) {
            session.invalidate(); // 세션 무효화
        }
        
		UserDAO userDAO = new UserDAO();
		userDAO.deleteUser(userId);
		/* 탈퇴 로직 추가.  */
		response.sendRedirect("../index.jsp");
	}
	%>
</body>
</html>