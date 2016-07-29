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
	#amount6{
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
	/* #amount5{
		font-size: 15px;
		height: 38px;
	} */
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
	
	var datas = data_;
	$("#olv_tab4 tbody").setTemplateElement("refund-list").processTemplate(datas);
	$("#olv_tab5 tbody").setTemplateElement("jifen-list").processTemplate(datas);
	$("#olv_tab2 tbody").setTemplateElement("fanquan-list").processTemplate(datas);
	$("#olv_tab6 tbody").setTemplateElement("Aquan-list").processTemplate(datas);
	
	if(datas.refundStatus=="03" || datas.refundStatus=="04" || datas.refundStatus=="12" || datas.refundStatus=="15"){
		$("#refundProductStatus").text("已入库");
	}else{
		$("#refundProductStatus").text("未入库");
	}
	var reMonStatus =reMonStatus_;
	if(reMonStatus=='1'){
		$("#qrtk").attr("disabled", "true");
	}else{
		$("#qrtk").removeAttr("disabled");
	}
	// 初始化
	$(function() {
		var refundApplyNo = applyNo_;
		$.ajax({
			type : "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/selectRefundApplyItemList",
			async:false,
			dataType: "json",
			data:{"refundApplyNo":refundApplyNo},
			success : function(response) {
				/* if (response.success == "true") {
					$("#olv_tab12 tbody").setTemplateElement("products-list").processTemplate(response);
					$("#olv_tab121 tbody").setTemplateElement("gift-list").processTemplate(response);
				} */
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
				/* $("#amount1").text(parseFloat(totalPrice).toFixed(2)); 16-7-9 一*/
			}
		});
		
		//通过退货单号查询信息
		var refundNo = refundNo_;
		var returnType;
		
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
						$("#olv_tab12 tbody").setTemplateElement("products-list").processTemplate(response);
						$("#olv_tab121 tbody").setTemplateElement("gift-list").processTemplate(response);
					}
//					$("#packimgUrl").val(response.packimgUrl);//域名赋值
				}
				return;
			}
		});
		$.ajax({
			type : "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/oms/selectRefundList",
			async:false,
			dataType: "json",
			data:{"refundNo":refundNo,"page":1},
			success : function(response) {
				if (response.success == "true") {
					var warehouseAddress=response.list[0].warehouseAddress;//退货仓库地址
					returnType = response.list[0].refundPath; //退货方式
					var expressCompanyName = response.list[0].expressCompanyName; //快递公司
					var courierNumber = response.list[0].courierNumber; //快递单号
					$("#t1").text(expressCompanyName);
					$("#t2").text(courierNumber);
					$("#t3").text(warehouseAddress);
					var refundAmount = response.list[0].refundAmount; //应退金额
					/* $("#amount2").text(refundAmount);16-7-9 二    */
					var refundApplyNo_ =  response.list[0].refundApplyNo;
					var returnShippingFee_ =  response.list[0].returnShippingFee;
					console.log(returnShippingFee_);
//					var refundAmount_ =  response.list[0].refundAmount;
					var quanAmount =  response.list[0].quanAmount;
					var paymentAmountSum = response.list[0].paymentAmountSum;
					if(""==refundApplyNo){
						//EDI自动退的没有退货申请单号
						if(isNaN(parseFloat(refundAmount))){
							$("#amount1").text(parseFloat(0).toFixed(2));
						}else{
							$("#amount1").text(parseFloat(refundAmount).toFixed(2));
						}
							$("#amount2").text(parseFloat(0).toFixed(2));
							$("#amount3").text(parseFloat(quanAmount).toFixed(2));
							$("#amount4").text(parseFloat(parseFloat(refundAmount)-quanAmount).toFixed(2));
							$("#amount6").text(parseFloat(parseFloat($("#amount1").text()).toFixed(2)-parseFloat($("#amount3").text()).toFixed(2)).toFixed(2));
					}else{
						
						$("#amount2").text(parseFloat(0).toFixed(2));
						$("#amount3").text(parseFloat(quanAmount).toFixed(2));
						if(isNaN(parseFloat(returnShippingFee_))){
							$("#amount1").text(parseFloat(refundAmount).toFixed(2));
							//$("#amount4").text(parseFloat(parseFloat(refundAmount)-quanAmount).toFixed(2));
						}else{
							$("#amount1").text((parseFloat(refundAmount)-parseFloat(returnShippingFee_)).toFixed(2));
							//$("#amount4").text(parseFloat(parseFloat(refundAmount)+parseFloat(returnShippingFee_)-quanAmount).toFixed(2));
						}
						$("#amount4").text(parseFloat(parseFloat(refundAmount)-quanAmount).toFixed(2));
						$("#amount6").text(parseFloat(parseFloat($("#amount1").text()).toFixed(2)-parseFloat($("#amount3").text()).toFixed(2)).toFixed(2));
					}
				}
				
			}
		});
		/* $("#amount4").text($("#amount1").text()-$("#amount2").text());//优惠金额目前是amount1-amount2 16-7-9 三*/
		$("#refundType").val(returnType);
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
	});

		//修改退款单状态
		var refundMonNo = refundMonNo_;
		var userName = getCookieValue("username");
		$("#qrtk").click(function() {
			$.ajax({
				type : "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url:__ctxPath + "/omsOrder/updataRefundMonStatus",
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
				data:{"refundMonNo":refundMonNo,"userName":userName},
				success : function(response) {
					if (response.success == "true") {
						$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>确认成功，返回列表页!</strong></div>");
			     	  	$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
					}else{
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><strong>"+response.data.errorMsg+"</strong></div>");
			     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					}
				},
				error : function() {
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"系统错误"+"</strong></div>");
		     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
			});
			
//			$("#pageBody").load(__ctxPath + "/jsp/order/RefundMonListView.jsp");
		});
		//关闭
		$("#close").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/order/RefundMonListView.jsp");
		});
		$("#rightclose").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		});
		$("#loading-container").addClass("loading-inactive");
		$("#productQuery").attr("disabled", "disabled");
		$("#resetQuery").attr("disabled", "disabled");
		$("#pageSelect").change(productQuery);
		

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
	// SKU数据
	function initProduct(spuCode) {
		productPagination = $("#productPagination").myPagination(
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
						url : __ctxPath + "/product/selectAllProduct",
						dataType : 'json',
						param : 'spuCode=' + $("#spuCode_from").val(),
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						callback : function(data) {
							$("#product_tab tbody").setTemplateElement(
									"product-list").processTemplate(data);
							for(var i=0;i<data.list.length;i++){
								if(data.list[i].spuCode == spuCode){
									$("#spuSid_from").val(data.list[i].spuSid);
								}
							}
						}
					}
				});
	}
	// 属性下拉框事件
	function valueSelectClick(data, valueSid) {
		// 赋值
		$("#valueSid_" + data).val(valueSid);
		$("#valueName_" + data).val($("#valueSidSelect_" + data).val());
	}
	// 属性文本框事件
	function valueInputChange(propSid) {
		// 赋值
		$("#valueSid_" + propSid).val(null);
		$("#valueName_" + propSid).val($("#valueInput_" + propSid).val());
	}
	
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/order/RefundMonListView.jsp");
	}
