<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	<!-- Main -->
	<main>
		<!-- contents section -->
		<section class="contents">
			<section class="profile">
				<img id="profile-image" src="../resources/images/profile.png" alt="profile" width="41" height="41">
				<article class="profile-contents">
				<!-- DB에서 가져올 예정 -->
					<h3 id="profile-nickname">백경이</h3>
					<h6 id="profile-date">2024.06.08. 18:00</h6>
				</article>
			</section>
			
			<section class="content-wrap">	
			<!-- DB에서 가져올 예정 -->	
				<h1 id="content-title">백경이의 부산 풀코스</h1>
				
				<article id="content">
					<pre>
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					</pre>
				</article>
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
				<form class="reply-form" action="" method="post" onsubmit="return confirmSubmission()">
					<h4 id="reply-write-title">댓글 추가</h4>
					<textarea id="reply-write-area" name="replyContent" rows="5" placeholder="댓글을 입력하세요"></textarea>
					<input type="submit" id="reply-write-button" value="추가하기"/>
				</form>
			</section>
			
			<ul class="reply-view-lists">
				<li class="reply-view-list">
					<section class="reply-view">
						<section class="reply-profile">
							<img id="reply-profile-image" src="../resources/images/profile.png" alt="reply-profile" width="41" height="41">
							<section class="reply-profile-contents-wrap">
								<article class="reply-profile-contents">
								<!-- DB에서 가져올 예정 -->
									<h3 id="reply-profile-nickname">백경이</h3>
									<h6 id="reply-profile-date">2024.06.08. 18:00</h6>
								</article>
								<article id="reply-view-more-button">
									<img src="../resources/images/kebab_menu_icon.png" alt="reply more button" width="19" height="19" />
								</article>
							</section>
						</section>
						
						<section class="reply-view-content">
						<!-- DB에서 가져올 예정 -->
							<article>
								댓글 내용
							</article>
						</section>
					</section>
				</li>
			</ul>
		</section>
	
	</main>
	
	<!-- Footer -->
	<jsp:include page="../common/footer.jsp"></jsp:include>
	
	<script type="text/javascript" src="../resources/js/boardDetail.js" defer></script>
</body>
</html>