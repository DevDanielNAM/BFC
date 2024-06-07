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
		
		
	
	</main>
	
	<!-- Footer -->
	<jsp:include page="../common/footer.jsp"></jsp:include>
	
	<script type="text/javascript" src="../resources/js/boardDetail.js" defer></script>
</body>
</html>