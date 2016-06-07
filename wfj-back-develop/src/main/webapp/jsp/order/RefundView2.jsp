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
	#amount4{
		font-size: 15px;
		height: 38px;
	}
	#amount5{
		font-size: 15px;
		height: 38px;
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
	
	//退货商品和数量信息
	var refundApplyNo = refundApplyNo_;
	var orderNo = orderNo_;//订单号
	var refundReasionDesc = problemDesc_;			//退货原因
	var callCenterComments = callCenterComments_; //备注
	var refundNum = refundNum_;
//	var data2 = orderData;
	var data_;
	var isCod;
	//退货方式
	$("#refundType").val(refundPath_);
	
	//查询订单是否是isCod
	$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/testOnlineOmsOrder/foundByOrder",
			async : false,
			data : {
				"orderNo" : orderNo
			},
			dataType : "json",
			success : function(response) {
				if(response.success=='true'){
					isCod = response.data.list[0].isCod;
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"查询订单失败"+"</strong></div>");
 	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	//退货退款账号信息展现
	if(isCod == 1){
		$("#isCodId").show();
	}else{
		$("#isCodId").hide();
	}
	var refundPath = $("#refundType");
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
						if(refundPath== ele.codeValue){
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
	//审核查询营销
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/testOnlineOmsOrder/foundPromResult",
		async : false,
		data : {
			"refundApplyNo" : refundApplyNo,
			"orderNo" : orderNo,
			"orderItemNo" : orderNo+"-1",//没用
			"refundNum15" : refundNum
		},
		dataType : "json",
		
		success : function(response) {
			if(response.success=='true'){
				data_ = response.data;
				var len = data_.billDetail.sellDetails.length;
				var discount = 0;
				for(var i=0; i<len; i++){
					discount += data_.billDetail.sellDetails[i].totalDiscount;
				}
				
//				$("#amount4").text(discount);
//				$("#amount2").text(data_.billDetail.factPay);
//				se = $(selectRefundPromotion);
//				se = session.getAttribute("selectRefundPromotion");
//				se = request.getsession().getAttribute("selectRefundPromotion");
				rowNo_ = data_.billDetail.sellPayments.length;
				$("#olv_tab2 tbody").setTemplateElement("fanquan-list").processTemplate(data_);
				$("#olv_tab4 tbody").setTemplateElement("refund-list").processTemplate(data_);
				$("#olv_tab5 tbody").setTemplateElement("jifen-list").processTemplate(data_);
				$("#olv_tab6 tbody").setTemplateElement("Aquan-list").processTemplate(data_);

			}else{
				/* $("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"查询营销失败"+"</strong></div>"); */
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.data.errorMsg+"</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
			
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
//				address = response.list[0].warehouseAddress;
				$("#refundType").val(refundType);
//				$("#address").val(address);
				$("#amount2").text(parseFloat( response.list[0].refundAmount).toFixed(2));
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
				$("#olv_tab12 tbody").setTemplateElement("product-list").processTemplate(response);
			}
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
			$("#amount1").text(parseFloat(totalPrice).toFixed(2));
			
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
//				$("#supplyProductNo1").text(supplyProductNo);
//				$("#shoppeProName1").text(shoppeProName);
//				$("#salePrice1").text(salePrice);
//				$("#refundNum1").text(refundNum);
			} 
			 */
			//扣款金额计算
			var ta=$(".amounttui");
			var t1 = 0;
			var t2 = 0;
			for(var i = 0; i<ta.length; i++){
				var t = ta[i];
				t1= $(t).val();
				t2 +=parseFloat(t1);
			}
			$("#amount4").text(parseFloat($("#amount1").text()-$("#amount2").text()).toFixed(2));
//			$("#amount4").text(parseFloat(t2));
			$("#amount5").text(parseFloat(t2));
		}
	});
	//扣款金额校验
	$(".amounttui").keyup(function(){
		var aa=$(".amounttui");
		var a1 = 0;
		var a2 = 0;
		for(var i = 0; i<aa.length; i++){
			var a = aa[i];
			a1= $(a).val();
			a2 +=parseFloat(a1);
		}
		var amount4money = $("#amount4").text();
		var id=$(this).attr("id");
		if(a2>amount4money){
			$("#"+id).val("");
		}
	});
	var returnShippingFee = returnShippingFee_; //订单支付运费金额
	// 初始化
	$(function() {
		$("#xzspan").hide();
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
			$("#pageBody").load(__ctxPath + "/jsp/order/ReturnApplyView2.jsp");
		});
		
	});

	/* $("#refundFee").mouseleaver(function(){
		var refundFeess = $("#refundFee").val();
		if(refundFeess>returnShippingFee){
			alert("金额大了！");
		}
	}); */
	function refundFeeTrim(){
		var refundFeess = $("#refundFee").val();
//		console.log("refundFeess:"+refundFeess);
//		console.log("returnShippingFee:"+returnShippingFee);
		if(parseFloat(refundFeess) > parseFloat(returnShippingFee)){
			$("#xzspan").show();
			$("#shtg").attr("disabled", "true");
			$("#shbtg").attr("disabled", "true");
		}else{
			$("#xzspan").hide();
			$("#shtg").removeAttr("disabled");
			$("#shbtg").removeAttr("disabled");
		}
	}
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
	if(0<tab.length){
		var j=0;
		for(var i = 0; i<tab.length; i++){
			if(data_.billDetail.sellPayments[j].flag=='3'){
				var inputTab = tab[i];
				data_.billDetail.sellPayments[j].money=parseFloat($(inputTab).val());
//				alert($(inputTab).val());
			}else{
				i=i-1;
			}
			j++;
	//		alert(data_.billDetail.sellPayments[i].amount);
		}	
	}
	//积分信息
	var tab=$(".amountjifen");
	if(0<tab.length){
		for(var i = 0; i<tab.length; i++){
			if(data_.billDetail.sellPayments[i].couponGroup=='01'){
				var inputTab2 = tab[i];
				data_.billDetail.sellPayments[i].amount=parseFloat($(inputTab2).val());
			}
		}	
	}
	var tab=$(".amountjifen2");
	if(0<tab.length){
		for(var i = 0; i<tab.length; i++){
			if(data_.billDetail.sellPayments[i].couponGroup=='01'){
				var inputTab3 = tab[i];
				data_.billDetail.sellPayments[i].money=parseFloat($(inputTab3).val());
			}
		}	
	}
	var da = JSON.stringify(data_); 
