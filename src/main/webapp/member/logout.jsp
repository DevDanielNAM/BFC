<%@page import="java.awt.SystemTray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    session = request.getSession(false); // 세션이 없으면 새로 생성하지 않음
	
    if (session != null) {
        session.invalidate(); // 세션 무효화
    }
    
    String currentURL = request.getParameter("currentURL");
    // 로그아웃 후 전달받은 페이지에 따라 리다이렉트
    if(currentURL.contains("boardEdit.jsp")){
    	response.sendRedirect("../index.jsp");
    } else {
    	response.sendRedirect(currentURL);
    }
%>
