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
			<div class="kuang" style="padding-top: 30px;">
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
			
			<div class="captcha_div">
				<div class="captcha_pic" id="big_pic1" >
					<div class="captcha_big" id="big_pic">
					</div>
					<div class="captcha_lit transparent_class" id="lit_pic">
					</div>
				</div>
				<div class="captcha_but">
					<div class="captcha_sav" id="captcha_sav"></div>
					<div class="captcha_img" id="captcha_img">
						<img src="${ctx}/image/slider.png" height="37" id="validImg">
					</div>
				</div>
			</div>
			
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
<script type="text/javascript">
	document.ondragstart = function() { return false;}
</script>
<script type="text/javascript">
	var rootPath = "${pageContext.request.contextPath}";
	var loadSuccessDate, captchaSuc = false;
	var startX = 0, startY = 0, maxRandomNum = "";
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
			console.log(butDivX+"  "+butDivW+"  "+imgDivW);
			if(event.pageX < minX){
				$("#captcha_img").attr("style","left: " + 2 + "px;");
				$("#lit_pic").attr("style","left: "+ 12 +"px;top :" + startY + "px;");
			} else if(event.pageX > minX && event.pageX < maxX){
				$("#captcha_img").attr("style","left: " + (event.pageX - butDivX - imgDivW/2) + "px;");
				$("#lit_pic").attr("style","left: " + (event.pageX - butDivX - imgDivW/2 + 12) + "px;top :" + startY + "px;");
			} else if(event.pageX > maxX){
				$("#captcha_img").attr("style","left: " + (butDivW - imgDivW) + "px;");
				$("#lit_pic").attr("style","left: "+ (butDivW - imgDivW + 12) + "px;top :" + startY + "px;");
			}
		}
		function butDown(event){
			$(".dianji div").text("");
			$("#validImg").attr("src", rootPath + "/image/slider.png"); 
			$(document).bind("mousemove",butMove);
			$(document).bind("mouseup",butUp);
			$("#captcha_img").unbind("mouseout", butOut);
			$("#lit_pic").addClass("alpha");
		}
		function butUp(event){
			$(document).unbind();
			$("#lit_pic").removeClass("alpha");
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
						$("#validImg").attr("src", rootPath + "/image/slider_valid.png");
						setTimeout(butOut,"800");
					} else {
						$("#validImg").attr("src", rootPath + "/image/slider_invalid.png");
						loadCaptcha();
						$("#big_pic1").hide();
						$("#captcha_img").attr("style","left: " + 2 + "px;");
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
				data : {
					"maxRandomNum" : maxRandomNum
				},
				success : function(result) {
					if(result.success){
						$("#big_pic").html("<img src='"+(rootPath+result.bigPic)+"'>");
						$("#lit_pic").html("<img src='"+(rootPath+result.litPic)+"'>");
						loadSuccessDate = new Date().getTime();
						startX = result.startX;
						maxRandomNum = result.maxRandomNum;
						$("#lit_pic").attr("style","left: 0px;top: 0px;");
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
</script>
</html>
