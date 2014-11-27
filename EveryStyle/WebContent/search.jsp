<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils" %>
<%

	String[] wear_kinds ={ "Outer", "Top", "Pants", "Skirt&Dress"};
	String[] wear_seasons ={ "Spring", "Summer", "fall", "Winter"};
	String[] wear_prices ={ "1~2만원",  "2~3만원", "3~4만원", "4~5만원","5만원이상"};
	
	String errorMsg = null;

	String actionUrl;
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
	
	
 	// Request로 ID가 있는지 확인
	int id = 0;

	try {
		id = Integer.parseInt(request.getParameter("id"));
		
	} catch (Exception e) {}

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
				wear_kind = rs.getString("wear_kind");
				wear_season = rs.getString("wear_season");
				wear_price = rs.getString("wear_price");


				if (wear_season != null && wear_season.length() > 0) {
					wear_seasonList = Arrays.asList(StringUtils.split(wear_season, ","));
				}
				
				if (wear_price != null && wear_price.length() > 0) {
					wear_priceList = Arrays.asList(StringUtils.split(wear_price, ","));
				}
			}
			
		}catch (SQLException e) {
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
	<%
 	if (errorMsg != null && errorMsg.length() > 0 ) {
			// SQL 에러의 경우 에러 메시지 출력
			out.print("<div class='alert'>" + errorMsg + "</div>");
	 }
	 %>
	 	<div>
	 		<div>
		  <form class="form-horizontal" action="check.jsp"  method="post">
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
							  <input type="radio" name="wear_kinds" value="<%=wear_kindName %>" 
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
					<input type="submit"  class="btn btn-default btn-primary" value="검색"></a>
				</div>
						
				
			</fieldset>
		  </form>
    </div>
  </div>
 </div>

</body>
</html>
