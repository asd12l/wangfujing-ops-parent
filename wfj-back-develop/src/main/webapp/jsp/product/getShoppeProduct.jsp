<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
WFJBackWeb - 专柜商品详情
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script type="text/javascript">
	/*   function getNowDate(){
	  	var date = new Date();
	  	var dateStr = "";
	  	dateStr += date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" ";
	  	dateStr += date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
	  	return dateStr;
	  }
	 */
	//初始化
	$(function() {
		getCate();
		$.ajax({
			url : __ctxPath + "/proLabel/findProLabelByShoppeProSid.htm",
			dataType : 'json',
			data : {
				"shoppeProSid" : "${jsons[0].productCode}"
			},
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive");
				}, 300);
			},
			success : function(data) {
				$("#label_tab tbody").setTemplateElement("label-list")
						.processTemplate(data);
			}
		});

		//修改按钮事件
		/* $("input[id='save']").click(
				function() {
					productChangePropId = "${jsonsSku[0].sid }";
					category_Sid = "${jsonsSku[0].category }";
					category_Name = "${jsonsSku[0].categoryName }";
					statcate_Name = "${jsonsSku[0].statCategoryName }";
					spuSid = "${jsonsSku[0].spuSid }";
					productSid = "${jsonsSku[0].spuCode }";
					productSid2 = "${jsonsSku[0].spuSid }";
					$("#pageBody").load(
							__ctxPath + "/jsp/product/productChangeProp.jsp");
				}); */

		//关闭按钮事件
		$("input[id='close']").click(function() {
			$("#pageBody").load(__ctxPath + "${backUrl }");
		});
		$("#loading-container").addClass("loading-inactive");
	});
	 
	 function getCate(){
		 $.ajax({
			url : __ctxPath + "/product/selectCate.htm",
			dataType : 'json',
			data : {
				"storeCode" : "${jsons[0].storeCode}",
				"manageCategory" : "${jsons[0].manageCategoryCode}",
				"statCategory" : "${jsons[0].statCategory}"
			},
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive");
				}, 300);
			},
			success : function(data) {
				if(data.success == "true"){
					$("#manageCate").append(data.manageCategoryNames || "无");
					$("#statCate").append(data.statCategoryNames || "无");
				} 
			}
		});
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
								<span class="widget-caption">专柜商品详情</span>
							</div>
							<div class="widget-body">
								<div class="tabbable">
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a onclick="aClick(this.id);" id="collapseOnes"
													class="accordion-toggle" style="cursor: pointer;">
													供应商专柜信息<font style="color: red;"></font>
												</a>
											</h4>
										</div>
										<div class="panel-collapse collapse in" id="collapseOnes_1">
											<div class="panel-body border-red">
												<div class="col-md-4">
													<label class="control-label">门店：</label>
													${jsons[0].storeName}
												</div>
												<div class="col-md-4">
													<label class="control-label">门店品牌：</label>
													${jsons[0].brandName}
												</div>
												<div class="col-md-4">
													<label class="control-label">业态：</label>
													<c:if test="${jsons[0].industrySid == 0}">
															百货
														</c:if>
													<c:if test="${jsons[0].industrySid == 1}">
															超市
														</c:if>
													<c:if test="${jsons[0].industrySid == 2}">
															电商
														</c:if>
													<input type="hidden" id="YTtype_" name="type" />
												</div>
												<div class="col-md-12">
													<hr class="wide"
														style="margin-top: 0; border-top: 0px solid #e5e5e5;">
												</div>
												<div class="col-md-4">
													<label class="control-label">供应商：</label>
													${jsons[0].supplierName}
												</div>
												<div class="col-md-4">
													<label class="control-label">专柜：</label>
													${jsons[0].counterName}
												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a onclick="aClick(this.id);" id="yyDiv"
													class="accordion-toggle" style="cursor: pointer;"> 要约信息<font
													style="color: red;" id="yyDiv_font"></font>
												</a>
											</h4>
										</div>
										<div class="panel-collapse collapse in" id="yyDiv_1">
											<div class="panel-body border-red">
												<c:if test="${jsons[0].industrySid != 2}">
													<div class="col-md-4" id="divOfferNumber">
														<label class="control-label" id="divOfferNumber_font">要约号：</label>
														${jsons[0].contractCode}
													</div>
												</c:if>
												<div class="col-md-4">
													<label class="control-label">经营方式：</label>
													<c:if test="${jsons[0].operateMode == 0}">
															经销
														</c:if>
													<c:if test="${jsons[0].operateMode == 1}">
															代销
														</c:if>
													<c:if test="${jsons[0].operateMode == 2}">
															联营
														</c:if>
													<c:if test="${jsons[0].operateMode == 3}">
															平台服务
														</c:if>
													<c:if test="${jsons[0].operateMode == 4}">
															租赁
														</c:if>
												</div>
												<c:if test="${jsons[0].industrySid == 0}">
													<c:if test="${jsons[0].operateMode == 2}">
														<div class="col-md-4">
															<label class="control-label">扣率码：</label>
															${jsons[0].discountCode}
															<c:if test="${jsons[0].discountCode == null}">
																	无
																</c:if>
														</div>
													</c:if>
												</c:if>
												<c:if test="${jsons[0].industrySid == 2}">
													<div class="col-md-4">
														<label class="control-label">物料号：</label>
														<c:if test="${jsons[0].field4 == null}">
																无
															</c:if>
														<c:if test="${jsons[0].field4 != null && jsons[0].field4 != 'null'}">
															${jsons[0].field4}
                                                        </c:if>
													</div>
												</c:if>
												<div class="col-md-12">
													<hr class="wide"
														style="margin-top: 0; border-top: 0px solid #e5e5e5;">
												</div>
												<c:if test="${jsons[0].industrySid != 0}">
													<c:if test="${jsons[0].operateMode != 2}">
														<div class="col-md-4" id="divInputTax">
															<label class="control-label">进项税：</label>
															    ${jsons[0].inputTax}
															<c:if test="${jsons[0].inputTax == null}">
																	无
                                                            </c:if>
														</div>
														<div class="col-md-4" id="divOutputTax">
															<label class="control-label">销项税：</label>
															${jsons[0].outputTax}
															<c:if test="${jsons[0].outputTax == null}">
																	无
                                                            </c:if>
														</div>
														<div class="col-md-4" id="divConsumptionTax">
															<label class="control-label">消费税：</label>
															${jsons[0].salesTax}
															<c:if test="${jsons[0].salesTax == null}">
																	无
																</c:if>
														</div>
													</c:if>
												</c:if>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a onclick="aClick(this.id);" id="manageCateGoryDiv"
													class="accordion-toggle" style="cursor: pointer;">
													管理/统计分类信息<font style="color: red;"></font>
												</a>
											</h4>
										</div>
										<div class="panel-collapse collapse in"
											id="manageCateGoryDiv_1">
											<div class="panel-body border-red">
												<div class="col-md-12" id="manageCate">
													<label>管理分类：</label>
													<%-- ${manageCategoryNames}
													<c:if test="${jsons[0].glCategoryName == null}">
															无
														</c:if> --%>
												</div>&nbsp;
												<div class="col-md-12" id="statCate">
													<label>统计分类：</label>
													<%-- ${statCategoryNames}
													<c:if test="${jsons[0].statCategoryName == null}">
															无
														</c:if> --%>
												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a onclick="aClick(this.id);" id="skuDiv"
													class="accordion-toggle" style="cursor: pointer;">
													专柜商品信息<font style="color: red;"></font>
												</a>
											</h4>
										</div>
										<div class="panel-collapse collapse in" id="skuDiv_1">
											<div class="panel-body border-red">
												<c:if test="${jsons[0].primaryAttr == null}">
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">款号：</label> ${jsons[0].modelCode}
														<c:if test="${jsons[0].modelCode == null}">
															无
														</c:if>
													</div>
												</c:if>
												<c:if test="${jsons[0].primaryAttr != null && jsons[0].primaryAttr != 'null'}">
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">主属性：</label>
														${jsons[0].primaryAttr}
														<c:if test="${jsons[0].primaryAttr == null}">
															无
														</c:if>
													</div>
												</c:if>
												<div class="col-md-4">
													<label class="col-md-4 control-label" style="width: 130px;">色系：</label>
													${jsons[0].proColor}
													<c:if test="${jsons[0].proColor == null}">
															无
														</c:if>
												</div>
												<c:if test="${jsons[0].features == null}">
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">色码：</label> ${jsons[0].colorCode}
														<c:if test="${jsons[0].colorCode == null}">
															无
														</c:if>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">颜色：</label>
														${jsons[0].colorName}
														<c:if test="${jsons[0].colorName == null}">
															无
														</c:if>
													</div>
												</c:if>
												<c:if test="${jsons[0].features != null && jsons[0].features != 'null'}">
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">特性：</label> ${jsons[0].features}
														<c:if test="${jsons[0].features == null}">
															无
														</c:if>
													</div>
												</c:if>
												<div class="col-md-4">
													<label class="col-md-4 control-label" style="width: 130px;">规格：</label>
													${jsons[0].stanName}
													<c:if test="${jsons[0].stanName == null}">
															无
														</c:if>
												</div>
												<div class="col-md-4">
													<label class="col-md-4 control-label" style="width: 130px;">专柜商品名称：</label>
													${jsons[0].productName}
													<c:if test="${jsons[0].productName == null}">
															无
														</c:if>

												</div>
												<div class="col-md-4">
													<label class="col-md-4 control-label" style="width: 130px;">专柜商品简称：</label>
													${jsons[0].productAbbr}
													<c:if test="${jsons[0].productAbbr == null}">
															无
														</c:if>

												</div>
												<div class="col-md-4">
													<label class="col-md-4 control-label" style="width: 130px;">销售单位：</label>
													${jsons[0].unitName}
													<c:if test="${jsons[0].unitName == null}">
															无
														</c:if>

												</div>
												<c:if test="${jsons[0].industrySid != 2}">
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">折扣底限：</label>
														${jsons[0].maxDiscountRate}
														<c:if test="${jsons[0].maxDiscountRate == null}">
																无
															</c:if>

													</div>
													<input type="hidden" id="isAdjustPriceInput"
														name="isAdjustPrice" value="1">
													<input type="hidden" id="s" name="isPromotion" value="1">

													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">加工类型：</label>
														<c:if test="${jsons[0].processType == 1}">单品</c:if>
														<c:if test="${jsons[0].processType == 2}">分割原材料</c:if>
														<c:if test="${jsons[0].processType == 3}">原材料</c:if>
														<c:if test="${jsons[0].processType == 4}">成品</c:if>
														<c:if test="${jsons[0].processType == null}">
																无
															</c:if>

													</div>
												</c:if>
												<c:if test="${jsons[0].industrySid != 1}">
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">货号：</label> ${jsons[0].articleNum}
														<c:if test="${jsons[0].articleNum == null}">
															无
														</c:if>
													</div>
												</c:if>
												<c:if test="${jsons[0].industrySid == 2}">
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 150px;">供应商商品编码：</label> <label
															style="margin-left: -20px;">${jsons[0].supplyProCode}</label>

													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">物流类型：</label>
														<c:if test="${jsons[0].tmsParam == null}">无</c:if>
														<c:if test="${jsons[0].tmsParam == 1}">液体</c:if>
														<c:if test="${jsons[0].tmsParam == 2}">易碎</c:if>
														<c:if test="${jsons[0].tmsParam == 3}">液体与易碎</c:if>
														<c:if test="${jsons[0].tmsParam == 4}">粉末</c:if>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">基本计量单位：</label>
														${jsons[0].baseUnitCode}

													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">原产国：</label>
														${jsons[0].originCountry}

													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">原产地：</label>
														${jsons[0].originLand2}

													</div>
													<%-- <div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">赠品范围：</label>
														<c:if test="${jsons[0].isGift == 0}">正常商品</c:if>
														<c:if test="${jsons[0].isGift == 1}">可以单独销售也可以作为本专柜内的赠品</c:if>
														<c:if test="${jsons[0].isGift == 2}">可以单独销售也可以作为本门店内的赠品</c:if>
														<c:if test="${jsons[0].isGift == 3}">可以单独销售也可以作为全渠道的赠品</c:if>
														<c:if test="${jsons[0].isGift == 4}">不可单独销售但是可以作为本专柜内的赠品</c:if>
														<c:if test="${jsons[0].isGift == 5}">不可单独销售但可以作为本门店内的赠品</c:if>
														<c:if test="${jsons[0].isGift == 6}">不可单独销售但可以作为全渠道的赠品</c:if>
													</div> --%>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">虚库标志：</label>
														<c:if test="${jsons[0].stockMode == 2}">
																是
															</c:if>
														<c:if test="${jsons[0].stockMode != 2}">
																否
															</c:if>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">可COD：</label>
														<c:if test="${jsons[0].isCOD == 0}">
																支持
															</c:if>
														<c:if test="${jsons[0].isCOD == 1}">
																不支持
															</c:if>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">可贺卡：</label>
														<c:if test="${jsons[0].isCard == 0}">是</c:if>
														<c:if test="${jsons[0].isCard == 1}">否</c:if>

													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">可包装：</label>
														<c:if test="${jsons[0].isPacking == 0}">是</c:if>
														<c:if test="${jsons[0].isPacking == 1}">否</c:if>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 150px;">是否有原厂包装：</label>
														<c:if test="${jsons[0].isOriginPackage == 0}">
															<label style="margin-left: -20px;">是</label>
														</c:if>
														<c:if test="${jsons[0].isOriginPackage == 1}">
															<label style="margin-left: -20px;">否</label>
														</c:if>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label"
															style="width: 130px;">先销后采(Y/N)：</label>
														<c:if test="${jsons[0].xxhcFlag == 0}">Y</c:if>
														<c:if test="${jsons[0].xxhcFlag == 1}">N</c:if>
													</div>
												</c:if>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a onclick="aClick(this.id);" id="priceStockDiv"
													class="accordion-toggle" style="cursor: pointer;">
													价格库存信息 <font style="color: red;"></font>
												</a>
											</h4>
										</div>
										<div class="panel-collapse collapse in" id="priceStockDiv_1">
											<div class="panel-body border-red">
												<div class="col-md-4">
													<label class="col-md-4 control-label">吊牌价：</label>
													￥${jsons[0].marketPrice}
													<c:if test="${jsons[0].marketPrice == null}">
															无
														</c:if>

												</div>
												<div class="col-md-4">
													<label class="col-md-4 control-label">销售价：</label>
													￥${jsons[0].promotionPrice}
													<c:if test="${jsons[0].promotionPrice == null}">
															无
														</c:if>

												</div>
												<div class="col-md-4">
													<label class="col-md-4 control-label">可售库存：</label>
													${jsons[0].saleStock}
													<c:if test="${jsons[0].saleStock == null}">
															0
														</c:if>

												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a onclick="aClick(this.id);" id="priceStockDiv"
													class="accordion-toggle" style="cursor: pointer;"> 条码信息
													<font style="color: red;"></font>
												</a>
											</h4>
										</div>
										<div class="panel-collapse collapse in" id="priceStockDiv_1">
											<div class="panel-body border-red">
												<table id="proTable"
													class="table table-bordered table-striped table-condensed table-hover flip-content">
													<thead class="flip-content bordered-darkorange">
														<tr>
															<th width="33%" style="text-align: center;">产地</th>
															<th width="33%" style="text-align: center;">条码类型</th>
															<th width="34%" style="text-align: center;">条码编号</th>
														</tr>
														<c:forEach items="${jsons[0].barcodeList}" var="barcode">
															<tr>
																<td><c:if
																		test="${barcode.originLand == 'null' || barcode.originLand == null}">
																	无
																</c:if> <c:if
																		test="${barcode.originLand != 'null' && barcode.originLand != null}">
																	${barcode.originLand}
																</c:if></td>
																<td><c:if test="${barcode.codeType == 1}">
																	供应商条码
																</c:if> <c:if test="${barcode.codeType == 0}">
																	自编条码
																</c:if></td>
																<td>${barcode.barcode}</td>
															</tr>
														</c:forEach>
													</thead>
													<tbody>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a onclick="aClick(this.id);" id="dqdDiv"
													class="accordion-toggle" style="cursor: pointer;"> 其他信息
												</a>
											</h4>
										</div>
										<div class="panel-collapse collapse in" id="dqdDiv_1">
											<div class="panel-body border-red">
												<div class="col-md-6">
													<label class="col-md-4 control-label">录入人员编号：</label>
													${jsons[0].inputUserCode}
													<c:if test="${jsons[0].inputUserCode == null}">
															无
														</c:if>

												</div>
												<div class="col-md-6">
													<label class="col-md-4 control-label">采购人员编号：</label>
													${jsons[0].procurementUserCode}
													<c:if test="${jsons[0].procurementUserCode == null}">
															无
														</c:if>

												</div>
											</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a onclick="aClick(this.id);" id="collapseOnes"
													class="accordion-toggle" style="cursor: pointer;">
													活动标签信息<font style="color: red;"></font>
												</a>
											</h4>
										</div>
										<div class="panel-collapse collapse in" id="collapseOnes_1">
											<div class="panel-body border-red">
												<table
													class="table table-bordered table-striped table-condensed table-hover flip-content"
													id="label_tab">
													<thead class="flip-content bordered-darkorange">
														<tr role="row">
															<th style="text-align: center;">活动标签名称</th>
															<th style="text-align: center;">开始时间</th>
															<th style="text-align: center;">结束时间</th>
														</tr>
													</thead>
													<tbody>
													</tbody>
												</table>

												<!-- Templates -->
												<p style="display: none">
													<textarea id="label-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													
													<td align="center" id="labelName_{$T.Result.sid}" >
														{$T.Result.tagName}
													</td>
													<td align="center" id="beginDate_{$T.Result.sid}">
														{$T.Result.beginDate}
													</td>
													<td align="center" id="endDate_{$T.Result.sid}">
														{$T.Result.endDate}
													</td>
													<td style="display:none;" id="statusHidden_{$T.Result.sid}">{$T.Result.status}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
												</p>
											</div>
										</div>
									</div>
									<div>
										<input class="btn btn-danger"
											style="width: 20%; margin-left: 40%" id="close" type="button"
											value="关闭" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>