//	var userName = "${username}";
  	var userName = getCookieValue("username");
	var rety = $("#refundType").val();
//	var addr = $("#address").val();
	
//	var refundTarget = $("#refundTarget").val();
	var isRefundFee = $("#isRefundFee").val();
	var refundFee = $("#refundFee").val();
	
	var bankName = $("#bankName").val();
	var bankNumber = $("#bankNumber").val();
	var bankUser = $("#bankUser").val();
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
		data:{bankName:"bankName",bankNumber:"bankNumber",bankUser:"bankUser","jj":da,"refundFee":refundFee,"latestUpdateMan":userName,"refundStatus":"4","refundType":rety/* ,"address":addr */},
		success : function(response) {
			if (response.success == "true") {
				$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>审核成功，返回列表页!</strong></div>");
	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			}else{
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.data.errorMsg+"</strong></div>");
/* 				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"审核失败"+"</strong></div>"); */
	     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
		},
		error : function() {
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.data.errorMsg+"</strong></div>");
/* 			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"审核失败"+"</strong></div>"); */
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
	if(0<tab.length){
		for(var i = 0; i<tab.length; i++){
			var inputTab = tab[i];
			data_.billDetail.sellPayments[i].amount=parseFloat($(inputTab).val());
	//		alert($(inputTab).val());
	//		alert(data_.billDetail.sellPayments[i].amount);
		}
	}
	//积分信息
	var tab=$(".amountjifen");
	if(0<tab.length){
		for(var i = 0; i<tab.length; i++){
			if(data_.billDetail.sellPayments[i].couponGroup=='01'){
				var inputTab2 = tab[i];
				data_.billDetail.sellPayments[i].amount=parseFloat($(inputTab2).val());
			}
		}
	}
	var tab=$(".amountjifen2");
	if(0<tab.length){
		for(var i = 0; i<tab.length; i++){
			if(data_.billDetail.sellPayments[i].couponGroup=='01'){
				var inputTab3 = tab[i];
				data_.billDetail.sellPayments[i].money=parseFloat($(inputTab3).val());
			}
		}		
	}
	var da = JSON.stringify(data_); 
