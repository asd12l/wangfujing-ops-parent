<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	var stockPagination;
	$(function() { 
		//供应商
		$.ajax({
			type : "post",
			url : __ctxPath + "/stock/querySupplyInfoList",
			dataType : "json",
			async:false,
			success : function(response) {
				var result = response.list;
				var option = "<option value=''>所有</option>";
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.sid+"'>" + ele.supplyName
							+ "</option>";
				$("#supplySid_select").append(option);
				}
				return;
			}
		})
		$("#supplySid_select").select2();
		$(".select2-arrow b").attr("style", "line-height: 2;");
		//渠道
		$.ajax({
			type : "post",
			url : __ctxPath + "/stock/queryChannelList",
			dataType : "json",
			async:false,
			success : function(response) {
				var result = response.list;
				var option = "<option value=''>所有</option>";
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.channelCode+"'>" + ele.channelName
							+ "</option>";
				$("#channelSid_select").append(option);
				}
				return;
			}
		})
		$("#channelSid_select").select2();
		$(".select2-arrow b").attr("style", "line-height: 2;");
		//门店
		$.ajax({
			type : "post",
			url : __ctxPath + "/stock/queryShopList",
			dataType : "json",
			async:false,
			success : function(response) {
				var result = response.list;
				var option = "<option value=''>所有</option>";
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.organizationCode+"'>" + ele.organizationName
							+ "</option>";
				$("#shopSid_select").append(option);
				}
				return;
			}
		})
		$("#shopSid_select").select2();
		$(".select2-arrow b").attr("style", "line-height: 2;");
		initStock();
		
		/* $("#supplySid_select").change(stockQuery);
		$("#channelSid_select").change(stockQuery);
		$("#shopSid_select").change(stockQuery); */
		$("#pageSelect").change(stockQuery);
	});
	function stockQuery() {
		$("#productSku_from").val($("#productSku_input").val());
		$("#productCode_from").val($("#productCode_input").val());
		$("#supplySid_from").val($("#supplySid_select").val());
		$("#channelSid_from").val($("#channelSid_select").val());
		$("#shopSid_from").val($("#shopSid_select").val());
		var params = $("#stock_form").serialize();
		//alert("表单序列化后请求参数:"+params);
		params = decodeURI(params);
		stockPagination.onLoad(params);
	}
	function find() {
		/* $("#supplySid_select").change(stockQuery);
		$("#channelSid_select").change(stockQuery);
		$("#shopSid_select").change(stockQuery);
		$("#productSku_input").change(stockQuery); 
		$("#productCode_input").change(stockQuery);  */
		stockQuery();
	}
	function reset() {
		$("#productSku_input").val("");
		$("#productCode_input").val("");
		$("#supplySid_select").val("").trigger("change");
		$("#channelSid_select").val("").trigger("change");
		$("#shopSid_select").val("").trigger("change");
		stockQuery();
	}
	function initStock() {
		var url = $("#ctxPath").val() + "/stock/selectStockSearch";
		stockPagination = $("#stockPagination").myPagination(
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
							ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								ZENG.msgbox.hide();
							}, 300);
						},
						callback : function(data) {
							//使用模板
							$("#stock_tab tbody").setTemplateElement(
									"stock-list").processTemplate(data);
						}
					}
				});
	}
	function editStock() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		} else if (checkboxArray.length == 0) {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		var value = checkboxArray[0];
		stockSid = value;
		saleStock_ = $("#saleStock_" + value).text().trim();
		productSku_ = $("#productSku_" + value).text().trim();
		proColorName_ = $("#proColorName_" + value).text().trim();
		proStanName_ = $("#proStanName_" + value).text().trim();
		proSum_ = $("#proSum_" + value).text().trim();
		stockName_ = $("#stockName_" + value).text().trim();
		brandName_ = $("#brandName_" + value).text().trim();
		supplyName_ = $("#supplyName_" + value).text().trim();
		shopName_ = $("#shopName_" + value).text().trim();
		productDetailSid_ = $("#productDetailSid_" + value).text().trim();
		var url = __ctxPath + "/jsp/StockSearch/editStockSearch.jsp";
		$("#pageBody").load(url);
	}
	function delStock() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			ZENG.msgbox.show(" 只能选择一列", 5, 2000);
			return false;
		} else if (checkboxArray.length == 0) {
			ZENG.msgbox.show("请选取要补充的列", 5, 2000);
			return false;
		}
		var value = checkboxArray[0];
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/stockSearch/deleteStockSearch",
					dataType : "json",
					data : {
						"sid" : value
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>删除成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
						} else {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
						}
						return;
					}
				});
	}
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
		$("#pageBody").load(__ctxPath + "/jsp/StockSearch/StockSearchView.jsp");
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
								<span class="widget-caption"><h5>库存管理</h5> </span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<!-- <div class="table-toolbar">
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="editStock();"
											class="btn btn-info" style="width: 100%;"> <i
											class="fa fa-wrench"></i> 修改库存信息 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="delStock();"
											class="btn btn-danger" style="width: 100%;"> <i
											class="fa fa-times"></i> 删除库存信息 </a>
									</div>
									<div class="col-md-8">
										
									</div>
								</div> -->
								<!-- <div class="table-toolbar">
									<a id="editabledatatable_new" onclick="editStock();"
										class="btn btn-primary"> <i class="fa fa-plus"></i> 修改库存信息 </a>&nbsp;&nbsp;
									<a id="editabledatatable_new" onclick="delStock();"
										class="btn btn-info"> <i class="fa fa-wrench"></i> 删除库存信息
									</a>
								</div> -->
								<div class="table-toolbar">
								<div class="col-md-12">
									<div class="col-md-4">
										<div class="col-lg-5"><span>商品Sku：</span></div>
										<div class="col-lg-7"><input type="text" id="productSku_input" style="width: 100%"/></div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-5"><span>专柜商品编码：</span></div>
										<div class="col-lg-7"><input type="text" id="productCode_input" style="width: 100%"/></div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-5"><span>供应商：</span></div>
										<div class="col-lg-7"><select id="supplySid_select"
											 style="padding: 0 0;width: 100%"></select></div>
									</div>
								</div>
									&nbsp;
								<div class="col-md-12">
									<div class="col-md-4">
										<div class="col-lg-5"><span>门店：</span></div>
										<div class="col-lg-7"><select id="shopSid_select"
											 style="padding: 0 0;width: 100%"></select></div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-5"><span>渠道：</span></div>
										<div class="col-lg-7"><select id="channelSid_select"
											 style="padding: 0 0;width: 100%"></select></div>
									</div>
									<div class="col-md-4">
										<div class="col-lg-12">
											<a class="btn btn-default shiny" onclick="find();"
												style="height: 32px; margin-top: -4px;">查询</a>
											<a class="btn btn-default shiny" onclick="reset();"
												style="height: 32px; margin-top: -4px;">重置</a>
										</div>
										&nbsp;
									</div>
									</div>
								</div>
								<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="stock_tab">
                                       <thead class="flip-content bordered-darkorange">
										<tr role="row">
											<th width="7.5%"></th>
											<th style="text-align: center;">商品SKU</th>
											<th style="text-align: center;">专柜商品编码</th>
											<th style="text-align: center;">销售单位</th>
											<!-- <th style="text-align: center;">库存数</th>
											<th style="text-align: center;">库位</th> -->
											<th style="text-align: center;">可售库</th>
											<th style="text-align: center;">残次品库</th>
											<th style="text-align: center;">退货库</th>
											<th style="text-align: center;">锁定库</th>
											<th style="text-align: center;">品牌</th>
											<th style="text-align: center;">供应商</th>
											<th style="text-align: center;">渠道</th>
											<th style="text-align: center;">门店</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="stock_form" action="">
										<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp; 
										 <input type="hidden" id="productSku_from" name="skuCode" /> 
										 <input type="hidden" id="productCode_from" name="productCode" /> 
										 <input type="hidden" id="supplySid_from" name="supplierSid" /> 
										 <input type="hidden" id="channelSid_from" name="channelSid" /> 
										 <input type="hidden" id="shopSid_from" name="storeCode" />
									</form>
								</div>
								<div id="stockPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="stock-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox"  style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="skuCode_{$T.Result.sid}">{$T.Result.skuCode}</td>
													<td align="center" id="productCode_{$T.Result.sid}">{$T.Result.productCode}</td>
													<td align="center" id="unitName_{$T.Result.sid}">{$T.Result.unitName}</td>
													<td align="center" style="display:none;" id="unitCode_{$T.Result.sid}">{$T.Result.unitCode}</td>
													
													<td align="center" id="saleStock_{$T.Result.sid}">
													{#if $T.Result.saleStock == null}
														<span>0</span>
													{#else}
														{$T.Result.saleStock}
													{#/if}
													</td>
													<td align="center" id="edefectiveStock_{$T.Result.sid}">
													{#if $T.Result.edefectiveStock == null}
														<span>0</span>
													{#else}
													{$T.Result.edefectiveStock}
													{#/if}
													</td>
													<td align="center" id="returnStock_{$T.Result.sid}">
													{#if $T.Result.returnStock == null}
														<span>0</span>
													{#else}
													{$T.Result.returnStock}
													{#/if}
													</td>
													<td align="center" id="lockedStock_{$T.Result.sid}">
													{#if $T.Result.lockedStock == null}
														<span>0</span>
													{#else}
													{$T.Result.lockedStock}
													{#/if}
													</td>
													
													<td align="center" id="brandName_{$T.Result.sid}">{$T.Result.brandName}</td>
													<td align="center" id="supplierName_{$T.Result.sid}">{$T.Result.supplierName}</td>
													<td align="center" style="display:none;" id="supplierCode_{$T.Result.sid}">{$T.Result.supplierCode}</td>
													<td align="center" style="display:none;" id="channelSid_{$T.Result.sid}">{$T.Result.channelSid}</td>
													<td align="center" id="channelName_{$T.Result.sid}">{$T.Result.channelName}</td>
													<td align="center" id="storeName_{$T.Result.sid}">{$T.Result.storeName}</td>
													<td align="center" style="display:none;" id="storeCode_{$T.Result.sid}">{$T.Result.storeCode}</td>
													<td style="display:none;" id="productDetailSid_{$T.Result.sid}">{$T.Result.productDetailSid}</td>
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
	</div>
</body>
</html>