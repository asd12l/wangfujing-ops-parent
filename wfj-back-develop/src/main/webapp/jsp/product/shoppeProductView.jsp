<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--
WFJBackWeb - productView
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<!-- zTree -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<!--Jquery Select2-->
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>

<!-- 专柜商品列表页展示及查询 -->
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image="http://images.shopin.net/images";
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 	
	var productPagination;
	$(function() {    	
	    initProduct();
	    $("#saleStatus_select").change(productQuery);
	    $("#pageSelect").change(productQuery);
	    
		$("#loading-container").addClass("loading-inactive");
		$(".select2-arrow b").attr("style", "line-height: 2;");
		$("#resetQuery").attr("disabled", "disabled");
		$("#materialNumber").hide();
	});
	//专柜商品查询
	function productQuery(){
		$("#shoppeProName_from").val($("#shoppeProName_input").val());
		$("#saleStatus_from").val($("#saleStatus_select").val());
        var params = $("#product_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        productPagination.onLoad(params);
   	}
	// 查询
	function query(){
		productQuery();
	}
	// 重置
	function reset(){
		$("#shoppeProName_input").val("");
		$("#saleStatus_select").val("");
		productQuery();
	}
	//初始化专柜商品列表
 	function initProduct() {
		var url = $("#ctxPath").val()+"/product/selectShoppeProductBySku";
		productPagination = $("#productPagination").myPagination({
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
             async : false,
             dataType: 'json',
             param:'productDetailSid='+$("#skuSid_hidden").val(),
             ajaxStart: function() {
					$(".loading-container").attr("class","loading-container");
				},
				ajaxStop: function() {
					//隐藏加载提示
					$(".loading-container").addClass("loading-inactive");
				},
             callback: function(data) {
               //使用模板
               $("#product_tab tbody").setTemplateElement("product-list").processTemplate(data);
             }
           }
         });
    }
</script> 