//	var userName = "${username}";
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
		$("#pageBody").load(__ctxPath+"/jsp/order/ReturnApplyView2.jsp");
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
													 <table class="table-striped table-hover table-bordered" id="olv_tab12" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">商品编号</th>
				                                                <th width="2%" style="text-align: center;">商品名称</th>
				                                                <th width="2%" style="text-align: center;">商品价格</th>
				                                                <th width="2%" style="text-align: center;">销售金额</th>
				                                                <th width="2%" style="text-align: center;">数量</th>
				                                                <th width="2%" style="text-align: center;">可退数量</th>
				                                                <th width="2%" style="text-align: center;">退货数量</th>
				                                                <th width="2%" style="text-align: center;">退货原因</th>
				                                                <th width="4%" style="text-align: center;">退货图片</th>
				                                                <th width="2%" style="text-align: center;">备注</th>
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        	
				                                        </tbody>
				                                    </table>&nbsp;
												</div>&nbsp;
												<p style="display:none">
													<textarea id="product-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.list as Result}
																<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px;">
																	<td align="center" id="supplyProductNo_{$T.Result.sid}">
																		{#if $T.Result.supplyProductNo != '[object Object]'}{$T.Result.supplyProductNo}
										                   				{#/if}
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
												<div id="isCodId" class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>退货退款账号信息</strong>
													</h5>
													</div>
													&nbsp;
													<div class="form-group">
														<div class="col-md-4">
															<label class="col-lg-4 col-sm-3 col-xs-3 control-label">开户行：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6">
																<input type="text" id="bankName" name="bankName"/>
															</div>											
														</div>
														
														<div class="col-md-4">
															<label class="col-lg-4 col-sm-3 col-xs-3 control-label">开户账号：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6">
																<input type="text" id="bankNumber" name="bankNumber"/>
															</div>											
														</div>
														
														<div class="col-md-4">
															<label class="col-lg-4 col-sm-3 col-xs-3 control-label">持卡人：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6">
																<input type="text" id="bankUser" name="bankUser"/>
															</div>											
														</div>
													
													</div>
												</div>&nbsp;
												
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
															</select>
															</div>											
														</div>
													
														<!-- <div class="col-md-6">
															<label class="col-lg-4 col-sm-3 col-xs-3 control-label">退货仓库地址：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6">
																<input type="text" id="address" name="address"/>
															</div>											
														</div> -->
													</div>
												</div>&nbsp;
												
												&nbsp;
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
															{#if $T.Result.flag == '3'}
																<tr class="gradeX" id="gradeX_{$T.Result.rowNo}" style="height:35px;">
																	<td align="center" id="payName_{$T.Result.rowNo}">
																		{#if $T.Result.payName != '[object Object]'}{$T.Result.payName}
										                   				{#/if}
																	</td>
																	<td align="center" id="money_{$T.Result.rowNo}">
																	<input id="moneys_{$T.Result.rowNo}" onkeyup="this.value=this.value.replace(/[^\-?\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\-?\d.]/g,'')" align="center" class="amounttui" value="{#if $T.Result.money != '[object Object]'}{$T.Result.money}
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
																	<td align="center" id="2payCode_{$T.Result.rowNo}">
																		{#if $T.Result.payCode != '[object Object]'}{$T.Result.payCode}
										                   				{#/if}
																	</td>
																	<td align="center" id="payName_{$T.Result.rowNo}">
																		{#if $T.Result.payName != '[object Object]'}{$T.Result.payName}
										                   				{#/if}
																	</td>
																	<td align="center" id="2amount_{$T.Result.rowNo}">
																		{#if $T.Result.amount != '[object Object]'}{$T.Result.amount}
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
														<span>实退金额：</span>
														<label id="amount1" class="control-label"></label>
														</div>&nbsp;
													</div>&nbsp;
													<div class="col-md-12">
														<div class="col-md-4">
														<span>&nbsp;&nbsp;其中,应退金额：</span>
														<label id="amount2" class="control-label"></label>
														</div>
														<!-- <div class="col-md-4">
														<div >
															<label>是否退运费：</label>
																<select  id="isRefundFee" name="isRefundFee">
																<option value="否">否</option>
																<option value="是">是</option>
																</select>
															</div>	
														</div> -->
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
															<input id="refundFee" type="refundFee" onkeyup="refundFeeTrim()">
															<span id="xzspan" style="color: red;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;应退运费金额输入不能大于订单支付运费金额</span>
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
													<div class="col-md-12">
														<div class="col-md-6">
														<span>&nbsp;&nbsp;扣款金额：</span>
														<label id="amount5" class="control-label"></label>
														</div>&nbsp;
													</div>&nbsp;
												</div>&nbsp;
												<div style="display: none;">
												</div>&nbsp;
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<!-- <input class="btn btn-success" style="width: 20%;" id="jess" type="button" value="金额试算" /> -->
														<input class="btn btn-danger" style="width: 20%;" id="shtg" type="button" value="审核通过" />
														<input class="btn btn-success" style="width: 20%;" id="shbtg" type="button" value="审核不通过" /> 
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