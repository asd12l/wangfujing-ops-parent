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
<script src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>	
<style type='text/css'>

</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>楼层样式管理</title>
</script>
<script
	src="${pageContext.request.contextPath}/js/customize/stylelist/stylelist.js">
</script>
<script
	src="${pageContext.request.contextPath}/js/customize/common/common.js">
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
			<%@ include file="../site/site_chose.jsp"%>
				<div class="widget">
					<div class="widget-header">
						<h5 class="widget-caption">楼层样式管理</h5>
						<div class="widget-buttons">
							<a href="#" data-toggle="collapse" onclick="tab('pro');"> <i class="fa fa-minus" id="pro-i"></i>
							</a>
						</div>
					</div>
					<div class="widget-body clearfix" id="pro">
						<div class="m10 pull-right">
						    <a id="editabledatatable_add" onclick="addStylelist();" class="btn btn-primary glyphicon glyphicon-plus">
								添加楼层样式</a>&nbsp;&nbsp;
						</div>
						<div class="table-toolbar">
							<table
								class="table table-bordered table-striped table-condensed table-hover flip-content"
								id="stylelist_tab">
								<thead class="flip-content bordered-darkorange">
									<tr role="row">
										<th style="text-align: center;" width="75px;">选择</th>
										<th style="text-align: center;">名称</th>
										<th style="text-align: center;">描述</th>
										<th style="text-align: center;">类型</th>
										<th style="text-align: center;">上传人</th>
										<th style="text-align: center;">上传时间</th>
										<!-- <th>最后修改时间</th> -->
										<th style="text-align: center;">操作</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<div id="productPagination"></div>
						</div>
						<!-- Templates -->
						<p style="display: none">
							<textarea id="stylelist-list" rows="0" cols="0">
							<!-- 
							{#template MAIN}
								{#foreach $T.list as Result}
									<tr class="gradeX">
										<td align="left">
											<div class="checkbox">
												<label>
													<input type="checkbox" id="id" value="{$T.Result.name}" >
													<span class="text"></span>
												</label>
											</div>
										</td>
										<td align="center" id="name_{$T.Result.name}">{$T.Result.name}</td>
										<td align="center" id="desc_{$T.Result.name}">{$T.Result.desc}</td>
										<td align="center" style="display:none;" id="img_name_{$T.Result.name}">{$T.Result.imgName}</td>
										{#if $T.Result.type==0}
											<td align="center" id="">频道楼层样式</td>
										{#elseif $T.Result.type==1}
											<td align="center" id="">专题活动楼层样式</td>
										{#elseif $T.Result.type==2}
											<td align="center" id="">更多商品楼层样式</td>
										{#/if}
										<td align="center" id="name_{$T.Result.name}">{$T.Result.username}</td>
										<td align="center" id="name_{$T.Result.name}">{$T.Result.uploadTime}</td>
										<!-- <td align="center" id="lastModifyTime_{$T.Result.name}">{$T.Result.updateTime}</td> -->
										<td align="center">
											<a onclick="view(this)" data="{$T.siteResultUrl}{$T.Result.imgUrl}" class="btn btn-info glyphicon glyphicon-wrench">预览</a>	
										</td>
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
			<%@include file="renameStylelist.jsp" %>
			<%@include file="uploadDir.jsp" %>
			
			<%@include file="../showView.jsp" %>
		</div>
		<!-- /Page Container -->
</body>
</html>