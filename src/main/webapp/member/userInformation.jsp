<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		response.sendRedirect("../main/main.jsp");
	}
	else if (type.equals("탈퇴")){
		/* 탈퇴 로직 추가.  */
		response.sendRedirect("../main/main.jsp");
	}
	%>
</body>
</html>