<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String actionUrl;

//사용자 정보를 위한 변수 초기화
String userid = "";
String name = "";
String pwd = "";
String email = "";


%> 


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Every Style</title>
</head>
<body>
	<jsp:include page="Share/header.jsp"></jsp:include>
	
	<form class="signupform" method="post">
	
	<fieldset>
	<div id="legend">
	<legend>회원가입</legend>
	</div>
	
	<div class="control-group">
	<label class="control-label">아이디</label>
	<div class="controls">
	<input type="text" name="id">
	</div>
	</div>
	
	<div class="control-group">
	<label class="control-label">비밀번호</label>
	<div class="controls">
	<input type="password" name="pwd">
	</div>
	</div>
	
	<div class="control-group">
	<label class="control-label">이름</label>
	<div class="controls">
	<input type="text" name="name">
	</div>
	</div>
	
	<div class="control-group">
	<label class="control-label">e-mail</label>
	<div class="controls">
	<input type="text" name="email">
	</div>
	</div>
	
	<div class="form-actions">
	<input type="reset" class="btn btn-primary" value="취소">
	<input type="submit" class="btn btn-primary" value="가입">
	</div>
	</fieldset>
	</form>
	
	<jsp:include page="Share/footer.jsp"></jsp:include>
</body>
</html>