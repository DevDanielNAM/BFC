<%@ page import="java.util.*, java.sql.*, com.bfc.board.PostDTO, com.bfc.board.ContentDTO, com.bfc.member.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="postDAO" class="com.bfc.board.PostDAO" scope="page" />
<jsp:useBean id="userDAO" class="com.bfc.member.UserDAO" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Busan Full Course</title>
<link rel="stylesheet" href="../resources/css/boardDetail.css">
</head>
<body>
	<!-- Header -->
	<jsp:include page="../common/header.jsp"></jsp:include>
	
	<%-- <%
		PostDTO postDetail = postDAO.getPostDetail(34);
		UserDTO userInfo = userDAO.getUserInfo(postDetail.getUserId());
		List<ContentDTO> contentList = postDetail.getContents();
		ContentDTO content = contentList.get(0);
	%> --%>
	
	<!-- Main -->
	<main>
		<!-- contents section -->
		<section class="contents">
			<section class="profile">
				<img id="profile-image" src="../resources/images/profile.png" alt="profile" width="41" height="41">
				<article class="profile-contents">
					<h3 id="profile-nickname">백경이</h3>
					<h6 id="profile-date">2024.06.08. 18:00</h6>
					<%-- <h3 id="profile-nickname"><%= userInfo.getNickname() %></h3>
					<h6 id="profile-date"><%= postDetail.getCreatedAt().toString().substring(0, 19) %></h6> --%>
				</article>
			</section>
			
			<section class="content-wrap">
				<h1 id="content-title">백경이의 부산 풀코스</h1>
				<%-- <h1 id="content-title"><%= postDetail.getTitle() %></h1> --%>
				
				<article class="content">
					<ul class="course-lists">
						<li>
							<img src="../uploadImages/board1/img01.jpeg" />
							<h1 class="course-image-title">img 1</h1>
						</li>
						<li>
							<img src="../uploadImages/board1/img02.jpeg" />
							<h1 class="course-image-title">img 2</h1>
						</li>
						<li>
							<img src="../uploadImages/board1/img03.jpeg" />
							<h1 class="course-image-title">img 3</h1>
						</li>
						<li>
							<img src="../uploadImages/board1/img04.jpeg" />
							<h1 class="course-image-title">img 4</h1>
						</li>
					</ul>
					<div class="prev-button"></div>
					<div class="next-button"></div>					
				</article>
				
				<section class="course-detail">
					<section class="course-detail-title-wrap">
						<article class="course-detail-title">
							<h1 id="course-detail-title">코스별 제목</h1>
							<h4 id="course-detail-location">코스 위치</h4>
							<%-- <h1 id="course-detail-title"><%= content.getContentTitle() %></h1>
							<h4 id="course-detail-location"><%= content.getContentLocation() %></h4> --%>
						</article>
					</section>
					
					<section class="course-detail-image-wrap">
						<article class="course-detail-image">
							<img src="../uploadImages/board1/img01.jpeg" />
						</article>
						<article class="course-detail-image">
							<img src="../uploadImages/board1/img02.jpeg" />
						</article>
						<article class="course-detail-image">
							<img src="../uploadImages/board1/img03.jpeg" />
						</article>
					</section>
					
					<section class="course-detail-content">
						<article>
						<%-- <%= content.getContent() %> --%>
						여기는 코스별 내용을 입력하는 곳입니다!
						여기는 코스별 내용을 입력하는 곳입니다!
						여기는 코스별 내용을 입력하는 곳입니다!
						여기는 코스별 내용을 입력하는 곳입니다!
						여기는 코스별 내용을 입력하는 곳입니다!
						여기는 코스별 내용을 입력하는 곳입니다!
						여기는 코스별 내용을 입력하는 곳입니다!
						여기는 코스별 내용을 입력하는 곳입니다!
						여기는 코스별 내용을 입력하는 곳입니다!
						</article>
					</section>
					
					<section class="course-detail-tags">
						<ul>
							<li>#이기대</li>
							<li>#영화의전당</li>
							<li>#오륙도</li>
							<li>#신세계센텀시티</li>
						</ul>
					</section>
				</section>
			</section>
			
			<section class="content-buttons">
				<input type="button" id="content-edit-button" value="수정하기" onclick="callConfirm('수정')" />
				<input type="button" id="content-delete-button" value="삭제하기" onclick="callConfirm('삭제')" />
			</section>
		</section>
		
		
		<hr>
		
		<!-- reply section -->
		<section class="reply">
			<section class="reply-write">
				<form class="reply-form" action="addReply.jsp" method="POST" onsubmit="return confirmSubmission()">
					<h4 id="reply-write-title">댓글 추가</h4>
					<textarea id="reply-write-area" name="replyContent" rows="5" placeholder="댓글을 입력하세요"></textarea>
					<input type="submit" id="reply-write-button" value="추가하기"/>
				</form>
			</section>
			
			<jsp:include page="replyList.jsp" />
			
		</section>
	
	</main>
	
	<!-- Footer -->
	<jsp:include page="../common/footer.jsp"></jsp:include>
	
	<script type="text/javascript" src="../resources/js/boardDetail.js" defer></script>
</body>
</html>