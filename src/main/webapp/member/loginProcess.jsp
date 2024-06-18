<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bfc.member.UserDAO" %>
<%@ page import="com.bfc.member.UserDTO" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인 처리</title>
</head>
<body>
<%
	// 폼에서 전송된 데이터 받기
	String login = request.getParameter("login");
	String password = request.getParameter("password");
	
	// DAO 객체 생성
	UserDAO userDAO = new UserDAO();
	
	// 로그인 검증
	UserDTO user = userDAO.validateUser(login, password);
	if (user != null) {
	    // 로그인 성공 시 세션에 사용자 정보 저장
	    session = request.getSession();
	    session.setAttribute("user", user);
	    session.setAttribute("userId", user.getUserId());
	    session.setAttribute("loginStatus", "loggedIn");
	    session.setAttribute("userNickname", user.getNickname());
	    
	    // 로그인 성공 메시지
	    out.println("<script>");
		    out.println("alert('로그인에 성공했습니다.');");
		    if(request.getParameter("postId") == null) {
		    	out.println("location.href='../index.jsp';");
		    } else{
		    	String postId = request.getParameter("postId");
		    	out.println("location.href='../board/boardDetail.jsp?postId=" + postId + "';");
		    }
	    out.println("</script>");
	} else {
	    // 로그인 실패 시 처리
	    response.sendRedirect("../member/login.jsp?error=invalid");
	}
%>
</body>
</html>
