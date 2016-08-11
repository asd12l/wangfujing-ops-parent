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
<!--Jquery Select2-->

<script
	src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
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
.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control
	{
	cursor: pointer;
}
.td_showHidden{
 text-overflow:ellipsis;
 word-break:keep-all;
 overflow:hidden;"
}
</style>
<!-- 专柜商品列表页展示及查询 -->
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var productPagination;
	
	//专柜商品查询
	function productQuery() {
		$("#storeCode_from").val($("#storeCode_select").find("option:selected")
				.attr("storecode"));
		$("#supplierCode_from").val($("#supplierCode_select").val());
		$("#manageCategory_from").val($("#manageCateGory").val());
		$("#counterCode_from").val($("#counterCode_select").find("option:selected")
				.attr("counterCode"));
		$("#brandCode_from").val($("#brandCode_select").val());
		$("#productCode_from").val($("#productCode_input").val());
		$("#isAddTag_from").val($("#isAddTag_select").val());
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
		$("#storeCode_select").val("").select2();
		$("#supplierCode_select").val("").select2();
		$("#manageCateGory").val("");
		$("#proA").text("请选择");
		$("#counterCode_select").val("").select2();
		$("#brandCode_select").val("").select2();
		$("#productCode_input").val("");
		$("#isAddTag_select").val("");
		/* $("#counterCode_from").val(""); */
		productQuery();
	}
	//初始化专柜商品列表
	function initProduct() {
		var url = $("#ctxPath").val() + "/productTag/selectShoppeProduct";
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
							if(_isMore == 1){
								$("td[id='hide_td']").hide();
							} else {
								$("td[id='hide_td']").show();
							}
						}
					}
				});
	}
</script>
<script type="text/javascript">
	function getSelectSid() {
		var checkboxArray = new Array();
		var inT = "";
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $("#productCode_"+$(this).val()).html().trim();
			checkboxArray.push(productSid);
		});
		inT = JSON.stringify(checkboxArray);
		inT = inT.replace(/\%/g, "%25");
		inT = inT.replace(/\#/g, "%23");
		inT = inT.replace(/\&/g, "%26");
		inT = inT.replace(/\+/g, "%2B");
		return inT;
	}

	/* 添加专柜商品关系 */
	function addProductTag() {
		var productSids = getSelectSid();
		if (productSids == "[]") {
			$("#warning2Body").text("请选取要添加的商品!");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/productTag/saveProductTag",
			async : false,
			dataType : "json",
			data : {
				"tagSid" : _tagSid,
				"productSids" : productSids
			},
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				setTimeout(function() {
					$("#loading-container")
							.addClass("loading-inactive");
				}, 300);
			},
			success : function(response) {
				if (response.success == "true") {
					$("#modal-body-success")
							.html(
									"<div class='alert alert-success fade in'>"
											+ "<i class='fa fa-check-circle'></i><strong>添加成功!</strong></div>");
					$("#modal-success");
					$("#modal-success").attr({
						"style" : "display:block;z-index:9999;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
				} else {
					$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
			}

		});
	}
	/* 批量添加专柜商品关系 */
	function addProductTagList() {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/productTag/saveShoppeProductTagBySelects",
			async : false,
			dataType : "json",
			data : $("#product_form").serialize(),
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				setTimeout(function() {
					$("#loading-container")
							.addClass("loading-inactive");
				}, 300);
			},
			success : function(response) {
				if (response.success == "true") {
					$("#modal-body-success").html(
									"<div class='alert alert-success fade in'>"
									+ "<i class='fa fa-check-circle'></i><strong>"+response.data+"</strong></div>");
					$("#modal-success");
					$("#modal-success").attr({
						"style" : "display:block;z-index:9999;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
				} else {
					$("#warning2Body").text("系统错误");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
			}

		});
	}
	
	/* 删除专柜商品关系 */
	function deleteProductTag() {
		var productSids = getSelectSid();
		if (productSids == "[]") {
			$("#warning2Body").text("请选取要添加的商品!");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/productTag/deleteProductTag",
					async : false,
					dataType : "json",
					data : {
						"tagSid" : _tagSid,
						"productSids" : productSids
					},
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive");
						}, 300);
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<i class='fa fa-check-circle'></i><strong>删除成功!</strong></div>");
							$("#modal-success");
							$("#modal-success").attr({
								"style" : "display:block;z-index:9999;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
						} else {
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
							$("#warning2").attr("style", "z-index:9999");
							$("#warning2").show();
						}
					}

				});
	}