</script>
<!-- 经营方式和要约事件 -->
<script type="text/javascript">
	/* ERP集合 */
	var erpList;
	//经营方式点击
	 function manageTypeFunct() {
		//$("#divOfferNumber").show();
		var manageType = $("#manageType").val();
		/* if (manageType == -1) {
			$("#divOfferNumber").hide();
			$("#divInputTax").hide();
			$("#divOutputTax").hide();
			$("#divConsumptionTax").hide();
			$("#divRate").hide();
			return;
		} */
		var storeCode = $("#proShopCode").find("option:selected").attr(
				"storeCode");
		var supplyCode = $("#supplierCode").find("option:selected").attr(
				"supplyCode");
		$("#offerNumber").html("");
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/product/selectContractByParams",
					dataType : "json",
					async : false,
					ajaxStart : function() {
						$("#loading-container").prop("class",
								"loading-container");
					},
					ajaxStop : function() {
						$("#loading-container").addClass("loading-inactive");
					},
					data : {
						"storeCode" : storeCode,
						"supplyCode" : supplyCode,
						"manageType" : manageType,
						"shoppeCode" : $("#counterCode").find("option:selected").attr("counterCode")
					},
					success : function(response) {
						if (response.success == 'true') {
							if (response.data[0] != "") {
								erpList = response.data.erpList;
								var option = "<option value='-1'>请选择</option>";
								for (var i = 0; i < response.data.contractList.length; i++) {
									var ele = response.data.contractList[i];
									option += "<option commissionRate='"+ele.commissionRate+"' outputTax='"+ele.outputTax+"' inputTax='"+ele.inputTax+"' value='"+ele.contractCode+"'>"
											+ ele.contractCode + "</option>";
								}
								$("#offerNumber").append(option);
							} else {
								$("#warning2Body").text("查询失败");
								$("#warning2").show();
							}
						} else {
							$("#warning2Body").text("查询失败");
							$("#warning2").show();
						}
					}
				});
		
	} 
	// 要约号改变事件
	function offerNumberChange() {
		$("#erpProductCode").html("");
		var option = "<option value='-1'>请选择</option>";
		for (var i = 0; i < erpList.length; i++) {
			var ele = erpList[i];
			option += "<option commissionRate='"+ele.commissionRate+"' value='"+ele.productCode+"'>"
					+ ele.productCode + "</option>";
		}
		$("#erpProductCode").append(option);

		var manageType = $("#manageType").val();
		var inputTax = $("#offerNumber").find("option:selected").attr(
				"inputTax");
		var outputTax = $("#offerNumber").find("option:selected").attr(
				"outputTax");
		if (manageType == 2 && $("#YTtype").val() == 0) {// 百货联营
			$("#inputTax").val("");
			$("#outputTax").val("");
			$("#consumptionTax").val("");
		} else {
			$("#inputTax").val(inputTax);
			$("#outputTax").val("");
			$("#consumptionTax").val(outputTax);
		}
	}
	/* ERP编码改变 */
	function erpProductCodeChange() {
		var commissionRate = $("#erpProductCode").find("option:selected").attr(
				"commissionRate");
		$("#rate").val(commissionRate);
	}
