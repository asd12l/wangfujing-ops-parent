<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<script src="${ctx}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${ctx}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${ctx}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${ctx}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/js/pagination/myPagination/page.css"/>
<!--Bootstrap Date Range Picker-->
<script src="${ctx}/assets/js/datetime/moment.js"></script>
<script src="${ctx}/assets/js/datetime/daterangepicker.js"></script>
<style type="text/css">
.trClick>td,.trClick>th{
 color:red;
}
</style>
  <script type="text/javascript">
		__ctxPath = "${ctx}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var olvPagination;
	$(function() {
		/* $.ajax({url:__ctxPath + "/DataDictionary/getItemType?dictTypeCode="+51,dataType:"json",async:false,success:function(response){
    		var result = response.list;
           	 var option = "<option value=''>所有</option>";
           	 for(var i=0;i<result.length;i++){
           		 var ele = result[i];
           		 option+="<option value='"+ele.dictItemCode+"'>"+ele.dictItemName+"</option>";
           	 }
           	 $("#shopName_select").append(option);
 		}}); */
 		$('#reservation').daterangepicker({
 			timePicker: true,
			timePickerIncrement: 30,
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
	    initOlv();
	});
	function olvQuery(){
		$("#orderNo_form").val($("#orderNo_input").val());
		$("#exceptionType_from").val($("#exceptionType_input").val());
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startTime_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endTime_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startTime_form").val("");
			$("#endTime_form").val("");
		}
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#orderNo_input").val("");
		$("#exceptionType_input").val("");
		$("#reservation").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/omsOrder/selectPushErpOffLineException";
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
             /* ajaxStart: function() {
               ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
             },
             ajaxStop: function() {
               //隐藏加载提示
               setTimeout(function() {
                 ZENG.msgbox.hide();
               }, 300);
             }, */
             	ajaxStart : function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive");
					}, 300);
				},
             callback: function(data) {
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
    }
	
 	//点击tr事件
	function trClick(orderNo,dealFlag,obj){
//		$(obj).addClass("trClick").siblings().removeClass("trClick");
//		var option = "";
//		var spn_click =  $("#spn_"+sid).html("<span class='btn btn-palegreen btn-xs'>已点击</span>");
//		var parameters = $("#parameters_"+sid).text();
//		if(parameters=="[object Object]"||parameters==undefined){
//			/* option+="<tr style='height:35px;'><td align='center'></td></tr>"; */
//		}else{
//			//option+=parameters;
//		}
//		$("#OLV1_tab").html(option);
//		$("#divTitle").html("参数信息");
//		$("#btDiv").show();
		
		if(dealFlag !='1'){
			
			$.ajax({
				type:"post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url:__ctxPath + "/omsOrder/saleSendErp",
				async:false,
				dataType: "json",
				data:{"orderNo":orderNo},
				success:function(response) {
					if(response.success=='true'){
						initOlv();
					}
				}
			});	
		}
		
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
	
	/* //折叠页面
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
			}
		}
	} */
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/OrderListView.jsp");
	}
	</script> 
</head>
<body>
	<input type="hidden" id="ctxPath" value="${ctx}" />
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
                                    <span class="widget-caption"><h5>异常销售单管理(线下)</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                    	<ul class="topList clearfix">
										    <li class="col-md-4">
										            <label class="titname">异常出现时间：</label>
													<input type="text" id="reservation"/>
										        </li>
										        <li class="col-md-4">
										            <label class="titname">单据号：</label>
													<input type="text" id="orderNo_input"/>
										        </li>
										    <li class="col-md-4">
										    	<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
												<a class="btn btn-default shiny" onclick="reset();">重置</a>
											    	<!-- <a id="editabledatatable_new" onclick="olvQuery();" class="btn btn-yellow" style="width: 37%;">
			                                    		<i class="fa fa-eye"></i>
														查询
			                                        </a>
			                                        <a id="editabledatatable_new" onclick="reset();" class="btn btn-primary" style="width: 37%;">
			                                        	<i class="fa fa-random"></i>
														重置
			                                        </a> -->
										    </li>
										</ul>
                                    	
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="10"/>
											<input type="hidden" id="orderNo_form" name="orderNo"/>
											<input type="hidden" id="startTime_form" name="startTime"/>
											<input type="hidden" id="endTime_form" name="endTime"/>
                                      	</form>
                                      	<div style="width:100%; height:0%; min-height:300px; overflow:hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style="height:35px;">
                                                <th width="8%" style="text-align: center;">单据号</th>
                                                <th width="5%" style="text-align: center;">异常类型</th>
                                                <th width="6%" style="text-align: center;">异常接口</th>
                                                <!-- <th width="4%" style="text-align: center;">参数</th> -->
                                                <th width="6%" style="text-align: center;">返回异常信息</th>
                                                <th width="5%" style="text-align: center;">异常出现时间</th>
                                                <th width="4%" style="text-align: center;">操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    	</table>
                                    </div>
                                </div>
                                 <div id="olvPagination"></div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px;" >
													<td align="center" id="orderNo_{$T.Result.sid}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.orderNo}
							                   			{#/if}
						                   			</td>
													<td align="center" id="exceptionType_{$T.Result.sid}">
														{#if $T.Result.exceptionType != '[object Object]'}{$T.Result.exceptionType}
							                   			{#/if}
							                   		</td>
													<td align="center" id="exceptionInterface_{$T.Result.sid}">
														{#if $T.Result.exceptionInterface != '[object Object]'}{$T.Result.exceptionInterface}
							                   			{#/if}
							                   		</td>
													<td align="center" style="display: none;" id="parameters_{$T.Result.sid}">{JSON.stringify($T.Result.parameters)}</td>
													<td align="center" id="returnMessage_{$T.Result.sid}">{JSON.stringify($T.Result.returnMessage)}</td>
													<td align="center" id="createdTimeStr_{$T.Result.sid}">
														{#if $T.Result.createdTimeStr != '[object Object]'}{$T.Result.createdTimeStr}
							                   			{#/if}
							                   		</td>
							                   		<td align="center" onclick="trClick('{$T.Result.orderNo}','{$T.Result.dealFlag}',this)" id="dealFlag_{$T.Result.sid}">
														{#if $T.Result.dealFlag == '1'}
															<span  class='btn btn-palegreen btn-xs'>已处理</span>
						                      			{#else}
						                      				<span  class='btn btn-danger btn-xs'>请处理</span>
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
				                <div class="widget-body" id="pro1">
					                <div style="width:100%;height:225px;overflow-x: hidden;word-break:break-all;" id="OLV1_tab">
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