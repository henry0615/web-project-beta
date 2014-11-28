<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
//Outer=top , Top=bottom, Pants=bag, Skirt&Dress=shoes-->


%>






<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Creating your Style!!</title>
</head>
<body>
	<jsp:include page ="share/header.jsp">
		<jsp:param name="current" value="create"/>
	</jsp:include>

 	<table id ="create_box" class="wide" cellpadding="0" cellspacing="8" style="height:300px;">
 		<tbody>
 			<tr valign ="top" height="100%">
 				<td id ="container" width="60%">
 					<div id="canvas" trackcontext="canvas" class="fill" _uid="76" style= "height:291px;">
 						<div class="statusbar" _uid="119">
 							<div id="statustext" class="info">
 								"오른쪽의 의류들을 상자에 추가해보세요."	
 							</div>
 						</div>
 						<div class="SideMenu" _uid="135">
 							<ul class="toolbar vertical controls canvasactions unselectable" _uid="136"
 							unselectable="on" style=" display:block; visibility: inherit;">
 							 <li class ="controls" style="display:block; visibility:inherit;">
 							 	<button id="clearph_btn" class="txt" trackelement="clearph_btn" _uid="204"
 							 	title disabled="true">Restart</button>
 							 </li>
 							</ul>
 						</div>
 						
						<div class="item selectNode placeholder empty unselectable droppable"
 						_uid="418" unselectable="on" style="left:401.386px; top: 62.843px; z-index:1;-webkit-transform: matrix(0.99574, -0.09229, 0.99574,0,0);
 						width:97px; height: 186px;">
 							<div class="bg"></div>
 							<div class="ph_hint unselectable" _uid="416" unselectable="on" style="font-size:1.24em; display:block; visibility:inherit;">Top</div>
 						</div>
 						
 						<div class="item selectNode placeholder unselectable droppable empty" _uid="431" unselectable="on" style="left: 321.725px; top: 69.467px; z-index:2;-webkit-transform:matrix(1,0,0,1,0,0): 
 						width: 110px; height:131px;">
 							<div class="bg"></div>
 							<div class="ph_hint unselectable" _uid="430" unselectable="on" style="font-size:1.39em; display:block; visibility:inherit;">Outer</div>
 						</div>
 							
 						<div class="item selectNode placeholder empty unselectable droppable" _uid="439" unselectable="on" style="left: 398.578px; top: 174.644px; z-index:3;-webkit-transform: matrix(0.99824, -0.05926, 0.05926, 0.99824,0,0); 
 						width: 86px; height:75px;">
 							<div class="bg"></div>
 							<div class="ph_hint unselectable" _uid="438" unselectable="on" style="font-size:0.98em; display:block; visibility:inherit;">Pants</div>
 						</div>
 						
 						<div class="item selectNode placeholder empty unselectable droppable" _uid="454" unselectable="on" style="left:336.079px; top:169.869px; z-index:4; -webkit-transform:matrix(0.90439, 0.42666, -0.42666, 0.90439 ,0 ,0);
 						width: 72px; height:62px;">
 							<div class="bg"></div>
 							<div class="ph_hint unselectable" _uid="453" unselectable="on" style="font-size:0.83em; display:block; visibility:inherit;">Skirt&dress</div>
 						</div>
 					</td>
 					<td width="40%">
 							
 						
 						
 						
 						
 						
 						
 						
 		</tbody>
	</table>
	

	
</body>
</html>