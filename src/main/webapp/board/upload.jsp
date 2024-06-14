<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
// 세션에서 userId 가져오기
//String userId = (String) session.getAttribute("userId");
int userId = 1;


// 파일 업로드 처리   // 절대 경로 처리 밖에 안되는 거 같습니다. 각자 절대 경로로 설정해주세요! C:\\Users/user/Desktop/work2/BFC/src/main/webapp/resources/images
MultipartRequest multi = new MultipartRequest(request, "C:\\Users/user/Desktop/work2/BFC/src/main/webapp/resources/images",
		5 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());

String title = multi.getParameter("title");
String fc = multi.getParameter("fc");
int fieldcount = Integer.parseInt(fc);

// 데이터베이스 처리
try {
    String dbUrl = "jdbc:mysql://localhost:3306/scott";
    String id = "scott";
    String pw = "tiger";
	
    // Post 테이블에 삽입
    String postQuery = "INSERT INTO Post (title, userId, createdAt) VALUES (?, ?, ?)";
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(dbUrl, id, pw);
    
    PreparedStatement pstmt = conn.prepareStatement(postQuery, Statement.RETURN_GENERATED_KEYS);
    pstmt.setString(1, title);
    pstmt.setInt(2, userId);
    pstmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
    pstmt.executeUpdate();
    
    ResultSet generatedKeys = pstmt.getGeneratedKeys();
    int postId = -1;
    if (generatedKeys.next()) {
        postId = generatedKeys.getInt(1);
    }
    
    pstmt.close();
    Enumeration files = multi.getFileNames();
    
    
    for(int i = 0 ; i <= fieldcount; i++){
    	String cName = "content" + i;
    	String content = multi.getParameter("" + cName);
    	// Content 테이블에 삽입 (파일 경로만 저장)

    	String file = (String) files.nextElement();
    	String fName = "file" + i;
    	String filename1 = multi.getFilesystemName("" + fName);
    	
        String contentQuery = "INSERT INTO Content (postId, content, image, userId) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(contentQuery);  
        pstmt.setInt(1, postId);
    	pstmt.setString(2, content);
        pstmt.setString(3, filename1);
        pstmt.setInt(4, userId);
        pstmt.executeUpdate();
        pstmt.close();
    }
    
    
    conn.close();
    
    // 성공 메시지 출력
    out.println("<script type='text/javascript'>");
    out.println("alert('게시글이 등록되었습니다.');");
    out.println("window.location.href = '../main/main.jsp';");
    out.println("</script>");
} catch (Exception e) {
    // 에러 처리
    e.printStackTrace();
}
%>


