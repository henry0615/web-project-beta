<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.net.*" import="java.sql.*" import="java.util.*"
	import="java.io.*" import="javax.naming.*" import="javax.sql.DataSource" import="org.apache.commons.lang3.StringUtils"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="./js/jquery-1.11.1.js"></script>
<link rel="Stylesheet" type="text/css" href="./css/reset.css"/>
<link rel="Stylesheet" type="text/css" href="./css/style.css"/>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/banner.css" rel="stylesheet">
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/excanvas.js"></script>
<script type="text/javascript" src="./js/fabric.js"></script>
<title>Creating your Style!!</title>
	<script type="text/javascript">
	// create a wrapper around native canvas element (with id="c")
			
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

				var imageArr = new Array();
				var canvas = new fabric.Canvas('c');
				canvas.setHeight(300);
				canvas.setWidth(300);
				
				
				$("#reload").click(function () {
					window.location.reload();
				});
				
				$("#save").click(function () {
						var outer_left;
						var outer_top;
						var outer_id;
						var top_left;
						var top_top;
						var top_id;
						var pants_left;
						var pants_top;
						var pants_id;
						var skirtdress_left;
						var skirtdress_top;
						var skirtdress_id;
						
	            for(var i = 0 ; i<imageArr.length; i++){
	            	if (imageArr[i]._element.classList[0] === 'Outer'){
	            		outer_left = imageArr[i].left;
	            		outer_top = imageArr[i].top;
	            		outer_id = imageArr[i]._element.id;
	            	} else if (imageArr[i]._element.classList[0] === 'Top') {
	            		top_left = imageArr[i].left;
	            		top_top = imageArr[i].top;
	            		top_id = imageArr[i]._element.id;
	            	} else if (imageArr[i]._element.classList[0] === 'Pants') {
	            		pants_left = imageArr[i].left;
	            		pants_top = imageArr[i].top;
	            		pants_id = imageArr[i]._element.id;
	            	} else if (imageArr[i]._element.classList[0] === 'Skirt&Dress') {
	            		skirtdress_left = imageArr[i].left;
	            		skirtdress_top = imageArr[i].top;
	            		skirtdress_id = imageArr[i]._element.id;
	            	}
	            }
	            if(imageArr[0]._element.classList[0] != null) {
	            	$.ajax({
	 								type:"POST",
	 								url:"./createSave.jsp",
	 								data:{outer_left:outer_left, outer_top:outer_top, outer_id:outer_id, top_left:top_left, top_top:top_top,
	 									top_id:top_id, pants_left:pants_left, pants_top:pants_top, pants_id:pants_id,
	 									skirtdress_left:skirtdress_left, skirtdress_top:skirtdress_top, skirtdress_id:skirtdress_id},
	 								success : alert("저장되었습니다."),
	 								error: function(xhr, textStatus, errorThrown) { alert("저장에 실패했습니다."); }
	 							})
	 							console.log(outer_left + ',' + outer_top + ',' + outer_id);
		        		console.log(top_left + ',' + top_top + ',' + top_id);
		        		console.log(pants_left + ',' + pants_top + ',' + pants_id);
		        		console.log(skirtdress_left + ',' + skirtdress_top + ',' + skirtdress_id);
	            } else {
	            	 alert("옷을 코디해주세요.");
	            }
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
							imageProcessingInit(imageArr, canvas,'canvas-container','#clothImg');	//image저장 배열, canvas객체, canvas를 감싼 div의 id,드래그앤 드랍을 허용할 div id <- 이 두가지 parameter를 넣어야함
						},
						error : function (request,status,error) {
							alert(request + "\n" + status + "\n" + error);
						}
					});
				});
			});
			
			function imageProcessingInit(imageArr,canvas,canvasDivID,imageforDD){
				// Bind the event listeners for the image elements
			    var images = document.querySelectorAll(imageforDD + ' img');
			    [].forEach.call(images, function (img) {
			        img.addEventListener('dragstart', function handleDragStart(e) {
					    [].forEach.call(images, function (img) {
					        img.classList.remove('img_dragging');
					    });
					    this.classList.add('img_dragging');
					}, false);
			        img.addEventListener('dragend', function handleDragEnd(e) {
					    // this/e.target is the source node.
					    [].forEach.call(images, function (img) {
					        img.classList.remove('img_dragging');
					    });
					}, false);
			    });
			    // Bind the event listeners for the canvas
			    var canvasContainer = document.getElementById(canvasDivID);
			    canvasContainer.addEventListener('dragenter', function handleDragEnter(e) {
				    // this / e.target is the current hover target.
				    this.classList.add('over');
				}, false);
			    canvasContainer.addEventListener('dragover', function handleDragOver(e) {
				    if (e.preventDefault) {
				        e.preventDefault(); // Necessary. Allows us to drop.
				    }
				
				    e.dataTransfer.dropEffect = 'copy'; // See the section on the DataTransfer object.
				    // NOTE: comment above refers to the article (see top) -natchiketa
				
				    return false;
				}, false);
			    canvasContainer.addEventListener('dragleave', function handleDragLeave(e) {
				    this.classList.remove('over'); // this / e.target is previous target element.
				}, false);
			    canvasContainer.addEventListener('drop', function handleDrop(e) {    
			        // this / e.target is current target element.

			        /*
			        if (e.stopPropagation) {
			            e.stopPropagation(); // stops the browser from redirecting.
			        }
			        */

			        e.stopPropagation(); // Stops some browsers from redirecting.
			        e.preventDefault(); // Stops some browsers from redirecting.

			        // handle browser images
			           var img = document.querySelector(imageforDD + ' img.img_dragging');
			            var newImage = new fabric.Image(img, {
			                width: img.width,
			                height: img.height,
			                // Set the center of the new object based on the event coordinates relative to the canvas container.
			                left: e.layerX,
			                top: e.layerY
			            });
			            console.log(newImage);
			            imageArr.push(newImage);
			            canvas.add(newImage); 

			        return false;
			    }, false);
				
			}
		</script>
</head>
<body>
	 <jsp:include page ="share/header.jsp">
		<jsp:param name="current" value="create"/>
	</jsp:include> 
	<div class="container">
			<div id="blankDiv">
				<h2>스타일링</h2>
				<div id="canvas-container">
				<canvas id="c" style="border:1px solid #000000;" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;">
							<div id="top" class="Top" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
				</canvas>
				</div>	
				
				<!-- <div id="canvas">
				<div id="outer" class="Outer" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
				<div id="top" class="Top" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
				<div id="pants" class="Pants" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
				<div id="skirtdress" class="Skirt" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
				</div> -->
				<!-- <table id="styleTable">
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
							<div id="Skirt&Dress" class="Skirt&Dress" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
						</td>
					</tr>
				</table> -->
			</div>
			
			
			<div id="styleDiv">
				<h2>선택할 옷</h2>
				<div class="table-responsive">
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
							<a href="#"><img src="./img/Skirt&Dress.PNG" class="category" id="Skirt&Dress"><br>
							<span class="category" id="Skirt&Dress">Skirt&Dress</span></a>
						</td>
					</tr>
				</table>
				</div>
				
				<div id="clothImg" ondrop="drop(this, event);" ondragenter="return false;" ondragover="return false;"></div>
				
			</div>
			<input type="button" action="createSave.jsp" value="원위치" id="reload">
			<input type="submit" value="저장" id="save">
	
	</div>
</body>
</html>