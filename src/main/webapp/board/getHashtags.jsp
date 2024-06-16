<%@ page import="java.util.*, com.bfc.board.HashtagDTO" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<jsp:useBean id="postDAO" class="com.bfc.board.PostDAO" />
<%
    String contentId = request.getParameter("contentId");
    List<HashtagDTO> hashtagList = postDAO.getHashtags(Integer.parseInt(contentId));
    
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    
    List<String> hashtags = new ArrayList<>();
    for (HashtagDTO hashtag : hashtagList) {
        hashtags.add(hashtag.getTag());
    }
    
    String jsonResponse = new com.google.gson.Gson().toJson(hashtags);
    out.print(jsonResponse);
    out.flush();
%>
