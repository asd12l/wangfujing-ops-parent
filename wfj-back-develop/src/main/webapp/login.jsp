<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="common/header.jsp"%>    
<%request.setAttribute("ctx", request.getContextPath());%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow-x: hidden; overflow-y: hidden;">
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/login.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/css/drag.css"/>
<script src="${ctx }/js/jquery-1.9.1.js"></script>
<script src="${ctx }/js/drag.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>王府井运营支撑系统登录</title>
<link rel="shortcut icon" href="${ctx }/images/titleLogo.png" type="image/x-icon">
</head>
<body>
<div>
	<div class="wenzi"> <img src="${ctx}/images/header.png" /> </div>
	<div class="header">Wang Fu Jing Operation support system</div>
	<form action="${ctx}/security/login" method="post"  id="login">
		<div class="box">
			<div class="kuang">
				<%-- <div style="position:relative;float: left;top: -20px;left: 162px;color: #cc324b;">
					<span>${backEnvironment }</span>
				</div> --%>
				<div class="user">
					<div class="tag"> <img  src="${ctx}/images/use.png"/> </div>
					<div class="model">
						<input type="text" id="username" name="username" placeholder=" 请输入你的账号" >
					</div>
				</div>
				<div class="password01">
					<div class="tag"> <img  src="${ctx}/images/password.png"/> </div>
					<div class="model">
						<input type="password" name="password" placeholder=" 请输入你的密码" >
					</div>
				</div>
			</div>
			<!-- <div class="captcha_div">
				<div class="captcha_but" id="drag" style="width: 380px;"></div>
			</div> -->
			
			<%-- <div class="captcha_div">
				<div class="captcha_pic" id="big_pic1" >
					<div class="captcha_big" id="big_pic">
					</div>
					<div class="captcha_lit transparent_class" id="lit_pic">
					</div>
				</div>
				<div class="captcha_but">
					<div class="captcha_sav" id="captcha_sav"></div>
					<div class="captcha_img" id="captcha_img">
						<img src="${ctx}/image/slider_valid.png">
					</div>
				</div>
			</div> --%>
			
			<div class="dianji">
				<div style="color:red;margin-top:5px;margin-left:5px;float:left;font-size:13px;">${error} </div>
				<!-- <a class="yes" href="javascript: void(0);"></a>
				<a class="mima" href="javascript: void(0);">记住密码</a> -->
				<input type="submit" style="width: 150px;line-height:0px;" class="login" value="登 录">
			</div>
		</div>
	</form>
	<div class="cloud"></div>
</div>
</body>
<!-- <script type="text/javascript">
	document.ondragstart = function() { return false;}
