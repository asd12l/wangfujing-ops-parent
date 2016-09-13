<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
WFJBackWeb - 商品列表页
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
<script
	src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script	src="${pageContext.request.contextPath}/assets/js/select2/selectAjax.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/selectAjax.css" />
<script type="text/javascript">
var sessionId = "<%=request.getSession().getId() %>";
	/* 色系列表 */
	function fingColorDict() {
		var proColor = $("#colorSid_select");// 色系对象
		$.ajax({
			type : "post",
			async : false,
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/colorManage/fingColorDict",
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			success : function(response) {
				var result = response.list;
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.sid + "'>"
							+ ele.colorName + "</option>");
					option.appendTo(proColor);
				}
				return;
			}
		});
	}
	//集团品牌
	/* function findBrand() {
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/brandDisplay/queryBrandGroupListPartInfo",
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
						"brandType" : 0,
						"page" : 1,
						"pageSize" : 1000000
					},
					success : function(response) {
                        if(response.success == "true") {
                            var result = response.list;
                            var option = "";
                            for (var i = 0; i < result.length; i++) {
                                var ele = result[i];
                                option += "<option sid='" + ele.brandSid + "' value='" + ele.brandSid + "'>"
                                        + ele.brandName + "</option>";
                            }
                        }
						$("#brandGroupCode_select").append(option);
						$("#brandGroupCode_select").select2();
						$("#s2id_brandGroupCode_select span:eq(0)").prop("style","text-align:left;");
						return;
					}
				});
		return;
	} */

	//findBrand();//查询集团品牌 
	fingColorDict();

	var productPagination;
	$(function() {
		initProduct();
		$("#proType_select").change(productQuery);
		$("#proActiveBit_select").change(productQuery);
		$("#pageSelect").change(productQuery);

		$("#BrandCode").change(productQuery);
		$("#colorSid_select").change(productQuery);
		$("#photoStatus_select").change(productQuery);
		$("#skuSale_select").change(productQuery);
		
		$("#BrandCode_input").keyup(function(e){
			var e = e || event;
			var code = e.keyCode;
			if(code != 32 && !(code >=37 && code <= 40) && !(code >=16 && code <= 18) && code != 93){
				seachData($("#BrandCode_input").val());
			}
		});
		
		/* $("#brandGroupCode_select").select2();
		$("#s2id_brandGroupCode_select span:eq(0)").prop("style","text-align:left;");
		$(".listInfo li:eq(0)").click(findBrand); */
	});
	function productQuery() {
		var minSkuCode = $("#skuCode_input").val().trim();
		var maxSkuCode = $("#maxSkuCode_input").val().trim();
		if(minSkuCode != "" && maxSkuCode != ""){
			$("#minSkuCode_from").val(minSkuCode);
			$("#maxSkuCode_from").val(maxSkuCode);
			$("#skuCode_from").val("");
		} else if(minSkuCode != "" && maxSkuCode == ""){
			$("#minSkuCode_from").val("");
			$("#maxSkuCode_from").val("");
			$("#skuCode_from").val(minSkuCode);
		} else if(minSkuCode == "" && maxSkuCode != ""){
			$("#minSkuCode_from").val("");
			$("#maxSkuCode_from").val("");
			$("#skuCode_from").val(maxSkuCode);
		} else if(minSkuCode == "" && maxSkuCode == ""){
			$("#minSkuCode_from").val("");
			$("#maxSkuCode_from").val("");
			$("#skuCode_from").val("");
		}
		$("#skuName_from").val($("#skuName_input").val());
		$("#proType_from").val($("#proType_select").val());
		$("#proActiveBit_from").val($("#proActiveBit_select").val());
		
		$("#brandGroupCode_from").val($("#BrandCode option:eq(0)").attr("sid"));
		$("#modelCode_from").val($("#modelCode_input").val());
		$("#colorSid_from").val($("#colorSid_select").val());
		$("#photoStatus_from").val($("#photoStatus_select").val());
		$("#skuSale_from").val($("#skuSale_select").val());
		
		var params = $("#product_form").serialize();
		LA.sysCode = "16";
		LA.log("product.productQuery", "商品查询：" + params, getCookieValue("username"), sessionId);
		params = decodeURI(params);
		productPagination.onLoad(params);
	}
	// 查询
	function query() {
		$("#cache").val(0);
		productQuery();
	}
	// 重置
	function reset() {
		$("#cache").val(1);
		$("#skuCode_input").val("");
		$("#maxSkuCode_input").val("");
		$("#skuName_input").val("");
		$("#proType_select").val("");
		$("#proActiveBit_select").val("");
		
		//$("#brandGroupCode_select").select2().select2("val","");
		//$("#s2id_brandGroupCode_select span:eq(0)").prop("style","text-align:left;");
		$("#BrandCode").html("<option value='' sid=''>请选择</option>"); 
		$("#BrandCode_input").val(""); 
		$("#colorSid_select").val("");
		$("#photoStatus_select").val("");
		$("#skuSale_select").val("");
		$("#modelCode_input").val("");
		productQuery();
	}

	var dataList;
	//初始化商品列表
	function initProduct() {
		var url = $("#ctxPath").val() + "/product/selectAllProduct";
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
							dataList = data.list;
							$("#product_tab tbody").setTemplateElement(
									"product-list").processTemplate(data);
						}
					}
				});
	}
