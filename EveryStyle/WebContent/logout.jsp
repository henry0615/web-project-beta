<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    session.invalidate();
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
		<jsp:param name="current" value="로그아웃" />
	</jsp:include>
	
	<div class="container">
	<p>로그아웃 되었습니다.</p>
	<p><a href="index.jsp">홈화면으로 돌아가기</a></p>
	</div>
	<jsp:include page="share/footer.jsp" />
</body>
</html>