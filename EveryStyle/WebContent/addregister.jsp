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
   String path = "D:/eclipse-jee-luna-SR1-win32/eclipse/workspace/EveryStyle/WebContent/uploadImg\\";
   MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*5, "utf-8", new DefaultFileRenamePolicy());
   File file = multi.getFile("image");
   String fileName = multi.getOriginalFileName("image");
   
   String userid = session.getAttribute("userid").toString();
   String link = multi.getParameter("link");
   String clothes = multi.getParameter("clothes");
   String price = multi.getParameter("price");
   String[] season = multi.getParameterValues("season");
   String seasonStr = StringUtils.join(season, ",");
   
   FileInputStream fileInputStream = new FileInputStream(file);
   
   try {
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
      stmt = conn.prepareStatement(
            "INSERT INTO adds(userid, image, link, clothes, price, season ) " +
            "VALUES(?, ?, ?, ?, ?, ?)"
            );
      //고칠 것!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      stmt.setString(1,  userid);
      // stmt.setString(2, fin.toString()); 
      stmt.setBinaryStream(2, fileInputStream, (int)(file.length()));
      stmt.setString(3,  link);
      stmt.setString(4,  clothes);
      stmt.setString(5,  price);
      stmt.setString(6,  seasonStr);
      
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
   
   /*request.setCharacterEncoding("utf-8");
   String userid = request.getParameter("userid");
   String link = request.getParameter("link");
   String clothes = request.getParameter("clothes");
   String price = request.getParameter("price");
   String[] season = request.getParameterValues("season");
   String seasonStr = StringUtils.join(season, ",");
   
   
   FileItemFactory factory = new DiskFileItemFactory();
   ServletFileUpload upload = new ServletFileUpload(factory);
   */
   /* InputStream inputStream = null;
   Part filePart = request.getPart("image");
   inputStream = filePart.getInputStream(); */
   
 
  if (link == null || link.trim().length() == 0) {
      errorMsgs.add("링크을 반드시 등록해주세요.");
   }
   
   if (clothes == null || clothes.length() == 0) {
      errorMsgs.add("옷에 적합하지 않은 값이 입력되었습니다.");
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
      <b><%session.getAttribute("userid"); %></b>님 등록해주셔서 감사합니다.   
      </div>
      
      <div class="form-action">
         <a href="addshow.jsp" class="btn">글 확인하기</a>
      </div>

      <%}%>
   </div>
</body>
</html>