<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="../resources/css/signup.css"> <!-- 회원가입 페이지에 맞는 CSS 파일 링크 -->
</head>
<body>
<!-- Header -->
<jsp:include page="../common/header.jsp"></jsp:include>

<!-- Site Introduction Banner -->
<section class="site-banner">
    <h2>부산 풀코스에 오신 것을 환영합니다!</h2>
    <p>다양한 여행지를 탐색하고, 각 여행지에 대한 코스 확인할 수 있습니다.</p>
</section>
<div class="signup-container">
    <h2>회원가입</h2>
    <form action="../member/signupProcess.jsp" method="post">
        <div class="form-group">
            <label for="nickname">닉네임:</label>
            <input type="text" id="nickname" name="nickname" required>
        </div>
        <div class="form-group">
            <label for="login">아이디:</label>
            <input type="text" id="login" name="login" required>
        </div>
        <div class="form-group">
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">가입하기</button>
    </form>
    <p>이미 계정이 있으신가요? <a href="../member/login.jsp">로그인</a></p> <!-- 로그인 링크 추가 -->
</div>
</body>
</html>
