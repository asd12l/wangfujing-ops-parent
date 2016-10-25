<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<style type="text/css">
.trClick>td,.trClick>th {
	color: red;
}
</style>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	var shopPagination;
	var brandPagination;
	
	$(function() {
		initShop();
		$("#pageSelect").change(shopQuery);
	});
	
	function shopQuery() {
		$("#organizationName_form").val($("#organizationName_input").val());
		$("#organizationCode_form").val($("#organizationCode_input").val());
		var params = $("#shop_form").serialize();
        LA.sysCode = '10';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('brand.queryOrganizationZero', '门店查询：' + params, getCookieValue("username"),  sessionId);
		params = decodeURI(params);
		shopPagination.onLoad(params);
	}
	
	function find() {
		shopQuery();
	}
	
	function reset() {
		$("#organizationName_input").val("");
		$("#organizationCode_input").val("");
		shopQuery();
	}
	
	function initShop() {
		var url = $("#ctxPath").val() + "/organization/queryOrganizationZero?organizationType=3";
		shopPagination = $("#shopPagination").myPagination({
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
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive");
					}, 300);
				},
				callback : function(data) {
					//使用模板
					$("#shop_tab tbody").setTemplateElement("shop-list").processTemplate(data);
				}
			}
		});
	}
	
	//点击查询门店下的门店品牌触发事件
	function trClick(sid, obj) {
		$(".shopA").css("color","#428bca");
		$("#organizationName_" + sid).css("color","red");
		$("#organizationCode_" + sid).css("color","red");
		
		$(obj).addClass("trClick").siblings().removeClass("trClick");

        LA.sysCode = '10';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('brand.queryPageShopBrand', '根据门店查询门店品牌：' + sid, getCookieValue("username"),  sessionId);

		var url = $("#ctxPath").val() + "/shopBrand/queryPageShopBrand";
		brandPagination = $("#brandPagination").myPagination({
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
				param : 'shopSid=' + sid,
				ajaxStart : function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive");
					}, 300);
				},
				callback : function(data) {
					//使用模板
					$("#brand_tab tbody").setTemplateElement("brand-list").processTemplate(data);
				}
			}
		});
	}
	
	function getBrandDetail(sid) {
		brandSid_ = $("#brandSid_" + sid).text().trim();
		brandName_ = $("#brandName_" + sid).text().trim();
		spell_ = $("#spell_" + sid).text().trim();
		brandNameSecond_ = $("#brandNameSecond_" + sid).text().trim();
		brandNameEn_ = $("#brandNameEn_" + sid).text().trim();
		shopType_ = $("#shopType_" + sid).text().trim();
		brandDesc_ = $("#brandDesc_" + sid).text().trim();
		url_ = $("#url_" + sid).text().trim();
		brandpic1_ = $("#brandpic1_" + sid).text().trim();
		brandpic2_ = $("#brandpic2_" + sid).text().trim();
		isDisplay_ = $("#isDisplay_" + sid).text().trim();
		$("#pageBody").load(__ctxPath + "/jsp/BrandShopRelation/ShopBrandDetailView.jsp");
	}

	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({"display" : "none"});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({"display" : "block"});
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
								<h5 class="widget-caption">门店与门店品牌管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> 
									<a href="#" data-toggle="collapse" onclick="tab('pro');"> 
										<i class="fa fa-minus" id="pro-i"></i> 
									</a> 
									<a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body clearfix" id="pro">
								<div class="table-toolbar">
									<div class="table-toolbar">
										<span>门店名称：</span>
										<input type="text" id="organizationName_input"/>&nbsp;&nbsp;&nbsp;
										<span>门店编码：</span>
										<input type="text" id="organizationCode_input"/>&nbsp;&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="reset();">重置</a>                                    	
									</div>
								</div>
										
								<div style="float: left;width:49%;">
									<table class="table table-bordered table-striped table-condensed table-hover flip-content">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;width: 50%">门店名称</th>
												<th style="text-align: center;width: 50%">门店编码</th>
											</tr>
										</thead>
									</table>
									<div style="overflow-y: scroll;height:352px">
										<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="shop_tab">
											<tbody>
											</tbody>
										</table>
									</div>
									<div class="pull-left" style="margin-top: 5px;">
										<form id="shop_form" action="">
											<div class="col-lg-12">
												<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>
											&nbsp; 
											<input type="hidden" id="organizationName_form" name="organizationName"/>
											<input type="hidden" id="organizationCode_form" name="organizationCode"/>
										</form>
									</div>
									<div id="shopPagination"></div>
								</div>
									
								<div style="float: left;width:2%;">&nbsp;</div>
									
								<div style="float: right;width:49%;">
									<table class="table table-bordered table-striped table-condensed table-hover flip-content">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;">门店品牌名称</th>
												<th style="text-align: center;">门店品牌编码</th>
											</tr>
										</thead>
									</table>
									<div style="overflow-y: scroll;height:352px">
										<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="brand_tab">
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="brandPagination"></div>
								</div>

								<!-- Templates -->
								<p style="display: none">
									<textarea id="shop-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" onclick="trClick('{$T.Result.sid}',this)" style="height:35px;cursor:pointer">
													<td align="center" style="text-align: center;width: 51.7%">
														<a id="organizationName_{$T.Result.sid}" class="shopA">
															{$T.Result.organizationName}
														</a>
													</td>
													<td align="center" style="text-align: center;width: 48.3%">
														<a id="organizationCode_{$T.Result.sid}" class="shopA">
															{$T.Result.organizationCode}
														</a>
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
								</p>
								
							<!-- Templates -->
							<p style="display: none">
								<textarea id="brand-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX" style="height:35px;">
													<td align="center" style="text-align: center;width: 51.7%">
														{$T.Result.brandName}
													</td>
													<td align="center" style="text-align: center;width: 48.3%">
														{$T.Result.brandSid}
													</td>
													<td align="center" style="display:none" id="sid_{$T.Result.sid}">{$T.Result.sid}</td>
													<td align="center" style="display:none" id="spell_{$T.Result.sid}">
														{#if $T.Result.spell != '[object Object]'}
															{$T.Result.spell}
														{/#if}
													</td>
													<td align="center" style="display:none" id="brandNameSecond_{$T.Result.sid}">
														{#if $T.Result.brandNameSecond != '[object Object]'}
															{$T.Result.brandNameSecond}
														{/#if}
													</td>
													<td align="center" style="display:none" id="brandNameEn_{$T.Result.sid}">
														{#if $T.Result.brandNameEn != '[object Object]'}
															{$T.Result.brandNameEn}
														{/#if}
													</td>
													<td align="center" style="display:none" id="shopType_{$T.Result.sid}">
														{#if $T.Result.shopType != '[object Object]'}
															{$T.Result.shopType}
														{/#if}
													</td>
													<td align="center" style="display:none" id="brandDesc_{$T.Result.sid}">
														{#if $T.Result.brandDesc != '[object Object]'}
															{$T.Result.brandDesc}
														{/#if}
													</td>
													<td align="center" style="display:none" id="url_{$T.Result.sid}">
														{#if $T.Result.url != '[object Object]'}
															{$T.Result.url}
														{/#if}
													</td>
													<td align="center" style="display:none" id="brandpic1_{$T.Result.sid}">
														{#if $T.Result.brandpic1 != '[object Object]'}
															{$T.Result.brandpic1}
														{/#if}
													</td>
													<td align="center" style="display:none" id="brandpic2_{$T.Result.sid}">
														{#if $T.Result.brandpic2 != '[object Object]'}
															{$T.Result.brandpic2}
														{/#if}
													</td>
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
	</div>
</body>
</html>