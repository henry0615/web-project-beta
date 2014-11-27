<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"
	import="java.io.*" import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%

   // DB 접속을 위한 준비
   Connection conn = null;
   PreparedStatement stmt = null;
   ResultSet rs = null;
   
   String dbUrl = "jdbc:mysql://localhost:3306/signup";
   String dbUser = "web";
   String dbPassword = "asdf";
   List<String> errorMsgs = new ArrayList<String>();
   int result = 0;
   String path = "C:/Users/lg/web/web-project-beta/EveryStyle/WebContent/uploadImg/";
   MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*5, "utf-8", new DefaultFileRenamePolicy());
   File file = multi.getFile("image");
   String fileName = multi.getOriginalFileName("image");
   
	//날짜+시간 저장
	 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
	 String today = formatter.format(new java.util.Date());
   
   String userid = session.getAttribute("userid").toString();
   //파일명 변경하여 업로드
   String realFileName = userid + fileName;  //사용자 아이디와 파일이름 합치기
   File NewFile = new File(path + realFileName);
   file.renameTo(NewFile);
   
   String clothesName = multi.getParameter("clothesName");
   String link = multi.getParameter("link");
   String clothes = multi.getParameter("clothes");
   String price = multi.getParameter("price");
   String[] season = multi.getParameterValues("season");
   String seasonStr = StringUtils.join(season, ",");
   String imgpath = path + realFileName;
   String created_at = today;
   
	 File saveFile = new File(path + realFileName);
   FileInputStream fileInputStream = new FileInputStream(saveFile);
   
   try {
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
      stmt = conn.prepareStatement(
            "INSERT INTO adds(userid, clothesName, image, link, clothes, price, season, path, created_at ) " +
            "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );
      //고칠 것!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      stmt.setString(1,  userid);
      stmt.setString(2,  clothesName); 
      stmt.setBinaryStream(3, fileInputStream, (int)(file.length()));
      stmt.setString(4,  link);
      stmt.setString(5,  clothes);
      stmt.setString(6,  price);
      stmt.setString(7,  seasonStr);
      stmt.setString(8,  imgpath);
      stmt.setString(9,  created_at);
      
      result = stmt.executeUpdate();
      if (result != 1) {
         errorMsgs.add("등록에 실패하였습니다.");
      }
   } catch (Exception e) {
      out.println(e);
   } finally {
      if (rs != null) try{rs.close();} catch(SQLException e) {}
      if (stmt != null) try{stmt.close();} catch(SQLException e) {}
      if (conn != null) try{conn.close();} catch(SQLException e) {}
   }
   
   if (clothesName == null || clothesName.trim().length() == 0) {
	      errorMsgs.add("옷 이름을 반드시 입력해주세요.");
	 }
   if (file == null) {
	   errorMsgs.add("이미지파일을 반드시 등록해주세요.");
   }
   if (link == null || link.trim().length() == 0) {
      errorMsgs.add("링크을 반드시 입력해주세요.");
   }
   if (clothes == null || clothes.length() == 0) {
      errorMsgs.add("옷종류를 반드시 입력해주세요.");
   }
   if (price == null || price.length() == 0) {
	      errorMsgs.add("가격을 반드시 입력해주세요.");
	 }
   if (seasonStr == null || seasonStr.length() == 0) {
	      errorMsgs.add("게절을 반드시 입력해주세요.");
	 }
 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>옷 등록</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
   <jsp:include page="share/header.jsp">
      <jsp:param name="current" value="Add" />
   </jsp:include>
   
   <div class="container">
      <% if (errorMsgs.size() > 0) { %>
      <div class="alert alert-error">
         <h3>Errors:</h3>
         <ul>
            <% for(String msg: errorMsgs) { %>
            <li><%=msg %></li>
            <% } %>
         </ul>
      </div>
      <div class="form-action">
         <a onclick="history.back();" class="btn">뒤로 돌아가기</a>
      </div>
      <% } else if (result == 1) { %>
      <div class="alert alert-success">
      <b><%out.println(session.getAttribute("userid"));%></b>님 등록해주셔서 감사합니다.   
      </div>
      
      <div class="form-action">
         <a href="addshow.jsp" class="btn">확인하기</a>
      </div>

      <%}%>
   </div>
</body>
</html>