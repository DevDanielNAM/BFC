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
				
				<article class="content">
					<ul class="course-lists">
						<li>
							<img src="../uploadImages/board1/img01.jpeg" />
						</li>
						<li>
							<img src="../uploadImages/board1/img02.jpeg" />
						</li>
						<li>
							<img src="../uploadImages/board1/img03.jpeg" />
						</li>
						<li>
							<img src="../uploadImages/board1/img04.jpeg" />
						</li>
					</ul>					
				</article>
				
				<section class="course-detail">
					<section class="course-detail-title-wrap">
						<article class="course-detail-title">
							<h1 id="course-detail-title">title</h1>
							<h4 id="course-detail-location">location</h4>
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
						contentcontentcontentcontentcontentcontentcontentcontent
						contentcontentcontentcontentcontentcontentcontentcontent
						contentcontentcontentcontentcontentcontentcontentcontent
						</article>
					</section>
					
					<section class="course-detail-tags">
						<ul>
							<li>#tag</li>
							<li>#tag</li>
							<li>#tag</li>
							<li>#tag</li>
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