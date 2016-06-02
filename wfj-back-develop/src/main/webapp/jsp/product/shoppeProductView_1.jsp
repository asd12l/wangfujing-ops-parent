<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
WFJBackWeb - productView
Version: 1.0.0
Author: WangSy
-->
<html>
<head>

<!-- 专柜商品列表页展示及查询 -->
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	/* image="http://images.shopin.net/images";
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 	 */
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
	function productQuery() {
		$("#shoppeProName_from").val($("#shoppeProName_input").val());
		$("#saleStatus_from").val($("#saleStatus_select").val());
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
		$("#shoppeProName_input").val("");
		$("#saleStatus_select").val("");
		productQuery();
	}
	//初始化专柜商品列表
	function initProduct() {
		var url = $("#ctxPath").val() + "/product/selectShoppeProductBySku";
		productPagination = $("#productPagination")
				.myPagination(
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
								async : false,
								dataType : 'json',
								param : 'productDetailSid='
										+ $("#skuSid_hidden").val(),
								ajaxStart : function() {
									$(".loading-container").attr("class",
											"loading-container");
								},
								ajaxStop : function() {
									//隐藏加载提示
									$(".loading-container").addClass(
											"loading-inactive");
								},
								callback : function(data) {
									//使用模板
									$("#product_tab tbody").setTemplateElement(
											"product-list").processTemplate(
											data);
								}
							}
						});
	}
</script>