<script type="text/javascript">
    var dictResponse;
	var url = __ctxPath + "/category/getAllCategory";
	var setting = {
		data : {
			key : {
				title : "t"
			},
			simpleData : {
				enable : true
			}
		},
		async: {
			enable: true,
			url: __ctxPath+"/category/ajaxAsyncList",
			dataType: "json",
			autoParam:["id", "channelSid", "shopSid","categoryType"],
			otherParam:{},
			dataFilter: filter
		},
		callback : {
			beforeClick : beforeClick,
			onClick : onClick,
			asyncSuccess: zTreeOnAsyncSuccess,//异步加载成功的fun
			asyncError: zTreeOnAsyncError //加载错误的fun 
		}
	};
	
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	function zTreeOnAsyncError(event, treeId, treeNode){
		$("#warning2Body").text("异步加载失败!");
		$("#warning2").show();
	}
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg){
	    $("#warning2Body").text("异步加载成功!");
		$("#warning2").show();
	} 
	var log, className = "dark";
	function beforeClick(treeId, treeNode, clickFlag) {
		className = (className === "dark" ? "" : "dark");
		showLog("[ " + getTime() + " beforeClick ]&nbsp;&nbsp;" + treeNode.name);
		return (treeNode.click != false);
	}
	var parametersLength = "";
	function onClick(event, treeId, treeNode, clickFlag) {
		if (treeNode.isLeaf == "Y") {
			if (treeNode.categoryType == 1) {// 管理分类操作   更换请选择汉字
				$("#proA").html(treeNode.name);
				$("#manageCateGory").val(treeNode.code);
				$("#proTreeDown").attr("treeDown", "true");
			} 
			$("#rightbaseBtnGroup").attr("class", "btn-group");
			$("#baseBtnGroup").attr("class", "btn-group");
			$("#proBtnGroup").attr("class", "btn-group");
			$("#tjBtnGroup").attr("class", "btn-group");
		} else {
			$("#warning2Body").text("请选择末级分类!");
			$("#warning2").attr("style","z-index:9999;");
			$("#warning2").show();
		}
	}
	function showLog(str) {
		if (!log)
			log = $("#log");
		log.append("<li class='"+className+"'>" + str + "</li>");
		if (log.children("li").length > 8) {
			log.get(0).removeChild(log.children("li")[0]);
		}
	}
	function getTime() {
		var now = new Date(), h = now.getHours(), m = now.getMinutes(), s = now
				.getSeconds();
		return (h + ":" + m + ":" + s);
	}
	
	// Tree管理分类请求
	function proTreeDemo() {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/list",
			async : false,
			data : {
				"categoryType" : 1,
				"shopSid":$("#shopCode").find("option:selected").attr("storecode")
			},
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			success : function(response) {
				$.fn.zTree.init($("#proTreeDemo"), setting, response);
			}
		});
	}

	//格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动    
	function formatAsText(item) {
		var itemFmt = "<div style='display:inline'>" + item.name + "</div>"
		return itemFmt;
	}
	
	// 查询专柜
	function counterCodeClick(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/shoppe/queryShoppe",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class",
						"loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass(
						"loading-inactive");
			},
			data : {
				"shopSid" : $("#proShopCode").val(),
				"businessTypeSid":$("#manageTypeForm").val(),
				"page":1,
				"pageSize":1000000
			},
			success : function(response) {
				$("#counterCode option[index!='0']").remove();
				$("#counterCode").append("<option value='-1'>全部</option>");
				if (response.pageCount != 0) {
					var result = response.list;
					for (var i = 0; i < result.length; i++) {
						var ele = result[i];
						$("#counterCode").append(
								"<option industryConditionSid='"+ele.industryConditionSid+"' value='"+ele.sid+"'>" + ele.shoppeName
										+ "</option>");
					}
					return;
				}
			}
		});
		$("#counterCode").select2();
		$(".select2-arrow b").attr("style", "line-height: 2;");
	}
	// 点击查询供应列表
	function supplierCodeClick(){
	    //$("#supplierCode").removeAttr("disabled");
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/supplierDisplay/selectSupplyByShopSidAndSupplyName",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class",
						"loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass(
						"loading-inactive");
			},
			data : {
			    "shopSid":$("#shopCode").find("option:selected").attr("storecode"),
				"page":1,
				"pageSize":1000000
			},
			success : function(response) {
				$("#supplierCode option[index!='0']").remove();
				$("#supplierCode").append("<option value='-1'>全部</option>");
				if (response.success != "false") {
					var result = response.data;
					for (var i = 0; i < result.length; i++) {
						var ele = result[i];
						$("#supplierCode").append(
								"<option businessPattern='"+ele.businessPattern+"' supplyCode='"+ele.supplyCode+"' value='"+ele.sid+"'>" + ele.supplyName
										+ "</option>");
					}
					return;
				}
			}
		});
		$("#supplierCode").select2();
		$(".select2-arrow b").attr("style", "line-height: 2;");
	}
	
	
	/* 门店列表 */
	function findShop() {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/organization/queryOrganizationZero",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class",
						"loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass(
						"loading-inactive");
			},
			data : {
				"organizationType":3,
				"storeType":0,
				"page" : 1,
				"pageSize" : 1000000
			},
			success : function(response) {
				var result = response.list;
				var option = "<option value='-1'>请选择</option>";
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option storeCode='"+ele.organizationCode+"' value='"+ele.sid+"'>"
							+ ele.organizationName + "</option>";
				}
				$("#proShopCode").append(option);
				return;
			}
		});
		$("#proShopCode").select2();
		$("#counterCode").select2();
		$("#supplierCode").select2();
		$("#shopBrandCode").select2();
		$(".select2-arrow b").attr("style", "line-height: 2;");
		return;
	}
	
	/* 门店点击后查询门店品牌方法 */
	function findShopBrand(){
	    $("#shopBrandCode").html("");
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/selectAllBrand",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class",
						"loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass(
						"loading-inactive");
			},
			data : {
				"shopCode" : $("#proShopCode").find("option:selected").attr("storeCode")
				
			},
			success : function(response) {
				var result = response.data;
				var option = "<option value='-1'>请选择</option>";
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option sid='"+ele.brandSid+"' value='"+ele.sid+"'>"
							+ ele.brandName + "</option>";
				}
				$("#shopBrandCode").append(option);
				return;
			}
		});
		$("#shopBrandCode").select2();
		$(".select2-arrow b").attr("style", "line-height: 2;");
		return;
	}
	
	/* 查询数据字典 */
	function findDictCode(){
	    $.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/dataDict/findDictByPidInfo",
			dataType : "json",
			async : false,
			ajaxStart : function() {$("#loading-container").prop("class","loading-container");},
			ajaxStop : function() {$("#loading-container").addClass("loading-inactive");},
			data : {
				"codes":"xsdw,splx,jglx,tmlx,yt"
			},
			success : function(response) {
			    dictResponse = response;
				var result = response.data[0].xsdw;
				var option = "<option value='-1'>请选择</option>";
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option sid='"+ele.sid+"' value='"+ele.name+"'>"
							+ ele.name + "</option>";
				}
				$("#unitCode").append(option);
				return;
			}
		});
	}
	
	var cData_change2;
	var dictCode;
	
	// 初始化
	$(function() {
	    dictResponse="";
	    /* 查询数据字典 */
	    findDictCode();		
		
		// 添加专柜商品的门店没有选择禁用专柜,楼层,供应商,管理分类
		$("#floor").attr("disabled", "disabled");
		$("#counterCode").attr("disabled", "disabled");
		$("#supplierCode").attr("disabled", "disabled");
		$("#proA").attr("disabled", "disabled");
		$("#proTreeDown").attr("disabled", "disabled");
		// 
		$("#isAdjustPrice").click(function() {
			isAdjustPrice();
		});
		$("#isPromotion").click(function() {
			isPromotion();
		});
		
		$("#proSave").click(function() {
			proForm();
		});
	
		$("#proTreeDown").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#proBtnGroup").attr("class", "btn-group open");
			} else {
				$(this).attr("treeDown", "true");
				$("#proBtnGroup").attr("class", "btn-group");
			}
		});
		
		$("#loading-container").addClass("loading-inactive");
		$(".select2-arrow b").attr("style", "line-height: 2;");
		
		
		/* 供应商绑定事件 */
		$("#supplierCode").change(function() {
			if ($(this).val() / 1 != -1) {
			    /* 加工类型 */
			    for(var i=0;i<dictResponse.data.length;i++){
				    if(dictResponse.data[i].jglx!=null){
						var jglx = dictResponse.data[i].jglx;
					    for(var j=0;j<jglx.length;j++){
						    var ele = jglx[j];
							var option = "<option value='"+ele.code+"'>"+ele.name+"</option>";
						    $("#processingType").append(option);
					    }
				    }else{
						break;
				    }
				}
			    
			    counterCodeClick();
			    var businessPattern = $("#supplierCode").find("option:selected").attr("businessPattern")
			    $("#manageType").html("");
			    if(businessPattern==0){
					$("#manageType").append("<option value='"+businessPattern+"'>经销</option>");
			    }else if(businessPattern==1){
					$("#manageType").append("<option value='"+businessPattern+"'>代销</option>");
			    }else if(businessPattern==2){
					$("#manageType").append("<option value='"+businessPattern+"'>联营</option>");
			    }else if(businessPattern==3){
					$("#manageType").append("<option value='"+businessPattern+"'>平台服务</option>");
			    }else{
					$("#manageType").append("<option value='"+businessPattern+"'>租赁</option>");
			    }
			    $("#manageTypeForm").val(businessPattern);
			    
				$("#counterCode").removeAttr("disabled");
				$("#erpProductCode").val("");
			} else {
				$("#counterCode").prop("disabled","disabled");
			}
		});

		/* 专柜变更事件 */
		$("#counterCode").change(function(){
		    if($(this).val() != -1){
				$("#YTtype").val($(this).find("option:selected").attr("industryConditionSid")).trigger("change");
				$("#YTtype_").val($(this).find("option:selected").attr("industryConditionSid"));
		    }else{
				$("#YTtype").val(-1);
				$("#YTtype_").val("");
		    }
		});
		/* 业态变更事件 */	
		$("#YTtype").change(
			function() {
				var YTtype = $(this).val();
				
				if(YTtype==1){						
					$("#tmDiv_font").show();				
				}
				else{
					$("#tmDiv_font").hide();
				}
                if(YTtype==-1){
					$("#yyDiv").html("合同信息<font id='yyDiv_font' style='color: red;'>(以下信息必填)</font>");					
					$("#dqdDiv_font").hide();
					  
					$("#divOfferNumber").hide();
					$("#ERP").hide();
					$("#materialNumber").show();
				}
                else{
                	$("#yyDiv").html("要约信息<font id='yyDiv_font' style='color: red;'>(以下信息必填)</font>");
                	$("#dqdDiv_font").show();
                	
                	$("#divOfferNumber").show();
                	$("#ERP").show();
                	$("#materialNumber").hide();
                }
				
				
		});	
		/* 门店品牌变更事件 */
		$("#shopBrandCode").change(function(){
		    if ($(this).val() / 1 != -1) {
			    supplierCodeClick();
				proTreeDemo();// Tree管理分类
				$("#supplierCode").removeAttr("disabled");
				$("#proA").removeAttr("disabled");
				$("#proTreeDown").removeAttr("disabled");
		    }else{
				$("#proTreeDown").attr("treeDown", "true");
				$("#proBtnGroup").attr("class", "btn-group");
				$("#counterCode").attr("disabled", "disabled");
				$("#s2id_counterCode a span").each(function(i){
					if(i==0){
						$(this).text("全部");
						return;
					}
				});
				$("#s2id_supplierCode a span").each(function(i){
					if(i==0){
						$(this).text("全部");
						return;
					}
				});
				$("#supplierCode").attr("disabled", "disabled");
				$("#manageType").attr("disabled", "disabled");
				$("#manageType").val(-1);
				$("#proA").attr("disabled", "disabled");
				$("#proTreeDown").attr("disabled", "disabled");
		    }
		});
		// 门店事件
		$("#proShopCode").change(function() {
			if ($(this).val() / 1 != -1) {
			    
			    /* 查询门店品牌-1.启动门店品牌下拉框- */
			    findShopBrand();
			    $("#shopBrandCode").removeAttr("disabled");
			    
			} else {
			    /* 禁用门店品牌 */
			    $("#shopBrandCode").attr("disabled", "disabled");
			    $("#s2id_shopBrandCode a span").each(function(i){
					if(i==0){
						$(this).text("全部");
						return;
					}
				});
			    
			    $("#proTreeDown").attr("treeDown", "true");
				$("#proBtnGroup").attr("class", "btn-group");
				$("#counterCode").attr("disabled", "disabled");
				$("#s2id_counterCode a span").each(function(i){
					if(i==0){
						$(this).text("全部");
						return;
					}
				});
				$("#s2id_supplierCode a span").each(function(i){
					if(i==0){
						$(this).text("全部");
						return;
					}
				});
				$("#supplierCode").attr("disabled", "disabled");
				$("#manageType").attr("disabled", "disabled");
				$("#manageType").val(-1);
				$("#proA").attr("disabled", "disabled");
				$("#proTreeDown").attr("disabled", "disabled");
			}
		});
	});

