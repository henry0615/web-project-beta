<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"
	import="org.apache.commons.lang3.StringUtils" import="java.sql.*" import="java.io.*"
   import="org.apache.commons.lang3.StringUtils"%>
<%
String[] wear_kinds = {"outer", "top", "pant", "dress & skirt"};
String[] wear_prices= {"1~2만원", "2~3만원", "3~4만원", "4~5만원","5만원이상" };
 
   String errorMsg = null;

  String actionUrl;
  // DB 접속을 위한 준비
  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet rs = null;
  
  String dbUrl = "jdbc:mysql://localhost:3306/signup";
  String dbUser = "web";
  String dbPassword = "asdf";
  
  // 사용자 정보를 위한 변수 초기화
  String userid = "";
  String clothesName = "";
  String link = "";
  String clothes = "";
  String season = "";
  String price = "";
	String imgpath = "";
  // Request로 ID가 있는지 확인
  int id = 0;
  try {
    id = Integer.parseInt(request.getParameter("id"));
  } catch (Exception e) {}
  
  if (id > 0) {
  try {
	  Class.forName("com.mysql.jdbc.Driver");
      // DB 접속
      conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
      // 질의 준비
      stmt = conn.prepareStatement("SELECT * FROM adds WHERE id = ?");
      stmt.setInt(1, id);
      
      // 수행
      rs = stmt.executeQuery();
      
      if (rs.next()) {
    	  userid = rs.getString("userid");
    	  clothesName = rs.getString("clothesName");
    	  link = rs.getString("link");
    	  clothes = rs.getString("clothes");
    	  price = rs.getString("price");
    	  season = rs.getString("season");
    	  imgpath = rs.getString("path");
            
          
      }
    }catch (SQLException e) {
     /*  errorMsg = "SQL 에러: " + e.getMessage(); */
    } finally {
      // 무슨 일이 있어도 리소스를 제대로 종료
      if (rs != null) try{rs.close();} catch(SQLException e) {}
      if (stmt != null) try{stmt.close();} catch(SQLException e) {}
      if (conn != null) try{conn.close();} catch(SQLException e) {}
    }
   
  }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>옷 정보</title>
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
      <%
         if (errorMsg != null && errorMsg.length() > 0 ) {
                // SQL 에러의 경우 에러 메시지 출력
                out.print("<div class='alert'>" + errorMsg + "</div>");
             } else {
      %>
      <div class="row">
  		<div class="col-sm-6 col-md-3">
  		<img src="<%=imgpath %>" class="img-thumbnail" alt="picture"/>
  		</div>
  		</div>
      <div>
         <!-- XSS (Cross-site scripting)의 위험이 있는 안좋은 코드의 예  -->
         <h3><%=clothesName%></h3>
         <ul>
            <li>User ID: <%=userid%></li>
            
            <li>Link: <%=link%></li>
            <li>Clothes: <%
               for (String arr: wear_kinds) {
                               if (arr.equals(clothes)) {
                                  out.println(arr);
                               }
                            }
            %>
            </li>
            <li>Price: <%
               for (String arr: wear_prices) {
                               if (arr.equals(price)) {
                                  out.println(arr);
                               }
                            }
            %>
            </li>
            <li>Season: <%=season%></li>
            
         </ul>
      </div>
      <%
         }
      %>

      <div class="form-actions">
         <a href="index.jsp" class="btn">목록으로</a>
         <%
            if (id > 0) {
         %>
         <a href="adds.jsp?id=<%=id%>" class="btn btn-primary">수정</a>
          
         <a href="#" class="btn btn-danger" data-action="delete" data-id="<%=id%>">삭제</a>
         <%
            }
         %>
      </div>
      <script>
         $("a[data-action='delete']").click(function() {
            if (confirm("정말로 삭제하시겠습니까?")) {
               location = 'adddelete.jsp?id=' + $(this).attr('data-id');
            }
            return false;
         });
      </script>
   </div>
</body>
</html>