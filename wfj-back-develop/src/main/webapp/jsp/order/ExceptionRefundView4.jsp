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
<title>缺货退货页面</title>
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
	#amount4{
		font-size: 15px;
		height: 38px;
	}
	/* #amount5{
		font-size: 15px;
		height: 38px;
	} */
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
	
	//退货商品和数量信息
	var refundApplyNo = refundApplyNo_;
	var orderNo = orderNo_;
	
//	var datas = data_;
//	var data2 = orderData;
	//查询订单明细（获得可退数量）
	$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/testOnlineOmsOrder/getOrderDetail",
			async : false,
			data : {
				"orderNo" : orderNo
			},
			dataType : "json",
			
			success : function(response) {
				if(response.success=='true'){
					orderData = response.data[0].allowRefundNum;
					$("#allowNum").text(orderData);
					$("#num").text(orderData);
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"查询订单失败"+"</strong></div>");
 	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	//查询退货申请单
	$.ajax({
		type : "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url:__ctxPath + "/omsOrder/selectRefundApplyList",
		async:false,
		dataType: "json",
		data:{"refundApplyNo":refundApplyNo,"page":1},
		success : function(response) {
			if (response.success == "true") {
				refundType = response.list[0].refundPath;
				address = response.list[0].warehouseAddress;
				$("#refundType").val(refundType);
				$("#address").val(address);
			} 
		}
	});
	$.ajax({
		type : "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url:__ctxPath + "/omsOrder/selectRefundApplyItemList",
		async:false,
		dataType: "json",
		data:{"refundApplyNo":refundApplyNo},
		success : function(response) {
			if (response.success == "true") {
				supplyProductNo = response.list[0].supplyProductNo;
				shoppeProName = response.list[0].shoppeProName;
				salePrice = response.list[0].salePrice;
				refundNum = response.list[0].refundNum;
				refundPcitureUrl = response.list[0].refundPcitureUrl;
				$("#supplyProductNo").text(supplyProductNo);
				$("#shoppeProName").text(shoppeProName);
				$("#salePrice").text(salePrice);
				$("#payPrice").text(salePrice*refundNum);
				$("#refundNum").text(refundNum);
//				$("#refundReasionDesc").text("库存不足");
				$("#refundPcitureUrl").text(refundPcitureUrl);
//				$("#refundReasionDesc").text(refundReasionDesc);
//				$("#callCenterComments").text(callCenterComments);
				
				//应退金额计算
				var a1 = salePrice*refundNum;
				$("#amount1").text(a1);
//				$("#amount2").text(a1);
				
				$("#orderNo").text(orderNo);
//				$("#supplyProductNo1").text(supplyProductNo);
//				$("#shoppeProName1").text(shoppeProName);
//				$("#salePrice1").text(salePrice);
//				$("#refundNum1").text(refundNum);
			} 
			
		}
	});
	var data_;
	//审核查询营销
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/testOnlineOmsOrder/foundPromResult",
		async : false,
		data : {
			"refundApplyNo" : refundApplyNo,
			"orderNo" : orderNo,
			"orderItemNo" : orderNo+"-1",
			"refundNum15" : refundNum
		},
		dataType : "json",
		cache:false, 
		success : function(response) {
			if(response.success=='true'){
				datas = response.data;
				var len = datas.billDetail.sellDetails.length;
				var discount = 0;
				for(var i=0; i<len; i++){
					discount += datas.billDetail.sellDetails[i].totalDiscount;
				}
				
				$("#amount4").text(discount);
				$("#amount2").text(datas.billDetail.factPay);
				rowNo_ = datas.billDetail.sellPayments.length;
				$("#olv_tab2 tbody").setTemplateElement("fanquan-list").processTemplate(datas);
				$("#olv_tab4 tbody").setTemplateElement("refund-list").processTemplate(datas);
				$("#olv_tab5 tbody").setTemplateElement("jifen-list").processTemplate(datas);
				$("#olv_tab6 tbody").setTemplateElement("Aquan-list").processTemplate(datas);
				data_ = datas;
			}else{
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"查询营销失败"+"</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
//			refundApplyNo_ = refundApplyNo;
//			orderNo_ = orderNo;
//			problemDesc_ = problemDesc;
//			callCenterComments_ = callCenterComments;
			//把退货扣款的rowNo带过去
			
			//扣款金额计算
			var ta=$(".amounttui");
			var t1 = 0;
			var t2 = 0;
			for(var i = 0; i<ta.length; i++){
				var t = ta[i];
				t1= $(t).val();
				t2 +=parseFloat(t1);
			}
			
			/* var a2=0;
			var rowNo=rowNo_;
				//循环拿到扣款额 id为amount_rowNo自加
			for(var i=1; rowNo>=i; i++){
				a2=$("#amount_"+i).text();
				a2++;
			} */
//			$("#amount4").text(parseFloat(t2));
//			$("#amount5").text(parseFloat(t2));
			
			return;
		}
	});
	// 初始化
	$(function() {
		//退运费
		$("#refundFee").hide();
		$("#isRefundFee").change(function() {
			if ($("#type").val() != 0) {
				$("#isRefundFee").val("否");
				$("#type").val(0);
				$("#refundFee").show();
			} else {
				$("#isRefundFee").val("是");
				$("#type").val(1);
				$("#refundFee").hide();
			}
		});
		//审核通过
		$("#shtg").click(function() {
			shtgForm();
		});
		//审核不通过
		$("#shbtg").click(function() {
			shbtgForm();
		});
		//取消
		$("#close").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/order/ExceptionOrderManagerView.jsp");
		});
		
	});
	//金额试算
	$("#jess").click(function() {
		var ta=$(".amounttui");
		var t1 = 0;
		var t2 = 0;
		for(var i = 0; i<ta.length; i++){
			var t = ta[i];
			t1= $(t).val();
			t2 +=parseFloat(t1);
		}
//		$("#amount4").text(parseFloat(t2));
//		$("#amount5").text(parseFloat(t2));	
	});	
	//审核通过
