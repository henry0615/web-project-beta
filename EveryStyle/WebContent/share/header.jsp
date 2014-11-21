<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String currentMenu = request.getParameter("current");
%>  
<div class="container navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="index.jsp">Every Style</a>
      </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
					<li><a class= "menu" href= "#">Coordination</a></li>
					<li><a class= "menu" href= "add.jsp">Add</a></li>
					<li><a class= "menu" href= "#">Create</a></li>
					<li><a class= "menu" href= "search.jsp">Search</a></li>
					<%if(session.getAttribute("userid") == null) {%>
					<li><a class= "menu" href= "loginForm.jsp">로그인</a></li>
					<li><a class= "menu" href= "signup.jsp">회원가입</a></li>
					<%} else {%>
					<li><a class= "menu" href= "index.jsp"><%out.println(session.getAttribute("userid"));%>님</a></li>
					<li><a class= "menu" href= "logout.jsp">로그아웃</a><li>
					<%} %>
          </ul>
        </div>
      </div>
  </div>
  <div class="container container-fluid" style="padding-top:50px">
		<h1>Every Style</h1>
 	</div>  
