<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="com.bfc.board.PostDAO" %>
<%@ page import="com.bfc.board.SimplePostDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행지 소개 메인 페이지</title>
<link rel="stylesheet" href="../resources/css/main.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="../common/header.jsp"></jsp:include>

    <!-- Site Introduction Banner -->
    <section class="site-banner">
        <h2>부산 풀코스에 오신 것을 환영합니다!</h2>
        <p>다양한 여행지를 탐색하고, 각 여행지에 대한 코스 확인할 수 있습니다.</p>
    </section>

    <!-- Search -->
    <section class="search-bar">
        <form action="main.jsp" method="get">
            <input type="text" name="query" placeholder="여행지를 검색하세요...">
            <button type="submit">검색</button>
        </form>
    </section>

    <!-- Main -->
    <main>
        <!-- contents section -->
        <section class="contents">
            <h1>여행지 소개</h1>
            <div class="posts">
                <%
                    int pageSize = 6; // 한 페이지에 보여줄 포스트 개수
                    int currentPage = 1; // 기본적으로 첫 번째 페이지를 보여줍니다.

                    // 페이지 파라미터가 있을 경우 해당 페이지로 설정합니다.
                    String pageParam = request.getParameter("page");
                    if (pageParam != null && !pageParam.isEmpty()) {
                        currentPage = Integer.parseInt(pageParam);
                    }

                    PostDAO postDAO = new PostDAO();
                    List<SimplePostDTO> allPosts;
                    String query = request.getParameter("query");

                    // 검색어가 있을 경우 해당 키워드를 포함하는 포스트만 가져옵니다.
                    if (query != null && !query.trim().isEmpty()) {
                        allPosts = postDAO.searchPosts(query);
                    } else {
                        allPosts = postDAO.getAllPosts(); // 검색어가 없을 경우 전체 포스트 가져오기
                    }

                    int totalPosts = allPosts.size();
                    int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

                    // 시작 인덱스와 끝 인덱스 계산
                    int startIndex = (currentPage - 1) * pageSize;
                    int endIndex = Math.min(startIndex + pageSize, totalPosts);

                    List<SimplePostDTO> postsOnPage = allPosts.subList(startIndex, endIndex);
                    for (SimplePostDTO post : postsOnPage) {
                %>
                <div class="post" onclick="moveBoardDetail(<%= post.getPostId() %>)">
                    <img class="contentImg" src="../resources/images/<%= post.getImage() %>" width="100%" />
                    <br>
                    <%= post.getTitle() %>
                </div>
                <%
                    } 
                %>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <%
                    // 페이지 링크 출력
                    for (int i = 1; i <= totalPages; i++) {
                        // 검색어(query)가 있을 때와 없을 때의 링크 구성
                        if (query != null && !query.trim().isEmpty()) {
                %>
                <a href="main.jsp?page=<%= i %>&query=<%= query %>" <%= (i == currentPage) ? "style='font-weight: bold;'" : "" %>><%= i %></a>
                <%
                        } else {
                %>
                <a href="main.jsp?page=<%= i %>" <%= (i == currentPage) ? "style='font-weight: bold;'" : "" %>><%= i %></a>
                <%
                        }
                    }
                %>
            </div>
        </section>
    </main>

    <!-- 여행지 등록 버튼 -->
    <div class="registration-button">
        <button type="button" onclick="location.href='../board/boardEdit.jsp'">여행지 등록</button>
    </div>
    
    <!-- 마이페이지 버튼 -->
    <div class="mypage-button">
        <button type="button" onclick="location.href='../member/mypage.jsp'">마이페이지</button>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <script type="text/javascript" src="../resources/js/boardMain.js" defer></script>
</body>
</html>
