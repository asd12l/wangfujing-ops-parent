<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 添加商品
Version: 1.0.0
Author: WangSy
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--Jquery Select2-->
<script
	src="${ctx}/assets/js/select2/select2.js"></script>
<!--Bootstrap Date Picker-->
<script
	src="${ctx}/assets/js/datetime/bootstrap-datepicker.js"></script>
<!-- zTree -->
<link rel="stylesheet"
	href="${ctx}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="${ctx}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="${ctx}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript"
	src="${ctx}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<!-- 分页JS -->
<script
	src="${ctx}/js/pagination/myPagination/jquery.myPagination6.0.js">
	
</script>
<script
	src="${ctx}/js/pagination/msgbox/msgbox.js">
	
</script>
<script
	src="${ctx}/js/pagination/jTemplates/jquery-jtemplates.js">
	
</script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/pagination/myPagination/page.css" />
<title>商品基本信息</title>
<!--图片上传
<link href="${ctx}/js/stream/css/stream-v1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${ctx}/js/stream/js/stream-v1.js"></script>-->
<style>
	#amount1{
		font-size: 15px;
		height: 38px;
	}
	#amount2{
		font-size: 15px;
		height: 38px;
	}
	#amount3{
		font-size: 15px;
		height: 38px;
	}
	/* #address{
		font-size: 14px;
		height: 4px;
	} */
	#returnType{
		font-size: 14px;
		height: 4px;
	}
	#amount4{
		font-size: 15px;
		height: 38px;
	}
	#amount5{
		font-size: 15px;
		height: 38px;
	}
	#t1{
		font-size: 14px;
		height: 4px;
	}#t2{
		font-size: 14px;
		height: 4px;
	}#t3{
		font-size: 14px;
		height: 4px;
	}
</style>
<style>
	.notbtn{
	    background-color: #fff;
	    border:1px solid #ccc;
	    color: #444;
	    border-radius: 2px;
	    font-size: 12px;
	    line-height: 1.39;
	    padding: 4px 9px;
	    text-align: center;   
	    text-decoration: none;
	}
	.notbtn:hover{
	    text-decoration: none;
	}
	.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
		cursor:pointer;
	}
</style>
<script type="text/javascript">
	$("#li_show a").click(function() {
		loadColors();
	});

	__ctxPath = "${ctx}";

	//--Bootstrap Date Picker--
	$('.date-picker').datepicker();
	$("#li_pro a").attr("data-toggle", " ");
	$("#li_profile a").attr("data-toggle", " ");
	$("#li_show a").attr("data-toggle", " ");
	//物流信息
	expressCompanyName=expressCompanyName_;
	courierNumber=courierNumber_;
	warehouseAddress=address_;
	$("#t1").text(expressCompanyName);
	$("#t2").text(courierNumber);
	$("#t3").text(warehouseAddress);
	//退货商品和数量信息
	var refundNo = refundNo_;
	var returnShippingFee = returnShippingFee_;
	var returnType = returnType_; //退货方式
	var refundApplyNo = refundApplyNo_;
	var needRefundAmount =needRefundAmount_;
	var quanAmount = quanAmount_;
	var refundStatus = refundStatus_;
//	var address = address_;   //仓库地址
	$("#refundType").val(returnType);
	var refundPath = $("#refundType");
	console.log(needRefundAmount);
	console.log(quanAmount);
	console.log(returnShippingFee);
	if(""==refundApplyNo){
		//EDI自动退的没有退货申请单号
		$("#amount1").text(parseFloat(needRefundAmount).toFixed(2));
		$("#amount2").text(parseFloat($("#amount1").text()-returnShippingFee).toFixed(2));
		$("#amount4").text(parseFloat(needRefundAmount).toFixed(2));
	}else{
		$("#amount1").text(parseFloat(needRefundAmount-quanAmount).toFixed(2));
		$("#amount2").text(parseFloat(needRefundAmount-returnShippingFee).toFixed(2));
		$("#amount4").text(parseFloat(needRefundAmount-quanAmount).toFixed(2));
	}
	$.ajax({
		type: "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=refundMode",
		dataType: "json",
		success: function(response) {
			var result = response;
			var codeValue = $("#refundType");
			for ( var i = 0; i < result.list.length; i++) {
				var ele = result.list[i];
				var option;
				if(returnType== ele.codeValue){
					option = $("<option selected='selected value='" + ele.codeValue + "'>"
							+ ele.codeName + "</option>");
				}else{
					option = $("<option value='" + ele.codeValue + "'>"
							+ ele.codeName + "</option>");
				}
				option.appendTo(codeValue);
			}
			return;
		}
	});
	//退货方式，仓库地址
