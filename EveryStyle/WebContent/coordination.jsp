<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.net.*" import="java.sql.*" import="java.util.*"
	import="java.io.*" import="javax.naming.*" import="javax.sql.DataSource" import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<%@ page import="org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
    <%
    	
    	String errorMsg = null;

    	String actionUrl = null;
    	// DB 접속을 위한 준비
    	Connection conn = null;
    	PreparedStatement stmt = null;
    	ResultSet rs = null;
    	
    	String dbUrl = "jdbc:mysql://localhost:3306/signup";
    	String dbUser = "web";
    	String dbPassword = "asdf";
    	
    	// 의류 정보를위한 변수 초기화
    	Vector<Integer> idList = new Vector<Integer>();
    	Vector<String> userid = new Vector<String>();
    	Vector<String> outer_left = new Vector<String>();
    	Vector<String> outer_top = new Vector<String>();
    	Vector<String> outer_id = new Vector<String>();
    	Vector<String> top_left = new Vector<String>();
    	Vector<String> top_top = new Vector<String>();
    	Vector<String> top_id = new Vector<String>();
    	Vector<String> pants_left = new Vector<String>();
    	Vector<String> pants_top = new Vector<String>();
    	Vector<String> pants_id = new Vector<String>();
    	Vector<String> skirtdress_left = new Vector<String>();
    	Vector<String> skirtdress_top = new Vector<String>();
    	Vector<String> skirtdress_id = new Vector<String>();
    	Vector<String> created_at = new Vector<String>();
    	
    	//List<String> favoriteList = null;
    	
    	int id = 0;
    	try {
    		id = Integer.parseInt(request.getParameter("id"));
    	} catch (Exception e) {}
    	
    		try {
    		    Class.forName("com.mysql.jdbc.Driver");

    		    // DB 접속
    			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    	 		// 질의 준비
    			stmt = conn.prepareStatement("SELECT id, userid, outer_left, outer_top, outer_id, top_left, top_top, top_id, pants_left, pants_top, pants_id, skirtdress_left, skirtdress_top, skirtdress_id, created_at, path FROM cody, adds WHERE cody.id=adds.id ORDER BY created_at DESC");
    			//stmt.setInt(1, id);
    			
    			// 수행
    	 		rs = stmt.executeQuery();
    			
    			while (rs.next()) {
    				idList.add(rs.getInt("id"));
    				userid.add(rs.getString("userid"));
    				outer_left.add(rs.getString("outer_left"));
    				outer_top.add(rs.getString("outer_top"));
    				outer_id.add(rs.getString("outer_id"));
    				top_left.add(rs.getString("top_left"));
    				top_top.add(rs.getString("top_top"));
    				top_id.add(rs.getString("top_id"));
    				pants_left.add(rs.getString("pants_left"));
    				pants_top.add(rs.getString("pants_top"));
    				pants_id.add(rs.getString("pants_id"));
    				skirtdress_left.add(rs.getString("skirtdress_left"));
    				skirtdress_top.add(rs.getString("skirtdress_top"));
    				skirtdress_id.add(rs.getString("skirtdress_id"));
    				created_at.add(rs.getString("created_at"));
    			}
    		}catch (SQLException e) {
    			errorMsg = "SQL 에러: " + e.getMessage();
    		} finally {
    			// 무슨 일이 있어도 리소스를 제대로 종료
    			if (rs != null) try{rs.close();} catch(SQLException e) {}
    			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
    			if (conn != null) try{conn.close();} catch(SQLException e) {}
    		}
    		actionUrl = "searchResult.jsp";
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>모든 코디 보기</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/banner.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript">
	// create a wrapper around native canvas element (with id="c")
	$(document).ready(function () {

				var imageArr = new Array();
				var canvas = new fabric.Canvas('c');
				canvas.setHeight(300);
				canvas.setWidth(300);
				
				var img
	});
	</script>
				
</head>
<body>
<jsp:include page="share/header.jsp">
  	<jsp:param name="current" value="Coordination"/>
  </jsp:include>
  <div class="container">
<div class="row">
 <% for(int i=0; i<idList.size(); i++ ) {%>
	  		<div class="col-sm-6 col-md-3">
	  		<%out.println(idList.get(i));%>
	  		<%-- <img src="<%=idList.get(i) %>" class="img-thumbnail" alt="picture"/> --%>
	  		</div>
	  	<%} %>
  <div class="col-sm-6 col-md-3">
    <div class="thumbnail">
      <img data-src="holder.js/300x200" alt="...">
      <div class="caption">
        <h3>코디 제목</h3>
        <p>...</p>
        <p><a href="#" class="btn btn-primary">Button</a> <a href="#" class="btn btn-default">Button</a></p>
      </div>
    </div>
  </div>
</div>
</div>
</body>
</html>