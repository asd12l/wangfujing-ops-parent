<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
WFJBackWeb - 专柜商品管理列表页
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<style type="text/css">
    .listInfo li {
        float: left;
        height: 35px;
        margin: 1px 1px 1px 0;
        overflow: hidden;
    }
</style>
<!--Jquery Select2-->

<script
	src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">
	
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">
	
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js">
	
</script>
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/bootstrap/css/bootstrap.min.css"/> --%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link
	href="${pageContext.request.contextPath}/js/bootstrap/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.js"
	charset="UTF-8"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.min.js"
	charset="UTF-8"></script>
<script
	src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.zh-CN.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>

<style>
.form-control[disabled],.form-control[readonly],fieldset[disabled] .form-control
	{
	cursor: pointer;
}
</style>
<!-- 专柜商品列表页展示及查询 -->
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";
	var productPagination;
	$(function() {
		selectAllShop();
		$('.form_datetime').datetimepicker({
			format : 'yyyy-mm-dd hh:ii:00',
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0
		});
		$('.form_date').datetimepicker({
			format : 'yyyy-mm-dd hh:ii:00',
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			minView : 2,
			forceParse : 0
		});
		$('.form_time').datetimepicker({
			format : 'yyyy-mm-dd hh:ii:00',
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 1,
			minView : 0,
			maxView : 1,
			forceParse : 0
		});
		$("#categoryDIV").hide();
		initProduct();
		$("#saleStatus_select").change(productQuery);
		$("#shoppe_select").change(productQuery);
		$("#pageSelect").change(productQuery);

		$("#isAdjustPrice").click(function() {
			isAdjustPrice();
		});
		$("#isPromotion").click(function() {
			isPromotion();
		});
		$("#proSave").click(function() {
			proForm();
		});
		$("#loading-container").addClass("loading-inactive");
		$(".select2-arrow b").attr("style", "line-height: 2;");
		$("#resetQuery").attr("disabled", "disabled");
		
	});
	//专柜商品查询
	function productQuery() {
		var minShoppeProSid = $("#shoppeProSid_input").val();
		var maxShoppeProSid = $("#maxShoppeProSid_input").val();
		if(minShoppeProSid != "" && maxShoppeProSid != ""){
			$("#minShoppeProSid_from").val(minShoppeProSid);
			$("#maxShoppeProSid_from").val(maxShoppeProSid);
		} else if(minShoppeProSid != "" && maxShoppeProSid == ""){
			$("#shoppeProSid_from").val(minShoppeProSid);
		} else if(minShoppeProSid == "" && maxShoppeProSid != ""){
			$("#shoppeProSid_from").val(maxShoppeProSid);
		} else if(minShoppeProSid == "" && maxShoppeProSid == ""){
			$("#shoppeProSid_from").val("");
			$("#minShoppeProSid_from").val("");
			$("#maxShoppeProSid_from").val("");
		}
		var minSkuCode = $("#skuCode_input").val();
		var maxSkuCode = $("#maxSkuCode_input").val();
		if(minSkuCode != "" && maxSkuCode != ""){
			$("#minSkuCode_from").val(minSkuCode);
			$("#maxSkuCode_from").val(maxSkuCode);
		} else if(minSkuCode != "" && maxSkuCode == ""){
			$("#skuCode_from").val(minSkuCode);
		} else if(minSkuCode == "" && maxSkuCode != ""){
			$("#skuCode_from").val(maxSkuCode);
		}else if(minSkuCode == "" && maxSkuCode == ""){
			$("#skuCode_from").val("");
			$("#minSkuCode_from").val("");
			$("#maxSkuCode_from").val("");
		}
		$("#shoppeProName_from").val($("#shoppeProName_input").val());
		$("#materialNumber_from").val($("#materialNumber_input").val());
		$("#saleStatus_from").val($("#saleStatus_select").val());
		$("#shoppe_from").val($("#shoppe_select").val());
		$("#shop_from").val($("#shop_select option:selected").attr("code"));
		$("#supplier_from").val($("#supplier_select option:selected").attr("code"));
		var params = $("#product_form").serialize();
		//alert("表单序列化后请求参数:"+params);
		params = decodeURI(params);
		productPagination.onLoad(params);
	}
	// 查询
	function query() {
		productQuery();
	}
	// 重置
	function reset() {
		$('#supplier_select').prop("disabled", "disabled").select2();
		$('#shoppe_select').prop("disabled", "disabled").select2();
		$("#shoppeProSid_input").val("");
		$("#maxShoppeProSid_input").val("");
		$("#skuCode_input").val("");
		$("#maxSkuCode_input").val("");
		$("#shoppeProName_input").val("");
		$("#materialNumber_input").val("");
		$("#saleStatus_select").val("");
		$("#shoppe_select").val("").select2();
		$("#shop_select").val($('#shop_select option:eq(0)').val()).select2();
		$("#supplier_select").val("").select2();
		productQuery();
		init_1();
	}
	//初始化专柜商品列表
	function initProduct() {
		var url = $("#ctxPath").val() + "/product/selectShoppeProductFromSearch";
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
						url : url,
						dataType : 'json',
						param : 'productDetailSid='
								+ $("#skuCode_hidden").val()
								+ "&field5=" + $("#shop_select option:selected").attr("code"),
						ajaxStart : function() {
							$(".loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							$(".loading-container")
									.addClass("loading-inactive");
						},
						callback : function(data) {
							//使用模板
							$("#product_tab tbody").setTemplateElement(
									"product-list").processTemplate(data);
							if(data != null && data.total != null){
								$("#total").text(data.total);
							}
						}
					}
				});
	}
	//查询所有门店
	function selectAllShop(){
		$.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=utf-8",
            url : __ctxPath + "/shoppe/queryShopListAddPermission",
            dataType : "json",
            async : false,
            data : "organizationType=3",
            success : function(response) {
            	if(response.success == "true"){
            		var result = response.list;
                    for (var i = 0; i < result.length; i++) {
                        var ele = result[i];
                        var option = $("<option value='" + ele.sid + "' code='" + ele.organizationCode + "'>" + ele.organizationName + "</option>");
                        option.appendTo($("#shop_select"));
                    }
            	} else {
            		var option = $("<option value='' code='0'></option>");
            		option.appendTo($("#shop_select"));
            	}
                return;
            },
            error : function(XMLHttpRequest, textStatus) {
                var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
                if(sstatus != "sessionOut"){
                    $("#warning2Body").text("系统错误!");
                    $("#warning2").show();
                }
                if(sstatus=="sessionOut"){
                    $("#warning3").css('display','block');
                }
            }
        });
		$("#shop_select").val($('#shop_select option:eq(0)').val()).select2();
	}
</script>
<!-- 点击编码或者名称查询详情 -->
<script type="text/javascript">
	function getView(data) {
		var url = __ctxPath + "/product/selectShoppeProductByCode1/" + data;
		$(".loading-container").attr("class", "loading-container");
		$("#pageBody").load(url, {
			"backUrl" : "/jsp/product/shoppeProductView_List.jsp"
		}, function(){
			$(".loading-container").addClass("loading-inactive");
		});
	}
	
	//根据门店查询供应商
	function selectSupplierByShop(){
		$('#supplier_select').html("<option selected='selected' value='' code=''>全部</option>");
		$('#supplier_select').select2();
		var organizationCode = $("#shop_select option:selected").attr("code");
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/supplierDisplay/findListSupplier",
			dataType : "json",
			async : false,
			data : "shopCode=" + organizationCode,
			success : function(response) {
				var result = response.list;
				if(typeof(result) != "undefined"){
					for (var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "' code='" + ele.supplyCode + "'>"
								+ ele.supplyName + "</option>");
						option.appendTo($("#supplier_select"));
					}
				}
				return;
			},
			error : function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
					$("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
	}
