<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
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
					url : __ctxPath + "/brandDisplay/queryBrand",
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
						var result = response.list;
						var option = "";
						for ( var i = 0; i < result.length; i++) {
							var ele = result[i];
							option += "<option sid='"+ele.brandSid+"' value='"+ele.brandSid+"' style='width: 120px'>"
									+ ele.brandName + "</option>";
						}
						$("#brandGroupCode_select").append(option);
						return;
					}
				});
		return;
	} */

	//findBrand();//查询集团品牌
	fingColorDict();

	var proDetailPagination;
	$(function() {
		
		if(_isMore == 1){
			$("#add_div1").hide();
			$("#moreAdd_div1").show();
			$("#isAdded1").hide();
			$("#hide_th1").hide();
		} else {
			$("#add_div1").show();
			$("#moreAdd_div1").hide();
			$("#isAdded1").show();
			$("#hide_th1").show();
		}
		
		$("#proDetail_tagSid_from").val(_tagSid);

		initProDetail();
		$("#proType_select").change(proDetailQuery);
		$("#pageSelect1").change(proDetailQuery);

		//$("#brandGroupCode_select").change(proDetailQuery);
		$("#colorSid_select").change(proDetailQuery);
		$("#proDetail_isAddTag_select").change(proDetailQuery);
		
		$("#BrandCode_input").keyup(function(e){
			var e = e || event;
			var code = e.keyCode;
			if(code != 32 && !(code >=37 && code <= 40) && !(code >=16 && code <= 18) && code != 93){
				seachData($("#BrandCode_input").val());
			}
		});
	});
	function proDetailQuery() {
		$("#skuCode_from").val($("#skuCode_input").val());
		$("#skuName_from").val($("#skuName_input").val());
		$("#proType_from").val($("#proType_select").val());

		$("#brandGroupCode_from").val($("#BrandCode option:eq(0)").attr("sid"));
		$("#modelCode_from").val($("#modelCode_input").val());
		$("#colorSid_from").val($("#colorSid_select").val());

		$("#proDetail_isAddTag_from").val($("#proDetail_isAddTag_select").val());

		var params = $("#proDetail_form").serialize();
        LA.sysCode = '16';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('productTag.selectAllProduct', '商品促销标签查询：' + params, getCookieValue("username"),  sessionId);
		params = decodeURI(params);
		proDetailPagination.onLoad(params);
	}
	// 查询
	function query() {
		$("#cache").val(0);
		proDetailQuery();
	}
	// 重置
	function reset() {
		$("#cache").val(1);
		$("#skuCode_input").val("");
		$("#skuName_input").val("");
		$("#proType_select").val("");

		$("#BrandCode").html("<option value='' sid=''>请选择</option>"); 
		$("#BrandCode_input").val(""); 
		$("#colorSid_select").val("");
		$("#modelCode_input").val("");

		$("#proDetail_isAddTag_select").val("");
		proDetailQuery();
	}

	//初始化商品列表
	function initProDetail() {
		var url = $("#ctxPath").val()
				+ "/productTag/selectAllProduct?proActiveBit=1";
		proDetailPagination = $("#proDetailPagination").myPagination(
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
										"loading-inactive");
							}, 300);
						},
						callback : function(data) {
							$("#proDetail_tab tbody").setTemplateElement(
									"proDetail-list").processTemplate(data);
							if(_isMore == 1){
								$("td[id='hide_td1']").hide();
							} else {
								$("td[id='hide_td1']").show();
							}
						}
					}
				});
	}

	function getSelectSid() {
		var checkboxArray = new Array();
		var inT = "";
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			var productCode = $("#skuCode_" + productSid).text().trim();
			checkboxArray.push(productCode);
		});
		inT = JSON.stringify(checkboxArray);
		inT = inT.replace(/\%/g, "%25");
		inT = inT.replace(/\#/g, "%23");
		inT = inT.replace(/\&/g, "%26");
		inT = inT.replace(/\+/g, "%2B");
		return inT;
	}

	/* 添加商品关系 */
	function addProDetailTag() {
		var productSids = getSelectSid();
		if (productSids == "[]") {
			$("#warning2Body").text("请选取要添加的商品!");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}

        LA.sysCode = '16';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('productTag.saveProductTag', '商品添加促销标签：', getCookieValue("username"),  sessionId);

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
	//批量添加商品关系
	function addProDetailTagList() {
        LA.sysCode = '16';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('productTag.saveProductTagBySelects', '商品批量添加促销标签：' + $("#proDetail_form").serialize(), getCookieValue("username"),  sessionId);

		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/productTag/saveProductTagBySelects",
			async : false,
			dataType : "json",
			data : $("#proDetail_form").serialize(),
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
	
	/* 删除商品关系 */
	function deleteProDetailTag() {
		var productSids = getSelectSid();
		if (productSids == "[]") {
			$("#warning2Body").text("请选取要添加的商品!");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}

        LA.sysCode = '16';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('productTag.deleteProductTag', '商品删除促销标签：' + $("#proDetail_form").serialize(), getCookieValue("username"),  sessionId);

		$.ajax({
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
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<div class="table-toolbar">
		<div>
			<div class="col-md-3">
				<label class="control-label" style="text-align: right;">标准品名：</label>
				<input style="width: 140px;" type="text" id="skuName_input" />
			</div>
			<div class="col-md-3">
				<label class="control-label" style="text-align: right;">编码：</label>
				<input style="width: 140px;" type="text" id="skuCode_input" />
			</div>
			<div class="col-md-3">
				<label class="control-label" style="text-align: right;">类型：</label>
				<select id="proType_select" style="width: 140px;">
					<option value="">全部</option>
					<option value="1">普通商品</option>
					<option value="2">赠品</option>
					<option value="3">礼品</option>
					<option value="4">虚拟商品</option>
					<option value="5">服务类商品</option>
				</select>
			</div>
			
			<div class="col-md-3">
				<label class="control-label" style="text-align: right;">色系：</label>
				<select style="width: 140px;" id="colorSid_select">
					<option value="">全部</option>
				</select>
			</div>
			<br>&nbsp;<br>
			<div class="col-md-3">
				<label class="control-label" style="text-align: right;">集团品牌：</label>
				<!-- <select style="width: 140px;" id="brandGroupCode_select">
					<option value="" style="width: 120px">全部</option>
				</select> -->
				<select id="BrandCode" name="parentSid"
					style="width: 100%;display: none;">
					<option value="" sid="">请选择</option>	
				</select>
				<input id="BrandCode_input" class="_input" type="text"
					   value="" placeholder="请输入集团品牌" autocomplete="off" style="width: 140px;height: 23px;">
				<div id="dataList_hidden" class="_hiddenDiv" style="width: 140px;margin-left: 69px;">
					<ul></ul>
				</div>
			</div>
			<div class="col-md-3">
				<label class="control-label" style="text-align: right;">款号：</label>
				<input style="width: 140px;" type="text" id="modelCode_input" />
			</div>

			<div class="col-md-5" id="isAdded1">
				<label class="control-label" style="text-align: right;">是否已加入该活动标签：</label>
				<select id="proDetail_isAddTag_select" style="width: 140px">
					<option value="">全部</option>
					<option value="0">是</option>
					<option value="1">否</option>
				</select>
			</div><br>&nbsp;<br>
			<div class="col-md-6" id="add_div1" style="margin-bottom: 10px;padding-left:100px;">
				<a id="" onclick="addProDetailTag();" class="btn btn-primary"> <i
					class="fa fa-plus"></i> 添加
				</a>&nbsp;&nbsp;&nbsp;&nbsp; <a id="" onclick="deleteProDetailTag();"
					class="btn btn-primary"> <i class="fa fa-trash-o"></i> 去除
				</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<div class="col-md-6" id="moreAdd_div1" style="margin-bottom: 10px;padding-left:100px;">
				<a id="" onclick="addProDetailTagList();" class="btn btn-primary"> 导&nbsp;入
				</a>&nbsp;&nbsp;&nbsp;&nbsp; <a id="" onclick="closeBtDiv();"
					class="btn btn-primary"> 取&nbsp;消
				</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<div class="col-md-6" style="margin-bottom: 10px;padding-left:200px;">
				<a class="btn btn-default shiny" onclick="query();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="btn btn-default shiny" onclick="reset();">重置</a>
			</div>
		</div>
	</div>
	<!-- <div class="table-bordered" style="overflow-y: scroll; height: 300px;"> -->
		<table
			class="table table-bordered table-striped table-condensed table-hover flip-content"
			style="table-layout: fixed;width: 943px">
			<thead class="flip-content bordered-darkorange">
				<tr>
					<th style="text-align: center;" width="5%" id="hide_th1">选择</th>
					<th style="text-align: center;" width="10%">编码</th>
					<th style="text-align: center;" width="15%">标准品名</th>
					<!-- <th style="text-align: center;">产品名称</th> -->
					<th style="text-align: center;" width="14%">集团品牌名称</th>
					<th style="text-align: center;" width="7%">商品类型</th>
					<th style="text-align: center;" width="9%">款号/主属性</th>
					<th style="text-align: center;" width="5%">色系</th>
					<th style="text-align: center;" width="8%">色码/特性</th>
					<th style="text-align: center;" width="6%">规格</th>
					<th style="text-align: center;" width="7%">拍照状态</th>
					<th style="text-align: center;" width="7%">上架状态</th>
					<th style="text-align: center;" width="7%">是否停用</th>
				</tr>
			</thead>
		</table>
		<div style="overflow-y: scroll; height: 227px;">
		<table class="table table-bordered table-striped table-condensed table-hover flip-content"
			id="proDetail_tab" style="table-layout:fixed;">
			<tbody>
			</tbody>
		</table>
		</div>
		<div class="pull-left" style="padding: 10px 0;">
			<form id="proDetail_form" action="">
				<div class="col-lg-12">
					<select id="pageSelect1" name="pageSize" style="padding: 0 12px;">
						<option>5</option>
						<option selected="selected">10</option>
						<option>15</option>
						<option>20</option>
					</select>
				</div>
				&nbsp; <input type="hidden" id="skuCode_from" name="skuCode" /> <input
					type="hidden" id="skuName_from" name="skuName" /> <input
					type="hidden" id="proType_from" name="proType" /> <input
					type="hidden" id="brandGroupCode_from" name="brandGroupCode" /> <input
					type="hidden" id="modelCode_from" name="modelCode" /> <input
					type="hidden" id="colorSid_from" name="colorSid" /> <input
					type="hidden" id="cache" name="cache" value="1" /> <input
					type="hidden" id="proDetail_isAddTag_from" name="isAddTag" /> <input
					type="hidden" id="proDetail_tagSid_from" name="tagSid" />
			</form>
		</div>
		<div id="proDetailPagination"></div>
	<!-- </div> -->
	<!-- Templates -->
	<p style="display: none">
		<textarea id="proDetail-list" rows="0" cols="0">
			<!--
			{#template MAIN}
				{#foreach $T.list as Result}
					<tr class="gradeX">
						<td align="left" width="5%" id="hide_td1">
							<div class="checkbox" style="margin-bottom: 0;margin-top: 0;">
								<label style="padding-left:9px;margin: 6px 0;">
									<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
									<span class="text"></span>
								</label>
							</div>
						</td>
						<td align="center" width="10%">
							{$T.Result.skuCode}
						</td>
						<td align="center"  width="15%" style="text-overflow:ellipsis;word-break:keep-all;overflow:hidden;">
							{$T.Result.skuName}
						</td>
						<td align="center" width="14%" style="text-overflow:ellipsis;word-break:keep-all;overflow:hidden;">
						    {$T.Result.brandGroupName}
						</td>
						<td align="center" width="7%">
							{#if $T.Result.proType == 1}普通商品
							{#elseif $T.Result.proType == 2}赠品
							{#elseif $T.Result.proType == 3}礼品
							{#elseif $T.Result.proType == 4}虚拟商品
							{#elseif $T.Result.proType == 5}服务类商品
							{#/if}
						</td>
						<td align="center" width="9%" style="text-overflow:ellipsis;word-break:keep-all;overflow:hidden;">
						    {#if $T.Result.modelCode == "" || $T.Result.modelCode == null}{$T.Result.primaryAttr}
						    {#else}{$T.Result.modelCode}
						    {#/if}
						</td>
						<td align="center" width="5%">{$T.Result.colorName}</td>
						<td align="center" width="8%" style="text-overflow:ellipsis;word-break:keep-all;overflow:hidden;">
						    {#if $T.Result.colorCodeName == "" || $T.Result.colorCodeName == null}{$T.Result.features}
						    {#else}{$T.Result.colorCodeName}
						    {#/if}
						</td>
						<td align="center" width="6%" style="text-overflow:ellipsis;word-break:keep-all;overflow:hidden;">
						    {$T.Result.stanName}
						</td>
						<td align="center" width="7%">
							{#if $T.Result.photoStatus == 0}<span>未拍照</span>
							{#elseif $T.Result.photoStatus == 1}<span>已加入计划</span>
							{#elseif $T.Result.photoStatus == 3}<span>已拍照上传</span>
							{#elseif $T.Result.photoStatus == 4}<span>已编辑</span>
							{#/if}
						</td>
						<td align="center" width="7%">
							{#if $T.Result.skuSale == 0}<span>未上架</span>
							{#elseif $T.Result.skuSale == 1}<span>上架</span>
							{#elseif $T.Result.skuSale == 2}<span>已下架</span>
							{#/if}
						</td>
						<td align="center" width="7%">
							{#if $T.Result.proActiveBit == 1}<span class="label label-success graded">启用</span>
							{#elseif $T.Result.proActiveBit == 0}<span class="label label-darkorange graded">停用</span>
							{#/if}
						</td>
						<td style="display:none;" id="skuCode_{$T.Result.sid}">{$T.Result.skuCode}</td>
		       		</tr>
				{#/for}
		    {#/template MAIN}	-->
		</textarea>
	</p>
</body>
</html>