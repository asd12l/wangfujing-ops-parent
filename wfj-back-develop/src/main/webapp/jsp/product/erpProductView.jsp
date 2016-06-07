<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
WFJBackWeb - 大码商品列表
Version: 1.0.0
Author: YeDong/zhangdl
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
<script type="text/javascript">
	var productPagination;
	$(function() {
		selectAllShop();
		initProduct();
		$("#proType_select").change(productQuery);
		$("#pageSelect").change(productQuery);
		$("#shoppe_select").change(productQuery);
	});
	function productQuery() {
		$("#productCode_from").val($("#productCode_input").val());
		$("#productName_from").val($("#productName_input").val());
		$("#shoppe_from").val($("#shoppe_select").val());
		$("#shop_from").val($("#shop_select option:selected").attr("code"));
		$("#supplier_from").val($("#supplier_select option:selected").attr("code"));
		var params = $("#product_form").serialize();
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
		$("#productCode_input").val("");
		$("#productName_input").val("");
		$("#shoppe_select").val("");
		$("#shop_select").val($('#shop_select option:eq(0)').val()).select2();
		$("#supplier_select").val("").select2();
		productQuery();
	}

	var dataList;
	var dictResponse;
	var jyfs, yt, dmlx, splb;
	
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/dataDict/findDictByPidInfo",
		dataType : "json",
		async : false,
		ajaxStart : function() {
			$("#loading-container").prop("class", "loading-container");
		},
		ajaxStop : function() {
			$("#loading-container").addClass("loading-inactive");
		},
		data : {
			"codes" : "jyfs,yt,dmlx,splb"
		},
		success : function(response) {
			dictResponse = response.data;
			for (var i = 0; i < dictResponse.length; i++) {
				if (dictResponse[i].jyfs != null) {
					jyfs = dictResponse[i].jyfs;
				}
				if (dictResponse[i].yt != null) {
					yt = dictResponse[i].yt;
				}
				if (dictResponse[i].dmlx != null) {
					dmlx = dictResponse[i].dmlx;
				}
				if (dictResponse[i].splb != null) {
					splb = dictResponse[i].splb;
				}
			}
		}
	});

	function showDetail(sid) {	
		for (var i = 0; i < dataList.length; i++) {
			if (sid == dataList[i].sid) {
				var value = "";
				var itemClass;
				for ( var key in dataList[i]) {
					if (key == 'productType' || key == 'formatType'
							|| key == 'codeType' || key == 'productCategory') {
						if (key == 'productType') {
							/* console.log(key);
							console.log(jyfs); */
							itemClass = jyfs;
						} else if (key == 'formatType') {
							/* console.log(key);
							console.log(yt); */
							itemClass = yt;
						} else if (key == 'codeType') {
							/* console.log(key);
							console.log(dmlx); */
							itemClass = dmlx;
						} else {
							/* console.log(key);
							console.log(splb); */
							itemClass = splb;
						}
						if (typeof (itemClass) != "undefined") {
							for (var j = 0; j < itemClass.length; j++) {
								var itemCode = key == 'formatType' ? parseInt(itemClass[j].code) + 1 : itemClass[j].code;
								if (itemCode == dataList[i][key]) {
									value = itemClass[j].name;
									break;
								}
							}
						}
						$("#" + key + "_lb").html(value);
						continue;
					}
					if (key == 'isPromotion' || key == 'isAdjustPrice') {
						value = dataList[i][key] == 0 ? "允许" : "不允许";
						$("#" + key + "_lb").html(value);
						continue;
					}
					if (key == 'proStatus') {
						value = dataList[i][key] == 0 ? "启用" : "停用";
						$("#" + key + "_lb").html(value);
						continue;
					}
					if (dataList[i][key] == "" || dataList[i][key] == null) {
						value = "无";
					} else {
						value = dataList[i][key];
					}
					$("#" + key + "_lb").html(value);
				}
			}
		}
		$("#detailDiv").show();
	}

	function closeDetailDiv() {
		$("#detailDiv").hide();
	}
	//初始化商品列表
	function initProduct() {
		var url = $("#ctxPath").val() + "/product/selectErpProduct";
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
						async : false,
						param : "storeCode="+$("#shop_select option:selected").attr("code"),
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
	//查询所有门店
	function selectAllShop(){
		$('#shop_select').select2({'height':'20px'}); 
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
<script type="text/javascript">
	$(function(){
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
			productQuery();
			$('#shoppe_select').removeAttr("disabled");
		});
	});
	
	//根据门店查询供应商
	function selectSupplierByShop(){
		$('#supplier_select').html("<option value=''>全部</option>");
		$('#supplier_select').select2({'height':'20px'});
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
								<h5 class="widget-caption">大码商品管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<ul class="listInfo clearfix">
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
											<span>大码商品编码：</span> 
											<input type="text" id="productCode_input" style="width: 200px;"/>
										</li>
										<li>
											<span>大码商品名称：</span> 
											<input type="text" id="productName_input" style="width: 200px;"/>
										</li>
										<li>
											&nbsp;&nbsp; 
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
											<th style="text-align: center;">大码商品编码</th>
											<th style="text-align: center;">大码商品名称</th>
											<th style="text-align: center;">专柜名称</th>
											<th style="text-align: center;">门店名称</th>
											<th style="text-align: center;">计量单位</th>
											<th style="text-align: center;">大码商品类型</th>
											<th style="text-align: center;">价格</th>
											<th style="text-align: center;">品牌</th>
											<th style="text-align: center;">供应商</th>
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
										&nbsp; <input type="hidden" id="productCode_from" name="productCode" /> 
										<input type="hidden" id="productName_from" name="productName" />
										<input type="hidden" id="shoppe_from" name="shoppeCode" />
										<input type="hidden" id="shop_from" name="storeCode" />
										<input type="hidden" id="supplier_from" name="supplyCode" />
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
													<td align="center" id="productCode_{$T.Result.sid}">
													    <a onclick="showDetail({$T.Result.sid});" style="cursor:pointer;">
													        {$T.Result.productCode}</a>
													</td>
													<td align="center" id="productName_{$T.Result.sid}">
													    <a onclick="showDetail({$T.Result.sid});" style="cursor:pointer;">
													        {$T.Result.productName}</td>
													<td align="center" id="shoppeName_{$T.Result.sid}">{$T.Result.shoppeName}</td>
													<td align="center" id="shopName_{$T.Result.sid}">{$T.Result.shopName}</td>
													<td align="center" id="salesUnit_{$T.Result.sid}">{$T.Result.salesUnit}</td>
													<td align="center">
														{#if $T.Result.codeType == 0}价格码
														{#elseif $T.Result.codeType == 1}长期统码
														{#elseif $T.Result.codeType == 2}促销统码
														{#elseif $T.Result.codeType == 3}特卖统码
														{#elseif $T.Result.codeType == 4}扣率码
														{#elseif $T.Result.codeType == 5}促销扣率码
														{#elseif $T.Result.codeType == 6}单品码
														{#/if}
													</td>
													<td align="center" id="salesUnit_{$T.Result.sid}">{$T.Result.salesPrice}</td>
													<td align="center" id="salesUnit_{$T.Result.sid}">{$T.Result.brandName}</td>
													<td align="center" id="salesUnit_{$T.Result.sid}">{$T.Result.supplyName}</td>
													<td align="center" id="salesUnit_{$T.Result.sid}">
														{#if $T.Result.proStatus == 0}<span class="label label-success graded">启用</span>
														{#elseif $T.Result.proStatus == 1}<span class="label label-darkorange graded">停用</span>
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

	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="detailDiv">
		<div class="modal-dialog"
			style="width: 900px; height: 600px; margin: 4% auto;"
			style="border:1px solid red;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeDetailDiv();">×</button>
					<h4 class="modal-title">大码商品详情</h4>
				</div>
				<div class="modal-body" style="height: 450px;">
					<div class="bootbox-body"
						style="overflow-x: hidden; overflow-y: auto; max-height: 350px; margin-top: 20px;">
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">门店名称：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="shopName_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">门店编码：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="storeCode_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">大码商品名称：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="productName_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">大码商品编码：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="productCode_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">品牌：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="brandName_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">品牌编码：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="brandCode_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">供应商名称：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="supplyName_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">供应商编码：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="supplyCode_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">专柜：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="shoppeName_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">专柜编码：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="shoppeCode_lb"></label>
							</div>
							&nbsp;
						</div>

						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">经营方式：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="productType_lb"></label>
								<!-- <select style="height: 100%; width: 70%;" disabled="disabled">
									<option id="productType_lb"></option>
								</select> -->
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">业态类型：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="formatType_lb"></label>
								<!-- <select style="height: 100%; width: 70%;" disabled="disabled">
									<option id="formatType_lb"></option>
								</select> -->
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">大码商品类型：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="codeType_lb"></label>
								<!-- <select style="height: 100%; width: 70%;" disabled="disabled">
									<option id="codeType_lb"></option>
								</select> -->
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">供应商条码：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="supplierBarcode_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">商品类别：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="productCategory_lb"></label>
								<!-- <select style="height: 100%; width: 70%;" disabled="disabled">
									<option id="productCategory_lb"></option>
								</select> -->
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">货号：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="articleNum_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">售价：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="salesPrice_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">计量单位：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="salesUnit_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">是否允许调价：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="isAdjustPrice_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">是否允许促销：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="isPromotion_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">产地：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="originLand_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">折扣底限：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="discountLimit_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">服务费类型：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="serviceFeeType_lb"></label>
							</div>
							&nbsp;
						</div>


						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">规格：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="stanName_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">进项税：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="inputTax_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">消费税：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="salesTax_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">销项税：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="outputTax_lb"></label>
							</div>
							&nbsp;
						</div>
						<div class="col-md-6">
							<label class="col-lg-3 control-label"
								style="width: 35%; text-align: right;">状态：</label>
							<div class="col-lg-6" style="width: 65%;">
								<label class="control-label" id="proStatus_lb"></label>
							</div>
							&nbsp;
						</div>
					</div>
					<div class="form-group"
						style="overflow-y: auto; overflow-x: hidden; margin-top: 10px; background:;">
						<div class="col-lg-offset-4 col-lg-6">
							&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <input
								onclick="closeDetailDiv();" class="btn btn-danger"
								style="width: 25%;" id="close" type="button" value="关闭" />
						</div>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /Page Container -->
	<!-- Main Container -->
</body>
</html>