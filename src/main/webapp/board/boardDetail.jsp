<%@page import="java.net.URLEncoder"%>
<%@ page import="java.util.*, java.sql.*, com.bfc.board.PostDTO, com.bfc.board.ContentDTO, com.bfc.member.UserDTO, com.bfc.board.HashtagDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="postDAO" class="com.bfc.board.PostDAO" scope="page" />
<jsp:useBean id="userDAO" class="com.bfc.member.UserDAO" scope="page" />
<!DOCTYPE html>
<html>
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
		
        boolean isLoggedIn = session.getAttribute("user") != null && session.getAttribute("userId") != null;
	%>
<head>
<meta charset="UTF-8">
<title>Busan Full Course - <%= userInfo.getNickname() %>의 <%= postDetail.getTitle() %></title>
<link rel="stylesheet" href="../resources/css/boardDetail.css">
</head>
<body>
	<!-- Header -->
	<jsp:include page="../common/header.jsp"></jsp:include>
	
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
							<li onclick="showCourseDetail(this)">
								<img src="<%= IMG_PATH %>/<%= URLEncoder.encode(images.get(i), "UTF-8") %>" />
								<h1 class="course-image-title"><%= contentTitles.get(i) %></h1>
								<div class="course-info" 
						             data-title="<%= contentTitles.get(i) %>" 
						             data-location="<%= locations.get(i) %>"
						             data-image="<%= IMG_PATH %>/<%= URLEncoder.encode(images.get(i), "UTF-8") %>"
						             data-content="<%= contents.get(i) %>"
						             data-content-id="<%= contentIds.get(i) %>">
						        </div>
							</li>
						<%
							}
						%>
					</ul>
					<div class="prev-button"></div>
					<div class="next-button"></div>					
				</article>
				
				<!-- course detail -->
				<section class="course-detail">
					<section class="course-detail-title-wrap">
						<article class="course-detail-title">
							<h1 id="course-detail-title"><%= contentTitles.get(0) %></h1>
							<h4 id="course-detail-location"><%= locations.get(0) %></h4>
						</article>
					</section>
					
					<section class="course-detail-image-wrap">
						<article class="course-detail-image">
							<img id="course-detail-image" src="<%= IMG_PATH %>/<%= URLEncoder.encode(images.get(0), "UTF-8") %>" />
						</article>
					</section>
					
					<section class="course-detail-content">
						<article id="course-detail-content">
						<%= contents.get(0) %>
						</article>
					</section>
					
					<section class="course-detail-tags">
						<ul id="course-detail-tags">
                            <% 
                                List<HashtagDTO> hashtagList = postDAO.getHashtags(Integer.parseInt(contentIds.get(0)));
                                for (HashtagDTO hashtag : hashtagList) {
                            %>
                            		<li>#<%= hashtag.getTag() %></li>
                            <% 
                                }
                            %>
                        </ul>
					</section>
				</section>
			</section>
			
			<!-- content buttons -->
			<%
				if (isLoggedIn) {
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
			<section class="reply-write">
				<%
					if (!isLoggedIn) {
				%>
		    		<article class="reply-form disable">
		    			<h4 id="reply-write-title">댓글 추가</h4>	
		    			<a id="disable-reply-box">댓글을 작성하시려면 로그인을 해주세요.</a>
		    			<input type="button" id="reply-write-button" value="추가하기" disabled />	    		
		    		</article>
	    		<%
					} else {
				%>
					<form class="reply-form" action="addReply.jsp?postId=<%= postId %>" method="POST" onsubmit="return confirmSubmission()">
						<h4 id="reply-write-title">댓글 추가</h4>					
						<textarea id="reply-write-area" name="replyContent" rows="5" placeholder="댓글을 입력하세요"></textarea>
						<input type="submit" id="reply-write-button" value="추가하기" />
					</form>
				<% 
					} 
				%>
			</section>
			
			<jsp:include page="replyList.jsp?postId=<%= postId %>" />
			
		</section>
	
	</main>
	
	<!-- Footer -->
	<jsp:include page="../common/footer.jsp"></jsp:include>
	
	<script type="text/javascript" src="../resources/js/boardDetail.js" defer></script>
</body>
</html>