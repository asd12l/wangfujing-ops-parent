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
	var hiddenParam;
	$(function() {
	    initOlv();
	});
	function olvQuery(){
		$("#salesPaymentNo_form").val($("#salesPaymentNo_input").val());
		$("#shopNo_form").val($("#shopNo_input").val());
		$("#memberNo_form").val($("#memberNo_input").val());
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#salesPaymentNo_input").val("");
		$("#shopNo_input").val("");
		$("#memberNo_input").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/testOms/selectPosFlowPage";
		var params = $("#olv_form").serialize();
        params = decodeURI(params);
        hiddenParam = params;
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
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
    }
	
	//点击tr事件
	function trClick(salesPaymentNo,obj){
		var newTr =  $(obj).clone(true);
		newTr.removeAttr("onclick");
		$("#mainTr").html(newTr);
		$(obj).addClass("trClick").siblings().removeClass("trClick");
		var option = "<tr role='row' style='height:35px;'>"+
		"<th width='5%' style='text-align: center;'>收银流水号</th>"+
		"<th width='6%' style='text-align: center;'>销售单号</th>"+
		"<th width='6%' style='text-align: center;'>订单号</th>"+
		"<th width='6%' style='text-align: center;'>账号</th>"+
		"<th width='5%' style='text-align: center;'>会员卡号</th>"+
		"<th width='4%' style='text-align: center;'>销售单状态</th>"+
		"<th width='4%' style='text-align: center;'>销售类别</th>"+
		"<th width='4%' style='text-align: center;'>销售单来源</th>"+
		"<th width='4%' style='text-align: center;'>支付状态</th>"+
		"<th width='4%' style='text-align: center;'>门店名称</th>"+
		"<th width='4%' style='text-align: center;'>供应商名称</th>"+
		"<th width='4%' style='text-align: center;'>专柜名称</th>"+
		"<th width='4%' style='text-align: center;'>销售类型</th>"+
		"<th width='4%' style='text-align: center;'>总金额</th>"+
		"<th width='4%' style='text-align: center;'>应付金额</th>"+
		"<th width='4%' style='text-align: center;'>优惠金额</th>"+
		"<th width='4%' style='text-align: center;'>收银损益</th>"+
		"<th width='4%' style='text-align: center;'>授权卡号</th>"+
		"<th width='4%' style='text-align: center;'>二维码</th>"+
		"<th width='4%' style='text-align: center;'>导购号</th>"+
		"<th width='4%' style='text-align: center;'>机器号</th>"+
		"<th width='6%' style='text-align: center;'>销售时间</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/testOms/selectSaleInfoList",
			async:false,
			dataType: "json",
			data:{"salesPaymentNo":salesPaymentNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						//收银流水号
						if(ele.salesPaymentNo=="[object Object]"||ele.salesPaymentNo==undefined){
							option+="<tr style='height:35px;'><td align='center'></td>";
						}else{
							option+="<tr style='height:35px;'><td align='center'>"+ele.salesPaymentNo+"</td>";
						}
						//销售单号
						if(ele.saleNo=="[object Object]"||ele.saleNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleNo+"</td>";
						}
						//订单号
						if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.orderNo+"</td>";
						}
						//账号
						if(ele.accountNo=="[object Object]"||ele.accountNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.accountNo+"</td>";
						}
						//会员卡号
						if(ele.memberNo=="[object Object]"||ele.memberNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.memberNo+"</td>";
						}
						//销售单状态
						if(ele.saleStatus=="2001"){
							option+="<td align='center'>草稿</td>";
						}else if(ele.saleStatus=="2002"){
							option+="<td align='center'>已打印销售单</td>";
						}else if(ele.saleStatus=="2003"){
							option+="<td align='center'>物流已提货</td>";
						}else if(ele.saleStatus=="2004"){
							option+="<td align='center'>顾客已提货</td>";
						}else if(ele.saleStatus=="2005"){
							option+="<td align='center'>导购确认缺货</td>";
						}else if(ele.saleStatus=="2010"){
							option+="<td align='center'>调入物流室</td>";
						}else if(ele.saleStatus=="2011"){
							option+="<td align='center'>调出物流室</td>";
						}else if(ele.saleStatus=="2012"){
							option+="<td align='center'>调入集货仓</td>";
						}else if(ele.saleStatus=="2013"){
							option+="<td align='center'>部分退货</td>";
						}else if(ele.saleStatus=="2014"){
							option+="<td align='center'>全部退货</td>";
						}else if(ele.saleStatus=="2098"){
							option+="<td align='center'>取消中</td>";
						}else if(ele.saleStatus=="2099"){
							option+="<td align='center'>已取消</td>";
						}else{
							option+="<td align='center'></td>";
						}
						//销售类别
						if(ele.saleType=="1"){
							option+="<td align='center'>正常销售单</td>";
						}else if(ele.saleType=="2"){
							option+="<td align='center'><span class='btn btn-xs'>大码销售单</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						//销售单来源
						if(ele.saleSource=="1"){
							option+="<td align='center'><span>线上</span></td>";
						}else if(ele.saleSource=="2"){
							option+="<td align='center'><span>线下</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						//支付状态
						if(ele.payStatus=="5001"){
							option+="<td align='center'><span>未支付</span></td>";
						}else if(ele.payStatus=="5002"){
							option+="<td align='center'><span>部分支付</span></td>";
						}else if(ele.payStatus=="5003"){
							option+="<td align='center'><span>超时未支付</span></td>";
						}else if(ele.payStatus=="5004"){
							option+="<td align='center'><span>已支付</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						//门店名称
						if(ele.storeName=="[object Object]"||ele.storeName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.storeName+"</td>";
						}
						//供应商名称
						if(ele.suppllyName=="[object Object]"||ele.suppllyName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.suppllyName+"</td>";
						}
						//专柜名称
						if(ele.shoppeName=="[object Object]"||ele.shoppeName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.shoppeName+"</td>";
						}
						//销售类型
						if(ele.saleClass=="1"){
							option+="<td align='center'>销售单</td>";
						}else if(ele.saleClass=="2"){
							option+="<td align='center'><span class='btn btn-xs'>换货换出单</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						//总金额
						if(ele.saleAmount=="[object Object]"||ele.saleAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleAmount+"</td>";
						}
						//应付金额
						if(ele.paymentAmount=="[object Object]"||ele.paymentAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.paymentAmount+"</td>";
						}
						//优惠金额
						if(ele.discountAmount=="[object Object]"||ele.discountAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.discountAmount+"</td>";
						}
						//收银损益
						if(ele.cashIncome=="[object Object]"||ele.cashIncome==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.cashIncome+"</td>";
						}
						//授权卡号
						if(ele.authorityCard=="[object Object]"||ele.cashIncome==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.authorityCard+"</td>";
						}
						//二维码
						if(ele.qrcode=="[object Object]"||ele.qrcode==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.qrcode+"</td>";
						}
						//导购号
						if(ele.employeeNo=="[object Object]"||ele.employeeNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.employeeNo+"</td>";
						}
						//机器号
						if(ele.casherNo=="[object Object]"||ele.casherNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.casherNo+"</td>";
						}
						//销售时间
						if(ele.saleTimeStr== "[object Object]"||ele.saleTimeStr==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleTimeStr+"</td>";
						}
					}
				}
			}
		});
		$("#OLV1_tab").html(option);
		$("#divTitle").html("对应销售单");
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
                                    <h5 class="widget-caption">未支付信息管理（前置）</h5>
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
										        <label class="titname">小票号：</label>
										        <input type="text" id="salesPaymentNo_input" />
										    </li>
										    <li class="col-md-4">
										        <label class="titname">会员号：</label>
										        <input type="text" id="memberNo_input" />
										    </li>
										    <li class="col-md-4">
										        <label class="titname">门&nbsp;&nbsp;&nbsp;  店：</label>
										        <input type="text" id="shopNo_input" />
										    </li>
										    <li class="col-md-4">
										    	<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
												<a class="btn btn-default shiny" onclick="reset();">重置</a>
										        <!-- <a id="editabledatatable_new" onclick="olvQuery();" class="btn btn-yellow" style="width: 37%;">
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
											<input type="hidden" id="pageSelect" name="pageSize" value="10"/>
											<input type="hidden" id="isRefund" name="isRefund" value="0"/>
											<input type="hidden" id="flowStatus" name="flowStatus" value="0"/>
											<input type="hidden" id="salesPaymentNo_form" name="salesPaymentNo"/>
											<input type="hidden" id="shopNo_form" name="shopNo"/>
											<input type="hidden" id="memberNo_form" name="memberNo"/>
                                      	</form>
                                	<div style="width:100%; height:0%; overflow-Y: hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 400%;background-color: #fff;margin-bottom: 0;">
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
                                    <div id="olvPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.salesPaymentNo}" onclick="trClick('{$T.Result.salesPaymentNo}',this)" style="height:35px;">
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
														{#if $T.Result.totalDiscountAmount != '[object Object]'}{$T.Result.totalDiscountAmount}
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
        <div class="modal-dialog" style="width: 800px;height:80%;margin: 160px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv();">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12" style="overflow-Y: hidden;">
                        	<table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 500%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                <th width="4%" style="text-align: center;">款机流水号</th>
                                                <th width="3%" style="text-align: center;">总金额</th>
                                                <th width="3%" style="text-align: center;">交易流水号</th>
                                                <th width="3%" style="text-align: center;">机器号</th>
                                                <th width="3%" style="text-align: center;">线上线下标识</th>
                                                <th width="4%" style="text-align: center;">支付时间</th>
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
												<th width="4%" style="text-align: center;">金卡</th>
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
                                        <tbody id="mainTr">
                                        </tbody>
                                    </table>
                		</div>
                	</div>
                </div>
                
                <div class="tabbable"> <!-- Only required for left/right tabs -->
					      <ul class="nav nav-tabs">
					        <li class="active"><a href="#tab1" data-toggle="tab">销售单信息</a></li>
					      </ul>
					      <div class="tab-content">
					        <div class="tab-pane active" id="tab1">
					                <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV1_tab" style="width: 400%;background-color: #fff;margin-bottom: 0;">
					                    </table>
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