</script>
<!-- 保存取消关闭按钮控制 -->
<script type="text/javascript">
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({
					"display" : "none"
				});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({
					"display" : "block"
				});
			}
		}
	}
	function successBtn() {
		$("#modal-success").hide();
		closeProDiv();
	}
	function proSaveSuccess() {
		$("#proSaveSuccess").hide();
		$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
	}
	function proWarningBtn() {
		$("#proWarning").hide();
	}
	// 关闭DIV
	function closeProDiv() {
		$("#editKLMDIV").hide();
	}

	function closeCategoryDiv() {
		$("#categoryDIV").hide();
		$("#categoryDIV2").hide();
		$("#categoryDIV3").hide();
		$("#categoryDIV4").hide();
		$("#categoryDIV5").hide();
		$("#categoryDIV6").hide();
		$("#categoryDIV7").hide();
	}
</script>
<!-- 换扣率码 -->
<script type="text/javascript">
	var supplierName;
	var industryCondition;
	var discountCode;
	var productCode;

	function editKLM() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			$("#divId").val(productSid)
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个专柜商品!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要换的专柜商品!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		/* 供应商名称 */
		supplierName = $("#supplierName_" + value).html().trim();
		/* 业态 */
		industryCondition = $("#industryCondition_" + value).html().trim();
		/* 扣率码 */
		discountCode = $("#discountCode_" + value).html().trim();
		$("#discountCode").val(discountCode)

		productCode = $("#productCode_" + value).html().trim();

		$("#divId").val(productCode);
		/* 不等于WFJ和业态为0 */
		/* 是百货联营 */
		if (supplierName != "WFJ" && industryCondition == "0") {
			/* 回显修改信息 */
			$("#categoryDIV").show();
			// 		    $("#editKLMDIV").attr("style","display:block;");
		} else {
			$("#warning2Body").text("非百货联营商品,无扣率码!");
			$("#warning2").show();
			return false;
		}
	}
	/* 换扣率码 */
	function edit() {

		var discountCodeval = $("#discountCode").val();
		var shoppeProSid = $("#divId").val();

		if (discountCodeval == "") {
			$("#warning2Body", parent.document).text("扣率码不能为空！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}
		if (discountCode == discountCodeval) {
			$("#warning2Body", parent.document).text("信息未改变，无需修改！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}
		$
				.ajax({
					type : "post",
					url : __ctxPath + "/product/updateRateCode",
					data : {
						"rateCode" : discountCodeval,
						"shoppeProSid" : shoppeProSid
					},
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					success : function(response) {
						if (response.success == "false") {
							$("#categoryDIV").hide();
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
							$("#warning2").show();
						} else {
							$("#categoryDIV").hide();
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<i class='fa fa-check-circle'></i><strong>操作成功，返回列表!</strong></div>");
							$("#modal-success")
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							productQuery();
						}

					}
				});
	}
</script>
<!-- 换专柜 -->
<script type="text/javascript">
	var counterCode;

	function editZG() {

		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			$("#divId").val(productSid)
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个专柜商品!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").html(
					"<i class='fa fa-warning'></i><span>请选取要换的专柜商品!</span>");
			$("#warning2").show();
			return false;
		} else {
			/* 回显修改信息 */
			$("#categoryDIV2").show();
			//查询所有装柜，回显已选中的
			var shoppeCode = $("#shoppeCode");
			//获取专柜编码
			var value = checkboxArray[0];
			/* 扣率码 */
			/* 专柜商品编码 */
			var productCode = $("#productCode_" + value).html().trim();
			//经营方式编码
			var operateMode = $("#operateMode_" + value).html().trim();
			//门店sid
			var storeSid = $("#storeSid_" + value).html().trim();
			//门店编码
			var storeCode2 = $("#storeCode_" + value).html().trim();
			$("#divId").val(productCode);
			//专柜编码
			counterCode = $("#counterCode_" + value).html().trim();

			$("#activeTime").val("");
			$
					.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/product/findListShoppe",
						data : {
							"shopSid" : storeSid,
							"businessTypeSid" : operateMode,
						},
						dataType : "json",
						success : function(response) {
							var result = response.data;
							shoppeCode.find("option").remove();
							for ( var i = 0; i < result.length; i++) {
								var ele = result[i];
								var option = "";
								if (ele.shoppeCode == counterCode) {
									option = $("<option selected='selected'  value='" + ele.shoppeCode + "'>"
											+ ele.shoppeName + "</option>");
								} else {
									option = $("<option value='" + ele.shoppeCode + "'>"
											+ ele.shoppeName + "</option>");
								}

								option.appendTo(shoppeCode);
							}
							return;
						},
						/* error : function() {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-error"
							});
						} */
						error : function(XMLHttpRequest, textStatus) {
							var sstatus = XMLHttpRequest
									.getResponseHeader("sessionStatus");
							if (sstatus != "sessionOut") {
								$("#model-body-warning")
										.html(
												"<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
								$("#modal-warning").attr({
									"style" : "display:block;",
									"aria-hidden" : "false",
									"class" : "modal modal-message modal-error"
								});
							}
							if (sstatus == "sessionOut") {
								$("#warning3").css('display', 'block');
							}
						}
					});
		}

	}

	//修改专柜
	function updateShoppe() {
		var shoppeSid = $("#shoppeCode").val();
		var shoppeProSid = $("#divId").val();
		var activeTime = $("#activeTime").val();

		if (activeTime == "") {
			$("#warning2Body", parent.document).text("请选择生效日期！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}
		if (counterCode == shoppeSid) {
			$("#warning2Body", parent.document).text("信息未改变，无需修改！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}
		$.ajax({
			type : "post",
			url : __ctxPath + "/product/updateShoppe",
			data : {
				"shoppeCode" : shoppeSid,
				"shoppeProSid" : shoppeProSid,
				"activeTime" : activeTime
			},
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				if (response.success == "false") {
					$("#categoryDIV2").hide();
					/* $("#modal-body-success").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>" + response.data.errorCode
									+ response.data.errorMsg
									+ "!</strong></div>");
					$("#modal-success")
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					}); */
					$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					$("#warning2").show();
				} else {
					$("#categoryDIV2").hide();
					$("#modal-body-success").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>操作成功，返回列表!</strong></div>");
					$("#modal-success")
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					productQuery();
				}

			}
		});
	}
</script>
<!-- 换品牌 -->
<script type="text/javascript">
	var brandSid;

	function editPP() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			$("#divId").val(productSid)
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个专柜商品!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要换的专柜商品!");
			$("#warning2").show();
			return false;
		} else {
			/* 回显修改信息 */
			$("#categoryDIV4").show();
			//查询所有门店，回显已选中的
			var brandCodes = $("#brandCode");
			//获取专柜编码
			var value = checkboxArray[0];
			/* 门店品牌sid */
			brandSid = $("#brandSid_" + value).html().trim();
			//门店编码
			var storeCode = $("#storeCode_" + value).html().trim();
			/* 专柜商品sid */
			var sid = $("#tdCheckbox_" + value).val();
			$("#divId").val(sid);
			$("#activeTimes").val("");

			$
					.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/product/selectAllBrand",
						data : {
							"shopCode" : storeCode
						},
						dataType : "json",
						success : function(response) {
							var result = response.data;
							brandCodes.find("option").remove();
							for ( var j = 0; j < result.length; j++) {
								var ele = result[j];
								var option = "";
								if (ele.sid == brandSid) {
									option = $("<option selected='selected'  value='" + ele.sid + "'>"
											+ ele.brandName + "</option>");
								} else {
									option = $("<option value='" + ele.sid + "'>"
											+ ele.brandName + "</option>");
								}
								option.appendTo(brandCodes);
							}
							return;
						},
						/* error : function() {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-error"
							});
						} */
						error : function(XMLHttpRequest, textStatus) {
							var sstatus = XMLHttpRequest
									.getResponseHeader("sessionStatus");
							if (sstatus != "sessionOut") {
								$("#model-body-warning")
										.html(
												"<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
								$("#modal-warning").attr({
									"style" : "display:block;",
									"aria-hidden" : "false",
									"class" : "modal modal-message modal-error"
								});
							}
							if (sstatus == "sessionOut") {
								$("#warning3").css('display', 'block');
							}
						}
					});
		}
	}

	/* 执行修改品牌和款号 */
	function updateBrand() {
		//专柜商品sid
		var sid = $("#divId").val();
		//换品牌生效时间
		var activeTime = $("#activeTimes").val();

		if (activeTime == "") {
			$("#warning2Body", parent.document).text("请选择生效日期！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}
		//品牌编码
		var brand = $("#brandCode").val();

		//  修改品牌
		if (brand == brandSid) {
			$("#warning2Body", parent.document).text("信息未改变，无需修改！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}

		$
				.ajax({
					type : "post",
					url : __ctxPath + "/product/updateBrand",
					data : {
						"sid" : sid,
						"brandCode" : brand,
						"activeTime" : activeTime
					},
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					success : function(response) {
						if (response.data.errorCode == "00200129") {
							$("#categoryDIV4").hide();
							/* $("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>新更换品牌与原品牌不能相同!</strong></div>");
							$("#modal-success")
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							}); */
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,"新更换品牌与原品牌不能相同！"));
							$("#warning2").show();
						} else if (response.data.errorCode == "00200128") {
							$("#categoryDIV4").hide();
							/* $("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>新门店品牌不存在!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							}); */
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,"新门店品牌不存在！"));
							$("#warning2").show();
						} else if (response.data.errorCode == "00200132") {
							$("#categoryDIV4").hide();
							/* $("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>专柜商品修改品牌失败!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							}); */
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,"专柜商品修改品牌失败！"));
							$("#warning2").show();
						} else if (response.data.errorCode == "00200127") {
							$("#categoryDIV4").hide();
							/* $("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>找不到对应的专柜商品!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							}); */
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,"找不到对应的专柜商品！"));
							$("#warning2").show();
						} else if (response.data.errorCode == "00200133") {
							$("#categoryDIV4").hide();
							/* $("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>校验专柜商品失败!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							}); */
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,"校验专柜商品失败！"));
							$("#warning2").show();
						} else if (response.data.errorCode == "00200134") {
							$("#categoryDIV4").hide();
							/* $("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>新品牌下存在相同的专柜商品，不允许更换!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							}); */
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,"新品牌下存在相同的专柜商品，不允许更换！"));
							$("#warning2").show();
						} else {
							$("#categoryDIV4").hide();
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>操作成功，返回列表!</strong></div>");
							$("#modal-success")
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							productQuery();
						}

					}
				});
	}
