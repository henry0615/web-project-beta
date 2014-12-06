<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%> 
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	List<String> errorMsgs = new ArrayList<String>();
	
	int result = 0;
	
	String dbUrl = "jdbc:mysql://localhost:3306/signup";
	String dbUser = "web";
	String dbPassword = "asdf";
	String outer_left = request.getParameter("outer_left");
	String outer_top = request.getParameter("outer_top");
	String outer_id = request.getParameter("outer_id");
	String top_left = request.getParameter("top_left");
	String top_top = request.getParameter("top_top");
	String top_id = request.getParameter("top_id");
	String pants_left = request.getParameter("pants_left");
	String pants_top = request.getParameter("pants_top");
	String pants_id = request.getParameter("pants_id");
	String skirtdress_left = request.getParameter("skirtdress_left");
	String skirtdress_top = request.getParameter("skirtdress_top");
	String skirtdress_id = request.getParameter("skirtdress_id");
	
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
	String today = formatter.format(new java.util.Date());
	String created_at = today;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");

		// DB 접속
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt = conn.prepareStatement(
				"INSERT INTO cody(userid, outer_left, outer_top, outer_id, top_left, top_top, top_id, pants_left, pants_top, pants_id, skirtdress_left, skirtdress_top, skirtdress_id, created_at)" +
				"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
				);
		stmt.setString(1, session.getAttribute("userid").toString());
		stmt.setString(2, outer_left);
		stmt.setString(3, outer_top);
		stmt.setString(4, outer_id);
		stmt.setString(5, top_left);
		stmt.setString(6, top_top);
		stmt.setString(7, top_id);
		stmt.setString(8, pants_left);
		stmt.setString(9, pants_top);
		stmt.setString(10, pants_id);
		stmt.setString(11, skirtdress_left);
		stmt.setString(12, skirtdress_top);
		stmt.setString(13, skirtdress_top);
		stmt.setString(14, created_at);
		
		result = stmt.executeUpdate();
		
		if(result != 1) {
			errorMsgs.add("등록에 실패하였습니다.");
		}
	} catch (SQLException e) {
		errorMsgs.add("SQL 에러: " + e.getMessage());
		out.println(e);
	 } finally {
	      if (rs != null) try{rs.close();} catch(SQLException e) {}
	      if (stmt != null) try{stmt.close();} catch(SQLException e) {}
	      if (conn != null) try{conn.close();} catch(SQLException e) {}
	 }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
      <b><span class="glyphicon glyphicon-ok"></span><%out.println(session.getAttribute("userid"));%></b>님 등록해주셔서 감사합니다.
      </div>
      
      <div class="form-action">
         <a href="addshow.jsp" class="btn">확인하기</a>
      </div>

      <%}%>
   </div>

</body>
</html>