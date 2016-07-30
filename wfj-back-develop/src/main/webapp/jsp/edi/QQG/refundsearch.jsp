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
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	var stockPagination;
	$(function() {
		initStock();
		$("#pageSelect").change(stockQuery);
	});
	function find() {
		stockQuery();
	}
	function reset() {
		$("#refund_id").val("");
		$("#tid").val("");
		$("#oid").val("").trigger("change");
		$("#status").val("").trigger("change");
		$("#reason").val("").trigger("change");
		stockQuery();
	}

	function stockQuery() {
		$("#refund_id_from").val($("#refund_id").val());
		$("#tid_from").val($("#tid").val());
		$("#oid_from").val($("#oid").val());
		$("#status_from").val($("#status option:selected").attr("id"));
		$("#reason_from").val($("#reason").val());
		var params = $("#stock_form").serialize();
		params = decodeURI(params);
		stockPagination.onLoad(params);

	}
	function initStock() {
		var url = $("#ctxPath").val() + "/refund/obtain?type=QQG";
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
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						callback : function(data) {

							//使用模板
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
								<h5 class="widget-caption">全球购退单查询</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">

									<div class="table-toolbar">
										<ul class="listInfo clearfix">
											<li><span>退货号：</span> <input type="text" id="refund_id"
												style="width: 200px" /></li>
											<li><span>交易主订单号：</span> <input type="text" id="tid"
												style="width: 200px" /></li>
											<li><span>交易子订单号：</span> <input type="text" id="oid"
												style="width: 200px" /></li>
											<li><span>状态：</span> <select id="status">
													<option id="default" selected="selected">不限</option>
													<option id="WAIT_SELLER_CONFIRM_GOODS">买家已经退货，等待卖家确认收货</option>
													<option id="WAIT_BUYER_RETURN_GOODS">卖家已经同意退款，等待买家退货</option>
													<option id="WAIT_SELLER_AGREE">买家已经申请退款，等待卖家同意</option>
													<option id="CLOSED">退款关闭</option>
													<option id="SUCCESS">退款成功</option>
													<option id="SELLER_REFUSE_BUYER">卖家拒绝退款</option>
											</select></li>
											<li><span>原因：</span> <select id="reason">
													<option id="" selected="selected">不限</option>
													<option>商品质量问题</option>
													<option>七天无理由退换货</option>
													<option>拍错.多拍.不想要</option>
													<option>未按约定时间发货</option>
													<option>其他</option>
													<option>其它</option>
													<option>商品错发.漏发</option>
													<option>收到商品破损</option>
													<option>收到商品不符</option>
													<option>不喜欢.不想要</option>
													<option>退运费</option>
													<option>不想要了</option>
													<option>拍错了.订单信息错误</option>
													<option>快递一直未送到</option>
													<option>商品需要维修</option>
													<option>收到商品描述不符</option>
													<option>假冒品牌</option>
													<option>缺货</option>
													<option>未收到货</option>
													<option>协商一致退款</option>
													<option>空包裹/少货</option>
													<option>发票问题</option>
													<option>卖家缺货</option>
													<option>快递无跟踪记录</option>
													<option>收到商品与描述不符</option>
													<option>卖家发错货</option>
													<option>包装.商品破损.污渍</option>
													<option>拍错.不喜欢.效果不好</option>
													<option>颜色.图案.款式与商品描述不符</option>
													<option>质量问题（脱皮，开裂等）</option>
													<option>大小尺寸与商品描述不符</option>
													<option>做工瑕疵</option>
													<option>尺寸拍错.不喜欢.效果不好</option>
													<option>做工问题（胶水印、配件无法使用等）</option>
													<option>大小.尺寸与商品描述不符</option>
													<option>少件.漏发</option>
											</select></li>


											<li style="height: 35px; margin-top: 0; float: right"><a
												class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
												<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;&nbsp;&nbsp;
											</li>
										</ul>
									</div>
									<table
										class="table table-bordered table-striped table-condensed table-hover flip-content"
										id="stock_tab">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;">退货/款单号</th>
												<th style="text-align: center;">交易主订单号</th>
												<th style="text-align: center;">交易子订单号</th>
												<th style="text-align: center;">状态</th>
												<th style="text-align: center;">金额</th>
												<th style="text-align: center;">原因</th>
												<th style="text-align: center;">物流公司</th>
												<th style="text-align: center;">物流编号</th>
												<th style="text-align: center;">获取时间</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="pull-left" style="margin-top: 5px;">
										<form id="stock_form" action="">
											<div class="col-lg-12">
												<select id="pageSelect" name="pageSize"
													style="padding: 0 12px;">
													<option>5</option>
													<option>10</option>
													<option selected="selected">15</option>
													<option>20</option>
												</select>
											</div>
											&nbsp; <input type="hidden" id="refund_id_from"
												name="refundId" /> <input type="hidden" id="tid_from"
												name="tid" /> <input type="hidden" id="oid_from" name="oid" />
											<input type="hidden" id="status_from" name="status" /> <input
												type="hidden" id="reason_from" name="reason" />
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
													<td align="center" id="unitCode_{$T.Result.sid}">{$T.Result.tid}</td>
													<td align="center" id="productCode_{$T.Result.sid}">{$T.Result.oid}</td>
													<td align="center" id="unitName_{$T.Result.sid}">{$T.Result.status}</td>
													
													<td align="center" id="saleStock_{$T.Result.sid}">
													{$T.Result.refund_fee}
													</td>
													<td align="center" id="edefectiveStock_{$T.Result.sid}">
													{$T.Result.reason}
													</td>
													
													<td align="center" >
													   {#if $T.Result.company_name == "" || $T.Result.company_name == null} ---
													   {#else} {$T.Result.company_name}
													   {#/if}													
													</td>
													
													<td align="center" >
													   {#if $T.Result.company_name == "" || $T.Result.sid == null} ---
													   {#else} {$T.Result.sid}
													   {#/if}													
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