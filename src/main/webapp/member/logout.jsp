<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    session = request.getSession(false); // 세션이 없으면 새로 생성하지 않음

    if (session != null) {
        session.invalidate(); // 세션 무효화
    }

    // 로그아웃 후 메인 페이지로 리다이렉트
    response.sendRedirect("../index.jsp");
%>
