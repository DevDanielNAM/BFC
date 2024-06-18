<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="com.bfc.board.PostDAO" %>
<%@ page import="com.bfc.board.SimplePostDTO" %>
<%@ page import="com.bfc.member.UserDAO" %>
<%@ page import="com.bfc.member.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.net.URLEncoder" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="../resources/css/mypage.css">
<link rel="stylesheet" href="../resources/css/header.css">
<link rel="stylesheet" href="../resources/css/footer.css">
<script type="text/javascript" src="../resources/js/mypage.js" defer></script>
</head>
<body>
    <%
        if (session.getAttribute("user") == null || session.getAttribute("userId") == null) {
            response.sendRedirect("../member/login.jsp");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        
        PostDAO postDAO = new PostDAO();
        List<SimplePostDTO> simplePosts = postDAO.getMyPosts(userId);
        UserDAO userDAO = new UserDAO();
        UserDTO userDTO = userDAO.getUserInfo(userId);
    %>
    <jsp:include page="../common/header.jsp"></jsp:include>
    <div class="container">
        <div class="sidebar">
            <img src="../resources/images/profile.png" alt="Profile Image">
            <ul>
                <li class="nickname"><%= userDTO.getNickname() %></li>
                <li class="button" onclick="callConfirm('수정')">정보 수정</li>
                <li class="out" onclick="callConfirm('탈퇴')">회원 탈퇴</li>
            </ul>
        </div>
        <div class="content">
            <h2 class="myContent">내가 작성한 글</h2>
            <div class="posts">
                <% for (SimplePostDTO post : simplePosts) { %>
                <div class="post" onclick="moveBoardDetail(<%= post.getPostId() %>)">
                    <img class="contentImg" src="../uploadImages/board<%= post.getPostId()%>/<%= URLEncoder.encode(post.getImage()) %>" width ="300px" height="200px" />
                    <br>
                    <%= post.getTitle() %>
                </div>
                <% } %>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>
