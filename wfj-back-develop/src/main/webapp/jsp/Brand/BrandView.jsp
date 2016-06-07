<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var brandPagination;
	
	$(function() {
		
		//取回显的值
		if(typeof(t) != "undefined"){
			$("#brandType_input").val(t);
			$("#brandType_form").val(t);
		}
		
		initBrand();
		$("#pageSelect").change(brandQuery);
		$("#brandType_input").change(brandQuery);
		$("#shopType_input").change(brandQuery);
	});
	
	function brandQuery() {
		$("#brandName_form").val($("#brandName_input").val());
		$("#brandSid_form").val($("#brandSid_input").val());
		var brandType = $("#brandType_input").val();
		$("#brandType_form").val(brandType);
		if(brandType == '1') {
			$("#shopType_span").show();
			$("#shopType_form").val($("#shopType_input").val());
		}
		if(brandType == '0'){
			$("#shopType_span").hide();
		}
		var params = $("#brand_form").serialize();
		params = decodeURI(params);
		brandPagination.onLoad(params);
		if(brandType == 1){
			$("#two").show();
			$("#two2").show();
		}else{
			$("#two").hide();
			$("#two2").hide();
		}
	}
	
	function find() {
		brandQuery();
	}
	
	function reset() {
		$("#brandName_input").val("");
		$("#brandSid_input").val("");
		$("#brandType_input").val("0");
		var brandType = $("#brandType_input").val();
		if(brandType == '1') {
			$("#shopType_span").show();
			$("#shopType_input").val("");
		}
		if(brandType == '0'){
			$("#shopType_span").hide();
			$("#shopType_input").val("");
		}
		brandQuery();
	}
	//初始化商品列表
	function initBrand() {
		var url = $("#ctxPath").val() + "/brandDisplay/queryBrand";
		brandPagination = $("#brandPagination").myPagination({
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
				param : "brandType="+$("#brandType_input").val(),
				async: false,
				ajaxStart : function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive");
					}, 300);
				},
				callback : function(data) {
					/* 使用模板 */
					$("#brand_tab tbody").setTemplateElement("brand-list").processTemplate(data);
				}
			}
		});
		if($("#brandType_input").val() == 1){
			$("#two").show();
			$("#two2").show();
		}else{
			$("#two").hide();
			$("#two2").hide();
		}
	}
	/* 添加品牌 */
	function addBrand() {
		var url = __ctxPath + "/jsp/Brand/addBrandView.jsp";
		$("#pageBody").load(url);
	}
	/* 添加门店品牌 */
	function addShopBrand() {
		var url = __ctxPath + "/jsp/Brand/addShopBrandView.jsp";
		$("#pageBody").load(url);
	}

	function modifyBrand() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text(buildErrorMessage("","只能选择一个品牌！"));
	        $("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text(buildErrorMessage("","请选择要修改的品牌！"));
	        $("#warning2").show();
			return;
		}
		/* if($("#brandType_input").val() == 1){
			$("#warning2Body").text("不许修改门店品牌!");
			$("#warning2").show();
			return;
		} */
		value = checkboxArray[0];
		brandSid_ = $("#brandSid_" + value).text().trim();
		parentSid_ = $("#parentSid_" + value).text().trim();
		parentName_ = $("#brandFatherName_" + value).text().trim();
		brandName_ = $("#brandName_" + value).text().trim();
		status_ = $("#status" + value).text().trim();
		brandSid_ = $("#brandSid_" + value).text().trim();
		brandUrl = $("#brand_url").val().trim();
		
		spell_ = $("#spell_" + value).text().trim();
		brandNameSecond_ = $("#brandNameSecond_" + value).text().trim();
		brandNameEn_ = $("#brandNameEn_" + value).text().trim();
		shopSid_ = $("#shopSid_" + value).text().trim();
		brandcorp_ = $("#brandcorp_" + value).text().trim();
		brandSpecialty_ = $("#brandSpecialty_" + value).text().trim();
		brandSuitability_ = $("#brandSuitability_" + value).text().trim();
		brandpic1_ = $("#brandpic1_" + value).val().trim();
		brandpic2_ = $("#brandpic2_" + value).val().trim();
		isDisplay_ = $("#isDisplay_" + value).attr("isDisplay").trim();
		status_ = $("#status_" + value).text().trim();
		brandDesc_ = $("#brandDesc_" + value).text().trim();
		
		brandType_ = $("#brandType_" + value).attr("brandType").trim();
		if (brandType_ == 1){
			shopType_ = $("#shopType_" + value).attr("shopType").trim();
			var url = __ctxPath + "/jsp/Brand/updateShopBrandView.jsp";
			$("#pageBody").load(url);
		} 
		if(brandType_ == 0){
			var url = __ctxPath + "/jsp/Brand/updateBrandView.jsp";
			$("#pageBody").load(url);
		}
	}
	
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({"display" : "none"});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({"display" : "block"});
			}
		}
	}

	function deleteBrand() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text(buildErrorMessage("","只能选择一列！"));
	        $("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text(buildErrorMessage("","请选择要删除的品牌！"));
	        $("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/brandDisplay/deleteBrand",
			dataType : "json",
			data : {
				"sid" : value
			},
			ajaxStart : function() {
				$("#loading-container").attr("class","loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive");
				}, 300);
			},
			success : function(response) {
				if (response.success == "true") {
					$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>删除成功，返回列表页!</strong></div>");
					$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
				} else {
					$("#warning2Body").text(buildErrorMessage("","删除失败！"));
			        $("#warning2").show();
				}
				return;
			}
		});
	}
	
	function successBtn() {
		$("#modal-success").attr({"style" : "display:none;","aria-hidden" : "true","class" : "modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/Brand/BrandView.jsp");
	}
</script>
</head>
<body>
	<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
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
								<h5 class="widget-caption">品牌管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body clearfix" id="pro">
								<div class="table-toolbar">
									<div class="clearfix">
										<a onclick="addBrand();" class="btn btn-primary"> <i class="fa fa-plus"></i> 添加集团品牌 </a>&nbsp;&nbsp;&nbsp;&nbsp;
										<a onclick="addShopBrand();" class="btn btn-primary"> <i class="fa fa-plus"></i> 添加门店品牌 </a>&nbsp;&nbsp;&nbsp;&nbsp;
										<a onclick="modifyBrand();" class="btn btn-info"> <i class="fa fa-wrench"></i> 修改品牌信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
									<div class="mtb10">
										<span>品牌类型：</span>
										<select id="brandType_input" style="width:150px;margin: 0 10px 0 0;">
											<option value="0" selected="selected">集团</option>
											<option value="1">门店</option>
										</select>
										<span id="shopType_span" style="display: none;margin: 0 10px 0 0;">
											<span>门店类型：</span>
											<select id="shopType_input" style="width:150px;padding: 0;">
												<option value="" selected="selected">请选择</option>
												<option value="0">北京</option>
												<option value="1">外阜</option>
												<option value="2">电商</option>
											</select>
										</span>
										<span>品牌名称：</span> 
										<input type="text" id="brandName_input" style="width:150px;margin: 0 10px 0 0;"/>
                                        <span>品牌编码：</span>
                                        <input type="text" id="brandSid_input" style="width:150px;margin: 0 10px 0 0;"/>
										<a class="btn btn-default shiny" onclick="find();" style="margin: 0 10px 0 0;">查询</a>
										<a class="btn btn-default shiny" onclick="reset();">重置</a>
									</div>									
								</div>
										<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="brand_tab">
                                        <thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;" width="7.5%">选择</th>
												<th style="text-align: center;">品牌编码</th>
												<th style="text-align: center;">品牌名称</th>
												<th style="text-align: center;">品牌类型</th>
												<th id="two" style="text-align: center; display: none;">门店类型</th>
												<th id="two2" style="text-align: center; display: none;">所属集团品牌</th>
												<th style="text-align: center;">拼音</th>
												<th style="text-align: center;">中文名称</th>
												<th style="text-align: center;">英文名称</th>
												<th style="text-align: center;">是否展示</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="brand_form" action="">
										<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp; 
										<input type="hidden" id="brandName_form" name="brandName" />
										<input type="hidden" id="brandSid_form" name="brandSid" />
										<input type="hidden" id="brandType_form" name="brandType" />
										<input type="hidden" id="shopType_form" name="shopType" />
									</form>
								</div>
								<div id="brandPagination"></div>
							</div>

							<!-- Templates -->
							<p style="display: none">
								<textarea id="brand-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX">
													<td align="left" class="brandTypeTd">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="brandSid_{$T.Result.sid}">{$T.Result.brandSid}</td>
													<td align="center" id="brandName_{$T.Result.sid}">{$T.Result.brandName}</td>
													<td align="center" id="brandType_{$T.Result.sid}" brandType="{$T.Result.brandType}">
														{#if $T.Result.brandType == 0}
															<span>集团品牌</span>
														{#elseif $T.Result.brandType == 1}
															<span>门店品牌</span>
														{#/if}
														<input type="hidden" id="brand_url" value="{$T.Result.url}"  />
														<input type="hidden" id="brandpic1_{$T.Result.sid}" value="{$T.Result.brandpic1}"  />
														<input type="hidden" id="brandpic2_{$T.Result.sid}" value="{$T.Result.brandpic2}"  />
													</td>
													
													{#if $T.Result.brandType == 1}
														<td align="center" id="shopType_{$T.Result.sid}" shopType="{$T.Result.shopType}">
															{#if $T.Result.shopType == 0}
																<span>北京</span>
															{#elseif $T.Result.shopType == 1}
																<span>外埠</span>
															{#elseif $T.Result.shopType == 2}
																<span>电商</span>
															{#/if}
														</td>
														<td align="center" id="brandFatherName_{$T.Result.sid}">{$T.Result.brandFatherName}</td>
													{#/if}
													<td align="center" style="display:none;" id="shopSid_{$T.Result.sid}">{$T.Result.shopSid}</td>
													<td align="center" style="display:none;" id="status_{$T.Result.sid}">{$T.Result.status}</td>
													<td align="center" style="display:none;" id="parentSid_{$T.Result.sid}">{$T.Result.parentSid}</td>
													<td align="center" style="display:none;" id="brandFatherName_{$T.Result.sid}">{$T.Result.brandFatherName}</td>
													<td align="center" style="display:none;" id="shopType_{$T.Result.sid}">{$T.Result.shopType}</td>
													<td align="center" style="display:none;" id="shopSid_{$T.Result.sid}">{$T.Result.shopSid}</td>
													<td align="center" id="spell_{$T.Result.sid}">
													    {#if $T.Result.spell != '[object Object]'}
                                                                {$T.Result.spell}
                                                        {#/if}
													</td>
													<td align="center" id="brandNameSecond_{$T.Result.sid}">
													    {#if $T.Result.brandNameSecond != '[object Object]'}
                                                                {$T.Result.brandNameSecond}
                                                        {#/if}
													</td>
													<td align="center" id="brandNameEn_{$T.Result.sid}">
													    {#if $T.Result.brandNameEn != '[object Object]'}
                                                                {$T.Result.brandNameEn}
                                                        {#/if}
													</td>
													<td align="center" style="display:none;" id="status_{$T.Result.sid}">
														{#if $T.Result.status == 0}
															<span>有效</span>
														{#elseif $T.Result.status == 1}
															<span>无效</span>
														{#/if}
													</td>
													<td align="center" id="isDisplay_{$T.Result.sid}" isDisplay="{$T.Result.isDisplay}">
														{#if $T.Result.isDisplay == 0}
															<span class="label label-success graded">是</span>
														{#elseif $T.Result.isDisplay == 1}
															<span class="label label-lightyellow graded">否</span>
														{#/if}
													</td>
													<td align="center" style="display:none;" id="brandcorp_{$T.Result.sid}">{$T.Result.brandcorp}</td>
													<td align="center" style="display:none;" id="brandDesc_{$T.Result.sid}">{$T.Result.brandDesc}</td>
													<td align="center" style="display:none;" id="brandSpecialty_{$T.Result.sid}">{$T.Result.brandSpecialty}</td>
													<td align="center" style="display:none;" id="brandSuitability_{$T.Result.sid}">{$T.Result.brandSuitability}</td>
													<td align="center" style="display:none;" id="optRealName_{$T.Result.sid}">{$T.Result.optRealName}</td>
													<td align="center" style="display:none;" id="optUpdateTimeStr_{$T.Result.sid}">{$T.Result.optUpdateTimeStr}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
							</p>
						</div>
						<!-- 创建时间和查询次数 备用-->
						<!-- 
							<td align="center" id="brandCreateTime_{$T.Result.sid}">{$T.Result.brandCreateTime}</td>
							<td align="center" id="aveSome_{$T.Result.sid}">{$T.Result.aveSome}</td>
						 -->
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