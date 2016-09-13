<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<!--Jquery Select2-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<style type="text/css">
    .listInfo li {
        float: left;
        height: 35px;
        margin: 1px 1px 1px 0;
        overflow: hidden;
    }
</style>

<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var sessionId = "<%=request.getSession().getId() %>";

	var stockPagination;
	$(function() {
		//渠道
		$.ajax({
			type : "post",
			url : __ctxPath + "/stock/queryChannelListAddPermission",
			dataType : "json",
			async : false,
			success : function(response) {
				if(response.success == "true"){
					var result = response.list;
					var option = "";
					for (var i = 0; i < result.length; i++) {
						var ele = result[i];
						option += "<option value='"+ele.channelCode+"' sid='"+ele.sid+"'>"
								+ ele.channelName + "</option>";
					}
					$("#channelSid_select").append(option);
				}
				return;
			}
		});
		selectAllShop();
        initStock();

        $("#pageSelect").change(stockQuery);
        $("#supplier_select").change(stockQuery);
        $("#channelSid_select").change(stockQuery);
        $("#shop_select").change(stockQuery);
        $("#shoppe_select").change(stockQuery);

        $("#supplier_select").select2();
        $("#channelSid_select").select2();
        $("#shop_select").select2();
        $("#shoppe_select").select2();

		/* //供应商
		$.ajax({
			type : "post",
			url : __ctxPath + "/stock/querySupplyInfoList",
			dataType : "json",
			async : false,
			success : function(response) {
				var result = response.list;
				var option = "";
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.sid+"'>" + ele.supplyName
							+ "</option>";
				}
				$("#supplier_select").append(option);
				return;
			}
		}); */

		//		$(".select2-arrow b").attr("style", "line-height: 2;");
		

		//		$(".select2-arrow b").attr("style", "line-height: 2;");
		/* //门店
		$.ajax({
			type : "post",
			url : __ctxPath + "/stock/queryShopList",
			dataType : "json",
			async : false,
			success : function(response) {
				var result = response.list;
				var option = "";
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.organizationCode+"'>"
							+ ele.organizationName + "</option>";
				}
				$("#shop_select").append(option);
				return;
			}
		}); */

		//		$(".select2-arrow b").attr("style", "line-height: 2;");

	});
	function stockQuery() {
		$("#productSku_from").val($("#productSku_input").val());
		$("#productCode_from").val($("#productCode_input").val());
		$("#channelSid_from").val($("#channelSid_select").val());
		$("#shoppe_from").val($("#shoppe_select").val());
		$("#shop_from").val($("#shop_select option:selected").attr("code"));
		$("#supplier_from").val($("#supplier_select option:selected").attr("code"));
		var params = $("#stock_form").serialize();
		LA.sysCode = "16";
		LA.log("stock.stockQuery", "库存查询：" + params, getCookieValue("username"), sessionId);
		params = decodeURI(params);
		stockPagination.onLoad(params);
	}
	function find() {
		stockQuery();
	}
	function reset() {
		$('#supplier_select').prop("disabled", "disabled").select2();
		$('#shoppe_select').prop("disabled", "disabled").select2();
		$("#productSku_input").val("");
		$("#productCode_input").val("");
		$("#supplier_select").select2().select2("val","");
		$("#channelSid_select").val($('#channelSid_select option:eq(0)').val()).select2();
		$("#shop_select").val($('#shop_select option:eq(0)').val()).select2();
		$('#shoppe_select').val($('#shoppe_select option:eq(0)').val()).select2();
		stockQuery();
		init_1();
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
						param : "storeCode=" + $("#shop_select option:selected").attr("code")
								+ "&channelSid=" + $("#channelSid_select").val(),
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
							$("#stock_tab tbody").setTemplateElement(
									"stock-list").processTemplate(data);
							if(data != null && data.total != null){
								$("#total").text(data.total);
							}
						}
					}
				});
	}
	function editStock(num) {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text(buildErrorMessage("","只能选择一行！"));
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text(buildErrorMessage("","请选取要修改的行！"));
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		stockSid = value;
		channelName_ = $("#channelName_" + value).text().trim();
		channelSid_ = $("#channelSid_" + value).text().trim();
		productCode_ = $("#productCode_" + value).text().trim();

		saleStock_ = $("#saleStock_" + value).text().trim();
		edefectiveStock_ = $("#edefectiveStock_" + value).text().trim();
		returnStock_ = $("#returnStock_" + value).text().trim();
		lockedStock_ = $("#lockedStock_" + value).text().trim();

		productSku_ = $("#productSku_" + value).text().trim();
		proColorName_ = $("#proColorName_" + value).text().trim();
		proStanName_ = $("#proStanName_" + value).text().trim();
		proSum_ = $("#proSum_" + value).text().trim();
		stockName_ = $("#stockName_" + value).text().trim();
		brandName_ = $("#brandName_" + value).text().trim();
		supplyName_ = $("#supplyName_" + value).text().trim();
		shopName_ = $("#shopName_" + value).text().trim();
		productDetailSid_ = $("#productDetailSid_" + value).text().trim();
//		var url = __ctxPath + "/jsp/stock/editStock.jsp";
        var url = "";
        if(num == "1"){
            url = __ctxPath + "/jsp/stock/editStockInChannel.jsp";
        }
        if(num == "2"){
            url = __ctxPath + "/jsp/stock/editStockOutChannel.jsp";
        }
		$("#pageBody").load(url);
	}
	//导出excel
	function excelStock() {
		
		var skuCode = $("#productSku_input").val();
		var productCode = $("#productCode_input").val();
		var supplierCode = $("#supplier_select").val();
		var storeCode = $("#shop_select option:selected").attr("code");
        if(typeof(storeCode) == "undefined"){
            storeCode = "";
        }
		var channelSid = $("#channelSid_select").val();
		var shoppe = $("#shoppe_select").val();
		LA.sysCode = "16";
		LA.log("stock.excelStock", "库存导出Excel：" + {
            "skuCode" : skuCode,
            "productCode" : productCode,
            "supplierCode" : supplierCode,
            "storeCode" : storeCode,
            "channelSid" : channelSid,
            "shoppe" : shoppe
        }, getCookieValue("username"), sessionId);
		var title = "stockSearch";
        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=utf-8",
            url : __ctxPath + "/stockWei/getStockToExcelCount",
            dataType : "json",
            async : false,
            data : {
                "skuCode" : skuCode,
                "productCode" : productCode,
                "supplierCode" : supplierCode,
                "storeCode" : storeCode,
                "channelSid" : channelSid,
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
                window.open(__ctxPath + "/stockWei/getStockToExcel?skuCode="
                        + skuCode + "&productCode=" + productCode
                        + "&supplierCode=" + supplierCode + "&storeCode="
                        + storeCode + "&channelSid=" + channelSid + "&shoppe" + shoppe
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
											"<div class='alert alert-success fade in'><strong>删除成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
						} else {
							$("#warning2Body").text(buildErrorMessage("","删除失败！"));
							$("#warning2").show();
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

	//库存历史记录
	function getStockDiv(shoppeProSid, channelSid, channelName) {
		$("#stockHisDiv").show();
		//给显示渠道名称赋值
		$("#stockHisChannelName").text(channelName);
		//给专柜商品编码、库存类型sid和渠道sid隐藏域赋值
		$("#shoppeProSid_form").val(shoppeProSid);
		$("#channelSid_form").val(channelSid);
		$("#changeTypeSid_form").val($("#changeTypeSid_select").val());
		initStockHis(shoppeProSid, channelSid);
	}

	var stockHisPagination;
	function initStockHis(shoppeProSid, channelSid) {
		//取库存类型查询参数		
		var changeTypeSid = $("#changeTypeSid_select").val();
		var url = $("#ctxPath").val() + "/stock/queryStockChangeHis";
		/* var url = $("#ctxPath").val() + "/stock/queryStockChangeHis?shoppeProSid="+shoppeProSid+"&channelSid="+channelSid+"&changeTypeSid="+changeTypeSid; */
		stockHisPagination = $("#stockHisPagination").myPagination(
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
						param : "shoppeProSid=" + shoppeProSid + "&channelSid="
								+ channelSid + "&changeTypeSid="
								+ changeTypeSid,
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
							$("#stockHis_tab tbody").setTemplateElement(
									"stockHis-list").processTemplate(data);
						}
					}
				});
	}

	function stockHisQuery() {
		$("#changeTypeSid_form").val($("#changeTypeSid_select").val());
		var params = $("#stockHis_form").serialize();
		params = decodeURI(params);
		stockHisPagination.onLoad(params);
	}

	function closeStockHisDiv() {
		$("#stockHisDiv").hide();
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
			stockQuery();
		});
		$('#supplier_select').change(function(){
			selectShoppeByShopAndSupplier();
			stockQuery();
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
                	$("#warning2Body").text(buildErrorMessage("","系统出错！"));
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
			"backUrl" : "/jsp/stock/StockView.jsp"
		}, function(){
			$(".loading-container").addClass("loading-inactive");
		});
	}
	function getViewDetail(data) {
		var url = __ctxPath + "/product/getProductDetail/" + data;
		$(".loading-container").attr("class", "loading-container");
		$("#pageBody").load(url, {
			"backUrl" : "/jsp/stock/StockView.jsp"
		}, function(){
			$(".loading-container").addClass("loading-inactive");
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
			<div class="page-body">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">库存管理</h5>
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
										<!-- <a onclick="editStock('1');" class="btn btn-info">
                                            <i class="fa fa-wrench"></i>
                                            渠道内库存修改
										</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a onclick="editStock('2');" class="btn btn-info">
                                            <i class="fa fa-wrench"></i>
                                            跨渠道库存修改
                                        </a>&nbsp;&nbsp;&nbsp;&nbsp; -->
                                        <a onclick="excelStock();" class="btn btn-yellow">
                                            <i class="fa fa-edit"></i>
											导出Excel
										</a>
									</div>
									<div class="table-toolbar">
										<ul class="listInfo clearfix">
											<li>
                                                <span>商品SKU：</span>
                                                <input type="text" id="productSku_input" style="width: 200px;" />
                                            </li>
											<li>
                                                <span>专柜商品编码：</span>
                                                <input type="text" id="productCode_input" style="width: 200px;" />
                                            </li>
                                            <li>
                                                <span>渠道：</span>
                                                <select id="channelSid_select" style="width: 200px;">
                                                    <!-- <option value="">所有</option> -->
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
											<li>
                                                <a class="btn btn-default shiny" onclick="find();" style="margin-left: 10px;">查询</a>
												<a class="btn btn-default shiny" onclick="reset();" style="margin-left: 10px;">重置</a>
                                            </li>
										</ul>
									</div>
									<table
										class="table table-bordered table-striped table-condensed table-hover flip-content"
										id="stock_tab">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;" width="7.5%">选择</th>
												<th style="text-align: center;">商品SKU</th>
												<th style="text-align: center;">专柜商品编码</th>
												<th style="text-align: center;">专柜名称</th>
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
												<th style="text-align: center;">库存变动详情</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="pull-left" style="margin-top: 5px;">
										<form id="stock_form" action="">
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
											<input type="hidden" id="productSku_from" name="skuCode" /> 
											<input type="hidden" id="productCode_from" name="productCode" /> 
											<input type="hidden" id="supplier_from" name="supplierSid" /> 
											<input type="hidden" id="channelSid_from" name="channelSid" /> 
											<input type="hidden" id="shop_from" name="storeCode" />
											<input type="hidden" id="shoppe_from" name="shoppeCode" />
										</form>
									</div>
									<div style="float: right;float: right !important;padding: 10px;color: rgb(72, 185, 239);">
										<div class="col-lg-12">
											<p>共&nbsp;<span id="total">0</span>&nbsp;条</p>
										</div>
									</div>
									<div id="stockPagination"></div>
								</div>
								<!-- Templates -->
								<p style="display: none">
									<textarea id="stock-list" rows="0" cols="0">
									<!--  {#template MAIN}
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
												<td align="center" id="skuCode_{$T.Result.sid}"><a onclick="getViewDetail('{$T.Result.skuCode}');" style="cursor:pointer;">{$T.Result.skuCode}</a></td>
												<td align="center" id="productCode_{$T.Result.sid}"><a onclick="getView('{$T.Result.productCode}');" style="cursor:pointer;">{$T.Result.productCode}</a></td>
												<td align="center">{$T.Result.counterName}</td>
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
												<td align="center">
													<a onclick="getStockDiv('{$T.Result.productCode}','{$T.Result.channelSid}','{$T.Result.channelName}')" style="cursor:pointer;color:blue">
														库存变动详情
													</a>
												</td>
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

	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="stockHisDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeStockHisDiv();">×</button>
					<h2 class="modal-title" id="divTitle">库存历史变动记录</h2>
				</div>
				<div class="page-body">
					<div class="row">
						<div class="col-xs-12 col-md-12">
							<div class="widget">
								<div class="table-toolbar">
									<ul class="listInfo clearfix">
										<li><span>渠道：</span> <label id="stockHisChannelName"></label>
										</li>
										<li><span style="text-align: center;">库位类型：</span> <select
											id="changeTypeSid_select" onchange="stockHisQuery();"
											style="text-align: center; padding: 0 0; width: 200px" disabled="disabled">
												<option value="1001" selected="selected">可售库</option>
												<option value="1002">残次品库</option>
												<option value="1003">退货库</option>
												<option value="1004">锁定库</option>
										</select></li>
									</ul>
								</div>

								<table id="stockHis_tab"
									class="table table-bordered table-striped table-condensed table-hover flip-content">
									<thead class="flip-content bordered-darkorange">
										<tr role="row">
											<th style="text-align: center;">单据号</th>
											<th style="text-align: center;">原库存数量</th>
											<th style="text-align: center;">变动数量</th>
											<th style="text-align: center;">变动时间</th>
											<th style="text-align: center;">备注</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>

								<div class="pull-left" style="margin-top: 5px;">
									<form id="stockHis_form" action="">
										<div class="col-lg-12">
											<!-- <select onchange="stockHisQuery();" name="pageSize"
												style="padding: 0 12px;">
												<option>5</option>
												<option selected="selected">10</option>
												<option>15</option>
												<option>20</option>
											</select> -->
										</div>
										&nbsp; <input type="hidden" name="shoppeProSid"
											id="shoppeProSid_form" value="" /> <input type="hidden"
											name="channelSid" id="channelSid_form" value="" /> <input
											type="hidden" name="changeTypeSid" id="changeTypeSid_form"
											value="" />
									</form>
								</div>
								<div id="stockHisPagination"></div>
							</div>

							<!-- Templates -->
							<p style="display: none">
								<textarea id="stockHis-list" rows="0" cols="0">
									<!--  {#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="center" id="billsNo_{$T.Result.sid}">{$T.Result.billsNo}</td>
												<td align="center" id="proSum_{$T.Result.sid}">{$T.Result.proSum}</td>
												<td align="center" id="changeSum_{$T.Result.sid}">{$T.Result.changeSum}</td>
												<td align="center" id="changeTime_{$T.Result.sid}">{$T.Result.changeTime}</td>
												<td align="center" id="note_{$T.Result.sid}">{$T.Result.note}</td>
								       		</tr>
										{#/for}
									{#/template MAIN}	-->
								</textarea>
							</p>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default" type="button"
						onclick="closeStockHisDiv();">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

</body>
</html>