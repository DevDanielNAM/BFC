<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="../resources/css/login.css"> <!-- 로그인 페이지에 맞는 CSS 파일 링크 -->
</head>
<body>		
	<div class="background"></div>
	
	<div class="login-container">
	    <h2><a href="../index.jsp">Busan Full Course</a></h2>
	    <%
	    	if(request.getParameter("postId") == null) {
	    %>
		    <form action="../member/loginProcess.jsp" method="post">
		        <div class="form-group">
		            <input type="text" id="login" name="login" required placeholder="아이디를 입력하세요">
		        </div>
		        <div class="form-group">
		            <input type="password" id="password" name="password" required placeholder="비밀번호를 입력하세요">
		        </div>
		        <button type="submit">로그인</button>
		    </form>
	    <% 
	    	} else {
	    		String postId = request.getParameter("postId");
	    %>
		    <form action="../member/loginProcess.jsp?postId=<%= postId %>" method="post">
		        <div class="form-group">
		            <label for="login">아이디:</label>
		            <input type="text" id="login" name="login" required>
		        </div>
		        <div class="form-group">
		            <label for="password">비밀번호:</label>
		            <input type="password" id="password" name="password" required>
		        </div>
		        <button type="submit">로그인</button>
		    </form>
	    <% } %>
	    
	    <% if (request.getParameter("error") != null && request.getParameter("error").equals("invalid")) { %>
	        <span style="color: red;">아이디 또는 비밀번호가 잘못되었습니다.</span>
	    <% } %>
	    
	    <p>계정이 없으신가요? <a href="../member/signup.jsp">회원가입</a></p> <!-- 회원가입 링크 추가 -->
	</div>
</body>
</html>
