<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/zTreeStyle/metro.css">
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



<script
	src="${pageContext.request.contextPath}/js/jquery.ztree.all-3.5.min.js"></script>

<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	var brandCategoryPagination;
	$(function() {
		initBrandCategory();
		$("#brankCategoryName_input").change(brandCategoryQuery);
		$("#pageSelect").change(brandCategoryQuery);
	});
	function brandCategoryQuery() {
		$("#brankCategoryName_from").val($("#brankCategoryName_input").val());
		var params = $("#brandCategory_form").serialize();
		//alert("表单序列化后请求参数:"+params);
		params = decodeURI(params);
		brandCategoryPagination.onLoad(params);
	}
	function reset() {
		$("#brankCategoryName_input").val("");
		brandCategoryQuery();
	}
	//初始化品牌分类列表
	function initBrandCategory() {
		var url = __ctxPath + "/brandCategory/selectAllBrandCategory";
		//分页
		brandCategoryPagination = $("#brandCategoryPagination")
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
									ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
								},
								ajaxStop : function() {
									//隐藏加载提示
									setTimeout(function() {
										ZENG.msgbox.hide();
									}, 300);
								},
								//遍历表
								callback : function(data) {
									//使用模板
									$("#brandCategory_tab tbody")
											.setTemplateElement(
													"brandCategory-list")
											.processTemplate(data);
								}
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
	var zNodes = "";
	var brandSid = "";
	//跳转到维护页面
	function editBrandCategory() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var brandSid = $(this).val();
			checkboxArray.push(brandSid);
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
		if (checkboxArray[0] != null) {

			$.ajax({
				url : __ctxPath + "/brandCategory/edit?brandSid="
						+ checkboxArray[0],
				dataType : "json",
				async : false,
				success : function(response) {
					brandSid = checkboxArray[0];
					id = response.categorySid;
					$("#categorySid").val(response.categorySid);
				}
			});
			$
					.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/brandCategory/liste",
						dataType : "json",
						data : {
							"brandSid" : checkboxArray[0],
							"channelSid" : 1
						},
						success : function(response) {
							//['list':{'a':'a','b':'b'}]
							zNodes = response;
							//$("#znodes").val(zNodes);
							var t = $("#tree");
							t = $.fn.zTree.init(t, setting, zNodes);
							var tree = $.fn.zTree.getZTreeObj("tree");
							return;
						}
					});
		}
		$("#bcategoryDIV").show();
	}

	var zTree;
	var demoIframe;

	var setting = {
		check : {
			enable : true
		},
		view : {
			dblClickExpand : false,
			showLine : true,
			selectedMulti : false
		},
		data : {
			simpleData : {
				enable : true,
				idKey : "id",
				pIdKey : "pId",
				rootPId : ""
			}
		},
		callback : {
			beforeClick : function(treeId, treeNode) {
				var zTree = $.fn.zTree.getZTreeObj("tree");
				if (treeNode.isParent) {
					zTree.expandNode(treeNode);
					return false;
				} else {
					demoIframe.attr("src", treeNode.file + ".html");
					return true;
				}
			},
			onClick : function(event, treeId, treeNode, clickFlag) {
				var treeObj = $.fn.zTree.getZTreeObj("tree");
				treeObj.checkNode(treeNode, true, true);
				var nodes = treeObj.getCheckedNodes(true);
				var names = "";
				var ids = "";
				for (var i = 0; i < nodes.length; i++) {
					if (i == nodes.length) {
						names += nodes[i].name;
						ids += nodes[i].id;
					} else {
						names += nodes[i].name + ",";
						ids += nodes[i].id + ",";
					}
				}
				$("#categorySid").val(ids);
				$("#brandName").val(names);
			},
			onCheck : function(event, treeId, treeNode, clickFlag) {
				var treeObj = $.fn.zTree.getZTreeObj("tree");
				var nodes = treeObj.getCheckedNodes(true);
				var names = "";
				var ids = "";
				for (var i = 0; i < nodes.length; i++) {
					if (i == nodes.length) {
						names += nodes[i].name;
						ids += nodes[i].id;
					} else {
						names += nodes[i].name + ",";
						ids += nodes[i].id + ",";
					}
				}
				$("#categorySid").val(ids);
				$("#brandName").val(names);
			}
		}
	};

	function loadReady() {
		var bodyH = demoIframe.contents().find("body").get(0).scrollHeight, htmlH = demoIframe
				.contents().find("html").get(0).scrollHeight, maxH = Math.max(
				bodyH, htmlH), minH = Math.min(bodyH, htmlH), h = demoIframe
				.height() >= maxH ? minH : maxH;
		if (h < 530)
			h = 530;
		demoIframe.height(h);
	}
	//保存tree选中的节点
	function saveDivFrom2() {
		var cSid = $("#categorySid").val();
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/brandCategory/save",
					dataType : "json",
					data : {
						"brandSid" : brandSid,
						"categorySid" : cSid
					},
					success : function(response) {
						if (response.status == 'success') {
							$("#bcategoryDIV").hide();
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<i class='fa-fw fa fa-times'></i><strong>操作成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
						} else {
							$("#model-body-success")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>操作失败!</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
						}
					}
				});
	}

	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(__ctxPath + "/jsp/BrandCategoryView.jsp");
	}
	function closeCategoryDiv() {
		$("#bcategoryDIV").hide();
	}
</script>
</head>
<body>
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
								<span class="widget-caption"><h5>品牌分类管理</h5> </span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">

								<div class="table-toolbar">
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="editBrandCategory();"
											class="btn btn-info" style="width: 100%;"> <i
											class="fa fa-wrench"></i> 维护
										</a>
									</div>
									<div class="col-md-10">
										<div class="btn-group pull-right">
											<form id="brandCategory_form" action="">
												<div class="col-lg-12">
													<select id="pageSelect" name="pageSize">
														<option>5</option>
														<option selected="selected">10</option>
														<option>15</option>
														<option>20</option>
													</select>
												</div>
												&nbsp; <input type="hidden" id="brankCategoryName_from"
													name="brandName" />
											</form>
										</div>
									</div>
								</div>
								<div class="table-toolbar">
									<div class="col-md-4">
										<div class="col-lg-5">
											<span>品牌名称：</span>
										</div>
										<div class="col-lg-7">
											<input type="text" id="brankCategoryName_input"
												style="width: 100%" />
										</div>
									</div>
									<div class="col-md-8">
										<div class="col-lg-12">
											<a class="btn btn-default" onclick="reset();"
												style="height: 32px; margin-top: -4px;">重置</a>
										</div>
										&nbsp;
									</div>
								</div>
								<table class="table table-hover table-bordered"
									id="brandCategory_tab">
									<thead>
										<tr role="row">
											<th width="7.5%"></th>

											<th style="text-align: center;">网站品牌名称</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div id="brandCategoryPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="brandCategory-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="brandCategoryName_{$T.Result.sid}">{$T.Result.brandName}</td>
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
	<div class="modal modal-darkorange" id="bcategoryDIV">
		<div class="modal-dialog" style="width: 400px; margin: 80px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">属性信息</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row" style="padding: 10px;">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" id="categorySid" /> <span>分类信息</span>
									<div class="form-group">
										<ul id="tree" class="ztree"
											style="width: 560px; overflow: auto;"></ul>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeCategoryDiv();" type="button">取消</button>
					<button class="btn btn-default" type="button"
						onclick="saveDivFrom2();">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
</body>
</html>