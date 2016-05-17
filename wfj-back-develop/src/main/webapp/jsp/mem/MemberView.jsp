<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 用户本信息表页
Version: 1.0.0
Author: WangJW
-->
<html>
<head>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script type="text/javascript">
	var productPagination;
	$(function() {
		initProduct();
	});
	function productQuery() {
		$("#username_from").val($("#username_input").val());
		$("#mobile_from").val($("#mobile_input").val());
		$("#email_from").val($("#email_input").val());
		var params = $("#product_form").serialize();
		params = decodeURI(params);
		productPagination.onLoad(params);
	}
	// 查询
	function query() {
		$("#cache").val(0);
		productQuery();
	}
	// 重置
	function reset() {
		$("#cache").val(1);
		$("#username_input").val("");
		$("#mobile_input").val("");
		$("#email_input").val("");
		productQuery();
	}
	
	var dataList;
	//初始化商品列表
	function initProduct() {
		var url = $("#ctxPath").val() + "/mem/getByUsername";
		productPagination = $("#productPagination").myPagination(
				{
					panel : {
						tipInfo_on : true,
						tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
						tipInfo_css : {
							width : '25px',
							height : "20px",
							border : "2px solid #f0f0f0",
							padding : "0 0 0 5px",
							margin : "0 5px 0 5px",
							color : "#48b9ef"
						}
					},
					debug : false,
					ajax : {
						on : true,
						url : url,
						dataType : 'json',
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						callback : function(data) {
							dataList = data.list;
							$("#product_tab tbody").setTemplateElement(
									"product-list").processTemplate(data);
						}
					}
				});
	}
</script>
<!-- 手机重置密码 -->
<script type="text/javascript">
function editMobilePassWord() {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var sid = $(this).val();
		checkboxArray.push(sid);
	});
	if (checkboxArray.length > 1) {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一行!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
		return false;
	} else if (checkboxArray.length == 0) {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的行!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
		return false;
	}
	var value = checkboxArray[0];
	password_= $("#password_" + value).text().trim();
	email_ = $("#email_" + value).text().trim();
	username_ = $("#username_" + value).text().trim();
	mobile_ = $("#mobile_" + value).text().trim();
	sid_ = $("#sid_" + value).text().trim();

	var url = __ctxPath + "/jsp/mem/editMobilePassWord.jsp";
	$("#pageBody").load(url);
}
</script>
<!--邮箱重置密码  -->
<script type="text/javascript">
function editEmailPassWord() {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var sid = $(this).val();
		checkboxArray.push(sid);
	});
	if (checkboxArray.length > 1) {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一行!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
		return false;
	} else if (checkboxArray.length == 0) {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的行!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
		return false;
	}
	var value = checkboxArray[0];
	password_= $("#password_" + value).text().trim();
	email_ = $("#email_" + value).text().trim();
	username_ = $("#username_" + value).text().trim();
	mobile_ = $("#mobile_" + value).text().trim();
	sid_ = $("#sid_" + value).text().trim();
	
	var url = __ctxPath + "/jsp/mem/editEmailPassWord.jsp";
	$("#pageBody").load(url);
	
}
</script>
<!-- 操作 -->
<script type="text/javascript">
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({
					"display" : "none"
				});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({
					"display" : "block"
				});
			}
		}
	}
