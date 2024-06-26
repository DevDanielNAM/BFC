<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.bfc.member.UserDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="userDTO" class="com.bfc.member.UserDTO" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원정보 수정</title>
</head>
<body>
<%
	if (session.getAttribute("user") == null || session.getAttribute("userId") == null) {
	    response.sendRedirect("../member/login.jsp");
	    return;
	}
	
	int userId = (Integer) session.getAttribute("userId");
	String nickname = request.getParameter("nickname");
	String password = request.getParameter("pw");
%>

	<!-- UserDTO 객체 생성 및 수정 -->
	<jsp:setProperty name="userDTO" property="userId" value="<%= userId %>" />
	<jsp:setProperty name="userDTO" property="nickname" value="<%= nickname %>" />
	<jsp:setProperty name="userDTO" property="password" value="<%= password %>" />

<%
// UserDAO를 사용하여 DB에 저장
	UserDAO userDAO = new UserDAO();
	boolean success = userDAO.updateUserInfo(userDTO);
	
	// 성공 여부에 따라 결과 출력
	if (success) {
		out.println("<script type='text/javascript'>");
		out.println("alert('유저 정보가 수정되었습니다.');");
		out.println("window.location.href = 'mypage.jsp';");
		out.println("</script>");
	} else {
		out.println("정보 업데이트에 실패했습니다.");
	}
%>

</body>
</html>