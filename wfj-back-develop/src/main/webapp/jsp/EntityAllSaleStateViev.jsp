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
		$('#reservation').daterangepicker();
		initOlv();
	});
	function olvQuery() {
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
		$("#reservation").val("");
		olvQuery();
	}
	
	function initOlv() {
		var url = __ctxPath + "/statement/entityAllSaleController";
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
	
	
	function exportExcel(){
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
		var title = "SHOPIN"+saleTimeFrom+"To"+saleTimeTo+"ENTITYSALEANDREFUND";
		var count =  $("#olv_tab tbody tr").length;
		if(count>0&&saleTimeFrom!=""&&saleTimeTo!=""){
			window.open(__ctxPath+"/stateExcel/entityAllSaleToExcel?saleTimeFrom="+saleTimeFrom+"&&saleTimeTo="+saleTimeTo+"&&title="+title);
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
		var title = "SHOPIN"+saleTimeFrom+"To"+saleTimeTo+"ENTITYALEANDREFUND";
		var count =  $("#olv_tab tbody tr").length;
		if(count>0&&saleTimeFrom!=""&&saleTimeTo!=""){
			window.open(__ctxPath+"/statePDF/entityAllSaleToPDF?saleTimeFrom="+saleTimeFrom+"&&saleTimeTo="+saleTimeTo+"&&title="+title);
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
								<span class="widget-caption"><h5>实体每日销售管理</h5>
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
										<div class="col-lg-3">时间</div>
										<div class="col-lg-9">
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
											<input type="hidden" id="pageSelect" name="pageSize" value="15" /> 
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
												<th width="5%" style="text-align: center;">门店</th>
												<th width="5%" style="text-align: center;">销售总金额</th>
												<th width="5%" style="text-align: center;">退货总金额</th>
												<th width="5%" style="text-align: center;">合计</th>
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
												<tr class="gradeX" id="gradeX{$T.Result.sid}" onclick="trClick({$T.Result.sid})">
													<td align="center" id="shopSid_{$T.Result.sid}">{$T.Result.shopSid}</td>
													<td align="center" id="shopSalePrice_{$T.Result.sid}">{$T.Result.shopSalePrice}</td>
													<td align="center" id="shopRefundPrice_{$T.Result.sid}">{$T.Result.shopRefundPrice}</td>
													<td align="center" id="shopRealPrice_{$T.Result.sid}">{$T.Result.shopRealPrice}</td>
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