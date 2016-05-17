<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
WFJBackWeb - 维护商品
Version: 1.0.0
Author: WangSy
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 验证 -->
<script
	src="${pageContext.request.contextPath}/assets/js/validation/bootstrapValidator.js"></script>
<title>商品基本信息</title>
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
<!-- 保存取消关闭按钮控制 -->
<script type="text/javascript">
	function successBtn() {
		$("#modal-success").hide();
		closeProDiv();
	}
	function proSaveSuccess() {
		$("#proSaveSuccess").hide();
		$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
	}
	function wcSuccess() {
		$("#wcSuccess").hide();
		var url = __ctxPath + "/product/getProductDetail/" + $("#skuSid").val();
		$("#pageBody").load(url);
	}
	function proWarningBtn() {
		$("#proWarning").hide();
	}
	// 关闭DIV
	function closeProDiv() {
		$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
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
	$(function() {
		$('#baseForm').bootstrapValidator({
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			}
		});
		$('#proForm').bootstrapValidator({
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			}
		});
		$("#savePro_1").click(function() {
			proForm_1();
		});
		$("#savePro_2").click(function() {
			proForm_2();
		});
	});
</script>
<script type="text/javascript">
	function proForm_1() {
		var skuSid = $("#skuSid").val();
		var skuCode = $("#skuCode_1").val();
		var primaryAttr = $("#primary_attr").val();
		var productSku = $("#product_sku").val();
		if (productSku != undefined) {
			if ($("#product_skuHidden").val() == productSku) {
				$("#wcSuccess2").html(
						"<div class='alert alert-success fade in'>"
								+ "<strong>修改成功</strong></div>");
				$("#wcSuccess").attr({
					"style" : "display:block;z-index:9999;",
					"aria-hidden" : "false",
					"class" : "modal modal-message modal-success"
				});
				return;
			}
		}
		console.log(primaryAttr);
		if (primaryAttr != undefined) {
			if ($("#primary_attrHidden").val() == primary_attr) {
				$("#wcSuccess2").html(
						"<div class='alert alert-success fade in'>"
								+ "<strong>修改成功</strong></div>");
				$("#wcSuccess").attr({
					"style" : "display:block;z-index:9999;",
					"aria-hidden" : "false",
					"class" : "modal modal-message modal-success"
				});
				return;
			}
		}
		if (skuCode != "") {
			$
					.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/product/skuUpdateAttrOrSku",
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
							skuCode : skuCode,
							productSku : productSku,
							primaryAttr : primaryAttr
						},
						success : function(response) {
							if (response.success == 'true') {
								$("#modal-body-success")
										.html(
												"<div class='alert alert-success fade in'>"
														+ "<strong>修改成功</strong></div>");
								$("#modal-success")
										.attr(
												{
													"style" : "display:block;z-index:9999;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-success"
												});
								var url = __ctxPath
										+ "/product/getProductDetail/" + skuSid;
								$("#pageBody").load(url);
							} else {
								$("#warning2Body").text(response.data.errorMsg);
								$("#warning2").attr("style", "z-index:9999");
								$("#warning2").show();
							}
							return;
						},
						/* error : function() {
							$("#warning2Body").text("系统出错");
							$("#warning2").attr("style", "z-index:9999");
							$("#warning2").show();
						} */
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
	}