function shtgForm(){
	//从页面中拿值，传参数
	//退货扣款
	var tab=$(".amounttui");
	for(var i = 0; i<tab.length; i++){
		var inputTab = tab[i];
		data_.billDetail.sellPayments[i].amount=parseFloat($(inputTab).val());
//		alert($(inputTab).val());
//		alert(data_.billDetail.sellPayments[i].amount);
	}	
	//积分信息
	var tab=$(".amountjifen");
	for(var i = 0; i<tab.length; i++){
		if(data_.billDetail.sellPayments[i].couponGroup=='01'){
			var inputTab2 = tab[i];
			data_.billDetail.sellPayments[i].amount=parseFloat($(inputTab2).val());
		}
	}	
	var tab=$(".amountjifen2");
	for(var i = 0; i<tab.length; i++){
		if(data_.billDetail.sellPayments[i].couponGroup=='01'){
			var inputTab3 = tab[i];
			data_.billDetail.sellPayments[i].money=parseFloat($(inputTab3).val());
		}
	}	
	
	var da = JSON.stringify(data_); 
	var userName = getCookieValue("username");
	var rety = $("#refundType").val();
	var addr = $("#address").val();
	
//	var refundTarget = $("#refundTarget").val();
	var isRefundFee = $("#isRefundFee").val();
	var refundFee = $("#refundFee").val();
	$.ajax({
		type : "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url:__ctxPath + "/testOnlineOmsOrder/refundCheck2",
		async:false,
		dataType: "json",
		ajaxStart: function() {
	       	 $("#loading-container").attr("class","loading-container");
	        },
        ajaxStop: function() {
          //隐藏加载提示
          setTimeout(function() {
       	        $("#loading-container").addClass("loading-inactive");
       	 },300);
        },
		data:{"jj":da,"refundFee":refundFee,"latestUpdateMan":userName,"refundStatus":"4","refundType":rety,"address":addr},
		success : function(response) {
			if (response.success == "true") {
				$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>审核成功，返回列表页!</strong></div>");
	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			}else{
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"审核失败"+"</strong></div>");
	     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
		},
		error : function() {
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"审核失败"+"</strong></div>");
     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	});
	//修改退货申请单（退货路径，退货方式）
	/* 
	var rety = $("#refundType").val();
	var addr = $("#address").val();
	$.ajax({
		type : "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url:__ctxPath + "/testOnlineOmsOrder/修改路径",
		async:false,
		dataType: "json",
		ajaxStart: function() {
	       	 $("#loading-container").attr("class","loading-container");
	        },
        ajaxStop: function() {
          //隐藏加载提示
          setTimeout(function() {
       	        $("#loading-container").addClass("loading-inactive");
       	 },300);
        },
		data:{"refundApplyNo":refundApplyNo,"refundType":rety,"address":addr},
		success : function(response) {
			if (response.success == "true") {
			}else{
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"系统错误"+"</strong></div>");
	     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
		},
		error : function() {
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"系统错误"+"</strong></div>");
     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	}); */
}	
	//审核不通过