</script>
<script type="text/javascript">
	var modelCode;

	function editKH() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			$("#divId").val(productSid)
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个专柜商品!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要换的专柜商品!");
			$("#warning2").show();
			return false;
		} else {
			/* 回显修改信息 */
			$("#categoryDIV7").show();
			//获取专柜编码
			var value = checkboxArray[0];
			/* 款号 */
			modelCode = $("#modelCode_" + value).html().trim();
			$("#kuanhao").val(modelCode);
			/* 专柜商品sid */
			var sid = $("#tdCheckbox_" + value).val();
			$("#divId").val(sid);
			/* 装柜商品编码 */
			var shoppeProSid = $("#productCode_" + value).html().trim();
			$("#shoppeProSid").val(shoppeProSid);
		}
	}

	/* 执行修改款号 */
	function updateMcode() {
		//专柜商品sid
		var sid = $("#divId").val();
		//装柜商品编码
		var productCode = $("#shoppeProSid").val();

		//款号
		var modelCode1 = $("#kuanhao").val();
		//  修改品牌
		if (modelCode == modelCode1) {
			$("#warning2Body", parent.document).text("信息未改变，无需修改！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}

		$.ajax({
			type : "post",
			url : __ctxPath + "/product/updateModelCode",
			data : {
				"modelCode" : modelCode1,
				"shoppeProSid" : productCode
			},
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				if (response.success == "false") {
					$("#categoryDIV7").hide();
					$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					$("#warning2").show();
				} else {
					$("#categoryDIV7").hide();
					$("#modal-body-success").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>操作成功，返回列表!</strong></div>");
					$("#modal-success")
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					productQuery();
				}

			}
		});
	}
</script>

<!-- 换色码(特性)规格 -->
<script type="text/javascript">
	/* 色系列表 */
	function fingColorDict(colorSid_, proColor_) {
		var proColor = $("#proColorSid");// 色系对象
		proColor.html("<option value='"+colorSid_+"'>" + proColor_
				+ "</option>");
		$
				.ajax({
					type : "post",
					async : false,
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/colorManage/fingColorDict",
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").prop("class",
								"loading-container");
					},
					ajaxStop : function() {
						$("#loading-container").addClass("loading-inactive");
					},
					success : function(response) {
						var result = response.list;
						proColor.html("<option value='-1'>全部</option>");
						for ( var i = 0; i < result.length; i++) {
							var ele = result[i];
							var option = "";
							if (ele.sid == colorSid) {
								option = $("<option value='" + ele.sid + "' selected='selected'>"
										+ ele.colorName + "</option>");
							} else {
								option = $("<option value='" + ele.sid + "'>"
										+ ele.colorName + "</option>");
							}
							proColor.append(option);
						}
						return;
					}
				});
	}
	var colorSid;
	var sizeCode;
	var colorCode;
	var features;
	function editSMGG() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			$("#divId").val(productSid)
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个专柜商品!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要换的专柜商品!");
			$("#warning2").show();
			return false;
		} else {

			/* 回显修改信息 */
			$("#categoryDIV3").show();
			//获取专柜编码
			var value = checkboxArray[0];
			/* 规格 */
			sizeCode = $("#stanCode_" + value).html().trim();
			$("#stanCode").val(sizeCode, proColor);
			colorSid = $("#colorSid_" + value).html().trim();
			var proColor = $("#proColor_" + value).html().trim();
			fingColorDict(colorSid, proColor);
			/* 特性 */
			colorCode = $("#colorCode_" + value).html().trim();
			features = $("#features_" + value).html().trim();
			if (features == null || features == "") {
				$("#colorCode").val(colorCode);
				$("#colorCodeDiv").show();
				$("#featuresDiv").hide();
			} else {
				$("#features").val(features);
				$("#featuresDiv").show();
				$("#colorCodeDiv").hide();
			}
			/* 色码 */
			/* 专柜商品编码 */
			var productCode = $("#productCode_" + value).html().trim();
			$("#divId").val(productCode);
			//专柜编码
			var counterCode = $("#counterCode_" + value).html().trim();
		}
	}

	//换色码(特性)规格 
	function updateSMGG() {

		var shoppeProSid = $("#divId").val();
		//色系
		var proColorSid = $("#proColorSid").val();
		//规格
		var proStanSid = $("#stanCode").val();
		//特性
		var features1 = $("#features").val();
		//色码
		var colorCode1 = $("#colorCode").val();
		if (!$("#colorCodeDiv").is(":hidden")) {
			if (proStanSid == "" || colorCode1 == "") {
				$("#warning2Body", parent.document).text("规格、色码信息不能为空！");
				$("#warning2", parent.document).attr("style", "z-index:9999");
				$("#warning2", parent.document).show();
				return;
			}
			if (proStanSid == sizeCode && colorCode == colorCode1
					&& colorSid == proColorSid) {
				$("#warning2Body", parent.document).text("信息未改变，无需修改！");
				$("#warning2", parent.document).attr("style", "z-index:9999");
				$("#warning2", parent.document).show();
				return;
			}
		}
		if (!$("#featuresDiv").is(":hidden")) {
			if (proStanSid == "" || features1 == "") {
				$("#warning2Body", parent.document).text("规格、特性信息不能为空！");
				$("#warning2", parent.document).attr("style", "z-index:9999");
				$("#warning2", parent.document).show();
				return;
			}
			if (proStanSid == sizeCode && features == features1) {
				$("#warning2Body", parent.document).text("信息未改变，无需修改！");
				$("#warning2", parent.document).attr("style", "z-index:9999");
				$("#warning2", parent.document).show();
				return;
			}
		}

		$.ajax({
			type : "post",
			url : __ctxPath + "/product/updateSMGG",
			data : {
				"shoppeProSid" : shoppeProSid,
				"proColorSid" : proColorSid,
				"sizeCode" : proStanSid,
				"features" : features1,
				"colorCode" : colorCode1
			},
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				if (response.success == "false") {
					$("#categoryDIV3").hide();
					$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					$("#warning2").show();
				} else {
					$("#categoryDIV3").hide();
					$("#modal-body-success").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>操作成功，返回列表!</strong></div>");
					$("#modal-success")
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					productQuery();
				}

			}
		});
	}