</script>
<!-- 经营方式和要约事件 -->
<script type="text/javascript">
	<!--
	/* ERP集合 */
	var erpList;
	//经营方式点击
	function manageTypeFunct(){
		/* $("#divOfferNumber").show(); */
		var manageType = $("#manageType").val();
		if(manageType==-1){
			$("#divOfferNumber").hide();
			$("#divInputTax").hide();
			$("#divOutputTax").hide();
			$("#divConsumptionTax").hide();
			$("#divRate").hide();
			return;
		}
		var storeCode = $("#proShopCode").find("option:selected").attr("storeCode");
		var supplyCode = $("#supplierCode").find("option:selected").attr("supplyCode");
		$("#offerNumber").html("");
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/selectContractByParams",
			dataType : "json",
			async : false,
			ajaxStart : function() {$("#loading-container").prop("class","loading-container");},
			ajaxStop : function() {$("#loading-container").addClass("loading-inactive");},
			data : {"storeCode":storeCode,"supplyCode":supplyCode,"manageType":manageType},
			success : function(response) {
				if (response.success == 'true') {
					if(response.data[0]!=""){
					    erpList = response.data.erpList;
						var option = "<option value='-1'>请选择</option>";
						for (var i = 0; i < response.data.contractList.length; i++) {
							var ele = response.data.contractList[i];
							option += "<option commissionRate='"+ele.commissionRate+"' outputTax='"+ele.outputTax+"' inputTax='"+ele.inputTax+"' value='"+ele.contractCode+"'>"
									+ ele.contractCode + "</option>";
						}
						$("#offerNumber").append(option);
					}else{
						$("#warning2Body").text("查询失败");
						$("#warning2").show();
					}
				} else {
				    $("#warning2Body").text("查询失败");
					$("#warning2").show();
				}
			}
		});
		if(manageType==2 && $("#YTtype").val()==0){// 百货联营
			$("#divInputTax").hide();
			$("#divOutputTax").hide();
			$("#divConsumptionTax").hide();
			$("#divRate").show();
			$("#inputTax").val("");
			$("#outputTax").val("");
			$("#consumptionTax").val("");
			$("#rate").val("");
			$("#divProcessingType").hide();
			$("#processingType").val(1);
		}else{
			$("#divInputTax").show();
			$("#divOutputTax").show();
			$("#divConsumptionTax").show();
			$("#divRate").hide();
			$("#inputTax").val("");
			$("#outputTax").val("");
			$("#consumptionTax").val("");
			$("#rate").val("");
			$("#processingType").val(-1);
			$("#divProcessingType").show();
		}
	}
	// 要约号改变事件
	function offerNumberChange(){
	    $("#erpProductCode").html("");
		var option = "<option value='-1'>请选择</option>";
		for (var i = 0; i < erpList.length; i++) {
			var ele = erpList[i];
			option += "<option commissionRate='"+ele.commissionRate+"' value='"+ele.productCode+"'>"
					+ ele.productCode + "</option>";
		}
		$("#erpProductCode").append(option);
	    
		var manageType = $("#manageType").val();
		var inputTax = $("#offerNumber").find("option:selected").attr("inputTax");
		var outputTax = $("#offerNumber").find("option:selected").attr("outputTax");
		if(manageType==2&&$("#type").val()==0){// 百货联营
			$("#inputTax").val("");
			$("#outputTax").val("");
			$("#consumptionTax").val("");
		}else{
			$("#inputTax").val(inputTax);
			$("#outputTax").val("");
			$("#consumptionTax").val(outputTax);
		}
	}
	/* ERP编码改变 */
	function erpProductCodeChange(){
	    var commissionRate = $("#erpProductCode").find("option:selected").attr("commissionRate");
	    $("#rate").val(commissionRate);
	}
	//-->
</script>