</script>
<!-- 按钮事件-添加商品 -->
<script type="text/javascript">
	function addProduct() {
		$("#pageBody").load(__ctxPath + "/jsp/product/productSaveView_1.jsp");
	}
</script>
<!-- 按钮事件-查询商品详情 -->
<script type="text/javascript">
	function getProduct() {
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
			$("#warning2Body").text("请选取要查看的列!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		var url = __ctxPath + "/product/getProductDetail/" + value;
		$("#pageBody").load(url);
	}
</script>
<!-- 商品下架 -->
<script type="text/javascript">
	function appendProduct() {
		var count = 0;
		var checkboxArray = new Array();
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			var skuSale = $("#skuSale_" + productSid).html().trim();
			if (skuSale == "0" || skuSale == "2") {
				count++;
			}
			checkboxArray.push(productSid);
		});
		var inT = JSON.stringify(checkboxArray);
		inT = inT.replace(/\%/g, "%25");
		inT = inT.replace(/\#/g, "%23");
		inT = inT.replace(/\&/g, "%26");
		inT = inT.replace(/\+/g, "%2B");
		if (count != 0 || checkboxArray.length == 0) {
			$("#warning2Body").text("请选取已上架的商品!");
			$("#warning2").show();
			return false;
		}
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/sellProduct",
			async : false,
			dataType : "json",
			data : {
				"sids" : inT,
				"status" : 2
			},
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				if (response.success == "true") {
					var mes = "<div style='text-align:left;'>";
					for ( var i = 0; i < response.data.length; i++) {
						mes = mes + response.data[i] + "<br/>";
					}
					mes = mes + "</div>";
					$("#warning2Body").html(mes);
					$("#warning2").show();
					productQuery();
				}
			}
		});
	}
</script>
<!-- 按钮事件-商品上架 -->
<script type="text/javascript">
	function updateProduct() {
		var count = 0;
		var checkboxArray = new Array();
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			var skuSale = $("#skuSale_" + productSid).html().trim();
			if (skuSale == "1") {
				count++;
			}
			checkboxArray.push(productSid);
		});
		var inT = JSON.stringify(checkboxArray);
		inT = inT.replace(/\%/g, "%25");
		inT = inT.replace(/\#/g, "%23");
		inT = inT.replace(/\&/g, "%26");
		inT = inT.replace(/\+/g, "%2B");
		if (count != 0 || checkboxArray.length == 0) {
			$("#warning2Body").text("请选取未上架或已下架的商品!");
			$("#warning2").show();
			return false;
		}
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/sellProduct",
			async : false,
			dataType : "json",
			data : {
				"sids" : inT,
				"status" : 1
			},
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				if (response.success == "true") {
					var mes = "<div style='text-align:left;'>";
					for ( var i = 0; i < response.data.length; i++) {
						mes = mes + response.data[i] + "<br/>";
					}
					mes = mes + "</div>";
					$("#warning2Body").html(mes);
					$("#warning2").show();
					productQuery();
				}
			}
		});
	}
