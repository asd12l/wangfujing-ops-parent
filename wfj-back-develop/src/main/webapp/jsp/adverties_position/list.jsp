<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 广告版位列表
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsp/web/css/webStyle.css" />

<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/js/bootstrap/css/components.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/js/customize/advertise/adverties_position.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery.validate.messages_cn.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/common/common.js"></script>
<script type="text/javascript">var sessionId = "<%=request.getSession().getId() %>";</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
			
			<%@ include file="../web/site/site_chose.jsp"%>
			
				<div class="widget">
					<div class="widget-header">
						<h5 class="widget-caption">广告位置</h5>
						<div class="widget-buttons">
							<a href="#" data-toggle="collapse" onclick="tab('pro');"> <i class="fa fa-minus" id="pro-i"></i></a>
						</div>
					</div>
					<div class="widget-body clearfix centerDiv" id="pro">
						<div class="table-toolbar clearfix">
							<a id="editabledatatable_new" onclick="addPosition();" class="btn btn-primary glyphicon glyphicon-plus">添加广告位置 </a>&nbsp;&nbsp;
							<a id="editabledatatable_new" onclick="editPosition();" class="btn btn-info glyphicon glyphicon-wrench">修改广告位置 </a>&nbsp;&nbsp;
							<a id="editabledatatable_new" onclick="delPosition();" class="btn btn-danger glyphicon glyphicon-trash">删除广告位置 </a>
						</div>
						<div style="height:500px;" class="centerDiv">
						<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="propsdict_tab">
							<thead class="flip-content bordered-darkorange">
								<tr role="row">
									<th style="text-align: center;" width="75px;">选择</th>
									<th style="text-align: center;">编码</th>		
									<th style="text-align: center;">名称</th>		
									<th style="text-align: center;">英文名称</th>
									<th style="text-align: center;">标记</th>				
									<th style="text-align: center;">状态</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						</div>
						
						<!-- Templates -->
						<p style="display: none">
							<textarea id="propsdict-list" rows="0" cols="0">
								<!--
								{#template MAIN}
									{#foreach $T.list as Result}
										<tr class="gradeX">
											<td align="left">
												<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
													<label>
														<input type="checkbox" id="tdCheckbox_{$T.Result.id}" value="{$T.Result.id}" >
														<span class="text"></span>
													</label>
												</div>
											</td>
											<td align="center" id="id{$T.Result.id}">{$T.Result.id}</td>
											<td align="center" id="position_name{$T.Result.id}">{$T.Result.name}</td>
											<td align="center" id="position{$T.Result.id}">{$T.Result.position}</td>
											<td align="center" id="source{$T.Result.id}">{$T.Result.source}</td>
											{#if $T.Result.status==1}
											<td align="center" id="status{$T.Result.id}" value="{$T.Result.status}">
												<span class="label label-success graded">启用</span>
											</td>
											{#else}
											<td align="center" id="status{$T.Result.id}" value="{$T.Result.status}">
											        <span>未启用</span>
											</td>
											{#/if}
							       		</tr>
									{#/for}
							    {#/template MAIN}	-->
							</textarea>
						</p>
					</div>
				</div>
				<!-- /Page Body -->
			</div>
			<!-- /Page Content -->
		</div>
		<!-- /Page Container -->

<%@ include file="addPosition.jsp"%>
<%@ include file="editPosition.jsp"%>

</body>
</html>