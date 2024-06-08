<%@ page import="java.util.*, java.sql.*, com.bfc.board.ReplyDTO, com.bfc.board.ReplyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/boardDetail.css">
</head>
	<%
        ReplyDAO replyDAO = new ReplyDAO();
        List<ReplyDTO> replyList = replyDAO.getAllReplies();
	%>

    <ul class="reply-view-lists">
     	<%
     	for (int i = 0; i < replyList.size(); i++) {
            ReplyDTO reply = replyList.get(i);
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
								<li><a onclick="return confirm('댓글을 수정하시겠습니까?');">수정</a></li>
								<li><a href="deleteReply.jsp?replyId=<%= reply.getReplyId() %>" onclick="return confirm('댓글을 삭제하시겠습니까?');">삭제</a></li>
							</ul>
						</article>
					</section>
				</section>
				
				<section class="reply-view-content">
					<article>
						<%= reply.getContent() %>
					</article>
				</section>
			</section>
		</li>
		<%
            }
        %>
	</ul>
	<script type="text/javascript" src="../resources/js/boardDetail.js" defer></script>
</html>