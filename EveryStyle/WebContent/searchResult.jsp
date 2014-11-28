<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
String[] wear_kinds = {"Outer", "Top", "Pants", "Skirt&Dress"};
String[] wear_seasons = {"Spring", "Summer", "Fall", "Winter"};
String[] wear_prices= {"1~2만원", "2~3만원", "3~4만원", "4~5만원","5만원이상" };

String actionUrl = null;
//DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/signup";
	String dbUser = "web";
	String dbPassword = "asdf";
	//search로부터 받는 옵션 변수
	request.setCharacterEncoding("utf-8");
	String RuseridOption = request.getParameter("userid");
	if(RuseridOption == null) {
		RuseridOption = "";
	}
	String RclothesOption = request.getParameter("clothesOption");
	if(RclothesOption == null) {
		RclothesOption = "";
	}
	String[] RseasonOption = request.getParameterValues("seasonOption");
	String RseasonOptionStr = StringUtils.join(RseasonOption, ",");
	if(RseasonOptionStr == null) {
		RseasonOptionStr = "";
	}
	String RpriceOption = request.getParameter("priceOption");
	if(RpriceOption == null) {
		RpriceOption = "";
	}
	
	String userid = "";
	String clothes = "";
	String season= "";
	String price ="";
	List<String> seasonList = null;
	List<String>priceList =null;
	
	//db로부터 받는 변수
	Vector<Integer> idList = new Vector<Integer>();
	Vector<String> useridList = new Vector<String>();
	Vector<String> clothesNameList = new Vector<String>();
	Vector<String> pathList = new Vector<String>();
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		
	    // DB 접속
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

 		// 질의 준비
		stmt = conn.prepareStatement("SELECT id, userid, clothesName, path FROM adds WHERE clothes LIKE ? AND season LIKE ? AND price LIKE ? AND userid LIKE ?");
		stmt.setString(1, "%" + RclothesOption + "%");
		stmt.setString(2, "%" + RseasonOptionStr + "%");
		stmt.setString(3, "%" + RpriceOption + "%");
		stmt.setString(4, "%" + RuseridOption + "%");
		
		// 수행
 		rs = stmt.executeQuery();
		while (rs.next()) {
			idList.add(rs.getInt("id"));
			useridList.add(rs.getString("userid"));
			clothesNameList.add(rs.getString("clothesName"));
			pathList.add(rs.getString("path"));
		}
	} catch (SQLException e) {
		errorMsgs.add("SQL 에러: " + e.getMessage());
	} finally {
		// 무슨 일이 있어도 리소스를 제대로 종료
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
<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="share/header.jsp">
 <jsp:param name="current" value="Search" />
</jsp:include>

 <div class="container">

 <div class="row">
		  <% for(int i=0; i<pathList.size(); i++ ) {%> 
  		<div class="col-sm-6 col-md-3">
  		<a href="addshow.jsp?id=<%=idList.get(i)%>">
  		<img src="<%=pathList.get(i) %>" class="img-thumbnail" alt="picture"/>
  		<%out.println(clothesNameList.get(i)); %>
  		</a>
  		</div>
  		<% }%>
 </div>
 </div>
</body>
</html>