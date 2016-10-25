<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
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
<style type="text/css">
.trClick>td,.trClick>th {
	color: red;
}
</style>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	var brandRelationPagination;
	var brandRelationPagination1;
	$(function() {
		initBrandRelation();
		/*   $("#brandName_input").change(brandRelationQuery); */
		$("#pageSelect").change(brandRelationQuery);
	});
	function brandRelationQuery() {
		$("#brandName_from").val($("#brandName_input").val());
		var params = $("#brandRelation_form").serialize();
        LA.sysCode = '10';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('brand.queryBrand', '品牌查询：' + params, getCookieValue("username"),  sessionId);
		params = decodeURI(params);
		brandRelationPagination.onLoad(params);
	}
	function find() {
		/* $("#brandName_input").change(brandRelationQuery); */
		brandRelationQuery();
	}
	function reset() {
		$("#brandName_input").val("");
		brandRelationQuery();
	}
	function initBrandRelation() {
		var url = $("#ctxPath").val() + "/brandDisplay/queryBrand";
		brandRelationPagination = $("#brandRelationPagination")
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
								dataType : 'json',
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
									$("#brandRelation_tab tbody")
											.setTemplateElement(
													"brandRelation-list")
											.processTemplate(data);
								}
							}
						});
	}

	//用于删除关系时只刷新右边的
	var trClickSid = "";
	var trClickObj = "";
	//点击查询集团品牌下的门店品牌触发事件
	function trClick(sid, obj) {
		//用于删除关系时只刷新右边的
		trClickSid = sid;
		trClickObj = obj;
		//点击确定消失
		$("#modal-success-deleteRelationBrand").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});

		brandFatherName_ = $("#brandName1_" + sid).text().trim();
		$(obj).addClass("trClick").siblings().removeClass("trClick");
		//点击变红
		$(".brandGroupName").css("color", "#428bca");
		$("#brandName1_" + sid).css("color", "red");

        LA.sysCode = '10';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('brand.queryShopBrandPage', '根据集团品牌查询门店品牌：' + sid, getCookieValue("username"),  sessionId);

		var url = $("#ctxPath").val()
				+ "/brandRelationDisplay/queryShopBrandPage";
		brandRelationPagination1 = $("#brandRelationPagination1").myPagination(
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
						param : 'sid=' + sid,
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
							$("#brandRelation1_tab tbody").setTemplateElement(
									"brandRelation1-list")
									.processTemplate(data);
						}
					}
				});
	}
	function addBrandRelation() {
		sid_ = trClickSid;
		var url = __ctxPath + "/jsp/BrandRelation/addBrandRelation.jsp";
		$("#pageBody").load(url);
	}
	function modifyBrandRelation() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要修改的品牌关系");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		sid_ = value;
		parentSid_ = $("#parentSid_" + value).text().trim();
		brandName_ = $("#brandName_" + value).text().trim();
		//		brandFatherName_ = $("#brandFatherName_" + value).text().trim();
		var url = __ctxPath + "/jsp/BrandRelation/editBrandRelationView.jsp";
		$("#pageBody").load(url);
	}
	function deleteBrandRelation() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要删除的门店品牌");
			$("#warning2").show();
			return false;
		}
		confirmOkAndNo(function(){
            var value = checkboxArray[0];
            var sid = $("#sid_" + value).text().trim();

            LA.sysCode = '10';
            var sessionId = '<%=request.getSession().getId() %>';
            LA.log('brand.deleteRelationBrand', '删除集团品牌与门店品牌的关系：' + sid, getCookieValue("username"),  sessionId);

			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/brandRelationDisplay/deleteRelationBrand",
				dataType : "json",
				data : {
					"sid" : sid
				/* "brandSid":value */
				},
				success : function(response) {
					if (response.success == "true") {
						//用于删除关系时只刷新右边的
						$("#modal-body-success-deleteRelationBrand").html(
								"<div class='alert alert-success fade in'>"
										+ "<strong>删除成功，返回列表页!</strong></div>");
						$("#modal-success-deleteRelationBrand").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
					} else if (response.data.errorMsg != "") {
						$("#warning2Body").text(response.data.errorMsg);
						$("#warning2").show();
					}
					return;
				}
			});
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
		$("#pageBody").load(
				__ctxPath + "/jsp/BrandRelation/BrandRelationView.jsp");
	}
