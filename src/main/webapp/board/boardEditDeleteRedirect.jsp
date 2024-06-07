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
		out.println(type);
	   /*  response.sendRedirect("boardEdit.jsp"); */
	} else if(type.equals("삭제")) {
		out.println(type);
	}
	%>
</body>
</html>