</script>
<script type="text/javascript">
	var rootPath = "${pageContext.request.contextPath}";
	var loadSuccessDate, captchaSuc = false;
	var startX = 0, startY = 0;
	$(document).ready(function(){
		function butMove(event){
			var butDivX = $('.captcha_but').offset().left;
			var butDivW = $('.captcha_but').width();
			var imgDivW = $('.captcha_img').width();
			
			var bigPicDivX = $('.captcha_pic').offset().left;
			var litPicDivW = $('.lit_pic').width();
			
			var minX = butDivX + imgDivW/2 + 2;
			var maxX = butDivX + butDivW - imgDivW/2 + 2;
			var minX1 = ((imgDivW-litPicDivW));
			
			if(event.pageX < minX){
				$("#captcha_img").prop("style","left: " + 2 + "px;");
				$("#lit_pic").prop("style","left: "+ 13 +"px;top :" + startY + "px;");
			} else if(event.pageX > minX && event.pageX < maxX){
				$("#captcha_img").prop("style","left: " + (event.pageX - butDivX - imgDivW/2) + "px;");
				$("#lit_pic").prop("style","left: " + (event.pageX - butDivX - imgDivW/2 + 11) + "px;top :" + startY + "px;");
			} else if(event.pageX > maxX){
				$("#captcha_img").prop("style","left: " + (butDivW - imgDivW) + "px;");
				$("#lit_pic").prop("style","left: "+ (butDivW - imgDivW +11) + "px;top :" + startY + "px;");
			}
		}
		function butDown(event){
			$(".dianji div").text("");
			$(document).bind("mousemove",butMove);
			$(document).bind("mouseup",butUp);
			$("#captcha_img").unbind("mouseout", butOut);
		}
		function butUp(event){
			$(document).unbind();
			$("#captcha_img").bind("mouseout", butOut);
			var litPicX = $("#lit_pic").position().left;
			$.ajax({
				url : rootPath+"/mycaptcha/checked",
				type : "get",
				dataType : "json",
				data : {
					"moveX" : litPicX,
					"datastr" : loadSuccessDate,
					"startX" : startX
				},
				success : function(result) {
					if(result.success){
						captchaSuc = true;
						$(".dianji div").text("验证通过！");
						setTimeout(butOut,"800")
					} else {
						loadCaptcha();
						$("#big_pic1").hide();
						$("#captcha_img").prop("style","left: " + 2 + "px;");
						$(".dianji div").text("验证错误！");
						captchaSuc = false;
					}
				}
			});
		}
		function butOver(event){
			if(!captchaSuc)
				$("#big_pic1").show();
		}
		function butOut(event){
			$("#big_pic1").hide();
		}
		function loadCaptcha(){
			$.ajax({
				url : rootPath+"/mycaptcha/getCaptcha",
				type : "get",
				dataType : "json",
				success : function(result) {
					if(result.success){
						$("#big_pic").html("<img src='"+(rootPath+result.bigPic)+"'>");
						$("#lit_pic").html("<img src='"+(rootPath+result.litPic)+"'>");
						loadSuccessDate = new Date().getTime();
						startX = result.startX;
						startY = result.startY;
						$("#lit_pic").prop("style","left: "+ 11 + "px;top :" + startY + "px;");
					}
				}
			});
		}
		loadCaptcha();
		$("#captcha_img").on({
			mousedown : butDown,
			mouseup : butUp,
			mouseover : butOver,
			mouseout : butOut 
		});
		$(".login").click(function(){
			if(captchaSuc){
				return true;
			}
			$(".dianji div").text("请验证登录！");
			return false;
		});
	});
</script> -->
<!-- <script type="text/javascript">
	var rootPath = "${pageContext.request.contextPath}";
	var loadSuccessDate, captchaSuc = false;
	var startX = 0, startY = 0;
	$(document).ready(function(){
		function butMove(event){
			var butDivX = $('.captcha_but').offset().left;
			var butDivW = $('.captcha_but').width();
			var imgDivW = $('.captcha_img').width();
			
			
			var minX = butDivX + imgDivW/2 + 2;
			var maxX = butDivX + butDivW - imgDivW/2 + 2;
			
			if(event.pageX < minX){
				$("#captcha_img").prop("style","left: " + 2 + "px;");
			} else if(event.pageX > minX && event.pageX < maxX){
				$("#captcha_img").prop("style","left: " + (event.pageX - butDivX - imgDivW/2) + "px;");
			} else if(event.pageX > maxX){
				$("#captcha_img").prop("style","left: " + (butDivW - imgDivW) + "px;");
			}
		}
		function butDown(event){
			$(document).bind("mousemove",butMove);
		}
		function butUp(event){
			$(document).unbind();
			var litPicX = $("#captcha_img").position().left;
			/* $.ajax({
				url : rootPath+"/mycaptcha/checked",
				type : "get",
				dataType : "json",
				data : {
					"moveX" : litPicX,
					"datastr" : loadSuccessDate,
					"startX" : startX
				},
				success : function(result) {
					if(result.success){
						captchaSuc = true;
						$(".dianji div").text("验证通过！");
					} else {
						$("#captcha_img").prop("style","left: " + 2 + "px;");
						captchaSuc = false;
					}
				}
			}); */
		}
		$("#captcha_img").on({
			mousedown : butDown,
			mouseup : butUp
		});
		$(".login").click(function(){
			if(captchaSuc){
				return true;
			}
			$(".dianji div").text("请验证登录！");
			return false;
		});
	});
</script> -->
<!-- <script type="text/javascript">
	$(function(){
		$("#drag").drag();
		$(".drag_text").prop("style", "width:380px;");
		/* $("#drag").prop("style", "border-radius: 15px;");
		$(".handler_bg").prop("style", "border-radius: 15px;"); */
	});
</script> -->
</html>
