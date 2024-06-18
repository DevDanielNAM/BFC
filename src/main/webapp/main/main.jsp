<%@ page import="java.util.*, java.sql.*, java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="com.bfc.board.PostDAO" %>
<%@ page import="com.bfc.board.SimplePostDTO" %>
<%@ page import="com.bfc.board.HashtagDTO" %>
<!DOCTYPE html>
<html>
<body>
    <!-- Site Introduction Banner -->
    <!-- <section class="site-banner">
        <p>다양한 부산 여행지를 탐색하고, 각 여행지에 대한 코스 확인해보세요</p>
    </section> -->

    <!-- Random Hashtags -->
    <section class="random-hashtags">
        <h3>추천 해시태그!</h3>
        <div class="hashtags">
            <%
                PostDAO postDAO2 = new PostDAO();
                List<String> randomHashtags = postDAO2.getRandomHashtags(6); // 6개의 랜덤 해시태그 가져오기

                for (String hashtag : randomHashtags) {
            %>
            <span class="hashtag">#<%= hashtag %></span>
            <%
                }
            %>
        </div>
    </section>

    <!-- 해시태그 검색 -->
    <section class="search-bar">
        <form action="${pageContext.request.contextPath}/index.jsp" method="get">
            <input type="text" name="tagQuery" placeholder="태그로 검색해보세요">
            <button type="submit">검색</button>
        </form>
    </section>
    
    <!-- 포스트 제목으로 검색 -->
<%--     <section class="search-bar">
        <form action="${pageContext.request.contextPath}/index.jsp" method="get">
            <input type="text" name="query" placeholder="글 제목으로 검색하기">
            <button type="submit">검색</button>
        </form>
    </section> --%>

    <!-- Main -->
    <main>
        <!-- contents section -->
        <section class="contents">
            <h1>여행지 소개</h1>
            <div class="posts">
                <%
                    int pageSize = 6; // 한 페이지에 보여줄 포스트 개수
                    int currentPage = 1; // 기본적으로 첫 번째 페이지

                    // 페이지 파라미터가 있을 경우 해당 페이지로 설정
                    String pageParam = request.getParameter("page");
                    if (pageParam != null && !pageParam.isEmpty()) {
                        currentPage = Integer.parseInt(pageParam);
                    }

                    PostDAO postDAO = new PostDAO();
                    List<SimplePostDTO> allPosts;
                    String query = request.getParameter("query");
                    String tagQuery = request.getParameter("tagQuery");

                    // 여행지 제목으로 검색
                    if (query != null && !query.trim().isEmpty()) {
                        allPosts = postDAO.searchPosts(query);
                    }
                    // 해시태그로 검색
                    else if (tagQuery != null && !tagQuery.trim().isEmpty()) {
                        allPosts = postDAO.searchPostsByTag(tagQuery);
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
                    <img class="contentImg" src="uploadImages/board<%= post.getPostId() %>/<%= URLEncoder.encode(post.getImage()) %>" width="100%" />
                    <br>
                    <h2><%= post.getTitle() %></h2>
                    <!-- 해시태그 출력 -->
                    <div class="tags">
                        <% for (HashtagDTO tag : post.getTags()) { %>
                            <span class="tag"><%= tag.getTag() %></span>
                        <% } %>
                    </div>
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
                        // 검색어(query 또는 tagQuery)가 있을 때와 없을 때의 링크 구성
                        if (query != null && !query.trim().isEmpty()) {
                %>
                <a href="${pageContext.request.contextPath}/index.jsp?page=<%= i %>&query=<%= query %>" <%= (i == currentPage) ? "style='font-weight: bold; background-color: #066AE0; color: white;" : "" %>><%= i %></a>
                <%
                        } else if (tagQuery != null && !tagQuery.trim().isEmpty()) {
                %>
                <a href="${pageContext.request.contextPath}/index.jsp?page=<%= i %>&tagQuery=<%= tagQuery %>" <%= (i == currentPage) ? "style='font-weight: bold; background-color: #066AE0; color: white;'" : "" %>><%= i %></a>
                <%
                        } else {
                %>
                <a href="${pageContext.request.contextPath}/index.jsp?page=<%= i %>" <%= (i == currentPage) ? "style='font-weight: bold; background-color: #066AE0; color: white;'" : "" %>><%= i %></a>
                <%
                        }
                    }
                %>
            </div>
        </section>
    </main>

    <!-- 여행지 등록 버튼 -->
    <div class="registration-button">
        <button type="button" onclick="location.href='board/boardEdit.jsp'">여행지 등록</button>
    </div>
</body>
</html>
