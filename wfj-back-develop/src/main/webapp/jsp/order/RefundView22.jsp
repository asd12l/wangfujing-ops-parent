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
	#refundFee{
		font-size: 15px;
		height: 38px;
	}
	/*#address{
		font-size: 14px;
		height: 4px;
	}
	 #refundType{
		font-size: 14px;
		height: 4px;
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
	var returnShippingFee = returnShippingFee_;
	
	var refundApplyNo = refundApplyNo_;
	var orderNo = orderNo_;
	var refundReasionDesc = problemDesc_;
	var callCenterComments = callCenterComments_;
	var refundNum = refundNum_;
//	var data2 = orderData;
	var data_;
	/* //退货方式
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
			}); */
	//审核查询营销
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/testOnlineOmsOrder/selectRefundApplyAll",
		async : false,
		data : {
			"refundApplyNo" : refundApplyNo,
			"orderNo" : orderNo,
			"orderItemNo" : orderNo+"-1", //多余没用
			"refundNum15" : refundNum
		},
		dataType : "json",
		
		success : function(response) {
			if(response.success=='true'){
				data_ = response.data;
				
//				$("#amount2").text(data_.refundAmount);
				$("#amount2").text(parseFloat(data_.refundAmount).toFixed(2));
				var len = data_.deduction.length;
				var discount = 0;
				for(var i=0; i<len; i++){
					discount += data_.deduction[i].totalDiscount;
				}
				
//				$("#amount4").text(parseFloat(discount));优惠金额
//				se = $(selectRefundPromotion);
//				se = session.getAttribute("selectRefundPromotion");
//				se = request.getsession().getAttribute("selectRefundPromotion");
				rowNo_ = data_.deduction.length;
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
	var refundType ;
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
				expressCompanyName = response.list[0].expressCompanyName;//快递公司
				courierNumber = response.list[0].courierNumber;//快递单号
				address = response.list[0].warehouseAddress;//退货地址
				
				/* $("#refundType").text(refundType) */;
				$("#expressCompanyName").val(expressCompanyName);
				$("#courierNumber").val(courierNumber);
				$("#warehouseAddress").val(address);
			} 
		}
	});
	//退货方式
	$("#refundType").val(refundType);
	console.log("refundType:"+refundType);
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
						if(refundType== ele.codeValue){
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
	$.ajax({
		type : "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url:__ctxPath + "/omsOrder/selectRefundApplyItemList",
		async:false,
		dataType: "json",
		data:{"refundApplyNo":refundApplyNo},
		success : function(response) {
			if (response.success == "true") {
				if (response.success == "true") {
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
//					$("#amount1").text(parseFloat(totalPrice));
				}
				/* supplyProductNo = response.list[0].supplyProductNo;
				shoppeProName = response.list[0].shoppeProName;
				salePrice = response.list[0].salePrice;
				refundNum = response.list[0].refundNum;
				refundPcitureUrl = response.list[0].refundPcitureUrl;
				$("#supplyProductNo").text(supplyProductNo);
				$("#shoppeProName").text(shoppeProName);
				$("#salePrice").text(salePrice);
				$("#payPrice").text(salePrice*refundNum);
				$("#refundNum").text(refundNum);
				$("#refundReasionDesc").text(refundReasionDesc);
				$("#refundPcitureUrl").text(refundPcitureUrl);
//				$("#refundReasionDesc").text(refundReasionDesc);
				$("#callCenterComments").text(callCenterComments);
				
				$("#allowNum").text(data2);
				$("#num").text(data2);
				//应退金额计算
				var a1 = salePrice*refundNum;
				$("#amount1").text(salePrice*refundNum);
//				$("#amount2").text(a1);
				
				$("#orderNo").text(orderNo);
//				$("#supplyProductNo1").text(supplyProductNo);
//				$("#shoppeProName1").text(shoppeProName);
//				$("#salePrice1").text(salePrice);
//				$("#refundNum1").text(refundNum); */
			} 
			
			//扣款金额计算
			var ta=document.getElementById("olv_tab4");//$("#olv_tab4");
			var t1 = 0;
			var t2 = 0;
			var rows = ta.rows;
			for(var i = 1; i<rows.length; i++){
				t1 = rows[i].cells[1].innerHTML;
				t2 +=parseFloat(t1);
			}
//			$("#amount4").text(parseFloat(t2));
//			$("#amount4").text($("#amount1").text()-$("#amount2").text());
			$("#amount4").text(parseFloat($("#amount1").text()-$("#amount2").text()).toFixed(2));
			$("#amount5").text(parseFloat(t2));
			
			/* var a2=0;
			var rowNo=rowNo_;
				//循环拿到扣款额 id为amount_rowNo自加
			for(var i=1; rowNo>=i; i++){
				a2=$("#amount_"+i).text();
				a2++;
			} */
		}
	});
	
	// 初始化
	$(function() {
		//退运费
		if(returnShippingFee==""){
			$("#isRefundFee").text("否");
		}else{
			$("#isRefundFee").text("是");
		}
		$("#refundFee").text(returnShippingFee);
		/* $("#refundFee").hide();
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
		}); */
		//提交（修改物流信息）
		$("#tijiao").click(function() {
			tijiaoForm();
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
	//金额试算
	/* $("#jess").click(function() {
		var ta=$(".amounttui");
		var t1 = 0;
		var t2 = 0;
		for(var i = 0; i<ta.length; i++){
			var t = ta[i];
			t1= $(t).val();
			t2 +=parseFloat(t1);
		}
		$("#amount4").text(parseFloat(t2));
		$("#amount5").text(parseFloat(t2));	
	}); */	
	
	function tijiaoForm(){
		//修改退货申请单 加上物流信息
		var expressCompanyName = $("#expressCompanyName").val();
		var courierNumber = $("#courierNumber").val();
		var warehouseAddress = $("#warehouseAddress").val();
		$.ajax({
			type : "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/updateRefundApply",  //修改退货申请单（更新物流信息）
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
			data:{"refundApplyNo":refundApplyNo,"expressCompanyName":expressCompanyName,"courierNumber":courierNumber,"warehouseAddress":warehouseAddress},
			success : function(response) {
				if (response.success == "true") {
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><strong>修改成功！</strong></div>");
		     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.data.errorMsg+"</strong></div>");
		     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
			},
			error : function() {
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.data.errorMsg+"</strong></div>");
	     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
		});
	}
	//审核通过
function shtgForm(){
	//从页面中拿值，传参数
	//退货扣款
	/* var tab=$(".amounttui");
	if(0<tab.length){
		for(var i = 0; i<tab.length; i++){
			var inputTab = tab[i];
			data_.billDetail.sellPayments[i].amount=parseFloat($(inputTab).val());
	//		alert($(inputTab).val());
	//		alert(data_.billDetail.sellPayments[i].amount);
		}	
	} */
	//积分信息
	/* var tab=$(".amountjifen");
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
	} */
	var da = JSON.stringify(data_); 
	var userName = "${username}";
	var rety = $("#refundType").val();
	var addr = $("#warehouseAddress").val();
	
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
				/* $("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"审核失败"+"</strong></div>"); */
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.data.errorMsg+"</strong></div>");
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
	 
	/* var tab=$(".amounttui");
	if(0<tab.length){
		for(var i = 0; i<tab.length; i++){
			var inputTab = tab[i];
			data_.billDetail.sellPayments[i].amount=parseFloat($(inputTab).val());
	//		alert($(inputTab).val());
	//		alert(data_.billDetail.sellPayments[i].amount);
		}
	} */
	//积分信息
	/* var tab=$(".amountjifen");
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
	} */
	var da = JSON.stringify(data_); 
	var userName = "${username}";
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
																<label id="address"></label>
															</div>											
														</div> -->
													</div>
												</div>&nbsp;
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>退货物流信息</strong>
													</h5>
													</div>
													&nbsp;
													<div>&nbsp;&nbsp;
														<label>快递公司：</label>
														&nbsp;<input type="text" id="expressCompanyName" name="expressCompanyName"/>
														&nbsp;&nbsp;<label>快递单号：</label>
														&nbsp;<input type="text" id="courierNumber" name="courierNumber"/>
														&nbsp;&nbsp;<label>退货地址：</label>
														&nbsp;<input type="text" id="warehouseAddress" name="warehouseAddress"/>
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<input id="tijiao" type="button" value="提交" />	
													</div>
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
															{#foreach $T.deduction as Result}
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
															{#foreach $T.deduction as Result}
															{#if $T.Result.couponGroup == '02'&&$T.Result.flag == '2'}
																<tr class="gradeX" id="gradeX{$T.Result.rowNo}" style="height:35px;">
																	<td align="center" id="payName_{$T.Result.rowNo}">
																		{#if $T.Result.payName != '[object Object]'}{$T.Result.payName}
										                   				{#/if}
																	</td>
																	<td align="center" id="2payType_{$T.Result.rowNo}">
																		{#if $T.Result.payType != '[object Object]'}{$T.Result.payType}
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
														<div class="col-md-4">
														<div >
															<label class="control-label">是否退运费：</label>
																<label id="isRefundFee" class="control-label"></label>
															</div>	
														</div>
														<!-- <div class="col-md-4">
														<label class="col-md-5 control-label">是否退运费:</label>
														<div class="col-md-7">
															<label class="control-label"> <input
																type="checkbox" id="isRefundFee" value="yes"
																class="checkbox-slider toggle yesno"> <span
																class="text"></span>
															</label> <input type="hidden" id="type" name="type" value="1">
														</div>
														&nbsp;
													</div> -->
													<div class="col-md-4">
														<span>应退运费金额：</span>
														<label id="refundFee" class="control-label"></label>
													</div>
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
														 
														<input class="btn btn-danger" style="width: 20%;" id="close" type="button" value="返回" />
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