</script>
<!-- 修改一般属性 -->
<script type="text/javascript">
function getProPproductByProductCode(value){
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/product/selectListByParam",
		dataType : "json",
		async : false,
		data : {
			"productCode" : $("#productCode_" + value).html().trim()
		},
		success : function(response) {
			if(response.success=="true"){
				var list = response.list;
				$("#originLand_" + value).html(list.originLand);
				$("#notes_" + value).html(list.field1);
			}
		},
		error : function(XMLHttpRequest, textStatus) {
			var sstatus = XMLHttpRequest
					.getResponseHeader("sessionStatus");
			if (sstatus != "sessionOut") {
				$("#warning2Body").text("系统出错");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
			if (sstatus == "sessionOut") {
				$("#warning3").css('display', 'block');
			}
		}
	});
}
	function editYBSX() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			$("#divId").val(productSid)
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个专柜商品!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要换的专柜商品!");
			$("#warning2").show();
			return false;
		} else {
			getProPproductByProductCode(checkboxArray[0]);
			/* 回显修改信息 */
			$("#categoryDIV5").show();
			//获取专柜编码
			var value = checkboxArray[0];
			var productName = $("#productName_" + value).html().trim();
			var articleNum = $("#articleNum_" + value).html().trim();
			$("#productName").val(productName);
			$("#productName2").val(productName);
			$("#articleNum").val(articleNum);
			$("#articleNum2").val(articleNum);
			var unit = $("#unitCode_" + value).html().trim();
			$("#unit2").val(unit);
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/dataDict/findDictByPidInfo",
				dataType : "json",
				async : true,
				ajaxStart : function() {
					$("#loading-container").prop("class",
							"loading-container");
				},
				ajaxStop : function() {
					$("#loading-container")
							.addClass("loading-inactive");
				},
				data : {
					"codes" : "xsdw"
				},
				success : function(response) {
					dictResponse = response;
					var result = response.data[0].xsdw;
					$("#unit").empty();
					var option = "";
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						if (ele.name == unit) {
							option += "<option sid='"+ele.sid+"' value='"+ele.name+"' selected='selected' >"
									+ ele.name + "</option>";
						} else {
							option += "<option sid='"+ele.sid+"' value='"+ele.name+"'>"
									+ ele.name + "</option>";
						}
					}
					$("#unit").append(option);
					return;
				}
			});
			var originLand = $("#originLand_" + value).html().trim();
			$("#originLand").val(originLand);
			$("#originLand2").val(originLand);
			var remark = $("#notes_" + value).html().trim();
			$("#remark").val(remark);
			$("#remark2").val(remark);
			/* 专柜商品编码 */
			var productCode = $("#productCode_" + value).html().trim();
			$("#divId").val(productCode);
		}
	}

	//一般属性修改
	function updateYBSX() {
		var productCode = $("#divId").val().trim();
		var productName = $("#productName").val().trim();
		var unit = $("#unit").val().trim();
		var originLand = $("#originLand").val().trim();
		var remark = $("#remark").val().trim();
		var articleNum = $("#articleNum").val().trim();
		var productName2 = $("#productName2").val();
		var unit2 = $("#unit2").val();
		var originLand2 = $("#originLand2").val();
		var remark2 = $("#remark2").val();
		var articleNum2 = $("#articleNum2").val();
		// 			alert("编码:"+productCode+" 名字:"+productName+" 单位:"+unit+" 产地:"+originLand+" 备注:"+remark);
		// 			alert("编码:"+productCode+" 名字:"+productName2+" 单位:"+unit2+" 产地:"+originLand2+" 备注:"+remark2);
		if (productName == '') {
			$("#warning2Body", parent.document).text("商品名称不能为空！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}
		if (unit == '') {
			$("#warning2Body", parent.document).text("销售单位不能为空！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}
		if (unit == unit2 && productName == productName2
				&& originLand == originLand2 && remark == remark2
				&& articleNum == articleNum2) {
			$("#warning2Body", parent.document).text("信息未改变，无需修改！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}
		$.ajax({
			type : "post",
			url : __ctxPath + "/product/updateYBSX",
			data : {
				"productCode" : productCode,
				"productName" : productName,
				"unit" : unit,
				"originLand" : originLand,
				"remark" : remark,
				"articleNum" : articleNum
			},
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				if (response.success == 'true') {
					// 						alert("success");
					$("#categoryDIV5").hide();
					$("#modal-body-success").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>操作成功，返回列表!</strong></div>");
					$("#modal-success")
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					productQuery();
				} else {
					$("#categoryDIV5").hide();
					$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					$("#warning2").show();
				}
			}
		});
	}
</script>
<!-- 修改统计分类 -->
<script type="text/javascript">
	var setting = {
		data : {
			key : {
				title : "t"
			},
			simpleData : {
				enable : true
			}
		},
		async : {
			enable : true,
			url : __ctxPath + "/category/ajaxAsyncList",
			dataType : "json",
			autoParam : [ "id", "channelSid", "shopSid", "categoryType" ],
			otherParam : {},
			dataFilter : filter
		},
		callback : {
			beforeClick : beforeClick,
			onClick : onClick,
			asyncSuccess : zTreeOnAsyncSuccess,//异步加载成功的fun
			asyncError : zTreeOnAsyncError
		//加载错误的fun 
		}
	};

	var log, className = "dark";
	function beforeClick(treeId, treeNode, clickFlag) {
		className = (className === "dark" ? "" : "dark");
		showLog("[ " + getTime() + " beforeClick ]&nbsp;&nbsp;" + treeNode.name);
		return (treeNode.click != false);
	}
	function zTreeOnAsyncError(event, treeId, treeNode) {
		$("#warning2Body").text("异步加载失败!");
		$("#warning2").show();
	}
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		$("#warning2Body").text("异步加载成功!");
		$("#warning2").show();
	}
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes)
			return null;
		for ( var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
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

	function onClick(event, treeId, treeNode, clickFlag) {
		if (treeNode.isLeaf == "Y") {
			if (treeNode.categoryType == 2) {
				// 更换请选择汉字
				$("#statcatebaseA").html(treeNode.name);
				$("#statcateDown").attr("treeDown", "true");
				$("#statCategoryName").val(treeNode.name);
				$("#statCategorySid").val(treeNode.id);
				$("#statIsLeaf").val(treeNode.isLeaf);
			}
			$("#statcateBtnGroup").attr("class", "btn-group");
		} else {
			$("#warning2Body").text("请选择末级分类!");
			$("#warning2").show();
		}
	}

	function statcatetreeDemo() {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/list",
			async : false,
			data : {
				"categoryType" : 2
			},
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			success : function(response) {
				$.fn.zTree.init($("#statcateTreeDemo"), setting, response);
			}
		});
	}

	function getTJCateByProductCode(value){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/findShoppeProductAndCategoryByPara",
			dataType : "json",
			async : false,
			data : {
				"productCode" : $("#productCode_" + value).html().trim()
			},
			success : function(response) {
				if(response.success=="true"){
					var list = response.list;
					$("#statCategoryName_" + value).html(list.statCategoryName);
					$("#statCategory_" + value).html(list.statCategory);
				}
			},
			error : function(XMLHttpRequest, textStatus) {
				var sstatus = XMLHttpRequest
						.getResponseHeader("sessionStatus");
				if (sstatus != "sessionOut") {
					$("#warning2Body").text("系统出错");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
				if (sstatus == "sessionOut") {
					$("#warning3").css('display', 'block');
				}
			}
		});
	}
	//
	var checkboxArray;
	function editTJFL() {
		checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			$("#divId").val(productSid)
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个专柜商品!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要换的专柜商品!");
			$("#warning2").show();
			return false;
		} else {
			getTJCateByProductCode(checkboxArray[0]);
			$("#statcatebaseA").text(
					$("#statCategoryName_" + checkboxArray[0]).html().trim());
			$("#statcateBtnGroup").attr("class", "btn-group");
			$("#activeTimes1").val("");
			$("#categoryDIV6").show();
			statcatetreeDemo();
			$("#statCategoryName").val(
					$("#statCategoryName_" + checkboxArray[0]).html().trim());
			$("#statIsLeaf").val("Y");
			$("#statCategorySid").val(
					$("#statCategory_" + checkboxArray[0]).html().trim());
		}

		$("#statcatetreeDown").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#statcateBtnGroup").attr("class", "btn-group open");
			} else {
				$(this).attr("treeDown", "true");
				$("#statcateBtnGroup").attr("class", "btn-group");
			}
		});
	}

	//修改
	function updateStatCategory() {
		var cateSid = $("#statCategorySid").val();
		var cateName = $("#statCategoryName").val();
		var ifLeaf = $("#statIsLeaf").val();
		var activeTime = $("#activeTimes1").val();
		if (ifLeaf != "Y" || cateSid == null || cateSid == "") {
			$("#warning2Body", parent.document).text("请选择统计分类末级节点！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		} else if (activeTime == "" || activeTime == null
				|| activeTime == "生效日期") {
			$("#warning2Body", parent.document).text("请选择生效日期！");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		} else {
			if ($("#statCategorySid").val() == $(
					"#statCategory_" + checkboxArray[0]).html().trim()) {
				$("#warning2Body", parent.document).text("信息未改变，无需修改！");
				$("#warning2", parent.document).attr("style", "z-index:9999");
				$("#warning2", parent.document).show();
				return;
			}
			$
					.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/productprops/updateStatCategory",
						dataType : "json",
						async : false,
						data : {
							cateSid : cateSid,
							spuSid : $("#productCode_" + checkboxArray[0])
									.html().trim(),
							activeTime : activeTime
						},
						success : function(response) {
							if (response.success == 'true') {
								$("#categoryDIV6").hide();
								$("#modal-body-success")
										.html(
												"<div class='alert alert-success fade in'>"
														+ "<strong>操作成功，返回列表!</strong></div>");
								$("#modal-success")
								$("#modal-success")
										.attr(
												{
													"style" : "display:block;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-success"
												});
								productQuery();
							} else {
								$("#categoryDIV6").hide();
								$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
								$("#warning2").show();
							}
						},
						error : function(XMLHttpRequest, textStatus) {
							var sstatus = XMLHttpRequest
									.getResponseHeader("sessionStatus");
							if (sstatus != "sessionOut") {
								$("#warning2Body").text("系统出错");
								$("#warning2").attr("style", "z-index:9999");
								$("#warning2").show();
							}
							if (sstatus == "sessionOut") {
								$("#warning3").css('display', 'block');
							}
						}
					});
		}
	}
