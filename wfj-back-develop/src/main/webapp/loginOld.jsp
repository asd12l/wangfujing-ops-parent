<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="common/header.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%request.setAttribute("ctx", request.getContextPath());%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>王府井中台系统登录</title>
</head>
<style>
/*css reset*/
body,p,ul,li,dl,dd{ margin:0;}
ul{ padding:0;}
input{ border:none;}
img,p{ display:block;}
input{ border-top-color:#08592a;1px;}
li{ list-style:none;}
a{ text-decoration:none; display:block;}
*{ font-family:'宋体';font-size:12px;}
.box{ width:500px; margin:auto;}
.logo{ width:280px; height:60px; margin:auto; margin-top:50px;}
.header{ font-size:28px;color:#1a1a1a; font-family:'微软雅黑'; width:248px; margin:auto; margin-top:50px;}
.denglu{ width:500px; height:360px; background-image:url(${ctx}/images/fruit.png);background-repeat:no-repeat; margin:auto; margin-top:-36px; padding-top:102px;}
.login{ font-size:16px;color:#e5e5e5; font-family:'微软雅黑'; text-align:center;}

input { width:130px; height:27px;background-color:#1e9650; border-radius:2px; border-top-color:#08592a 1px; margin:auto; margin-left:168px; margin-top:10px; text-align:center;}

.user{ font-size:16px;color:#e5e5e5; font-family:'微软雅黑'; line-height:28px;padding-left:28px; background-image:url(${ctx}/images/user.png); background-repeat:no-repeat; background-position:left center;}
.password{ font-size:16px;color:#e5e5e5; font-family:'微软雅黑'; line-height:28px;padding-left:28px; background-image:url(${ctx}/images/password.png); background-repeat:no-repeat; background-position:left center; margin-top:10px;}


.login_forgot{ width:158px; height:28px; margin:auto; margin-top:10px;}
.login_1{ float:left;}
.forgot{ float:right;}
.login_1{font-size:16px;color:#08592a; font-family:'微软雅黑'; line-height:28px; background-image:url(${ctx}/images/login.png); background-repeat:no-repeat; width:68px; text-align:center;}
.forgot{font-size:16px;color:#08592a; font-family:'微软雅黑'; line-height:28px; background-image:url(${ctx}/images/forgot_bg.png); background-repeat:no-repeat; width:78px; text-align:center;}

.dot{ background-image:url(${ctx}/images/dot.png); background-repeat:repeat-x; height:1px; margin:auto; margin-top:-58px;}
.footer{ text-align:center; margin-top:10px;}


</style>
<body style="background-image:url(${ctx}/images/bg.jpg)">
<div class="box">
	<div class="logo">
    	<img src="${ctx}/images/logo-Login.png" >
    </div>
    <div class="header">网站后台管理系统</div>
    <div class="denglu">
    	<a class="login">管理员登录</a>
    	<form action="${ctx}/security/login" method="post"  id="login">
    	<div>
			<div><input type="text" id="username" name="username" class="user" placeholder="用户名"></div>
            <div><input type="password" name="password" class="password" placeholder="密码">
            <input class="login_1" type="submit" value="登录" /></div>
            <div class="login_forgot">
            <a class="forgot" href="javascript:void(0);">忘记密码</a>
            </div>
    	</div>  
    	</form>
    </div>
	
</div>
<div class="dot"></div>
<div class="footer">Copyright (C) All rights reserved; 本系统由北京易特英才信息科技系统部提供技术支持
<div>
<%
String msg=(String)request.getParameter("error");
if("true".equals(msg)){
%>
<p><font color="red">您没有权限访问！</font></p>
<%}%>
</body>
</html>