<!-- 专柜商品保存 -->
<script type="text/javascript">
	<!--
	/* 条码JSON数据生成 */
	function tmJson(){
	    var tmCounts = 0;
		/* 产地list */
		var proTableTd_placeOfOrigin = new Array();
		/* 条码类型 */
		var tmlx = new Array();
		/* 条码编号list */
		var proTableTd_standardBarCode = new Array();
		var parameters = new Array();
		$("input[name='proTableTd_placeOfOrigin']").each(function(i) {
		    if($(this).val()!=""){
			    proTableTd_placeOfOrigin.push($(this).val());
		    }else{
				tmCounts++;
				return;
		    }
		});
		$("select[name='tmlx']").each(function(i) {
		    if($(this).val()!="-1"){
			    tmlx.push($(this).val());
		    }else{
				tmCounts++;
				return;
		    }
		});
		// 整理条码文本
		$("input[name='proTableTd_standardBarCode']").each(function(i) {
		    if($(this).val()!=""){
			    proTableTd_standardBarCode.push($(this).val().trim());
		    }else{
				tmCounts++;
				return;
		    }
		});
		var inT;
		if(tmCounts==0){
			for (var i = 0; i < proTableTd_placeOfOrigin.length; i++) {
				parameters.push({
				    'originLand': proTableTd_placeOfOrigin[i],
					'type' : tmlx[i],
					'barcode' : proTableTd_standardBarCode[i],
				});
			}
			inT = JSON.stringify(parameters);
			inT = inT.replace(/\%/g, "%25");
			inT = inT.replace(/\#/g, "%23");
			inT = inT.replace(/\&/g, "%26");
			inT = inT.replace(/\+/g, "%2B");
		}else{
		    inT = new Array();
		}
		return inT;
	}
	// pro保存
	function proForm(){
		var message = requiredProForm();
	    if(message==false){
			return;
	    }
		var manageType = $("#manageType").val();
		
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/saveShoppeProduct",
			dataType : "json",
			async : false,
			ajaxStart : function() {$("#loading-container").prop("class","loading-container");},
			ajaxStop : function() {$("#loading-container").addClass("loading-inactive");},
			data : $("#proForm").serialize(),
			success : function(response) {
				if (response.success == 'true') {
					$("#modal-body-success")
							.html("<div class='alert alert-success fade in'>"
											+ "<strong>添加成功</strong></div>");
					$("#modal-success").attr({
						"style" : "display:block;z-index:9999;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
				} else {
					$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
				}
				return;
			},
			error : function(XMLHttpRequest, textStatus) {
				var sstatus = XMLHttpRequest
						.getResponseHeader("sessionStatus");
				if (sstatus != "sessionOut") {
					$("#warning2Body").text("系统出错");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
				}
				if (sstatus == "sessionOut") {
					$("#warning3").css('display', 'block');
				}
			}
		});
	}
</script>
<!-- 验证表单Tab2专柜商品 -->
<script type="text/javascript">
	function requiredProForm(){//校验
		
		if($("#proShopCode").val()==-1){
		    $("#warning2Body").text("请选择门店");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#shopBrandCode").val()==-1){
		    $("#warning2Body").text("请选择门店品牌");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#supplierCode").val()==-1){
		    $("#warning2Body").text("请选择供应商");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#counterCode").val()==-1){
		    $("#warning2Body").text("请选择专柜");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#manageCateGory").val()==""){
		    $("#warning2Body").text("请选择管理分类");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#productName").val()==""){
		    $("#warning2Body").text("请填写专柜商品名称");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#productAbbr").val()==""){
		    $("#warning2Body").text("请填写专柜商品简称");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#unitCode").val()==-1){
		    $("#warning2Body").text("请选择销售单位");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#discountLimit").val()==""){
		    $("#warning2Body").text("请填写折扣底限");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#processingType").val()==-1){
		    $("#warning2Body").text("请选择加工类型");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#marketPrice").val()==""||$("#marketPrice").val()==0){
		    $("#warning2Body").text("请填写吊牌价");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#salePrice").val()==""||$("#salePrice").val()==0){
		    $("#warning2Body").text("请填写销售价");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#inventory").val()==""||$("#inventory").val()==0){
		    $("#warning2Body").text("请填写可售库存");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		
		if($("#YTtype").val()==1){//超市
			if($("#offerNumber").val()==-1){
			    $("#warning2Body").text("请选择要约号");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
			if($("#manageType").val()==3){
			    if($("#erpProductCode").val()==-1){
				    $("#warning2Body").text("请选择ERP编码");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			    if($("#rate").val()==""){
				    $("#warning2Body").text("请填写扣率");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			}else{
			    if($("#inputTax").val()==""){
				    $("#warning2Body").text("请填写进项税");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			    if($("#consumptionTax").val()==""){
				    $("#warning2Body").text("请填写销项税");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			}
			if($("#proTable").find("tbody").html().trim()==""){
			    $("#warning2Body").text("请新增条码");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
			// 整理条码
			var tm = tmJson();
			if(tm.length==0){
			    $("#warning2Body").text("条码未填写或存在空值");
				$("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return;
			}
			$("#tmlist").val(tm);
		}else if($("#YTtype").val()==-1){//电商
			if($("#entryNumber").val()==""){
			    $("#warning2Body").text("请填写录入人员编号");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
			if($("#procurementPersonnelNumber").val()==""){
			    $("#warning2Body").text("请填写采购人员编号");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
			if($("#inputMat").val()==""){
			    $("#warning2Body").text("请填写物料号");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
		}else if($("#YTtype").val()==0){//百货
			if($("#offerNumber").val()==-1){
			    $("#warning2Body").text("请选择要约号");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
			// 百货联营 
			if($("#YTtype").val()==0&&$("#manageType").val()==3){
			    if($("#erpProductCode").val()==-1){
				    $("#warning2Body").text("请选择ERP编码");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			    if($("#rate").val()==""){
				    $("#warning2Body").text("请填写扣率");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			}else{
			    if($("#inputTax").val()==""){
				    $("#warning2Body").text("请填写进项税");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			    if($("#consumptionTax").val()==""){
				    $("#warning2Body").text("请填写销项税");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			}
		}
    	return true;
	} 
</script>
<!-- 多条码控制 -->
<script type="text/javascript">
	<!--
	var tmCount = 0;
	//增加条码
	function addTM(){
		tmCount++;
		var option = "<tr id='proTableTr_"+tmCount+"'><td style='text-align: center;'>"+
					"<div class='checkbox'>"+
						"<label style='padding-left: 5px;'>"+
							"<input type='checkbox' id='proTableTd_tmCount_"+tmCount+"' value='"+tmCount+"'  name='proTableTd_tmCount'>"+
							"<span class='text'></span>"+
						"</label>"+
					"</div></td>"+
					"<td style='text-align: center;'>"+
						"<input type='text' name='proTableTd_placeOfOrigin' class='form-control'/>"+
					"</td>"+
					"<td style='text-align: center;'>"+
						"<select name='tmlx' style='width: 100%;border-radius: 4px;'><option value='-1'>全部</option>";
						for(var i=0;i<dictResponse.data.length;i++){
						    if(dictResponse.data[i].tmlx!=null){
								for(var j=0;j<dictResponse.data[i].tmlx.length;j++){
								    var ele = dictResponse.data[i].tmlx[j];
									option+="<option value='"+ele.code+"'>"+ele.name+"</option>";
								}
						    }
						}
				option+="</select>"+
					"</td>"+
					"<td style='text-align: center;'>"+
						"<input type='text' name='proTableTd_standardBarCode' onkeyup='clearNoNum2(event,this)' onblur='checkNum2(this)' onpaste='return false;' placeholder='只允许数字' class='form-control'/>"+
					"</td></tr>";
		$("#proTable tbody").append(option);
		return;
	}
	// 删除选中的条码
	function deleteTM(){
		$("input[type='checkbox']:checked").each(function(){
			$("#proTableTr_"+$(this).val()).remove();
		});
		return;
	}
	//-->
</script>
<!-- 开关控制 -->
<script type="text/javascript">
	function isAdjustPrice() {
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
	}
</script>

<!-- 添加专柜商品 -->
<script type="text/javascript">
	<!--
	function addZGpro(){
	    /* 定义死数据业态 */
	    for(var i=0;i<dictResponse.data.length;i++){
		    if(dictResponse.data[i].yt!=null){
				$("#YTtype").append("<option value='-1'> 请选择 </option>");
			    for(var j=0;j<dictResponse.data[i].yt.length;j++){
				    var ele = dictResponse.data[i].yt[j];
						var option = "<option value='"+ele.code+"'>"+ele.name+"</option>";
				    $("#YTtype").append(option);
			    }
		    }
		}
	    
	    findShop();// 查询门店
	    $("#proShopCode").val("-1");
	    $("#s2id_proShopCode a span").each(function(i){
			if(i==0){
				$(this).text("全部");
				return;
			}
		});
	    /* 门店品牌取消选择 */
	    $("#shopBrandCode").val("-1");
	    $("#shopBrandCode").attr("disabled", "disabled");
		$("#s2id_shopBrandCode a span").each(function(i){
			if(i==0){
				$(this).text("全部");
				return;
			}
		});
		/* 供应商取消选择 */
		$("#supplierCode").val("-1");
	    $("#supplierCode").attr("disabled", "disabled");
		$("#s2id_supplierCode a span").each(function(i){
			if(i==0){
				$(this).text("全部");
				return;
			}
		});
		/* 禁用ERP编码 */
		$("#erpProductCode").val("");
		/* 禁用专柜 */
		$("#counterCode").val("-1");
		$("#counterCode").attr("disabled", "disabled");
		$("#s2id_counterCode a span").each(function(i){
			if(i==0){
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
		$("#divInputTax").hide();
		$("#divOutputTax").hide();
		$("#divConsumptionTax").hide();
		$("#divRate").hide();
		$("#divOfferNumber").hide();
		$("#proDivTable").hide();
		$("#skuSid").val();
		$("#manageType").prop("disabled","disabled");
		$("#kh").text($("#productNum").val());
		//var skuName = $("#name_"+data).html().trim();
		//$("#skuName").val(skuName);
		//$("#productName").val(skuName);
		//$("#gg").text($("#gg_"+data).html().trim());
		$("#divProcessingType").hide();
		$("a[class='accordion-toggle collapsed']").each(function(){
		    $(this).attr("class","accordion-toggle");
		    $("#"+this.id+"_1").addClass("in");
		    $("#"+this.id+"_1").attr("style","");
		});
		
		//$("#ys").text($("#ys_"+data).html().trim());
	    //$("#tx").text($("#tx_"+data).html().trim());
	    
		$("#appProDiv").show(function(){
		    $("#appProScrollTop").scrollTop(0);
		});
	}
	//-->
</script>

<!-- 保存取消关闭按钮控制 -->
<script type="text/javascript">
	function successBtn() {
		$("#modal-success").hide();
		closeProDiv();
	}
	// 关闭DIV
	function closeProDiv(){
		$("#appProDiv").hide();
	}
</script>
<!-- 专柜商品添加的折叠控制 -->
<script type="text/javascript">
	function aClick(data){
	    // 判断样式信息
	    if($("#"+data).attr("class")=="accordion-toggle"){
			$("#"+data).addClass("collapsed");
		    $("#"+data+"_1").attr("class","panel-collapse collapse");
		    $("#"+data+"_1").attr("style","height: 0px;");
	    }else{
			$("#"+data).attr("class","accordion-toggle");
		    $("#"+data+"_1").addClass("in");
		    $("#"+data+"_1").attr("style","");
	    }
	}
</script>
<!-- 保证只有两位小数的表单验证 -->
<script type="text/javascript">
	<!--
	function clearNoNum(event,obj){
		//响应鼠标事件，允许左右方向键移动
		event = window.event||event;
		if(event.keyCode == 37 | event.keyCode == 39){return;}
    	//先把非数字的都替换掉，除了数字和.-
    	obj.value = obj.value.replace(/[^\d.]/g,"");
    	//把不是在第一个的所有的-都删除
    	var index = obj.value.indexOf("-");
    	if(index!=0){
     		obj.value = obj.value.replace(/-/g,"");
    	}
    	//必须保证第一个为数或-字而不是.
    	obj.value = obj.value.replace(/^\./g,"");        
    	//保证只有出现一个.而没有多个.
    	obj.value = obj.value.replace(/\.-{2,}/g,".");
    	//保证.只出现一次，而不能出现两次以上
    	obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
    	obj.value = obj.value.replace("-","$#$").replace(/\-/g,"").replace("$#$","-");
		var index = obj.value.indexOf(".");
		if(index!=-1){
			var flag = index+3;
			if(obj.value.length>flag){
		 		obj.value =obj.value.substring(0,flag);
			}
		}
	}
	function checkNum(obj){
	    //为了去除最后一个.
	    obj.value = obj.value.replace(/\.$/g,"");
		obj.value =formatFloat(obj.value,2);
		//alert(formatFloat(obj.value,2));
	}
	function formatFloat(src, pos){
		return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
	}
	//-->
</script>
<!-- 只能输入>0的正整数   -->
<script type="text/javascript">
	<!--
	function clearNoNum2(event,obj){
		//响应鼠标事件，允许左右方向键移动
		event = window.event||event;
		if(event.keyCode == 37 | event.keyCode == 39){return;}
		//先把非数字的都替换掉，除了数字和.-
		obj.value = obj.value.replace(/[^\d]/g,"");
		//把不是在第一个的所有的-都删除
		var index = obj.value.indexOf("-");
		if(index!=0){
	 		obj.value = obj.value.replace(/-/g,"");
		}
		//必须保证第一个为数或-字而不是.
		obj.value = obj.value.replace(/^\./g,"");        
		//保证只有出现一个.而没有多个.
		//obj.value = obj.value.replace(/\.-{2,}/g,".");
		//保证.只出现一次，而不能出现两次以上
		//obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		//obj.value = obj.value.replace("-","$#$").replace(/\-/g,"").replace("$#$","-");
		var index = obj.value.indexOf(".");
		if(index!=-1){
			var flag = index+3;
			if(obj.value.length>flag){
		 		obj.value =obj.value.substring(0,flag);
			}
		}
	}
	function checkNum2(obj){
	    //为了去除最后一个.
	    obj.value = obj.value.replace(/\.$/g,"");
		obj.value =formatFloat2(obj.value,2);
	}
	function formatFloat2(src, pos){
	    if(Math.round(src*Math.pow(10, pos))/Math.pow(10, pos)==0){
			return "";
	    }else{
			return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
	    }
	}
	//-->
</script>
	
</head>
<body>
	<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
	
	<!-- Loading Container -->
    <div class="loading-container" id="loading-container">
        <div class="loading-progress">
            <div class="rotator">
                <div class="rotator">
                    <div class="rotator colored">
                        <div class="rotator">
                            <div class="rotator colored">
                                <div class="rotator colored"></div>
                                <div class="rotator"></div>
                            </div>
                            <div class="rotator colored"></div>
                        </div>
                        <div class="rotator"></div>
                    </div>
                    <div class="rotator"></div>
                </div>
                <div class="rotator"></div>
            </div>
            <div class="rotator"></div>
        </div>
    </div>
    <!--  /Loading Container -->
	
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
                                    <span class="widget-caption"><h5>商品管理</h5></span>
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
                                    	<!-- <div class="col-md-2">
                                    		<div class="col-md-12">
		                                    	<a id="editabledatatable_new" onclick="getProduct();" class="btn btn-yellow" style="width: 99.99%;">
		                                    		<i class="fa fa-eye"></i>
													查询详情
		                                        </a>
		                                    </div>
                                        </div> -->
                                       <!--  <div class="col-md-2">
                                        	<div class="col-md-12">
		                                        <a id="editabledatatable_new" onclick="addProduct();" class="btn btn-primary" style="width: 99.99%;">
		                                        	<i class="fa fa-plus"></i>
													添加商品
		                                        </a>
		                                    </div>
	                                    </div> -->
	                                    <div class="col-md-2">
	                                    	<div class="col-md-12">
		                                        <a id="editabledatatable_new" onclick="addZGpro();" class="btn btn-info" style="width: 100%;">
		                                        	<i class="fa fa-plus"></i>
													新增专柜商品
		                                        </a>
		                                    </div>
	                                    </div>
	                                    <div class="col-md-12">
                                        	<div class="col-md-12">&nbsp;
		                                    </div>
	                                    </div>
                                    	<div class="col-md-4">
	                                		<label class="col-md-12 control-label">商品名称：
	                                			<input type="text" id="shoppeProName_input" style="width: 60%" />
	                                		</label>
	                                	</div>
	                                	<div class="col-md-4">
	                                		<label class="col-lg-12 control-label">是否可售：
		                                		<select id="saleStatus_select" style="padding: 0 0;width: 60%">
		                                			<option value="">全部</option>
		                                			<option value="Y">可售</option>
		                                			<option value="N">不可售</option>
		                                		</select>
		                                	</label>
	                                	</div>
	                                	<!-- <div class="col-md-4">
	                                		<div class="col-lg-5"><span>品牌：</span></div>
	                                		<div class="col-lg-7"><input type="text" id="brandName_input" style="width: 100%"/></div>
	                                	</div>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-5"><span>是否上架：</span></div>
	                                		<div class="col-lg-7">
		                                		<select id="proSelling_select" style="padding: 0 0;width: 100%">
		                                			<option value="">全部</option>
		                                			<option value="0">未上架</option>
		                                			<option value="1">已上架</option>
		                                		</select>
		                                	</div>
	                                	</div> -->
	                                	<!-- <div class="col-md-4">
	                                		<label class="col-lg-12 control-label">类型:
		                                		<select id="proType_select" style="padding: 0 0;width: 70%">
		                                			<option value="">全部</option>
		                                			<option value="0">普通商品</option>
		                                			<option value="1">赠品</option>
		                                			<option value="2">礼品</option>
		                                			<option value="3">虚拟商品</option>
		                                			<option value="4">服务类商品</option>
		                                		</select>
		                                	</label>
	                                	</div> -->
	                                	<div class="col-md-4">
	                                		<div class="col-md-12">
                                				<a class="btn btn-default btn-sm" onclick="query();" style="margin-top:-2px;width: 30%">查询</a>&nbsp;
                                				<a class="btn btn-default btn-sm" onclick="reset();" style="margin-top:-2px;width: 30%">重置</a>
                                			</div>&nbsp;
                                		</div>
                                	</div>
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="product_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr>
                                            	<th width="7.5%"></th>
                                            	<th style="text-align: center;">门店</th>
                                                <th style="text-align: center;">专柜编码</th>
                                                <th style="text-align: center;">编码</th>
                                                <th style="text-align: center;">名称</th>
                                                <th style="text-align: center;">供应商</th> 
                                                <th style="text-align: center;">门店品牌</th>
                                                <th style="text-align: center;">管理分类</th>
                                                <th style="text-align: center;">状态</th>                                                                                               
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                     <div class="pull-left" style="padding: 10px 0;">
                                   		 <form id="product_form" action="">
                                     		<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp;
											<input type="hidden" id="skuSid_hidden" name="productDetailSid" value="${sku.sid}" />
											<input type="hidden" id="skuCode_hidden"  value="${sku.skuCode}" />
											<input type="hidden" id="shoppeProName_from" name="shoppeProName"/>
											<input type="hidden" id="saleStatus_from" name="saleStatus"/>
											<!-- <input type="hidden" id="proActiveBit_from" name="proActiveBit"/>
											<input type="hidden" id="proSelling_from" name="proSelling"/>
											<input type="hidden" id="proType_from" name="proType"/> -->
                                      	</form>
                                      </div>
                                    <div id="productPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="product-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
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
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Page Body -->
            </div>
            <!-- /Page Content -->
        </div>
        <!-- /Page Container -->
    <!-- Add DIV root classification used -->
	<div class="modal modal-darkorange" id="appProDiv">
        <div class="modal-dialog" style="width: 80%;margin-top: 80px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeProDiv();">×</button>
                    <h4 class="modal-title">专柜商品添加</h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body" id="appProScrollTop"
                		style="overflow-x: hidden;overflow-y: auto;height: 420px;">
				        <div class="row" style="padding: 10px;">
				            <div class="col-lg-12 col-sm-12 col-xs-12">
				            	<form id="proForm" method="post" class="form-horizontal">
				            		<div id="accordions" class="panel-group accordion">
			                            <div class="panel panel-default">
			                                <div class="panel-heading">
			                                    <h4 class="panel-title">
			                                        <a onclick="aClick(this.id);" id="collapseOnes" class="accordion-toggle" style="cursor: pointer;">
														供应商专柜信息<font id="collapseOnes_font" style="color: red;">(以下信息必填)</font>
			                                        </a>
			                                    </h4>
			                                </div>
			                                <div class="panel-collapse collapse in" id="collapseOnes_1">
			                                    <div class="panel-body border-red">
			                                        <div class="col-md-4">
														<label class="control-label">门店：</label>
														<select id="proShopCode" name="shopCode" style="width: 70%;float: right;"></select>
													</div>
													<div class="col-md-4">
														<label class="control-label">门店品牌：</label>
														<select id="shopBrandCode" style="width: 70%;float: right;"></select>
													</div>
													<div class="col-md-4">
														<label class="control-label">业态：</label>
														<select id="YTtype" style="width: 70%;float: right;" onchange="manageTypeFunct();" disabled="disabled"></select>
														<input type="hidden" id="YTtype_" name="type" />
													</div>
													<div class="col-md-12">
														<hr class="wide" style="margin-top: 0;border-top: 0px solid #e5e5e5;">
													</div>
													<div class="col-md-4">
														<label class="control-label">供应商：</label>
														<select style="width: 70%;float: right;" id="supplierCode" name="supplierCode">
															<option value="-1">全部</option>
														</select>
													</div>
													<div class="col-md-4">
														<label class="control-label">专柜：</label>
														<select style="width: 70%;float: right;" id="counterCode" name="counterCode">
															<option value="-1">全部</option>
														</select>
													</div>
													<div class="col-md-4">
														<label class="control-label">经营方式：</label>
														<select id="manageType" style="width: 70%;float: right;"></select>
														<input type="hidden" id="manageTypeForm" name="manageType"/>
													</div>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="panel panel-default">
			                                <div class="panel-heading">
			                                    <h4 class="panel-title">
			                                        <a onclick="aClick(this.id);" id="yyDiv" class="accordion-toggle" style="cursor: pointer;">
														要约信息<font id="yyDiv_font" style="color: red;">(以下信息必填)</font>
			                                        </a>
			                                    </h4>
			                                </div>
			                                <div class="panel-collapse collapse in" id="yyDiv_1">
			                                    <div class="panel-body border-red">
			                                        <div class="col-md-4" id="materialNumber">
														<label class="control-label">物料号：</label>
															<input type="text" class="form-control" id="inputMat" name="inputMat"
																 style="width: 70%;float: right;" 
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)" onpaste="return false;" maxLength=20
															/>
													</div>
			                                    	<div class="col-md-4" id="divOfferNumber">
														<label class="control-label"><font style="color: red;">*</font>要约号：</label>
														<select id="offerNumber" name="offerNumber" onchange="offerNumberChange();" style="width: 70%;float: right;" >
															<option value="-1">请选择</option>
														</select>
													</div>
													<div class="col-md-4" id="ERP">
														<label class="control-label">ERP编码：</label>
														<select id="erpProductCode" onchange="erpProductCodeChange();"
															name="erpProductCode" style="width: 70%;float: right;"></select>
													</div>
													<div class="col-md-4" id="divRate">
														<label class="control-label">扣率：</label>
														<input class="form-control" id="rate"
															name="rate" style="width: 70%;float: right;" readonly />
													</div>
													<div class="col-md-12">
														<hr class="wide" style="margin-top: 0;border-top: 0px solid #e5e5e5;">
													</div>
													<div class="col-md-4" id="divInputTax">
														<label class="control-label">进项税：</label>
															<input type="text" class="form-control" id="inputTax" name="inputTax"
																 style="width: 70%;float: right;" 
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)" onpaste="return false;" maxLength=10
															/>
													</div>
													<div class="col-md-4" id="divOutputTax">
														<label class="control-label">消费税：</label>
														<input type="text" class="form-control" id="outputTax"
																name="outputTax" style="width: 70%;float: right;" 
														onkeyup="clearNoNum(event,this)" onblur="checkNum(this)" onpaste="return false;" maxLength=10
														/>
													</div>
													<div class="col-md-4" id="divConsumptionTax">
														<label class="control-label">销项税：</label>
														<input type="text" class="form-control" id="consumptionTax"
															name="consumptionTax" style="width: 70%;float: right;" 
														onkeyup="clearNoNum(event,this)" onblur="checkNum(this)" onpaste="return false;" maxLength=10	
														/>
													</div>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="panel panel-default">
			                                <div class="panel-heading">
			                                    <h4 class="panel-title">
			                                        <a onclick="aClick(this.id);" id="manageCateGoryDiv" class="accordion-toggle" style="cursor: pointer;">
														管理分类信息<font id="manageCateGoryDiv_font" style="color: red;">(以下信息必填)</font>
			                                        </a>
			                                    </h4>
			                                </div>
			                                <div class="panel-collapse collapse in" id="manageCateGoryDiv_1">
			                                    <div class="panel-body border-red">
			                                    	<div class="col-md-6">
														<label class="col-md-4 control-label">管理分类：</label>
														<div class="col-md-8">
															<div class="btn-group" style="width: 100%"
																id="proBtnGroup">
																<a href="javascript:void(0);" class="btn btn-default"
																	id="proA"
																	style="width: 85%;">请选择</a>
																<a id="proTreeDown" href="javascript:void(0);"
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
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="panel panel-default">
			                                <div class="panel-heading">
			                                    <h4 class="panel-title">
			                                        <a onclick="aClick(this.id);" id="skuDiv" class="accordion-toggle" style="cursor: pointer;">
														专柜商品信息<font id="skuDiv_font" style="color: red;">(以下信息必填)</font>
			                                        </a>
			                                    </h4>
			                                </div>
			                                <div class="panel-collapse collapse in" id="skuDiv_1">
			                                    <div class="panel-body border-red">
			                                    	<c:if test="${sku.industryCondition==0}">
				                                    	<div class="col-md-4">
															<label class="col-md-4">款号：</label>
															<div class="col-md-8">
																<span id="kh" >${sku.modelCode}</span>
															</div>
														</div>	
														<div class="col-md-4" id="divYs">
															<label class="col-md-4">颜色：</label>
															<div class="col-md-8">
																<span id="ys">${sku.colorCodeName}</span>
															</div>
														</div>
													</c:if>
													<c:if test="${sku.industryCondition==1}">
														<div class="col-md-4">
															<label class="col-md-4">主属性：</label>
															<div class="col-md-8">
																<span id="kh" >${sku.primaryAttr}</span>
															</div>
														</div>	
														<div class="col-md-4" id="divTx">
															<label class="col-md-4">特性：</label>
															<div class="col-md-8">
																<span id="tx">${sku.features}</span>
															</div>
														</div>
													</c:if>
													<div class="col-md-6">
														<label class="col-md-4 control-label">专柜商品名称：</label>
														<div class="col-md-8">
															<input class="form-control" id="productName"
																name="productName" value="${sku.skuName}"
															onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20
															/>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">专柜商品简称：</label>
														<div class="col-md-8">
															<input class="form-control" id="productAbbr"
																name="productAbbr" style="width: 100%" 
															onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20
															/>
														</div>&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">销售单位：</label>
														<div class="col-md-8">
															<select id="unitCode" name="unitCode" style="width: 100%"></select>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">折扣底限：</label>
														<div class="col-md-8">
															<input class="form-control" id="discountLimit"
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)" onpaste="return false;" maxLength=5
																name="discountLimit" style="width: 100%" />
														</div>&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">是否允许ERP促销：</label>
														<div class="col-md-8">
															<label class="control-label"> 
															<input
																type="checkbox" id="isAdjustPrice" value="on"
																class="checkbox-slider toggle yesno"> 
																<span class="text"></span>
															</label>
															<input type="hidden" id="isAdjustPriceInput"
																name="isAdjustPrice" value="1">
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">是否允许ERP调价：</label>
														<div class="col-md-8">
															<label class="control-label"> <input
																type="checkbox" id="isPromotion" 
																value="on"
																class="checkbox-slider toggle yesno"> 
																<span class="text"></span>
															</label> 
															<input 
																type="hidden" 
																id="isPromotionInput"
																name="isPromotion" value="1">
														</div>&nbsp;
													</div>
													<div class="col-md-6" id="divProcessingType">
														<label class="col-md-4 control-label">加工类型：</label>
														<div class="col-md-8">
															<select id="processingType"
																name="processingType" style="width: 100%" >
																<option value="-1">全部</option>
																<option value="1">单品</option>
																<option value="2">分割原材料</option>
																<option value="3">原材料</option>
																<option value="4">成品</option>
															</select>
														</div>
													</div>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="panel panel-default">
			                                <div class="panel-heading">
			                                    <h4 class="panel-title">
			                                        <a onclick="aClick(this.id);" id="priceStockDiv" class="accordion-toggle" style="cursor: pointer;">
														价格库存信息
														<font id="priceStockDiv_font" style="color: red;">(以下信息必填)</font>
			                                        </a>
			                                    </h4>
			                                </div>
			                                <div class="panel-collapse collapse in" id="priceStockDiv_1">
			                                    <div class="panel-body border-red">
			                                    	<div class="col-md-4">
														<label class="col-md-4 control-label">吊牌价：</label>
														<div class="col-md-8">
															<input class="form-control" id="marketPrice"
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)" onpaste="return false;" maxLength=20
																name="marketPrice" style="width: 100%" />
														</div>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label">销售价：</label>
														<div class="col-md-8">
															<input class="form-control" id="salePrice"
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)" onpaste="return false;" maxLength=20
																name="salePrice" style="width: 100%" />
														</div>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label">可售库存：</label>
														<div class="col-md-8">
															<input class="form-control" id="inventory"
																name="inventory" style="width: 100%" 
															onkeydown=if(event.keyCode==13)event.keyCode=9 onkeyup="value=value.replace(/[^0-9- ]/g,'');" maxLength=20
															/>
														</div>
													</div>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="panel panel-default">
			                                <div class="panel-heading">
			                                    <h4 class="panel-title">
			                                        <a onclick="aClick(this.id);" id="dqdDiv" class="accordion-toggle" style="cursor: pointer;">
														其他信息
														<font id="dqdDiv_font" style="color: red;">(以下信息必填)</font>
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
															onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=10	
															/>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">采购人员编号：</label>
														<div class="col-md-8">
															<input class="form-control" id="procurementPersonnelNumber"
																name="procurementPersonnelNumber" style="width: 100%" 
															onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=10
															/>
														</div>&nbsp;
													</div>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="panel panel-default">
			                                <div class="panel-heading">
			                                    <h4 class="panel-title">
			                                        <a onclick="aClick(this.id);" id="tmDiv" class="accordion-toggle" style="cursor: pointer;">
														条码信息
														<font id="tmDiv_font" style="color: red;">(以下信息必填)</font>
			                                        </a>
			                                    </h4>
			                                </div>
			                                <div class="panel-collapse collapse in" id="tmDiv_1">
			                                    <div class="panel-body border-red">
													<div style="width: 100%;">
														<div class="widget-header ">
															<span class="widget-caption">多条码添加</span>
															<div class="widget-buttons">
																<a data-toggle="collapse" style="color: green;cursor: pointer;"> 
																	<span class="fa fa-plus"
																	onclick="addTM();">新增</span>
																</a> 
																<a data-toggle="collapse" style="color: red;cursor: pointer;"> 
																	<span
																	class="fa fa-trash-o" onclick="deleteTM()">删除</span>
																</a>
															</div>
														</div>
														<table id="proTable" class="table table-bordered table-striped table-condensed table-hover flip-content">
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
										<input type="hidden" id="skuSid" name="skuSid" value="${sku.sid}" />
										<input type="hidden" id="skuName" name="skuName" value="${sku.skuName}" />
										<input type="hidden" id="tmlist" name="barcodes" />
									</div>
									<!-- /yincangDiv -->
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input type="button" class="btn btn-success" style="width: 25%;"
												id="proSave" value="保存" >&emsp;&emsp; 
												<input onclick="closeProDiv();" 
												class="btn btn-danger" style="width: 25%;" id="close"
												type="button" value="取消" />
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
</body>
</html>