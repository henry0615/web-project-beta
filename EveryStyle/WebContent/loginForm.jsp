<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String actionUrl = "loginCheck.jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="로그인" />
	</jsp:include>
	
	<div class="container">
	<form action="<%=actionUrl%>" method="post">
		<fieldset>
		<legend class="legend">로그인</legend>
		
		<div class="form-group">
		<label class="form-label" for="userid">ID: </label>
		<div class="controls">
		<input type="text" name="userid">
		</div>
		</div>
		
		<div class="form-group">
		<label class="form-label" for="userid">Password: </label>
		<div class="controls">
		<input type="password" name="pwd">
		</div>
		</div>
		
		<div class="form-actions">
		<input type="submit" value="login">
		</div>
		</fieldset>
	</form>
	</div>
	<jsp:include page="share/footer.jsp" />
</body>
</html>