<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">
	
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">
	
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js">
	
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsp/web/css/webStyle.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>FTP管理</title>
<script
	src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var sessionId = "<%=request.getSession().getId() %>";
</script>
<script	src="${pageContext.request.contextPath}/js/customize/server/serverlist.js"></script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="widget">
					<div class="widget-header ">
						<h5 class="widget-caption">webServer管理</h5>
						<div class="widget-buttons">
							<a href="#" data-toggle="maximize"></a> <a href="#"
								data-toggle="collapse" onclick="tab('pro');"> <i
								class="fa fa-minus" id="pro-i"></i>
							</a> <a href="#" data-toggle="dispose"></a>
						</div>
					</div>
					<div class="widget-body" id="pro">
						<div class="btn-group clearfix">
                           		<a id="editabledatatable_add" onclick="addDir();" class="btn btn-primary glyphicon glyphicon-plus">
								添加资源</a>&nbsp;&nbsp;
                          		<a id="editabledatatable_del" onclick="delDir();" class="btn btn-danger glyphicon glyphicon-trash">
								删除资源</a>
                           		<a id="editabledatatable_edit" onclick="editDir();" class="btn btn-info glyphicon glyphicon-wrench">
								编辑资源</a>
						</div>
						<div class="table-toolbar">
							<table
								class="table table-bordered table-striped table-condensed table-hover flip-content"
								id="ftp_tab">
								<thead class="flip-content bordered-darkorange">
									<tr>
										<th style="text-align: center;" width="75px;">选择</th>
										<th style="text-align: center;">编码</th>
										<th style="text-align: center;">名称</th>
										<th style="text-align: center;">站点</th>
										<th style="text-align: center;width:300px;">服务器IP</th>
										<th style="text-align: center;">远程目录</th>
										<th style="text-align: center;">端口号</th>
										<th style="text-align: center;">WebServer类型</th>
										<th style="text-align: center;">操作</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<!-- Templates -->
						<p style="display: none">
							<textarea id="ftp-list" rows="0" cols="0">
							<!-- 
							{#template MAIN}
								{#foreach $T.list as Result}
									<tr class="gradeX">
										<td align="left">
											<div class="checkbox">
												<label>
													<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
													<span class="text"></span>
												</label>
											</div>
										</td>
										<input type='hidden' id='password_{$T.Result.sid}' value='{$T.Result.password}'/>
										<input type='hidden' id='username_{$T.Result.sid}' value='{$T.Result.username}'/>
										<input type='hidden' id='encoding_{$T.Result.sid}' value='{$T.Result.encoding}'/>
										<input type='hidden' id='type_{$T.Result.sid}' value='{$T.Result.type}'/>
										<input type='hidden' id='siteId_{$T.Result.sid}' value='{$T.Result.site_id}'/>
										<td align="center" id="id_{$T.Result.sid}">{$T.Result.sid}</td>
										<td align="center" id="name_{$T.Result.sid}">{$T.Result.server_name}</td>
										<td align="center" id="siteName_{$T.Result.sid}">{$T.Result.site_name}</td>
										<td align="center" id="ip_{$T.Result.sid}">{$T.Result.ip}</td>
										{#if $T.Result.server_path!=""}
											<td align="center" id="path_{$T.Result.sid}">{$T.Result.server_path}</td>
						       			{#else}
											<td align="center">— —</td>
										{#/if}
										<td align="center" id="port_{$T.Result.sid}">{$T.Result.port}</td>
										{#if $T.Result.type==0}
											<td align="center" id="">静态</td>			
											<td align="center" id=""><a style="cursor:pointer;" unable="true" onclick="initStatic({$T.Result.sid});">静态化</a></td>
										{#elseif $T.Result.type==1}
											<td align="center" id="">动态</td>
											<td align="center" id=""><a style="cursor:pointer;" name="{$T.Result.port}" id="{$T.Result.sid}" data="{$T.Result.ip}" contextPath="{$T.Result.server_path}" unable="false" onclick="initTplResource(this)">初始化</a>
											&nbsp;&nbsp;&nbsp;<a style="cursor:pointer;" onclick="recordList({$T.Result.sid})">记录</a></td>
										{#/if}										
						       		</tr>
								{#/for}
						    {#/template MAIN}	 -->
						</textarea>
						</p>
					</div>
				</div>
				<!-- /Page Body -->
			</div>
			<!-- /Page Content -->
		</div>
		<!-- /Page Container -->
	<%@ include file="log_server.jsp"%>
</body>
</html>