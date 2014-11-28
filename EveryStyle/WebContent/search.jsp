<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>
<%

String[] wear_kinds = {"Outer", "Top", "Pants", "Skirt&Dress"};
String[] wear_seasons = {"Spring", "Summer", "Fall", "Winter"};
String[] wear_prices= {"1~2만원", "2~3만원", "3~4만원", "4~5만원","5만원이상" };
	
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
	String userid = "";
	String clothes = "";
	String season= "";
	String price ="";
	List<String> seasonList = null;
	List<String>priceList =null;
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
		actionUrl = "searchResult.jsp";

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
		  <form class="form-horizontal" action="<%=actionUrl%>" method="post" target="frame">
			<fieldset>
        <legend class="legend">Search</legend>
			  	<%
			  	if (id > 0) {
			  		out.println("<input type='hidden' name='id' value='"+id+"'>");
			  	}
			  	%>
			  	
			  	<div class="row">
			  	
			  	<div class="col-lg-3">
			  	<div class="form-group ">
					<label class="col-sm-2 control-label">Kind</label>
					<% for(String clothesOption : wear_kinds) { %> 
						<div  class="col-sm-offset-3 radio">
							<label> 
							  <input type="radio" value="<%=clothesOption%>" name="clothesOption"
							  <% if (clothesOption.equals(clothes)) { out.print("checked");} %>
							  > 
							  <%=clothesOption%>
							</label>
						</div>
					<%
						}
					%> 
				</div>
				</div>
				
					<div class="col-lg-3">
					<div class="form-group ">
					<label class="col-sm-2 control-label">Season</label>
					<% for (String seasonOption: wear_seasons) {	%>
						<div class="col-sm-offset-3 checkbox">
							<label> 
							  <input type="checkbox" name="seasonOption" value="<%=seasonOption%>"
							  <% 
							  	if ((seasonList)!= null && seasonList.contains(seasonOption)){ 
								  	out.print("checked");
								 	} 
								 %>
							  >
							  <%=seasonOption  %>
							</label> 
						</div>
					<%				
						}			
					%>
					</div>
					</div>
					
					<div class="col-lg-3">
					<div class="form-group ">
					<label class=" col-sm-2 control-label">Price</label>
					<% for (String priceOption: wear_prices) {	%>
						<div class="col-sm-offset-3 checkbox">
							<label> 
							  <input type="checkbox" name="priceOption" value="<%=priceOption%>"
							  <% 
							  	if ((priceList) != null && priceList.contains(priceOption)) { 
								  	out.print("checked");
								 	} 
								 %>
							  >
							  <%=priceOption %>
							</label> 
						</div>
					<%				
						}			
					%>
				</div>
				</div>
				
				<div class="col-lg-3">
					<div class="form-group ">
					<label class="col-sm-2 control-label">ID</label>
							<label> 
							  <input type="text" name="userid" value="<%=userid%>">
							</label> 
						</div>
					</div>
				
</div>
				<div class="form-group">
					<a href="search.jsp" class="col-sm-offset-2 btn btn-default">목록으로</a>
						<input type="submit" class="btn btn-success" value="검색">
				</div>
			</fieldset>
		  </form>
		  <!-- 최신 순으로 나열 -->
		 
		  <div class="row">
		  <% for(int i=0; i<imgpathList.size(); i++ ) {%> 
  		<div class="col-sm-6 col-md-3">
  		<a href="addshow.jsp?id=<%=idList.get(i)%>">
  		<img src="<%=imgpathList.get(i) %>" class="img-thumbnail" alt="picture"/>
  		</a>
  		</div>
  		<% }%>
  		</div>
  		<iframe name="frame"></iframe>
    </div>
<jsp:include page="share/footer.jsp" />
</body>
</html>