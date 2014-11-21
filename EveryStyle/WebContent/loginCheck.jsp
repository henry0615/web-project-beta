<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>

<%
	String errorMsg = null;
	String actionUrl;
	
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/signup";
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
<title>Insert title here</title>
</head>
<body>
	<%
	if (request.getMethod().equals("POST")){
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		if(userid == null || pwd == null || userid.length() == 0 || pwd.length() == 0) {
			%>
			<div>아이디와 비밀번호를 입력하세요.</div>
			<%
		} else if (userid.equals(dbuserid) && pwd.equals(dbpwd)) {
			//로그인 성공
			session.setAttribute("userid", dbuserid);
			response.sendRedirect("index.jsp");
		} else {
			%>
			<div>아이디나 비밀번호가 잘못되었습니다.</div>
			<%
		}
	}
	%>
</body>
</html>