</script>
<script type="text/javascript">
	function proForm_2() {
		var skuCode = $("#skuCode_2").val();
		var stanCode = $("#stanCode").val();
		var features = $("#features").val();
		var colorCode = $("#colorCode").val();
		var skuSid = $("#skuSid").val();
		if ($("#stanCodeHidden").val() == stanCode) {
			if (colorCode != "") {
				if ($("#colorCodeHidden").val() == colorCode) {
					$("#wcSuccess2").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>修改成功</strong></div>");
					$("#wcSuccess").attr({
						"style" : "display:block;z-index:9999;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					return;
				}
			} else {
				if ($("#featuresHidden").val() == features) {
					$("#wcSuccess2").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>修改成功</strong></div>");
					$("#wcSuccess").attr({
						"style" : "display:block;z-index:9999;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					return;
				}
			}
		}
		if (stanCode == "" || features == "" || colorCode == "") {
			$("#warning2Body").text("色码（特性）/规码（尺寸码）不能为空");
			$("#warning2").attr("style", "z-index:9999;");
			$("#warning2").show();
			return;
		}
		if (skuCode != "") {
			$
					.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/product/skuUpdateAttr",
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
							skuCode : skuCode,
							proStanSid : stanCode,
							features : features,
							proColorName : colorCode,
						},
						success : function(response) {
							if (response.success == 'true') {
								$("#modal-body-success")
										.html(
												"<div class='alert alert-success fade in'>"
														+ "<strong>修改成功</strong></div>");
								$("#modal-success")
										.attr(
												{
													"style" : "display:block;z-index:9999;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-success"
												});
								var url = __ctxPath
										+ "/product/getProductDetail/" + skuSid;
								$("#pageBody").load(url);
								return;
							} else {
								$("#warning2Body").text(response.data.errorMsg);
								$("#warning2").attr("style", "z-index:9999");
								$("#warning2").show();
							}
							return;
						},
						/* error : function() {
							$("#warning2Body").text("系统出错");
							$("#warning2").attr("style", "z-index:9999");
							$("#warning2").show();
						} */
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
								<span class="widget-caption">商品维护</span>
							</div>
							<div class="widget-body">
								<div class="tabbable">
									<ul class="nav nav-tabs" id="myTab">
										<li class="active" id="li_base"><a data-toggle="tab"
											href="#base"> <font style="color: black;">产品换款/主属性</font>
										</a></li>
										<li class="tab-red" id="li_pro"><a data-toggle="tab"
											href="#pro"> <font>商品换色码（特性）/规码（尺寸码）</font>
										</a></li>
									</ul>
									<!-- BaseMessage start -->
									<div class="tab-content">
										<div id="base" class="tab-pane in active">
											<form id="baseForm" method="post" class="form-horizontal">
												<div class="col-md-12">
													<h5>
														<strong>产品信息</strong>
													</h5>
													<hr class="wide" style="margin-top: 0;">
													<div class="col-md-6">
														<label class="col-md-4 control-label">集团品牌：</label>
														<div class="col-md-8 js-data-example-ajax">
															<input id="skuSid" type="hidden"
																value="${jsonsSku[0].sid }" /> <input id="skuCode_1"
																type="hidden" value="${jsonsSku[0].skuCode }" /> <label
																class="control-label">${jsonsSku[0].brandGroupName }</label>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">业态：</label>
														<div class="col-md-8">
															<c:if test="${jsonsSku[0].industryCondition==0 }">
																<label class="control-label">百货</label>
															</c:if>
															<c:if test="${jsonsSku[0].industryCondition==1 }">
																<label class="control-label">超市</label>
															</c:if>
														</div>
														&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">工业分类：</label>
														<div class="col-md-8">
															<label class="control-label">${jsonsSku[0].categoryName }</label>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">统计分类：</label>
														<div class="col-md-8">
															<label class="control-label">${jsonsSku[0].statCategoryName }</label>
														</div>
														&nbsp;
													</div>
													<c:if test="${jsonsSku[0].industryCondition==0 }">
														<div class="col-md-6">
															<div class="form-group">
																<label class="col-md-4 control-label">款号：</label>
																<div class="col-md-8">
																	<input id="product_sku" name="product_sku"
																		class="form-control" value="${jsonsSku[0].modelCode }"
																		onkeyup="value=value.replace(/[^0-9- ]/g,'');"
																		maxLength=20 data-bv-notempty="true"
																		data-bv-notempty-message="款号不能为空!" />
																	<input type="hidden" id="product_skuHidden"
																		value="${jsonsSku[0].modelCode }" />
																</div>
															</div>
														</div>
													</c:if>
													<c:if test="${jsonsSku[0].industryCondition==1 }">
														<div class="col-md-6">
															<div class="form-group">
																<label class="col-md-4 control-label">主属性：</label>
																<div class="col-md-8">
																	<input id="primary_attr" name="primary_attr"
																		class="form-control"
																		value="${jsonsSku[0].primaryAttr }" maxLength=20
																		data-bv-notempty="true"
																		data-bv-notempty-message="主属性不能为空!" />
																	<input type="hidden" id="primary_attrHidden"
																		value="${jsonsSku[0].primaryAttr }" />
																</div>
															</div>
														</div>
													</c:if>
													<div class="col-md-6">
														<label class="col-md-4 control-label">类型：</label>
														<div class="col-md-8">
															<c:if test="${jsonsSku[0].proType==1 }">
																<label class="control-label">普通商品</label>
															</c:if>
															<c:if test="${jsonsSku[0].proType==2}">
																<label class="control-label">赠品</label>
															</c:if>
															<c:if test="${jsonsSku[0].proType==3 }">
																<label class="control-label">礼品</label>
															</c:if>
															<c:if test="${jsonsSku[0].proType==4 }">
																<label class="control-label">虚拟商品</label>
															</c:if>
															<c:if test="${jsonsSku[0].proType==5 }">
																<label class="control-label">服务类商品</label>
															</c:if>
														</div>
														&nbsp;
													</div>

												</div>
												<div class="col-md-12">
													<h5>
														<strong>商品信息</strong>
													</h5>
													<hr class="wide" style="margin-top: 0;">
													<div class="col-md-6">
														<label class="col-md-4 control-label">标准品名：</label>
														<div class="col-md-8">
															<label class="control-label">${jsonsSku[0].skuName }</label>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">色系：</label>
														<div class="col-md-8">
															<label class="control-label">${jsonsSku[0].colorName }</label>
														</div>
													</div>
													<c:if test="${jsonsSku[0].industryCondition==0 }">
														<div class="col-md-6">
															<label class="col-md-4 control-label">色码：</label>
															<div class="col-md-8">
																<label class="control-label">${jsonsSku[0].colorCode }</label>
															</div>
														</div>
													</c:if>
													<c:if test="${jsonsSku[0].industryCondition==1 }">
														<div class="col-md-6">
															<label class="col-md-4 control-label">特性：</label>
															<div class="col-md-8">
																<label class="control-label">${jsonsSku[0].features }</label>
															</div>
														</div>
													</c:if>
													<div class="col-md-6">
														<label class="col-md-4 control-label">规格：</label>
														<div class="col-md-8">
															<label class="control-label">${jsonsSku[0].stanName }</label>
														</div>
														&nbsp;
													</div>
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input type="submit" class="btn btn-success"
															style="width: 25%;" id="savePro_1" value="保存" />&emsp;&emsp;
														<input onclick="closeProDiv();" class="btn btn-danger"
															style="width: 25%;" id="close" type="button" value="取消" />
													</div>
												</div>
											</form>
										</div>
										<!-- BaseMessage end -->
										<!-- ProMessage start -->
										<div id="pro" class="tab-pane">
<!-- 											<div class="well"> -->
												<div id="base" class="tab-pane in active">
													<form id="proForm" method="post" class="form-horizontal">
														<div class="col-md-12">
															<h5>
																<strong>产品信息</strong>
															</h5>
															<hr class="wide" style="margin-top: 0;">
															<div class="col-md-6">
																<label class="col-md-4 control-label">集团品牌：</label>
																<div class="col-md-8 js-data-example-ajax">
																	<input id="skuCode_2" type="hidden"
																		value="${jsonsSku[0].skuCode }" /> <label
																		class="control-label">${jsonsSku[0].brandGroupName }</label>
																</div>
															</div>
															<div class="col-md-6">
																<label class="col-md-4 control-label">业态：</label>
																<div class="col-md-8">
																	<c:if test="${jsonsSku[0].industryCondition==0 }">
																		<label class="control-label">百货</label>
																	</c:if>
																	<c:if test="${jsonsSku[0].industryCondition==1 }">
																		<label class="control-label">超市</label>
																	</c:if>
																</div>
																&nbsp;
															</div>
															<div class="col-md-6">
																<label class="col-md-4 control-label">工业分类：</label>
																<div class="col-md-8">
																	<label class="control-label">${jsonsSku[0].categoryName }</label>
																</div>
															</div>
															<div class="col-md-6">
																<label class="col-md-4 control-label">统计分类：</label>
																<div class="col-md-8">
																	<label class="control-label">${jsonsSku[0].statCategoryName }</label>
																</div>
																&nbsp;
															</div>
															<c:if test="${jsonsSku[0].industryCondition==0 }">
																<div class="col-md-6">
																	<label class="col-md-4 control-label">款号：</label>
																	<div class="col-md-8">
																		<label class="control-label">${jsonsSku[0].modelCode }</label>
																	</div>
																</div>
															</c:if>
															<c:if test="${jsonsSku[0].industryCondition==1 }">
																<div class="col-md-6">
																	<label class="col-md-4 control-label">主属性：</label>
																	<div class="col-md-8">
																		<label class="control-label">${jsonsSku[0].primaryAttr }</label>
																	</div>
																</div>
															</c:if>
															<div class="col-md-6">
																<label class="col-md-4 control-label">类型：</label>
																<div class="col-md-8">
																	<c:if test="${jsonsSku[0].proType==1 }">
																		<label class="control-label">普通商品</label>
																	</c:if>
																	<c:if test="${jsonsSku[0].proType==2}">
																		<label class="control-label">赠品</label>
																	</c:if>
																	<c:if test="${jsonsSku[0].proType==3 }">
																		<label class="control-label">礼品</label>
																	</c:if>
																	<c:if test="${jsonsSku[0].proType==4 }">
																		<label class="control-label">虚拟商品</label>
																	</c:if>
																	<c:if test="${jsonsSku[0].proType==5 }">
																		<label class="control-label">服务类商品</label>
																	</c:if>
																</div>
																&nbsp;
															</div>
														</div>
														<div class="col-md-12">
															<h5>
																<strong>商品信息</strong>
															</h5>
															<hr class="wide" style="margin-top: 0;">
															<div class="col-md-6">
																<label class="col-md-4 control-label">标准品名：</label> <label
																	class="control-label">${jsonsSku[0].skuName }</label>
															</div>
															<div class="col-md-6">
																<label class="col-md-4 control-label">色系：</label> <label
																	class="control-label">${jsonsSku[0].colorName }</label>
															</div>
															<div class="col-md-12">
																<hr class="wide" style="border-top: 0 solid #e5e5e5;">
															</div>
															<c:if test="${jsonsSku[0].industryCondition==0 }">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="col-md-4 control-label">色码：</label>
																		<div class="col-md-8">
																			<input id="colorCode" name="colorCode"
																				class="form-control"
																				value="${jsonsSku[0].colorCode }" maxLength=10
																				data-bv-notempty="true"
																				data-bv-notempty-message="色码不能为空!" />
																			<input type="hidden" id="colorCodeHidden"
																				value="${jsonsSku[0].colorCode }" />
																		</div>
																	</div>
																</div>
															</c:if>
															<c:if test="${jsonsSku[0].industryCondition==1 }">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="col-md-4 control-label">特性：</label>
																		<div class="col-md-8">
																			<input id="features" name="features"
																				value="${jsonsSku[0].features }"
																				class="form-control" maxLength=10
																				data-bv-notempty="true"
																				data-bv-notempty-message="特性不能为空!" />
																			<input type="hidden" id="featuresHidden"
																				value="${jsonsSku[0].features }" />
																		</div>
																	</div>
																</div>
															</c:if>
															<div class="col-md-6">
																<div class="form-group">
																	<label class="col-md-4 control-label">规码/尺码：</label>
																	<div class="col-md-8">
																		<input id="stanCode" name="stanCode"
																			value="${jsonsSku[0].stanName }" class="form-control"
																			maxLength=10 data-bv-notempty="true"
																			data-bv-notempty-message="规码/尺码不能为空!" />
																		<input type="hidden" id="stanCodeHidden"
																			value="${jsonsSku[0].stanName }" />
																	</div>
																</div>
																&nbsp;
															</div>
														</div>
														<div class="form-group">
															<div class="col-lg-offset-4 col-lg-6">
																<input type="submit" class="btn btn-success"
																	style="width: 25%;" id="savePro_2" value="保存" />&emsp;&emsp;
																<input onclick="closeProDiv();" class="btn btn-danger"
																	style="width: 25%;" id="close" type="button" value="取消" />
															</div>
														</div>
													</form>
												</div>
<!-- 											</div> -->
										</div>
										<!-- ProMessage end -->
										<!-- propfileMessage start -->
										<div id="propfile" class="tab-pane"></div>
										<!-- propfileMessage end -->
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
	<!-- 成功 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="proSaveSuccess">
		<div class="modal-dialog" style="margin: 150px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<i class="glyphicon glyphicon-check"></i>
				</div>
				<div class="modal-body" id="proSaveSuccess2">修改成功!</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="proSaveSuccess()">确定</button>
				</div>
			</div>
		</div>
	</div>
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="wcSuccess">
		<div class="modal-dialog" style="margin: 150px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<i class="glyphicon glyphicon-check"></i>
				</div>
				<div class="modal-body" id="wcSuccess2">修改成功!</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="wcSuccess()">确定</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /成功 -->
	<!-- 失败 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-warning fade" id="proWarning">
		<div class="modal-dialog" style="margin: 150px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<i class="fa fa-warning"></i>
				</div>
				<div class="modal-body" id="model-body-proWarning">修改失败</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-warning" type="button"
						onclick="proWarningBtn()">确定</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /失败 -->
</body>
</html>