</script>
<!-- base保存控制 -->
<script type="text/javascript">
	//属性属性值提交数据
	function inTJson() {
		var propName = new Array();
		var propSid = new Array();
		var valueSid = new Array();
		var valueName = new Array();
		var parameters = new Array();
		// 整理属性名
		$("label[name='propName']").each(function(i) {
			propName.push($(this).text().replace("*", "").trim());
		});
		// 整理属性SID
		$("input[name='propSid']").each(function(i) {
			propSid.push($(this).val());
		});
		// 整理值SID
		$("input[name='valueSid']").each(function(i) {
			if ($(this).val() == "") {
				valueSid.push(null);
			} else {
				valueSid.push($(this).val());
			}
		});
		// 整理值名称
		$("input[name='valueName']").each(function(i) {
			valueName.push($(this).val());
		});
		for (var i = 0; i < parametersLength; i++) {
			if(valueSid[i] == -1){
				
			}else if(valueName[i] == ""){
				
			}else{
				parameters.push({
					'propSid' : propSid[i],
					'propName' : propName[i],
					'valueSid' : valueSid[i],
					'valueName' : valueName[i]
				});
			}
		}
		var inT = JSON.stringify(parameters);
		inT = inT.replace(/\%/g, "%25");
		inT = inT.replace(/\#/g, "%23");
		inT = inT.replace(/\&/g, "%26");
		inT = inT.replace(/\+/g, "%2B");
		return inT;
	}
	// SKU数据
	function skuJson() {
		var proColor = new Array();// 色系
		var colorCode = new Array();// 色码
		var sizeCode = new Array();// 规格
		if ($("#type").val() == 0) {// 百货
			$("input[name='baseTableTd_proColorSid']").each(function() {
				proColor.push($(this).val());
			});
			$("td[name='baseTableTd_colorCode']").each(function() {
				colorCode.push($(this).html().trim());
			});
			$("td[name='baseTableTd_sizeCode']").each(function() {
				sizeCode.push($(this).html().trim());
			});
			var json = new Array();
			for (var i = 0; i < proColor.length; i++) {
				json.push({
					'proColor' : proColor[i],
					'colorCode' : colorCode[i],
					'colorName' : colorCode[i],
					'sizeCode' : sizeCode[i]
				});
			}
			var inT = JSON.stringify(json);
			inT = inT.replace(/\%/g, "%25");
			inT = inT.replace(/\#/g, "%23");
			inT = inT.replace(/\&/g, "%26");
			inT = inT.replace(/\+/g, "%2B");
			return inT;
		} else {
			$("input[name='baseTableTd_proColorSid']").each(function() {
				if ($(this).val() > 100) {
					proColor.push(null);
				} else {
					proColor.push($(this).val());
				}
			});
			$("td[name='baseTableTd_featrues']").each(function() {
				colorCode.push($(this).html().trim());
			});
			$("td[name='baseTableTd_sizeCode']").each(function() {
				sizeCode.push($(this).html().trim());
			});
			var json = new Array();
			for (var i = 0; i < proColor.length; i++) {
				json.push({
					'proColor' : proColor[i],
					'features' : colorCode[i],
					'sizeCode' : sizeCode[i]
				});
			}
			var inT = JSON.stringify(json);
			inT = inT.replace(/\%/g, "%25");
			inT = inT.replace(/\#/g, "%23");
			inT = inT.replace(/\&/g, "%26");
			inT = inT.replace(/\+/g, "%2B");
			return inT;
		}
	}
	// 保存#baseFrom
	function baseFrom() {
		var message = requiredBaseForm();
		if (message == false) {
			return;
		}
		var inT = inTJson();
		var sku = skuJson();
		if (sku == '[]') {
			$("#warning2Body").text("请添加单品");
			$("#warning2").show();
			return;
		}
		$("#parameters").html(inT);
		$("#skuProps").html(sku);
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/product/addProduct",
					dataType : "json",
					async : false,
					ajaxStart : function() {
						$("#loading-container").prop("class",
								"loading-container");
					},
					ajaxStop : function() {
						$("#loading-container").addClass("loading-inactive");
					},
					data : $("#baseForm").serialize(),
					success : function(response) {
						if (response.success == 'true') {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'><strong>添加成功</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;z-index:9999;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							$("#spuCode_from").val(response.data);
							initProduct(response.data);
							$("#li_base").prop("class", " ");
							$("#base").prop("class", "tab-pane");
							$("#li_pro").addClass("active");
							$("#pro").addClass("active");
							$("#baseSave").prop("disabled", "disabled");
							// 保存成功置灰整个页面的按钮
							$("#shopCode").attr("disabled", "disabled");
							$("#type").attr("disabled", "disabled");
							$("#BrandCode").attr("disabled", "disabled");
							$("#baseA").attr("disabled", "disabled");
							$("#treeDown").attr("disabled", "disabled");
							$("#tjA").attr("disabled", "disabled");
							//$("#tjTreeDown").attr("disabled", "disabled");
							$("#productNum").attr("disabled", "disabled");/* 款号 */
							$("#mainAttribute").attr("disabled", "disabled");/* 主属性 */
							$("#TStype").attr("disabled", "disabled");/* 特殊属性 */
							$("#proTypeSid").attr("disabled", "disabled");/* 类型 */
							$(".sxz").each(function() {
								$(this).attr("disabled", "disabled");
							});
							$("#proColor").attr("disabled", "disabled");
							$("#colorCode").attr("disabled", "disabled");
							$("#sizeCode").attr("disabled", "disabled");
							$("#baseBtnGroup").attr("disabled", "disabled");
							$("#addSku").attr("disabled", "disabled");
							$("#deleteSku").attr("disabled", "disabled");
							$("#productQuery").removeAttr("disabled");
							$("#resetQuery").removeAttr("disabled");
							/* 放开234tab */
							$("#li_pro a").attr("data-toggle", "tab");
							$("#li_profile a").attr("data-toggle", "tab");
							$("#li_show a").attr("data-toggle", "tab");
							rightTreeDemo();
							$("#li_show a").click(function() {
								loadColors();
							});

							if ($("#type").val() == 0) {
								$("#TeShutype").html("色码");
							} else if ($("#type").val() == 1) {
								s
								$("#TeShutype").html("特性");
							}

						} else {
							$("#warning2Body").text(response.data.errorMsg);
							$("#warning2").show();
						}
						return;
					},
					error : function() {
						$("#warning2Body").text("系统出错");
						$("#warning2").show();
					}
				});
	}
</script>

<script type="text/javascript">
	/* 条码JSON数据生成 */
	function tmJson() {
		var tmCounts = 0;
		/* 产地list */
		var proTableTd_placeOfOrigin = new Array();
		/* 条码类型 */
		var tmlx = new Array();
		/* 条码编号list */
		var proTableTd_standardBarCode = new Array();
		var parameters = new Array();
		$("input[name='proTableTd_placeOfOrigin']").each(function(i) {
			if ($(this).val() != "") {
				proTableTd_placeOfOrigin.push($(this).val());
			} else {
				tmCounts++;
				return;
			}
		});
		$("select[name='tmlx']").each(function(i) {
			if ($(this).val() != "-1") {
				tmlx.push($(this).val());
			} else {
				tmCounts++;
				return;
			}
		});
		// 整理条码文本
		$("input[name='proTableTd_standardBarCode']").each(function(i) {
			if ($(this).val() != "") {
				proTableTd_standardBarCode.push($(this).val().trim());
			} else {
				tmCounts++;
				return;
			}
		});
		var inT;
		if (tmCounts == 0) {
			for (var i = 0; i < proTableTd_placeOfOrigin.length; i++) {
				parameters.push({
					'originLand' : proTableTd_placeOfOrigin[i],
					'type' : tmlx[i],
					'barcode' : proTableTd_standardBarCode[i]
				});
			}
			inT = JSON.stringify(parameters);
			inT = inT.replace(/\%/g, "%25");
			inT = inT.replace(/\#/g, "%23");
			inT = inT.replace(/\&/g, "%26");
			inT = inT.replace(/\+/g, "%2B");
		} else {
			inT = new Array();
		}
		return inT;
	}
	// pro保存
	function proForm() {
		var message = requiredProForm();
		// 整理条码
		var tm = tmJson();
		if (tm.length == 0) {
			$("#warning2Body").text("条码未填写或存在空值");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		$("#tmlist").val(tm);
		if (message == false) {
			return;
		}
		var manageType = $("#manageType").val();
		if ($("#type").val() == 0) {
			if ($("#productNum").val().trim() == "") {
				$("#warning2Body").text("款号没有填写");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return;
			}
		} else {
			if ($("#mainAttribute").val().trim() == "") {
				$("#warning2Body").text("主属性没有填写");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return;
			}
		}
		var urlPath = "";
		if($("#YTtype").val()==2){
			urlPath = "/product/saveShoppeProductDs";
		}else{
			urlPath = "/product/saveShoppeProduct";
		}
		
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + urlPath,
					dataType : "json",
					async : false,
					ajaxStart : function() {
						$("#loading-container").prop("class",
								"loading-container");
					},
					ajaxStop : function() {
						$("#loading-container").addClass("loading-inactive");
					},
					data : $("#proForm").serialize(),
					success : function(response) {
						var skuSid = $("#skuSid").val();
						if (response.success == 'true') {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'><strong>添加成功</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;z-index:9999;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							initShopp(skuSid);
							clearAll();
						} else {
							$("#warning2Body").text(response.data.errorMsg);
							$("#warning2").attr("style", "z-index:9999");
							$("#warning2").show();
						}
						return;
					},
					error : function() {
						$("#warning2Body").text("系统出错");
						$("#warning2").attr("style", "z-index:9999");
						$("#warning2").show();
					}
				});
	}
</script>

<script type="text/javascript">
	var tmCount = 0;
	//增加条码
	function addTM() {
		tmCount++;
		var option = "<tr id='proTableTr_"+tmCount+"'><td style='text-align: center;'>"
				+ "<div class='checkbox'>"
				+ "<label style='padding-left: 5px;'>"
				+ "<input type='checkbox' id='proTableTd_tmCount_"+tmCount+"' value='"+tmCount+"'  name='proTableTd_tmCount'>"
				+ "<span class='text'></span>"
				+ "</label>"
				+ "</div></td>"
				+ "<td style='text-align: center;'>"
				+ "<input type='text' name='proTableTd_placeOfOrigin' class='form-control' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20 />"
				+ "</td>"
				+ "<td style='text-align: center;'>"
				+ "<select name='tmlx' style='width: 100%;border-radius: 4px;'><option value='-1'>全部</option>";
		for (var i = 0; i < dictResponse.data.length; i++) {
			if (dictResponse.data[i].tmlx != null) {
				for (var j = 0; j < dictResponse.data[i].tmlx.length; j++) {
					var ele = dictResponse.data[i].tmlx[j];
					option += "<option value='"+ele.code+"'>" + ele.name
							+ "</option>";
				}
			}
		}
		option += "</select>"
				+ "</td>"
				+ "<td style='text-align: center;'>"
				+ "<input type='text' name='proTableTd_standardBarCode' onkeyup='clearNoNum2(event,this)' onblur='checkNum2(this)' onpaste='return false;' placeholder='只允许数字' class='form-control' maxLength=18/>"
				+ "</td></tr>";
		$("#proTable tbody").append(option);
		return;
	}
	// 删除选中的条码
	function deleteTM() {
		$("input[type='checkbox']:checked").each(function() {
			$("#proTableTr_" + $(this).val()).remove();
		});
		return;
	}
</script>

<script type="text/javascript">
	/* function isAdjustPrice() {
		if ($("#isAdjustPrice").val() == "on") {
			$("#isAdjustPrice").val("in");
			$("#isAdjustPriceInput").val(0);
		} else {
			$("#isAdjustPrice").val("on");
			$("#isAdjustPriceInput").val(1);
		}
	}
	function isPromotion() {
		if ($("#isPromotion").val() == "on") {
			$("#isPromotion").val("in");
			$("#isPromotionInput").val(0);
		} else {
			$("#isPromotion").val("on");
			$("#isPromotionInput").val(1);
		}
	} */
	function isCheckButton(id) {//alert($("#"+id).val()+"--"+$("#"+id+"Input").val());
		if ($("#"+id).val() == "on") {
			$("#"+id).val("in");
			$("#"+id+"Input").val(0);
		} else {
			$("#"+id).val("on");
			$("#"+id+"Input").val(1);
		}
	}
</script>

<script type="text/javascript">
	function skuClick(data, num) {
		if (num == 0) {
			/* 第一次点击是选中 */
			if ($("#tdCheckbox_" + data).attr("or") == "false") {
				$("#tdCheckbox_" + data).attr("or", "true");
			} else {
				$("#tdCheckbox_" + data).attr("or", "false");
				data = "0";
			}
			$("input[type='checkbox']:checked").each(function(i, team) {
				if ($(this).val() != data) {
					$(this).attr("or", "false");
					$(this).attr("checked", false);
				}
			});
		}
		initShopp(data);
	}
	var shoppPagination;
	function initShopp(data) {
		shoppPagination = $("#shoppPagination").myPagination(
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
						url : __ctxPath + "/product/selectShoppeProductBySku",
						dataType : 'json',
						param : 'productDetailSid=' + data,
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						callback : function(data) {
							$("#shopp_tab tbody").setTemplateElement(
									"shopp-list").processTemplate(data);
						}
					}
				});
	}