//	$("#returnType").text(returnType);
//	$("#address").text(address);
	//var data2 = orderData;
	var datas = data_;
	/* $("#amount2").text(parseFloat(data_.refundAmount).toFixed(2)); 16-7-9 一*/
	/* var len = data_.billDetail.sellDetails.length;
	var discount = 0;
	for(var i=0; i<len; i++){
		discount += data_.billDetail.sellDetails[i].totalDiscount;
	}
	
	$("#amount4").text(discount); */
	$("#olv_tab4 tbody").setTemplateElement("refund-list").processTemplate(datas);
	$("#olv_tab5 tbody").setTemplateElement("jifen-list").processTemplate(datas);
	$("#olv_tab2 tbody").setTemplateElement("fanquan-list").processTemplate(datas);
	$("#olv_tab6 tbody").setTemplateElement("Aquan-list").processTemplate(datas);
	//扣款金额计算
	var ta=document.getElementById("olv_tab4");//$("#olv_tab4");
	var t1 = 0;
	var t2 = 0;
	var rows = ta.rows;
	for(var i = 1; i<rows.length; i++){
		t1 = rows[i].cells[1].innerHTML;
		t2 +=parseFloat(t1);
	}
//	$("#amount4").text(parseFloat(t2));
	$("#amount5").text(parseFloat(t2).toFixed(2));
	
	//退货方式
	/* $("#refundType").one("click",function(){
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=refundMode",
			dataType: "json",
			success: function(response) {
				var result = response;
				var codeValue = $("#refundType");
				for ( var i = 0; i < result.list.length; i++) {
					var ele = result.list[i];
					var option;
					option = $("<option value='" + ele.codeValue + "'>"
							+ ele.codeName + "</option>");
					option.appendTo(codeValue);
				}
				return;
			}
		});
	}); */
	$.ajax({
		type : "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url:__ctxPath + "/omsOrder/selectRefundItemListByNo",
		async:false,
		dataType: "json",
		data:{"refundNo":refundNo},
		success : function(response) {
			if (response.success == "true") {
				if (response.success == "true") {
					$("#olv_tab12 tbody").setTemplateElement("product-list").processTemplate(response);
					$("#olv_tab121 tbody").setTemplateElement("gift-list").processTemplate(response);
				}
				$("#packimgUrl").val(response.packimgUrl);//域名赋值
				//16-7-8注释
				/* supplyProductNo = response.list[0].supplyProductNo;
				if(response.list[0].shoppeProName != '[object Object]'){
					shoppeProName = response.list[0].shoppeProName;
				}else{
					shoppeProName = "";
				}
				salePrice = response.list[0].salePrice;
				refundNum = response.list[0].refundNum;
				refundReasionDesc = response.list[0].refundReasionDesc;
				if(refundReasionDesc=="[object Object]"){
					refundReasionDesc = "";
				}else{
					refundReasionDesc = refundReasionDesc;
				}
				$("#refundReasionDesc").text(refundReasionDesc);
				refundPcitureUrl = response.list[0].refundPcitureUrl;
				$("#supplyProductNo").text(supplyProductNo);
				$("#shoppeProName").text(shoppeProName);
				$("#salePrice").text(salePrice);
				$("#payPrice").text(salePrice*refundNum);
				$("#refundNum").text(refundNum);
				$("#refundPcitureUrl").text(refundPcitureUrl); */
				
//				$("#allowNum").text(data2);
//				$("#num").text(data2);
				//应退金额计算
//			var a1 = salePrice*refundNum;
//				$("#amount1").text(salePrice*refundNum);
//				$("#amount2").text(a1);
				
				//应退运费
				if(datas.refundStatus=="03" || datas.refundStatus=="04" || datas.refundStatus=="12" || datas.refundStatus=="15"){
					$("#refundProductStatus").text("已入库");
				}else{
					$("#refundProductStatus").text("未入库");
				}
				$("#returnShippingFee").text(returnShippingFee);
				if(returnShippingFee==0){
					$("#isReturnShippingFee").text("不退");
				}else{
					$("#isReturnShippingFee").text("退");
				}
				
			} else {
			}
			return;
		}
		/* callback: function(data) {
      		$("#olv_tab1 tbody").setTemplateElement("olv-list1").processTemplate(data);
        } */
	});
	
	// 初始化
	$(function() {
	//	var refundApplyNo = refundApplyNo_;
		$.ajax({
			type : "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/selectRefundApplyItemList",
			async:false,
			dataType: "json",
			data:{"refundApplyNo":refundApplyNo},
			success : function(response) {
				
				var spc=$(".salePriceClass");
				var rc=$(".refundNumClass");
				var totalPrice = 0;
				var t1 = 0;
				var t2 = 0;
				
				for(var i = 0; i<spc.length; i++){
					var s1 = spc[i];
					var r1 = rc[i];
					t1 = parseFloat($(s1).text());
					t2 = parseFloat($(r1).text());
					totalPrice += t1*t2;
				}
				/* $("#amount1").text(parseFloat(totalPrice).toFixed(2)); 16-7-9 三*/
				
					/* for(var i=0; i<response.list.length; i++){
					} */
					/* supplyProductNo = response.list[0].supplyProductNo;
					shoppeProName = response.list[0].shoppeProName;
					salePrice = response.list[0].salePrice;
					refundNum = response.list[0].refundNum;
					refundPcitureUrl = response.list[0].refundPcitureUrl; 
					$("#supplyProductNo").text(supplyProductNo); //商品编号
					$("#shoppeProName").text(shoppeProName);	//商品名称
					$("#salePrice").text(salePrice);			//商品价格
					$("#payPrice").text(salePrice*refundNum);	//销售价格
					$("#amount1").text(salePrice*refundNum);
					$("#refundNum").text(refundNum);			//退货数量
					$("#refundPcitureUrl").text(refundPcitureUrl);  //退货图片
					
					$("#refundReasionDesc").text(refundReasionDesc); //退货原因
					$("#callCenterComments").text(callCenterComments); //备注
					
					$("#allowNum").text(data2);					//可货数量
					$("#num").text(data2);						//数量
					//应退金额计算
					var a1 = salePrice*refundNum;
		//			$("#amount1").text(a1);
		//			$("#amount2").text(a1);
					
					$("#orderNo").text(orderNo);
//					$("#supplyProductNo1").text(supplyProductNo);
//					$("#shoppeProName1").text(shoppeProName);
//					$("#salePrice1").text(salePrice);
//					$("#refundNum1").text(refundNum);
				} 
				
				//扣款金额计算
				var ta=$(".amounttui");
				var t1 = 0;
				var t2 = 0;
				for(var i = 0; i<ta.length; i++){
					var t = ta[i];
					t1= $(t).val();
					t2 +=parseFloat(t1);
				}
				
//				$("#amount4").text(parseFloat(t2));
//				$("#amount5").text(parseFloat(t2)); */
			}
		});
		/* if(isNaN(($("#amount1").text()-$("#amount2").text()).toFixed(2))){
			$("#amount4").text("");
		}else{
			$("#amount4").text(parseFloat($("#amount1").text()-$("#amount2").text()).toFixed(2));//优惠金额目前是amount1-amount2
		}16-7-9 四 */
//		$("#amount4").text(parseFloat($("#amount1").text()-$("#amount2").text()).toFixed(2));//优惠金额目前是amount1-amount2
		//取消
		$("#closed").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/order/OrderRefundListView2.jsp");
		});
	});

