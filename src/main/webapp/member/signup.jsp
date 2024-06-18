<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="../resources/css/signup.css"> <!-- 회원가입 페이지에 맞는 CSS 파일 링크 -->
</head>
<body>
	<div class="background"></div>
	<div class="signup-container">
	    <h2>회원가입</h2>
	    <form action="../member/signupProcess.jsp" method="post">
	        <div class="form-group">
	            <input type="text" id="nickname" name="nickname" required placeholder="닉네임을 입력하세요">
	        </div>
	        <div class="form-group">
	            <input type="text" id="login" name="login" required placeholder="아이디를 입력하세요">
	        </div>
	        <div class="form-group">
	            <input type="password" id="password" name="password" required placeholder="비밀번호를 입력하세요">
	        </div>
	        <button type="submit">가입하기</button>
	    </form>
	    <p>이미 계정이 있으신가요? <a href="../member/login.jsp">로그인</a></p> <!-- 로그인 링크 추가 -->
	</div>
</body>
</html>