</script>

<script type="text/javascript">
	function addZGpro() {

		$("[class='panel panel-default']").each(function(i) {
			if (i > 0) {
				$(this).hide();
			}
		});

		var data;
		/* 获取选择的SKU */
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一列!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要添加的标准商品!");
			$("#warning2").show();
			return false;
		}
		data = checkboxArray[0];

		/* 定义死数据业态 */
		for (var i = 0; i < dictResponse.data.length; i++) {
			if (dictResponse.data[i].yt != null) {
				$("#YTtype").append("<option value='-1'> 请选择 </option>");
				for (var j = 0; j < dictResponse.data[i].yt.length; j++) {
					var ele = dictResponse.data[i].yt[j];
					var option = "<option value='"+ele.code+"'>" + ele.name
							+ "</option>";
					$("#YTtype").append(option);
				}
			}
		}
		findShop();// 查询门店
		$("#proShopCode").val("-1");
		$("#s2id_proShopCode a span").each(function(i) {
			if (i == 0) {
				$(this).text("全部");
				return;
			}
		});
		/* 门店品牌取消选择 */
		$("#shopBrandCode").val("-1");
		$("#shopBrandCode").attr("disabled", "disabled");
		$("#s2id_shopBrandCode a span").each(function(i) {
			if (i == 0) {
				$(this).text("全部");
				return;
			}
		});
		/* 供应商取消选择 */
		$("#supplierCode").val("-1");
		$("#supplierCode").attr("disabled", "disabled");
		$("#s2id_supplierCode a span").each(function(i) {
			if (i == 0) {
				$(this).text("全部");
				return;
			}
		});
		/* 禁用ERP编码 */
		$("#erpProductCode").val("");
		/* 禁用专柜 */
		$("#counterCode").val("-1");
		$("#counterCode").attr("disabled", "disabled");
		$("#s2id_counterCode a span").each(function(i) {
			if (i == 0) {
				$(this).text("全部");
				return;
			}
		});
		/* 禁用经营方式 */
		$("#manageType").attr("disabled", "disabled");
		$("#manageType").val(-1);

		$("#unitCode").val("");
		$("#productAbbr").val("");
		$("#marketPrice").val("");
		$("#salePrice").val("");
		$("#inventory").val("");
		$("#inputTax").val("");
		$("#outputTax").val("");
		$("#consumptionTax").val("");
		$("#rate").val("");
		$("#discountLimit").val("");
		$("#placeOfOrigin").val("");
		$("#entryNumber").val("");
		$("#procurementPersonnelNumber").val("");
		$("#standardBarCode").val("");
		$("#tmlx").val(-1);
		$("#proTable tbody tr").remove();
		//$("#divInputTax").hide();
		//$("#divOutputTax").hide();
		//$("#divConsumptionTax").hide();
		/* $("#divRate").hide(); */
		//$("#divOfferNumber").hide();
		$("#proDivTable").hide();
		$("#skuSid").val(data);
		$("#manageType").prop("disabled", "disabled");
		$("#kh").text($("#productNum").val());
		$("#zsx").text($("#mainAttribute").val());
		var skuName = $("#name_" + data).text().trim();
		$("#skuName").val(skuName);
		$("#productName").val(skuName);
		$("#gg").text($("#gg_" + data).html().trim());
		$("#divProcessingType").hide();
		$("a[class='accordion-toggle collapsed']").each(function() {
			$(this).attr("class", "accordion-toggle");
			$("#" + this.id + "_1").addClass("in");
			$("#" + this.id + "_1").attr("style", "");
		});

		$("#ys").text($("#ys_" + data).html().trim());
		$("#tx").text($("#tx_" + data).html().trim());
		$("#sm").text($("#tx_" + data).html().trim());

		$("#appProDiv").show(function() {
			$("#appProScrollTop").scrollTop(0);
		});
	}
