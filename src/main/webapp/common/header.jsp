<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bfc.member.UserDTO" %>
<% session = request.getSession(false); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BusanFullCourse</title>
    <link rel="stylesheet" href="../resources/css/header.css">
</head>
<body>
    <header class="header">
        <div class="container">
           <div class="site-name">
                  <h1><a href="../main/main.jsp">BusanFullCourse</a></h1>
            </div>
           <div class="login-button">
            <% if (session != null && session.getAttribute("user") != null) {
                // 세션이 있고 로그인 되어있는 경우
                UserDTO user = (UserDTO) session.getAttribute("user");
            %>
                <form action="../member/logout.jsp" method="post" id="logoutForm">
                    <input type="hidden" name="logout" value="true">
                    <a href="javascript:{}" onclick="document.getElementById('logoutForm').submit();">로그아웃</a>
                </form>
            <% } else {
                // 세션이 없거나 로그인 되어있지 않은 경우
            %>
                <a href="../member/login.jsp">로그인</a>
            <% } %>
        </div>
        </div>
    </header>
</body>
</html>
