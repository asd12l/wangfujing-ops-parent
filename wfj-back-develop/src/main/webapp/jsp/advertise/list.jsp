<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 广告列表
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />	
<link rel="stylesheet" type="text/css" 
	href="${pageContext.request.contextPath}/jsp/web/css/webStyle.css" />
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";</script>
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/validation/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/advertise/advertise.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/advertise/advertise_product.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/advertise/add_advertising_product.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/My97DatePicker/WdatePicker.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/common/common.js"></script>
</head>
<body>
	
<!-- Page Container -->
<div class="page-container">
	<!-- Page Body -->
	<div class="page-body" id="pageBodyRight">
	<%@ include file="../web/site/site_chose.jsp"%>
		<div id="advertising_list" class="widget">
			<div class="widget-header">
				<h5 class="widget-caption">广告管理</h5>
				<div class="widget-buttons">
					<a href="#" data-toggle="collapse" onclick="tab('pro');"> <i class="fa fa-minus" id="pro-i"></i></a>
				</div>
			</div>
			<div class="widget-body clearfix" id="pro">
				<div class="table-toolbar clearfix">
					<div class="col-lg-6 col-sm-6 col-xs-6">
						<a id="editabledatatable_new" onclick="addPropsdict();" class="btn btn-primary glyphicon glyphicon-plus">添加广告 </a>&nbsp;&nbsp;
						<a id="editabledatatable_new" onclick="editPropsdict();" class="btn btn-info glyphicon glyphicon-wrench">修改广告 </a>&nbsp;&nbsp;
						<a id="editabledatatable_new" onclick="delPropsdict();" class="btn btn-danger glyphicon glyphicon-trash">删除广告 </a>
					</div>
				</div>
				<div class="col-lg-3 col-sm-3 col-xs-3">
					<span class="widget-caption">广告版位： </span>
					<select class="form-control adspace" id="advertise_space_list" data-bv-field="country" style="width:60%;"></select>
				</div>
				<table class="table table-bordered table-striped table-condensed table-hover flip-content"
						id="propsdict_tab">
					<thead class="flip-content bordered-darkorange">
						<tr role="row">
							<th style="text-align: center;" width="75px;">选择</th>
							<th style="text-align: center;">名称</th>
							<!-- <th style="text-align: center;">版位</th> -->
							<th style="text-align: center;">类型</th>
							<th style="text-align: center;width:15%;">开始时间</th>
							<th style="text-align: center;width:15%;">结束时间</th>
							<th style="text-align: center;">顺序</th>
							<th style="text-align: center;">状态</th>
							<th style="text-align: center;">操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<div class="pull-left" style="margin-top: 5px;">
					<form id="advertising_form" action="">
						<select id="pageSelect" name="pageSize">
							<option>5</option>
							<option selected="selected">10</option>
							<option>15</option>
							<option>20</option>
						</select>
					</form>
				</div>
				<div id="advertisingPagination"></div>
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
									<td align="center" id="advertiesName{$T.Result.id}">{$T.Result.name}</td>
									<!-- <td align="center" id="advertiesAdspace{$T.Result.id}">{$T.Result.adspace}</td> -->
									<td align="center" style="display:none;" id="advertiesAdspaceId{$T.Result.id}">{$T.Result.adspaceId}</td>
									
									{#if $T.Result.category=="image"}
									<td align="center" id="advertiesCategory{$T.Result.id}" value="{$T.Result.category}">
										图片
									</td>
									{#elseif $T.Result.category=="flash"}
									<td align="center" id="advertiesCategory{$T.Result.id}" value="{$T.Result.category}">
										视频
									</td>
									{#elseif $T.Result.category=="text"}
									<td align="center" id="advertiesCategory{$T.Result.id}" value="{$T.Result.category}">
										文字
									</td>
									{#elseif $T.Result.category=="code"}
									<td align="center" id="advertiesCategory{$T.Result.id}" value="{$T.Result.category}">
										代码
									</td>
									{#/if}
									
									<td align="center" style="display:none;" id="attr_image_url{$T.Result.id}">{$T.Result.image_url}</td>
									<td align="center" style="display:none;" id="attr_image_name{$T.Result.id}">{$T.Result.image_name}</td>
									<td align="center" style="display:none;" id="attr_image_width{$T.Result.id}">{$T.Result.image_width}</td>
									<td align="center" style="display:none;" id="attr_image_link{$T.Result.id}">{$T.Result.image_link}</td>
									<td align="center" style="display:none;" id="attr_image_desc{$T.Result.id}">{$T.Result.image_desc}</td>
									<td align="center" style="display:none;" id="attr_image_title{$T.Result.id}">{$T.Result.image_title}</td>
									<td align="center" style="display:none;" id="attr_image_uppict{$T.Result.id}">{$T.Result.image_uppict}</td>
									<td align="center" style="display:none;" id="attr_image_backpict{$T.Result.id}">{$T.Result.image_backpict}</td>
									<td align="center" style="display:none;" id="flashPath1{$T.Result.id}">{$T.Result.flashPath1}</td>
									<td align="center" style="display:none;" id="flashFile{$T.Result.id}">{$T.Result.flashFile}</td>
									<td align="center" style="display:none;" id="flash_url{$T.Result.id}">{$T.Result.flash_url}</td>
									<td align="center" style="display:none;" id="attr_flash_width{$T.Result.id}">{$T.Result.flash_width}</td>
									<td align="center" style="display:none;" id="attr_text_title{$T.Result.id}">{$T.Result.text_title}</td>
									<td align="center" style="display:none;" id="attr_text_link{$T.Result.id}">{$T.Result.text_link}</td>
									<td align="center" style="display:none;" id="attr_text_font{$T.Result.id}">{$T.Result.text_font}</td>
									<td align="center" style="display:none;" id="code{$T.Result.id}">{$T.Result.code}</td>
									
									<td align="center" style="display:none;" id="advertiesTplName{$T.Result.id}">{$T.Result.tplName}</td>
									<td align="center" style="display:none;" id="advertiesPath{$T.Result.id}">{$T.Result.path}</td>
									<td align="center" id="advertiesStartTime{$T.Result.id}">{$T.Result.startTime}</td>
									<td align="center" id="advertiesEndTime{$T.Result.id}">{$T.Result.endTime}</td>
									<td align="center" id="seq{$T.Result.id}">{$T.Result.seq}</td>
									
									{#if $T.Result.enabled}
									<td align="center" id="advertiesEnabled{$T.Result.id}" value="{$T.Result.enabled}">
										<span class="label label-success graded">启用</span>
									</td>
									{#else}
									<td align="center" id="advertiesEnabled{$T.Result.id}" value="{$T.Result.enabled}">
									    <span>未启用</span>
									</td>
									{#/if}
									<td align="center">
									<a class="btn btn-default shiny" onclick="setAdvertisingProduct({$T.Result.id});">配置商品</a>
									</td>
					       		</tr>
							{#/for}
					    {#/template MAIN}	-->
					</textarea>
				</p>
			</div>
		</div>
		
		<div id="advertise_product" style="display:none;">
			<%@ include file="advertise_product_list.jsp" %>
		</div>
		<!-- /Page Body -->
	</div>
	<!-- /Page Content -->
</div>
<!-- /Page Container -->
</body>
</html>