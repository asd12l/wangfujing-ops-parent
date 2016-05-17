<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
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
<!--Bootstrap Date Range Picker-->
<script
	src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	var olvPagination;
	$(function() {
		$.ajax({
			url : __ctxPath + "/DataDictionary/getItemType?dictTypeCode=" + 11,
			dataType : "json",
			async : false,
			success : function(response) {
				var result = response.list;
				var option = "<option value=''>所有</option>";
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.dictItemCode+"'>"
							+ ele.dictItemName + "</option>";
				}
				$("#orderSourceSid_select").append(option);
			}
		});
		$('#reservation').daterangepicker();
		initOlv();
	});
	function olvQuery() {
		$("#SaleCode_form").val($("#SaleCode_input").val());

		var strTime = $("#reservation").val();
		if (strTime != "") {
			strTime = strTime.split("-");
			$("#startSaleTime_form").val(
					strTime[0].replace("/", "-").replace("/", "-"));
			$("#endSaleTime_form").val(
					$.trim(strTime[1].replace("/", "-").replace("/", "-")));
		} else {
			$("#startSaleTime_form").val("");
			$("#endSaleTime_form").val("");
		}

		var params = $("#olv_form").serialize();
		params = decodeURI(params);
		olvPagination.onLoad(params);
	}
	function reset() {
		$("#SaleCode_input").val("");

		$("#reservation").val("");
		olvQuery();
	}
	function exportExcel() {
		var SaleNo = $("SaleCode_input").val();
		var saleTimeFrom = $("#startSaleTime_form").val();
		var saleTimeTo = $("#endSaleTime_form").val();
		saleTimeTo = $.trim(saleTimeTo);
		var title = "SHOPIN" + saleTimeFrom + "to" + saleTimeTo + "For"
				+ SaleNo + "SaleNoState";
		var count = $("#olv_tab tbody tr").length;
		if (count > 0 && SaleNo != "" && saleTimeFrom != "" && saleTimeTo != "") {
			window.open(__ctxPath + "/stateExcel/SaleNoToExcel?SaleNo="
					+ SaleNo + "&&saleTimeFrom=" + saleTimeFrom
					+ "&&saleTimeTo=" + saleTimeTo + "&&title=" + title);
		} else {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'>"
									+ "<i class='fa-fw fa fa-times'></i><strong>条件不足不能生成EXCEL!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
		}
	}
	function exportPDF() {
		var SaleNo = $("SaleCode_input").val();
		var saleTimeFrom = $("#startSaleTime_form").val();
		var saleTimeTo = $("#endSaleTime_form").val();
		var title = "SHOPIN" + saleTimeFrom + "to" + saleTimeTo + "For"
				+ SaleNo + "SaleNoState";
		var count = $("#olv_tab tbody tr").length;
		if (count > 0 && SaleNo != "" && saleTimeFrom != "" && saleTimeTo != "") {
			window.open(__ctxPath + "/statePDF/SaleNoToPDF?SaleNo=" + SaleNo
					+ "&&saleTimeFrom=" + saleTimeFrom + "&&saleTimeTo="
					+ saleTimeTo + "&&title=" + title);
		} else {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'>"
									+ "<i class='fa-fw fa fa-times'></i><strong>条件不足不能生成PDF!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
		}
	}

	function initOlv() {
		var url = __ctxPath + "/statement/SaleNOController";
		olvPagination = $("#olvPagination").myPagination(
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
							ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								ZENG.msgbox.hide();
							}, 300);
						},
						callback : function(data) {
							$("#olv_tab tbody").setTemplateElement("olv-list")
									.processTemplate(data);
						}
					}
				});
	}

	//折叠页面
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
	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(__ctxPath + "/jsp/OrderListView.jsp");
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
								<span class="widget-caption"><h5>销售单销编统计报表管理</h5> </span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">

									<div class="col-md-4">
										<div class="col-lg-3">时间</div>
										<div class="col-lg-9">
											<input type="text" id="reservation" style="width: 100%" />
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-4">
											<span>销售编码：</span>
										</div>
										<div class="col-lg-8">
											<div class="col-lg-12">
												<input type="text" id="SaleCode_input" style="width: 100%;" />
											</div>
											&nbsp;
										</div>
									</div>
									<div class="col-md-12">
										<div class="col-lg-12">
											<a class="btn btn-default" onclick="olvQuery();">查询</a>
											&nbsp; <a class="btn btn-default" onclick="reset();">重置</a>
											&nbsp; <a class="btn btn-default" onclick="exportExcel();">导出EXCEL</a>
											&nbsp; <a class="btn btn-default" onclick="exportPDF();">导出PDF</a>
										</div>
										&nbsp;
									</div>

									<div class="col-md-6">
										<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize"
												value="15" /> <input type="hidden" id="saleCode_form"
												name="saleCode" /> <input type="hidden"
												id="startSaleTime_form" name="saleTimeFrom" /> <input
												type="hidden" id="endSaleTime_form" name="saleTimeTO" />
										</form>
									</div>
								</div>
								<div style="width: 100%; height: 400px; overflow: scroll;">
									<table class="table-striped table-hover table-bordered"
										id="olv_tab"
										style="width: 100%; background-color: #fff; margin-bottom: 0;">
										<thead>
											<tr role="row">
												<th width="5%" style="text-align: center;">日期</th>
												<th width="5%" style="text-align: center;">门店</th>
												<th width="5%" style="text-align: center;">销售编码</th>
												<th width="5%" style="text-align: center;">品牌</th>
												<th width="5%" style="text-align: center;">单据号</th>
												<th width="5%" style="text-align: center;">实体销售</th>
												<th width="5%" style="text-align: center;">实体退货</th>
												<th width="5%" style="text-align: center;">网络销售</th>
												<th width="5%" style="text-align: center;">网络退货</th>
												<th width="5%" style="text-align: center;">小票号</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
								<!-- <div id="olvPagination"></div> -->
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" onclick="trClick({$T.Result.sid})">
													<td align="center" id="saleTime_{$T.Result.sid}">{$T.Result.saleTime}</td>
													<td align="center" id="shopName_{$T.Result.sid}">{$T.Result.shopName}</td>
													<td align="center" id="saleCode_{$T.Result.sid}">{$T.Result.saleCode}</td>
													<td align="center" id="brandName_{$T.Result.sid}">{$T.Result.brandName}</td>
													<td align="center" id="saleNo_{$T.Result.sid}">{$T.Result.saleNo}</td>
													<td align="center" id="shopSaleNumber_{$T.Result.sid}">{$T.Result.shopSaleNumber}</td>
													<td align="center" id="shopRefundNumber_{$T.Result.sid}">{$T.Result.shopRefundNumber}</td>
													<td align="center" id="netSaleNumber_{$T.Result.sid}">{$T.Result.netSaleNumber}</td>
													<td align="center" id="netRefundNumber_{$T.Result.sid}">{$T.Result.netRefundNumber}</td>
													<td align="center" id="cashierNumber_{$T.Result.sid}">{$T.Result.cashierNumber}</td>
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