</script>
<script type="text/javascript">
	var count_num = 0;
	//查询专柜
	function counterCodeClick() {
		if (count_num == 0) {
			$
					.ajax({
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
							$("#loading-container")
									.addClass("loading-inactive");
						},
						data : {
							"page" : 1,
							"pageSize" : 1000000
						},
						success : function(response) {
							count_num = 1;
							if (response.pageCount != 0) {
								var result = response.list;
								for ( var i = 0; i < result.length; i++) {
									var ele = result[i];
									if (ele.shoppeCode == "") {
										continue;
									}
									$("#shoppe_select").append(
											"<option value='"+ele.shoppeCode+"'>"
													+ ele.shoppeName
													+ "</option>");
								}
								return;
							}
						}
					});
		}
	}

	//专柜商品启用或禁用
	function editStatus(status) {
		var checkboxArrays = new Array();
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			var productCode = $("#productCode_" + productSid).html().trim();
			checkboxArrays.push(productCode);
		});
		var inT = JSON.stringify(checkboxArrays);
		inT = inT.replace(/\%/g, "%25");
		inT = inT.replace(/\#/g, "%23");
		inT = inT.replace(/\&/g, "%26");
		inT = inT.replace(/\+/g, "%2B");
		if (checkboxArrays.length == 0) {
			$("#warning2Body").text("请选取未停用的商品!");
			$("#warning2").show();
			return false;
		}
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/product/UpdateProductsStatusInfo",
					dataType : "json",
					data : {
						"productCodes" : inT,
						"status" : status
					},
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<i class='fa fa-check-circle'></i><strong>操作成功!</strong></div>");
							$("#modal-success")
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							productQuery();
						} else {
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
							$("#warning2").show();
						}
					},
					error : function(XMLHttpRequest, textStatus) {
						var sstatus = XMLHttpRequest
								.getResponseHeader("sessionStatus");
						if (sstatus != "sessionOut") {
							$("#warning2Body").text("系统出错");
							$("#warning2").attr("style", "z-index:9999");
							$("#warning2").show();
						}
						if (sstatus == "sessionOut") {
							$("#warning3").css('display', 'block');
						}
					}
				});
	}
</script>
<script type="text/javascript">

	function init_1(){
		$('#supplier_select').prop("disabled", "disabled").select2();
		$('#shoppe_select').prop("disabled", "disabled").select2();
		$('#s2id_supplier_select').click(function(){
			if($('#supplier_select').attr("disabled") == "disabled"){
				selectSupplierByShop();
				$('#supplier_select').removeAttr("disabled");
			}
		});
		$('#s2id_shoppe_select').click(function(){
			if($('#shoppe_select').attr("disabled") == "disabled"){
				selectShoppeByShopAndSupplier();
				$('#shoppe_select').removeAttr("disabled");
			}
		});
		$('#shop_select').change(function(){
			selectSupplierByShop();
			$('#supplier_select').removeAttr("disabled");
			selectShoppeByShopAndSupplier();
			$('#shoppe_select').removeAttr("disabled");
			productQuery();
		});
		$('#supplier_select').change(function(){
			selectShoppeByShopAndSupplier();
			$('#shoppe_select').removeAttr("disabled");
			productQuery();
		});
	}

	$(function(){
		init_1();
	});
	
	//根据门店和供应商查询专柜
	function selectShoppeByShopAndSupplier(){
		$('#shoppe_select').html("<option value=''>全部</option>");
		$('#shoppe_select').select2({'height':'20px'});
		$.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=utf-8",
            url : __ctxPath + "/shoppe/findShoppeList",
            dataType : "json",
            async : false,
            data : {
            	"shopSid" : $('#shop_select').val(),
            	"supplySid" : $('#supplier_select').val()
            },
            success : function(response) {
                var result = response.list;
                if(typeof(result) != "undefined"){
	                for (var i = 0; i < result.length; i++) {
	                    var ele = result[i];
	                    var option = $("<option value='" + ele.shoppeCode + "'>" + ele.shoppeName + "</option>");
	                    option.appendTo($("#shoppe_select"));
	                }
                }
                return;
            },
            error : function(XMLHttpRequest, textStatus) {
                var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
                if(sstatus != "sessionOut"){
                    $("#warning2Body").text("系统错误!");
                    $("#warning2").show();
                }
                if(sstatus=="sessionOut"){
                    $("#warning3").css('display','block');
                }
            }
        });
	}
