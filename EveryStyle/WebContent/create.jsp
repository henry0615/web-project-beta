<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="Stylesheet" type="text/css" href="./css/reset.css"/>
<link rel="Stylesheet" type="text/css" href="./css/style.css"/>
<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/jquery-1.11.1.js"></script>
<title>Creating your Style!!</title>
	<script type="text/javascript">
			function drag(target, cloth) {		//드래그 시작시 호출 할 함수
				
				cloth.dataTransfer.setData('id', target.id);
				cloth.dataTransfer.setData('class', target.getAttribute('class'));
				cloth.dataTransfer.setData("path", target.getAttribute("src"));
			};
			function drop(target, cloth) {		//드롭시 호출 할 함수
				var id = cloth.dataTransfer.getData('id');
				var cClass = cloth.dataTransfer.getData('class');
				var targetClass = target.getAttribute('class');
				var path = cloth.dataTransfer.getData("path");
				
				id = id.replace(/(^\s*)|(\s*$)/gi, "");
				if (cClass == targetClass) 	{
					var element = document.createElement("img");
					element.setAttribute("src", path);
					element.setAttribute("id", id);
					
					target.appendChild(element);
					//target.appendChild(document.getElementById(id));
				}
				else alert("올바른 위치에 놓아주세요");
				cloth.preventDefault();
			};
			
			$(document).ready(function () {
				
				$("#reload").click(function () {
					window.location.reload();
				});
				
				$("#save").click(function () {
					var outer = $("#outer img").attr("id");
					var top = $("#top img").attr("id");
					var pants = $("#pants img").attr("id");
					var skirtdress = $("#skirtdress img").attr("id");
					alert((top != undefined?top:"null"));
					
					$.ajax({
						type:"POST",
						url:"./createSave.jsp",
						data:{outer:outer, top:top, pants:pants, skirtdress:skirtdress},
						
					})
				});
				
				$(".category").click(function () {
					var category = $(this).attr("id");
					$("#clothImg").find("img").remove();
					$("#clothImg").attr("class", category);
					
					$.ajax({
						type:"POST",
						url:"./createSystem.jsp",
						data:{category:category},
						success : function (result) {
							var clothes = result.split("@");
							var div = $("#clothImg");
							for (var i = 0;i < clothes.length;++i) {
								var temp = clothes[i].split(",");
								div.append("<img src='"+temp[0]+"' id='"+temp[1]+"' draggable='true'  class='"+category+"' ondragstart='drag(this, event)'>");
								if (i % 4 == 3) {
									div.append("<br>");
								}
							}
						},
						error : function (request,status,error) {
							alert(request + "\n" + status + "\n" + error);
						}
					});
				});
			});
		</script>
</head>
<body>
	 <jsp:include page ="share/header.jsp">
		<jsp:param name="current" value="create"/>
	</jsp:include> 
	<div class="container">
			<div id="blankDiv">
				<h2>스타일링</h2>
				<table id="styleTable">
					<tr>
						<td>
							<div id="outer" class="Outer" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
						</td>
						<td>
							<div id="top" class="Top" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
						</td>
					</tr>
					<tr>
						<td>
							<div id="pants" class="Pants" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
						</td>
						<td>
							<div id="skirtdress" class="Skirt" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
						</td>
					</tr>
				</table>
			</div>
			
			
			<div id="styleDiv">
				<h2>선택할 옷</h2>
				<table id="categoryList">
					<tr>
						<td>
							<a href="#"><img src="./img/Outer.PNG" class="category" id="Outer"><br>
							<span class="category" id="Outer">Outer</span></a>
						</td>
						<td>
							<a href="#"><img src="./img/Top.PNG" class="category" id="Top"><br>
							<span class="category" id="Top">Top</span></a>
						</td>
						<td>
							<a href="#"><img src="./img/Pants.PNG" class="category" id="Pants"><br>
							<span class="category" id="Pants">Pants</span></a>
						</td>
						<td>
							<a href="#"><img src="./img/Skirt&Dress.PNG" class="category" id="Skirt"><br>
							<span class="category" id="Skirt">Skirt</span></a>
						</td>
					</tr>
				</table>
				
				<!-- <table id="clothImg">
					
				</table>-->
				<div id="clothImg" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
				
				<!-- <div id="outerListDiv" class="outerType" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;">
					<img src="./img/Outer.PNG" draggable="true" id="outerImg" class="outerType" ondragstart="drag(this, event)" />
				</div>
				<div id="topListDiv" class="topType" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;">
					<img src="./img/Top.PNG" draggable="true" id="topImg" class="topType" ondragstart="drag(this, event)" />
				</div>
				<div id="pantsListDiv" class="pantsType" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;">
					<img src="./img/Pants.PNG" draggable="true" id="pantsImg" class="pantsType" ondragstart="drag(this, event)" />
				</div>
				<div id="skirtdressListDiv" class="skirtdressType" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;">
					<img src="./img/Skirt&Dress.PNG" draggable="true" id="skirtdressImg" class="skirtdressType" ondragstart="drag(this, event)"/>
				</div>-->
			</div>
			<input type="button" value="원위치" id="reload">
			<input type="button" value="저장" id="save">
	
	</div>
</body>
</html>