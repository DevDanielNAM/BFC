<%@ page import="java.util.*, java.sql.*, com.bfc.board.ReplyDTO, com.bfc.board.ReplyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="replyDAO" class="com.bfc.board.ReplyDAO" scope="page" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/boardDetail.css">
</head>
	<%
		int postId = Integer.parseInt(request.getParameter("postId"));
		List<ReplyDTO> replyList = replyDAO.getAllReplies(postId);
		int userId = (Integer) (session.getAttribute("userId") != null? session.getAttribute("userId"): -1);
	%>

    <ul class="reply-view-lists">
     	<%
     	for (int i = 0; i < replyList.size(); i++) {
     		ReplyDTO reply = replyList.get(i);
     		int writerId = reply.getWriterId();							        
	        boolean isWriter = writerId == userId;
        %>
		<li class="reply-view-list">
			<section class="reply-view">
				<section class="reply-profile">
					<img id="reply-profile-image" src="../resources/images/profile.png" alt="reply-profile" width="41" height="41">
					<section class="reply-profile-contents-wrap">
						<article class="reply-profile-contents">
							<h3 id="reply-profile-nickname"><%= reply.getWriterNickname() %></h3>
							<h6 id="reply-profile-date"><%= reply.getCreatedAt().toString().substring(0, 19) %></h6>
						</article>
						<article class="reply-view-more-button">
							<img id="reply-more-button-<%= i %>" class="reply-more-button" src="../resources/images/kebab_menu_icon.png" alt="reply more button" width="19" height="19" />									
							<ul id="reply-view-more-button-lists-<%= i %>" class="reply-view-more-button-lists">
								<%
							        if(isWriter) {
								%>
									<li><a class="edit-reply" data-content="<%= reply.getContent() %>" data-index="<%= i %>">수정</a></li>
									<li><a href="deleteReply.jsp?postId=<%= postId %>&writerId=<%= reply.getWriterId() %>&replyId=<%= reply.getReplyId() %>" onclick="return confirm('댓글을 삭제하시겠습니까?');">삭제</a></li>
								<%
							        } else {
								%>
									<li><a class="edit-reply" data-content="<%= reply.getContent() %>" data-index="<%= i %>">수정</a></li>
									<li><a>삭제</a></li>
								<%
							        }
								%>
							</ul>
						</article>
					</section>
				</section>
				
				<section class="reply-view-content">
					<article id="reply-content-<%= i %>">
						<%= reply.getContent() %>
					</article>
					<form class="edit-reply-form" id="edit-reply-form-<%= i %>" action="editReply.jsp?postId=<%= postId %>" method="post" style="display:none;">
	                    <input type="hidden" name="writerId" value="<%= reply.getWriterId() %>">
	                    <input type="hidden" name="replyId" value="<%= reply.getReplyId() %>">
	                    <textarea name="replyContent" rows="3"><%= reply.getContent() %></textarea>
	                    <input type="submit" value="수정하기" onclick="return confirm('댓글을 수정하시겠습니까?');">
	                    <input type="button" class="cancel-edit" data-index="<%= i %>" value="취소하기">
                	</form>
				</section>
			</section>
		</li>
		<%
            }
        %>
	</ul>
	<script type="text/javascript" src="../resources/js/boardDetail.js" defer></script>
</html>