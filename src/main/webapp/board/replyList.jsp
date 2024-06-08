<%@ page import="java.util.*, java.sql.*, com.bfc.board.ReplyDTO, com.bfc.board.ReplyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<%
        ReplyDAO replyDAO = new ReplyDAO();
        List<ReplyDTO> replyList = replyDAO.getAllReplies();
	%>

    <ul class="reply-view-lists">
     	<%
            for (ReplyDTO reply : replyList) {
        %>
		<li class="reply-view-list">
			<section class="reply-view">
				<section class="reply-profile">
					<img id="reply-profile-image" src="../resources/images/profile.png" alt="reply-profile" width="41" height="41">
					<section class="reply-profile-contents-wrap">
						<article class="reply-profile-contents">
						<!-- DB에서 가져올 예정 -->
							<h3 id="reply-profile-nickname"><%= reply.getWriterNickname() %></h3>
							<h6 id="reply-profile-date"><%= reply.getCreatedAt().toString().substring(0, 19) %></h6>
						</article>
						<article class="reply-view-more-button">
							<img id="reply-more-button" src="../resources/images/kebab_menu_icon.png" alt="reply more button" width="19" height="19" />									
							<ul id="reply-view-more-button-lists">
								<li>수정</li>
								<li>삭제</li>
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
</html>