<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<!--Jquery Select2-->
<script
	src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
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
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";
	var stockPagination;
	var userName;
	var logJs;
	
	$(function() { 
		initStock();
		$("#pageSelect").change(stockQuery);
	});
	
	function  obtain(){
		LA.env = 'dev';
		LA.sysCode = '44';
		var sessionId = '<%=request.getSession().getId()%>';
		LA.log('tm-rufundObtain', '天猫退单获取', userName,  sessionId);
		$("#new_refundId_from").val($("#new_refundId_input").val());
		var params = $("#stock_form").serialize();
		params = decodeURI(params);
		stockPagination.onLoad(params);
	}
	function reset() {
		$("#new_refundId_input").val("");
		$("#new_refundId_from").val("");
		stockQuery();
	}
	function stockQuery() {
		var params = $("#stock_form").serialize();
		params = decodeURI(params);
		stockPagination.onLoad(params);
		
	}

	function reloadjs(){
			
			var head= document.getElementsByTagName('head')[0]; 
			var script= document.createElement('script'); 
			script.type= 'text/javascript'; 
			script.onload = script.onreadystatechange = function() { 
			if (!this.readyState || this.readyState === "loaded" || this.readyState === "complete" ) { 
			/* help(); */ 
			// Handle memory leak in IE 
			script.onload = script.onreadystatechange = null; 
			} }; 
			script.src= logJs; 
			head.appendChild(script);  
		}
	function initStock() {
		var url = $("#ctxPath").val() + "/refund/obtain?type=TM";
		stockPagination = $("#stockPagination").myPagination(
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
							userName = data.userName ;
							logJs = data.logJs;
							reloadjs();
							$("#stock_tab tbody").setTemplateElement(
									"stock-list").processTemplate(data);
						}
					}
					
				});
	}
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
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
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
								<h5 class="widget-caption">天猫退单获取</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
																		
								<div class="table-toolbar">
									<ul class="listInfo clearfix">
										<li>
											<span>退货号：</span>
											<input type="text" id="new_refundId_input" style="width: 200px"/>
										</li>
										
										<li style="height:35px;margin-top:0;">
											<a class="btn btn-default shiny" onclick="obtain();">获取</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;&nbsp;&nbsp;
										</li>
									</ul>
								</div>
								<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="stock_tab">
                                       <thead class="flip-content bordered-darkorange">
										<tr role="row">
											<th style="text-align: center;">退货/款单号</th><!-- sku_id -->
											<th style="text-align: center;">交易主订单号</th><!--num_iid -->
											<th style="text-align: center;">交易子订单号</th><!-- title -->
											<th style="text-align: center;">状态</th><!--num  -->
											<th style="text-align: center;">金额</th><!-- nick -->
											<th style="text-align: center;">原因</th><!-- price -->
											<th style="text-align: center;">物流公司</th><!-- status -->
											<th style="text-align: center;">物流编号</th><!-- increment -->
											<th style="text-align: center;">获取时间</th><!-- increment -->
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="stock_form" action="">
										<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option >10</option>
													<option selected="selected">15</option>
													<option>20</option>
												</select>
											</div>&nbsp; 
										 <input type="hidden" id="new_refundId_from" name="new_refundId" /> 
									</form>
								</div>
								<div id="stockPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="stock-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="center" id="skuCode_{$T.Result.sid}">{$T.Result.refund_id}</td>
													<td align="center"  id="unitCode_{$T.Result.sid}">{$T.Result.tid}</td>
													<td align="center" id="productCode_{$T.Result.sid}">{$T.Result.oid}</td>
													<td align="center" id="unitName_{$T.Result.sid}">{$T.Result.status}</td>
													
													<td align="center" id="saleStock_{$T.Result.sid}">
													{$T.Result.refund_fee}
													</td>
													<td align="center" id="edefectiveStock_{$T.Result.sid}">
													{$T.Result.reason}
													</td>
													<td align="center" id="returnStock_{$T.Result.sid}">
													{#if $T.Result.company_name == null || $T.Result.company_name == ""} --- {#else} {$T.Result.company_name} {#/if}
													</td>
													
													<td align="center" id="returnStock_{$T.Result.sid}">
													{#if $T.Result.sid == null || $T.Result.sid == ""} --- {#else} {$T.Result.sid} {#/if}
													</td>
													<td align="center" id="returnStock_{$T.Result.sid}">
													{$T.Result.created}
													</td>
									       		
									       		</tr>
											{#/for}
									    {#/template MAIN}	
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