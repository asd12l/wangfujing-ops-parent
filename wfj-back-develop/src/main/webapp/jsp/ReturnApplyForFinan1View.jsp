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
			url : __ctxPath + "/DataDictionary/getItemType?dictTypeCode=" + 1,
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
				$("#payType_Finan_select").append(option);
			}
		});
		$.ajax({
			url : __ctxPath + "/DataDictionary/getItemType?dictTypeCode=" + 51,
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
				$("#shop_Name_Return_select").append(option);
			}
		});
		$.ajax({
			url : __ctxPath + "/DataDictionary/getItemType?dictTypeCode=" + 0,
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
				$("#refund_status_select").append(option);
			}
		});
		$('#reservation1').daterangepicker();
		$('#reservation2').daterangepicker();
		initOlv();
	});
	function olvQuery() {
		$("#orderNo_form").val($("#orderNo_input").val());
		$("#refundApplyNo_form").val($("#refundApplyNo_select").val());
		var strTime = $("#reservation1").val();
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

		$("#parentOrderNo_form").val($("#parentOrderNo_select").val());
		$("#bank_Number_form").val($("#bank_Number_input").val());
		var strTime2 = $("#reservation2").val();
		if (strTime2 != "") {
			strTime2 = strTime2.split("-");
			$("#startSaleTime2_form").val(
					strTime2[0].replace("/", "-").replace("/", "-"));
			$("#endSaleTime2_form").val(
					$.trim(strTime2[1].replace("/", "-").replace("/", "-")));
		} else {
			$("#startSaleTime2_form").val("");
			$("#endSaleTime2_form").val("");
		}

		$("#payType_Finan_form").val($("#payType_Finan_select").val());
		$("#shop_Name_Return_form").val($("#shop_Name_Return_select").val());
		$("#refund_status_select").val($("#refund_status_select").val());
		var params = $("#olv_form").serialize();
		params = decodeURI(params);
		olvPagination.onLoad(params);
	}
	function reset() {
		$("#orderNo_input").val("");
		$("#refundApplyNo_input").val("");
		$("#reservation1").val("");
		$("#parentOrderNo_input").val("");
		$("#bank_Number_input").val("");
		$("#reservation2").val("");
		$("#payType_Finan_select").val("");
		$("#shop_Name_Return_select").val("");
		$("#refund_status_select").val("");
		olvQuery();
	}
	function exportExcel() {
		var applyNo = $("#refundApplyNo_input").val();
		var orderno = $("#orderNo_input").val();
		var payType = $("#payType_Finan_select").val();
		var bankNumber = $("#bank_Number_input").val();
		var parentOrderNo = $("#parentOrderNo_input").val();
		var shopName = $("#shop_Name_Return_select").val();
		var refundStatus = $("#refund_status_select").val();

		var startSaleTime = $("#startSaleTime_form").val();
		var endSaleTime = $("#endSaleTime_form").val();
		endSaleTime = $.trim(endSaleTime);
		var finaceConfirmTimeStart = $("#startSaleTime2_form").val();
		var finaceConfirmTimeEnd = $("#endSaleTime2_form").val();
		finaceConfirmTimeEnd = $.trim(finaceConfirmTimeEnd);
		var count = $("#olv_tab tbody tr").length;
		if (count > 0) {
			window.open(__ctxPath
					+ "/cod/exportRefundApplyExcel?startSaleTime="
					+ startSaleTime + "&&endSaleTime=" + endSaleTime
					+ "&&orderNo=" + orderno + '&&refundApplyNo=' + applyNo
					+ "&&paymentTypeSid=" + payType + "&&bankNumber="
					+ bankNumber + "&&refundStatus=" + refundStatus
					+ "&&shopName=" + shopName + "&&parentOrderNo="
					+ parentOrderNo + "&&finaceConfirmTimeStart="
					+ finaceConfirmTimeStart + "&&finaceConfirmTimeEnd="
					+ finaceConfirmTimeEnd + "&&title=RefundApplyExcel");
		} else {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'>"
									+ "<i class='fa-fw fa fa-times'></i><strong>不能生成空的Excel!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
		}
	}
	function ok() {
		
	}
	//初始化包装单位列表
	function initOlv() {
		var url = __ctxPath + "/order/selectRefundApplyForFin";
		olvPagination = $("#olvPagination")
				.myPagination(
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
									//支付类型
									$.ajax({
												url : __ctxPath
														+ "/DataDictionary/getItemType?dictTypeCode=1",
												dataType : "json",
												async : false,
												success : function(response) {
													var result = response.list;
													for ( var j = 0; j < result.length; j++) {
														for ( var i = 0; i < data.list.length; i++) {
															var ele = data.list[i];
															if (ele.paymentTypeSid == result[j].dictItemCode) {
																data.list[i].paymentTypeSid = result[j].dictItemName;
															}
														}
													}
												}
											});
									$("#olv_tab tbody").setTemplateElement(
											"olv-list").processTemplate(data);
								}
							}
						});
	}

	//点击tr事件
	function trClick(orderSid) {
		$("#OLV2_tab")
				.html(
						"<tr role='row'><th width='5%' style='text-align: center;'>退货申请单号</th><th width='5%' style='text-align: center;'>品牌名称</th><th width='5%' style='text-align: center;'>商品名称</th><th width='6%' style='text-align: center;'>计量单位</th><th width='6%' style='text-align: center;'>包装单位</th><th width='4%' style='text-align: center;'>退货单价</th><th width='5%' style='text-align: center;'>退货总数</th><th width='5%' style='text-align: center;'>退款总金额</th><th width='6%' style='text-align: center;'>收银流水号</th><th width='5%' style='text-align: center;'>调拨状态描述</th><th width='4%' style='text-align: center;'>库存类别</th><th width='4%' style='text-align: center;'>退货原因</th><th width='6%' style='text-align: center;'>导购确认收货状态</th><th width='4%' style='text-align: center;'>残损金额</th></tr>");
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/order/selectRefundApplyDetailByParam",
			async : false,
			dataType : "json",
			data : {
				"orderSid" : orderSid
			},
			success : function(response) {
				if (response.success = 'true') {
					var result = response.list;
					var option = "";
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						//退货申请单号
						if (ele.refundApplyNo == undefined) {
							option += "<tr><td align='center'></td>";
						} else {
							option += "<tr><td align='center'>"
									+ ele.refundApplyNo + "</td>";
						}
						//品牌名称
						if (ele.brandName == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>" + ele.brandName
									+ "</td>";
						}
						//商品名称
						if (ele.productName == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>" + ele.productName
									+ "</td>";
						}
						//计量单位
						if (ele.proSize == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>" + ele.proSize
									+ "</td>";
						}
						//包装单位
						if (ele.proColor == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>" + ele.proColor
									+ "</td>";
						}
						//退货单价
						if (ele.refundPrice == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>" + ele.refundPrice
									+ "</td>";
						}
						//退货总数
						if (ele.refundNum == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>" + ele.refundNum
									+ "</td>";
						}
						//退款总金额
						if (ele.refundMoneySum == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>"
									+ ele.refundMoneySum + "</td>";
						}
						//收银流水号
						if (ele.cashierNumber == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>" + ele.cashierNumber
									+ "</td>";
						}
						//调拨状态描述
						if (ele.allotStatusDesc == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>"
									+ ele.allotStatusDesc + "</td>";
						}
						//库存类别
						if (ele.stockTypeSid == 0) {
							option += "<td align='center'>正品库</td>";
						} else {
							option += "<td align='center'>次品库</td>";
						}
						//退货原因
						if (ele.refundReasonDesc == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>"
									+ ele.refundReasonDesc + "</td>";
						}
						//导购确认收货状态
						if (ele.confirmStatus == 0) {
							option += "<td align='center'>未确认收货</td></tr>";
						} else {
							option += "<td align='center'>确认收货</td></tr>";
						}
						//残损金额
						if (ele.damagedPrice == undefined) {
							option += "<td align='center'></td>";
						} else {
							option += "<td align='center'>" + ele.damagedPrice
									+ "</td>";
						}
					}
					$("#OLV2_tab").append(option);
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
								<span class="widget-caption"><h5>财务退货退款确认管理</h5> </span>
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
										<div class="col-lg-5">申请退款时间:</div>
										<div class="col-lg-7">
											<input type="text" id="reservation1" style="width: 100%" />&nbsp;
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-5">
											<span>订单号：</span>
										</div>
										<div class="col-lg-7">
											<input type="text" id="orderNo_input" style="width: 100%;" />
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-5">
											<span>退货申请单号：</span>
										</div>
										<div class="col-lg-7">
											<input type="text" id="refundApplyNo_input"
												style="width: 100%;" />&nbsp;
										</div>
									</div>

									<div class="col-md-4">
										<div class="col-lg-5">财务退款时间:</div>
										<div class="col-lg-7">
											<input type="text" id="reservation2" style="width: 100%" />&nbsp;
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-5">
											<span>父订单号：</span>
										</div>
										<div class="col-lg-7">
											<input type="text" id="parentOrderNo_input"
												style="width: 100%;" />
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-5">
											<span>银行账号：</span>
										</div>
										<div class="col-lg-7">
											<input type="text" id="bank_Number_input"
												style="width: 100%;" />&nbsp;
										</div>
									</div>

									<div class="col-md-4">
										<div class="col-lg-5">
											<span>支付方式：</span>
										</div>
										<div class="col-lg-7">
											<select id="payType_Finan_select"
												style="padding: 0 0; width: 100%;"></select>
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-5">
											<span>门店：</span>
										</div>
										<div class="col-lg-7">
											<select id="shop_Name_Return_select"
												style="padding: 0 0; width: 100%;"></select>
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-5">
											<span>申请单状态：</span>
										</div>
										<div class="col-lg-7">
											<select id="refund_status_select"
												style="padding: 0 0; width: 100%;"></select>&nbsp;
										</div>
									</div>
									<div class="col-md-5">
										<div class="col-lg-12">

											<a class="btn btn-default" onclick="olvQuery();">查询</a>
											&nbsp; <a class="btn btn-default" onclick="reset();">重置</a>
											&nbsp; <a class="btn btn-default" onclick="exportExcel();">导出EXCEL</a>
											&nbsp; <a class="btn btn-default" onclick="ok();">确认退款</a>

										</div>
										&nbsp;
									</div>
									<div class="col-md-7">
										<div class="col-lg-3">
											<span>退款总金额</span>
										
											<input type="text" id="bank_Number_input"
												style="padding: 0 0; width: 80%;" placeholder="0.00" />
										</div>

										<div class="col-lg-3">
											<span>退券总金额</span>
										
											<input type="text" id="refundMoneySumAll"
												style="padding: 0 0; width: 80%;" placeholder="0.00" />
										</div>
										<div class="col-lg-3">
											<span>公司应付总费用</span>
										
											<input type="text" id="companyPostageAll"
												style="padding: 0 0; width: 80%;" placeholder="0.00" />
										</div>
										<div class="col-lg-3">
											<span>公司退款总金额</span>
										
											<input type="text" id="needRefundMoneyAll"
												style="padding: 0 0; width: 80%;" placeholder="0.00" />
										</div>

									</div>

									<div class="col-md-4">
										<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize"
												value="15" /> <input type="hidden" id="orderNo_form"
												name="orderNo" /> <input type="hidden"
												id="refundApplyNo_form" name="refundApplyNo" /> <input
												type="hidden" id="startSaleTime_form" name="startSaleTime" />
											<input type="hidden" id="endSaleTime_form" name="endSaleTime" />
											<input type="hidden" id="parentOrderNo_form"
												name="parentOrderNo" /> <input type="hidden"
												id="bank_Number_form" name="bank_Number" /> <input
												type="hidden" id="startSaleTime2_form" name="startSaleTime2" />
											<input type="hidden" id="endSaleTime2_form"
												name="endSaleTime2" /> <input type="hidden"
												id="payType_Finan_form" name="payType_Finan" /> <input
												type="hidden" id="shop_Name_Return_form"
												name="shop_Name_Return" /> <input type="hidden"
												id="refund_status_form" name="refund_status" />
										</form>
									</div>
								</div>
								<div style="width: 1070px; height: 225px; overflow: scroll;">
									<table class="table-striped table-hover table-bordered"
										id="olv_tab"
										style="width: 200%; background-color: #fff; margin-bottom: 0;">
										<thead>
											<tr role="row">
												<th width="6%" style="text-align: center;">订单号</th>
												<th width="6%" style="text-align: center;">父订单号</th>
												<th width="4%" style="text-align: center;">支付方式</th>
												<th width="4%" style="text-align: center;">退货数量</th>
												<th width="4%" style="text-align: center;">退款金额</th>
												<th width="5%" style="text-align: center;">公司应付运费</th>
												<th width="5%" style="text-align: center;">顾客购买运费</th>
												<th width="5%" style="text-align: center;">顾客寄回运费</th>
												<th width="3%" style="text-align: center;">退券金额</th>
												<th width="5%" style="text-align: center;">实际退款金额</th>
												<th width="4%" style="text-align: center;">退货类型</th>
												<th width="5%" style="text-align: center;">退货申请单状态</th>
												<th width="5%" style="text-align: center;">退货申请单号</th>
												<th width="5%" style="text-align: center;">优惠券使用金额</th>
												<th width="4%" style="text-align: center;">收货人</th>
												<th width="5%" style="text-align: center;">退款确认姓名</th>
												<th width="5%" style="text-align: center;">退款申请时间</th>
												<th width="5%" style="text-align: center;">财务退款时间</th>
												<th width="6%" style="text-align: center;">物流确认收货时间</th>
												<th width="5%" style="text-align: center;">物流备注</th>
												<th width="5%" style="text-align: center;">客服备注</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>

								<div style="width: 1070px; height: 95px; overflow: scroll;">
									<table class="table-striped table-hover table-bordered"
										id="OLV2_tab"
										style="width: 130%; background-color: #fff; margin-bottom: 0;">
										<tr role="row">
											<th width="5%" style="text-align: center;">退货申请单号</th>
											<th width="5%" style="text-align: center;">品牌名称</th>
											<th width="5%" style="text-align: center;">商品名称</th>
											<th width="6%" style="text-align: center;">计量单位</th>
											<th width="6%" style="text-align: center;">包装单位</th>
											<th width="4%" style="text-align: center;">退货单价</th>
											<th width="5%" style="text-align: center;">退货总数</th>
											<th width="5%" style="text-align: center;">退款总金额</th>
											<th width="6%" style="text-align: center;">收银流水号</th>
											<th width="5%" style="text-align: center;">调拨状态描述</th>
											<th width="4%" style="text-align: center;">库存类别</th>
											<th width="4%" style="text-align: center;">退货原因</th>
											<th width="6%" style="text-align: center;">导购确认收货状态</th>
											<th width="4%" style="text-align: center;">残损金额</th>
										</tr>
									</table>
								</div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" onclick="trClick({$T.Result.sid})">
													
													<td align="center" id="orderNo_{$T.Result.sid}">{$T.Result.orderNo}</td>
													<td align="center" id="parentOrderNo_{$T.Result.sid}">{$T.Result.parentOrderNo}</td>
													<td align="center" id="paymentTypeSid_{$T.Result.sid}">{$T.Result.paymentTypeSid}</td>
													
													<td align="center" id="refundNum_{$T.Result.sid}">{$T.Result.refundNum}</td>
													<td align="center" id="refundMoneySum_{$T.Result.sid}">{$T.Result.refundMoneySum}</td>
													<td align="center" id="companyPostage_{$T.Result.sid}">{$T.Result.companyPostage}</td>
													<td align="center" id="goPostage_{$T.Result.sid}">{$T.Result.goPostage}</td>
													<td align="center" id="comePostage_{$T.Result.sid}">{$T.Result.comePostage}</td>
													<td align="center" id="refundTicketSnPrice_{$T.Result.sid}">{$T.Result.refundTicketSnPrice}</td>
													<td align="center" id="needRefundMoney_{$T.Result.sid}">{$T.Result.needRefundMoney}</td>
													<td align="center" id="refundGoodDesc_{$T.Result.sid}">{$T.Result.refundGoodDesc}</td>
													<td align="center" id="refundStatus_{$T.Result.sid}">
														{#if $T.Result.refundStatus == '-1'}已作废
						                      			{#elseif $T.Result.refundStatus == '0'}超时
						           						{#elseif $T.Result.refundStatus == '1'}草稿
						           						{#elseif $T.Result.refundStatus == '-2'}审核未通过
						           						{#elseif $T.Result.refundStatus == '2'}审核通过
						           						{#elseif $T.Result.refundStatus == '3'}确认收货
						           						{#elseif $T.Result.refundStatus == '4'}确认退货
						                   				{#/if}
													</td>
													<td align="center" id="refundApplyNo_{$T.Result.sid}">{$T.Result.refundApplyNo}</td>
													<td align="center" id="ticketSnUsePrice_{$T.Result.sid}">{$T.Result.ticketSnUsePrice}</td>
													<td align="center" id="receptName_{$T.Result.sid}">{$T.Result.receptName}</td>
													<td align="center" id="paymentRealName_{$T.Result.sid}">{$T.Result.paymentRealName}</td>
													<td align="center" id="applyTime_{$T.Result.sid}">{$T.Result.applyTime}</td>
													<td align="center" id="finaceConfirmTime_{$T.Result.sid}">{$T.Result.finaceConfirmTime}</td>
													<td align="center" id="logisticsConfirmTime_{$T.Result.sid}">{$T.Result.logisticsConfirmTime}</td>
													<td align="center" id="logisticsMemo_{$T.Result.sid}">{$T.Result.logisticsMemo}</td>
													<td align="center" id="customerServiceMemo_{$T.Result.sid}">{$T.Result.customerServiceMemo}</td>
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