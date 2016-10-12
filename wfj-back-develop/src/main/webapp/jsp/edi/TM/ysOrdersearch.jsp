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

<%-- <jsp:include page="../TM/modifyorder.jsp" /> --%>

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
	var userName;
	var logJs;
	var memberInfo;
	
	$(function() { 
		$('#startDate_form').daterangepicker();
		initStock();
		$("#pageSelect").change(stockQuery);
	});
	function modify(tid){
		var url = __ctxPath + "/jsp/edi/TM/modifyorder.jsp?tid="+tid;
		$("#pageBody").load(url);
	}
	function olvQuery(){
		LA.env = 'dev';
		LA.sysCode = '44';
		var sessionId = '<%=request.getSession().getId()%>';
		LA.log('tm-ysSearch', '天猫预售搜索', userName, sessionId);
		$("#tid_form").val($("#tid_input").val());
		$("#ordersId_form").val($("#ordersId_input").val());
		$("#receiverName_form").val($("#receiverName_input").val());
		$("#title_form").val($("#goodName_input").val());
		$("#exceptionType_form").val($("#exceptionType_input").val());
        var params = $("#stock_form").serialize(); 
        params = decodeURI(params);
        stockPagination.onLoad(params);
	}
	
	//加入黑名单
	function addBL(tid){
		LA.env = 'dev';
		LA.sysCode = '44';
		var sessionId = '<%=request.getSession().getId()%>';
		LA.log('tm-addBL', '天猫预售加入黑名单', userName, sessionId);
       	 $.ajax({
       		on: true,
    			url : __ctxPath + "/ediOrder/blacklistAdd?tid="+tid+"&channelCode=C7",
    			dataType : "json",
    			success : function(data) {
		            reset();
				},
        	 	error:function(){ 
		            reset(); 
        	   	}
    	});
   	}
	
	function reset() {
		$("#tid_form").val("");
		$("#ordersId_form").val("");
		$("#receiverName_form").val("");
		$("#title_form").val("");
		$("#exceptionType_form").val("");
		
		$("#tid_input").val("");
		$("#ordersId_input").val("");
		$("#receiverName_input").val("");
		$("#goodName_input").val("");
		$("#exceptionType_input").val("");
		stockQuery();
	}
	function stockQuery() {
		var params = $("#stock_form").serialize();
		params = decodeURI(params);
		stockPagination.onLoad(params);
	}
	
	function plusXing (str,frontLen,endLen) { 
		var len = str.length-frontLen-endLen;
		var xing = '';
		for (var i=0;i<len;i++) {
		xing+='*';
		}
		if(memberInfo==1){
			return str.substring(0,frontLen)+xing+str.substring(str.length-endLen);
		}else{
			return str;
		}
		
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
		var url = __ctxPath+"/ediOrder/selectOrderList?ispreSale=YS&tradesource=C7";
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
							memberInfo=data.memberInfo;
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
								<h5 class="widget-caption">预售订单</h5>
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
										<li class="col-md-4"><label class="titname">订单编号：</label>
											<input type="text" id="tid_input" /></li>
										<li class="col-md-4"><label class="titname">EC订单编号：</label>
											<input type="text" id="ordersId_input" /></li>
										
										<li class="col-md-6"><a id="editabledatatable_new" 
											onclick="olvQuery();" class="btn btn-yellow"> <i
												class="fa fa-eye"></i> 查询
										</a>  <a id="editabledatatable_new" onclick="reset();"
											class="btn btn-primary"> <i class="fa fa-random"></i> 重置
										</a></li>
									</ul>
								</div>
								<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="stock_tab">
                                       <thead class="flip-content bordered-darkorange">
										<tr role="row">
													<th style="text-align: center;">订单编号</th>
													<!-- tid -->
													<th style="text-align: center;">王府井订单编号</th>
													<!--ordersid -->
													<th style="text-align: center;">收货人</th>
													<!--receiverName -->
													<th style="text-align: center;">购买人</th>
													<!-- buyerNick -->
													<th style="text-align: center;">联系方式</th>
													<!--receiverMobile  -->
													<th style="text-align: center;">金额</th>
													<!-- payment -->
													<th style="text-align: center;">状态</th>
													<th style="text-align: center;">下单时间</th>
													<th style="text-align: center;">操作</th>
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
											<input type="hidden" id="ordersId_form" name="ordersId" /> 
											<input type="hidden" id="receiverName_form" name="receiverName" /> 
											<input type="hidden" id="title_form" name="goodName" /> 
											<input type="hidden" id="exceptionType_form" name="exceptionType" /> 
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
													<td align="center" id="skuCode_{$T.Result.sid}">{$T.Result.tid}</td>
													<td align="center" >
													   {#if $T.Result.ordersid == "" || $T.Result.ordersid == null} ---
													   {#else} {$T.Result.ordersid}
													   {#/if}													
													</td>
													<td align="center" id="productCode_{$T.Result.sid}">{plusXing($T.Result.receiverName,1,0)}</td>
													<td align="center" id="unitName_{$T.Result.sid}">{$T.Result.buyerNick}</td>
													<td align="center" id="saleStock_{$T.Result.receiverMobile}">{plusXing($T.Result.receiverMobile,3,4)}</td>
													<td align="center" id="edefectiveStock_{$T.Result.payment}">{$T.Result.payment}</td>
													<td align="center" id="returnStock_{$T.Result.tradeStatus}">{$T.Result.tradeStatus}</td>
													<td align="center" id="lockedStock_{$T.Result.updateDate}">{$T.Result.updateDate}</td>
									       		    <td align="center">
														<a class="btn btn-default shiny" onclick="addBL('{$T.Result.tid}')">拉黑</a>
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