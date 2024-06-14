<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bfc.board.PostDAO" %>
<%@ page import="com.bfc.board.PostDTO" %>
<%@ page import="com.bfc.board.ContentDTO" %>
<%@ page import="com.bfc.board.HashtagDTO" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
// 세션에서 userId 가져오기
//String userId = (String) session.getAttribute("userId");
int userId = 1;

PostDAO postDAO = new PostDAO();
PostDTO postDTO = new PostDTO();

// 이전에 등록된 postId 가져오기
int lastPostId = postDAO.getLastPostId();
int newPostId = lastPostId + 1;

// 경로 설정
String uploadPath = getServletContext().getRealPath("/uploadImages/board" + newPostId);

File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) {
    uploadDir.mkdirs();
}

MultipartRequest multi = new MultipartRequest(request, uploadPath,
		5 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());

String title = multi.getParameter("title");
int postId = Integer.parseInt(multi.getParameter("postId"));
int fieldcount = Integer.parseInt(multi.getParameter("fc"));

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
	
	 // 고유한 파일 이름 생성
	String uniqueFileName = filename1;
	uniqueFileName = URLEncoder.encode(uniqueFileName, "UTF-8");
	    
	// 파일을 고유한 이름으로 디렉토리에 저장
	File oldFile = new File(uploadPath, filename1);
	File newFile = new File(uploadPath, uniqueFileName);
	if (oldFile.renameTo(newFile)) {
	    System.out.println("File renamed successfully to " + uniqueFileName);
	} else {
	    System.out.println("Failed to rename file " + filename1);
	}
	
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
	contentDTO.setImage(uniqueFileName);
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