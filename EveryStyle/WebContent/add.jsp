<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="java.util.*"  import="java.sql.*" 
    import="org.apache.commons.lang3.StringUtils"%>

<%
	String[][] wear_kinds = {{"O","outer"},{"T", "top"}, {"P", "pant"}, {"D", "dress & skirt"}};
	String[] wear_seasons = {"spring", "summer", "fall", "winter"};
	String[] wear_prices= {"1~2만원", "2~3만원", "3~4만원", "4~5만원","5만원이상" };
	
	String errorMsg = null;

	String actionUrl;
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/add";
	String dbUser = "web";
	String dbPassword = "asdf";
	
	// 사용자 정보를 위한 변수 초기화
	String userid = "";
	String image = "";
	String link = "";
	String clothes = "";
	String season = "";
	String price = "";
	
	List<String> seasonList = null;
	List<String> priceList = null;
	
	// Request로 ID가 있는지 확인
		int id = 0;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (Exception e) {}

		if (id > 0) {
			// Request에 id가 있으면 update모드라 가정
			actionUrl = "update.jsp";
			try {
			    Class.forName("com.mysql.jdbc.Driver");

			    // DB 접속
				conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

		 		// 질의 준비
				stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
				stmt.setInt(1, id);
				
				// 수행
		 		rs = stmt.executeQuery();
				
				if (rs.next()) {
					userid = rs.getString("userid");
					image = rs.getString("image");
					link = rs.getString("link");
					clothes = rs.getString("clothes");
					season = rs.getString("season");
					price = rs.getString("price");
					
					if (season != null && season.length() > 0) {
						seasonList = Arrays.asList(StringUtils.split(season, ","));
					}
				}
			}catch (SQLException e) {
				errorMsg = "SQL 에러: " + e.getMessage();
			} finally {
				// 무슨 일이 있어도 리소스를 제대로 종료
				if (rs != null) try{rs.close();} catch(SQLException e) {}
				if (stmt != null) try{stmt.close();} catch(SQLException e) {}
				if (conn != null) try{conn.close();} catch(SQLException e) {}
			}
		} else {
			actionUrl = "register.jsp";
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="share/header.jsp">
  <jsp:param name="current" value="Add"/>
</jsp:include>

 <div class="container">

	  <div>
		  <form class="form-horizontal"  method="post">
			<fieldset>
        <legend class="legend">Add</legend>
			  	
				<div class="control-group">
					<label class="control-label" for="userid">ID</label>
					<div class="controls">
						<input type="text" name="userid" value="<%=userid%>">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label" for="image">Image</label>
					<div class="controls">
						<input type="text"  name="image" value="<%=image%>">
					</div>
				</div>

					<div class="control-group">
					<label class="control-label" for="link">Link</label>
					<div class="controls">
						<input type="text"  name="link" value="<%=link%>">
					</div>
				</div>
				


				<div class="control-group">
					<label class="control-label">Clothes</label>
					<div class="controls">
						<% for(String[] clothesOption : wear_kinds) { %> 
							<label class="radio"> 
							  <input type="radio" value="<%=clothesOption[0] %>" name="clothes"
							  <% if (clothesOption[0].equals(clothes)) { out.print("checked");} %>
							  > 
							  <%=clothesOption[1] %>
							</label>
						<% } %> 
					</div>
				</div>


				<div class="control-group">
					<label class="control-label">Season</label>
					<div class="controls">
						<% 
						for (String seasonOption: wear_seasons) {
							%>
							<label class="checkbox"> 
							  <input type="checkbox" name="seaeon" value="<%=seasonOption%>"
							  <% 
							  	if (seasonList != null && seasonList.contains(seasonOption)) { 
								  	out.print("checked");
								 	} 
								 %>
							  >
							  <%=seasonOption %>
							</label> 
							<%				
						}						
						%>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Price</label>
					<div class="controls">
						<% 
						for (String priceOption: wear_prices) {
							%>
							<label class="checkbox"> 
							  <input type="checkbox" name="price" value="<%=priceOption%>"
							  <% 
							  	if (seasonList != null && seasonList.contains(priceOption)) { 
								  	out.print("checked");
								 	} 
								 %>
							  >
							  <%=priceOption %>
							</label> 
							<%				
						}						
						%>
					</div>
				</div>
				
				<div class="form-actions">
					<a href="index.jsp" class="btn">목록으로</a>
					<% if (id <= 0) { %>
						<input type="submit" class="btn btn-primary" value="가입">
					<% } else { %>
						<input type="submit" class="btn btn-primary" value="수정">
					<% } %>
				</div>
			
				
			</fieldset>
		  </form>
    </div>
  </div>
</body>
</html>