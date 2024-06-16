<%@page import="java.net.URLEncoder"%>
<%@ page import="java.util.*, java.sql.*, com.bfc.board.PostDTO, com.bfc.board.ContentDTO, com.bfc.member.UserDTO, com.bfc.board.HashtagDTO" %>
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
	<%
		int postId = Integer.parseInt(request.getParameter("postId"));
		String IMG_PATH = "../uploadImages/board" + postId;
		
		Map<String, List<String>> contentImagesTitlesLocations = postDAO.getContentImagesTitlesLocations(postId);
		List<String> contentIds = contentImagesTitlesLocations.get("contentIds");
		List<String> contents = contentImagesTitlesLocations.get("contents");
		List<String> contentTitles = contentImagesTitlesLocations.get("contentTitles");
		List<String> locations = contentImagesTitlesLocations.get("locations");
		List<String> images = contentImagesTitlesLocations.get("images");

		PostDTO postDetail = postDAO.getPostDetail(postId);
		UserDTO userInfo = userDAO.getUserInfo(postDetail.getUserId());
		List<ContentDTO> contentList = postDetail.getContents();
		ContentDTO content = contentList.get(0);
		
		int USER_ID = postDetail.getUserId();
		int contentId = contentList.get(0).getContentId();
	%>
	
	<!-- Main -->
	<main>
		<!-- contents section -->
		<section class="contents">
			<section class="profile">
				<img id="profile-image" src="../resources/images/profile.png" alt="profile" width="41" height="41">
				<article class="profile-contents">
					<h3 id="profile-nickname"><%= userInfo.getNickname() %></h3>
					<h6 id="profile-date"><%= postDetail.getCreatedAt().toString().substring(0, 19) %></h6>
				</article>
			</section>
			
			<section class="content-wrap">
				<h1 id="content-title"><%= postDetail.getTitle() %></h1>
				
				<article class="content">
					<ul class="course-lists">
						<% 
							int contentCount = postDAO.getContentCount(postId); 
							for(int i=0; i<contentCount; i++) {
						%>
							<li>
								<img src="<%= IMG_PATH %>/<%= URLEncoder.encode(images.get(i), "UTF-8") %>" />
								<h1 class="course-image-title"><%= contentTitles.get(i) %></h1>
							</li>
						<%
							}
						%>
					</ul>
					<div class="prev-button"></div>
					<div class="next-button"></div>					
				</article>
				<!-- 이미지를 클릭하면 i를 넘겨준다 -->
				<section class="course-detail">
					<section class="course-detail-title-wrap">
						<article class="course-detail-title">
							<h1 id="course-detail-title"><%= contentTitles.get(0) %></h1>
							<h4 id="course-detail-location"><%= locations.get(0) %></h4>
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
						<%= contents.get(0) %>
						</article>
					</section>
					
					<section class="course-detail-tags">
						<ul>
							<% 
								List<HashtagDTO> hashtagList = postDAO.getHashtags(Integer.parseInt(contentIds.get(0)));
								
								for(int i=0; i<hashtagList.size(); i++) {
							%>							
								<li>#<%= hashtagList.get(i).getTag() %></li>
							<%
								}
							%>
						</ul>
					</section>
				</section>
			</section>
			
			
			<%
				if (session.getAttribute("user") != null && (Integer)session.getAttribute("userId") == USER_ID) {
		    %>
				<section class="content-buttons">
					<input type="button" id="content-edit-button" value="수정하기" onclick="callConfirm('수정', <%= postId %>)" />
					<input type="button" id="content-delete-button" value="삭제하기" onclick="callConfirm('삭제', <%= postId %>)" />
				</section>		    
		    <%         
		        }
			%>
		</section>
		
		
		<hr>
		
		<!-- reply section -->
		<section class="reply">
			<!-- textarea 클릭 시 로그인 여부 확인 -->
			<section class="reply-write">
				<form class="reply-form" action="addReply.jsp?postId=<%= postId %>" method="POST" onsubmit="return confirmSubmission()">
					<h4 id="reply-write-title">댓글 추가</h4>
					<%
						if (session.getAttribute("user") == null || session.getAttribute("userId") == null) {
		    		%>
		    			<textarea id="reply-write-area" name="replyContent" rows="5" placeholder="로그인을 해주세요" onclick="showLoginAlert()" readonly></textarea>
		    		<%
						} else {
		    		%>
						<textarea id="reply-write-area" name="replyContent" rows="5" placeholder="댓글을 입력하세요"></textarea>
					<%
						}
					%>
					<input type="submit" id="reply-write-button" value="추가하기"/>
				</form>
			</section>
			
			<jsp:include page="replyList.jsp?postId=<%= postId %>" />
			
		</section>
	
	</main>
	
	<!-- Footer -->
	<jsp:include page="../common/footer.jsp"></jsp:include>
	
	<script type="text/javascript" src="../resources/js/boardDetail.js" defer></script>
</body>
</html>