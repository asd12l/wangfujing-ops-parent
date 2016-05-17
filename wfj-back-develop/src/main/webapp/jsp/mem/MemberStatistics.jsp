<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 用户统计有手机号和QQ号
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
		var url = $("#ctxPath").val() + "/mem/getMemberByMobileAndQQ";
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
								<h5 class="widget-caption">用户有手机号和QQ号</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body clearfix" id="pro">
								<div class="table-toolbar">
									<div class="mtb10">
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
										
											<th style="text-align: center;" width="20%">用户名</th>
											<th style="text-align: center;" width="20%">邮箱</th>
											<th style="text-align: center;" width="10%">电话</th>
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
													<td align="center" id="username_{$T.Result.sid}">
														{#if $T.Result.username == "" || $T.Result.username == null}{$T.Result.features}
													    {#else}{$T.Result.username}
													    {#/if}
													</td>
													<td align="center" id="email_{$T.Result.sid}">
														{#if $T.Result.email == "" || $T.Result.email == null}{$T.Result.features}
													    {#else}{$T.Result.email}
													    {#/if}
														
													</td>
													<td align="center" id="mobile_{$T.Result.sid}">
														{#if $T.Result.mobile == "" || $T.Result.mobile == null}{$T.Result.features}
													    {#else}{$T.Result.mobile}
													    {#/if}														
													</td>
													<td align="center" id="m_time_{$T.Result.sid}">
														{#if $T.Result.m_time == "" || $T.Result.m_time == null}{$T.Result.features}
													    {#else}{$T.Result.m_time}
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