</script>
<!-- 按钮事件-商品停用 -->
<script type="text/javascript">
	function deleteProduct() {
		var count = 0;
		var checkboxArray = new Array();
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			var proActiveBit = $("#proActiveBit_" + productSid).html().trim();
			if (proActiveBit == "0") {
				count++
				return false;
			}
			checkboxArray.push(productSid);
		});
		var inT = JSON.stringify(checkboxArray);
		inT = inT.replace(/\%/g, "%25");
		inT = inT.replace(/\#/g, "%23");
		inT = inT.replace(/\&/g, "%26");
		inT = inT.replace(/\+/g, "%2B");
		if (count != 0 || checkboxArray.length == 0) {
			$("#warning2Body").text("请选取未停用的商品!");
			$("#warning2").show();
			return false;
		}
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/product/deleteProduct",
					async : false,
					dataType : "json",
					data : {
						"sids" : inT,
						"status" : 0
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
					}

				});
	}
</script>
<!--  -->
<script type="text/javascript">
	var productChangePropId = "";
	var category_Sid = "";
	var category_Name = "";
	var spuSid = "";

	var productDetail;

	/* 商品启用 */
	function editProductSX() {
		var count = 0;
		var checkboxArray = new Array();
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			var proActiveBit = $("#proActiveBit_" + productSid).html().trim();
			if (proActiveBit == "1") {
				count++;
			}
			checkboxArray.push(productSid);
		});
		var inT = JSON.stringify(checkboxArray);
		inT = inT.replace(/\%/g, "%25");
		inT = inT.replace(/\#/g, "%23");
		inT = inT.replace(/\&/g, "%26");
		inT = inT.replace(/\+/g, "%2B");
		if (count != 0 || checkboxArray.length == 0) {
			$("#warning2Body").text("请选取已停用的商品!");
			$("#warning2").show();
			return false;
		}
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/product/deleteProduct",
					async : false,
					dataType : "json",
					data : {
						"sids" : inT,
						"status" : 1
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
							/* $("#warning2Body").text("操作成功!");
							$("#warning2").show(); */
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
					}

				});
	}
</script>
<!-- 操作 -->
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
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
	}
</script>
<!-- 点击编码或者名称查询详情 -->
<script type="text/javascript">
	function getView(data) {
		var url = __ctxPath + "/product/getProductDetail/" + data;
		$("#pageBody").load(url, {
			"backUrl" : "/jsp/product/ProductStatus.jsp"
		});
	}

	function editProduct(data) {
		var url = __ctxPath + "/product/getShoppeBySkuSid?skuSid=" + data;
		$("#pageBody").load(url);
	}
