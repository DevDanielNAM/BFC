<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bfc.member.UserDTO" %>
<% session = request.getSession(false); %>
<!DOCTYPE html>
<html>
<body>
    <header class="header" >

	    <div class="site-name">
	          <a href="${pageContext.request.contextPath}/index.jsp"></a>
	    </div>
            
        <div class="login-button">
        <% if (session != null && session.getAttribute("user") != null) {
            // 세션이 있고 로그인 되어있는 경우
            UserDTO user = (UserDTO) session.getAttribute("user");
        %>
            <form action="${pageContext.request.contextPath}/member/logout.jsp" method="post" id="logoutForm">
                <input type="hidden" name="logout" value="true">
                <input id="current-url" type="hidden" name="currentURL" value="../index.jsp">
                <a href="javascript:{}" onclick="document.getElementById('logoutForm').submit();">로그아웃</a>
            </form>
        <% } else { // 세션이 없거나 로그인 되어있지 않은 경우
            // 현재 페이지에 쿼리스트링 존재여부에 따른 로그
            if(request.getQueryString() == null){
        %>
            	<a href="${pageContext.request.contextPath}/member/login.jsp">로그인</a>
            <% } else {
            	String queryString = request.getQueryString();
           	 %>
            	<a href="${pageContext.request.contextPath}/member/login.jsp?<%= queryString %>">로그인</a>
           	<% } %>
        <% } %>
        </div>
    </header>
    <script>
	    window.onload = function() {
	        const currentURL = document.getElementById('current-url');
	        if (currentURL) {
	            currentURL.setAttribute('value', window.location.href);
	        } else {
	            console.error('Element with id "current-url" not found.');
	        }
	    };
    </script>    
</body>
</html>
