<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<!--Jquery Select2-->

<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
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
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";
	var stockPagination;

	$(function() {
		$('#startDate').daterangepicker(
				{
					timePicker : true,
					timePickerIncrement : 15,
					format : 'YYYY/MM/DD HH:mm:ss',
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

	function olvQuery() {
		$("#orderNo_form").val($("#tid_input").val());
		$("#src_form").val($("#src").val());
		$("#isPost_form").val($("#isPost").val());
			
		var strTime = $("#startDate").val();
		
		if (strTime != "") {
			strTime = strTime.split("-");
			$("#startDate_form").val(
					strTime[0].replace("/", "-").replace("/", "-"));
			$("#endDate_form").val(
					strTime[1].replace("/", "-").replace("/", "-"));
		} else {
			$("#startDate_form").val("");
			$("#endDate_form").val("");
		}
		var params = $("#stock_form").serialize();
		params = decodeURI(params);
		stockPagination.onLoad(params);
	}

	function reset() {
		$("#tid_input").val("");
		$("#src").val("");
		$("#isPost").val("");
		$("#startDate").val("");
		$("#endDate").val("");
		
		$("#orderNo_form").val("");
		$("#src_form").val("");
		$("#isPost_form").val("");
		$("#startDate_form").val("");
		$("#endDate_form").val("");
		stockQuery();
	}
	function stockQuery() {
		var params = $("#stock_form").serialize();
		params = decodeURI(params);
		stockPagination.onLoad(params);
	}
	// 导出excel
	function exportexcle() {
		
		$("#orderNo_form").val($("#tid_input").val());
		$("#src_form").val($("#src").val());
		$("#isPost_form").val($("#isPost").val());
		var strTime = $("#startDate").val();
		if (strTime != "") {
			strTime = strTime.split("-");
			$("#startDate_form").val(
					strTime[0].replace("/", "-").replace("/", "-"));
			$("#endDate_form").val(
					strTime[1].replace("/", "-").replace("/", "-"));
		} else {
			$("#startDate_form").val("");
			$("#endDate_form").val("");
		}
		var orderNo = $("#orderNo_form").val();
		var src = $("#src_form").val();
		var isPost = $("#isPost_form").val();
		
		var startDate = $("#startDate_form").val();
		var endDate = $("#endDate_form").val();
		var count = $("#stock_tab tbody tr").length;
		if (count > 0) {
			var form = $('#stock_form');
			form.attr("method", "post");
			form.attr('action', $("#ctxPath").val() + "/ediCps/exportExcle");
			form.submit();
			/* window.open($("#ctxPath").val()
					+ "/ediOrder/exportExcle?tradesource=C7&&tid=" + tid
					+ "&&ordersId=" + ordersId + "&&startDate=" + startDate
					+ "&&endDate=" + endDate + "&&receiverName=" + receiverName
					+ "&&title=" + goodName + "&&status=" + status
					+ "&&symbol=" + symbol + "&&totalAmount=" + amount
					+ "&&count=" + count); */
		} else {

			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'>"
									+ "<i class='fa-fw fa fa-times'></i><strong>不能生成空的EXCEL!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
		}
	
	}

	function initStock() {
		var url = $("#ctxPath").val()
				+ "/ediCps/selectCpsList";
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
								<h5 class="widget-caption">推广CPS数据查看</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
										<ul class="topList clearfix">
											<li class="col-md-4"><label class="titname">订单编号：</label>
												<input type="text" id="tid_input" /></li>
											<li class="col-md-4"><label class="titname">渠道：</label>
												<select id="src" class="titname">
													<option value="">全部</option>
													<option value="yiqifa">亿起发</option>
													<option value="linktech">领科特</option>
													<option value="duomai">多麦</option>
											</select></li>
											<li class="col-md-4"><label class="titname">是否推送：</label>
												<select id="isPost" class="titname">
													<option value="">全部</option>
													<option value="0">未推送</option>
													<option value="1">已推送</option>
											</select></li>
											<li class="col-md-4"><label class="titname">订单时间：</label>
												<input type="text" id="startDate" /></li>


											<li class="col-md-6"><a id="editabledatatable_new"
												onclick="olvQuery();" class="btn btn-yellow"> <i
													class="fa fa-eye"></i> 查询
											</a> <a id="editabledatatable_new" onclick="exportexcle();"
												class="btn btn-primary"> <i class="fa fa-random"></i> 导出
											</a> <a id="editabledatatable_new" onclick="reset();"
												class="btn btn-primary"> <i class="fa fa-random"></i> 重置
											</a></li>
										</ul>
									<div>
										<span style="color: red; margin-bottom: 10px;">出于安全考虑，请到中台系统'报表管理'---->'市场报表'---->'渠道订单明细报表'进行查看详细信息以及导出Excel
											! </span>
									</div>
									<table
										class="table table-bordered table-striped table-condensed table-hover flip-content"
										id="stock_tab">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;">订单编号</th>
												<!-- tid -->
												<th style="text-align: center;">渠道</th>
												<!--ordersid -->
												<th style="text-align: center;">创建时间</th>
												<!--receiverName -->
												<th style="text-align: center;">是否发送</th>

												<!-- createDate -->
												<!-- 													<th style="text-align: center;">操作</th>
 -->
												<!-- increment -->
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
											&nbsp; <input type="hidden" id="orderNo_form" name="orderNo" /> <input
												type="hidden" id="src_form" name="src" /> <input
											    type="hidden" id="isPost_form" name="isPost" /> <input
												type="hidden" id="startDate_form" name="startDate" /> <input
												type="hidden" id="endDate_form" name="endDate" /> <input
												type="hidden" id="action_form" name="action" value="query" />
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
													<td align="center" id="orderNo_{$T.Result.sid}">{$T.Result.orderId}</td>
													<td align="center" id="src_{$T.Result.sid}">{$T.Result.src}</td>
													<td align="center" id="createTime_{$T.Result.sid}">{$T.Result.creatTime}</td>
													<td align="center" id="isPost_{$T.Result.sid}">
														{#if $T.Result.isPost == 0} 未推送
														 {#else} 已推送
														 {#/if}
													</td>
													
													<!-- <td align="center" id="">
														<a class="btn btn-default shiny" onclick="modify()">发货</a>&nbsp;&nbsp;&nbsp;&nbsp;
													</td> -->
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