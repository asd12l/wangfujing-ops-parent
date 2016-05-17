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
		$("#orderSourceSid_form").val($("#orderSourceSid_select").val());
		$("#payTypes_form").val($("#payTypes_select").val());
		$("#IfReturn_form").val($("#IfReturn_select").val());
		var strTime = $("#reservation").val();
		if (strTime != "") {
			strTime = strTime.split("-");
			$("#startSaleTime_form").val(
					$.trim(strTime[0].replace("/", "-").replace("/", "-")));
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
		$("#orderSourceSid_select").val("");
		$("#payTypes_select").val("");
		$("#IfReturn_select").val("");
		$("#reservation").val("");
		olvQuery();
	}
	
	function exportExcel(){
		var OrderSource= $("#orderSourceSid_select").val();
		var payTypes = $("#payTypes_select").val();
		var IfReturn = $("#IfReturn_select").val();
		var strTime = $("#reservation").val();
		if (strTime != "") {
			strTime = strTime.split("-");
			var saleTimeFrom = strTime[0].replace("/", "-").replace("/", "-");
			var	saleTimeTo= strTime[1].replace("/", "-").replace("/", "-");
		} else {
			var saleTimeFrom = "";
			var	saleTimeTo= "";
		}
		saleTimeTo=$.trim(saleTimeTo);
		var title = "SHOPIN"+saleTimeFrom+"to"+saleTimeTo+"ORDERsOURCE";
		var count =  $("#olv_tab tbody tr").length;
		if(count>0&&saleTimeFrom!=""&&saleTimeTo!=""){
		 window.open(__ctxPath+"/stateExcel/orderSourceToExcel?OrderSource="+OrderSource+"&&payTypes="+payTypes
			+"&&IfReturn="+IfReturn+"&&saleTimeFrom="+saleTimeFrom+"&&saleTimeTo="+saleTimeTo+"&&title="+title);
		}else{
			
			$("#model-body-warning").html("<div class='alert alert-warning fade in'>"
					+ "<i class='fa-fw fa fa-times'></i><strong>不能生成空的Excel!</strong></div>");
			$("#modal-warning").attr({
									"style" : "display:block;",
									"aria-hidden" : "false",
									"class" : "modal modal-message modal-warning"
								});
		}
	}
	
	
	function exportPDF(){
		var OrderSource= $("#orderSourceSid_select").val();
		var payTypes = $("#payTypes_select").val();
		var IfReturn = $("#IfReturn_select").val();
		var strTime = $("#reservation").val();
		if (strTime != "") {
			strTime = strTime.split("-");
			var saleTimeFrom = strTime[0].replace("/", "-").replace("/", "-");
			var	saleTimeTo= strTime[1].replace("/", "-").replace("/", "-");
		} else {
			var saleTimeFrom = "";
			var	saleTimeTo= "";
		}
		saleTimeTo=$.trim(saleTimeTo);
		var title = "SHOPIN"+saleTimeFrom+"to"+saleTimeTo+"ORDERsOURCE";
		var count =  $("#olv_tab tbody tr").length;
		if(count>0&&saleTimeFrom!=""&&saleTimeTo!=""){
		 window.open(__ctxPath+"/statePDF/orderSourceToPDF?OrderSource="+OrderSource+"&&payTypes="+payTypes
			+"&&IfReturn="+IfReturn+"&&saleTimeFrom="+saleTimeFrom+"&&saleTimeTo="+saleTimeTo+"&&title="+title);
		}else{
			
			$("#model-body-warning").html("<div class='alert alert-warning fade in'>"
					+ "<i class='fa-fw fa fa-times'></i><strong>不能生成空的PDF!</strong></div>");
			$("#modal-warning").attr({
									"style" : "display:block;",
									"aria-hidden" : "false",
									"class" : "modal modal-message modal-warning"
								});
		}
	} 
	
	
	function initOlv() {
		var url = __ctxPath + "/statement/OrderSourceController";
		olvPagination = $("#olvPagination").myPagination({
	           panel: {
	             tipInfo_on: true,
	             tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
	             tipInfo_css: {
	               width: '25px',
	               height: "20px",
	               border: "2px solid #f0f0f0",
	               padding: "0 0 0 5px",
	               margin: "0 5px 0 5px",
	               color: "#48b9ef"
	             }
	           },
	           debug: false,
	           ajax: {
	             on: true,
	             url: url,
	             dataType: 'json',
	             ajaxStart: function() {
	               ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
	             },
	             ajaxStop: function() {
	               //隐藏加载提示
	               setTimeout(function() {
	                 ZENG.msgbox.hide();
	               }, 300);
	             },
	             callback: function(data) {
	           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
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
								<span class="widget-caption"><h5>订单来源统计报表管理</h5>
								</span>
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
										<div class="col-lg-4">
											<span>订单来源：</span>
										</div>
										<div class="col-lg-8">
											<select id="orderSourceSid_select"
												style="padding: 0 0; width: 100%;"></select>&nbsp;
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-4">
											<span>付款类型：</span>
										</div>
										<div class="col-lg-8">
											<select id="payTypes_select"
												style="padding: 0 0; width: 100%">
												<option value="">所有</option>
												<option value="1">未支付</option>
												<option value="2">已支付</option>
											</select>&nbsp;
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-4">
											<span>是否退货：</span>
										</div>
										<div class="col-lg-8">
											<select id="IfReturn_select"
												style="padding: 0 0; width: 100%">
												<option value="">所有</option>
												<option value="1">退货</option>
												<option value="0">无退货</option>
											</select>&nbsp;
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-4">时&nbsp;&nbsp;间</div>
										<div class="col-lg-8">
											<input type="text" id="reservation" style="width: 100%" />
										</div>
									</div>
									<div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="olvQuery();" class="btn btn-yellow" style="width: 100%;">
	                                    		<i class="fa fa-eye"></i>
												查询
	                                        </a>
                                        </div>
                                        <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="reset();" class="btn btn-primary" style="width: 100%;">
	                                        	<i class="fa fa-random"></i>
												重置
	                                        </a>&nbsp;
	                                    </div>
									<div class="col-md-4">
										<div class="col-lg-12">
											<a class="btn btn-darkorange" onclick="exportExcel();"><i class="fa fa-share-alt"></i>导出EXCEL</a>
											<a class="btn btn-maroon" onclick="exportPDF();"><i class="fa fa-share-alt-square"></i>导出PDF</a>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<form id="olv_form" action="">
											<input type="hidden" id="orderSourceSid_form" name="OrderSource" /> 
											<input type="hidden" id="payTypes_form" name="payTypes" /> 
											<input type="hidden" id="IfReturn_form" name="IfReturn" /> 
											<input type="hidden" id="startSaleTime_form" name="saleTimeFrom" />
											<input type="hidden" id="endSaleTime_form" name="saleTimeTO" />
										</form>
									</div>
								</div>
								<div style="width: 100%; height: 400px; overflow: scroll;">
									<table class="table-striped table-hover table-bordered"
										id="olv_tab"
										style="width: 100%; background-color: #fff; margin-bottom: 0;">
										<thead>
											<tr role="row">
												<th width="5%" style="text-align: center;">订单来源</th>
												<th width="5%" style="text-align: center;">订单状态</th>
												<th width="5%" style="text-align: center;">是否退货</th>
												<th width="5%" style="text-align: center;">订单数量</th>
												<th width="5%" style="text-align: center;">销售总金额</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" ">
													<td align="center" id="orderSource_{$T.Result.sid}">{$T.Result.orderSource}</td>
													<td align="center" id="ifPay_{$T.Result.sid}">
														{#if $T.Result.ifPay == '1'}未支付
														{#elseif $T.Result.ifPay == '2'}已支付
														{#/if}
													</td>
													<td align="center" id="ifRefund_{$T.Result.sid}">
														{#if $T.Result.ifRefund == '1'}退货
														{#elseif $T.Result.ifRefund == '0'}无退货
														{#/if}
													</td>
													<td align="center" id="saleAllSum_{$T.Result.sid}">{$T.Result.saleAllSum}</td>
													<td align="center" id="saleAllPrice_{$T.Result.sid}">{$T.Result.saleAllPrice}</td>
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