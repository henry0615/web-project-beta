<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>
<%

	String[] wear_kinds ={ "Outer", "Top", "Pants", "Skirt&Dress"};
	String[] wear_seasons ={ "Spring", "Summer", "fall", "Winter"};
	String[] wear_prices ={ "5만원 이하",  "5만원~10만원", "10만원~20만원", "20만원 이상"};
	
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
	String wear_kind = "";
	String wear_season= "";
	String wear_price ="";
	List<String> wear_seasonList = null;
	List<String> wear_priceList =null;
	String imgpath = "";
	Vector<String> imgpathList = new Vector<String>();
	Vector<Integer> idList = new Vector<Integer>();
	
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
			stmt = conn.prepareStatement("SELECT id, path FROM adds ORDER BY created_at DESC");
			//stmt.setInt(1, id);
			
			// 수행
	 		rs = stmt.executeQuery();
			
			while (rs.next()) {
				imgpathList.add(rs.getString("path"));
				idList.add(rs.getInt("id"));
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
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스타일 탐색</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>

<body>
	<jsp:include page="share/header.jsp">
  	<jsp:param name="current" value="Search"/>
  </jsp:include>
  
  <div class="container">
 
 <% for(int i=0; i<imgpathList.size(); i++ ) {%> 
			<div class="row">
  		<div class="col-sm-6 col-md-3">
  		<a href="addshow.jsp?id=<%=idList.get(i)%>">
  		<img src="<%=imgpathList.get(i) %>" class="img-thumbnail" alt="picture">
  		</a>
  		</div>
  		</div>
  <% }%>
	<%
 	if (errorMsg != null && errorMsg.length() > 0 ) {
			// SQL 에러의 경우 에러 메시지 출력
			out.print("<div class='alert'>" + errorMsg + "</div>");
	 }
	 %>
	 	<div>
	 		<div>
		  <form class="form-horizontal" action="<%=actionUrl%>" method="post">
			<fieldset>
        <legend class="legend">Search</legend>
			  	<%
			  	if (id > 0) {
			  		out.println("<input type='hidden' name='id' value='"+id+"'>");
			  	}
			  	%>			

				<div class="form-group ">
					<label class="col-sm-2 control-label">Kind</label>
					<% for(String wear_kindName : wear_kinds) { %> 
						<div  class="col-sm-offset-2 radio">
							<label> 
							  <input type="radio" value="<%=wear_kindName %>" name="wear_kind"
							  <% if (wear_kindName.equals(wear_kind)) { out.print("checked");} %>
							  > 
							  <%=wear_kindName %>
							</label>
						</div>
					<% } %> 
				</div>
				
					
					<div class="form-group ">
					<label class=" col-sm-2 control-label">Season</label>
					<% 
						for (String wear_seasonName: wear_seasons) {
					%>
						<div class="col-sm-offset-2 checkbox">
							<label> 
							  <input type="checkbox" name="wear_kinds" value="<%=wear_seasonName%>"
							  <% 
							  	if ((wear_seasonList)!= null && wear_seasonList.contains(wear_seasonName)) { 
								  	out.print("checked");
								 	} 
								 %>
							  >
							  <%=wear_seasonName %>
							</label> 
						</div>
					<%				
						}			
					%>
					</div>
					
					<div class="form-group ">
					<label class=" col-sm-2 control-label">Price</label>
					<% 
						for (String wear_priceNumber: wear_prices) {
					%>
						<div class="col-sm-offset-2 checkbox">
							<label> 
							  <input type="checkbox" name="wear_kinds" value="<%=wear_priceNumber%>"
							  <% 
							  	if ((wear_priceList) != null && wear_priceList.contains(wear_priceNumber)) { 
								  	out.print("checked");
								 	} 
								 %>
							  >
							  <%=wear_priceNumber %>
							</label> 
						</div>
					<%				
						}			
					%>
				</div>

				<div class="form-group">
					<a href="index.jsp" class="col-sm-offset-2 btn btn-default">목록으로</a>
					<% if (id <= 0) { %>
						<input type="submit" class="btn btn-default btn-primary" value="가입">
					<% } else { %>
						<input type="submit" class="btn btn-default btn-primary" value="수정">
					<% } %>
				</div>
			</fieldset>
		  </form>
    </div>
  </div>
 </div>

</body>
</html>