</script>
</head>
<body>
	<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">用户基本信息</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body clearfix" id="pro">
								<div class="table-toolbar">
									<div class="clearfix">
									 <a id="editabledatatable_new"
											onclick="editMobilePassWord();" class="btn btn-primary"> <i
											class="fa fa-edit"></i> 用户根据手机重置密码
										</a>&nbsp;&nbsp;&nbsp;&nbsp; <a id="editabledatatable_new"
											onclick="editEmailPassWord();" class="btn btn-primary"> <i
											class="fa fa-edit"></i> 用户根据邮箱重置密码
										</a>
									</div>
									<div class="mtb10">
										<span>用户名：</span> <input type="text" id="username_input" />&nbsp;&nbsp;&nbsp;&nbsp;
										<span>手机号码：</span> <input type="text" id="mobile_input" />&nbsp;&nbsp;&nbsp;&nbsp;
										<span>邮箱：</span> <input type="text" id="email_input" />&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;&nbsp;&nbsp;&nbsp; <a class="btn btn-default shiny"
											onclick="query();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
											class="btn btn-default shiny" onclick="reset();">重置</a>
									</div>
								</div>
								<table
									class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="product_tab" style="table-layout:fixed;">
									<thead class="flip-content bordered-darkorange">
										<tr>
											<th style="text-align: center;" width="5%">选择</th>
											<th style="text-align: center;" width="5%">SID</th>
											<th style="text-align: center;" width="20%">用户名</th>
											<th style="text-align: center;" width="20%">邮箱</th>
											<th style="text-align: center;" width="10%">电话</th>
											<th style="text-align: center;" width="10%">会员卡编号</th>
											<th style="text-align: center;" width="15%">身份证号码</th>
											<th style="text-align: center;" width="15%">注册时间</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="pull-left" style="padding: 10px 0;">
									<form id="product_form" action="">
										<input type="hidden" id="username_from" name="username" />
										<input type="hidden" id="mobile_from" name="mobile" /> 
										<input type="hidden" id="email_from" name="email" />
										 <input type="hidden" id="cache" name="cache" value="1" />
									</form>
								</div>
								<div id="productPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="product-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="sid_{$T.Result.sid}">
														{#if $T.Result.sid == "" || $T.Result.sid == null}{$T.Result.features}
													    {#else}{$T.Result.sid}
													    {#/if}
													</td>
													<td align="center" id="username_{$T.Result.sid}">
														{#if $T.Result.username == "" || $T.Result.username == null}{$T.Result.features}
													    {#else}{$T.Result.username}
													    {#/if}
													</td>
													<td align="center" id="email_{$T.Result.sid}">
														{#if $T.Result.email == "" || $T.Result.email == null}{$T.Result.features}
													    {#else}{$T.Result.email}
													    {#/if}
														{#if $T.Result.email == "" || $T.Result.email == null}无
						                   				{#/if}	
													</td>
													<td align="center" id="mobile_{$T.Result.sid}">
														{#if $T.Result.mobile == "" || $T.Result.mobile == null}{$T.Result.features}
													    {#else}{$T.Result.mobile}
													    {#/if}
													    {#if $T.Result.mobile == "" || $T.Result.mobile == null}无
						                   				{#/if}														
													</td>
													<td align="center" id="cid_{$T.Result.sid}">
														{#if $T.Result.cid == "" || $T.Result.cid == null}{$T.Result.features}
													    {#else}{$T.Result.cid}
													    {#/if}
													    {#if $T.Result.cid == "" || $T.Result.cid == null}无
						                   				{#/if}
													</td>
													<td align="center" id="identity_card_no_{$T.Result.sid}">
														{#if $T.Result.identity_card_no == "" || $T.Result.identity_card_no == null}{$T.Result.features}
													    {#else}{$T.Result.identity_card_no}
													    {#/if}
													    {#if $T.Result.identity_card_no == "" || $T.Result.identity_card_no == null}无
						                   				{#/if}
													</td>
													<td align="center" id="m_time_{$T.Result.sid}">
														{#if $T.Result.m_time == "" || $T.Result.m_time == null}{$T.Result.features}
													    {#else}{$T.Result.m_time}
													    {#/if}
													    {#if $T.Result.m_time == "" || $T.Result.m_time == null}无
						                   				{#/if}
													</td>
													<td style="display:none;" id="password_{$T.Result.sid}">{$T.Result.password}</td>
													<td style="display:none;" id="cardNo_{$T.Result.sid}">{$T.Result.card_no}</td>
													
													<td style="display:none;" id="statCategoryName_{$T.Result.sid}">{$T.Result.statCategoryName}</td>
													<td style="display:none;" id="spuCode_{$T.Result.sid}">{$T.Result.spuCode}</td>
													
													<td style="display:none;" id="proActiveBit_{$T.Result.sid}">{$T.Result.proActiveBit}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
							</p>
						</div>
					</div>
				</div>
			</div>
			<!-- /Page Body -->
		</div>
		<!-- /Page Content -->
	</div>
	<!-- /Page Container -->
	<!-- Main Container -->
</body>
</html>