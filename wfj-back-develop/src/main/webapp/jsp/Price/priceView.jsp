<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/timeline/css/timeline2.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<!--Jquery Select2-->
<script
	src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var pricePagination;

	$(function() {
		/* $.ajax({//供应商
			type : "post",
			url : __ctxPath + "/stock/querySupplyInfoList",
			async : false,
			dataType : "json",
			success : function(response) {
				var list1 = response.list;
				var option = "<option value=''>所有</option>";
				$("#supplier_select").append(option);
				for (var i = 0; i < list1.length; i++) {
					var ele = list1[i];
					option = "<option value='"+ele.supplyCode+"'>"
							+ ele.supplyName + "</option>";
					$("#supplier_select").append(option);
				}
				return;
			}
		})
		$("#supplier_select").select2(); */
		/* $(".select2-arrow b").attr("style", "line-height: 2;"); */
		//渠道
		/* $.ajax({
			type : "post",
			url : __ctxPath + "/stock/queryChannelListAddPermission",
			dataType : "json",
			async : false,
			success : function(response) {
				var result = response.list;
				var option = "";
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.channelCode+"' sid='"+ele.sid+"'>" + ele.channelName
							+ "</option>";
				}
				$("#channelSid_select").append(option);
				return;
			}
		}); */
		/* $("#channelSid_select").select2(); */
		/* 	$(".select2-arrow b").attr("style", "line-height: 2;"); */

		/* $.ajax({//门店
			type : "post",
			url : __ctxPath + "/stock/queryShopList",
			async : false,
			dataType : "json",
			success : function(response) {
				var list1 = response.list;
				var option = "<option value=''>所有</option>";
				$("#shop_select").append(option);
				for (var i = 0; i < list1.length; i++) {
					var ele = list1[i];
					option = "<option value='"+ele.organizationCode+"'>"
							+ ele.organizationName + "</option>";
					$("#shop_select").append(option);
				}
				return;
			}
		})
		$("#shop_select").select2(); */

		/* 	$(".select2-arrow b").attr("style", "line-height: 2;"); */
		selectAllShop();
		initPrice();

		/* $("#productCode_input").change(priceQuery);
		$("#supplier_select").change(priceQuery);
		$("#shop_select").change(priceQuery);*/
		$("#pageSelect").change(priceQuery);
		 $("#shoppe_select").change(priceQuery);
	});
	function closeBtDiv() {
		$("#btDiv").hide();
	}
	function price(shoppeProSid) {
		$("#cd-timeline").html("")
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/productPrice/queryShoppeProPriceInfo",
					dataType : "json",
					data : {
						"shoppeProSid" : shoppeProSid
					},
					success : function(response) {
						var result = response.list;
						/* $("#prices").html(""); */
						
						for (var j = 0; j < result.length; j++) {
							var ele = result[j];

							var priceLine = "<div class='cd-timeline-block'>"
									+ "<div class='cd-timeline-img cd-picture'>"
									+ ele.promotionPrice
									+ "</div><div class='cd-timeline-content'><span class='cd-date'>"
									+ ele.promotionBeginTime
									+ "</span></div></div>"
									+ "<div class='cd-timeline-block'>"
									+ "<div class='cd-timeline-img cd-movie'>"
									+ ele.promotionPrice
									+ "</div><div class='cd-timeline-content'><span class='cd-date'>"
									+ ele.promotionEndTime
									+ "</span></div></div>"

							/* var li = "<li><div class='shiji' ><h1>"
									+ ele.originalPrice + "</h1>" + "<p>"
									+ ele.promotionBeginTime
									+ "</p></div></li>";
							//if (ele.promotionEndTime == '9999-12-31 23:59:59') {
							li = li + "<li><div class='shiji' ><h1>"
									+ ele.originalPrice + "</h1>" + "<p>"
									+ ele.promotionEndTime + "</p></div></li>";
							//}
							$("#prices").append(li); */
							$("#cd-timeline").append(priceLine);
						}
						$('.shiji').slideDown(600);
						$("#btDiv").show();
					},
					error : function(XMLHttpRequest, textStatus) {		      
						var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
						if(sstatus != "sessionOut"){
							$("#warning2Body").text(buildErrorMessage("","系统出错！"));
		 	     	        $("#warning2").show();
						}
						if(sstatus=="sessionOut"){     
			            	 $("#warning3").css('display','block');     
			             }
					}
				});
	}

	/*打开时间轴*/
	function showTimeLine() {
		$('.shiji').slideDown(600);

	}

	function priceQuery() {
		$("#productName_from").val($("#productCode_input").val());
		$("#channelSid_from").val($("#channelSid_select").val());
		$("#productSku_from").val($("#productSku_input").val());
		$("#shoppe_from").val($("#shoppe_select").val());
		$("#shop_from").val($("#shop_select option:selected").attr("code"));
		$("#supplier_from").val($("#supplier_select option:selected").attr("code"));
		var params = $("#price_form").serialize();
		//alert("表单序列化后请求参数:"+params);
		params = decodeURI(params);
		pricePagination.onLoad(params);
	}
	function find() {
		$("#productName_from").val($("#productCode_input").val());
		$("#channelSid_from").val($("#channelSid_select").val());
		$("#productSku_from").val($("#productSku_input").val());
		$("#shoppe_from").val($("#shoppe_select").val());
		$("#shop_from").val($("#shop_select option:selected").attr("code"));
		$("#supplier_from").val($("#supplier_select option:selected").attr("code"));
		var params = $("#price_form").serialize();
		params = decodeURI(params);
		pricePagination.onLoad(params);
	}

	function reset() {
		$('#supplier_select').prop("disabled", "disabled").select2();
		$('#shoppe_select').prop("disabled", "disabled").select2();
		$("#shop_select").val($('#shop_select option:eq(0)').val()).select2();

		$("#productCode_input").val("");
		
		$("#productSku_input").val("");

		$("#supplier_select").val($('#supplier_select option:eq(0)').val()).select2();
		$('#shoppe_select').val($('#shoppe_select option:eq(0)').val()).select2();

		$("#channelSid_select").val("0").trigger("change");
		priceQuery();
		init_1();
	}
	function initPrice() {
		var url = $("#ctxPath").val() + "/productPrice/selectPricePara";
		pricePagination = $("#pricePagination").myPagination(
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
						param : "storeCode="+$("#shop_select option:selected").attr("code")
								+ "&channelSid=0",
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive");
							}, 300);
						},
						callback : function(data) {
							//使用模板
							$("#price_tab tbody").setTemplateElement(
									"price-list").processTemplate(data);
							if(data != null && data.total != null){
								$("#total").text(data.total);
							}
						}
					}
				});
	}
	//导出excel
	function excelPrice() {
		var productCode = $("#productCode_input").val();
		var supplyCode = $("#supplier_select option:selected").val();
		var storeCode = $("#shop_select option:selected").attr("code");
        if(typeof(storeCode) == "undefined"){
            storeCode = "";
        }
		var channelSid = "0"/* $("#channelSid_select option:selected").attr("sid") */;
		var productSku = $("#productSku_input").val();
		var shoppe = $("#shoppe_select").val();
		
		var title = "priceSearch";
        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=utf-8",
            url : __ctxPath + "/productPrice/getStockToExcelCount",
            dataType : "json",
            async : false,
            data : {
                "productCode" : productCode,
                "supplyCode" : supplyCode,
                "storeCode" : storeCode,
                "channelSid" : channelSid,
                "productSku" : productSku,
                "shoppe" : shoppe
            },
            success : function(response) {
                if(typeof(response) != "undefined"){
                    if(response.count > 3000) {
                        $("#warning2Body").text(buildErrorMessage("","您申请导出的数据超过3000条，请调整查询条件后重试。"));
                        $("#warning2").show();
                        return;
                    }
                }
                window.open(__ctxPath + "/productPrice/getPriceToExcel?productCode="
                        + productCode + "&supplyCode=" + supplyCode
                        + "&storeCode=" + storeCode + "&channelSid=" + channelSid
                        + "&productSku" + productSku + "&shoppe" + shoppe
                        + "&title=" + title);
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

	//折叠页面
	function tab(data) {
		if ($("#" + data + "-i").attr("class") == "fa fa-minus") {
			$("#" + data + "-i").attr("class", "fa fa-plus");
			$("#" + data).css({
				"display" : "none"
			});
		} else if (data == 'pro') {
			$("#" + data + "-i").attr("class", "fa fa-minus");
			$("#" + data).css({
				"display" : "block"
			});
		} else {
			$("#" + data + "-i").attr("class", "fa fa-minus");
			$("#" + data).css({
				"display" : "block"
			});
			$("#" + data).parent().siblings().find(".widget-body").css({
				"display" : "none"
			});
			$("#" + data).parent().siblings().find(".fa-minus").attr("class",
					"fa fa-plus");
		}
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
			priceQuery();
		});
		$('#supplier_select').change(function(){
			selectShoppeByShopAndSupplier();
			priceQuery();
			$('#shoppe_select').removeAttr("disabled");
		});
	}
	
	$(function(){
		init_1();
	});
	
	//根据门店查询供应商
	function selectSupplierByShop(){
		$('#supplier_select').html("<option value=''>所有</option>");
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
					$("#warning2Body").text(buildErrorMessage("","系统出错！"));
 	     	        $("#warning2").show();
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
	}
	//根据门店和供应商查询专柜
	function selectShoppeByShopAndSupplier(){
		$('#shoppe_select').html("<option value=''>所有</option>");
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
	function getView(data) {
		var url = __ctxPath + "/product/selectShoppeProductByCode1/" + data;
		$(".loading-container").attr("class", "loading-container");
		$("#pageBody").load(url, {
			"backUrl" : "/jsp/Price/priceView.jsp"
		}, function(){
			$(".loading-container").addClass("loading-inactive");
		});
	}
	function getViewDetail(data) {
		var url = __ctxPath + "/product/getProductDetail/" + data;
		$(".loading-container").attr("class", "loading-container");
		$("#pageBody").load(url, {
			"backUrl" : "/jsp/Price/priceView.jsp"
		}, function(){
			$(".loading-container").addClass("loading-inactive");
		});
	}
</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">价格管理</h5>
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
										<a id="editabledatatable_new" onclick="excelPrice();"
											class="btn btn-yellow"> <i class="fa fa-edit"></i>
											导出Excel
										</a>
									</div>
									<div class="table-toolbar">
										<!-- <ul class="listInfo clearfix">
											<li><span>专柜商品编码：</span> <input type="text"
												id="productCode_input" style="width: 200px" /></li>
											<li><span>渠道：</span> <select id="channelSid_select"
												style="padding: 0 0; width: 200px"></select></li>
											<li><span>门店：</span> <select id="shop_select"
												style="padding: 0 0; width: 200px"></select></li>
											<li><span>供应商：</span> <select id="supplier_select"
												style="padding: 0 0; width: 200px"></select></li>
											<li style="height: 35px; margin-top: 0;"><a
												class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
												<a class="btn btn-default shiny" onclick="reset();">重置</a></li>
										</ul> -->
										<ul class="listInfo clearfix">
											<li>
                                                <span>商品SKU：</span>
                                                <input type="text" id="productSku_input" style="width: 200px;" />
                                            </li>
											<li>
                                                <span>专柜商品编码：</span>
                                                <input type="text" id="productCode_input" style="width: 200px;" />
                                            </li>
                                            <li style="display: none;">
                                                <span>渠道：</span>
                                                <select id="channelSid_select" style="width: 200px;">
                                                    <option value="0" code="0" sid="">所有</option>
                                                </select>
                                            </li>
                                            <li>
                                                <span>门店：</span>
                                                <select id="shop_select" style="width: 200px;">
                                                    <!-- <option value="">所有</option> -->
                                                </select>
                                            </li>
											<li>
                                                <span>供应商：</span>
                                                <select id="supplier_select" style="width: 200px;">
                                                    <option value="">所有</option>
                                                </select>
                                            </li>
											<li>
                                                <span>专柜名称：</span>
                                                <select id="shoppe_select" style="width: 200px;">
                                                    <option value="">所有</option>
                                                </select>
                                            </li>
											<li style="height:40px;">
                                                <a class="btn btn-default shiny" onclick="find();" style="margin-left: 10px;">查询</a>
												<a class="btn btn-default shiny" onclick="reset();" style="margin-left: 10px;">重置</a>
                                            </li>
										</ul>
										<table
											class="table table-bordered table-striped table-condensed table-hover flip-content"
											id="price_tab">
											<thead class="flip-content bordered-darkorange">
												<tr role="row">
													<!-- <th style="text-align: center;" width="7.5%">选择</th> -->
													<th style="text-align: center;">商品SKU</th>
													<th style="text-align: center;">商品名称</th>
													<th style="text-align: center;">专柜商品编码</th>
													<th style="text-align: center;">专柜名称</th>
													<th style="text-align: center;">款号</th>
													<th style="text-align: center;">颜色名称</th>
													<th style="text-align: center;">规格名称</th>
													<th style="text-align: center;">市场价</th>
													<th style="text-align: center;">零售价</th>
													<!-- <th style="text-align: center;">活动价</th> -->
													<th style="text-align: center;">供应商</th>
													<th style="text-align: center;">渠道</th>
													<th style="text-align: center;">门店</th>
													<th style="text-align: center;">价格详情</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
										<div class="btn-group pull-left">
											<form id="price_form" action="">
												<div class="col-lg-12" style="margin-top: 5px;">
													<select id="pageSelect" name="pageSize">
														<option>5</option>
														<option selected="selected">10</option>
														<option>15</option>
														<option>20</option>
													</select>
													<input type="hidden" id="productName_from" name="productCode" /> 
													<input type="hidden" id="productSku_from" name="productSku" /> 
													<input type="hidden" id="supplier_from" name="supplyCode" /> 
													<input type="hidden" id="shop_from" name="storeCode" />
													<input type="hidden" id="shoppe_from" name="shoppeCode" />
													<input type="hidden" id="channelSid_from" name="channelSid" />
												</div>
												&nbsp;
											</form>
										</div>
									</div>
									<div style="float: right;float: right !important;padding: 10px;color: rgb(72, 185, 239);">
										<div class="col-lg-12">
											<p>共&nbsp;<span id="total">0</span>&nbsp;条</p>
										</div>
									</div>
									<div id="pricePagination"></div>
								</div>
								<!-- Templates -->
								<p style="display: none">
									<textarea id="price-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left" style="display:none;">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="skuCode_{$T.Result.sid}" >
														{#if $T.Result.skuCode != null}
															<a onclick="getViewDetail('{$T.Result.skuCode}');" style="cursor:pointer;">{$T.Result.skuCode}</a>
														{/#if }
													</td>
													<td align="center" id="productName_{$T.Result.sid}" >
														{#if $T.Result.productName != null}
															{$T.Result.productName}
														{/#if }
													</td>
													<td align="center" id="productCode_{$T.Result.sid}">
														{#if $T.Result.productCode != null}
															<a onclick="getView('{$T.Result.productCode}');" style="cursor:pointer;">{$T.Result.productCode}</a>
														{/#if }
													</td>
													<td align="center">{$T.Result.counterName}</td>
													<td align="center" id="modelCode_{$T.Result.sid}">
													{#if $T.Result.modelCode != null}
														{$T.Result.modelCode.toString().replace(/\[object Object\]/ ,"--")}
													{/#if }</td>
													<td align="center" id="colorName_{$T.Result.sid}">
													{#if $T.Result.colorName != null}
														{$T.Result.colorName.toString().replace(/\[object Object\]/ ,"--")}
													{/#if}</td>
													<td align="center" id="stanName_{$T.Result.sid}">
													{#if $T.Result.stanName != null}
														{$T.Result.stanName.toString().replace(/\[object Object\]/ ,"--")}
													{/#if}</td>
													<td align="center" id="marketPrice_{$T.Result.sid}">
													{#if $T.Result.marketPrice != null}
														{$T.Result.marketPrice.toString().replace(/\[object Object\]/ ,"--")}
													{/#if}</td>
													<td align="center" id="salesPrice_{$T.Result.sid}">
													{#if $T.Result.salesPrice != null}
														{$T.Result.salesPrice.toString().replace(/\[object Object\]/ ,"--")}
													{#/if}
													</td>
													<td align="center" id="supplierName_{$T.Result.sid}">
													{#if $T.Result.supplierName != null}
														{$T.Result.supplierName.toString().replace(/\[object Object\]/ ,"--")}
													{/#if}</td>
													<td align="center" id="channelName_{$T.Result.sid}">
													{#if $T.Result.channelName != null}
														{$T.Result.channelName.toString().replace(/\[object Object\]/ ,"--")}
													{/#if}</td>
													<td align="center" id="storeName_{$T.Result.sid}">
													{#if $T.Result.storeName != null}
														{$T.Result.storeName.toString().replace(/\[object Object\]/ ,"--")}
													{/#if}</td>
													<td align="center">
														<a onclick="price('{$T.Result.productCode}')" id="storeName_{$T.Result.sid}" style="cursor:pointer;color:blue">
															价格详情点击
														</a>
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
				<!-- /Page Container -->
			</div>
		</div>
		<!-- Main Container -->
	</div>

	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="btDiv1">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv();">×</button>
					<h2 class="modal-title" id="divTitle">价格详情(元)</h2>
				</div>
				<div class="page-body" id="pageBodyRight">
					<div class="row">
						<div class="col-xs-12 col-md-12">
							<div class="widget">
								<div class="clearfix course_nr">
									<ul id="prices" class="course_nr2">
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv();" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="btDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv();">×</button>
					<h2 class="modal-title" id="divTitle">价格详情(元)</h2>
				</div>
				<div class="page-body" id="pageBodyRight"
					style="overflow-x: hidden; height: 400px;">
					<div class="row">
						<div class="col-xs-12 col-md-12">
							<div class="widget">
								<section id="cd-timeline" class="cd-container">
								</section>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv();" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

</body>
<script>
	jQuery(document).ready(function() {
		$('#divTitle').mousedown(function(event) {
			var isMove = true;
			var abs_x = event.pageX - $('#btDiv').offset().left;
			var abs_y = event.pageY - $('#btDiv').offset().top;
			$(document).mousemove(function(event) {
				if (isMove) {
					var obj = $('#btDiv');
					obj.css({
						'left' : event.pageX - abs_x,
						'top' : event.pageY - abs_y
					});
				}
			}).mouseup(function() {
				isMove = false;
			});
		});
	});
</script>
</html>