</script>
<script type="text/javascript">
    //专柜商品导出excel
    function excelShoppeProduct() {
        var shoppeProSid = "";
		var minShoppeProSid = $("#shoppeProSid_input").val().trim();
		var maxShoppeProSid = $("#maxShoppeProSid_input").val().trim();
		if(minShoppeProSid != "" && maxShoppeProSid == ""){
			shoppeProSid = minShoppeProSid;
			minShoppeProSid = "";
		} else if(minShoppeProSid == "" && maxShoppeProSid != ""){
			shoppeProSid = maxShoppeProSid;
			maxShoppeProSid = "";
		}
		var productDetailSid = "";
		var minSkuCode = $("#skuCode_input").val();
		var maxSkuCode = $("#maxSkuCode_input").val();
		if(minSkuCode != "" && maxSkuCode == ""){
			productDetailSid = minSkuCode;
			minSkuCode = "";
		} else if(minSkuCode == "" && maxSkuCode != ""){
			productDetailSid = maxSkuCode;
			maxSkuCode = "";
		}
        var shoppeProName = $("#shoppeProName_input").val().trim();
        var field4 = $("#materialNumber_input").val();
        if(typeof(field4) == "undefined"){
            field4 = "";
        }
        var saleStatus = $("#saleStatus_select").val().trim();
        var shoppeSid = $("#shoppe_select").val().trim();
        var field5 = $("#shop_select option:selected").attr("code");
        if(typeof(field5) == "undefined"){
            field5 = "";
        }
        var supplySid = $("#supplier_select").val();

        var title = "shoppProduct";
        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=utf-8",
            url : __ctxPath + "/product/getShoppeProductToExcelCount",
            dataType : "json",
            async : false,
            data : {
                "shoppeProSid" : shoppeProSid,
                "minShoppeProSid" : minShoppeProSid,
                "maxShoppeProSid" : maxShoppeProSid,
                "productDetailSid" : productDetailSid,
                "minProductDetailSid" : minSkuCode,
                "maxProductDetailSid" : maxSkuCode,
                "shoppeProName" : shoppeProName,
                "field4" : field4,
                "saleStatus" : saleStatus,
                "shoppeSid" : shoppeSid,
                "field5" : field5,
                "supplySid" : supplySid
            },
            success : function(response) {
                if(typeof(response) != "undefined"){
                    if(response.count > 3000) {
                        $("#warning2Body").text(buildErrorMessage("","您申请导出的数据超过3000条，请调整查询条件后重试。"));
                        $("#warning2").show();
                        return;
                    }
                }
                window.open(__ctxPath + "/product/getShoppeProductToExcel?shoppeProSid=" + shoppeProSid
						+ "&minShoppeProSid=" + minShoppeProSid + "&maxShoppeProSid=" + maxShoppeProSid
                        + "&shoppeProName=" + shoppeProName + "&productDetailSid=" + productDetailSid
						+ "&minProductDetailSid=" + minSkuCode + "&maxProductDetailSid=" + maxSkuCode
                        + "&saleStatus=" + saleStatus + "&shoppeSid=" + shoppeSid + "&field5=" + field5
                        + "&supplySid=" + supplySid + "&field4=" + field4 + "&title=" + title);
                return;
            },
            error : function(XMLHttpRequest, textStatus) {
                var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
                if(sstatus != "sessionOut"){
                    $("#warning2Body").text("系统错误!");
                    $("#warning2").show();
                }
                if(sstatus=="sessionOut"){
                    $("#warning3").css('display','block');
                }
            }
        });
    }