function shbtgForm(){
	//从页面中拿值，传参数
	 
	var tab=$(".amounttui");
	for(var i = 0; i<tab.length; i++){
		var inputTab = tab[i];
		data_.billDetail.sellPayments[i].amount=parseFloat($(inputTab).val());
//		alert($(inputTab).val());
//		alert(data_.billDetail.sellPayments[i].amount);
	}	
	//积分信息
	var tab=$(".amountjifen");
	for(var i = 0; i<tab.length; i++){
		if(data_.billDetail.sellPayments[i].couponGroup=='01'){
			var inputTab2 = tab[i];
			data_.billDetail.sellPayments[i].amount=parseFloat($(inputTab2).val());
		}
	}	
	var tab=$(".amountjifen2");
	for(var i = 0; i<tab.length; i++){
		if(data_.billDetail.sellPayments[i].couponGroup=='01'){
			var inputTab3 = tab[i];
			data_.billDetail.sellPayments[i].money=parseFloat($(inputTab3).val());
		}
	}		
	
	var da = JSON.stringify(data_); 
	var userName = getCookieValue("username");
	$.ajax({
		type : "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url:__ctxPath + "/testOnlineOmsOrder/refundCheck2",
		async:false,
		dataType: "json",
		ajaxStart: function() {
	       	 $("#loading-container").attr("class","loading-container");
	        },
        ajaxStop: function() {
          //隐藏加载提示
          setTimeout(function() {
       	        $("#loading-container").addClass("loading-inactive");
       	 },300);
        },
		data:{"jj":da,"latestUpdateMan":userName,"refundStatus":"2"},
		success : function(response) {
			if (response.success == "true") {
				$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>审核成功，返回列表页!</strong></div>");
	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			}else{
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"审核失败"+"</strong></div>");
	     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
		},
		error : function() {
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"审核失败"+"</strong></div>");
     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	});
}	
	
	var productPagination;
	function productQuery() {
		$("#sxStanCode_from").val($("#sxStanCode").val());
		$("#sxColorCode_from").val($("#sxColorCode").val());
		var params = $("#product_form").serialize();
		params = decodeURI(params);
		productPagination.onLoad(params);
	}
	function resetQuery() {
		$("#sxStanCode").val("");
		$("#sxColorCode").val("");
		productQuery();
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
		$("#pageBody").load(__ctxPath+"/jsp/order/ExceptionOrderManagerView.jsp");
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
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>退货商品和数量</strong>
													</h5>
													</div>
													&nbsp;
													 <table class="table-striped table-hover table-bordered" id="olv_tab1" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">商品编号</th>
				                                                <th width="2%" style="text-align: center;">商品名称</th>
				                                                <th width="1%" style="text-align: center;">商品价格</th>
				                                                <th width="1%" style="text-align: center;">支付金额</th>
				                                                <th width="1%" style="text-align: center;">数量</th>
				                                                <th width="1%" style="text-align: center;">可退数量</th>
				                                                <th width="1%" style="text-align: center;">退货数量</th>
				                                                <th width="2%" style="text-align: center;">退货原因</th>
				                                                <th width="2%" style="text-align: center;">退货图片</th>
				                                                <th width="2%" style="text-align: center;">备注</th>
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        	<tr>
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
				                                        	</tr>
				                                        </tbody>
				                                    </table>&nbsp;
												</div>&nbsp;
												
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
															<label class="col-lg-3 col-sm-3 col-xs-3 control-label">退货方式：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 230px;">
																<select class="form-control" id="refundType" name="refundType">
																<option value="原路返回" selected="selected">原路返回</option>
																<option value="上门取货">上门取货</option>
															</select>
															</div>											
														</div>
													
														<div class="col-md-6">
															<label class="col-lg-4 col-sm-3 col-xs-3 control-label">退货仓库地址：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6">
																<input type="text" id="address" name="address"/>
															</div>											
														</div>
													</div>
												</div>&nbsp;
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>订单赠品信息</strong>
													</h5>
													</div>
													&nbsp;
													 <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">订单号</th>
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
				                                        	<tr>
				                                        		<td align="center" id="orderNoZengping"></td>
				                                        		<td align="center" id="supplyProductNo1"></td>
				                                        		<td align="center" id="shoppeProName1"></td>
				                                        		<td align="center" id="salePrice1"></td>
				                                        		<td align="center" id="activityID"></td>
				                                        		<td align="center" id="activityName"></td>
				                                        		<td align="center" id="num1"></td>
				                                        		<td align="center" id="refundNum1"></td>
				                                        	</tr>
				                                        </tbody>
				                                    </table>&nbsp;
												</div>&nbsp;
												
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
															{#foreach $T.billDetail.sellPayments as Result}
															{#if $T.Result.flag == '3'&&$T.Result.payCode!=$T.Result.payType}
																<tr class="gradeX" id="gradeX{$T.Result.rowNo}" style="height:35px;">
																	<td align="center" id="payName_{$T.Result.rowNo}">
																		{#if $T.Result.payName != '[object Object]'}{$T.Result.payName}
										                   				{#/if}
																	</td>
																	<td align="center" id="amount_{$T.Result.rowNo}">
																	<input align="center" class="amounttui" value="{#if $T.Result.amount != '[object Object]'}{$T.Result.amount}
										                   				{#/if}"/>
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
															{#foreach $T.billDetail.sellPayments as Result}
																	{#if $T.Result.couponGroup == '01'}
																<tr class="gradeX" id="gradeX{$T.Result.rowNo}" style="height:35px;">
																	<td align="center" id="1amount_{$T.Result.rowNo}">
										                   				<input align="center" class="amountjifen" value="{#if $T.Result.amount != '[object Object]'}{$T.Result.amount}
										                   				{#/if}"/>
																	</td>
																	<td align="center" id="couponBalance_{$T.Result.rowNo}">
																		{#if $T.Result.couponBalance != '[object Object]'}{$T.Result.couponBalance}
										                   				{#/if}
																	</td>
																	<td align="center" id="money_{$T.Result.rowNo}">
										                   				<input align="center" class="amountjifen2" value="{#if $T.Result.money != '[object Object]'}{$T.Result.money}
										                   				{#/if}"/>
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
												
												<div class="col-md-12">
													<div class="col-md-6">
														<!-- <label class="col-lg-3 col-sm-3 col-xs-3 control-label" text-align="left">退款方式：</label>
														<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 230px;">
															<select class="form-control" id="refundTarget" name="refundTarget">
															<option value="1">原路返回</option>
															<option value="2">退到站内余额</option>
														</select>
														</div> -->											
													</div>
													<div class="col-md-12">
														<div class="col-md-6">
														<span>商品金额：</span>
														<label id="amount1" class="control-label"></label>
														</div>&nbsp;
													</div>&nbsp;
													<div class="col-md-12">
														<div class="col-md-4">
														<span>&nbsp;&nbsp;其中,应退金额：</span>
														<label id="amount2" class="control-label"></label>
														</div>
														<div class="col-md-4">
															<label class="col-md-5 control-label">是否退运费:</label>
															<div class="col-md-7">
																<label class="control-label"> <input
																	type="checkbox" id="isRefundFee" value="on"
																	class="checkbox-slider toggle yesno"> <span
																	class="text"></span>
																</label> <input type="hidden" id="type" name="type" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4">
															<span>应退运费金额：</span>
															<input id="refundFee" type="refundFee">
														</div>
														&nbsp;
													</div>
													<div class="col-md-12">
														<div class="col-md-6">
														<span>&nbsp;&nbsp;退回A券金额合计：</span>
														<label id="amount3" class="control-label"></label>
														</div>&nbsp;
													</div>&nbsp;
													<div class="col-md-12">
														<div class="col-md-6">
														<span>&nbsp;&nbsp;优惠金额合计：</span>
														<label id="amount4" class="control-label"></label>
														</div>&nbsp;
													</div>&nbsp;
													<!-- <div class="col-md-12">
														<div class="col-md-6">
														<span>&nbsp;&nbsp;退货金额合计：</span>
														<label id="amount5" class="control-label"></label>
														</div>&nbsp;
													</div>&nbsp; -->
												</div>&nbsp;
												<div style="display: none;">
												</div>&nbsp;
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<!-- <input class="btn btn-success" style="width: 20%;" id="jess" type="button" value="金额试算" />
														<input class="btn btn-success" style="width: 20%;" id="shbtg" type="button" value="审核不通过" />  -->
														<input class="btn btn-success" style="width: 20%;" id="shtg" type="button" value="审核通过" />
														<input class="btn btn-danger" style="width: 20%;" id="close" type="button" value="取消" />
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
	
</body>
</html>