</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
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
								<h5 class="widget-caption">商品状态管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<div class="clearfix">
										<!-- 										<a id="editabledatatable_new" onclick="updateProduct();" -->
										<!-- 											class="btn btn-primary"> <i class="fa fa-edit"></i> 商品上架 -->
										<!-- 										</a>&nbsp;&nbsp;&nbsp;&nbsp; <a id="editabledatatable_new" -->
										<!-- 											onclick="appendProduct();" class="btn btn-primary"> <i -->
										<!-- 											class="fa fa-edit"></i> 商品下架 -->
										<!-- 										</a>&nbsp;&nbsp;&nbsp;&nbsp;  -->
										<a id="editabledatatable_new" onclick="editProductSX();"
											class="btn btn-primary"> <i class="fa fa-edit"></i> 商品启用
										</a>&nbsp;&nbsp;&nbsp;&nbsp;<a id="editabledatatable_new"
											onclick="deleteProduct();" class="btn btn-primary"> <i
											class="fa fa-edit"></i> 商品停用
										</a>
									</div>
									<div class="mtb10" style="float:left;width:100%;margin-bottom:0">
										<div class="col-md-3" style="margin-bottom: 15px;width:24%">
											<label style="width: 70px; text-align: right;">商品编码：</label>
											<input style="width: 66px;" type="text" id="skuCode_input" />
											~
											<input style="width: 66px;" type="text" id="maxSkuCode_input" />
										</div>
										<div class="col-md-3" style="margin-bottom: 15px;width:24%">
											<label style="width: 70px; text-align: right;">标准品名：</label>
											<input style="width: 150px;" type="text" id="skuName_input" />
										</div>
										<div class="col-md-3" style="margin-bottom: 15px;width:24%">
											<label style="width: 70px; text-align: right;">是否停用：</label>
											<select id="proActiveBit_select" style="width: 150px;">
												<option value="">全部</option>
												<option value="1">启用</option>
												<option value="0">停用</option>
											</select>
										</div>
										<div class="col-md-3" style="margin-bottom: 15px;width:24%">
											<label style="width: 70px; text-align: right;">类型：</label> <select
												id="proType_select" style="width: 150px;">
												<option value="">全部</option>
												<option value="1">普通商品</option>
												<option value="2">赠品</option>
												<option value="3">礼品</option>
												<option value="4">虚拟商品</option>
												<option value="5">服务类商品</option>
											</select>
										</div>
										</div>
										<div class="mtb10" style="float:left;width:100%;margin-bottom:0;margin-top:0">
										<div class="col-md-3" style="margin-bottom: 15px;width:24%">
											<label style="width: 70px; text-align: right;">款号：</label> <input
												style="width: 150px;" type="text" id="modelCode_input" />
										</div>
										<div class="col-md-3" style="margin-bottom: 15px;width:24%">
											<label style="width: 70px; text-align: right;">色系：</label> <select
												style="width: 150px;" id="colorSid_select">
												<option value="">全部</option>
											</select>
										</div>
										<div class="col-md-3" style="margin-bottom: 15px;width:24%">
											<label style="width: 70px; text-align: right;">拍照状态：</label>
											<select style="width: 150px;" id="photoStatus_select">
												<option value="">全部</option>
												<option value="0">未拍照</option>
												<option value="1">已加入计划</option>
												<option value="3">已拍照上传</option>
												<option value="4">已编辑</option>
											</select>
										</div>
										<div class="col-md-3" style="margin-bottom: 15px;width:24%">
											<label style="width: 70px; text-align: right;">上架状态：</label>
											<select style="width: 150px;" id="skuSale_select">
												<option value="">全部</option>
												<option value="0">未上架</option>
												<option value="1">上架</option>
												<option value="2">已下架</option>
											</select>
										</div>
										</div>
										<div class="mtb10" style="float:left;width:100%;margin-bottom:0;margin-top:0">
										<ul class="listInfo" style="margin-left: 15px;width:24%;">
											<li>
												<label style="width: 70px;text-align:right;">集团品牌：</label>
											    <select id="BrandCode" name="parentSid"
													style="width: 100%;display: none;">
													<option value="" sid="">请选择</option>	
												</select>
												<input id="BrandCode_input" class="_input" type="text"
													   value="" placeholder="请输入集团品牌" autocomplete="off" style="width: 150px;height: 25px;">
												<div id="dataList_hidden" class="_hiddenDiv" style="width: 150px;margin-left: 74px;">
													<ul></ul>
												</div>
											</li>
										</ul>
										<div class="col-md-3" style="margin-bottom: 15px;width:24%">
											<a class="btn btn-default shiny" onclick="query();">查询</a>
											&nbsp;&nbsp;&nbsp;&nbsp; <a class="btn btn-default shiny"
												onclick="reset();">重置</a>
										</div>
									</div>
								</div>
								<table
									class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="product_tab" style="table-layout: fixed;">
									<thead class="flip-content bordered-darkorange">
										<tr>
											<th style="text-align: center;" width="5%">选择</th>
											<th style="text-align: center; width: 100px;">商品编码</th>
											<th style="text-align: center; width: 150px;">标准品名</th>
											<!-- <th style="text-align: center;">产品名称</th> -->
											<th style="text-align: center; width: 100px;">集团品牌名称</th>
											<th style="text-align: center;">商品类型</th>
											<th style="text-align: center; width: 100px;">款号/主属性</th>
											<th style="text-align: center; width: 60px;">色系</th>
											<th style="text-align: center;">色码/特性</th>
											<th style="text-align: center;">规格</th>
											<th style="text-align: center;">拍照状态</th>
											<th style="text-align: center;">上架状态</th>
											<th style="text-align: center;">是否停用</th>
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
										<input type="hidden" id="skuCode_from" name="skuCode" />
										<input type="hidden" id="minSkuCode_from" name="minSkuCode" />
										<input type="hidden" id="maxSkuCode_from" name="maxSkuCode" />
										<input type="hidden" id="skuName_from" name="skuName" />
										<input type="hidden" id="proType_from" name="proType" />
										<input type="hidden" id="proActiveBit_from" name="proActiveBit" />
										<input type="hidden" id="brandGroupCode_from" name="brandGroupCode" />
										<input type="hidden" id="modelCode_from" name="modelCode" />
										<input type="hidden" id="colorSid_from" name="colorSid" />
										<input type="hidden" id="photoStatus_from" name="photoStatus" />
										<input type="hidden" id="skuSale_from" name="skuSale" />
										<input type="hidden" id="cache" name="cache" value="1" />
									</form>
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
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center">
														<a onclick="getView('{$T.Result.skuCode}');" style="cursor:pointer;">{$T.Result.skuCode}</a></td>
													<td align="center" style="text-overflow:ellipsis;word-break:keep-all;overflow:hidden;">
														<a onclick="getView({$T.Result.sid});" style="cursor:pointer;">{$T.Result.skuName}</a></td>
													<td align="center" style="display:none;">{$T.Result.spuName}</td>
													<td align="center" style="text-overflow:ellipsis;word-break:keep-all;overflow:hidden;">
													    {$T.Result.brandGroupName}
													</td>
													<td align="center">
														{#if $T.Result.proType == 1}普通商品
														{#elseif $T.Result.proType == 2}赠品
														{#elseif $T.Result.proType == 3}礼品
														{#elseif $T.Result.proType == 4}虚拟商品
														{#elseif $T.Result.proType == 5}服务类商品
														{#/if}
													</td>
													<td align="center" style="text-overflow:ellipsis;word-break:keep-all;overflow:hidden;">
													    {#if $T.Result.modelCode == "" || $T.Result.modelCode == null}{$T.Result.primaryAttr}
													    {#else}{$T.Result.modelCode}
													    {#/if}
													</td>
													<td align="center">{$T.Result.colorName}</td>
													<td align="center" style="text-overflow:ellipsis;word-break:keep-all;overflow:hidden;">
													    {#if $T.Result.colorCode == "" || $T.Result.colorCode == null}{$T.Result.features}
													    {#else}{$T.Result.colorCode}
													    {#/if}
													</td>
													<td align="center">{$T.Result.stanName}</td>
													<td align="center">
														{#if $T.Result.photoStatus == 0}<span>未拍照</span>
														{#elseif $T.Result.photoStatus == 1}<span>已加入计划</span>
														{#elseif $T.Result.photoStatus == 3}<span>已拍照已上传</span>
														{#elseif $T.Result.photoStatus == 4}<span>已编辑</span>
														{#/if}
													</td>
													<td align="center">
														{#if $T.Result.skuSale == 0}<span>未上架</span>
														{#elseif $T.Result.skuSale == 1}<span>上架</span>
														{#elseif $T.Result.skuSale == 2}<span>已下架</span>
														{#/if}
													</td>
													<td align="center">
														{#if $T.Result.proActiveBit == 1}<span class="label label-success graded">启用</span>
														{#elseif $T.Result.proActiveBit == 0}<span class="label label-darkorange graded">停用</span>
														{#/if}
													</td>
													<td style="display:none;" id="category_{$T.Result.sid}">{$T.Result.category}</td>
													<td style="display:none;" id="categoryName_{$T.Result.sid}">{$T.Result.categoryName}</td>
													<td style="display:none;" id="statCategoryName_{$T.Result.sid}">{$T.Result.statCategoryName}</td>
													<td style="display:none;" id="spuCode_{$T.Result.sid}">{$T.Result.spuCode}</td>
													<td style="display:none;" id="spuSid_{$T.Result.sid}">{$T.Result.spuSid}</td>
													<td style="display:none;" id="proActiveBit_{$T.Result.sid}">{$T.Result.proActiveBit}</td>
													<td style="display:none;" id="skuSale_{$T.Result.sid}">{$T.Result.skuSale}</td>
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
</body>
</html>