<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.net.*" import="java.sql.*" import="java.util.*"
	import="java.io.*" import="javax.naming.*" import="javax.sql.DataSource" import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<%@ page import="org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
    <%
    class Cody {
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
    }
    
    
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
    	/*Vector<Integer> idList = new Vector<Integer>();
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
    	Vector<String> created_at = new Vector<String>();*/
    	ArrayList<Cody> codyList = new ArrayList<Cody>();
    	
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
    			//stmt = conn.prepareStatement("select a.id, b.id, b.path, c.id, c.path, d.id, d.path, e.id, e.path from cody a,(select distinct a.id, b.id, b.path from cody a, adds b where a.id=? and a.outer_id=b.id ) b, (select distinct a.id, b.id, b.path from cody a, adds b where a.id=? and a.top_id=b.id) c, (select distinct a.id, b.id, b.path from cody a, adds b where a.id=? and a.pants_id=b.id) d, (select distinct a.id, b.id, b.path from cody a, adds b where a.id=? and a.skirtdress_id=b.id) e where a.id = ? and a.id=b.id and a.id=c.id and a.id=d.id and a.id=e.id; ORDER BY created_at DESC");
    	 		stmt = conn.prepareStatement("select id, outer_id, outer_top, outer_left, top_id, top_left, top_top, pants_id, pants_left, pants_top, skirtdress_id, skirtdress_left, skirtdress_top from cody order by id desc");
    			//stmt.setInt(1, id);
    			
    			// 수행
    	 		rs = stmt.executeQuery();
    			while (rs.next()) {
    				int mainId = rs.getInt("id");
    				int outerId = rs.getInt("outer_id");
    				int topId = rs.getInt("top_id");
    				int pantsId = rs.getInt("pants_id");
    				int skirtDressId = rs.getInt("skirtdress_id");
    				String outerPath = null;
    				String topPath = null;
    				String pantsPath = null;
    				String skirtDressPath = null;
    				int outerTop = rs.getInt("outer_top");
    				int outerLeft = rs.getInt("outer_left");
    				int topTop = rs.getInt("top_top");
    				int topLeft = rs.getInt("top_left");
    				int pantsTop = rs.getInt("pants_top");
    				int pantsLeft = rs.getInt("pants_left");
    				int skirtDressTop = rs.getInt("skirtdress_top");
    				int skirtDressLeft = rs.getInt("skirtdress_left");
    				
    				PreparedStatement tempStmt = conn.prepareStatement("SELECT path FROM adds WHERE id=?");
    				tempStmt.setInt(1, outerId);
    				ResultSet tempRS = tempStmt.executeQuery();
    				if (tempRS.next()) outerPath = tempRS.getString("path");
    				tempRS.close();
    				tempStmt.close();
    				
    				tempStmt = conn.prepareStatement("SELECT path FROM adds WHERE id=?");
    				tempStmt.setInt(1, topId);
    				tempRS = tempStmt.executeQuery();
    				if (tempRS.next()) topPath = tempRS.getString("path");
    				tempRS.close();
    				tempStmt.close();
    				
    				tempStmt = conn.prepareStatement("SELECT path FROM adds WHERE id=?");
    				tempStmt.setInt(1, pantsId);
    				tempRS = tempStmt.executeQuery();
    				if (tempRS.next()) pantsPath = tempRS.getString("path");
    				tempRS.close();
    				tempStmt.close();
    				
    				tempStmt = conn.prepareStatement("SELECT path FROM adds WHERE id=?");
    				tempStmt.setInt(1, skirtDressId);
    				tempRS = tempStmt.executeQuery();
    				if (tempRS.next()) skirtDressPath = tempRS.getString("path");
    				tempRS.close();
    				tempStmt.close();
    				
    				codyList.add(new Cody(mainId, outerId, outerPath, topId, topPath, pantsId, pantsPath, skirtDressId, skirtDressPath, outerLeft, outerTop, topLeft, topTop, pantsLeft, pantsTop, skirtDressLeft, skirtDressTop));
    			}
    			
    			/*while (rs.next()) {
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
    			}*/
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
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>모든 코디 보기</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/banner.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./js/excanvas.js"></script>
	<script type="text/javascript" src="./js/fabric.js"></script>
	<!-- <script type="text/javascript">
	// create a wrapper around native canvas element (with id="c")
	$(document).ready(function () {

				var imageArr = new Array();
				var canvas = new fabric.Canvas('c');
				canvas.setHeight(300);
				canvas.setWidth(300);
				
	});
	</script> -->
	<script type="text/javascript">
	var canvas = new Array(<%=codyList.size()%>)
	var context = new Array(<%=codyList.size()%>);
	var image = new Array(<%=codyList.size()%>);
	var image2 = new Array(<%=codyList.size()%>);
	var image3 = new Array(<%=codyList.size()%>);
	var image4 = new Array(<%=codyList.size()%>);
	</script>
</head>
<body>
  <div class="container">
  <div class="row">
  
 <%
	 	for (int i = 0;i < codyList.size();++i) {
	 		%>
	 		<div class="col-sm-6 col-md-3">
	 			<a href="asd.jsp?id="><canvas width="250" height="300" id="<%=codyList.get(i).id%>" style="border:1px solid #e5e5e5;"></canvas></a>
	 			<script type="text/javascript">
		 			canvas[<%=i%>] = document.getElementById("<%=codyList.get(i).id%>");
		 			context[<%=i%>] = canvas[<%=i%>].getContext("2d");
		 			image[<%=i%>] = new Image();
		 			image[<%=i%>].onload = function (){
		 				context[<%=i%>].drawImage(image[<%=i%>], <%=codyList.get(i).outerLeft%>, <%=codyList.get(i).outerTop%>, 100, 100);
		 			}
		 			image[<%=i%>].src = "<%=codyList.get(i).outerPath%>";
		 			////////////////////
		 			image2[<%=i%>] = new Image();
		 			image2[<%=i%>].onload = function (){
		 				context[<%=i%>].drawImage(image2[<%=i%>], <%=codyList.get(i).topLeft%>, <%=codyList.get(i).topTop%>, 100, 100);
		 			}
		 			image2[<%=i%>].src = "<%=codyList.get(i).topPath%>";
		 			///////////////////////
		 			image3[<%=i%>] = new Image();
		 			image3[<%=i%>].onload = function (){
		 				context[<%=i%>].drawImage(image3[<%=i%>], <%=codyList.get(i).pantsLeft%>, <%=codyList.get(i).pantsTop%>, 100, 100);
		 			}
		 			image3[<%=i%>].src = "<%=codyList.get(i).pantsPath%>";
		 			///////////////////////
		 			image4[<%=i%>] = new Image();
		 			image4[<%=i%>].onload = function (){
		 				context[<%=i%>].drawImage(image4[<%=i%>], <%=codyList.get(i).skirtDressLeft%>, <%=codyList.get(i).skirtDressTop%>, 100, 100);
		 			}
		 			image4[<%=i%>].src = "<%=codyList.get(i).skirtDressPath%>";
	 			</script>
	 		</div>
	 		<%
	 	}
	 %>
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