</script>

<script type="text/javascript">
	
	
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
	//图片展示
	function urlClick(ur,obj){
//		$("#imageDiv").text(ur);
		$("#imageDiv").html('<img style="width:200px; heigth:200px;" align="center" src="http://10.6.100.100/refundPicture/'+ur+'"/>');
		$("#btDiv2").show();
	}
	function closeBtDiv2(){
		$("#btDiv2").hide();
	}
	//跳到商品详情页
	function trClick(skuNo, obj){
		var packimg_url = $("#packimgUrl").val();
		window.open(packimg_url+"/item/"+skuNo+".jhtml");
	}
</script>

</head>
<body>
	<div class="page-body" id="productSaveBody">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption"></span>
								<div class="widget-buttons">
                                     <a href="#" data-toggle="maximize"></a>
                                     <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                         <i class="fa fa-minus" id="pro-i"></i>
                                     </a>
                                     <a href="#" data-toggle="dispose"></a>
                                 </div>
							</div>
							<div class="widget-body" id="pro">
								<div class="tabbable">
									<!-- <ul class="nav nav-tabs" id="myTab">
										<li class="active" id="li_base"><a data-toggle="tab"
											href="#base"> <span>退货信息</span>
										</a></li>
									</ul> -->
									<!-- BaseMessage start -->
									<div class="tab-content">
										<div id="base" class="tab-pane in active">
											<form id="baseForm" method="post" class="form-horizontal">
												<input type="hidden" id="packimgUrl" value="">
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>退货商品和数量</strong>
													</h5>
													</div>
													&nbsp;
													 <table class="table-striped table-hover table-bordered" id="olv_tab12" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">订单号</th>
				                                                <th width="2%" style="text-align: center;">退货单号</th>
				                                                <th width="2%" style="text-align: center;">商品编号</th>
				                                                <th width="2%" style="text-align: center;">商品名称</th>
				                                                <th width="1%" style="text-align: center;">商品价格</th>
				                                                <th width="1%" style="text-align: center;">销售金额</th>
				                                                <th width="1%" style="text-align: center;">数量</th>
				                                                <th width="1%" style="text-align: center;">可退数量</th>
				                                                <th width="1%" style="text-align: center;">退货数量</th>
				                                                <th width="2%" style="text-align: center;">退货原因</th>
				                                                <th width="2%" style="text-align: center;">退货图片</th>
				                                                <th width="2%" style="text-align: center;">备注</th>
				                                            </tr>
				                                        </thead>
				                                         <tbody>
				                                        	<!-- <tr>
				                                        		<td align="center" id="supplyProductNo" name="supplyProductNo"></td>
				                                        		<td align="center" id="shoppeProName" name="shoppeProName"></td>
				                                        		<td align="center" id="salePrice" name="salePrice"></td>
				                                        		<td align="center" id="payPrice" name="payPrice"></td>
				                                        		<td align="center" id="num" name="num"></td>
				                                        		<td align="center" id="allowNum" name="allowNum"></td>
				                                        		<td align="center" id="refundNum" name="refundNum"></td>
				                                        		<td align="center" id="refundReasionDesc" name="refundReasionDesc"></td>
				                                        		<td align="center" id="refundPcitureUrl" name="refundPcitureUrl"></td>
				                                        		<td align="center" id="callCenterComments" name="callCenterComments"></td>
				                                        	</tr> -->
				                                        </tbody>
				                                    </table>
												</div>&nbsp;
												<p style="display:none">
													<textarea id="product-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.list as Result}
															{#if $T.Result.isGift == '0'}
																<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px;">
																	<td align="center" id="orderNo_{$T.Result.sid}">
																		{#if $T.Result.orderNo != '[object Object]'}{$T.Result.orderNo}
										                   				{#/if}
																	</td>
																	<td align="center" id="refundNo_{$T.Result.sid}">
																		{#if $T.Result.refuntNo != '[object Object]'}{$T.Result.refundNo}
										                   				{#/if}
																	</td>
																	<td align="center" id="supplyProductNo_{$T.Result.sid}">
																		<a onclick="trClick('{$T.Result.skuNo}',this);" style="cursor:pointer;">
																			{#if $T.Result.supplyProductNo != '[object Object]'}{$T.Result.supplyProductNo}
																			{#/if}
																		</a>
																	</td>
																	<td align="center" id="shoppeProName_{$T.Result.sid}">
																		{#if $T.Result.shoppeProName != '[object Object]'}{$T.Result.shoppeProName}
										                   				{#/if}
																	</td>
																	<td align="center" class="salePriceClass" id="salePrice_{$T.Result.sid}">
																		{#if $T.Result.salePrice != '[object Object]'}{$T.Result.salePrice}
																		{#elseif $T.Result.salePrice == ''}0
										                   				{#/if}
																	</td>
																	<td align="center" id="refundSalePrice_{$T.Result.sid}">
																		{#if $T.Result.refundSalePrice != '[object Object]'}{$T.Result.refundSalePrice}
																		{#else}0
										                   				{#/if}
																	</td>
																	<td align="center" id="refundNumAll_{$T.Result.sid}">
																		{#if $T.Result.refundNumAll != '[object Object]'}{$T.Result.refundNumAll}
																		{#else}0
										                   				{#/if}
																	</td>
																	<td align="center" id="allowRefundNum_{$T.Result.sid}">
																		{#if $T.Result.allowRefundNum != '[object Object]'}{$T.Result.allowRefundNum}
																		{#else}0
										                   				{#/if}
																	</td>
																	<td align="center" class="refundNumClass" id="refundNum_{$T.Result.sid}">
																		{#if $T.Result.refundNum != '[object Object]'}{$T.Result.refundNum}
										                   				{#else}0
										                   				{#/if}
																	</td>
																	<td align="center" id="refundReasionDesc_{$T.Result.sid}">
																		{#if $T.Result.refundReasionDesc != '[object Object]'}{$T.Result.refundReasionDesc}
										                   				{#/if}
																	</td>
																	<td align="center" id="refundPcitureUrl_{$T.Result.sid}">
																		<a onclick="urlClick('{$T.Result.refundPcitureUrl}',this);" style="cursor:pointer;">
																			{#if $T.Result.refundPcitureUrl != '[object Object]'}{$T.Result.refundPcitureUrl}
										                   					{#/if}
																		</a>
																	</td>
																	<td align="center" id="callCenterComments_{$T.Result.sid}">
																		{#if $T.Result.callCenterComments != '[object Object]'}{$T.Result.callCenterComments}
										                   				{#/if}
																	</td>
													       		</tr>
															{#/if}
															{#/for}
													    {#/template MAIN}	-->
													</textarea>
												</p>
												<!-- <div class="col-md-12">
													<h5>
														<strong>退货理由</strong>
													</h5>
													&nbsp;
													<div class="form-group">
														<div class="col-md-6">
															<label class="col-lg-3 col-sm-3 col-xs-3 control-label">退货原因：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 230px;">
																<select class="form-control" id="refundReason" name="refundReason">
																<option value="">请选择退货原因</option>
															</select>
															</div>											
														</div>
													
														<div class="col-md-6">
															<label class="col-lg-3 col-sm-3 col-xs-3 control-label">备注：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6">
																<textarea style="width: 500px;height: 240px;max-width: 300px;max-height: 100px;min-width: 200px;min-height: 100px;resize: none" id="comments" name="comments" placeholder="非必填"></textarea>
															</div>											
														</div>
													</div>
												</div> -->
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>退货方式</strong>
													</h5>
													</div>
													&nbsp;
													<div class="form-group">
													
														<div class="col-md-6">
															<label class="col-lg-4 col-sm-3 col-xs-3 control-label">退货方式：</label>
															<!-- <div class="col-lg-6 col-sm-6 col-xs-6">
																<label id="returnType"></label>
															</div> -->	
															<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 230px;">
																<select class="form-control" id="refundType" name="refundType">
																</select>
															</div>											
														</div>
														<!-- <div class="col-md-6">
															<label class="col-lg-4 col-sm-3 col-xs-3 control-label">退货仓库地址：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6">
																
																<label id="address"></label>
															</div>											
														</div> -->
													</div>
												</div>
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>退货物流信息</strong>
													</h5>
													</div>
													&nbsp;
													<div class="form-group">
														<div class="col-md-4">
															<label class="col-lg-4 col-sm-3 col-xs-3 control-label">快递公司：</label>
															<div class="col-lg-8 col-sm-8 col-xs-8">
																<label id="t1"></label>
															</div>											
														</div>
														<div class="col-md-4">
															<label class="col-lg-4 col-sm-3 col-xs-3 control-label">快递单号：</label>
															<div class="col-lg-8 col-sm-8 col-xs-8">
																<label id="t2"></label>
															</div>										
														</div>
														
														<div class="col-md-4">
															<label class="col-lg-4 col-sm-3 col-xs-3 control-label">退货地址：</label>
															<div class="col-lg-8 col-sm-8 col-xs-8">
																<label id="t3"></label>
															</select>
															</div>											
														</div>
														<!-- 	<div class="col-md-6">
															<label class="col-lg-3 col-sm-3 col-xs-3 control-label">快递费用：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6">
																<label id="t4"></label>
															</div>											
														</div> -->
														&nbsp;
														<!-- <div>
														 <table align="center" class="table-striped table-hover table-bordered" id="olv_tab" style="width: 60%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">时间</th>
				                                                <th width="2%" style="text-align: center;">地点和跟踪进度</th>
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        	<tr>
				                                        		<td align="center">1</td>
				                                        		<td align="center">2</td>
				                                        	</tr>
				                                        	<tr>
				                                        		<td align="center">1</td>
				                                        		<td align="center">2</td>
				                                        	</tr>
				                                        </tbody>
				                                    </table>
				                                    </div> -->
													</div>
												</div>
												&nbsp;
												
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>订单赠品信息</strong>
													</h5>
													</div>
													&nbsp;
													 <table class="table-striped table-hover table-bordered" id="olv_tab121" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">订单号</th>
				                                                <th width="2%" style="text-align: center;">退货单号</th>
				                                                <th width="2%" style="text-align: center;">商品编码</th>
				                                                <th width="1%" style="text-align: center;">商品名称</th>
				                                                <th width="2%" style="text-align: center;">价格</th>
				                                                <th width="2%" style="text-align: center;">活动编码</th>
				                                                <th width="1%" style="text-align: center;">活动名称</th>
				                                                <th width="1%" style="text-align: center;">数量</th>
				                                                <th width="1%" style="text-align: center;">退回数量</th>
				                                            </tr>
				                                        </thead>
				                                       <tbody>
				                                        	<!-- <tr>
				                                        		<td align="center" id="orderNo"></td>
				                                        		<td align="center" id="supplyProductNo1"></td>
				                                        		<td align="center" id="shoppeProName1"></td>
				                                        		<td align="center" id="salePrice1"></td>
				                                        		<td align="center" id="activityID"></td>
				                                        		<td align="center" id="activityName"></td>
				                                        		<td align="center" id="num1"></td>
				                                        		<td align="center" id="refundNum1"></td>
				                                        	</tr> -->
				                                        </tbody>
				                                    </table>&nbsp;
												</div>&nbsp;
												<p style="display:none">
													<textarea id="gift-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.list as Result}
															{#if $T.Result.isGift == '1'}
																<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px;">
																	<td align="center" id="orderNo_{$T.Result.sid}">
																		{#if $T.Result.orderNo != '[object Object]'}{$T.Result.orderNo}
										                   				{#/if}
																	</td>
																	<td align="center" id="refundNo_{$T.Result.sid}">
																		{#if $T.Result.refuntNo != '[object Object]'}{$T.Result.refundNo}
										                   				{#/if}
																	</td>
																	<td align="center" id="supplyProductNo_{$T.Result.sid}">
																		<a onclick="trClick2('{$T.Result.skuNo}',this);" style="cursor:pointer;">
																			{#if $T.Result.supplyProductNo != '[object Object]'}{$T.Result.supplyProductNo}
																			{#/if}
																		</a>
																	</td>
																	<td align="center" id="shoppeProName_{$T.Result.sid}">
																		{#if $T.Result.shoppeProName != '[object Object]'}{$T.Result.shoppeProName}
										                   				{#/if}
																	</td>
																	<td align="center" id="salePrice_{$T.Result.sid}">
																		{#if $T.Result.salePrice != '[object Object]'}{$T.Result.salePrice}
																		{#elseif $T.Result.salePrice == ''}0
										                   				{#/if}
																	</td>
																	
																	<td align="center" id="hdbm_{$T.Result.sid}">
																		{#if $T.Result.hdbm != '[object Object]'}{$T.Result.hdbm}
										                   				{#/if}
																	</td>
																	<td align="center" id="hdmc_{$T.Result.sid}">
																		{#if $T.Result.hdmc != '[object Object]'}{$T.Result.hdmc}
										                   				{#/if}
																	</td>
																	
																	<td align="center" id="refundNumAll_{$T.Result.sid}">
																		{#if $T.Result.refundNumAll != '[object Object]'}{$T.Result.refundNumAll}
																		{#else}0
										                   				{#/if}
																	</td>
																	<td align="center" id="refundNum_{$T.Result.sid}">
																		{#if $T.Result.refundNum != '[object Object]'}{$T.Result.refundNum}
										                   				{#else}0
										                   				{#/if}
																	</td>
													       		</tr>
															{#/if}
															{#/for}
													    {#/template MAIN}	-->
													</textarea>
												</p>
												
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>退货扣款</strong>
													</h5>
													</div>
													&nbsp;
													 <table class="table-striped table-hover table-bordered" id="olv_tab4" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">原因</th>
				                                                <th width="2%" style="text-align: center;">扣款额</th>
				                                                <th width="1%" style="text-align: center;">扣款说明</th>
				                                                <!-- <th width="1%" style="text-align: center;">是否退回</th> -->
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        	<!-- <tr>
				                                        		<td align="center">1</td>
				                                        		<td align="center">2</td>
				                                        		<td align="center">3</td>
				                                        		<td align="center">
				                                        			<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
																		<label style="padding-left:9px;">
																			<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																			<span class="text"></span>
																		</label>
																	</div>
																</td>
				                                        	</tr>
				                                        	<tr>
				                                        		<td align="center">1</td>
				                                        		<td align="center">2</td>
				                                        		<td align="center">3</td>
				                                        		<td align="center">
				                                        			<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
																		<label style="padding-left:9px;">
																			<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																			<span class="text"></span>
																		</label>
																	</div>
																</td>
				                                        	</tr> -->
				                                        </tbody>
				                                    </table>&nbsp;
												</div>&nbsp;
												<p style="display:none">
													<textarea id="refund-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.deduction as Result}
															{#if $T.Result.flag == '3'}
																<tr class="gradeX" id="gradeX{$T.Result.rowNo}" style="height:35px;">
																	<td align="center" id="payname_{$T.Result.rowNo}">
																		{#if $T.Result.payname != '[object Object]'}{$T.Result.payname}
										                   				{#/if}
																	</td>
																	<td align="center" id="money_{$T.Result.rowNo}">
																		{#if $T.Result.money != '[object Object]'}{$T.Result.money}
										                   				{#/if}
																	</td>
																	<td align="center" id="payType_{$T.Result.rowNo}">
																		{#if $T.Result.payType != '[object Object]'}{$T.Result.payType}
										                   				{#/if}
																	</td>
																	
													       		</tr>
													       		{#/if}
															{#/for}
													    {#/template MAIN}	-->
													</textarea>
												</p>
												
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>积分信息</strong>
													</h5>
													</div>
													&nbsp;
													 <table class="table-striped table-hover table-bordered" id="olv_tab5" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">须退回积分</th>
				                                                <th width="2%" style="text-align: center;">当前账户</th>
				                                                <th width="1%" style="text-align: center;">需要补扣积分</th>
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        </tbody>
				                                    </table>&nbsp;
												</div>&nbsp;
												<p style="display:none">
													<textarea id="jifen-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.deduction as Result}
																	{#if $T.Result.couponGroup == '01'}
																<tr class="gradeX" id="gradeX{$T.Result.rowNo}" style="height:35px;">
																	<td align="center" id="1amount_{$T.Result.rowNo}">
																		{#if $T.Result.amount != '[object Object]'}{$T.Result.amount}
										                   				{#/if}
																	</td>
																	<td align="center" id="couponBalance_{$T.Result.rowNo}">
																		{#if $T.Result.couponBalance != '[object Object]'}{$T.Result.couponBalance}
										                   				{#/if}
																	</td>
																	<td align="center" id="money_{$T.Result.rowNo}">
																		{#if $T.Result.money != '[object Object]'}{$T.Result.money}
										                   				{#/if}
																	</td>
													       		</tr>
																	(#/if}
															{#/for}
													    {#/template MAIN}	-->
													</textarea>
												</p>
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>退货商品关联返券信息</strong>
													</h5>
													</div>
													&nbsp;
													 <table class="table-striped table-hover table-bordered" id="olv_tab2" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">优惠券编码</th>
				                                                <th width="2%" style="text-align: center;">优惠券名称</th>
				                                                <th width="1%" style="text-align: center;">优惠券面值</th>
				                                                <th width="2%" style="text-align: center;">活动编码</th>
				                                                <th width="2%" style="text-align: center;">活动名称</th>
				                                                <th width="1%" style="text-align: center;">优惠券状态</th>
				                                                <th width="1%" style="text-align: center;">是否退回</th>
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        </tbody>
				                                    </table>&nbsp;
												</div>&nbsp;
												<p style="display:none">
													<textarea id="fanquan-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.billDetail.sellPayments as Result}
															{#if $T.Result.couponGroup == '02'&&$T.Result.flag == '3'}
																<tr class="gradeX" id="gradeX{$T.Result.rowNo}" style="height:35px;">
																	<td align="center" id="payCode_{$T.Result.rowNo}">
																		{#if $T.Result.payCode != '[object Object]'}{$T.Result.payCode}
										                   				{#/if}
																	</td>
																	<td align="center" id="payName_{$T.Result.rowNo}">
																		{#if $T.Result.payName != '[object Object]'}{$T.Result.payName}
										                   				{#/if}
																	</td>
																	<td align="center" id="amount_{$T.Result.rowNo}">
																		{#if $T.Result.amount != '[object Object]'}{$T.Result.amount}
										                   				{#/if}
																	</td>
																	<td align="center" id="couponEventId_{$T.Result.rowNo}">
																		{#if $T.Result.couponEventId != '[object Object]'}{$T.Result.couponEventId}
										                   				{#/if}
																	</td>
																	<td align="center" id="receptPhone_{$T.Result.rowNo}">
																		{#if $T.Result.receptPhone != '[object Object]'}{$T.Result.receptPhone}
										                   				{#/if}
																	</td>
																	<td align="center" id="receptAddress_{$T.Result.rowNo}">
																		{#if $T.Result.receptAddress != '[object Object]'}{$T.Result.receptAddress}
										                   				{#/if}
																	</td>
																	<td align="center" class="brandTypeTd">
																		<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
																			<label>
																				<input type="checkbox" id="tdCheckbox_{$T.Result.rowNo}" value="{$T.Result.rowNo}" >
																				<span class="text"></span>
																			</label>
																		</div>
																	</td>
													       		</tr>
													       		{#/if}
															{#/for}
													    {#/template MAIN}	-->
													</textarea>
												</p>
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>退款信息(退回顾客使用的A券)</strong>
													</h5>
													</div>
													&nbsp;
													 <table class="table-striped table-hover table-bordered" id="olv_tab6" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">优惠券编码</th>
				                                                <th width="2%" style="text-align: center;">优惠券名称</th>
				                                                <th width="1%" style="text-align: center;">面值</th>
				                                                <th width="1%" style="text-align: center;">是否退回</th>
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        	<!-- <tr>
				                                        		<td align="center">1</td>
				                                        		<td align="center">2</td>
				                                        		<td align="center">3</td>
				                                        		<td align="center">
				                                        			<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
																		<label style="padding-left:9px;">
																			<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																			<span class="text"></span>
																		</label>
																	</div>
																</td>
				                                        	</tr>
				                                        	<tr>
				                                        		<td align="center">1</td>
				                                        		<td align="center">2</td>
				                                        		<td align="center">3</td>
				                                        		<td align="center">
				                                        			<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
																		<label style="padding-left:9px;">
																			<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																			<span class="text"></span>
																		</label>
																	</div>
																</td>
				                                        	</tr> -->
				                                        </tbody>
				                                    </table>&nbsp;
												</div>&nbsp;
												<p style="display:none">
													<textarea id="Aquan-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.billDetail.sellPayments as Result}
															{#if $T.Result.couponGroup == '02'&&$T.Result.flag == '2'}
																<tr class="gradeX" id="gradeX{$T.Result.rowNo}" style="height:35px;">
																	<td align="center" id="payName_{$T.Result.rowNo}">
																		{#if $T.Result.payName != '[object Object]'}{$T.Result.payName}
										                   				{#/if}
																	</td>
																	<td align="center" id="2amount_{$T.Result.rowNo}">
																		{#if $T.Result.amount != '[object Object]'}{$T.Result.amount}
										                   				{#/if}
																	</td>
																	<td align="center" id="receptPhone_{$T.Result.rowNo}">
																		{#if $T.Result.receptPhone != '[object Object]'}{$T.Result.receptPhone}
										                   				{#/if}
																	</td>
																	<td align="left" class="brandTypeTd">
																		<div align="center" class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
																			<label>
																				<input type="checkbox" id="tdCheckbox_{$T.Result.rowNo}" value="{$T.Result.rowNo}" >
																				<span class="text"></span>
																			</label>
																		</div>
																	</td>
													       		</tr>
													       		{#/if}
															{#/for}
													    {#/template MAIN}	-->
													</textarea>
												</p>
												&nbsp;
												<div class="col-md-12">
													<div class="col-md-4">
														<div >
														<label> &nbsp; &nbsp; &nbsp; 退货商品入库状态：</label>
															<label id="refundProductStatus"></label>
														</div>	
													</div>
													<div class="col-md-6">
														<!-- <label class="col-lg-3 col-sm-3 col-xs-3 control-label" text-align="left">退款方式：</label>
														<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 230px;">
															<select class="form-control" id="refundType" name="refundType">
															<option value="1">原路返回</option>
															<option value="2">退到站内余额</option>
														</select>
														</div>	 -->										
													</div>
													<div class="col-md-12">
														<div class="col-md-6">
														<span> &nbsp;&nbsp;应退款金额：</span>
														<label id="amount1" class="control-label"></label>
														</div>&nbsp;
													</div>
													<div class="col-md-12">
														<div class="col-md-4">
														<span>&nbsp;&nbsp;其中,应退商品金额：</span>
														<label id="amount2" class="control-label"></label>
														</div>
														<div class="col-md-4">
															<div >
															<label>是否退运费：</label>
																<label id="isReturnShippingFee"></label>
															</div>	
														</div>
														<div class="col-md-4">
															<span>应退运费金额：</span>
															<label id="returnShippingFee"></label>
														</div>
														&nbsp;
													</div>
													<div class="col-md-12">
														<div class="col-md-6">
														<span>&nbsp;&nbsp;退回顾客A券金额合计：</span>
														<label id="amount3" class="control-label"></label>
														</div>
														&nbsp;
													</div>
													<div class="col-md-12">
														<div class="col-md-6">
														<span>&nbsp;&nbsp;扣款金额合计：</span>
														<label id="amount5" class="control-label"></label>
														</div>
														&nbsp;
													</div>
													<div class="col-md-12">
														<div class="col-md-6">
														<span>&nbsp;&nbsp;退款金额合计：</span>
														<label id="amount4" class="control-label"></label>
														</div>
														&nbsp;
													</div>
												</div>
												<div style="display: none;">
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														 <input class="btn btn-danger" style="width: 20%;" id="closed"
															type="button" value="返回" />
													</div>
												</div>
											</form>
										</div>
										<!-- BaseMessage end -->
										<!-- #show start -->
										<div id="show" class="tab-pane"></div>
										<!-- #show end -->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Templates -->
	<div class="modal modal-darkorange" id="btDiv2">
        <div class="modal-dialog" style="width:200px; height:500%; margin: 15% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv2();">×</button>
                    <h6 class="modal-title" id="divTitle">图片</h6>
                </div>
                    <div id="imageDiv">
                    	
                    </div>
               <!--  <div class="page-body" id="pageBodyRight">
                </div> -->
               
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
</body>
</html>