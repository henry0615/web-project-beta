<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>
 <%
	String errorMsg = null;
	String actionUrl;
	
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/add";
	String dbUser = "web";
	String dbPassword = "asdf";
	
	//사용자 정보를 위한 변수 초기화
	String dbuserid = "";
	String dbname = "";
	String dbpwd = "";
	String dbemail = "";
	
	String getid = "";
	try {
		getid = request.getParameter("userid");
	} catch (Exception e) {}
	
	if (getid != null) {
		try {
		    Class.forName("com.mysql.jdbc.Driver");
	
		    // DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	
	 		// 질의 준비
			stmt = conn.prepareStatement("SELECT userid, pwd FROM users WHERE userid = ?");
			stmt.setString(1, getid);
			
			// 수행
	 		rs = stmt.executeQuery();
			if (rs.next()) {
				dbuserid = rs.getString("userid");
				dbpwd = rs.getString("pwd");
			}
		}catch (SQLException e) {
			errorMsg = "SQL 에러: " + e.getMessage();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}

%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Every Style</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="tab.js"></script>
</head>
<body>
	<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="Coordination" />
	</jsp:include>

	<jsp:include page="share/footer.jsp" />
</body>
</html>