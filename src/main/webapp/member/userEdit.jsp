<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.bfc.member.UserDAO" %>
<%@ page import="com.bfc.member.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 정보 수정 페이지</title>
</head>
<link rel="stylesheet" href="../resources/css/userEdit.css">
<link rel="stylesheet" href="../resources/css/header.css">
<link rel="stylesheet" href="../resources/css/footer.css">
<script type="text/javascript" src="../resources/js/userEdit.js" defer></script>
<script>
const callCacelConfirm = (type) => {
	if(confirm(`취소하시겠습니까?`)){
		window.location.href = "mypage.jsp";
	}
};
</script>
<body>
	<%
	if (session.getAttribute("user") == null || session.getAttribute("userId") == null) {
        response.sendRedirect("../member/login.jsp");
        return;
    }
    
    int userId = (Integer) session.getAttribute("userId");
    
	 	UserDAO userDAO = new UserDAO();
        UserDTO userDTO = userDAO.getUserInfo(userId);
	%>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container">
	<h2>유저 정보 수정</h2>
	<img src="https://mblogthumb-phinf.pstatic.net/MjAyMDExMDFfODMg/MDAxNjA0MjI4ODc1MDgz.gQ3xcHrLXaZyxcFAoEcdB7tJWuRs7fKgOxQwPvsTsrUg.0OBtKHq2r3smX5guFQtnT7EDwjzksz5Js0wCV4zjfpcg.JPEG.gambasg/%EC%9C%A0%ED%8A%9C%EB%B8%8C_%EA%B8%B0%EB%B3%B8%ED%94%84%EB%A1%9C%ED%95%84_%EB%B3%B4%EB%9D%BC.jpg?type=w400" alt="Profile Image">
        <form action="UserUpload.jsp" method="post">
            <div id="inputFields">
				<div class="form-group">
					<label for="title">닉네임:</label> <input type="text" name="nickname"
						id="nickname" size="1" value = "<%=userDTO.getNickname()%>" required>
				</div>
				<div class="form-group">
					<label for="title">아이디:</label> <input type="text" name="id"
						id="id" size="1" value = "<%=userDTO.getLogin()%>" required disabled>
				</div>
				<div class="form-group">
					<label for="title">비밀번호:</label> <input type="password" name="pw"
						id="pw" size="1" value = "<%=userDTO.getPassword()%>" required>
				</div>
			</div>
            <div class="form-actions">
            	<input type="button" id = "content-cancel-button" value="취소" onclick ="callCacelConfirm('취소')">
                <input type="submit" id = "content-upload-button" value="수정">
            </div>
        </form>
    </div>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>