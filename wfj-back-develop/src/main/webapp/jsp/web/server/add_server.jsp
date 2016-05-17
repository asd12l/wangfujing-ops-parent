<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("ctx", request.getContextPath());
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/js/bootstrap/bootstrap.min.js"></script>
<link href="${ctx}/js/bootstrap/css/components.css" rel="stylesheet" type="text/css" />
<script 
	src="${pageContext.request.contextPath}/js/customize/common/validate.js"></script>
<script src="${ctx}/js/jquery/jquery.validate.js"></script>
<script src="${ctx}/js/jquery/jquery.validate.messages_cn.js"></script>
<title>FTP管理</title>
<script type="text/javascript">
__ctxPath = "${pageContext.request.contextPath}";
</script>
<script	src="${pageContext.request.contextPath}/js/customize/server/addServer.js"></script>
</head>
<body>
	<div class="page-body">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">添加webServer</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<div class="form-group">
										<label class="col-lg-3 control-label"><span style="color:red;">*</span>名称</label>
										<div class="col-lg-6">
										   <div class="input-icon " >
										    <i class="fa"></i>										
											<input type="text" class="form-control" id="name"
												name="name" placeholder="" />												
											</div>											
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label"><span style="color:red;">*</span>站点</label>
										<div class="col-lg-6">
										    <div class="input-icon " >
										    <i class="fa"></i>										
											<select id="siteId" name="siteId" class="form-control">
											</select>												
											</div>											
										</div>	
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">服务器IP</label>
										<div class="col-lg-6">
										    <div class="input-icon " >
										    <i class="fa"></i>										
											<input type="text" class="form-control" id="ip"
												name="ip" placeholder="" />											
											</div>											
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">WebServer端口号</label>
										<div class="col-lg-6">
										    <div class="input-icon " >
										    <i class="fa"></i>										
											<input type="text" class="form-control" id="port"
												name="port" value="22" placeholder="" />										
											</div>											
										</div>
									</div>
									<div class="form-group" ref="serveruser">
										<label class="col-lg-3 control-label">WebServer用户名</label>
										<div class="col-lg-6">
											<div class="input-icon " >
										    <i class="fa"></i>										
											<input type="text" class="form-control" id="username"
												name="username" placeholder="" />										
											</div>
										</div>
									</div>
									<div class="form-group" ref="serverpwd">
										<label class="col-lg-3 control-label">WebServer密码</label>
										<div class="col-lg-6">
											<div class="input-icon " >
										    <i class="fa"></i>										
											<input type="password" class="form-control" id="password"
												name="password" placeholder="" />										
											</div>	
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">WebServer类型</label>
										<div class="col-lg-5">
											<div class="radio" id="webType" onclick="set();">
												<label>
													<input class="basic" type="radio" id="isErpProp_0" checked="checked" name="type" value="0">
													<span class="text">静态</span>
												</label>
												<label>
													<input class="basic" type="radio" id="isErpProp_1" name="type" value="1">
													<span class="text">动态</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label>
													<input class="inverted" type="radio" name="type">
													<span class="text"></span>
												</label>
											</div>
										</div>
									</div>
									<div class="form-group path">
										<label ref="label_path" class="col-lg-3 control-label">远程目录</label>
										<div class="col-lg-6">
										    <div class="input-icon " >
										    <i class="fa"></i>										
											<input type="text" class="form-control" id="path"
												name="path" value="/" placeholder="" />										
											</div>											
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">编码</label>
										<div class="col-lg-6">
										    <div class="input-icon " >
										    <i class="fa"></i>										
											<select id="encoding" name="encoding" class="form-control">
												<option value="UTF-8">UTF-8</option>
												<option value="GBK">GBK</option>
											</select>											
											</div>											
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												type="button" value="返回" />
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /Page Body -->
</body>
</html>