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
	var olvPaginationPayList;
	var olvPaginationPayList3;
	var hiddenParam;
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
		$("#shopNo_form").val($("#shopNo_input").val());
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startFlowTime_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endFlowTime_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startFlowTime_form").val("");
			$("#endFlowTime_form").val("");
		}
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        hiddenParam = params;
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#shopNo_input").val("");
		$("#reservation").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/oms/checkAccountsList.htm";
		olvPagination = $("#olvPagination").myPagination({
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
           		$("#olv1_tab tbody").setTemplateElement("olv1-list").processTemplate(data);
             }
           }
         });
    }
	
	function payList(){
		var url = __ctxPath+"/oms/selectAllPosFlowList";
		var params = $("#olv_form").serialize();
        params = decodeURI(params);
        hiddenParam = params;
		olvPaginationPayList = $("#olvPagination2").myPagination({
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
              param:hiddenParam,
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
            	 $("#olv2_tab tbody").setTemplateElement("olv2-list").processTemplate(data);
             }
           }
         });
		$("#divTitle").html("款机流水详情");
		$("#btDiv").show();
		
	}
	
	function payList3(paymentType,obj){
		$(obj).addClass("trClick").siblings().removeClass("trClick");
		$("#paymentType").val(paymentType);
		var params = $("#olv_form").serialize();
        params = decodeURI(params);
        hiddenParam = params;
		var url = __ctxPath+"/oms/selectAllPosFlowPayments";
		olvPaginationPayList3 = $("#olvPagination3").myPagination({
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
              param:hiddenParam,
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
            	 $("#olv3_tab tbody").setTemplateElement("olv3-list").processTemplate(data);
             }
           }
         });
		$("#divTitle3").html("款机流水详情");
		$("#btDiv3").show();
		
	}
	
	function closeBtDiv(obj){
		$("#"+obj).hide();
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
                                    <h5 class="widget-caption">退款对账管理</h5>
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
										        <label class="titname">退款时间：</label>
										        <input type="text" id="reservation"  />
										    </li>
										    <li class="col-md-4">
										        <label class="titname">门店号：</label>
										        <input type="text" id="shopNo_input" />
										    </li>
										    <li class="col-md-4">
										    	<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
												<a class="btn btn-default shiny" onclick="reset();">重置</a>
										       <!--  <a id="editabledatatable_new" onclick="olvQuery();" class="btn btn-yellow" style="width: 37%;">
										            <i class="fa fa-eye"></i>
										            查询
										        </a>&nbsp;&nbsp;
										        <a id="editabledatatable_new" onclick="reset();" class="btn btn-primary" style="width: 37%;">
										            <i class="fa fa-random"></i>
										            重置
										        </a> -->
										    </li>
										</ul>
                               			<form id="olv_form" action="">
											<input type="hidden" id="isRefund" name="isRefund" value="1"/>
											<input type="hidden" id="flowStatus" name="flowStatus" value="1"/>
											<input type="hidden" id="paymentType" name="paymentType"/>
											<input type="hidden" id="shopNo_form" name="shopNo"/>
											<input type="hidden" id="startFlowTime_form" name="startFlowTime"/>
											<input type="hidden" id="endFlowTime_form" name="endFlowTime"/>
                                      	</form>
                                    <div style="width:100%; height:0%; overflow-Y: hidden;">
	                                    <table class="table-striped table-hover table-bordered" id="olv1_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
	                                        <thead>
	                                            <tr role="row" style='height:35px;'>
	                                                <th width="5%" style="text-align: center;">总金额</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        </tbody>
	                                    </table>
                                    </div>
                                    <div style="width:100%; height:0%; overflow-Y: hidden;">
	                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
	                                        <thead>
	                                            <tr role="row" style='height:35px;'>
	                                                <th width="5%" style="text-align: center;">一级介质</th>
	                                                <th width="5%" style="text-align: center;">二级介质</th>
	                                                <th width="5%" style="text-align: center;">金额</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        </tbody>
	                                    </table>
                                    </div>
                                	
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv1-list" rows="0" cols="0">
										<!--
										{#template MAIN}
												<tr class="gradeX" id="gradeX{$T.totalPaymentAmount}" onclick="payList()" style="height:35px;">
													<td align="center" id="totalPaymentAmount">
														{#if $T.totalPaymentAmount != '[object Object]'}{$T.totalPaymentAmount}
						                   				{#/if}
													</td>
									       		</tr>
									    {#/template MAIN}	-->
									</textarea>
									<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" onclick="payList3('{$T.Result.paymentType}',this)" style="height:35px;">
													<td align="center" id="paymentClass_{$T.Result.sid}">
														{#if $T.Result.paymentClass != '[object Object]'}{$T.Result.paymentClass}
						                   				{#/if}
													</td>
													<td align="center" id="paymentType_{$T.Result.sid}">
														{#if $T.Result.paymentType != '[object Object]'}{$T.Result.paymentType}
						                   				{#/if}
													</td>
													<td align="center" id="amount_{$T.Result.sid}">
														{#if $T.Result.amount != '[object Object]'}{$T.Result.amount}
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
    <div class="modal modal-darkorange" id="btDiv3">
        <div class="modal-dialog" style="width: 800px;height:80%;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv('btDiv3');">×</button>
                    <h4 class="modal-title" id="divTitle3"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
			                <div class="widget">
			                     <div class="widget-header ">
			                         <h5 class="widget-caption">支付介质详情信息</h5>
			                         <div class="widget-buttons">
			                             <a href="#" data-toggle="maximize"></a>
			                             <a href="#" data-toggle="collapse" onclick="tab('pro3');">
			                                 <i class="fa fa-minus " id="pro3-i"></i>
			                             </a>
			                             <a href="#" data-toggle="dispose"></a>
			                         </div>
			                     </div>
				                <!-- <div class="widget-body" id="pro2">
					                <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV3_tab" style="width: 650%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
				                </div> -->
				                
				                 <div style="width:100%; height:0%; overflow-Y: hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv3_tab" style="width: 400%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                            	<th width="5%" style="text-align: center;">款机流水号</th>
												<th width="3%" style="text-align: center;">一级支付介质</th>
												<th width="3%" style="text-align: center;">二级支付介质</th>
												<th width="3%" style="text-align: center;">支付金额</th>
												<th width="3%" style="text-align: center;">实际抵扣金额</th>
												<th width="3%" style="text-align: center;">汇率</th>
												<th width="4%" style="text-align: center;">支付账号</th>
												<th width="4%" style="text-align: center;">会员id</th>
												<th width="3%" style="text-align: center;">支付流水号</th>
												<th width="3%" style="text-align: center;">优惠券类型</th>
												<th width="3%" style="text-align: center;">优惠券批次</th>
												<th width="3%" style="text-align: center;">券模板名称</th>
												<th width="3%" style="text-align: center;">活动号</th>
												<th width="3%" style="text-align: center;">收券规则</th>
												<th width="3%" style="text-align: center;">收券规则描述</th>
												<th width="3%" style="text-align: center;">结余</th>
												<th width="3%" style="text-align: center;">备注</th>
											</tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    </div>
			                      <div id="olvPagination3"></div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv3-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px;">
													<td align="center" id="posFlowNo_{$T.Result.sid}">
														{#if $T.Result.posFlowNo != '[object Object]'}{$T.Result.posFlowNo}
						                   				{#/if}
													</td>
													<td align="center" id="paymentClass_{$T.Result.sid}">
														{#if $T.Result.paymentClass != '[object Object]'}{$T.Result.paymentClass}
						                   				{#/if}
													</td>
													<td align="center" id="paymentType_{$T.Result.sid}">
														{#if $T.Result.paymentType != '[object Object]'}{$T.Result.paymentType}
						                   				{#/if}
													</td>
													<td align="center" id="amount_{$T.Result.sid}">
														{#if $T.Result.amount != '[object Object]'}{$T.Result.amount}
						                   				{#/if}
													</td>
													<td align="center" id="acturalAmount_{$T.Result.sid}">
														{#if $T.Result.acturalAmount != '[object Object]'}{$T.Result.acturalAmount}
						                   				{#/if}
													</td>
													<td align="center" id="rate_{$T.Result.sid}">
														{#if $T.Result.rate != '[object Object]'}{$T.Result.rate}
						                   				{#/if}
													</td>
													<td align="center" id="account_{$T.Result.sid}">
														{#if $T.Result.account != '[object Object]'}{$T.Result.account}
						                   				{#/if}
													</td>
													<td align="center" id="userId_{$T.Result.sid}">
														{#if $T.Result.userId != '[object Object]'}{$T.Result.userId}
						                   				{#/if}
													</td>
													<td align="center" id="payFlowNo_{$T.Result.sid}">
														{#if $T.Result.payFlowNo != '[object Object]'}{$T.Result.payFlowNo}
						                   				{#/if}
													</td>
													<td align="center" id="couponType_{$T.Result.sid}">
														{#if $T.Result.couponType != '[object Object]'}{$T.Result.couponType}
						                   				{#/if}
													</td>
													<td align="center" id="couponBatch_{$T.Result.sid}">
														{#if $T.Result.couponBatch != '[object Object]'}{$T.Result.couponBatch}
						                   				{#/if}
													</td>
													<td align="center" id="couponName_{$T.Result.sid}">
														{#if $T.Result.couponName != '[object Object]'}{$T.Result.couponName}
						                   				{#/if}
													</td>
													<td align="center" id="activityNo_{$T.Result.sid}">
														{#if $T.Result.activityNo != '[object Object]'}{$T.Result.activityNo}
						                   				{#/if}
													</td>
													<td align="center" id="couponRule_{$T.Result.sid}">
														{#if $T.Result.couponRule != '[object Object]'}{$T.Result.couponRule}
						                   				{#/if}
													</td>
													<td align="center" id="couponRuleName_{$T.Result.sid}">
														{#if $T.Result.couponRuleName != '[object Object]'}{$T.Result.couponRuleName}
						                   				{#/if}
													</td>
													<td align="center" id="cashBalance_{$T.Result.sid}">
														{#if $T.Result.cashBalance != '[object Object]'}{$T.Result.cashBalance}
						                   				{#/if}
													</td>
													<td align="center" id="remark_{$T.Result.sid}">
														{#if $T.Result.remark != '[object Object]'}{$T.Result.remark}
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
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv('btDiv3');" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
     <div class="modal modal-darkorange" id="btDiv">
        <div class="modal-dialog" style="width: 800px;height:80%;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv('btDiv');">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
			                <div class="widget">
			                     <div class="widget-header ">
			                         <h5 class="widget-caption">支付信息</h5>
			                         <div class="widget-buttons">
			                             <a href="#" data-toggle="maximize"></a>
			                             <a href="#" data-toggle="collapse" onclick="tab('pro');">
			                                 <i class="fa fa-minus " id="pro2-i"></i>
			                             </a>
			                             <a href="#" data-toggle="dispose"></a>
			                         </div>
			                     </div>
			                 	
			                 	
                                    <div style="width:100%; min-height:300px; height:0%; overflow-Y: hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv2_tab" style="width: 400%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                <th width="4%" style="text-align: center;">款机流水号</th>
                                                <th width="3%" style="text-align: center;">总金额</th>
                                                <th width="3%" style="text-align: center;">交易流水号</th>
                                                <th width="3%" style="text-align: center;">机器号</th>
                                                <th width="3%" style="text-align: center;">线上线下标识</th>
                                                <th width="3%" style="text-align: center;">支付时间</th>
                                                <th width="3%" style="text-align: center;">总折扣</th>
                                                <th width="3%" style="text-align: center;">总应收</th>
                                                <th width="3%" style="text-align: center;">实际支付</th>
                                                <th width="3%" style="text-align: center;">找零</th>
                                                <th width="3%" style="text-align: center;">折扣额</th>
                                                <th width="3%" style="text-align: center;">折让额</th>
                                                <th width="3%" style="text-align: center;">会员总折扣</th>
												<th width="3%" style="text-align: center;">优惠折扣额</th>
												<th width="3%" style="text-align: center;">收银损益</th>
												<th width="3%" style="text-align: center;">收银员号</th>
												<th width="3%" style="text-align: center;">班次</th>
												<th width="3%" style="text-align: center;">渠道标志</th>
												<th width="3%" style="text-align: center;">金卡</th>
												<th width="3%" style="text-align: center;">微信卡门店号</th>
												<th width="3%" style="text-align: center;">会员卡号</th>
												<th width="3%" style="text-align: center;">订单号</th>
												<th width="3%" style="text-align: center;">授权卡号</th>
												<th width="3%" style="text-align: center;">人民币</th>
												<th width="3%" style="text-align: center;">电子返券</th>
												<th width="3%" style="text-align: center;">电子扣回</th>
												<th width="3%" style="text-align: center;">银行手续费</th>
												<th width="3%" style="text-align: center;">来源</th>
												<th width="3%" style="text-align: center;">门店号</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    </div>
			                      <div id="olvPagination2"></div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv2-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.salesPaymentNo}" style="height:35px;">
													<td align="center" id="salesPaymentNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.salesPaymentNo != '[object Object]'}{$T.Result.salesPaymentNo}
						                   				{#/if}
													</td>
													<td align="center" id="money_{$T.Result.salesPaymentNo}">
														{#if $T.Result.money != '[object Object]'}{$T.Result.money}
						                   				{#/if}
													</td>
													<td align="center" id="payFlowNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.payFlowNo != '[object Object]'}{$T.Result.payFlowNo}
						                   				{#/if}
													</td>
													<td align="center" id="posNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.posNo != '[object Object]'}{$T.Result.posNo}
						                   				{#/if}
													</td>
													<td align="center" id="ooFlag_{$T.Result.salesPaymentNo}">
														{#if $T.Result.ooFlag == '1'}
															<span>线上</span>
						                      			{#elseif $T.Result.ooFlag == '2'}
						                      				<span>线下</span>
						                   				{#/if}
													</td>
													<td align="center" id="payTimeStr_{$T.Result.salesPaymentNo}">
														{#if $T.Result.payTimeStr != '[object Object]'}{$T.Result.payTimeStr}
						                   				{#/if}
													</td>
													<td align="center" id="totalDiscountAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.totalDiscountAmount != '[object Object]'}{$T.Result.totalDiscountAmount}%
						                   				{#/if}
													</td>
													<td align="center" id="paymentAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.paymentAmount != '[object Object]'}{$T.Result.paymentAmount}
						                   				{#/if}
													</td>
													<td align="center" id="actualPaymentAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.actualPaymentAmount != '[object Object]'}{$T.Result.actualPaymentAmount}
						                   				{#/if}
													</td>
													<td align="center" id="changeAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.changeAmount != '[object Object]'}{$T.Result.changeAmount}
						                   				{#/if}
													</td>
													<td align="center" id="tempDiscountAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.tempDiscountAmount != '[object Object]'}{$T.Result.tempDiscountAmount}
						                   				{#/if}
													</td>
													<td align="center" id="zrAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.zrAmount != '[object Object]'}{$T.Result.zrAmount}
						                   				{#/if}
													</td>
													<td align="center" id="memberDiscountAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.memberDiscountAmount != '[object Object]'}{$T.Result.memberDiscountAmount}
						                   				{#/if}
													</td>
													<td align="center" id="promDiscountAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.promDiscountAmount != '[object Object]'}{$T.Result.promDiscountAmount}
						                   				{#/if}
													</td>
													<td align="center" id="income_{$T.Result.salesPaymentNo}">
														{#if $T.Result.income != '[object Object]'}{$T.Result.income}
						                   				{#/if}
													</td>
													<td align="center" id="casher_{$T.Result.salesPaymentNo}">
														{#if $T.Result.casher != '[object Object]'}{$T.Result.casher}
						                   				{#/if}
													</td>
													<td align="center" id="shifts_{$T.Result.salesPaymentNo}">
														{#if $T.Result.shifts != '[object Object]'}{$T.Result.shifts}
						                   				{#/if}
													</td>
													<td align="center" id="channel_{$T.Result.salesPaymentNo}">
														{#if $T.Result.channel != '[object Object]'}{$T.Result.channel}
						                   				{#/if}
													</td>
													<td align="center" id="weixinCard_{$T.Result.salesPaymentNo}">
														{#if $T.Result.weixinCard != '[object Object]'}{$T.Result.weixinCard}
						                   				{#/if}
													</td>
													<td align="center" id="weixinStoreNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.weixinStoreNo != '[object Object]'}{$T.Result.weixinStoreNo}
						                   				{#/if}
													</td>
													<td align="center" id="memberNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.memberNo != '[object Object]'}{$T.Result.memberNo}
						                   				{#/if}
													</td>
													<td align="center" id="orderNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.orderNo}
						                   				{#/if}
													</td>
													<td align="center" id="authorizationNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.authorizationNo != '[object Object]'}{$T.Result.authorizationNo}
						                   				{#/if}
													</td>
													<td align="center" id="rmb_{$T.Result.salesPaymentNo}">
														{#if $T.Result.rmb != '[object Object]'}{$T.Result.rmb}
						                   				{#/if}
													</td>
													<td align="center" id="elecGet_{$T.Result.salesPaymentNo}">
														{#if $T.Result.elecGet != '[object Object]'}{$T.Result.elecGet}
						                   				{#/if}
													</td>
													<td align="center" id="elecDeducation_{$T.Result.salesPaymentNo}">
														{#if $T.Result.elecDeducation != '[object Object]'}{$T.Result.elecDeducation}
						                   				{#/if}
													</td>
													<td align="center" id="bankServiceCharge_{$T.Result.salesPaymentNo}">
														{#if $T.Result.bankServiceCharge != '[object Object]'}{$T.Result.bankServiceCharge}
						                   				{#/if}
													</td>
													<td align="center" id="sourceType_{$T.Result.salesPaymentNo}">
														{#if $T.Result.sourceType != '[object Object]'}{$T.Result.sourceType}
						                   				{#/if}
													</td>
													<td align="center" id="shopNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.elecGet != '[object Object]'}{$T.Result.shopNo}
						                   				{#/if}
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
								</p>
			                      
			                     <!--  
				                <div class="widget-body" id="pro3">
					                <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 650%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
				                </div>
				                -->
			                </div>
                		</div>
                	</div>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv('btDiv');" type="button">关闭</button>
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
	<script>
		jQuery(document).ready(
			function () {
				$('#divTitle3').mousedown(
					function (event) {
						var isMove = true;
						var abs_x = event.pageX - $('#btDiv3').offset().left;
						var abs_y = event.pageY - $('#btDiv3').offset().top;
						$(document).mousemove(function (event) {
							if (isMove) {
								var obj = $('#btDiv3');
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