<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.bfc.board.PostDAO" %>
<%@ page import="com.bfc.board.PostDTO" %>
<%@ page import="com.bfc.board.ContentDTO" %>
<%@ page import="com.bfc.board.HashtagDTO" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
// 세션에서 userId 가져오기
//String userId = (String) session.getAttribute("userId");
int userId = 1;


// 파일 업로드 처리   // 절대 경로 처리 밖에 안되는 거 같습니다. 각자 절대 경로로 설정해주세요!
MultipartRequest multi = new MultipartRequest(request, "C:\\Users/oo7ba/Desktop/InDBSpace/BFC/src/main/webapp/resources/images",
		5 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());

String title = multi.getParameter("title");
int postId = Integer.parseInt(multi.getParameter("postId"));
int fieldcount = Integer.parseInt(multi.getParameter("fc"));

PostDAO postDAO = new PostDAO();
PostDTO postDTO = new PostDTO();
List<ContentDTO> contents = new ArrayList<>();

postDTO.setPostId(postId);
postDTO.setUserId(userId);
postDTO.setTitle(title);
postDTO.setCreatedAt(new Timestamp(System.currentTimeMillis()));

Enumeration files = multi.getFileNames();
for(int i = 0 ; i < fieldcount; i++){ // 코스 리스트
	String name = "title" + i;
	String contentTitle = multi.getParameter("" + name);
	
	String locationName = "location" + i;
	String location = multi.getParameter("" + locationName);
	
	String cName = "content" + i;
	String content = multi.getParameter("" + cName);
	// Content 테이블에 삽입 (파일 경로만 저장)

	String file = (String) files.nextElement();
	String fName = "file" + i;
	String filename1 = multi.getFilesystemName("" + fName);
	
	String tname = "tag" + i;
	String tag = multi.getParameter("" + tname);
    
	List<HashtagDTO> tags = new ArrayList<>();
    
    if(tag != null && !tag.trim().isEmpty()) {
        String[] tagsArray = tag.split(" ");
        for(String t : tagsArray){ // 해쉬태그 리스트
            HashtagDTO hashtagDTO = new HashtagDTO();
            hashtagDTO.setTag(t);
            hashtagDTO.setUserId(userId);
            tags.add(hashtagDTO);
        }
    }
	ContentDTO contentDTO = new ContentDTO();
	contentDTO.setContentTitle(contentTitle);
	contentDTO.setUserId(userId);
	contentDTO.setLocation(location);
	contentDTO.setContent(content);
	contentDTO.setImage(filename1);
	contentDTO.setTags(tags);
	contents.add(contentDTO);
}
postDTO.setContents(contents);

if(postDAO.updatePost(postDTO)){
    out.println("<script type='text/javascript'>");
    out.println("alert('게시글이 수정되었습니다.');");
    out.println("window.location.href = '../main/main.jsp';");
    out.println("</script>");
}
else{
	 out.println("<script type='text/javascript'>");
	 out.println("alert('게시글에 실패했습니다.');");
	 out.println("window.location.href = '../main/main.jsp';");
	 out.println("</script>");
}

%>