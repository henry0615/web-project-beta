<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	List<String> errorMsgs = new ArrayList<String>();

	String dbUrl = "jdbc:mysql://localhost:3306/signup";
	String dbUser = "web";
	String dbPassword = "asdf";
	String category = request.getParameter("category");

	try {
		Class.forName("com.mysql.jdbc.Driver");

		// DB 접속
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt = conn.prepareStatement("SELECT id, path FROM adds WHERE clothes LIKE ?");
		stmt.setString(1, "%"+category+"%");
		rs = stmt.executeQuery();
		
		ArrayList<String> pathList = new ArrayList<String>();
		ArrayList<String> idList = new ArrayList<String>();
		while (rs.next()) {
			pathList.add(rs.getString("path"));
			idList.add(rs.getInt("id")+"");
		}
		
		for (int i = 0;i < pathList.size();++i) {
			response.getWriter().print(pathList.get(i) + "," + idList.get(i));
			if (i + 1 < pathList.size()) {
				response.getWriter().println("@");
			}
		}

	} catch (SQLException e) {
		errorMsgs.add("SQL 에러: " + e.getMessage());
	} finally {
		// 무슨 일이 있어도 리소스를 제대로 종료
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException e) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException e) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException e) {
			}
	}
%>