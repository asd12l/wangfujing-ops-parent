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
<script src="${ctx}/js/jquery/jquery.validate.js"></script>
<script src="${ctx}/js/jquery/jquery.validate.messages_cn.js"></script>
<title>站点管理</title>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}"; 
</script>
<script src="${ctx}/jsp/web/site/js/site_edit.js"></script>
<script src="${ctx}/js/customize/common/validate.js"></script>
<script	src="${ctx}/js/customize/site/editSite.js"></script>
</head>
<body>
	<div class="page-body">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">修改站点</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="id" id="id_" value="" />
									<div class="form-group">
										<label class="col-lg-3 control-label"><span style="color:red;">*</span>站点名称</label>
										<div class="col-lg-6">
											<div class="input-icon " >
										    <i class="fa"></i>										
											<input type="text" class="form-control" id="name_"
												name="name" placeholder=""/>												
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">渠道</label>
										<div class="col-lg-6">
											<select id="channelCode_" name="channelCode" class="form-control">
											</select>
											<input type="hidden" id="channelName_" name="channelName"/>
										</div>	
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label"><span style="color:red;">*</span>域名</label>
										<div class="col-lg-6">
										    <div class="input-icon " >
										    <i class="fa"></i>										
					                        <input type="text" class="form-control" id="domain_"
												name="domain" placeholder="" onblur="getDomain()"/>												
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">站点路径</label>
										<div class="col-lg-6">
										<div class="input-icon " >
											<input type="text" class="form-control" id="site_path_"
												name="sitePath" placeholder="" />
										</div>
										</div>
									</div>	
									<div class="form-group">
										<label class="col-lg-3 control-label">资源服务器</label>
										<div class="col-lg-6">
											<select id="resource_path_" name="resource_path" class="form-control" onclick="getResPath()">
											</select>
										</div>	
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">资源路径</label>
										<div class="col-lg-6">
										<div class="input-icon " >
											<input type="text" id="resDomain"  class="form-control" disabled="true" />
											<span>说明：由资源路径+站点路径生成</span> 
										</div>
										</div>		
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">模板服务器</label>
										<div class="col-lg-6">
											<select id="tpl_path_" name="tpl_path" class="form-control" onclick="getTplPath()">
											</select>                                                     
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">模板路径</label>
										<div class="col-lg-6">
										<div class="input-icon " >
											<input type="text" id="tplDomain" class="form-control" readonly="readonly"/>
											<span>说明：由模板路径+站点路径生成</span>
										</div>
										</div>		
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">动态页后缀</label>
										<div class="col-lg-6">
											<select id="dynamicSuffix_" name="dynamicSuffix" class="form-control">
												<option value=".jhtml">.jhtml</option>
												<option value=".htm">.jspx</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">静态页后缀</label>
										<div class="col-lg-6">
											<select id="staticSuffix_" name="staticSuffix" class="form-control">
												<option value=".html">.html</option>
												<option value=".shtml">.htm</option>
											</select>
										</div>
									</div>						
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												type="button" value="保存" />&emsp;&emsp; <input
												class="btn btn-danger" style="width: 25%;" id="close"
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
	<script>
		
	</script>

</body>
</html>
