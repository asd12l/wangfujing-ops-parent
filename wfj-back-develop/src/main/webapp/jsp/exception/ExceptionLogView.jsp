<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<!--Jquery Select2-->
<script
	src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<!--Bootstrap Date Range Picker-->
<script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
<style type="text/css">
.trClick>td,.trClick>th{
 color:red;
}
</style>
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

	var stockPagination;
	$(function() { 
		$('#reservation').daterangepicker({
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
	function stockQuery() {
		$("#uuid_from").val($("#uuid_input").val());
		$("#shopSid_from").val($("#shopSid_select").val());
		
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startTime_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endTime_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startTime_form").val("");
			$("#endTime_form").val("");
		}
		
		var params = $("#stock_form").serialize();
		params = decodeURI(params);
		stockPagination.onLoad(params);
	}
	function find() {
		stockQuery();
	}
	function reset() {
		$("#uuid_input").val("");
		$("#productCode_input").val("");
		$("#supplySid_select").val("").trigger("change");
		$("#channelSid_select").val("").trigger("change");
		$("#shopSid_select").val("").trigger("change");
		$("#reservation").val("");
		stockQuery();
	}
	function initStock() {
		var url = $("#ctxPath").val() + "/exceptionLog/queryExceptionLog";
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
		var errorMessage = $("#errorMessage_"+sid).text();
		if(errorMessage=="[object Object]"||errorMessage==undefined){
		}else{
			option+=errorMessage;
		}
		$("#OLV1_tab").html(option);
		
		var option = "";
		var dataContent = $("#dataContent_"+sid).text();
		if(dataContent=="[object Object]"||dataContent==undefined){
		}else{
			option+=dataContent;
		}
		$("#OLV2_tab").html(option);
		$("#divTitle").html("查看");
		$("#btDiv").show();
	}
	function closeBtDiv(){
		$("#btDiv").hide();
	}
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
								<h5 class="widget-caption">异常管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">

								<div class="table-toolbar">
									<div class="clearfix">
										<span>时间：</span>
										<input type="text" id="reservation"  style="width: 200px;"/>&nbsp;&nbsp;&nbsp;&nbsp;
										<span>uuid：</span>
										<input type="text" id="uuid_input" style="width: 200px;"/>&nbsp;&nbsp;&nbsp;&nbsp;
										<span>异常类型：</span>
										<select id="shopSid_select" style="padding: 0 0;width: 200px;">
											<option value="">所有</option>
											<option value="1001">商品</option>
											<option value="1002">品牌</option>
											<option value="1003">品类 </option>
											<option value="1004">供应商</option>
											<option value="1005">价格</option>
											<option value="1006">库存</option>
											<option value="1007">合同</option>
											<option value="1008">组织机构</option>
										</select>&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="reset();">重置</a>
									</div>								
								</div>
								<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="stock_tab">
                                       <thead class="flip-content bordered-darkorange">
										<tr role="row">
											<th style="text-align: center;">uuid</th>
											<th style="text-align: center;">接口名称</th>
											<th style="text-align: center;">异常类型</th>
											<th style="text-align: center;">参数信息</th>
											<!-- <th style="text-align: center;">数据内容</th> -->
											<th style="text-align: center;">处理人</th>
											<th style="text-align: center;">处理状态</th>
											<th style="text-align: center;">创建时间</th>
											<th style="text-align: center;">修改时间</th>
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
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp; 
										 <input type="hidden" id="uuid_from" name="uuid" /> 
										<input type="hidden" id="startTime_form" name="startTimeStr"/>
										<input type="hidden" id="endTime_form" name="endTimeStr"/>
										 <input type="hidden" id="shopSid_from" name="exceptionType" />
										 
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
													<td align="center" id="uuid_{$T.Result.sid}">
													{#if $T.Result.uuid != '[object Object]'}
														{$T.Result.uuid}
													{#/if}
													</td>
													<td align="center" id="interfaceName_{$T.Result.sid}">{$T.Result.interfaceName}</td>
													
													<td align="center" id="exceptionType_{$T.Result.sid}">
														{#if $T.Result.exceptionType == "1001"}
															<span>商品</span>
														{#elseif $T.Result.exceptionType == "1002"}
															<span>品牌</span>
														{#elseif $T.Result.exceptionType == "1003"}
															<span>品类</span>
														{#elseif $T.Result.exceptionType == "1004"}
															<span>供应商</span>
														{#elseif $T.Result.exceptionType == "1005"}
															<span>价格</span>
														{#elseif $T.Result.exceptionType == "1006"}
															<span>库存</span>
														{#elseif $T.Result.exceptionType == "1007"}
															<span>合同</span>
														{#elseif $T.Result.exceptionType == "1008"}
															<span>组织机构</span>
														{#/if}
													</td>
													<td align="center" id="spn_{$T.Result.sid}"><span  class='btn btn-danger btn-xs'>请点击</span></td>
													<td align="center" style="display:none" id="errorMessage_{$T.Result.sid}">{JSON.stringify($T.Result.errorMessage)}</td>
													<td align="center" style="display:none" id="dataContent_{$T.Result.sid}">{JSON.stringify($T.Result.dataContent)}</td>
													<td align="center" id="resolveby_{$T.Result.sid}">
													{#if $T.Result.resolveby != '[object Object]'}
														{$T.Result.resolveby}
													{#/if}
													</td>
													
													<td align="center" id="processStatus_{$T.Result.sid}">
													{#if $T.Result.processStatus == 0}
														<span class="label label-lightred graded">未处理</span>
													{#elseif $T.Result.processStatus == 1}
														<span class="label label-lightyellow graded">处理中</span>
													{#elseif $T.Result.processStatus == 2}
														<span class="label label-success graded">已处理</span>
													{#/if}
													</td>
													
													<td align="center" id="createTimeStr_{$T.Result.sid}">
													{#if $T.Result.createTimeStr != '[object Object]'}
														{$T.Result.createTimeStr}
													{#/if}
													</td>
													<td align="center" id="updateTimeStr_{$T.Result.sid}">
													{#if $T.Result.updateTimeStr != '[object Object]'}
														{$T.Result.updateTimeStr}
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
	<!-- /Page Container -->
	<!-- Main Container -->
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
			                         <h5 class="widget-caption">错误信息</h5>
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
				                
				                <div class="widget">
			                     <div class="widget-header ">
			                         <h5 class="widget-caption">数据内容</h5>
			                         <div class="widget-buttons">
			                             <a href="#" data-toggle="maximize"></a>
			                             <a href="#" data-toggle="collapse" onclick="tab('pro2');">
			                                 <i class="fa fa-plus " id="pro2-i"></i>
			                             </a>
			                             <a href="#" data-toggle="dispose"></a>
			                         </div>
			                     </div>
				                <div class="widget-body" id="pro2" style="display: none;">
					                <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 650%;background-color: #fff;margin-bottom: 0;">
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