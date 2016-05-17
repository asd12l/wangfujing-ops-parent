<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="common/header.jsp"%>    
<%request.setAttribute("ctx", request.getContextPath());%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow-x: hidden; overflow-y: hidden;">
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/login.css"/>
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
</html>