</script>

<!-- 专柜商品添加的折叠控制 -->
<script type="text/javascript">
	function aClick(data) {
		// 判断样式信息
		if ($("#" + data).attr("class") == "accordion-toggle") {
			$("#" + data).addClass("collapsed");
			$("#" + data + "_1").attr("class", "panel-collapse collapse");
			$("#" + data + "_1").attr("style", "height: 0px;");
		} else {
			$("#" + data).attr("class", "accordion-toggle");
			$("#" + data + "_1").addClass("in");
			$("#" + data + "_1").attr("style", "");
		}
	}
</script>

<script type="text/javascript">
	
	//图片展示
	function urlClick(ur,obj){
	//	$("#imageDiv").text(ur);
		$("#imageDiv").html('<img style="width:200px; heigth:200px;" align="center" src="http://10.6.100.100/refundPicture/'+ur+'"/>');
		$("#btDiv2").show();
	}
	function closeBtDiv2(){
		$("#btDiv2").hide();
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
				                                                <th width="2%" style="text-align: center;">订单号</th>
				                                                <th width="2%" style="text-align: center;">销售单号</th>
				                                                <th width="2%" style="text-align: center;">商品编号</th>
				                                                <th width="2%" style="text-align: center;">商品名称</th>
				                                                <th width="1%" style="text-align: center;">商品价格</th>
				                                                <th width="1%" style="text-align: center;">数量</th>
				                                                <th width="1%" style="text-align: center;">可退数量</th>
				                                                <th width="1%" style="text-align: center;">退货数量</th>
				                                                <th width="2%" style="text-align: center;">退货原因</th>
				                                                <th width="2%" style="text-align: center;">退货图片</th>
				                                                <th width="2%" style="text-align: center;">备注</th>
				                                                <th width="1%" style="text-align: center;">商品应退金额</th>
				                                                <th width="2%" style="text-align: center;">商品应退款金额(不含优惠券)</th>
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
													<textarea id="products-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.list as Result}
															{#if $T.Result.isGift == '0'}
																<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px;">
																	<td align="center" id="orderNo_{$T.Result.sid}">
																		{#if $T.Result.orderNo != '[object Object]'}{$T.Result.orderNo}
										                   				{#/if}
																	</td>
																	<td align="center" id="saleNo_{$T.Result.sid}">
																		{#if $T.Result.saleNo != '[object Object]'}{$T.Result.saleNo}
										                   				{#/if}
																	</td>
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
																	<td align="center" id="refundAmount_{$T.Result.sid}">
																		{#if $T.Result.refundAmount != '[object Object]'}{$T.Result.refundAmount}
																		{#else}0
										                   				{#/if}
																	</td>
																	<td align="center" id="actualRefundAmount_{$T.Result.sid}">
																		{#if $T.Result.actualRefundAmount != '[object Object]'}{$T.Result.actualRefundAmount}
																		{#else}0
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
																<input type="text" id="address" name="address"/>
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
															<label class="col-lg-5 col-sm-3 col-xs-3 control-label">快递公司：</label>
															<div class="col-lg-7 col-sm-8 col-xs-8">
																<label id="t1"></label>
															</div>											
														</div>
														<div class="col-md-4">
															<label class="col-lg-5 col-sm-3 col-xs-3 control-label">快递单号：</label>
															<div class="col-lg-7 col-sm-8 col-xs-8">
																<label id="t2"></label>
															</div>										
														</div>
														
														<div class="col-md-4">
															<label class="col-lg-5 col-sm-3 col-xs-3 control-label">退货地址：</label>
															<div class="col-lg-7 col-sm-8 col-xs-8">
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
															{#foreach $T.billDetail.sellDetails[0].couponGains as Result}
															{#if $T.Result.couponGroup == '02'}
																<tr class="gradeX" id="gradeX{$T.Result.eventId}" style="height:35px;">
																	<td align="center" id="couponAccount_{$T.Result.eventId}">
																		{#if $T.Result.couponAccount != '[object Object]'}{$T.Result.couponAccount}
										                   				{#/if}
																	</td>
																	<td align="center" id="couponName_{$T.Result.eventId}">
																		{#if $T.Result.couponName != '[object Object]'}{$T.Result.couponName}
										                   				{#/if}
																	</td>
																	<td align="center" id="saleTimeStr_{$T.Result.eventId}">
																		{#if $T.Result.saleTimeStr != '[object Object]'}{$T.Result.saleTimeStr}
										                   				{#/if}
																	</td>
																	<td align="center" id="receptName_{$T.Result.eventId}">
																		{#if $T.Result.receptName != '[object Object]'}{$T.Result.receptName}
										                   				{#/if}
																	</td>
																	<td align="center" id="receptPhone_{$T.Result.eventId}">
																		{#if $T.Result.receptPhone != '[object Object]'}{$T.Result.receptPhone}
										                   				{#/if}
																	</td>
																	<td align="center" id="receptAddress_{$T.Result.eventId}">
																		{#if $T.Result.receptAddress != '[object Object]'}{$T.Result.receptAddress}
										                   				{#/if}
																	</td>
																	<td align="center" class="brandTypeTd">
																		<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
																			<label>
																				<input type="checkbox" id="tdCheckbox_{$T.Result.eventId}" value="{$T.Result.eventId}" >
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
														<strong>订单赠品信息</strong>
													</h5>
													</div>
													&nbsp;
													 <table class="table-striped table-hover table-bordered" id="olv_tab121" style="width: 90%;background-color: #fff;margin-bottom: 0;">
				                                        <thead>
				                                            <tr role="row" style='height:25px;'>
				                                                <th width="2%" style="text-align: center;">订单号</th>
				                                                <th width="2%" style="text-align: center;">销售单号</th>
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
																	<td align="center" id="saleNo_{$T.Result.sid}">
																		{#if $T.Result.saleNo != '[object Object]'}{$T.Result.saleNo}
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
				                                               <!--  <th width="1%" style="text-align: center;">是否退回</th> -->
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
													<textarea id="Aquan-list" rows="0" cols="0">
														<!--
														{#template MAIN}
															{#foreach $T.billDetail.sellPayments as Result}
															{#if $T.Result.couponGroup == '02'}
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
														<label>&nbsp;&nbsp;退货商品入库状态：</label>
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
														<span>应退款金额：</span>
														<label id="amount1" class="control-label"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<span>&nbsp;&nbsp;现金类支付金额：</span>
														<label id="amount6" class="control-label"></label>
														</div>&nbsp;
													</div>
													<div class="col-md-12">
														<div class="col-md-4">
														<span>&nbsp;&nbsp;其中,优惠券：</span>
														<label id="amount3" class="control-label"></label>
														</div>
														<!-- <div class="col-md-4">
															<div >
															<label>是否退运费：</label>
																<label id="isReturnShippingFee"></label>
															</div>	
														</div>
														<div class="col-md-4">
															<span>应退运费金额：</span>
															<label id="returnShippingFee"></label>
														</div> -->
														&nbsp;
													</div>
													
													<div class="col-md-12">
														<div class="col-md-6">
														<span>&nbsp;&nbsp;退回顾客优惠券金额：</span>
														<label id="amount2" class="control-label"></label>
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
														<span>&nbsp;&nbsp;实际退款金额合计：</span>
														<label id="amount4" class="control-label"></label>
														</div>
														&nbsp;
													</div>
												</div>
												<div style="display: none;">
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														 <input class="btn btn-success" style="width: 20%;" id="qrtk" type="button" value="确认退款" />
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
	<!-- Templates -->
	<p style="display: none">
		<textarea id="product-list" rows="0" cols="0">
			<!--
			{#template MAIN}
				{#foreach $T.list as Result}
					<tr class="gradeX">
						<td align="left" style="vertical-align: text-top;">
							<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
								<label style="padding-left: 4px;">
									<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" or="false"  onclick="skuClick({$T.Result.sid},0);">
									<span class="text"></span>
								</label>
							</div>
						</td>
						<td align="center"><a onclick="skuClick({$T.Result.sid},1);" style="cursor:pointer;">{$T.Result.skuCode}</a></td>
						<td align="center" id="name_{$T.Result.sid}">
							<a onclick="skuClick({$T.Result.sid},1);" style="cursor:pointer;">{$T.Result.skuName}</a></td>
						<td align="center">{$T.Result.brandGroupName}</td>
						<td align="center" id="ys_{$T.Result.sid}">
							{#if $T.Result.colorName==null}
							{#else}
								{$T.Result.colorName}
							{#/if}
						</td>
						<td align="center" id="gg_{$T.Result.sid}">
							{$T.Result.stanCode}
						</td>
						<td align="center" id="tx_{$T.Result.sid}">
							{#if $T.Result.features==null}
							    {$T.Result.colorCode}
							{#else}
								{$T.Result.features}
							{#/if}
						</td>
		       		</tr>
				{#/for}
		    {#/template MAIN}	-->
		</textarea>
	</p>
	<p style="display: none">
		<textarea id="shopp-list" rows="0" cols="0">
			<!--
			{#template MAIN}
				{#foreach $T.list as Result}
					<tr class="gradeX">
						<td align="center">{$T.Result.storeName}</td>
						<td align="center">{$T.Result.counterCode}</td>
						<td align="center">{$T.Result.productCode}</td>
						<td align="center">{$T.Result.productName}</td>
						<td align="center">{$T.Result.supplierName}</td>
						<td align="center">{$T.Result.brandName}</td>
						<td align="center">{$T.Result.glCategoryName}</td>
						<td align="center">
							{#if $T.Result.isSale == 'Y'}<span class="label label-success graded"> 可售</span>
							{#elseif $T.Result.isSale == 'N'}<span class="label label-darkorange graded"> 不可售</span>
							{#/if}
						</td>
		       		</tr>
				{#/for}
		    {#/template MAIN}	-->
		</textarea>
	</p>
	<!-- Add DIV root classification used -->
	<div class="modal modal-darkorange" id="appProDiv">
		<div class="modal-dialog" style="width: 80%; margin-top: 80px;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeProDiv();">×</button>
					<h4 class="modal-title">专柜商品添加</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body" id="appProScrollTop"
						style="overflow-x: hidden; overflow-y: auto; max-height: 420px;">
						<div class="row" style="padding: 10px;">
							<div class="col-lg-12 col-sm-12 col-xs-12">
								<form id="proForm" method="post" class="form-horizontal">
									<div id="accordions" class="panel-group accordion">
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
													<a onclick="aClick(this.id);" id="collapseOnes"
														class="accordion-toggle" style="cursor: pointer;">
														供应商专柜信息<font style="color: red;">(以下信息必填)</font>
													</a>
												</h4>
											</div>
											<div class="panel-collapse collapse in" id="collapseOnes_1">
												<div class="panel-body border-red">
													<div class="col-md-4">
														<label class="control-label">门店：</label> <select
															id="proShopCode" name="shopCode"
															style="width: 70%; float: right;"></select>
													</div>
													<div class="col-md-4">
														<label class="control-label">门店品牌：</label> <select
															id="shopBrandCode" style="width: 70%; float: right;"></select>
													</div>
													<div class="col-md-4">
														<label class="control-label">供应商：</label> <select
															style="width: 70%; float: right;" id="supplierCode"
															name="supplierCode">
															<option value="-1">全部</option>
														</select>
													</div>
													<div class="col-md-12">
														<hr class="wide"
															style="margin-top: 0; border-top: 0px solid #e5e5e5;">
													</div>
													<div class="col-md-4">
														<label class="control-label">专柜：</label> <select
															style="width: 70%; float: right;" id="counterCode"
															name="counterCode">
															<option value="-1">全部</option>
														</select>
													</div>
													<div class="col-md-4">
														<label class="control-label">业态：</label> <select
															id="YTtype" style="width: 70%; height: 32px; float: right;"
															 disabled="disabled"></select>
														<input type="hidden" id="YTtype_" name="type" />
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
													<a onclick="aClick(this.id);" id="yyDiv"
														class="accordion-toggle" style="cursor: pointer;">
														要约信息<font style="color: red;" id="yyDiv_font">(以下带*是必填项)</font>
													</a>
												</h4>
											</div>
											<div class="panel-collapse collapse in" id="yyDiv_1">
												<div class="panel-body border-red">
													<div class="col-md-4" id="divOfferNumber">
														<label class="control-label" id="divOfferNumber_font"><font
															style="color: red;">*</font>要约号：</label> <select id="offerNumber"
															name="offerNumber" onchange="offerNumberChange();"
															style="width: 70%; height: 32px; float: right;">
															<option value="-1">请选择</option>
														</select>
													</div>
													<div class="col-md-4" id="divRate">
														<label class="control-label"><font id="erpCode_font_"
															style="color: red;">*</font>扣率码：</label> <select
															id="erpProductCode" onchange="erpProductCodeChange();"
															name="erpProductCode" style="width: 70%; height: 32px; float: right;"></select>
													</div>
													<!-- <div class="col-md-4" id="divRate">
														<label class="control-label">扣率：</label> <input
															class="form-control" id="rate" name="rate"
															style="width: 70%; float: right;" readonly />
													</div> -->
													<div class="col-md-4" id="divJyType">
														<label class="control-label">经营方式：</label> <select
														    id="manageType" style="width: 70%; height: 32px; float: right;"></select>
														<input type="hidden" id="manageTypeForm" name="manageType" />
													</div>
													<div class="col-md-12">
														<hr class="wide"
															style="margin-top: 0; border-top: 0px solid #e5e5e5;">
													</div>
													<div class="col-md-4" id="divInputTax">
														<label class="control-label"><font
															style="color: red;">*</font>进项税：</label> <input type="text"
															class="form-control" id="inputTax" name="inputTax"
															style="width: 70%; float: right;"
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
															onpaste="return false;" maxLength=10 />
													</div>
													<div class="col-md-4" id="divConsumptionTax">
														<label class="control-label"><font
															style="color: red;">*</font>销项税：</label> <input type="text"
															class="form-control" id="consumptionTax"
															name="outputTax" style="width: 70%; float: right;"
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
															onpaste="return false;" maxLength=10 />
													</div>
													<div class="col-md-4" id="divOutputTax">
														<label class="control-label">消费税：</label> <input
															type="text" class="form-control" id="outputTax"
															name="consumptionTax" style="width: 70%; float: right;"
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
															onpaste="return false;" maxLength=10 />
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
													<a onclick="aClick(this.id);" id="manageCateGoryDiv"
														class="accordion-toggle" style="cursor: pointer;">
														管理/统计分类信息<font style="color: red;" id="managerDiv_font">(以下信息必填)</font>
													</a>
												</h4>
											</div>
											<div class="panel-collapse collapse in"
												id="manageCateGoryDiv_1">
												<div class="panel-body border-red">
													<div class="col-md-6">
														<label class="col-md-4 control-label">管理分类：</label>
														<div class="col-md-8">
															<div class="btn-group" style="width: 100%"
																id="proBtnGroup">
																<a href="javascript:void(0);" class="btn btn-default"
																	id="proA" style="width: 85%;">请选择</a> <a
																	id="proTreeDown" href="javascript:void(0);"
																	class="btn btn-default" treeDown="true"><i
																	class="fa fa-angle-down"></i></a>
																<ul id="proTreeDemo"
																	class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 98%; position: absolute;"></ul>
																<input type="hidden" id="manageCateGory"
																	name="manageCateGory" />
															</div>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">统计分类</label>
														<div class="col-md-8">
															<div class="btn-group" style="width: 100%"
																id="tjBtnGroup">
																<a href="javascript:void(0);" class="btn btn-default"
																	id="tjA" style="width: 85%;">请选择</a> <a id="tjTreeDown"
																	href="javascript:void(0);" class="btn btn-default"
																	treeDown="true"><i class="fa fa-angle-down"></i></a>
																<ul id="tjTreeDemo"
																	class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 98%; position: absolute;"></ul>
																<input type="hidden" id="finalClassiFicationCode"
																	name="finalClassiFicationCode" />
															</div>
														</div>
														&nbsp;
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
													<a onclick="aClick(this.id);" id="skuDiv"
														class="accordion-toggle" style="cursor: pointer;">
														专柜商品信息<font style="color: red;">(以下信息是必填项)</font>
													</a>
												</h4>
											</div>
											<div class="panel-collapse collapse in" id="skuDiv_1">
												<div class="panel-body border-red">
													<div class="col-md-3" id="divKh">
														<label class="col-md-4">款号：</label>
														<div class="col-md-8">
															<span id="kh"></span>
														</div>
													</div>
													<div class="col-md-3" id="divZsx">
														<label class="col-md-4" style="width: 100px;">主属性：</label>
														<div class="col-md-8">
															<span id="zsx"></span>
														</div>
													</div>
													<div class="col-md-3" id="divYs">
														<label class="col-md-4">色系：</label>
														<div class="col-md-8">
															<span id="ys"></span>
														</div>
													</div>
													<div class="col-md-3" id="divTx">
														<label class="col-md-4">特性：</label>
														<div class="col-md-8">
															<span id="tx"></span>
														</div>
													</div>
													<div class="col-md-3" id="divSm">
														<label class="col-md-4">色码：</label>
														<div class="col-md-8">
															<span id="sm"></span>
														</div>
													</div>
													<div class="col-md-3">
														<label class="col-md-4">规格：</label>
														<div class="col-md-8">
															<span id="gg"></span>
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" style="padding: 0">
														<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>专柜商品名称：</label>
														<div class="col-md-8">
															<input class="form-control" id="productName"
																name="productName"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=50 style="width: 100%" />
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" style="padding: 0;">
														<label class="col-md-4 control-label" style="padding: 8px 0;"><font
															style="color: red;">*</font>专柜商品简称：</label>
														<div class="col-md-8">
															<input class="form-control" id="productAbbr"
																name="productAbbr"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=25  style="width: 100%"/>
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" style="padding: 0;">
														<label class="col-md-4 control-label" style="padding: 8px 0;"><font
															style="color: red;">*</font>销售单位：</label>
														<div class="col-md-8">
															<select id="unitCode" name="unitCode" style="width: 100%;height: 32px;margin-bottom: 4px;"></select>
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" id="discountLimitDiv" style="padding: 0">
														<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>折扣底限：</label>
														<div class="col-md-8">
															<input class="form-control" id="discountLimit"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																onpaste="return false;" maxLength=5 name="discountLimit" style="width: 100%"/>
														</div>
														&nbsp;
													</div>
													<input type="hidden" id="isAdjustPriceInput" name="isAdjustPrice" value="1">
													<input type="hidden" id="s" name="isPromotion" value="1">
													
													<div class="col-md-4" id="divProcessingType" style="padding: 0">
														<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>加工类型：</label>
														<div class="col-md-8">
															<select id="processingType" name="processingType"
																style="width: 100%;height: 32px;">	
															</select>
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" id="modelNumDiv" style="padding: 0;">
														<label class="col-md-4 control-label" style="padding: 8px 0;">货号：</label>
														<div class="col-md-8">
															<input class="form-control" id="modelNum"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																onpaste="return false;" maxLength=20 name="modelNum" style="width: 100%"/>
														</div>
														&nbsp;
													</div>
													<div id="eConDivShow"
														style="overflow-y: auto; width: 100%;margin:0;">
														<div class="col-md-4"  style="padding: 0">
															<label class="col-md-4 control-label" style="padding: 8px 0">供应商商品编码：</label>
															<div class="col-md-8">
																<input class="form-control" id="supplyProductCode"
																	onkeyup="clearNoNum(event,this)"
																	onblur="checkNum(this)" onpaste="return false;"
																	maxLength=20 name="supplyProductCode" style="width: 100%"/>
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">物流类型：</label>
															<div class="col-md-8" style="height:36px;">
															    <select id="tmsParam" name="tmsParam" style="width: 100%;height: 32px;"></select>
															</div>
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">基本计量单位：</label>
															<div class="col-md-8">
																<input class="form-control" id="baseUnitCode"onpaste="return false;"
																	name="baseUnitCode" style="width: 100%"/>
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">原产国：</label>
															<div class="col-md-8">
																<input class="form-control" id="originCountry" onpaste="return false;"
																	maxLength=20 name="originCountry" style="width: 100%"/>
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">原产地：</label>
															<div class="col-md-8">
																<input class="form-control" id="countryOfOrigin" onpaste="return false;"
																	maxLength=20 name="countryOfOrigin" style="width: 100%"/>
															</div>
															&nbsp;
														</div>
														<div class="col-md-4"  style="padding: 0">
															<label class="col-md-4 control-label" style="padding: 8px 0">赠品范围：</label>
															<div class="col-md-8">
																<input class="form-control" id="isGift" onpaste="return false;"
																	maxLength=20 name="isGift" style="width: 100%"/>
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">虚库标志：</label>
															<div class="col-md-8">
															    <label class="control-label"> <input
																    type="checkbox" value="on" id="stockMode" onclick="isCheckButton('stockMode')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="stockModeInput"
																    name="stockMode" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">可COD：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																    type="checkbox" value="on" id="isCod" onclick="isCheckButton('isCod')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="isCodInput"
																    name="isCod" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">可贺卡：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																    type="checkbox" id="isCard" value="on" onclick="isCheckButton('isCard')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="isCardInput"
																    name="isCard" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">可包装：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																    type="checkbox" id="isPacking" value="on" onclick="isCheckButton('isPacking')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="isPackingInput"
																    name="isPacking" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4"  style="padding: 0">
															<label class="col-md-4 control-label" style="padding: 8px 0">是否有原厂包装：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																    type="checkbox" id="isOriginPackage" value="on" onclick="isCheckButton('isOriginPackage')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="isOriginPackageInput"
																    name="isOriginPackage" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">先销后采：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																    type="checkbox" id="xxhcFlag" value="on" onclick="isCheckButton('xxhcFlag')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="xxhcFlagInput"
																    name="xxhcFlag" value="1">
															</div>
															&nbsp;
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
													<a onclick="aClick(this.id);" id="priceStockDiv"
														class="accordion-toggle" style="cursor: pointer;">
														价格库存信息 <font style="color: red;">(以下信息必填)</font>
													</a>
												</h4>
											</div>
											<div class="panel-collapse collapse in" id="priceStockDiv_1">
												<div class="panel-body border-red">
													<div class="col-md-4">
														<label class="col-md-4 control-label">吊牌价：</label>
														<div class="col-md-8">
															<input class="form-control" id="marketPrice"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																onpaste="return false;" maxLength=20 name="marketPrice"
																style="width: 100%" />
														</div>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label">销售价：</label>
														<div class="col-md-8">
															<input class="form-control" id="salePrice"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																onpaste="return false;" maxLength=20 name="salePrice"
																style="width: 100%" />
														</div>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label">可售库存：</label>
														<div class="col-md-8">
															<input class="form-control" id="inventory"
																name="inventory" style="width: 100%"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																onkeyup="value=value.replace(/[^0-9- ]/g,'');"
																maxLength=20 />
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
													<a onclick="aClick(this.id);" id="dqdDiv"
														class="accordion-toggle" style="cursor: pointer;">
														其他信息 <font style="color: red;" id="dqdDiv_font">(以下信息必填)</font>
													</a>
												</h4>
											</div>
											<div class="panel-collapse collapse in" id="dqdDiv_1">
												<div class="panel-body border-red">
													<div class="col-md-6">
														<label class="col-md-4 control-label">录入人员编号：</label>
														<div class="col-md-8">
															<input class="form-control" id="entryNumber"
																name="entryNumber" style="width: 100%"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=10 />
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">采购人员编号：</label>
														<div class="col-md-8">
															<input class="form-control"
																id="procurementPersonnelNumber"
																name="procurementPersonnelNumber" style="width: 100%"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=10 />
														</div>
														&nbsp;
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
													<a onclick="aClick(this.id);" id="tmDiv"
														class="accordion-toggle" style="cursor: pointer;">
														条码信息 <font id="tmDiv_font" style="color: red;">(以下信息必填)</font>
													</a>
												</h4>
											</div>
											<div class="panel-collapse collapse in" id="tmDiv_1">
												<div class="panel-body border-red">
													<div style="width: 100%;">
														<div class="widget-header ">
															<span class="widget-caption">多条码添加</span>
															<div class="widget-buttons">
																<a data-toggle="collapse"
																	style="color: green; cursor: pointer;"> <span
																	class="fa fa-plus" onclick="addTM();">新增</span>
																</a> <a data-toggle="collapse"
																	style="color: red; cursor: pointer;"> <span
																	class="fa fa-trash-o" onclick="deleteTM()">删除</span>
																</a>
															</div>
														</div>
														<table id="proTable"
															class="table table-bordered table-striped table-condensed table-hover flip-content">
															<thead class="flip-content bordered-darkorange">
																<tr>
																	<th width="1%"></th>
																	<th width="33%" style="text-align: center;">产地</th>
																	<th width="33%" style="text-align: center;">条码类型</th>
																	<th width="33%" style="text-align: center;">条码编号</th>
																</tr>
															</thead>
															<tbody>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- yincangDiv -->
									<div style="display: none">
										<input type="hidden" id="skuSid" name="skuSid" /> <input
											type="hidden" id="skuName" name="skuName" /> <input
											type="hidden" id="tmlist" name="barcodes" />
									</div>
									<!-- /yincangDiv -->
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input type="button" class="btn btn-success"
												style="width: 25%;" id="proSave" value="保存">&emsp;&emsp;
											<input onclick="closeProDiv();clearAll();" class="btn btn-danger"
												style="width: 25%;" id="close" type="button" value="取消" />
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Add DIV root classification used ||| End -->
	<!-- /Page Body -->
	<!-- 成功 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="proSaveSuccess">
		<div class="modal-dialog" style="margin: 150px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<i class="glyphicon glyphicon-check"></i>
				</div>
				<div class="modal-body" id="proSaveSuccess2">添加成功!</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="proSaveSuccess()">确定</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /成功 -->
	<!-- 成功2 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="iframeSuccess2">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<i class="glyphicon glyphicon-check"></i>
				</div>
				<div class="modal-body" id="modal-body-success">保存成功</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="iframeSuccessBtn2()">确定</button>
				</div>
			</div>
			<!-- / .modal-content -->
		</div>
		<!-- / .modal-dialog -->
	</div>
	<!-- 图片展示 -->
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
	<!-- 图片展示 -->
</body>
</html>