<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코스 작성 페이지</title>
</head>
<link rel="stylesheet" href="../resources/css/boardEdit.css">
<script type="text/javascript" src="../resources/js/boardEdit.js" defer>
</script>
<script>
const callCacelConfirm = (type) => {
	if(confirm(`취소하시겠습니까?`)){
		window.location.href = "../index.jsp";
	}
};
</script>
<body>
<% 
if (session.getAttribute("user") == null || session.getAttribute("userId") == null) {
            response.sendRedirect("../member/login.jsp");
            return;
        }
%>
        
        
<jsp:include page="../common/header.jsp"></jsp:include>
    <div class="container">
        <form action="upload.jsp" method="post" enctype="multipart/form-data">
            <div id="inputFields">
                <div class="form-group">
                    <label for="title">제목:</label>
                    <input type="text" name="title" id="title" size="1" required>
                </div>
				<div class="form-form-group">
					<div id="fileFields">
						<div class="form-group">
							<label for="file0">파일 업로드:</label> <input type="file"
								name="file00" id="file0">
						</div>
						<div class="form-group">
							<label for="file0">파일 업로드:</label> <input type="file"
								name="file01" id="file0">
						</div>
						<div class="form-group">
							<label for="file0">파일 업로드:</label> <input type="file"
								name="file02" id="file0">
						</div>
					</div>
					<div class="form-group">
						<label for="title0">코스 제목:</label> <input type="text" name="title0"
							id="title0" size="1" required>
					</div>
					<div class="form-group">
						<label for="location0">코스 위치:</label> <input type="text"
							name="location0" id="location0" size="1" required>
					</div>
					<div class="form-group">
						<label for="content0">코스 소개:</label>
						<textarea name="content0" id="content0" rows="15" cols="40"
							required style="resize: none;"></textarea>
					</div>
					<div class="form-group">
						<label for="tag0">태그:</label> <input type="text" name="tag0"
							id="tag0" size="1" placeholder="각 태그들은 띄어쓰기로 구분됩니다." required>
					</div>
				</div>
            </div>
            <div class="center-align">
                <button type="button" id = "content-add-button" onclick="addFields()">+</button>
            </div>
            <input type="hidden" name="fc" id="fc" value="0">
            <div class="form-actions">
            	<input type="button" id = "content-cancel-button" value="취소" onclick ="callCacelConfirm('취소')">
                <input type="submit" id = "content-upload-button" value="업로드">
            </div>
            
        </form>
    </div>
    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>