</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />

	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade"
		id="modal-success-deleteRelationBrand">
		<div class="modal-dialog" style="margin: 200px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="myModalLabel">温馨提示</h5>
				</div>
				<div class="modal-body" id="modal-body-success-deleteRelationBrand">操作成功</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="trClick(trClickSid,trClickObj);">确定</button>
				</div>
			</div>
			<!-- / .modal-content -->
		</div>
		<!-- / .modal-dialog -->
	</div>
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
								<h5 class="widget-caption">品牌关联管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body clearfix" id="pro">
								<div class="table-toolbar">
									<div style="float: left; width: 49%;margin-bottom:1%;">
										<span>集团品牌名称：</span> 
										<input type="text" id="brandName_input" />&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="find();"
											style="margin-bottom:1%;margin-top:1%;">查询</a>&nbsp;&nbsp; 
										<a class="btn btn-default shiny" onclick="reset();"
											style="margin-bottom:1%;margin-top:1%;">重置</a>
									</div>
									<div style="float: left; width: 2%;margin-bottom:1%;">&nbsp;</div>
									<div style="float: left; width: 49%;margin-bottom:1%;">
										<a onclick="addBrandRelation();" class="btn btn-primary" style="margin-bottom:1%;margin-top:1%;"> 
											<i class="fa fa-plus"></i>
											添加品牌关联信息
										</a>&nbsp; &nbsp; 
										<a onclick="modifyBrandRelation();" class="btn btn-info" style="margin-bottom:1%;margin-top:1%;"> 
											<i class="fa fa-wrench"></i>
											修改品牌关联信息
										</a>&nbsp; &nbsp; 
										<a onclick="deleteBrandRelation();" class="btn btn-danger" style="margin-bottom:1%;margin-top:1%;">
											<i class="fa fa-times"></i> 
											删除品牌关联信息
										</a>
									</div>
								</div>
								<div style="float: left; width: 49%;">
									<table class="table table-bordered table-striped table-condensed table-hover flip-content">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;">集团品牌名称</th>
											</tr>
										</thead>
									</table>
									<div style="overflow-y: scroll;height:352px">
										<table
											class="table table-bordered table-striped table-condensed table-hover flip-content"
											id="brandRelation_tab">
											<tbody>
											</tbody>
										</table>
									</div>
									<div class="pull-left" style="margin-top: 5px;">
										<form id="brandRelation_form" action="">
											<div class="col-lg-12">
												<select id="pageSelect" name="pageSize"
													style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>
											&nbsp; <input type="hidden" id="brandName_from"
												name="brandName" />
										</form>
									</div>
									<div id="brandRelationPagination"></div>
								</div>
								
								<div style="float: left; width: 2%;">&nbsp;</div>
								
								<div style="float: right; width: 49%;">
									<table
										class="table table-bordered table-striped table-condensed table-hover flip-content">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center; width:10%;">选择</th>
												<th style="text-align: center; width:50%;">门店类型</th>
												<th style="text-align: center; width:50%;">门店品牌名称</th>
											</tr>
										</thead>
									</table>
									<div style="overflow-y: scroll;height:352px">
										<table class="table table-bordered table-striped table-condensed table-hover flip-content"
											id="brandRelation1_tab">
												<tbody>
												</tbody>
										</table>
									</div>
									<div id="brandRelationPagination1"></div>
								</div>
								
							</div>

								<!-- Templates -->
								<p style="display: none">
									<textarea id="brandRelation-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" onclick="trClick('{$T.Result.sid}',this)" style="height:35px;cursor:pointer">
													
													<td align="center">
														<a id="brandName1_{$T.Result.sid}" class="brandGroupName">
															{$T.Result.brandName}
														</a>
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
								</p>
								<!-- Templates -->
								<p style="display: none">
									<textarea id="brandRelation1-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX">
												    <td align="left" style="text-align: center; width:10.3%;">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left: 9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="shopType_{$T.Result.sid}" style="text-align: center; width:51.7%;">
														{#if $T.Result.shopType == 0}
															北京
														{#elseif $T.Result.shopType == 1}
															外埠
														{#elseif $T.Result.shopType == 2}
															电商
														{#/if}
													</td>
													<td align="center" style="display:none;" id="parentSid_{$T.Result.sid}">{$T.Result.parentSid}</td>
													<td align="center" id="brandName_{$T.Result.sid}" style="text-align: center; width:48.3%;">{$T.Result.brandName}</td>
													<td align="center" style="display:none" id="sid_{$T.Result.sid}">{$T.Result.sid}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
								</p>
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