<script type="text/javascript">
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
		$("#warning2").show();
	}
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
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

	// Tree管理分类请求
	function proTreeDemo() {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/list",
			async : false,
			data : {
				"categoryType" : 1,
				"shopSid" : $("#proShopCode").find("option:selected").attr(
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
	//统计分类树
	function tjTreeDemo() {
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
				$.fn.zTree.init($("#tjTreeDemo"), setting, response);
			}
		});
	} 

	//格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动    
	function formatAsText(item) {
		var itemFmt = "<div style='display:inline'>" + item.name + "</div>"
		return itemFmt;
	}

	// 查询专柜
	function counterCodeClick() {
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/shoppe/findListShoppeForAddShoppeProduct",
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
						"shopSid" : $("#proShopCode").val(),
						"supplySid" : $("#supplierCode").val(),
                        "shoppeType" : "01",
						"page" : 1,
						"pageSize" : 1000000
					},
					success : function(response) {
						$("#counterCode option[index!='0']").remove();
						$("#counterCode").append(
								"<option value='-1'>全部</option>");
						if (response.success == 'true'&& response.list != null) {
							var result = response.list;
							for (var i = 0; i < result.length; i++) {
								var ele = result[i];
								$("#counterCode")
										.append(
												"<option counterCode='"+ ele.shoppeCode +"' industryConditionSid='"+ele.industryConditionSid+"' value='"+ele.sid+"'>"
														+ ele.shoppeName
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
	function supplierCodeClick() {
		//$("#supplierCode").removeAttr("disabled");
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath
							+ "/supplierDisplay/selectSupplyByShopSidAndSupplyName",
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
						"shopSid" : $("#proShopCode").find("option:selected")
								.attr("storecode"),
						"page" : 1,
						"pageSize" : 1000000
					},
					success : function(response) {
						$("#supplierCode option[index!='0']").remove();
						$("#supplierCode").append(
								"<option value='-1'>全部</option>");
						if (response.success != "false") {
							var result = response.data;
							for (var i = 0; i < result.length; i++) {
								var ele = result[i];
								$("#supplierCode")
										.append(
												"<option businessPattern='"+ele.businessPattern+"' supplyCode='"+ele.supplyCode+"' value='"+ele.sid+"'>"
														+ ele.supplyName
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
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/organization/queryListOrganization",
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
						"organizationType" : 3,
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
						$("#proShopCode").html(option);
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
	function findShopBrand() {
		$("#shopBrandCode").html("");
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath
							+ "/brandDisplay/getShopBrandByShopSidAndSkuSid",
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
						"shopSid" : $("#proShopCode").val(),
						"skuSid" : $("#skuSid").val()
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
	
	/*  查询数据字典   */
	function findDictCode() {
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
				"codes" : "xsdw,splx,jglx,tmlx,yt,wllx"
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
	var dictResponse;
	// 初始化
	$(function() {

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
		//管理分类
		$("#proTreeDown").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#proBtnGroup").attr("class", "btn-group open");
			} else {
				$(this).attr("treeDown", "true");
				$("#proBtnGroup").attr("class", "btn-group");
			}
		});
		$("#proA").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#proBtnGroup").attr("class", "btn-group open");
			} else {
				$(this).attr("treeDown", "true");
				$("#proBtnGroup").attr("class", "btn-group");
			}
		});
		//统计分类
		$("#tjTreeDown").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#tjBtnGroup").attr("class", "btn-group open");

				$("#treeDown").attr("treeDown", "true");
				$("#baseBtnGroup").attr("class", "btn-group");
			} else {
				$(this).attr("treeDown", "true");
				$("#tjBtnGroup").attr("class", "btn-group");
			}
		});
		$("#tjA").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#tjBtnGroup").attr("class", "btn-group open");

				$("#treeDown").attr("treeDown", "true");
				$("#baseBtnGroup").attr("class", "btn-group");
			} else {
				$(this).attr("treeDown", "true");
				$("#tjBtnGroup").attr("class", "btn-group");
			}
		});

		$("#loading-container").addClass("loading-inactive");
		$(".select2-arrow b").attr("style", "line-height: 2;");

		/* 供应商绑定事件 */
		$("#supplierCode")
				.change(
						function() {
							if ($(this).val() / 1 != -1) {
								/* 加工类型 */
								for (var i = 0; i < dictResponse.data.length; i++) {
									if (dictResponse.data[i].jglx != null) {
										var jglx = dictResponse.data[i].jglx;
										var option = "<option value='-1'>全部</option>";
										for (var j = 0; j < jglx.length; j++) {
											var ele = jglx[j];
											option += "<option value='"+ele.code+"'>"
													+ ele.name + "</option>";
										}
										$("#processingType").html(option);
									}
								}

								counterCodeClick();
								var businessPattern = $("#supplierCode").find(
										"option:selected").attr(
										"businessPattern")
								$("#manageType").html("");
								if (businessPattern == 0) {
									$("#manageType")
											.append(
													"<option value='"+businessPattern+"'>经销</option>");
								} else if (businessPattern == 1) {
									$("#manageType")
											.append(
													"<option value='"+businessPattern+"'>代销</option>");
								} else if (businessPattern == 2) {
									$("#manageType")
											.append(
													"<option value='"+businessPattern+"'>联营</option>");
								} else if (businessPattern == 3) {
									$("#manageType")
											.append(
													"<option value='"+businessPattern+"'>平台服务</option>");
								} else {
									$("#manageType")
											.append(
													"<option value='"+businessPattern+"'>租赁</option>");
								}
								$("#manageTypeForm").val(businessPattern);

								$("#counterCode").removeAttr("disabled");
								$("#erpProductCode").val("");
							} else {
								$("#counterCode").prop("disabled", "disabled");
							}
						});

		/* 专柜变更事件 */
		$("#counterCode").change(
				function() {

					$("[class='panel panel-default']").each(function(i) {
						if (i > 0) {
							$(this).show();
						}
					});

					if ($(this).val() != -1) {
						$("#YTtype").val(
								$(this).find("option:selected").attr(
										"industryConditionSid")).trigger(
								"change");
						$("#YTtype_").val(
								$(this).find("option:selected").attr(
										"industryConditionSid"));
					} else {
						$("#YTtype").val(-1);
						$("#YTtype_").val("");
					}
				});
		/* 业态变更事件 */
		$("#YTtype")
				.change(
						function() {
							var YTtype = $(this).val();
							manageTypeFunct();
							if (YTtype == 1) {
								$("#tmDiv_font").show();
								$("#divZsx").show();
								$("#divKh").hide();
								$("#divTx").show();
								$("#divSm").hide();
								$("#modelNumDiv").hide();
							} else {
								$("#tmDiv_font").hide();
								$("#divZsx").hide();
								$("#divKh").show();
								$("#divTx").hide();
								$("#divSm").show();
								$("#modelNumDiv").show();
							}
							if (YTtype == 2) {
								$("#divProcessingType").hide();
								$("#dqdDiv_font").hide();
								$("#yyDiv")
										.html(
												"合同信息<font id='yyDiv_font' style='color: red;'>(以下带*是必填项)</font>");

								/* $("#divOfferNumber_font")
										.html(
												"合同号：");
								$("#offerNumber_text").show() 
								                      .attr("name","offerNumber");
								$("#offerNumber").hide() 
								                 .removeAttr("name"); */
								$("#divJyType").hide();
								$("#discountLimitDiv").hide();
								$("#managerDiv_font").hide();
								$("#divSm").hide();
								$("#divGg").hide();
								$("#divTxys").show();
								$("#divTxcm").show();
								$("#eConDivShow").show();

								/* for (var i = 0; i < dictResponse.data.length; i++) {
									if (dictResponse.data[i].wllx != null) {
										var wllx = dictResponse.data[i].wllx;
										var option = "<option value='-1'>全部</option>";
										for (var j = 0; j < wllx.length; j++) {
											var ele = wllx[j];
											option += "<option value='"+(j+1)+"'>"
													+ ele.name + "</option>";
										}
										$("#tmsParam").html(option);
									}
								} */

							} else {
								$("#divProcessingType").show();
								$("#dqdDiv_font").show();
								$("#yyDiv")
										.html(
												"要约信息<font id='yyDiv_font' style='color: red;'>(以下带*是必填项)</font>");

								/* $("#divOfferNumber_font")
										.html(
												"<font style='color: red;'>*</font>要约号：");
								$("#offerNumber_text").hide()
								                      .removeAttr("name");
								$("#offerNumber").show()
								                 .attr("name","offerNumber"); */
								$("#divJyType").show();
								$("#discountLimitDiv").show();
								$("#managerDiv_font").show();
								$("#divSm").show();
								$("#divGg").show();
								$("#divTxys").hide();
								$("#divTxcm").hide();
								$("#eConDivShow").hide();
							}
							if (YTtype == 0 && $("#manageType").val() == 2) {
								$("#divRate").show();
								$("#divInputTax").hide();
								$("#divOutputTax").hide();
								$("#divConsumptionTax").hide();
								$("#erpCode_font_").show();
							} else {
								$("#divRate").hide();
								$("#divInputTax").show();
								$("#divOutputTax").show();
								$("#divConsumptionTax").show();
								$("#erpCode_font_").hide();
							}
							if((YTtype == 0 && $("#manageType").val() != 2)||YTtype == 1||YTtype == 2){
								$("#KLJJDiv").show();
								$("#KLJJDiv_1").show();
							} else {
								$("#KLJJDiv").hide();
								$("#KLJJDiv_1").hide();
							}
						});
		/* 门店品牌变更事件 */
		$("#shopBrandCode").change(function() {
			if ($(this).val() / 1 != -1) {
				supplierCodeClick();
				proTreeDemo();// Tree管理分类
				tjTreeDemo();//tree统计分类
				$("#supplierCode").removeAttr("disabled");
				$("#proA").removeAttr("disabled");
				$("#proTreeDown").removeAttr("disabled");
			} else {
				$("#proTreeDown").attr("treeDown", "true");
				$("#proBtnGroup").attr("class", "btn-group");
				$("#counterCode").attr("disabled", "disabled");
				$("#s2id_counterCode a span").each(function(i) {
					if (i == 0) {
						$(this).text("全部");
						return;
					}
				});
				$("#s2id_supplierCode a span").each(function(i) {
					if (i == 0) {
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
				$("#s2id_shopBrandCode a span").each(function(i) {
					if (i == 0) {
						$(this).text("全部");
						return;
					}
				});

				$("#proTreeDown").attr("treeDown", "true");
				$("#proBtnGroup").attr("class", "btn-group");
				$("#counterCode").attr("disabled", "disabled");
				$("#s2id_counterCode a span").each(function(i) {
					if (i == 0) {
						$(this).text("全部");
						return;
					}
				});
				$("#s2id_supplierCode a span").each(function(i) {
					if (i == 0) {
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
	/* ERP集合 */
	var erpList;
	//经营方式点击
	function manageTypeFunct() {
		/* $("#divOfferNumber").show(); */
		var manageType = $("#manageType").val();
		/* if(manageType==-1){
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
		/* if(manageType==2 && $("#YTtype").val()==0){// 百货联营
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
		} */
	}
	// 要约号改变事件
	function offerNumberChange() {
		$("#erpProductCode").html("");
		var option = "<option value=''>请选择</option>";
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
		if (manageType == 2 && $("#type").val() == 0) {// 百货联营
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
	/* function erpProductCodeChange(){
	    var commissionRate = $("#erpProductCode").find("option:selected").attr("commissionRate");
	    $("#rate").val(commissionRate);
	} */
</script>


<!-- 专柜商品保存 -->
<script type="text/javascript">
var inputTax_decimalLength = 0;
var KLNum_decimalLength = 0;
    /* 自动计算含税扣率 */
    function getHSKL(){
    	if(inputTax != "" && KLNum != ""){
    		var inputTax = $("#inputTax").val().trim();
        	var KLNum = $("#KLNum").val().trim();
        	var inputTaxStrs = inputTax.split(".");
        	var KLNumStrs = KLNum.split(".");
        	if(inputTaxStrs.length != 1){
        		inputTax_decimalLength = inputTaxStrs[1].length;
        	}
        	if(KLNumStrs.length != 1){
        		KLNum_decimalLength = KLNumStrs[1].length;
        	}
        	$("#HSKLNum").val(
    				(Number(inputTax)*Math.pow(10,inputTax_decimalLength)+Math.pow(10,inputTax_decimalLength))
    		      * (Number(KLNum)*Math.pow(10,KLNum_decimalLength)) 
    		      / Math.pow(10,inputTax_decimalLength+KLNum_decimalLength)
    		);
    	} else {
    		$("#HSKLNum").val("");
    	}
    }
    
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
					'barcode' : proTableTd_standardBarCode[i],
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
		var urlPath = "";
		if ($("#YTtype").val() == 2) {
			urlPath = "/product/saveShoppeProductDs";
		} else {
			urlPath = "/product/saveShoppeProduct";
		}

		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + urlPath,
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			data : $("#proForm").serialize(),
			success : function(response) {
				if (response.success == 'true') {
					$("#modal-body-success").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>添加成功</strong></div>");
					$("#modal-success").attr({
						"style" : "display:block;z-index:9999;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					initProduct();
					clearAll();
				} else {
					$("#warning2Body").text(response.data.errorMsg);
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
				return;
			},
			error : function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					$("#warning2Body").text("系统出错");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
	}
</script>
<!-- 验证表单Tab2专柜商品 -->
<script type="text/javascript">
	function requiredProForm() {//校验
		if ($("#proShopCode").val() == -1) {
			$("#warning2Body").text("请选择门店");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#shopBrandCode").val() == -1) {
			$("#warning2Body").text("请选择门店品牌");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#supplierCode").val() == -1) {
			$("#warning2Body").text("请选择供应商");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#counterCode").val() == -1) {
			$("#warning2Body").text("请选择专柜");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#offerNumber").val() == -1) {
			if ($("#YTtype").val() != 2) {
				$("#warning2Body").text("请选择要约号");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		if ($("#erpProductCode").val().trim() == "") {
			if ($("#YTtype").val() == 0 && $("#manageType").val() == 2) {
				$("#warning2Body").text("请选择扣率码");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		if ($("#inputTax").val().trim() == "") {
			if (!($("#YTtype").val() == 0 && $("#manageType").val() == 2)) {
				$("#warning2Body").text("请填写进项税");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		if ($("#consumptionTax").val().trim() == "") {
			if (!($("#YTtype").val() == 0 && $("#manageType").val() == 2)) {
				$("#warning2Body").text("请填写销项税");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		if ($("#manageCateGory").val().trim() == "") {
			if ($("#YTtype").val() != 2) {
				$("#warning2Body").text("请选择管理分类");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		if ($("#finalClassiFicationCode").val().trim() == "") {
			$("#warning2Body").text("请选择统计分类");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#productName").val().trim() == "") {
			$("#warning2Body").text("请填写专柜商品名称");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#productAbbr").val().trim() == "") {
			$("#warning2Body").text("请填写专柜商品简称");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#unitCode").val() == -1) {
			$("#warning2Body").text("请选择销售单位");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#discountLimit").val().trim() == "") {
			if (!($("#YTtype").val() == 2)) {
				$("#warning2Body").text("请填写折扣底限");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		if ($("#processingType").val() == -1) {
			if (!($("#YTtype").val() == 2)) {
				$("#warning2Body").text("请选择加工类型");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		if ($("#modelNum").val().trim() == "") {
			if ($("#YTtype").val() == 0) {
				$("#warning2Body").text("请填写货号");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		if ($("#marketPrice").val().trim() == ""
				|| $("#marketPrice").val().trim() == 0) {
			$("#warning2Body").text("请填写吊牌价");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#salePrice").val().trim() == ""
				|| $("#salePrice").val().trim() == 0) {
			$("#warning2Body").text("请填写销售价");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#inventory").val().trim() == ""
				|| $("#inventory").val().trim() == 0) {
			$("#warning2Body").text("请填写可售库存");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if ($("#KLNum").val().trim() == "") {
			if((YTtype == 0 && $("#manageType").val() != 2)||YTtype == 1||YTtype == 2){
				$("#warning2Body").text("请填写扣率/进价");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		if ($("#entryNumber").val().trim() == "") {
			if (!($("#YTtype").val() == 2)) {
				$("#warning2Body").text("请填写录入人员编号");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		if ($("#procurementPersonnelNumber").val().trim() == "") {
			if (!($("#YTtype").val() == 2)) {
				$("#warning2Body").text("请填写采购人员编号");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}

		if ($("#YTtype").val() == 0) {//百货

		} else if ($("#YTtype").val() == 1) {//超市
			if ($("#proTable").find("tbody").html().trim() == "") {
				$("#warning2Body").text("请新增条码");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		} else if ($("#YTtype").val() == 2) {//电商
			if ($("#supplyProductCode").val().trim() == "") {
				$("#warning2Body").text("请填写供应商商品编码");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
			if ($("#baseUnitCode").val().trim() == "") {
				$("#warning2Body").text("请填写基本计量单位");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
			if ($("#originCountry").val().trim() == "") {
				$("#warning2Body").text("请填写原产国");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
			if ($("#countryOfOrigin").val().trim() == "") {
				$("#warning2Body").text("请填写原产地");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
			if ($("#isGift").val().trim() == "") {
				$("#warning2Body").text("请填写赠品范围");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
			if ($("#supplyOriginLand").val().trim() == "") {
				$("#warning2Body").text("请填写货源地");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}
		return true;
	}
	//添加一个专柜商品后或取消添加专柜商品后清除已填的条码数据
	function clearAll() {
		$("#tmlist").val("");
		$("#KLNum").val("");
		$("#HSKLNum").val("");
	}
</script>

<!-- 多条码控制 -->
<script type="text/javascript">
<!--
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
				+ "<input type='text' name='proTableTd_placeOfOrigin' class='form-control'/>"
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
				+ "<input type='text' name='proTableTd_standardBarCode' onkeyup='clearNoNum2(event,this)' onblur='checkNum2(this)' onpaste='return false;' placeholder='只允许数字' class='form-control'/>"
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
//-->
</script>
<!-- 开关控制 -->
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
		if ($("#" + id).val() == "on") {
			$("#" + id).val("in");
			$("#" + id + "Input").val(0);
		} else {
			$("#" + id).val("on");
			$("#" + id + "Input").val(1);
		}
	}
</script>

<!-- 添加专柜商品 -->
<script type="text/javascript">
	function addZGpro() {

		$("[class='panel panel-default']").each(function(i) {
			if (i > 0) {
				$(this).hide();
			}
		});

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
		$("#skuSid").val("${sku.sid}");
		$("#manageType").prop("disabled", "disabled");
		$("#kh").text("${sku.modelCode}");
		//var skuName = $("#name_"+data).html().trim();
		$("#skuName").val("${sku.skuName}");
		$("#productName").val("${sku.spuName}");
		$("#gg").text("${sku.stanCode}");
		$("#divProcessingType").hide();
		$("a[class='accordion-toggle collapsed']").each(function() {
			$(this).attr("class", "accordion-toggle");
			$("#" + this.id + "_1").addClass("in");
			$("#" + this.id + "_1").attr("style", "");
		});

		$("#ys").text("${sku.colorName}");
		$("#tx").text("${sku.features}");
		$("#sm").text("${sku.colorCode}");

		$("#appProDiv").show(function() {
			$("#appProScrollTop").scrollTop(0);
		});
	}
</script>

<!-- 保存取消关闭按钮控制 -->
<script type="text/javascript">
	function successBtn() {
		$("#modal-success").hide();
		closeProDiv();
	}
	// 关闭DIV
	function closeProDiv() {
		$("#appProDiv").hide();
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
<!-- 保证只有两位小数的表单验证 -->
<script type="text/javascript">
	function clearNoNum(event, obj) {
		//响应鼠标事件，允许左右方向键移动
		event = window.event || event;
		if (event.keyCode == 37 | event.keyCode == 39) {
			return;
		}
		//先把非数字的都替换掉，除了数字和.-
		obj.value = obj.value.replace(/[^\d.]/g, "");
		//把不是在第一个的所有的-都删除
		var index = obj.value.indexOf("-");
		if (index != 0) {
			obj.value = obj.value.replace(/-/g, "");
		}
		//必须保证第一个为数或-字而不是.
		obj.value = obj.value.replace(/^\./g, "");
		//保证只有出现一个.而没有多个.
		obj.value = obj.value.replace(/\.-{2,}/g, ".");
		//保证.只出现一次，而不能出现两次以上
		obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace(
				"$#$", ".");
		obj.value = obj.value.replace("-", "$#$").replace(/\-/g, "").replace(
				"$#$", "-");
		var index = obj.value.indexOf(".");
		if (index != -1) {
			var flag = index + 3;
			if (obj.value.length > flag) {
				obj.value = obj.value.substring(0, flag);
			}
		}
	}
	function checkNum(obj) {
		//为了去除最后一个.
		obj.value = obj.value.replace(/\.$/g, "");
		obj.value = formatFloat(obj.value, 2);
		//alert(formatFloat(obj.value,2));
	}
	function formatFloat(src, pos) {
		return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);
	}
</script>
<!-- 只能输入>0的正整数   -->
<script type="text/javascript">
	function clearNoNum2(event, obj) {
		//响应鼠标事件，允许左右方向键移动
		event = window.event || event;
		if (event.keyCode == 37 | event.keyCode == 39) {
			return;
		}
		//先把非数字的都替换掉，除了数字和.-
		obj.value = obj.value.replace(/[^\d]/g, "");
		//把不是在第一个的所有的-都删除
		var index = obj.value.indexOf("-");
		if (index != 0) {
			obj.value = obj.value.replace(/-/g, "");
		}
		//必须保证第一个为数或-字而不是.
		obj.value = obj.value.replace(/^\./g, "");
		//保证只有出现一个.而没有多个.
		//obj.value = obj.value.replace(/\.-{2,}/g,".");
		//保证.只出现一次，而不能出现两次以上
		//obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		//obj.value = obj.value.replace("-","$#$").replace(/\-/g,"").replace("$#$","-");
		var index = obj.value.indexOf(".");
		if (index != -1) {
			var flag = index + 3;
			if (obj.value.length > flag) {
				obj.value = obj.value.substring(0, flag);
			}
		}
	}
	function checkNum2(obj) {
		//为了去除最后一个.
		obj.value = obj.value.replace(/\.$/g, "");
		obj.value = formatFloat2(obj.value, 2);
	}
	function formatFloat2(src, pos) {
		if (Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos) == 0) {
			return "";
		} else {
			return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);
		}
	}
</script>

</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />

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
			<div id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<!-- <div class="widget-header ">
                                    <span class="widget-caption"><h5>商品管理</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div> -->
							<div id="pro">
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
										<div class="col-md-14">
											<a id="editabledatatable_new" onclick="addZGpro();"
												class="btn btn-info" style="width: 100%;"> <i
												class="fa fa-plus"></i> 新增专柜商品
											</a>
										</div>
									</div>
									<div class="col-md-12">
										<div class="col-md-12">&nbsp;</div>
									</div>
									<div class="col-md-4">
										<label class="col-md-12 control-label">专柜商品名称： <input
											type="text" id="shoppeProName_input" style="width: 60%" />
										</label>
									</div>
									<div class="col-md-4">
										<label class="col-lg-12 control-label">是否可售： <select
											id="saleStatus_select" style="padding: 0 0; width: 60%">
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
											<a class="btn btn-default btn-sm" onclick="query();"
												style="margin-top: -2px; width: 30%">查询</a>&nbsp; <a
												class="btn btn-default btn-sm" onclick="reset();"
												style="margin-top: -2px; width: 30%">重置</a>
										</div>
										&nbsp;
									</div>
								</div>
								<table
									class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="product_tab">
									<thead class="flip-content bordered-darkorange">
										<tr>
											<th width="7.5%"></th>
											<th style="text-align: center;">门店</th>
											<th style="text-align: center;">专柜编码</th>
											<th style="text-align: center;">专柜商品编码</th>
											<th style="text-align: center;">专柜商品名称</th>
											<th style="text-align: center;">供应商</th>
											<th style="text-align: center;">门店品牌</th>
											<!-- <th style="text-align: center;">管理分类</th> -->
											<th style="text-align: center;">可售状态</th>
											<th style="text-align: center;">操作</th>
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
										&nbsp; <input type="hidden" id="skuSid_hidden"
											name="productDetailSid" value="${sku.sid}" /> <input
											type="hidden" id="skuCode_hidden" value="${sku.skuCode}" />
										<input type="hidden" id="shoppeProName_from"
											name="shoppeProName" /> <input type="hidden"
											id="saleStatus_from" name="saleStatus" />
										<!-- <input type="hidden" id="proActiveBit_from" name="proActiveBit"/>
											<input type="hidden" id="proSelling_from" name="proSelling"/>
											<input type="hidden" id="proType_from" name="proType"/> -->
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
													<td align="center"  id="status_1_{$T.Result.productCode}">
														{#if $T.Result.isSale == 'Y'}<span class="label label-success graded"> 可售</span>
														{#elseif $T.Result.isSale == 'N'}<span class="label label-darkorange graded"> 不可售</span>
														{#/if}
													</td>
													<td align="center" id="status_{$T.Result.productCode}">
														{#if $T.Result.isSale == 'N'}
														    <a href="#" onclick="editStatus({$T.Result.productCode},0)">
														        <span class="label label-success graded"
																	style="color: #000;">启用</span></a>
														{#/if} 
														{#if $T.Result.isSale == 'Y'}
															<a href="#" onclick="editStatus({$T.Result.productCode},1)">
															    <span class="label label-lightyellow graded"
																	style="color: #000;">停用</span></a>
														{#/if}
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
							</p>
						</div>
					</div>
					<div class="form-group">
					<div class="col-lg-offset-4 col-lg-6">
						&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <input class="btn btn-danger"
							style="width: 25%;" id="shoppeclose" type="button" value="取消" />
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
															id="YTtype"
															style="width: 70%; height: 32px; float: right;"
															disabled="disabled"></select> <input type="hidden"
															id="YTtype_" name="type" />
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
														<label class="control-label"><font
															id="erpCode_font_" style="color: red;">*</font>扣率码：</label> <select
															id="erpProductCode"
															name="erpProductCode"
															style="width: 70%; height: 32px; float: right;"></select>
													</div>
													<!-- <div class="col-md-4">
														<label class="control-label"><font
															style="color: red;">*</font>扣率码：</label> <input
															class="form-control" id="rate" name="rate"
															style="width: 70%; float: right;" readonly />
													</div> -->
													<div class="col-md-4" id="divJyType">
														<label class="control-label">经营方式：</label> <select
															id="manageType"
															style="width: 70%; height: 32px; float: right;"></select>
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
															onkeyup="clearNoNum(event,this);getHSKL();" onblur="checkNum(this)"
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
																	id="proA" treeDown="true" style="width: 85%;">请选择</a> <a
																	id="proTreeDown" href="javascript:void(0);"
																	class="btn btn-default" treeDown="true"><i
																	class="fa fa-angle-down"></i></a>
																<ul id="proTreeDemo"
																	class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 98%; position: absolute;overflow:auto;max-height: 200px;"></ul>
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
																	id="tjA" treeDown="true" style="width: 85%;">请选择</a> <a id="tjTreeDown"
																	href="javascript:void(0);" class="btn btn-default"
																	treeDown="true"><i class="fa fa-angle-down"></i></a>
																<ul id="tjTreeDemo"
																	class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 98%; position: absolute;overflow:auto;max-height: 200px;"></ul>
																<input type="hidden" id="finalClassiFicationCode"
																	name="finalClassiFicationCode" />
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
													<a onclick="aClick(this.id);" id="skuDiv"
														class="accordion-toggle" style="cursor: pointer;">
														专柜商品信息<font style="color: red;">(以下带*是必填项)</font>
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
													<div class="col-md-3" id="divGg">
														<label class="col-md-4">规格：</label>
														<div class="col-md-8">
															<span id="gg"></span>
														</div>
													</div>
													<div class="col-md-4" style="padding: 0" id="divShoppeProType">
														<label class="col-md-4 control-label"
															style="padding: 8px 0"><font style="color: red;">*</font>电商商品类型：</label>
														<div class="col-md-8">
															<select id="shoppeProType" name="shoppeProType"
																style="width: 100%; height: 32px; margin-bottom: 4px;">
																<option value="0">正常商品</option>
																<option value="1">低值易耗</option>
															</select>
														</div>
													</div>
													<br><br>
													<div class="col-md-4" style="padding: 0">
														<label class="col-md-4 control-label"
															style="padding: 8px 0"><font style="color: red;">*</font>专柜商品名称：</label>
														<div class="col-md-8">
															<input class="form-control" id="productName"
																name="productName"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=20 style="width: 100%" />
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" style="padding: 0;">
														<label class="col-md-4 control-label"
															style="padding: 8px 0;"><font style="color: red;">*</font>专柜商品简称：</label>
														<div class="col-md-8">
															<input class="form-control" id="productAbbr"
																name="productAbbr"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=20 style="width: 100%" />
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" style="padding: 0;">
														<label class="col-md-4 control-label"
															style="padding: 8px 0;"><font style="color: red;">*</font>销售单位：</label>
														<div class="col-md-8">
															<select id="unitCode" name="unitCode"
																style="width: 100%; height: 32px; margin-bottom: 4px;"></select>
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" id="discountLimitDiv"
														style="padding: 0">
														<label class="col-md-4 control-label"
															style="padding: 8px 0"><font style="color: red;">*</font>折扣底限：</label>
														<div class="col-md-8">
															<input class="form-control" id="discountLimit"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																maxLength=5 name="discountLimit"
																style="width: 100%" />
														</div>
														&nbsp;
													</div>
													<input type="hidden" id="isAdjustPriceInput"
														name="isAdjustPrice" value="1"> <input
														type="hidden" id="s" name="isPromotion" value="1">

													<div class="col-md-4" id="divProcessingType"
														style="padding: 0">
														<label class="col-md-4 control-label"
															style="padding: 8px 0"><font style="color: red;">*</font>加工类型：</label>
														<div class="col-md-8">
															<select id="processingType" name="processingType"
																style="width: 100%; height: 32px;">
															</select>
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" id="modelNumDiv" style="padding: 0;">
														<label class="col-md-4 control-label"
															style="padding: 8px 0;"><font
															style="color: red;">*</font>货号：</label>
														<div class="col-md-8">
															<input class="form-control" id="modelNum"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																maxLength=20 name="modelNum"
																style="width: 100%" />
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" id="divTxys" style="padding: 0;">
														<label class="col-md-4 control-label"
														style="padding: 8px 0;"><font
															style="color: red;">*</font>特性颜色：</label>
														<div class="col-md-8">
															<input class="form-control" id="zzColorCode"
																	maxLength=20
																	name="zzColorCode" style="width: 100%" />
														</div>
													</div>
													<div class="col-md-4" id="divTxcm" style="padding: 0;">
														<label class="col-md-4 control-label"
														style="padding: 8px 0;"><font
															style="color: red;">*</font>特性尺码：</label>
														<div class="col-md-8">
															<input class="form-control" id="zzSizeCode"
																	maxLength=20
																	name="zzSizeCode" style="width: 100%" />
														</div>
														&nbsp;
													</div>
													<div id="eConDivShow"
														style="overflow-y: auto; width: 100%; margin: 0;">
														<div class="col-md-4" style="padding: 0">
															<label style="width:109px;float:left;padding: 8px 0;"><font
															style="color: red;">*</font>供应商商品编码：</label>
															<div style="width:186px;float:left;margin-left:15px;">
																<input class="form-control" id="supplyProductCode"
																	onkeyup="clearNoNum(event,this)"
																	onblur="checkNum(this)"
																	maxLength=20 name="supplyProductCode"
																	style="width: 100%" />
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0"><font
															style="color: red;">*</font>物流类型：</label>
															<div class="col-md-8" style="height: 36px;">
																<select id="tmsParam" name="tmsParam"
																	style="width: 100%; height: 32px;">
																	<option value="1" code="Z001">液体</option>
															    	<option value="2" code="Z002">易碎</option>
															    	<option value="3" code="Z003">液体与易碎</option>
															    	<option value="4" code="Z004">粉末</option>
																</select>
															</div>
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0"><font
															style="color: red;">*</font>基本计量单位：</label>
															<div class="col-md-8">
																<input class="form-control" id="baseUnitCode"
																	name="baseUnitCode"
																	style="width: 100%" />
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0"><font
															style="color: red;">*</font>原产国：</label>
															<div class="col-md-8">
																<input class="form-control" id="originCountry"
																	maxLength=20
																	name="originCountry" style="width: 100%" />
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0"><font
															style="color: red;">*</font>原产地：</label>
															<div class="col-md-8">
																<input class="form-control" id="countryOfOrigin"
																	maxLength=20
																	name="countryOfOrigin" style="width: 100%" />
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0"><font
															style="color: red;">*</font>赠品范围：</label>
															<div class="col-md-8">
																<input class="form-control" id="isGift"
																	maxLength=20 name="isGift"
																	style="width: 100%" />
															</div>
															&nbsp;
														</div>
														<!-- 
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0"><font
															style="color: red;">*</font>上市日期：</label>
															<div class="col-md-8">
																<input class="form-control" id="launchDate"
																	maxLength=20 name="launchDate"
																	style="width: 100%" />
															</div>
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0"><font
															style="color: red;">*</font>季节：</label>
															<div class="col-md-8">
																<select name="season"
																	style="width: 100%; height: 32px;">
																	<option value="01">春季</option>
																	<option value="02">夏季</option>
																	<option value="03">秋季</option>
																	<option value="04">冬季</option>
																	<option value="0102">春夏</option>
																	<option value="0103">春秋</option>
																	<option value="0304">秋冬</option>
																	<option value="010203">春夏秋</option>
																	<option value="01020304" selected="selected">四季皆宜</option>
																</select>
															</div>
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0"><font
															style="color: red;">*</font>适用人群：</label>
															<div class="col-md-8">
																<select name="applicablePeople"
																	style="width: 100%; height: 32px;">
																	<option value="1" selected="selected">男</option>
																	<option value="2">女</option>
																	<option value="3">老人</option>
																	<option value="4">儿童</option>
																</select>
															</div>
															&nbsp;
														</div> -->
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0"><font
															style="color: red;">*</font>货源地：</label>
															<div class="col-md-8">
																<input class="form-control" id="supplyOriginLand"
																	maxLength=20 name="supplyOriginLand"
																	style="width: 100%" />
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0">总货架寿命：</label>
															<div class="col-md-8">
																<input class="form-control" id="shelfLife"
																	maxLength=20 name="shelfLife"
																	style="width: 100%" />
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0">剩余货架寿命：</label>
															<div class="col-md-8">
																<input class="form-control" id="remainShelLife"
																	maxLength=20 name="remainShelLife"
																	style="width: 100%" />
															</div>
															&nbsp;
														</div>
														
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0">虚库标志：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																	type="checkbox" value="on" id="stockMode"
																	onclick="isCheckButton('stockMode')"
																	class="checkbox-slider toggle yesno"> <span
																	class="text"></span>
																</label> <input type="hidden" id="stockModeInput"
																	name="stockMode" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0">可COD：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																	type="checkbox" value="on" id="isCod"
																	onclick="isCheckButton('isCod')"
																	class="checkbox-slider toggle yesno"> <span
																	class="text"></span>
																</label> <input type="hidden" id="isCodInput" name="isCod"
																	value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0">可贺卡：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																	type="checkbox" id="isCard" value="on"
																	onclick="isCheckButton('isCard')"
																	class="checkbox-slider toggle yesno"> <span
																	class="text"></span>
																</label> <input type="hidden" id="isCardInput" name="isCard"
																	value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0">可包装：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																	type="checkbox" id="isPacking" value="on"
																	onclick="isCheckButton('isPacking')"
																	class="checkbox-slider toggle yesno"> <span
																	class="text"></span>
																</label> <input type="hidden" id="isPackingInput"
																	name="isPacking" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0">
															<label class="col-md-4 control-label"
																style="padding: 8px 0;">是否有原厂包装：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																	type="checkbox" id="isOriginPackage" value="on"
																	onclick="isCheckButton('isOriginPackage')"
																	class="checkbox-slider toggle yesno"> <span
																	class="text"></span>
																</label> <input type="hidden" id="isOriginPackageInput"
																	name="isOriginPackage" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0;">
															<label class="col-md-4 control-label"
																style="padding: 8px 0">先销后采：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																	type="checkbox" id="xxhcFlag" value="on"
																	onclick="isCheckButton('xxhcFlag')"
																	class="checkbox-slider toggle yesno"> <span
																	class="text"></span>
																</label> <input type="hidden" id="xxhcFlagInput" name="xxhcFlag"
																	value="1">
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
														</div>&nbsp;
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label">销售价：</label>
														<div class="col-md-8">
															<input class="form-control" id="salePrice"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																onpaste="return false;" maxLength=20 name="salePrice"
																style="width: 100%" />
														</div>&nbsp;
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label">可售库存：</label>
														<div class="col-md-8">
															<input class="form-control" id="inventory"
																name="inventory" style="width: 100%"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																onkeyup="value=value.replace(/[^0-9- ]/g,'');"
																maxLength=20 />
														</div>&nbsp;
													</div>
													<div class="col-md-4" style="padding-left:0;" id="KLJJDiv">
														<label class="col-md-4 control-label" style="padding:5px 0 0 0;">扣率/进价：&nbsp;&nbsp;</label>
														<div class="col-md-8">
															&nbsp;&nbsp;<input class="form-control" id="KLNum"
																name="purchasePrice" style="width: 165px;"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																onkeyup="clearNoNum(event,this);getHSKL();"
																maxLength=20 />
														</div>
													</div>
													<div class="col-md-4" style="padding-left:0;" id="KLJJDiv_1">
														<label class="col-md-4 control-label" style="padding:5px 0 0 0;">扣率/含税进价：</label>
														<div class="col-md-8">
															&nbsp;&nbsp;<input class="form-control" id="HSKLNum" readonly="readonly"
															name="buyingPrice" style="width:165px;"/>
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
										<input type="hidden" id="skuSid" name="skuSid" value="${sku.sid}" />
										<input type="hidden" id="skuName" name="skuName" value="${sku.skuName}" />
										<input type="hidden" id="tmlist" name="barcodes" />
									</div>
									<!-- /yincangDiv -->
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input type="button" class="btn btn-success"
												style="width: 25%;" id="proSave" value="保存">&emsp;&emsp;
											<input onclick="closeProDiv();clearAll();"
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