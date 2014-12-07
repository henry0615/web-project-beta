<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.net.*" import="java.sql.*" import="java.util.*"
	import="java.io.*" import="javax.naming.*" import="javax.sql.DataSource" import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<%@ page import="org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
    <%
    /* class Cody {
    	public int id;
    	public int outerId;
    	public String outerPath;
    	public int topId;
    	public String topPath;
    	public int pantsId;
    	public String pantsPath;
    	public int skirtDressId;
    	public String skirtDressPath;
    	
    	public int outerLeft;
    	public int outerTop;
    	public int topLeft;
    	public int topTop;
    	public int pantsLeft;
    	public int pantsTop;
    	public int skirtDressTop;
    	public int skirtDressLeft;
    	
    	public Cody (int id, int outerId, String outerPath, int topId, String topPath, int pantsId, String pantsPath, int skirtDressId, String skirtDressPath, int outerLeft, int outerTop, int topLeft, int topTop, int pantsLeft, int pantsTop, int skirtDressLeft, int skirtDressTop) {
    		this.id = id;
    		this.outerId = outerId;
    		this.topId = topId;
    		this.pantsId = pantsId;
    		this.skirtDressId = skirtDressId;
    		this.outerPath = outerPath;
    		this.topPath = topPath;
    		this.pantsPath = pantsPath;
    		this.skirtDressPath = skirtDressPath;
    		this.outerLeft = outerLeft;
    		this.outerTop = outerTop;
    		this.topLeft = topLeft;
    		this.topTop = topTop;
    		this.pantsLeft = pantsLeft;
    		this.pantsTop = pantsTop;
    		this.skirtDressLeft = skirtDressLeft;
    		this.skirtDressTop = skirtDressTop;
    	}
    } */
    
    	String errorMsg = null;

    	String actionUrl = null;
    	// DB 접속을 위한 준비
    	Connection conn = null;
    	PreparedStatement stmt = null;
    	ResultSet rs = null;
    	
    	String dbUrl = "jdbc:mysql://localhost:3306/signup";
    	String dbUser = "web";
    	String dbPassword = "asdf";
    	
    	int mainId = 0;
			String userid = "";
			int outerId = 0;
			int topId = 0;
			int pantsId = 0;
			int skirtDressId = 0;
			String outerPath = null;
			String outerName = null;
			String outerLink = null;
			String topPath = null;
			String topName = null;
			String topLink = null;
			String pantsPath = null;
			String pantsName = null;
			String pantsLink = null;
			String skirtDressPath = null;
			String skirtDressName = null;
			String skirtDressLink = null;
			int outerTop = 0;
			int outerLeft = 0;
			int topTop = 0;
			int topLeft = 0;
			int pantsTop = 0;
			int pantsLeft = 0;
			int skirtDressTop = 0;
			int skirtDressLeft = 0;
    
    	int id = 0;
    	try {
    		id = Integer.parseInt(request.getParameter("id"));
    	} catch (Exception e) {}
    	
    		try {
    		    Class.forName("com.mysql.jdbc.Driver");

    		    // DB 접속
    			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    	 		// 질의 준비
    	 		stmt = conn.prepareStatement("select id, userid, outer_id, outer_top, outer_left, top_id, top_left, top_top, pants_id, pants_left, pants_top, skirtdress_id, skirtdress_left, skirtdress_top from cody where id=? order by id desc");
    			stmt.setInt(1, id);
    			
    			// 수행
    	 		rs = stmt.executeQuery();
    			while (rs.next()) {
    				mainId = rs.getInt("id");
    				userid = rs.getString("userid");
    				outerId = rs.getInt("outer_id");
    				topId = rs.getInt("top_id");
    				pantsId = rs.getInt("pants_id");
    				skirtDressId = rs.getInt("skirtdress_id");
    				outerPath = null;
    				topPath = null;
    				pantsPath = null;
    				skirtDressPath = null;
    				outerTop = rs.getInt("outer_top");
    				outerLeft = rs.getInt("outer_left");
    				topTop = rs.getInt("top_top");
    				topLeft = rs.getInt("top_left");
    				pantsTop = rs.getInt("pants_top");
    				pantsLeft = rs.getInt("pants_left");
    				skirtDressTop = rs.getInt("skirtdress_top");
    				skirtDressLeft = rs.getInt("skirtdress_left");
    				
    				PreparedStatement tempStmt = conn.prepareStatement("SELECT clothesName, link, path FROM adds WHERE id=?");
    				tempStmt.setInt(1, outerId);
    				ResultSet tempRS = tempStmt.executeQuery();
    				if (tempRS.next()) {
    					outerPath = tempRS.getString("path");
    					outerName = tempRS.getString("clothesName");
    					outerLink = tempRS.getString("link");
    				}
    				tempRS.close();
    				tempStmt.close();
    				
    				tempStmt = conn.prepareStatement("SELECT clothesName, link, path FROM adds WHERE id=?");
    				tempStmt.setInt(1, topId);
    				tempRS = tempStmt.executeQuery();
    				if (tempRS.next()) {
    					topPath = tempRS.getString("path");
    					topName = tempRS.getString("clothesName");
    					topLink = tempRS.getString("link");
    				}
    				tempRS.close();
    				tempStmt.close();
    				
    				tempStmt = conn.prepareStatement("SELECT clothesName, link, path FROM adds WHERE id=?");
    				tempStmt.setInt(1, pantsId);
    				tempRS = tempStmt.executeQuery();
    				if (tempRS.next()) {
    					pantsPath = tempRS.getString("path");
    					pantsName = tempRS.getString("clothesName");
    					pantsLink = tempRS.getString("link");
    				}
    				tempRS.close();
    				tempStmt.close();
    				
    				tempStmt = conn.prepareStatement("SELECT clothesName, link, path FROM adds WHERE id=?");
    				tempStmt.setInt(1, skirtDressId);
    				tempRS = tempStmt.executeQuery();
    				if (tempRS.next()) {
    					skirtDressPath = tempRS.getString("path");
    					skirtDressName = tempRS.getString("clothesName");
    					skirtDressLink = tempRS.getString("link");
    				}
    				tempRS.close();
    				tempStmt.close();
    				
    			}
    			
    		}catch (SQLException e) {
    			errorMsg = "SQL 에러: " + e.getMessage();
    		} finally {
    			// 무슨 일이 있어도 리소스를 제대로 종료
    			if (rs != null) try{rs.close();} catch(SQLException e) {}
    			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
    			if (conn != null) try{conn.close();} catch(SQLException e) {}
    		}
    %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>모든 코디 보기</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/banner.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./js/excanvas.js"></script>
	<script type="text/javascript" src="./js/fabric.js"></script>
	<script type="text/javascript">
	$(document).ready(function () {
		var canvas = null;
		var newIamge = null;
		var img = null;
			canvas = new fabric.Canvas('c');
			var imgElement = new Image();
			
			imgElement.src = "<%=outerPath%>";
			fabric.Image.fromURL('<%=outerPath%>', function (img){
				img.set({
					width:200,
					height:200,
					left:<%=outerLeft%>,
					top:<%=outerTop%>
				});
				canvas.add(img);
			});
			fabric.Image.fromURL('<%=topPath%>', function (img){
				img.set({
					width:200,
					height:200,
					left:<%=topLeft%>,
					top:<%=topTop%>
				});
				canvas.add(img);
			});
			fabric.Image.fromURL('<%=pantsPath%>', function (img){
				img.set({
					width:200,
					height:200,
					left:<%=pantsLeft%>,
					top:<%=pantsTop%>
				});
				canvas.add(img);
			});
			fabric.Image.fromURL('<%=skirtDressPath%>', function (img){
				img.set({
					width:200,
					height:200,
					left:<%=skirtDressLeft%>,
					top:<%=skirtDressTop%>
				});
				canvas.add(img);
			});
	});
	</script>
</head>
<body>
	<div class="container">
	<div class="row" style="padding-top:20px">
	<div style="float:left;">
	<canvas width="450" height="500" id='c' style="border:1px solid #e5e5e5;"></canvas>
	</div>
	
	<div style="float:left; margin-left:20px;">
		<p>ID <strong><%=userid %></strong> 님의 코디입니다.</p>
		<%if(outerName != null) { %>
		<h4>Outer: <%=outerName %></h4>
		<p>구매사이트: <a href="<%=outerLink %>"><%=outerLink %></a></p>
		<%} %>
		<%if(topLink != null) { %>
		<h4>Top: <%=topName %></h4>
		<p>구매사이트: <a href="<%=topLink %>"><%=topLink %></a></p>
		<%} %>
		<%if(pantsLink != null) { %>
		<h4>pants: <%=pantsName %></h4>
		<p>구매사이트: <a href="<%=pantsLink %>"><%=pantsLink %></a></p>
		<%} %>
		<%if(skirtDressLink != null) { %>
		<h4>Skirt&Dress: <%=skirtDressName %></h4>
		<p>구매사이트: <a href="<%=skirtDressLink %>"><%=skirtDressLink %></a></p>
		<%} %>
	</div>
	</div>
	</div>
</body>
</html>