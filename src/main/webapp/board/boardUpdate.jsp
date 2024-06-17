<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="com.bfc.board.PostDAO" %>
<%@ page import="com.bfc.board.PostDTO" %>
<%@ page import="com.bfc.board.ContentDTO" %>
<%@ page import="com.bfc.board.HashtagDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코스 수정  페이지</title>
</head>
<link rel="stylesheet" href="../resources/css/boardEdit.css">
<script type="text/javascript" src="../resources/js/boardUpdate.js" defer>
</script>
<script>
const callCacelConfirm = (type) => {
	if(confirm(`취소하시겠습니까?`)){
		window.location.href = "../main/main.jsp";
	}
};
</script>
<%!
	String tagString = "";
	int nameNumber = 0;
	int postId = 0;
%>
<body>

<%

if (session.getAttribute("user") == null || session.getAttribute("userId") == null) {
    response.sendRedirect("../member/login.jsp");
    return;
}

int userId = (Integer) session.getAttribute("userId");
	postId = Integer.parseInt(request.getParameter("postId"));
	
	postId = Integer.parseInt(request.getParameter("postId"));
	PostDAO postDAO = new PostDAO();
	PostDTO postDTO = postDAO.getPostDetail(postId);
%>
<jsp:include page="../common/header.jsp"></jsp:include>
    <div class="container">
        <form action="update.jsp?postId=<%=postId%>" method="post" enctype="multipart/form-data">
            <div id="inputFields">
                <div class="form-group">
                    <label for="title">제목:</label>
                    <input type="text" name="title" id="title" size="1" required value = "<%=postDTO.getTitle()%>">
                </div>
				<div class="form-form-group">
					<% for(ContentDTO contents : postDTO.getContents()) {
					%>
					<div id="fileFields">
						<div class="form-group">
							<label for="file0">파일 업로드:</label> <input type="file"
								name="file<%=nameNumber%>0" id="file0">
						</div>
						<div class="form-group">
							<label for="file0">파일 업로드:</label> <input type="file"
								name="file<%=nameNumber%>1" id="file0">
						</div>
						<div class="form-group">
							<label for="file0">파일 업로드:</label> <input type="file"
								name="file<%=nameNumber%>2" id="file0">
						</div>
					</div>
					<div class="form-group">
						<label for="title0">코스 제목:</label> <input type="text" name="title<%=nameNumber%>"
							id="title0" size="1" required value = "<%=contents.getContentTitle()%>">
					</div>
					<div class="form-group">
						<label for="location0">코스 위치:</label> <input type="text"
							name="location<%=nameNumber%>" id="location0" size="1" required value = "<%=contents.getLocation()%>">
					</div>
					<div class="form-group">
						<label for="content0">코스 소개:</label>
						<textarea name="content<%=nameNumber%>" id="content0" rows="15" cols="40"
							required style="resize: none;"><%=contents.getContent()%></textarea>
					</div>
					<%
						tagString = "";
						for (HashtagDTO tags : contents.getTags()) {
							tagString = tagString + tags.getTag() + " ";
						}
					%>
					<div class="form-group">
						<label for="tag0">태그:</label> <input type="text" name="tag<%=nameNumber%>"
							id="tag0" size="1" value = "<%=tagString%>" required>
					</div>
					<% nameNumber++;
					}%>
				</div>
            </div>
             <div class="center-align">
                <button type="button" id = "content-add-button" onclick="addFields()">+</button>
            </div>
            <%-- <input type="hidden" name="postId" id="postId" value="<%=postId%>"> --%>
            <input type="hidden" name="fc" id="fc" value="<%=nameNumber%>">
            <input type="hidden" name="nfc" id="nfc" value="-1">
            <div class="form-actions">
            	<input type="button" id = "content-cancel-button" value="취소" onclick ="callCacelConfirm('취소')">
                <input type="submit" id = "content-upload-button" value="수정">
            </div>
            
        </form>
    </div>
    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>