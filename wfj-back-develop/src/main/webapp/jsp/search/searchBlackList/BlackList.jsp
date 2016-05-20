<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var t;
	var blackPagination;
	var brandType_ = $("#brandType_from").val($("#blackType").val());
	$(function() {
			initBrand();
			$("#pageSelect").change(blackQuery);
			$("#blackType").change(blackQuery);
	});
	function blackQuery() {
		$("#id_from").val($("#id").val());
		$("#blackType_from").val($("#blackType").val());
		var params = $("#black_form").serialize();
		//alert("表单序列化后请求参数:"+params);
		params = decodeURI(params);
		blackPagination.onLoad(params);
	}
	function find() {
		/* $("#brandName_input").change(brandQuery); */ 
		blackQuery();
	}
	function reset() {
		$("#id").val("");
		/* brandQuery(); */
	}
	//初始化黑名单列表
	function initBrand() {
		var url = __ctxPath + "/blackList/getList";
		blackPagination = $("#blackPagination")
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
								async: false,
								
								ajaxStart: function() {
						               ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
						             },
						             ajaxStop: function() {
						               //隐藏加载提示
						               setTimeout(function() {
						                 ZENG.msgbox.hide();
						               }, 300);
						             },
								callback : function(data) {
									if(data.success == true){
										$("#brand_tab tbody").setTemplateElement("black-list").processTemplate(data);
									}else{
										$("#hotWord_tab tbody").setTemplateElement("hotWord-list").processTemplate(data);
										$("#model-body-warning").html("<div class='alert alert-warning fade in'><i></i><strong>"+data.message+"</strong></div>");
										$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
									}
								}
							}
						});
	}
	/* 添加黑名单 */
	function addBlackList() {
		/* brandType_ = $("#brandType_from").val($("#brandType_input").val()); */
		var url;
//		if (brandType_.val() != 0){
			/* $("#model-body-warning")
			.html(
					"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>门店品牌不可添加!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false; */
//			url = __ctxPath + "/jsp/Brand/addShopBrandView.jsp";
//			$("#pageBody").load(url);
//		}else{
			url = __ctxPath + "/jsp/search/searchBlackList/addBlackList.jsp";
			$("#pageBody").load(url);
//		}
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

	function deleteBlackList() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var id = $(this).val();
			checkboxArray.push(id);
		});
		if (checkboxArray.length > 1) {
		    $("#warning2Body").text("只能选择一列!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
		    $("#warning2Body").text("请选择要删除的黑名单!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		var type = $("#type_"+value).attr("value");
		$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/blackList/deleteBlackList",
					dataType : "json",
					data : {
						"id" : value,
						"type":type
					},
					success : function(response) {
						if (response.success == true) {
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
						    $("#warning2Body").text("删除失败!");
							$("#warning2").show();
						}
						return;
					}
				});
	}
	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(__ctxPath + "/jsp/search/searchBlackList/BlackList.jsp");
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
								<h5 class="widget-caption">搜索黑名单管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<div class="clearfix">
										<a id="editabledatatable_new" onclick="addBlackList();" class="btn btn-primary"> <i class="fa fa-plus"></i> 添加黑名单</a>&nbsp;&nbsp;&nbsp;&nbsp;
										<a id="editabledatatable_new" onclick="deleteBlackList();" class="btn btn-danger"> <i class="fa fa-times"></i> 删除黑名单 </a>&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
									<div class="mtb10">
										<span>黑名单类型：</span>
										<select id="blackType" style="width:200px;padding: 0px 0px">
											<option value="">--请选择--</option>
											<option value="ITEM">商品</option>
											<option value="SKU">SKU</option>
											<option value="SPU">SPU</option>
											<option value="BRAND">品牌</option>
										</select>&nbsp;&nbsp;&nbsp;&nbsp;
										<span>编号：</span> 
										<input type="text" id="id" />&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="reset();">重置</a>
									</div>									
								</div>
										<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="brand_tab">
                                        <thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;" width="7.5%">选择</th>
												<th style="text-align: center;">类型</th>
												<th style="text-align: center;">编号</th>
												<th style="text-align: center;">创建人</th>
												<th style="text-align: center;">创建时间</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="black_form" action="">
										<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp; 
										<input type="hidden" id="blackType_from" name="blackType" />
										<input type="hidden" id="id_from" name="id" />
									</form>
								</div>
								<div id="blackPagination"></div>
							</div>

							<!-- Templates -->
							<p style="display: none">
								<textarea id="black-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.id}" value="{$T.Result.id}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="type_{$T.Result.id}" value="{$T.Result.type}">{$T.Result.type}</td>
													<td align="center" id="id_{$T.Result.id}">{$T.Result.id}</td>
													<td align="center" id="creator_{$T.Result.id}">{$T.Result.creator}</td>
													<td align="center" id="createTime_{$T.Result.id}">{$T.Result.createTime}</td>

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
</body>
</html>