</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<!-- 换扣率码 -->
	<div class="modal modal-darkorange" id="categoryDIV">
		<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">换扣率码</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row" class="col-md-10">
							<!-- <div class="col-md-12"> -->
							<form id="divForm" method="post" class="form-horizontal"
								enctype="multipart/form-data">
								<input type="hidden" id="divId" name="shoppeProSid" />
								<div class="mtb10 col-lg-12">
									<label class="col-lg-4 control-label">扣率码： </label> <input
										type="text" placeholder="必填" class="col-lg-6 form-control"
										id="discountCode" name="productName" style="width: 200px;">
								</div>
							</form>
							<!-- </div> -->
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" type="button" onclick="edit();">保存</button>
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeCategoryDiv();" type="button">取消</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 换专柜 -->
	<div class="modal modal-darkorange" id="categoryDIV2">
		<div class="modal-dialog"
			style="width: 400px; height: 400px; margin: 100px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">换专柜</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" id="divId" name="shoppeProSid" /> <label
										class="col-lg-3 control-label" style="padding-left: 10px;">
										专柜列表：</label> <select name="sid" id="shoppeCode"
										style="width: 240px; height: 35px; margin: 0 0 15px 0;">
									</select> <br> <label class="col-lg-3 control-label"
										style="padding-left: 10px;"> 生效日期：</label>
									<div class=" input-group date form_date" data-date=""
										data-date-format="" data-link-field="dtp_input2"
										data-link-format="yyyy-mm-dd"
										style="float: left; width: 200px;">
										<input class="form-control" onfocus="this.blur();"
											id="activeTime" style="position: relative; width: 100px;"
											name="activeTime" placeholder="生效时间" size="10" type="text"
											readonly> <span class="input-group-addon"> <span
											class="glyphicon glyphicon-remove"></span>
										</span> <span class="input-group-addon"> <span
											class="glyphicon glyphicon-calendar"></span></span>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" type="button"
						onclick="updateShoppe();">保存</button>
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeCategoryDiv();" type="button">取消</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- 换色码（特性）规格-->
	<div class="modal modal-darkorange" id="categoryDIV3">
		<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">换色码（特性）规格</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data" style="text-align: center;">
									<input type="hidden" id="divId" name="shoppeProSid" />
									<div class="form-group" id="proColorSidDiv">
										色系： <select id="proColorSid" name="proColorSid"
											style="width: 50%" class="form-control">
										</select>
									</div>
									<div class="form-group" id="featuresDiv">
										特性： <input type="text" placeholder="必填" maxlength="20"
											style="width: 50%" class="form-control" id="features"
											name="features">
									</div>
									<div class="form-group" id="colorCodeDiv">
										色码： <input type="text" placeholder="必填" maxlength="20"
											style="width: 50%" class="form-control" id="colorCode"
											name="proColorName">
									</div>
									<div class="form-group">
										规格： <input type="text" placeholder="必填" maxlength="20"
											style="width: 50%" class="form-control" id="stanCode"
											name="stanCode">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" type="button"
						onclick="updateSMGG();">保存</button>
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeCategoryDiv();" type="button">取消</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 一般属性修改-->
	<div class="modal modal-darkorange" id="categoryDIV5">
		<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">一般属性修改</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row" style="padding: 10px;">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data" style="text-align: center;">
									<input type="hidden" id="divId" name="shoppeProSid" /> <input
										type="hidden" id="productName2" /> <input type="hidden"
										id="unit2" /> <input type="hidden" id="originLand2" /> <input
										type="hidden" id="remark2" /> <input type="hidden"
										id="articleNum2" />
									<div class="form-group">
										商品名称： <input type="text" maxlength="20" style="width: 60%"
											class="form-control" id="productName" name="productName">
									</div>
									<div class="form-group">
										货&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号： <input type="text"
											maxlength="20" style="width: 60%" class="form-control"
											id="articleNum" name="articleNum">
									</div>
									<div class="form-group">
										销售单位：<select id="unit" name="unit"
											style="width: 60%; height: 34px; margin-left: 4px;"></select>
									</div>
									<div class="form-group">
										产&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;地： <input type="text"
											maxlength="20" style="width: 60%" class="form-control"
											id="originLand" name="originLand">
									</div>
									<div class="form-group">
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注： <input type="text"
											maxlength="20" style="width: 60%" class="form-control"
											id="remark" name="remark">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" type="button"
						onclick="updateYBSX();">保存</button>
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeCategoryDiv();" type="button">取消</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 换品牌-->
	<div class="modal modal-darkorange" id="categoryDIV4">
		<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">换品牌</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" id="divId" name="sid" /> <input
										type="hidden" id="shoppeProSid" name="shoppeProSid" />
									<div class="col-lg-12" id="channelid"
										style="margin-bottom: 15px;">
										品牌列表： <select name="sid" id="brandCode" class="form-control"
											style="width: 240px;">
										</select>
									</div>
									<label class="col-lg-3 control-label"
										style="text-align: left; padding-left: 13px; padding-right: 0; width: 82px;">
										生效日期：</label>
									<div class="col-lg-10 mtb10 input-group date form_date"
										data-date="" data-date-format="" data-link-field="dtp_input2"
										data-link-format="yyyy-mm-dd"
										style="width: 200px; margin-left: 0;">
										<input class="form-control" onfocus="this.blur();"
											id="activeTimes" style="position: relative" name="activeTime"
											placeholder="生效时间" size="10" type="text" readonly> <span
											class="input-group-addon"> <span
											class="glyphicon glyphicon-remove"></span>
										</span> <span class="input-group-addon"> <span
											class="glyphicon glyphicon-calendar"></span></span>
									</div>

								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" type="button"
						onclick="updateBrand();">保存</button>
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeCategoryDiv();" type="button">取消</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 换款号-->
	<div class="modal modal-darkorange" id="categoryDIV7">
		<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">换款号</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" id="divId" name="sid" /> <input
										type="hidden" id="shoppeProSid" name="shoppeProSid" />
									<div class="mtb10 col-lg-12">
										款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号： <input type="text"
											style="width: 240px"
											onkeyup="value=value.replace(/[\u4E00-\u9FA5]/g,'');" maxLength=20
											placeholder="必填" class="form-control" id="kuanhao"
											name="modelCode">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" type="button"
						onclick="updateMcode();">保存</button>
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeCategoryDiv();" type="button">取消</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>



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
								<h5 class="widget-caption">专柜商品管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<div class="clearfix" >
										<!-- <a onclick="editKLM();" class="btn btn-primary" style="margin-top:5px;margin-bottom: 5px">
                                            <i class="fa fa-edit"></i> 换扣率码
										</a>&nbsp;&nbsp;
                                        <a onclick="editZG();" class="btn btn-primary" style="margin-top:5px;margin-bottom: 5px">
                                            <i class="fa fa-edit"></i> 换专柜
										</a>&nbsp;&nbsp; -->
                                        <!--  <a id="editabledatatable_new"
											onclick="editPP();" class="btn btn-primary" style="margin-top:5px;margin-bottom: 5px"> <i
											class="fa fa-edit"></i> 换品牌
										</a>&nbsp;&nbsp; <a id="editabledatatable_new"
											onclick="editKH();" class="btn btn-primary" style="margin-top:5px;margin-bottom: 5px"> <i
											class="fa fa-edit"></i> 换款号
										</a>&nbsp;&nbsp;  -->
                                        <!-- <a onclick="editSMGG();" class="btn btn-primary" style="margin-top:5px;margin-bottom: 5px">
                                            <i class="fa fa-edit"></i> 换色码(特性)规格
										</a>&nbsp;&nbsp;
                                        <a onclick="editYBSX();" class="btn btn-primary" style="margin-top:5px;margin-bottom: 5px">
                                            <i class="fa fa-edit"></i> 一般属性修改
										</a>&nbsp;&nbsp;
                                        <a onclick="editTJFL();" class="btn btn-primary" style="margin-top:5px;margin-bottom: 5px">
                                            <i class="fa fa-edit"></i> 换统计分类
										</a>&nbsp;&nbsp; -->
										<div style="white-space: nowrap;width:300px;display: inline;">
										<a onclick="editStatus(0);" class="btn btn-yellow" style="margin-top:5px;margin-bottom: 5px" >
                                            <i class="fa fa-edit"></i> 专柜商品启用
										</a>&nbsp;&nbsp;
                                        <a onclick="editStatus(1);" class="btn btn-danger" style="margin-top:5px;margin-bottom: 5px">
                                            <i class="fa fa-times"></i> 专柜商品停用
										</a>&nbsp;&nbsp;
                                        <a onclick="excelShoppeProduct();" class="btn btn-yellow" style="margin-top:5px;margin-bottom: 5px">
                                            <i class="fa fa-edit"></i> 导出Excel
                                        </a>
									</div>
								</div>
									<br>
									<ul class="listInfo clearfix">
										<li>
											<span>专柜商品编码：</span> 
											<input type="text" id="shoppeProSid_input" style="width: 91px;" maxlength="20" />
											~
											<input type="text" id="maxShoppeProSid_input" style="width: 92px;" maxlength="20" />
										</li>
										<li>
											<span>SKU编码：</span> 
											<input type="text" id="skuCode_input" style="width: 91px;" maxlength="20" />
											~
											<input type="text" id="maxSkuCode_input" style="width: 92px;" maxlength="20" />
										</li>
										<li>
											<span>商品名称：</span> 
											<input type="text" id="shoppeProName_input" style="width: 200px;" maxlength="20" />
										</li>
										<!-- <li>
											<span>erp商品编码：</span> 
											<input type="text" id="materialNumber_input" style="width: 200px;" maxlength="20" />
										</li> -->
										<li>
											<span>是否可售：</span> 
											<select id="saleStatus_select" style="width: 200px;">
												<option value="">全部</option>
												<option value="Y">可售</option>
												<option value="N">不可售</option>
											</select>
										</li>
										<li>
											<span>门店：</span>
											<select id="shop_select" style="width: 200px;">
												<!-- <option value="">全部</option> -->
											</select>
										</li>
										<li>
											<span>供应商：</span>
											<select id="supplier_select" style="width: 200px;">
												<option value="">全部</option>
											</select>
										</li>
										<li>
											<span>专柜名称：</span>
											<select id="shoppe_select" style="width: 200px;">
												<option value="">全部</option>
											</select>
										</li>
										<li>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
											<a class="btn btn-default shiny" onclick="query();">查询</a>
											&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="reset();">重置</a>
										</li>
									</ul>
								</div>
								<table
									class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="product_tab">
									<thead class="flip-content bordered-darkorange">
										<tr>
											<th style="text-align: center;" width="7.5%">选择</th>
											<th style="text-align: center;">专柜商品编码</th>
											<th style="text-align: center;">商品名称</th>
											<th style="text-align: center;">SKU编码</th>
											<th style="text-align: center;">门店</th>
											<th style="text-align: center;">专柜</th>
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
											<select id="pageSelect" name="pageSize"
												style="padding: 0 12px;">
												<option>5</option>
												<option selected="selected">10</option>
												<option>15</option>
												<option>20</option>
											</select>
										</div>
										&nbsp; 
										<input type="hidden" id="skuSid_hidden" value="${sku.sid}" /> 
										<input type="hidden" id="skuCode_hidden" value="${sku.skuCode}" />
										<input type="hidden" id="shoppeProSid_from" name="shoppeProSid" />
										<input type="hidden" id="minShoppeProSid_from" name="minShoppeProSid" />
										<input type="hidden" id="maxShoppeProSid_from" name="maxShoppeProSid" />
										<input type="hidden" id="skuCode_from" name="productDetailSid" />
										<input type="hidden" id="minSkuCode_from" name="minProductDetailSid" />
										<input type="hidden" id="maxSkuCode_from" name="maxProductDetailSid" />
										<input type="hidden" id="shoppeProName_from" name="shoppeProName" />
										<input type="hidden" id="materialNumber_from" name="field4" />
										<input type="hidden" id="saleStatus_from" name="saleStatus" /> 
										<input type="hidden" id="shoppe_from" name="shoppeSid" />
										<input type="hidden" id="shop_from" name="field5" />
										<input type="hidden" id="supplier_from" name="supplySid" />
										<!-- <input type="hidden" id="proActiveBit_from" name="proActiveBit"/>
											<input type="hidden" id="proSelling_from" name="proSelling"/>
											<input type="hidden" id="proType_from" name="proType"/> -->
									</form>
								</div>
								<div style="float: right;float: right !important;padding: 10px;color: rgb(72, 185, 239);">
									<div class="col-lg-12">
										<p>共&nbsp;<span id="total">0</span>&nbsp;条</p>
									</div>
								</div>
								<div id="productPagination"></div>
								
							</div>
							<!-- Templates -->
							<p style="display: none">
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
													<td align="center"><a onclick="getView('{$T.Result.productCode}');" style="cursor:pointer;">{$T.Result.productCode}</a></td>
													<td align="center"><a onclick="getView('{$T.Result.productCode}');" style="cursor:pointer;">{$T.Result.productName}</a></td>
													<td align="center">{$T.Result.skuCode}</td>
													<td align="center">{$T.Result.storeName}</td>
													<td align="center" >{$T.Result.counterName}</td>
													<td align="center" id="supplierName_{$T.Result.sid}">{$T.Result.suppliers[0].supplierName}</td>
													<td align="center">{$T.Result.storeBrandName}</td>
													<td align="center">
														{#if $T.Result.managerCategoryName == ''}
															无
														{#elseif $T.Result.managerCategoryName != ''}
															{$T.Result.managerCategoryName}
														{#/if}
													</td>
													<td align="center">
														{#if $T.Result.isSale == '0'}<span class="label label-success graded"> 可售</span>
														{#elseif $T.Result.isSale == '1'}<span class="label label-darkorange graded"> 不可售</span>
														{#/if}
													</td>
													<td style="display:none;" id="counterCode_{$T.Result.sid}">{$T.Result.counterCode}</td>
													<td style="display:none;" id="industryCondition_{$T.Result.sid}">{$T.Result.industry}</td>
													<td style="display:none;" id="discountCode_{$T.Result.sid}">{$T.Result.erpProductCode}</td>

													<td style="display:none;" id="productCode_{$T.Result.sid}">{$T.Result.productCode}</td>
													<td style="display:none;" id="colorSid_{$T.Result.sid}">{$T.Result.colorSid}</td>
													<td style="display:none;" id="proColor_{$T.Result.sid}">{$T.Result.colorName}</td>
													<td style="display:none;" id="features_{$T.Result.sid}">{$T.Result.features}</td>
												    <td style="display:none;" id="colorCode_{$T.Result.sid}">{$T.Result.colorCode}</td>
												    <td style="display:none;" id="stanCode_{$T.Result.sid}">{$T.Result.stanCode}</td>
												    
												    <td style="display:none;" id="modelCode_{$T.Result.sid}">{$T.Result.modelCode}</td>
												    <td style="display:none;" id="brandSid_{$T.Result.sid}">{$T.Result.brandSid}</td>
												    <td style="display:none;" id="storeCode_{$T.Result.sid}">{$T.Result.storeCode}</td>
												    <td style="display:none;" id="operateMode_{$T.Result.sid}">{$T.Result.suppliers[0].businessPattern}</td>
												    <td style="display:none;" id="storeSid_{$T.Result.sid}">{$T.Result.storeSid}</td>
												    <td style="display:none;" id="productName_{$T.Result.sid}">{$T.Result.productName}</td>
												    
												    <td style="display:none;" id="unitCode_{$T.Result.sid}">{$T.Result.unitCode}</td>
												    <td style="display:none;" id="originLand_{$T.Result.sid}">{$T.Result.originLand}</td>
												    <td style="display:none;" id="notes_{$T.Result.sid}">{$T.Result.notes}</td>
												    <td style="display:none;" id="articleNum_{$T.Result.sid}">{$T.Result.articleNum}</td>
												    <td style="display:none;" id="statCategory_{$T.Result.sid}">{$T.Result.statCategory}</td>
												    <td style="display:none;" id="statCategoryName_{$T.Result.sid}">{$T.Result.statCategoryName}</td>
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
	<!-- 换扣率码 -->
	<div class="modal modal-darkorange" id="editKLMDIV">
		<div class="modal-dialog" style="margin-top: 150px;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeProDiv();">×</button>
					<h4 class="modal-title">专柜商品换扣率码</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row" style="padding: 10px;">
							<div class="col-lg-12 col-sm-12 col-xs-12">
								<form id="proForm" method="post" class="form-horizontal">
									<div class="col-md-12">
										<label class="col-md-3 ">扣率码:</label>
										<div class="col-md-9">
											<input type="text" id="editKLMInput" name="editKLMInput"
												style="width: 100%" />
										</div>
										&nbsp;
									</div>
									<!-- yincangDiv -->
									<div style="display: none">
										<input type="hidden" id="#" name="#" />
									</div>
									<!-- /yincangDiv -->
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input type="button" class="btn btn-success"
												style="width: 25%;" id="proSave" value="保存">&emsp;&emsp;
											<input onclick="closeProDiv();" class="btn btn-danger"
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
	<!-- /换扣率码 -->

	<!-- 换统计分类 -->
	<div class="modal modal-darkorange" id="categoryDIV6">
		<div class="modal-dialog"
			style="width: 400px; height: 400ox; margin: 100px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">换统计分类</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<div class="col-md-14">
										<div class="col-md-14">
											<label class="col-md-3 control-label"
												style="padding: 6px 0; float: left;">统计分类：</label>
											<div class="col-md-9" style="padding: 0;">
												<div class="btn-group"
													style="width: 100%; margin: 0 0 15px 0;"
													id="statcateBtnGroup">
													<a href="javascript:void(0);" class="btn btn-default"
														id="statcatebaseA" style="width: 72%; margin-left: 8px;overflow-x: hidden;"></a>
													<a id="statcatetreeDown" href="javascript:void(0);"
														class="btn btn-default" treeDown="true"><i
														class="fa fa-angle-down"></i></a>
													<ul id="statcateTreeDemo"
														class="dropdown-menu ztree form-group"
														style="margin-left: 8px; width: 86%; max-height: 300px; position: absolute;overflow: auto;"></ul>
												</div>
											</div>
										</div>
										<div class="col-md-14">
											<label class="col-md-3 control-label"
												style="padding: 6px 0; float: left;">生效日期：</label>
											<div class="col-lg-12 mtb10 input-group date form_date"
												data-date="" data-date-format=""
												data-link-field="dtp_input2" data-link-format="yyyy-mm-dd"
												style="width: 220px; margin-left: 100px;">
												<input class="form-control" onfocus="this.blur();"
													id="activeTimes1" style="position: relative"
													name="activeTime" placeholder="生效时间" size="10" type="text"
													readonly> <span class="input-group-addon"> <span
													class="glyphicon glyphicon-remove"></span>
												</span> <span class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span></span>
											</div>
										</div>


									</div>

								</form>
							</div>
						</div>
					</div>
				</div>
				<div style="display: none;">
					<form id="statcateForm" method="post" class="form-horizontal">
						<input type="hidden" id="statCategorySid" /> <input type="hidden"
							id="statCategoryName" /> <input type="hidden" id="statIsLeaf" />
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" type="button"
						onclick="updateStatCategory();">保存</button>
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeCategoryDiv();" type="button">取消</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

</body>
</html>