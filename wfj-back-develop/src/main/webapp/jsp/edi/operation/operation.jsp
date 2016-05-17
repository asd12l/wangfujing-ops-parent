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
<!--Bootstrap Date Range Picker-->
<script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";
	var stockPagination;
	
	$(function() { 
		$('#startDate').daterangepicker({
			timePicker: true,
			timePickerIncrement: 15,
			format: 'YYYY/MM/DD HH:mm:ss',
            locale : {
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        });
		initStock();
		$("#pageSelect").change(stockQuery);
	});
	
	function olvQuery(){
		$("#tid_form").val($("#tid_input").val());
		$("#operationType_form").val($("#operationType_select").val());
		$("#operation_form").val($("#operation_select").val());
		$("#channel_form").val($("#channel_select").val());
		
		var strTime = $("#startDate").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startDate_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endDate_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startDate_form").val("");
			$("#endDate_form").val("");
		}
        var params = $("#stock_form").serialize(); 
        params = decodeURI(params);
        stockPagination.onLoad(params);
	}
	
	function reset() {
		$("#tid_input").val("");
		$("#channel_select").val("");
		$("#operationType_select").val("");
		$("#operation_select").val("");
		$("#startDate").val("");
		$("#endDate").val("");
		
		$("#tid_form").val("");
		$("#operationType_form").val("");
		$("#operation_form").val("");
		$("#channel_form").val("");
		$("#startDate_form").val("");
		$("#endDate_form").val("");
		stockQuery();
	}
	function stockQuery() {
		var params = $("#stock_form").serialize();
		params = decodeURI(params);
		stockPagination.onLoad(params);
		
	}
	
	function initStock() {
		var url = $("#ctxPath").val()+"/ediLog/selectLogList";
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
								<h5 class="widget-caption">日志查询</h5>
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
									<ul class="topList clearfix">
										<li class="col-md-4"><label class="titname">渠道标识：</label> <select
											id="channel_select" style="padding: 0 0;">
												<option value="">全部</option>
												<option value="C7">天猫</option>
												<option value="CA">爱逛街</option>
												<option value="CB">全球购</option>
												<option value="C8">聚美</option>
												<option value="M4">有赞</option>
										</select></li>
										
										<li class="col-md-4"><label class="titname">操作类型：</label> <select
											id="operationType_select" style="padding: 0 0;">
												<option value="">全部</option>
												<option value="spgl">商品关联</option>
												<option value="ddcx">订单查询</option>
												<option value="ddhq">订单获取</option>
												<option value="ycdd">异常订单</option>
												<option value="tdhq">退单获取</option>
										</select></li>
										
										<li class="col-md-4"><label class="titname">操作：</label> <select
											id="operation_select" style="padding: 0 0;">
												<option value="">全部</option>
												<option value="sdgl">手动关联</option>
												<option value="plgl">批量关联</option>
												<option value="jcgl">解除关联</option>
												<option value="export">导出</option>
												<option value="toObtain">获取</option>
												<option value="upSave">修改保存</option>
										</select></li>
										
										
										<li class="col-md-4"><label class="titname">操作时间：</label>
											<input type="text" id="startDate" />
										</li>
										
										<li class="col-md-4"><label class="titname">操作编号：</label>
											<input type="text" id="tid_input" /></li>
											
										<li class="col-md-4"><a id="editabledatatable_new" 
											onclick="olvQuery();" class="btn btn-yellow"> <i
												class="fa fa-eye"></i> 查询
										</a> <a id="editabledatatable_new" onclick="reset();"
											class="btn btn-primary"> <i class="fa fa-random"></i> 重置
										</a></li>
									</ul>
								</div>
								<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="stock_tab">
                                       <thead class="flip-content bordered-darkorange">
										<tr role="row">
													<th style="text-align: center;">操作编号</th>
													<!-- tid -->
													<th style="text-align: center;">渠道标识</th>
													<!--ordersid -->
													<th style="text-align: center;">操作类型</th>
													<!--receiverName -->
													<th style="text-align: center;">操作</th>
													<!-- buyerNick -->
													<th style="text-align: center;">错误信息（英）</th>
													<!--receiverMobile  -->
													<th style="text-align: center;">错误信息（中）</th>
													<!-- payment -->
													<th style="text-align: center;">操作人</th>
													<!-- tradeStatus -->
													<th style="text-align: center;">操作时间</th>
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
											<input type="hidden" id="tid_form" name="tid" /> 
											<input type="hidden" id="operationType_form" name="operationType" /> 
											<input type="hidden" id="operation_form" name="operation" /> 
											<input type="hidden" id="channel_form" name="channel" /> 
											<input type="hidden" id="startDate_form" name="startDate" /> 
											<input type="hidden" id="endDate_form" name="endDate" /> 
											<input type="hidden" id="action_form" name="action" value="query"/> 
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
													<td align="center" id="tid_{$T.Result.tid}">{$T.Result.tid}</td>
													<td align="center" id="channel_{$T.Result.tid}">{$T.Result.channel}</td>
													<td align="center" id="operationType_{$T.Result.tid}">{$T.Result.operationType}</td>
													<td align="center" id="operation_{$T.Result.tid}">{$T.Result.operation}</td>
													<td align="center" id="errorMsgEn_{$T.Result.errorMsgEn}">
														{#if $T.Result.errorMsgEn == "" || $T.Result.errorMsgEn == null} ---
														{#else} {$T.Result.errorMsgEn}
													   	{#/if}	
													</td>
													<td align="center" id="errorMsgCn_{$T.Result.errorMsgCn}">
														{#if $T.Result.errorMsgCn == "" || $T.Result.errorMsgCn == null} ---
														{#else} {$T.Result.errorMsgCn}
													   	{#/if}
													</td>
													<td align="center" id="operator_{$T.Result.operator}">
														{#if $T.Result.operator == "" || $T.Result.operator == null} ---
														{#else} {$T.Result.operator}
													   	{#/if}
													</td>
													<td align="center" id="cdate_{$T.Result.cdate}">{$T.Result.cdate}</td>
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