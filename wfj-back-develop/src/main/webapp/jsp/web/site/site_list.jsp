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
<title>站点管理</title>
<script
	src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
</script>
<script	src="${pageContext.request.contextPath}/js/customize/site/sitelist.js"></script>
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
						<h5 class="widget-caption">站点管理</h5>
						<div class="widget-buttons">
							<a href="#" data-toggle="maximize"></a> <a href="#"
								data-toggle="collapse" onclick="tab('pro');"> <i
								class="fa fa-minus" id="pro-i"></i>
							</a> <a href="#" data-toggle="dispose"></a>
						</div>
					</div>
					<div class="widget-body" id="pro">
						<div class="btn-group clearfix">
                           		<a id="editabledatatable_add" onclick="addSite();" class="btn btn-primary glyphicon glyphicon-plus">
								添加资源</a>&nbsp;&nbsp;
                          		<a id="editabledatatable_del" onclick="delSite();" class="btn btn-danger glyphicon glyphicon-trash">
								删除资源</a>
                           		<a id="editabledatatable_edit" onclick="editSite();" class="btn btn-info glyphicon glyphicon-wrench">
								编辑资源</a>
						</div>
						<div class="table-toolbar">
							<table
								class="table table-bordered table-striped table-condensed table-hover flip-content"
								id="site_tab">
								<thead class="flip-content bordered-darkorange">
									<tr>
										<th style="text-align: center;" width="75px;">选择</th>
										<th style="text-align: center;">编码</th>
										<th style="text-align: center;">站点名称</th>
										<th style="text-align: center;">域名</th>
										<th style="text-align: center;">渠道</th>
										<th style="text-align: center;">站点路径</th>
										<th style="text-align: center;">动态页后缀</th>
										<th style="text-align: center;">静态页后缀</th>
										<th style="text-align: center;">前台本地化</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<input type='hidden' id='ftp_list' value=''/>
							<div id="productPagination"></div>
						</div>
						<!-- Templates -->
						<p style="display: none">
							<textarea id="site-list" rows="0" cols="0">
							<!-- 
							{#template MAIN}
								{#foreach $T.list as Result}
									<tr class="gradeX">
										<td align="left">
											<div class="checkbox">
												<label>
													<input type="checkbox" id="tdCheckbox_{$T.Result.id}" value="{$T.Result.id}" >
													<span class="text"></span>
												</label>
											</div>
										</td>
										<input type='hidden' id='shortName_{$T.Result.id}' value='{$T.Result.shortName}'/>
										<input type='hidden' id='keywords_{$T.Result.id}' value='{$T.Result.keywords}'/>
										<input type='hidden' id='description_{$T.Result.id}' value='{$T.Result.description}'/>
										<input type='hidden' id='domainAlias_{$T.Result.id}' value='{$T.Result.domainAlias}'/>
										<input type='hidden' id='domainRedirect_{$T.Result.id}' value='{$T.Result.domainRedirect}'/>
										<input type='hidden' id='relativePath_{$T.Result.id}' value='{$T.Result.relativePath}'/>
										<input type='hidden' id='protocol_{$T.Result.id}' value='{$T.Result.protocol}'/>
										<input type='hidden' id='staticDir_{$T.Result.id}' value='{$T.Result.staticDir}'/>
										<input type='hidden' id='indexToRoot_{$T.Result.id}' value='{$T.Result.indexToRoot}'/>
										<input type='hidden' id='staticIndex_{$T.Result.id}' value='{$T.Result.staticIndex}'/>
										<input type='hidden' id='localeAdmin_{$T.Result.id}' value='{$T.Result.localeAdmin}'/>
										<input type='hidden' id='uploadFtpId_{$T.Result.id}' value='{$T.Result.uploadFtpId}'/>
										<input type='hidden' id='resycleOn_{$T.Result.id}' value='{$T.Result.resycleOn}'/>
										<input type='hidden' id='resource_path_{$T.Result.id}' value='{$T.Result.resPath}'/>
										<input type='hidden' id='tpl_path_{$T.Result.id}' value='{$T.Result.tplPath}'/>
										<input type='hidden' id='channelCode_{$T.Result.id}' value='{$T.Result.channelCode}'/>
										
										<td align="center" id='id_{$T.Result.id}'>{$T.Result.id}</td>
										<td align="center" id="name_{$T.Result.id}">{$T.Result.name}</td>
										<td align="center" id='domain_{$T.Result.id}'>{$T.Result.domain}</td>
										<td align="center" id='channelName_{$T.Result.id}'>{$T.Result.channelName}</td>
										<td align="center" id="path_{$T.Result.id}">{$T.Result.path}</td>
										<td align="center" id="dynamicSuffix_{$T.Result.id}">{$T.Result.dynamicSuffix}</td>
										<td align="center" id="staticSuffix_{$T.Result.id}">{$T.Result.staticSuffix}</td>
										<td align="center" id="localeFront_{$T.Result.id}">{$T.Result.localeFront}</td>
										<td></td>
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
</body>
</html>