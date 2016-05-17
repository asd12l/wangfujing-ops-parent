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
<style type="text/css">
.trClick>td,.trClick>th{
 color:red;
}
</style>
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
		
		/* $("#supplySid_select").change(stockQuery);
		$("#channelSid_select").change(stockQuery);
		$("#shopSid_select").change(stockQuery); */
		$("#pageSelect").change(stockQuery);
	});
	function stockQuery() {
		$("#messageid_from").val($("#messageid_input").val());
		$("#desturl_from").val($("#desturl_input").val());
		$("#serviceid_from").val($("#serviceid_input").val());
		$("#data_from").val($("#data_input").val());
		var params = $("#stock_form").serialize();
		//alert("表单序列化后请求参数:"+params);
		params = decodeURI(params);
		stockPagination.onLoad(params);
	}
	function find() {
		/* $("#supplySid_select").change(stockQuery);
		$("#channelSid_select").change(stockQuery);
		$("#shopSid_select").change(stockQuery);
		$("#productSku_input").change(stockQuery); 
		$("#productCode_input").change(stockQuery);  */
		stockQuery();
	}
	function reset() {
		$("#messageid_input").val("");
		$("#desturl_input").val("");
		$("#serviceid_input").val("");
		$("#data_input").val("");
		stockQuery();
	}
	function initStock() {
		var url = $("#ctxPath").val() + "/mq/queryMq";
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
							$("#loading-container").attr("class","loading-container");},
						 ajaxStop : function() {
								//隐藏加载提示
								setTimeout(function() {
									$("#loading-container").addClass("loading-inactive");
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
	function editStock() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text(buildErrorMessage("","只能选择一列！"));
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text(buildErrorMessage("","请选取要修改的列！"));
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		stockSid = value;
		saleStock_ = $("#saleStock_" + value).text().trim();
		productSku_ = $("#productSku_" + value).text().trim();
		proColorName_ = $("#proColorName_" + value).text().trim();
		proStanName_ = $("#proStanName_" + value).text().trim();
		proSum_ = $("#proSum_" + value).text().trim();
		stockName_ = $("#stockName_" + value).text().trim();
		brandName_ = $("#brandName_" + value).text().trim();
		supplyName_ = $("#supplyName_" + value).text().trim();
		shopName_ = $("#shopName_" + value).text().trim();
		productDetailSid_ = $("#productDetailSid_" + value).text().trim();
		var url = __ctxPath + "/jsp/StockSearch/editStockSearch.jsp";
		$("#pageBody").load(url);
	}
	function delStock() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			ZENG.msgbox.show(" 只能选择一列", 5, 2000);
			return false;
		} else if (checkboxArray.length == 0) {
			ZENG.msgbox.show("请选取要补充的列", 5, 2000);
			return false;
		}
		var value = checkboxArray[0];
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/stockSearch/deleteStockSearch",
					dataType : "json",
					data : {
						"sid" : value
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>删除成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
						} else {
							$("#warning2Body").text(buildErrorMessage("","删除失败！"));
							$("#warning2").show();
						}
						return;
					}
				});
	}
	//点击tr事件
	function trClick(sid,obj){
		$(obj).addClass("trClick").siblings().removeClass("trClick");
		var option = "";
		var spn_click =  $("#spn_"+sid);
		var data = $("#data_"+sid).text();
		
			option+=data;
		
		$("#OLV1_tab").html(option);
		
		$("#divTitle").html("查看");
		$("#btDiv").show();
	}
	function closeBtDiv(){
		$("#btDiv").hide();
	}
	/* function tab(data) {
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
	} */
	//折叠页面
	function tab(data){
		if($("#"+data+"-i").attr("class")=="fa fa-minus"){
			$("#"+data+"-i").attr("class","fa fa-plus");
			$("#"+data).css({"display":"none"});
		}else if(data=='pro'){
			$("#"+data+"-i").attr("class","fa fa-minus");
			$("#"+data).css({"display":"block"});
		}else{
			$("#"+data+"-i").attr("class","fa fa-minus");
			$("#"+data).css({"display":"block"});
			$("#"+data).parent().siblings().find(".widget-body").css({"display":"none"});
			$("#"+data).parent().siblings().find(".fa-minus").attr("class","fa fa-plus");
		}
	}
	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(__ctxPath + "/jsp/StockSearch/StockSearchView.jsp");
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
								<h5 class="widget-caption">MQ管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<!-- <div class="table-toolbar">
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="editStock();"
											class="btn btn-info" style="width: 100%;"> <i
											class="fa fa-wrench"></i> 修改库存信息 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="delStock();"
											class="btn btn-danger" style="width: 100%;"> <i
											class="fa fa-times"></i> 删除库存信息 </a>
									</div>
									<div class="col-md-8">
										
									</div>
								</div> -->
								<!-- <div class="table-toolbar">
									<a id="editabledatatable_new" onclick="editStock();"
										class="btn btn-primary"> <i class="fa fa-plus"></i> 修改库存信息 </a>&nbsp;&nbsp;
									<a id="editabledatatable_new" onclick="delStock();"
										class="btn btn-info"> <i class="fa fa-wrench"></i> 删除库存信息
									</a>
								</div> -->
								<div class="table-toolbar">
									<div class="clearfix">
										<span>消息编号：</span>
										<input type="text" id="messageid_input" style="width: 200px;"/>&nbsp;&nbsp;&nbsp;&nbsp;
										<span>消息目的地URL：</span>
										<input type="text" id="desturl_input" style="width: 200px;"/>&nbsp;&nbsp;&nbsp;&nbsp;
										<span>接口编码：</span>
										<input type="text" id="serviceid_input" style="width: 200px;"/><br><br>
										<span>消息内容：</span>
										<input type="text" id="data_input" style="width: 200px;"/>&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="reset();">重置</a>
									</div>
								
								
								</div>
								<div style="width:100%; height:0%; overflow-Y: hidden;">
								<!-- <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="stock_tab">
                                       <thead class="flip-content bordered-darkorange"> -->
                                        <table class="table-striped table-hover table-bordered" id="stock_tab" style="width: 400%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
										<tr role="row">
											<th style="text-align: center; width: 6.5%">消息编号</th>
											<th style="text-align: center; width: 5.5%">消息系统路径</th>
											<th style="text-align: center; width: 5.5%">消息目的地URL</th>
											<th style="text-align: center; width: 5.5%">回调路径</th>
											<th style="text-align: center; width: 5.5%">接口编码</th>
											<th style="text-align: center; width: 7.5%">消息内容</th>
											<th style="text-align: center; width: 7.5%">消息记录数</th>
											<th style="text-align: center; width: 7.5%">sourceSysID</th>
											<th style="text-align: center; width: 7.5%">创建时间</th>
											<th style="text-align: center; width: 7.5%">返回结果描述</th>
											<th style="text-align: center; width: 7.5%">返回编码编码</th>
											<th style="text-align: center; width: 7.5%">消息状态</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								</div>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="stock_form" action="">
										<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp; 
										 <input type="hidden" id="messageid_from" name="messageid" /> 
										 <input type="hidden" id="desturl_from" name="desturl" /> 
										 <input type="hidden" id="serviceid_from" name="serviceid" /> 
										 <input type="hidden" id="data_from" name="data" /> 
									</form>
								</div>
								<div id="stockPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="stock-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" onclick="trClick({$T.Result.sid},this)" style="height:35px;" >
													<td align="center" id="messageid_{$T.Result.sid}">{$T.Result.messageid}</td>
													<td align="center" id="url_{$T.Result.sid}">{$T.Result.url}</td>
													<td align="center" id="desturl_{$T.Result.sid}">{$T.Result.desturl}</td>
													<td align="center" id="callbackurl_{$T.Result.sid}">{$T.Result.callbackurl}</td>
													<td align="center" id="serviceid_{$T.Result.sid}">{$T.Result.serviceid}</td>
													<td align="center" style="display:none" id="data_{$T.Result.sid}">{JSON.stringify($T.Result.data)}</td>
													<td align="center" id="spn_{$T.Result.sid}"><span  class='btn btn-danger btn-xs'>请点击</span></td>
													<td align="center" id="count_{$T.Result.sid}">{$T.Result.count}</td>
													<td align="center" id="sourcesysid_{$T.Result.sid}">{$T.Result.sourcesysid}</td>
													<td align="center" id="createdateStr_{$T.Result.sid}">{$T.Result.createdateStr}</td>
													<td align="center"id="bizdesc_{$T.Result.sid}">{$T.Result.bizdesc}</td>
													<td align="center"id="bizcode_{$T.Result.sid}">{$T.Result.bizcode}</td>
									       			
									       			<td align="center" id="status_{$T.Result.sid}">
													{#if $T.Result.status == 0}
														<span class="label label-lightred graded">未确认</span>
													{#elseif $T.Result.status == 1}
														<span class="label label-success graded">确认</span>
													{#/if}
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
	<div class="modal modal-darkorange" id="btDiv">
        <div class="modal-dialog" style="width: 800px;height:80%;margin: 4% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv();">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
				                <!-- <div class="widget-body" id="pro1">
					                <div style="width:100%;height:225px;overflow-x: hidden;word-break:break-all;" id="OLV1_tab">
					                </div>
				                </div> -->
				                
				                <div class="widget">
			                     <div class="widget-header ">
			                         <h5 class="widget-caption">消息内容</h5>
			                         <div class="widget-buttons">
			                             <a href="#" data-toggle="maximize"></a>
			                             <a href="#" data-toggle="collapse" onclick="tab('pro1');">
			                                 <i class="fa fa-minus " id="pro1-i"></i>
			                             </a>
			                             <a href="#" data-toggle="dispose"></a>
			                         </div>
			                     </div>
				                 <div class="widget-body" id="pro1">
					                <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV1_tab" style="width: 650%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
				                </div>
			                </div>
                		</div>
                	</div>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv();" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    <script>
		jQuery(document).ready(
			function () {
				$('#divTitle').mousedown(
					function (event) {
						var isMove = true;
						var abs_x = event.pageX - $('#btDiv').offset().left;
						var abs_y = event.pageY - $('#btDiv').offset().top;
						$(document).mousemove(function (event) {
							if (isMove) {
								var obj = $('#btDiv');
								obj.css({'left':event.pageX - abs_x, 'top':event.pageY - abs_y});
								}
							}
						).mouseup(
							function () {
								isMove = false;
							}
						);
					}
				);
			}
		);
	</script>  
</body>
</html>