<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.bfc.member.UserDAO" %>
<%@ page import="com.bfc.member.UserDTO" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<%
int userId = 1; /* 세션에서 로그인 아이디 구해야함 */
String nickname = request.getParameter("nickname");
String password = request.getParameter("pw");

// UserDTO 객체 생성 및 수정
UserDTO userDTO = new UserDTO();
userDTO.setUserId(userId);
userDTO.setNickname(nickname);
userDTO.setPassword(password);

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