</script>
<script type="text/javascript">
/* 门店列表 */
function findShop() {
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/shoppe/queryShopListAddPermission",
		dataType : "json",
		async : false,
		success : function(response) {
			var result = response.list;
			var option = "<option value=''>全部</option>";
			for (var i = 0; i < result.length; i++) {
				var ele = result[i];
				option += "<option storeCode='"+ele.organizationCode+"' value='"+ele.sid+"'>"
						+ ele.organizationName + "</option>";
			}
			$("#storeCode_select").html(option);
			return;
		}
	});
	$("#storeCode_select").select2();
	$(".select2-arrow b").attr("style", "line-height: 2;");
	return;
}
//点击查询门店品牌
function findShopBrand() {
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath
				+ "/shopBrand/queryPageShopBrand",
		dataType : "json",
		async : false,
		data : {
			"currentPage" : "1",
			"pageSize" : "9999",
			"shopSid" : $("#storeCode_select").val()
		},
		success : function(response) {
			var result = response.list;
			var option = "<option value=''>全部</option>";
			for (var i = 0; i < result.length; i++) {
				var ele = result[i];
				option += "<option sid='"+ele.brandSid+"' value='"+ele.sid+"'>"
						+ ele.brandName + "</option>";
			}
			$("#brandCode_select").html(option);
			return;
		}
	});
	$("#brandCode_select").select2();
	return;
}
//点击查询供应列表
function supplierCodeClick() {
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath
				+ "/supplierDisplay/selectSupplyByShopSidAndSupplyName",
		dataType : "json",
		async : false,
		data : {
			"shopSid" : $("#storeCode_select").find("option:selected")
					.attr("storecode"),
			"page" : 1,
			"pageSize" : 1000000
		},
		success : function(response) {
			var option = "<option value=''>全部</option>";
			if (response.success != "false") {
				var result = response.data;
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option businessPattern='"+ele.businessPattern+"' supplyCode='"+ele.supplyCode+"' value='"+ele.sid+"'>"
											+ ele.supplyName
											+ "</option>";
				}
				$("#supplierCode_select").html(option);
				return;
			}
		}
	});
	$("#supplierCode_select").select2();
	return;
}
//查询专柜
function counterCodeClick() {
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/shoppe/queryShoppe",
		dataType : "json",
		async : false,
		data : {
			"shopSid" : $("#storeCode_select").val(),
			"page" : 1,
			"pageSize" : 1000000
		},
		success : function(response) {
			var option = "<option value=''>全部</option>";
			if (response.pageCount != 0) {
				var result = response.list;
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option counterCode='"+ ele.shoppeCode +"' industryConditionSid='"+ele.industryConditionSid+"' value='"+ele.sid+"'>"
											+ ele.shoppeName
											+ "</option>";
				}
				$("#counterCode_select").html(option);
				return;
			}
		}
	});
	$("#counterCode_select").select2();
	return;
}

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

	function filter(treeId, parentNode, childNodes) {
		if (!childNodes)
			return null;
		for (var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	function zTreeOnAsyncError(event, treeId, treeNode) {
		$("#warning2Body").text("异步加载失败!");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
	}
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		$("#warning2Body").text("异步加载成功!");
		$("#warning2").attr("style", "z-index:9999");
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
				$("#manageCateGory").val(treeNode.id);
				$("#proTreeDown").attr("treeDown", "true");
			}else if (treeNode.categoryType == 2){
				$("#tjA").html(treeNode.name);
				$("#finalClassiFicationCode").val(treeNode.id);
				$("#tjTreeDown").attr("treeDown", "true");
			}
			$("#rightbaseBtnGroup").attr("class", "btn-group");
			$("#baseBtnGroup").attr("class", "btn-group");
			$("#proBtnGroup").attr("class", "btn-group");
			$("#tjBtnGroup").attr("class", "btn-group");
		} else {
			$("#warning2Body").text("请选择末级分类!");
			$("#warning2").attr("style", "z-index:9999;");
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
//Tree管理分类请求
function proTreeDemo() {
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/category/list",
		async : false,
		data : {
			"categoryType" : 1,
			"shopSid" : $("#storeCode_select").find("option:selected").attr(
					"storecode")
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
</script>
<script type="text/javascript">
$(function() {
	
	if(_isMore == 1){
		$("#add_div").hide();
		$("#moreAdd_div").show();
		$("#isAdded").hide();
		$("#hide_th").hide();
	} else {
		$("#add_div").show();
		$("#moreAdd_div").hide();
		$("#isAdded").show();
		$("#hide_th").show();
	}

	$("td").addClass("td_showHidden");
	
	$("#tagSid_from").val(_tagSid);
	
	$("#storeCode_select").select2();
	$("#supplierCode_select").select2();
	$("#counterCode_select").select2();
	$("#brandCode_select").select2();
	$("#isAddTag_select").select2({
		minimumResultsForSearch: -1
	});
	$("#supplierCode_select").attr("disabled", "disabled");
	$("#counterCode_select").attr("disabled", "disabled");
	$("#brandCode_select").attr("disabled", "disabled");
	initProduct();
	findShop();
	$("#storeCode_select").change(function(){
		findShopBrand();
		supplierCodeClick();
		counterCodeClick();
		$("#supplierCode_select").removeAttr("disabled");
		$("#counterCode_select").removeAttr("disabled");
		$("#brandCode_select").removeAttr("disabled");
	});
	
	/* $("#storeCode_select").on("click", findShop); */
	
	$("#pageSelect2").change(productQuery);

	//管理分类
	$("#proTreeDown").click(function() {
		if ($(this).attr("treeDown") == "true") {
			$(this).attr("treeDown", "false");
			proTreeDemo();
			$("#proBtnGroup").attr("class", "btn-group open");
		} else {
			$(this).attr("treeDown", "true");
			$("#proBtnGroup").attr("class", "btn-group");
		}
	});
	$("#proBtnGroup").blur(function(){
		$("#proBtnGroup").attr("class", "btn-group");
	});
	$(".select2-arrow b").attr("style", "line-height: 2;");
	
});
</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
		
	<div class="table-toolbar" style="padding: 0;">
		<div class="mtb10" style="margin-top: 0;">
			&nbsp;&nbsp;&nbsp;<span>门店名称：</span> 
			<select id="storeCode_select" style="padding: 0 0; width: 200px">
			    <option value="">全部</option>
			</select>&nbsp;&nbsp;
			<span>门店品牌名称：</span> 
			<select id="brandCode_select" style="padding: 0 0; width: 200px">
				<option value="">全部</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span>管理分类名称：</span>
			<div class="btn-group" style="width: 200px;margin:10px 0" id="proBtnGroup">
				<a href="javascript:void(0);" class="btn btn-default" id="proA"
					style="width: 81%;">请选择</a> <a id="proTreeDown"
					href="javascript:void(0);" class="btn btn-default" treeDown="true"><i
					class="fa fa-angle-down"></i></a>
				<ul id="proTreeDemo" class="dropdown-menu ztree form-group"
					style="margin-left: 0; width: 98%; position: absolute;overflow: auto;max-height: 300px;"></ul>
				<input type="hidden" id="manageCateGory" name="manageCateGory" />
			</div>
			<br>
			<span>供应商名称：</span> 
			<select id="supplierCode_select" style="padding: 0 0; width: 200px">
				<option value="">全部</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span>专柜名称：</span>
			<select id="counterCode_select" style="padding: 0 0; width: 200px">
				<option value="">全部</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span>专柜商品编码：</span>
			<input type="text" id="productCode_input" style="height:30px; width: 200px">
			<div id="isAdded" style="margin:10px 0;display: none;">
				<span>是否已加入该活动标签：</span> <select
					id="isAddTag_select" style="padding: 0 0; width: 200px">
					<option value="">全部</option>
					<option value="0">是</option>
					<option value="1">否</option>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>

			<div class="clearfix" style="float: right; margin-right: 100px;">
				<a class="btn btn-default shiny" onclick="query();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="btn btn-default shiny" onclick="reset();">重置</a>
			</div>
			
			<div class="clearfix" id="add_div" style="margin-left: 100px;display: none;">
				<a id="" onclick="addProductTag();" class="btn btn-primary"> <i
					class="fa fa-plus"></i> 添加
				</a>&nbsp;&nbsp;&nbsp;&nbsp; <a id="" onclick="deleteProductTag();"
					class="btn btn-primary"> <i class="fa fa-trash-o"></i> 去除
				</a>
			</div>
			<div class="clearfix" id="moreAdd_div" style="margin-left: 100px;">
				<a id="" onclick="addProductTagList();" class="btn btn-primary">导&nbsp;入
				</a>&nbsp;&nbsp;&nbsp;&nbsp; <a id="" onclick="closeBtDiv();"
					class="btn btn-primary"> 取&nbsp;消
				</a>
			</div>
		</div>
	</div>
	<div>
	    <table class="table table-bordered table-striped table-condensed table-hover flip-content"
	    style="width: 943px">
	        <thead class="flip-content bordered-darkorange">
				<tr>
					<th style="text-align: center;" width="5%" id="hide_th">选择</th>
					<th style="text-align: center;" width="10%">专柜商品编码</th>
					<th style="text-align: center;" width="15%">商品名称</th>
					<th style="text-align: center;" width="10%">门店</th>
					<th style="text-align: center;" width="14%">专柜</th>
					<th style="text-align: center;" width="15%">供应商</th>
					<th style="text-align: center;" width="8%">门店品牌</th>
					<th style="text-align: center;" width="8%">管理分类</th>
					<th style="text-align: center;" width="5%">状态</th>
				</tr>
			</thead>
	    </table>
	    <div style="overflow-y: scroll; height: 227px;">
		<table class="table table-bordered table-striped table-condensed table-hover flip-content"
			id="product_tab" style="table-layout:fixed;">
			<tbody>
			</tbody>
		</table>
		</div>
		<div class="pull-left" style="padding: 10px 0;">
			<form id="product_form" action="">
				<div class="col-lg-12">
					<select id="pageSelect2" name="pageSize" style="padding: 0 12px;">
						<option>5</option>
						<option selected="selected">10</option>
						<option>15</option>
						<option>20</option>
					</select>
				</div>
				&nbsp; <input type="hidden" id="storeCode_from" name="storeCode" />
				<input type="hidden" id="supplierCode_from" name="supplierCode" />
				<input type="hidden" id="manageCategory_from" name="manageCategory" />
				<input type="hidden" id="counterCode_from" name="counterCode" /> 
				<input type="hidden" id="brandCode_from" name="brandCode" />
				<input type="hidden" id="productCode_from" name="productCode" />
				<input type="hidden" id="isAddTag_from" name="isAddTag"/>
				<input type="hidden" id="tagSid_from" name="tagSid"/>
			</form>
		</div>
		<div id="productPagination"></div>
	</div>
	<!-- </div> -->
	<!-- Templates -->
	<p style="display: none">
		<textarea id="product-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left" width="5%" id="hide_td">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;">
														    <label style="padding-left:9px;margin: 6px 0;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td width="10%" align="center">{$T.Result.productCode}</td>
													<td width="15%" align="center">{$T.Result.productName}</td>
													<td width="10%" align="center">{$T.Result.storeName}</td>
													<td width="14%" align="center" >{$T.Result.counterName}</td>
													<td width="15%" align="center" id="supplierName_{$T.Result.sid}">{$T.Result.supplierName}</td>
													<td width="8%" align="center">{$T.Result.brandName}</td>
													<td width="8%" align="center">{$T.Result.glCategoryName}</td>
													<td width="5%" align="center">
														{#if $T.Result.isSale == 'Y'}<span class="label label-success graded"> 可售</span>
														{#elseif $T.Result.isSale == 'N'}<span class="label label-darkorange graded"> 不可售</span>
														{#/if}
													</td>
													<td style="display:none;" id="counterCode_{$T.Result.sid}">{$T.Result.counterCode}</td>
													<td style="display:none;" id="industryCondition_{$T.Result.sid}">{$T.Result.industrySid}</td>
													<td style="display:none;" id="discountCode_{$T.Result.sid}">{$T.Result.discountCode}</td>
													<td style="display:none;" id="spuSid_{$T.Result.sid}">{$T.Result.spuSid}</td>
													<td style="display:none;" id="productCode_{$T.Result.sid}">{$T.Result.productCode}</td>
													<td style="display:none;" id="colorSid_{$T.Result.sid}">{$T.Result.colorSid}</td>
													<td style="display:none;" id="proColor_{$T.Result.sid}">{$T.Result.proColor}</td>
													<td style="display:none;" id="features_{$T.Result.sid}">{$T.Result.features}</td>
												    <td style="display:none;" id="colorCode_{$T.Result.sid}">{$T.Result.colorCode}</td>
												    <td style="display:none;" id="stanCode_{$T.Result.sid}">{$T.Result.stanCode}</td>
												    <td style="display:none;" id="brandCode_{$T.Result.sid}">{$T.Result.brandCode}</td>
												    <td style="display:none;" id="modelCode_{$T.Result.sid}">{$T.Result.modelCode}</td>
												    <td style="display:none;" id="brandSid_{$T.Result.sid}">{$T.Result.brandSid}</td>
												    <td style="display:none;" id="storeCode_{$T.Result.sid}">{$T.Result.storeCode}</td>
												    <td style="display:none;" id="operateMode_{$T.Result.sid}">{$T.Result.operateMode}</td>
												    <td style="display:none;" id="storeSid_{$T.Result.sid}">{$T.Result.storeSid}</td>
												    <td style="display:none;" id="productName_{$T.Result.sid}">{$T.Result.productName}</td>
												    <td style="display:none;" id="isSale_{$T.Result.sid}">{$T.Result.isSale}</td>
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
	<!-- </div>
					</div>
				</div>
			</div>
			/Page Body
		</div>
		/Page Content
	</div> -->
	<!-- /Page Container -->
	<!-- Main Container -->
</body>
</html>