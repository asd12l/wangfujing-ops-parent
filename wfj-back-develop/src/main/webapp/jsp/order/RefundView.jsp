<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<!--Bootstrap Date Picker-->
<script
	src="${ctx}/assets/js/datetime/bootstrap-datepicker.js"></script>
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
<title>退货申请单展示页面（签收退货）</title>
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

	__ctxPath = "${ctx}";

	//--Bootstrap Date Picker--
	//查促销,返回信息
	var refundApplyNo =refundApplyNo_;
	var shoppeProName =shoppeProName_;
	var supplyProductNo =supplyProductNo_;
	var salePrice =salePrice_;
	var refundNum = saleSum2;
	var orderNo = orderNo_;
	/* var data2 = orderData; */
	var data_;
//	$("#amount1").text(salePrice*refundNum);
	var returnShippingFee; //订单支付运费金额(从订单上获取16-7-1改)
	var isCod;
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
					returnShippingFee = response.data.list[0].needSendCost;
					if(returnShippingFee==undefined){
						returnShippingFee=0;
					}
					console.log("returnShippingFee:"+returnShippingFee);
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
				$("#olv_tab121 tbody").setTemplateElement("gift-list").processTemplate(response);
			}
			$("#packimgUrl").val(response.packimgUrl);//域名赋值
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
			$("#amount1").text(parseFloat(totalPrice));
			
		}
	});
	// 初始化
	$("#pid").val(problemDesc);
	$(function() {
		$("#xzspan").hide();
		//退货原因
		
		/* var pid = $("#pid");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=refundReason",
			dataType: "json",
			success: function(response) {
				var result = response;
				for ( var i = 0; i < result.list.length; i++) {
					var ele = result.list[i];
					var option;
					if(pid == ele.codeValue){
						option = $("<option selected='selected' groupSid='" + ele.codeValue + "' value='" + ele.sid + "'>"
								+ ele.codeName + "</option>");
					}else{
						option = $("<option groupSid='" + ele.codeValue + "' value='" + ele.sid + "'>"
								+ ele.codeName + "</option>");
					}
					option.appendTo(pid);
				}
				return;
			}
		}); */
		var pid = $("#pid");
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=refundReason",
				dataType: "json",
				success: function(response) {
					var result = response;
					var codeValue = $("#pid");
					for ( var i = 0; i < result.list.length; i++) {
						var ele = result.list[i];
						var option;
						if(problemDesc== ele.codeValue){
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
		//退货方式
		$("#refundType").one("click",function(){
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
		});
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
		
		$("#t1").text(supplyProductNo1);
		$("#t2").text(shoppeProName1);
		$("#t3").text(salesPrice1);
		$("#t5").text(saleSum1);
		$("#t6").text(saleSum2);
		
		$("#remark").text(callCenterComments);
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
				"refundNum15" : saleSum2
			},
			dataType : "json",
			
			success : function(response) {
				if(response.success=='true'){
					data_ = response.data;
					
					$("#amount2").text(data_.billDetail.factPay);
					$("#supplyProductNo").text(supplyProductNo);
					$("#shoppeProName").text(shoppeProName);
					$("#salePrice").text(salePrice);
					$("#refundNum").text(refundNum);
					/* $("#num").text(data2); */
					$("#payPrice").text(salePrice*refundNum);
					
					var len = data_.billDetail.sellDetails.length;
					var discount = 0;
					for(var i=0; i<len; i++){
						discount += data_.billDetail.sellDetails[i].totalDiscount;
					}
					if(isNaN(discount)){
						$("#amount4").text("");
					}else{
						$("#amount4").text(parseFloat(discount).toFixed(2));
					}
					//应退金额计算
					var a1 = salePrice*refundNum;
//					$("#amount1").text(a1);
//					$("#amount2").text(a1);
					
					$("#orderNo").text(orderNo);
//					$("#supplyProductNo1").text(supplyProductNo);
//					$("#shoppeProName1").text(shoppeProName);
//					$("#salePrice1").text(salePrice);
//					$("#refundNum1").text(refundNum);
//					alert(成功,赋值);
					var datas = response.data;

					$("#olv_tab2 tbody").setTemplateElement("fanquan-list").processTemplate(datas);
					$("#olv_tab4 tbody").setTemplateElement("refund-list").processTemplate(datas);
					$("#olv_tab5 tbody").setTemplateElement("jifen-list").processTemplate(datas);
					$("#olv_tab6 tbody").setTemplateElement("Aquan-list").processTemplate(datas);
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"查询营销失败"+"</strong></div>");
 	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
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
				$("#amount5").text(parseFloat(t2).toFixed(2));
			},
			error : function() {
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"查询营销失败"+"</strong></div>");
	     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
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
//			$("#amount4").text(parseFloat(t2));
//			$("#amount5").text(parseFloat(t2));	
		});	
		//运费校验
		function refundFeeTrim(){
			var refundFeess = $("#refundFee").val();
//			console.log("refundFeess:"+refundFeess);
//			console.log("returnShippingFee:"+returnShippingFee);
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
		//审核通过
		function shtgForm(){
			//从页面中拿值，传参数
			 
			var tab=$(".amounttui");
			if(0<tab.length){
				console.log(tab.length);
				for(var i = 0; i<tab.length; i++){
					if(data_.billDetail.sellPayments[i].flag=='3'){
						var inputTab = tab[i];
						data_.billDetail.sellPayments[i].money=parseFloat($(inputTab).val());
					}
	//				alert($(inputTab).val());
	//				alert(data_.billDetail.sellPayments[i].amount);
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
			var userName = "${username}";
			var rety = $("#refundType").val();
//			var addr = $("#address").val();
			/* var refundReason = $("#refundReason").val(); */
			var refundReason = $("#pid").val();
//			var refundTarget = $("#refundTarget").val();
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
				data:{bankName:"bankName",bankNumber:"bankNumber",bankUser:"bankUser","jj":da,"refundFee":refundFee,"latestUpdateMan":userName,"refundStatus":"4","refundReason":refundReason,"refundType":rety/* ,"address":addr */},
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
		//审核不通过
		function shbtgForm(){
			//从页面中拿值，传参数
			 
			var tab=$(".amounttui");
			if(0<tab.length){
				for(var i = 0; i<tab.length; i++){
					var inputTab = tab[i];
					data_.billDetail.sellPayments[i].money=parseFloat($(inputTab).val());
	//				alert($(inputTab).val());
	//				alert(data_.billDetail.sellPayments[i].amount);
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
		//关闭页面
		$("#close").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/order/saleOrderListView2.jsp");
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
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/order/saleOrderListView2.jsp");
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
													<hr class="wide" style="margin-top: 0;">
													 <table class="table-striped table-hover table-bordered" id="olv_tab12" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">商品编号</th>
				                                                <th width="2%" style="text-align: center;">商品名称</th>
				                                                <th width="1%" style="text-align: center;">商品价格</th>
				                                                <th width="1%" style="text-align: center;">销售金额</th>
				                                                <th width="1%" style="text-align: center;">数量</th>
				                                                <th width="1%" style="text-align: center;">退货数量</th>
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        	<!-- <tr>
				                                        		<td align="center" id="supplyProductNo"></td>
				                                        		<td align="center" id="shoppeProName"></td>
				                                        		<td align="center" id="salePrice"></td>
				                                        		<td align="center" id="payPrice"></td>
				                                        		<td align="center" id="num"></td>
				                                        		<td align="center" id="refundNum"></td>
				                                        	</tr> -->
				                                        </tbody>
				                                    </table>&nbsp;
												</div>&nbsp;
												<p style="display:none">
													<textarea id="product-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.list as Result}
															{#if $T.Result.isGift == '0'}
																<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px;">
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
										                   				{#/if}
																	</td>
																	<td align="center" id="refundSalePrice_{$T.Result.sid}">
																		{#if $T.Result.refundSalePrice!= '[object Object]'}{$T.Result.refundSalePrice}
										                   				{#/if}
																	</td>
																	<td align="center" id="refundNumAll_{$T.Result.sid}">
																		{#if $T.Result.refundNumAll != '[object Object]'}{$T.Result.refundNumAll}
										                   				{#/if}
																	</td>
																	<td align="center" class="refundNumClass" id="refundNum_{$T.Result.sid}">
																		{#if $T.Result.refundNum != '[object Object]'}{$T.Result.refundNum}
										                   				{#/if}
																	</td>
													       		</tr>
															{#/if}
															{#/for}
													    {#/template MAIN}	-->
													</textarea>
												</p>
											<!-- 	<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>退货理由</strong>
													</h5>
													</div>
													<hr class="wide" style="margin-top: 0;">
													<div class="form-group">
														<div class="col-md-6">
															<label class="col-lg-3 col-sm-3 col-xs-3 control-label">退货原因：</label>
															<select class="col-lg-6 col-sm-6 col-xs-6" id="pid" name="pid" readonly="readonly"></select>
														</div>
													
														<div class="col-md-6">
															<label class="col-lg-3 col-sm-3 col-xs-3 control-label">备注：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6">
																<textarea id="remark" style="width: 500px;height: 240px;max-width: 300px;max-height: 100px;min-width: 200px;min-height: 100px;resize: none" id="comments" name="comments" placeholder="非必填"></textarea>
															</div>											
														</div>
													</div>
												</div> -->
												&nbsp;
												
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
													<hr class="wide" style="margin-top: 0;">
													<div class="form-group">
														<div class="col-md-6">
															<label class="col-lg-3 col-sm-3 col-xs-3 control-label">退货方式：</label>
															<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 230px;">
																<select class="form-control" id="refundType" name="refundType">
																<option value="" selected="selected">请选择</option>
																<!-- <option value="上门取货">上门取货</option> -->
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
												</div>
												&nbsp;
												
												<div class="col-md-12">
													<div class="widget-body" style="padding: 2px;">
													<h5>
														<strong>订单赠品信息</strong>
													</h5>
													</div>
													<hr class="wide" style="margin-top: 0;">
													 <table class="table-striped table-hover table-bordered" id="olv_tab121" style="width: 90%;background-color: #fff;margin-bottom: 0;">
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
				                                        	<!-- <tr>
				                                        		<td align="center" id="orderNoZengping"></td>
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
													<hr class="wide" style="margin-top: 0;">
													 <table class="table-striped table-hover table-bordered" id="olv_tab4" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">原因</th>
				                                                <th width="2%" style="text-align: center;">扣款额</th>
				                                                <th width="1%" style="text-align: center;">扣款说明</th>
				                                                
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        	
				                                        </tbody>
				                                    </table>&nbsp;
												</div>&nbsp;
												<p style="display:none">
													<textarea id="refund-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.billDetail.sellPayments as Result}
															{#if $T.Result.flag == '3'}
																<tr class="gradeX" id="gradeX{$T.Result.rowNo}" style="height:35px;">
																	<td align="center" id="payName_{$T.Result.rowNo}">
																		{#if $T.Result.payName != '[object Object]'}{$T.Result.payName}
										                   				{#/if}
																	</td>
																	<td align="center" id="money_{$T.Result.rowNo}">
																	<input align="center" class="amounttui" value="{#if $T.Result.money != '[object Object]'}{$T.Result.money}
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
													<hr class="wide" style="margin-top: 0;">
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
																	<td align="center" id="1couponBalance_{$T.Result.rowNo}">
																		{#if $T.Result.couponBalance != '[object Object]'}{$T.Result.couponBalance}
										                   				{#/if}
																	</td>
																	<td align="center" id="1money_{$T.Result.rowNo}">
																		<input align="center" class="amountjifen2" value="{#if $T.Result.money != '[object Object]'}{$T.Result.money}
										                   				{#/if}"/>
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
													<hr class="wide" style="margin-top: 0;">
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
												</div>
												&nbsp;
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
																	<td align="center" id="2payName_{$T.Result.rowNo}">
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
													</div>
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
														</div>
														&nbsp;
													</div>
													<div class="col-md-12">
														<div class="col-md-6">
														<span>&nbsp;&nbsp;优惠金额合计：</span>
														<label id="amount4" class="control-label"></label>
														</div>
														&nbsp;
													</div>
													<div class="col-md-12">
														<div class="col-md-6">
														<span>&nbsp;&nbsp;扣款金额：</span>
														<label id="amount5" class="control-label"></label>
														</div>
														&nbsp;
													</div>
												</div>
												<div style="display: none;">
												</div>
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
</body>
</html>