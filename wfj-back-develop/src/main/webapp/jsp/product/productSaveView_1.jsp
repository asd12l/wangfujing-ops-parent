<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 添加商品
Version: 1.0.0
Author: WangSy
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--Jquery Select2-->
<script
	src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<!--Bootstrap Date Picker-->
<script
	src="${pageContext.request.contextPath}/assets/js/datetime/bootstrap-datepicker.js"></script>
<!-- zTree -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<!-- 分页JS -->
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
<script	src="${pageContext.request.contextPath}/assets/js/select2/selectAjax.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/selectAjax.css" />
<title>商品基本信息</title>

<style>
	.notbtn{
	    background-color: #fff;
	    border:1px solid #ccc;
	    color: #444;
	    border-radius: 2px;
	    font-size: 12px;
	    line-height: 1.39;
	    padding: 4px 9px;
	    text-align: center;   
	    text-decoration: none;
	}
	.notbtn:hover{
	    text-decoration: none;
	}
	.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
		cursor:pointer;
	}
</style>
<!-- <script type="text/javascript">
	function showBrandGroup(){
		$("#pageBodyBrandGroup").load(__ctxPath + "/jsp/product/selectBrand.jsp");
		$("#selectBrandGroup").show();
	}
	function closeBrandGroup(){
		$("#selectBrandGroup").hide();
	}
</script> -->
<script type="text/javascript">
	$("#li_show a").click(function() {
		var status = $("#li_show a").attr("data-toggle");
	  	if(status == " "){
		  	$("#warning2Body").text("请先添加产品基本信息！");
			$("#warning2").show();
	  	} else {
		   loadColors();
	  	}
	});
	$("#li_FinePack a").click(function() {
		var status = $("#li_FinePack a").attr("data-toggle");
	  	if(status == " "){
		$("#warning2Body").text("请先添加产品基本信息！");
			$("#warning2").show();
	  	} else {
			loadProPacking();
	  	}
	});

	var channelCodeList = new Array();
	__ctxPath = "${pageContext.request.contextPath}";

	//--Bootstrap Date Picker--
	$('.date-picker').datepicker();
	$("#li_pro a").attr("data-toggle", " ");
	$("#li_profile a").attr("data-toggle", " ");
	$("#li_show a").attr("data-toggle", " ");
	$("#li_FinePack a").attr("data-toggle", " ");

	var url = __ctxPath + "/category/getAllCategory";

	var setting2 = {
		check : {
			enable : true,
			chkboxType : {
				"Y" : "",
				"N" : "p"
			}
		},
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
			autoParam : [ "id", "channelSid", "shopSid", "categoryType", "pId" ],
			otherParam : {},
			dataFilter : filter
		},
		callback : {
			onCheck : zTreeOnCheck,
			beforeClick : beforeClick,
			/* onClick : onClick2, */
			asyncSuccess : zTreeOnAsyncSuccess,//异步加载成功的fun
			asyncError : zTreeOnAsyncError
		//加载错误的fun 
		}
	};

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

	/* 每次点击 checkbox */
	function zTreeOnCheck(event, treeId, treeNode) {
		/* alert(treeNode.tId + ", " + treeNode.name + "," + treeNode.checked); */
		var pathName = treeNode.name;
		var currentNode = treeNode.getParentNode();
		while (currentNode != null) {
			pathName = currentNode.name + " > " + pathName;
			currentNode = currentNode.getParentNode();
		}
		if (!treeNode.checked) {
			$("#div_" + treeNode.id).remove();
		} else {
			if (treeNode.isLeaf == "Y") {
				if (treeNode.categoryType == 0) {
					$("div[name='after']").remove();
					// 更换请选择汉字
					$("#baseA").html(treeNode.name);
					$("#categoryName").val(treeNode.name);
					$("#prodCategoryCode").val(treeNode.id);
					$("#treeDown").attr("treeDown", "true");
					// 查询属性
					$
							.ajax({
								type : "post",
								contentType : "application/x-www-form-urlencoded;charset=utf-8",
								url : __ctxPath + "/selectvalueDictByCateSid",
								async : false,
								data : {
									"categorySid" : treeNode.id
								},
								dataType : "json",
								ajaxStart : function() {
									$("#loading-container").prop("class",
											"loading-container");
								},
								ajaxStop : function() {
									$("#loading-container").addClass(
											"loading-inactive");
								},
								success : function(response) {
									var option = "";
									parametersLength = response.length;
									for (var i = 0; i < response.length; i++) {
										var ele = response[i].prop;
										option += "<div class='col-md-4' name='after'>"
												+ "<label class='col-md-4 control-label' name='propName'>";
										if (ele.notNull == 1) {
											option += "<font style='color:red;'>*</font>";
										}
										option += ele.propsName
												+ "</label>"
												+ "<input type='hidden' name='propSid' value='"+ele.propsSid+"' />"
												+ "<input type='hidden' name='valueSid' id='valueSid_"+ele.propsSid+"' />"
												+ "<input type='hidden' name='valueName' id='valueName_"+ele.propsSid+"' />"
												+ "<div class='col-md-8'>";
										if (ele.isEnumProp == 0) {// 0是枚举
											option += "<select class='sxz' style='width: 100%' id='valueSidSelect_"
													+ ele.propsSid
													+ "' >"
													+ "<option onclick='valueSelectClick("
													+ ele.propsSid
													+ ",-1)' value='请选择'>请选择</option>";
											for (var j = 0; j < response[i].values.length; j++) {
												var values = response[i].values[j];
												option += "<option onclick='valueSelectClick("
														+ ele.propsSid
														+ ","
														+ values.sid
														+ ")' value='"
														+ values.valuesName
														+ "'>"
														+ values.valuesName
														+ "</option>";
											}
											option += "</select>";
										} else {
											option += "<input class='form-control sxz' id='valueInput_"
													+ ele.propsSid
													+ "' onchange='valueInputChange("
													+ ele.propsSid
													+ ")' type='text'/>";
										}
										option += "</div>&nbsp;</div>";
									}
									$("#baseHr").append(option);
								}
							});
					
					// 查询色系
					fingColorDict();
					/* 查询类型字典 */
					findModelNum();
				} else if (treeNode.categoryType == 1) {// 管理分类操作   更换请选择汉字
					$("#proA").html(treeNode.name);
					$("#manageCateGory").val(treeNode.code);
					$("#proTreeDown").attr("treeDown", "true");
					
				} else if (treeNode.categoryType == 3) {
					// 展示分类

					$("#righttreeDown").attr("treeDown", "true");
					$
							.ajax({
								type : "post",
								contentType : "application/x-www-form-urlencoded;charset=utf-8",
								url : __ctxPath
										+ "/productprops/selectPropValueBySid",
								async : false,
								dataType : "json",
								data : {
									"cid" : treeNode.id,
									"productSid" : $("#spuSid_from").val()
								},
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
								success : function(response) {
									cData_change2 = response[0].c;
									if(cData_change2.length == 0 && response[0].cp.length == 0){
										$("#warning2Body").text("该分类下无属性可添加！");
										$("#warning2").show();
										return;
									}
									var option = "<div style='overflow-y: auto;width:100%;' id='div_"
											+ treeNode.id
											+ "' name='div_sppv'>"
											+ "<span style='width:100%;'>"
											+ pathName + "</span>";
									option += addOption(response[0].c,treeNode.tId);
									if (response[0].cp.length > 0) {
										option += addOption1(response[0].cp,treeNode.tId);
									}
									option += "<div style='display: none;'>"
											+ "<input type='hidden' id='rightCategorySid" +treeNode.id+ "' value='"+treeNode.id+"'/>"
											+ "<input type='hidden' id='rightCategoryName" +treeNode.id+ "' value='"+treeNode.name+"'/>"
											+ "<input type='hidden' id='rightChannelSid" +treeNode.id+ "' value='"+treeNode.channelSid+"'/>"
											+ "</div>" + "</div>";
									$("#rightddlist").append(option);
									/* for (var i = 0; i < cData_change2.length; i++) {
										var c = cData_change2[i];
										var category_id = (treeNode.tId + "" + c.propsSid).split("_")[1];

										option += "<ol id='rightdd-list_"+category_id+"' class='dd-list' style='cursor: pointer;'>"
												+ "<li class='dd-item bordered-danger'>"
												+ "<div class='dd-handle'>"
												+ "<div class='col-md-6'>"
												+ "<span style='color:red;'>";
										if (c.notNull == 1) {
											option += "* &nbsp";
										} else {
											option += "  &nbsp;";
										}
										option += "</span><span name='rightpropName'>"
												+ c.propsName
												+ "</span></div>"
												+ "<input type='hidden' value='"+c.propsSid+"' name='rightpropSid'>"
												+ "<div class='col-md-5'>"
												+ "<input id='rightvalueSid_"+category_id+"' type='hidden' name='rightvalueSid' value=''>"
												+ "<input id='rightvalueName_"+category_id+"' type='hidden' name='rightvalueName' value=''>";
										if (c.isEnumProp == 1) {
											if (c.valueName == undefined) {
												option += "<input type='text' id='rightvalueInput_"
														+ category_id
														+ "' onchange='rightvalueInputChange("
														+ category_id
														+ ")' value='' style='padding: 0 12px;width: 100%;'/>";
											} else {
												option += "<input type='text' id='rightvalueInput_"
														+ category_id
														+ "' onchange='rightvalueInputChange("
														+ category_id
														+ ")' value='"
														+ c.valueName
														+ "' style='padding: 0 12px;width: 100%;'/>";
											}
										} else {
											option += "<select class='rightyz' id='rightvalueSidSelect_"
													+ category_id
													+ "' name='" + c.propsName + "' style='padding: 0 12px;width: 100%;'>"
													+ "<option value='-1'>请选择</option>";
											for (var j = 0; j < c.values.length; j++) {
												var values = c.values[j];
												option += "<option  onclick='rightvalueSelectClick("
														+ category_id
														+ ","
														+ values.valuesSid
														+ ")' value='"
														+ values.valuesName
														+ "'>"
														+ values.valuesName
														+ "</option>";
											}
											option += "</select>";
										}
										option += "</div>";

										if (c.notNull == 0) {
											option += "<div class='col-md-1'>"
													+ "<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("
													+ category_id
													+ ",2);'>删除</span>"
													+ "</div>"
										}
										option += "</div>" + "</li>" + "</ol>";
									}

									option += "<div style='display: none;'>"
											+ "<input type='hidden' id='rightCategorySid" +treeNode.tId+ "' value='"+treeNode.id+"'/>"
											+ "<input type='hidden' id='rightCategoryName" +treeNode.tId+ "' value='"+treeNode.name+"'/>"
											+ "<input type='hidden' id='rightChannelSid" +treeNode.tId+ "' value='"+treeNode.channelSid+"'/>"
											+ "</div>" + "</div>";
									$("#rightddlist").append(option);  */
								}
							});
				} else {// 统计分类
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
	};

	function addOption(cData_change2,treeNode_tId) {
		var option = "";
		for (var i = 0; i < cData_change2.length; i++) {
			var c = cData_change2[i];
			var category_id = (treeNode_tId + "" + c.propsSid).split("_")[1];
			option += "<ol id='rightdd-list_"+category_id+"' class='dd-list' style='cursor: pointer;'>"
					+ "<li class='dd-item bordered-danger'>"
					+ "<div class='dd-handle'>"
					+ "<div class='col-md-6'>"
					+ "<span style='color:red;'>";
			if (c.notNull == 1) {
				option += "* &nbsp";
			} else {
				option += "  &nbsp;";
			}
			option += "</span><span name='rightpropName'>"
					+ c.propsName
					+ "</span></div>"
					+ "<input type='hidden' value='"+c.propsSid+"' name='rightpropSid'>"
					+ "<div class='col-md-5'>"
					+ "<input id='rightvalueSid_"+category_id+"' type='hidden' name='rightvalueSid' value='"+c.valueSid+"'>"
					+ "<input id='rightvalueName_"+category_id+"' type='hidden' name='rightvalueName' value='"+c.valueName+"'>";
			if (c.isEnumProp == 1) {
				if (c.valueName == undefined) {
					option += "<input type='text' class='rightyz' name='"+ c.propsName +"' id='rightvalueInput_"
							+ category_id
							+ "' onchange='rightvalueInputChange("
							+ category_id
							+ ")' value='' style='padding: 0 12px;width: 100%;'/>";
				} else {
					option += "<input type='text' class='rightyz' name='"+ c.propsName +"' id='rightvalueInput_"
							+ category_id + "' onchange='rightvalueInputChange("
							+ category_id + ")' value='" + c.valueName
							+ "' style='padding: 0 12px;width: 100%;'/>";
				}
			} else {
				option += "<select class='rightyz' id='rightvalueSidSelect_"
						+ category_id
						+ "' name='" + c.propsName + "' style='padding: 0 12px;width: 100%;'>"
						+ "<option value='-1'>请选择</option>";
				for (var j = 0; j < c.values.length; j++) {
					var values = c.values[j];
					option += "<option  onclick='rightvalueSelectClick("
							+ category_id + "," + values.valuesSid
							+ ")' value='" + values.valuesName + "'>"
							+ values.valuesName + "</option>";
				}
				option += "</select>";
			}
			option += "</div>";

			if (c.notNull == 0) {
				option += "<div class='col-md-1'>"
						+ "<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("
						+ category_id
						+ ",2);'>删除</span>"
						+ "</div>";
			}
			option += "</div>" + "</li>" + "</ol>";
		}
		return option;
	}
	function addOption1(cData_change2,treeNode_tId) {
		var option = "";
		for (var i = 0; i < cData_change2.length; i++) {
			var cp = cData_change2[i];
			var category_id = (treeNode_tId + "" + cp.propSid).split("_")[1];
			option += "<ol id='rightdd-list_"+category_id+"' class='dd-list' style='cursor: pointer;'>"
					+ "<li class='dd-item bordered-danger'>"
					+ "<div class='dd-handle'>"
					+ "<div class='col-md-6'>"
					+ "<span style='color:red;'>";
			if (cp.notNull == 1) {
				option += "* &nbsp";
			} else {
				option += "  &nbsp;";
			}
			option += "</span><span name='rightpropName'>"
					+ cp.propName
					+ "</span></div>"
					+ "<input type='hidden' value='"+cp.propSid+"' name='rightpropSid'>"
					+ "<div class='col-md-5'>"
					+ "<input id='rightvalueSid_"+category_id+"' type='hidden' name='rightvalueSid' value='"+cp.valueSid+"'>"
					+ "<input id='rightvalueName_"+category_id+"' type='hidden' name='rightvalueName' value='"+cp.valueName+"'>";
			if (cp.valueSid == null) {
				if (cp.valueName == 'undefined') {
					option += "<input type='text' class='rightyz' name='"+ cp.propName +"' id='rightvalueInput_"
							+ category_id
							+ "' onchange='rightvalueInputChange("
							+ category_id
							+ ")' value='' style='padding: 0 12px;width: 100%;'  onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
				} else {
					option += "<input type='text' class='rightyz' name='"+ cp.propName +"' id='rightvalueInput_"
							+ category_id
							+ "' onchange='rightvalueInputChange("
							+ category_id
							+ ")' value='"
							+ cp.valueName
							+ "' style='padding: 0 12px;width: 100%;'  onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
				}
			} else {
				option += "<select class='rightyz' id='rightvalueSidSelect_"
						+ category_id
						+ "' name='" + cp.propName + "' style='padding: 0 12px;width: 100%;' >"
						+ "<option onclick='rightvalueSelectClick("
						+ category_id + ",-1)' value='-1'>请选择</option>";
				for (var j = 0; j < cp.values.length; j++) {
					var values = cp.values[j];
					if (cp.valueSid == values.valuesSid) {
						option += "<option onclick='rightvalueSelectClick("
								+ category_id + "," + values.valuesSid
								+ ")' selected='selected' value='"
								+ values.valuesName + "'>" + values.valuesName
								+ "</option>";
					} else {
						option += "<option onclick='rightvalueSelectClick("
								+ category_id + "," + values.valuesSid
								+ ")' value='" + values.valuesName + "'>"
								+ values.valuesName + "</option>";
					}
				}
				option += "</select>";
			}
			option += "</div>";

			if (cp.notNull == 0) {
				option += "<div class='col-md-1'>"
						+ "<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("
						+ category_id
						+ ",2);'>删除</span>"
						+ "</div>";
			}
			option += "</div>" + "</li>" + "</ol>";
		}
		return option;
	}
	
	
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
			if (treeNode.categoryType == 0) {
				$("div[name='after']").remove();
				// 更换请选择汉字
				$("#baseA").html(treeNode.name);
				$("#categoryName").val(treeNode.name);
				$("#prodCategoryCode").val(treeNode.id);
				$("#treeDown").attr("treeDown", "true");
				// 查询属性
				$
						.ajax({
							type : "post",
							contentType : "application/x-www-form-urlencoded;charset=utf-8",
							url : __ctxPath + "/selectvalueDictByCateSid",
							async : false,
							data : {
								"categorySid" : treeNode.id
							},
							dataType : "json",
							ajaxStart : function() {
								$("#loading-container").prop("class",
										"loading-container");
							},
							ajaxStop : function() {
								$("#loading-container").addClass(
										"loading-inactive");
							},
							success : function(response) {
								var option = "";
								parametersLength = response.length;
								for (var i = 0; i < response.length; i++) {
									var ele = response[i].prop;
									option += "<div class='col-md-4' name='after'>"
											+ "<label class='col-md-4 control-label' name='propName'>";
									if (ele.notNull == 1) {
										option += "<font style='color:red;'>*</font>";
									}
									option += ele.propsName
											+ "</label>"
											+ "<input type='hidden' name='propSid' value='"+ele.propsSid+"' />"
											+ "<input type='hidden' name='valueSid' id='valueSid_"+ele.propsSid+"' />"
											+ "<input type='hidden' name='valueName' id='valueName_"+ele.propsSid+"' />"
											+ "<div class='col-md-8'>";
									if (ele.isEnumProp == 0) {// 0是枚举
										option += "<select class='sxz form-control' id='valueSidSelect_"
												+ ele.propsSid
												+ "' >"
												+ "<option onclick='valueSelectClick("
												+ ele.propsSid
												+ ",-1)' value='请选择'>请选择</option>";
										for (var j = 0; j < response[i].values.length; j++) {
											var values = response[i].values[j];
											option += "<option onclick='valueSelectClick("
													+ ele.propsSid
													+ ","
													+ values.sid
													+ ")' value='"
													+ values.valuesName
													+ "'>"
													+ values.valuesName
													+ "</option>";
										}
										option += "</select>";
									} else {
										option += "<input class='form-control sxz' id='valueInput_"
												+ ele.propsSid
												+ "' onchange='valueInputChange("
												+ ele.propsSid
												+ ")' type='text'/>";
									}
									option += "</div>&nbsp;</div>";
								}
								$("#baseHr").append(option);
							}
						});
				// Tree统计分类
				/* tjTreeDemo(); */
				// 查询色系
				fingColorDict();
				/* 查询类型字典 */
				findModelNum();
			} else if (treeNode.categoryType == 1) {// 管理分类操作   更换请选择汉字
				$("#proA").html(treeNode.name);
				$("#manageCateGory").val(treeNode.code);
				$("#proTreeDown").attr("treeDown", "true");
			} else if (treeNode.categoryType == 3) {
				// 展示分类
				$("#rightdd").html("");
				$("#rightddlist").html("");
				$("#rightChannelSid").val(treeNode.channelSid);
				// 更换请选择汉字
				$("#rightbaseA").html(treeNode.name);
				$("#rightCategoryName").val(treeNode.name);
				$("#rightCategorySid").val(treeNode.id);
				$("#righttreeDown").attr("treeDown", "true");
				$
						.ajax({
							type : "post",
							contentType : "application/x-www-form-urlencoded;charset=utf-8",
							url : __ctxPath
									+ "/productprops/selectPropValueBySid",
							async : false,
							dataType : "json",
							data : {
								"cid" : treeNode.id,
								"productSid" : $("#spuSid_from").val()
							},
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
							success : function(response) {
								cData_change2 = response[0].c;
								var opt = "";
								for (var i = 0; i < response[0].c.length; i++) {
									var c = response[0].c[i];
									opt += "<div class='col-md-4'>"
											+ "<label class='col-md-12 control-label'>"
											+ "<div class='checkbox'  style='float:left;'>";
									if (c.notNull == '1') {
										opt += "<label>"
												+ "<input type='checkbox' id='rightcheckId_"
												+ c.propsSid
												+ "' name='notNull' value='righton' onclick='rightcheckboxClick("
												+ c.propsSid
												+ ");' >"
												+ "<span id='rightcheckSpanId_"+c.propsSid+"' class='text'>"
												+ c.propsName
												+ "</span><span style='color:red;'>(必选)</span>"
												+ "</label>" + "<span></span>";
									} else {
										opt += "<label>"
												+ "<input type='checkbox' id='rightcheckId_"
												+ c.propsSid
												+ "' value='righton' onclick='rightcheckboxClick("
												+ c.propsSid
												+ ");' >"
												+ "<span id='rightcheckSpanId_"+c.propsSid+"' class='text'>"
												+ c.propsName + "</span>"
												+ "</label>";
									}
									opt += "</div>" + "</label>&nbsp;"
											+ "</div>";
								}
								$("#rightdd").append(opt);
								var option = "";
								for (var i = 0; i < response[0].cp.length; i++) {
									var cp = response[0].cp[i];
									option += "<ol id='rightdd-list_"+cp.propSid+"' class='dd-list' style='cursor: pointer;'>"
											+ "<li class='dd-item bordered-danger'>"
											+ "<div class='dd-handle'>"
											+ "<div class='col-md-6' name='rightpropName'>"
											+ cp.propName
											+ "</div>"
											+ "<input type='hidden' value='"+cp.propSid+"' name='rightpropSid'>"
											+ "<div class='col-md-5'>"
											+ "<input id='rightvalueSid_"+cp.propSid+"' type='hidden' name='rightvalueSid' value='"+cp.valueSid+"'>"
											+ "<input id='rightvalueName_"+cp.propSid+"' type='hidden' name='rightvalueName' value='"+cp.valueName+"'>";
									if (cp.valueSid == null) {
										if (cp.valueName == 'undefined') {
											option += "<input type='text' id='rightvalueInput_"
													+ cp.propSid
													+ "' onchange='rightvalueInputChange("
													+ cp.propSid
													+ ")' value='' style='padding: 0 12px;width: 100%;'/>";
										} else {
											option += "<input type='text' id='rightvalueInput_"
													+ cp.propSid
													+ "' onchange='rightvalueInputChange("
													+ cp.propSid
													+ ")' value='"
													+ cp.valueName
													+ "' style='padding: 0 12px;width: 100%;'/>";
										}
									} else {
										option += "<select class='yz' id='rightvalueSidSelect_"
												+ cp.propSid
												+ "' style='padding: 0 12px;width: 100%;'>"
												+ "<option onclick='rightvalueSelectClick("
												+ cp.propSid
												+ ",-1)' value='-1'>请选择</option>";
										for (var j = 0; j < cp.values.length; j++) {
											var values = cp.values[j];
											if (cp.valueSid == values.valuesSid) {
												option += "<option onclick='rightvalueSelectClick("
														+ cp.propSid
														+ ","
														+ values.valuesSid
														+ ")' selected='selected' value='"
														+ values.valuesName
														+ "'>"
														+ values.valuesName
														+ "</option>";
											} else {
												option += "<option onclick='rightvalueSelectClick("
														+ cp.propSid
														+ ","
														+ values.valuesSid
														+ ")' value='"
														+ values.valuesName
														+ "'>"
														+ values.valuesName
														+ "</option>";
											}
										}
										option += "</select>";
									}
									option += "</div>"
											+ "<div class='col-md-1'>"
											+ "<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("
											+ cp.propSid + ",1);'>删除</span>"
											+ "</div>" + "</div>" + "</li>"
											+ "</ol>";
								}
								$("#rightddlist").append(option);
							}
						});
			} else {// 统计分类
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

	// Tree工业分类请求
	function treeDeme() {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/list",
			async : false,
			data : {
				"categoryType" : 0
			},
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			success : function(response) {
				$.fn.zTree.init($("#treeDemo"), setting, response);
			}
		});
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
	// Tree统计分类
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
	/* 展示分类 */
	function isAtChannelCodeList(a){
		for(var i=0;i<channelCodeList.length;i++){
			if(a == channelCodeList[i]){
				return true;
			}
		}
		return false;
	}
	function rightTreeDemo() {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/list",
			async : false,
			data : {
				"categoryType" : 3
			},
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			success : function(response) {
				var zTreeCate = new Array();
				for(var i=0;i<response.length;i++){
					if(response[i].categoryType==3 && response[i].status=="Y"
							&& isAtChannelCodeList(response[i].channelSid) ){
						zTreeCate.push(response[i]);
					}
				}
				if(zTreeCate.length != 0){
					$.fn.zTree.init($("#rightTreeDemo"), setting2, zTreeCate);
				}
			}
		});
	}
	//格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动    
	function formatAsText(item) {
		var itemFmt = "<div style='display:inline'>" + item.name + "</div>";
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
						if (response.pageCount != 0) {
							var result = response.list;
							for (var i = 0; i < result.length; i++) {
								var ele = result[i];
								$("#counterCode")
										.append(
												"<option counterCode='" + ele.shoppeCode + "' industryConditionSid='"+ele.industryConditionSid+"' value='"+ele.sid+"'>"
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
	/* 色系列表 */
	function fingColorDict() {
		var proColor = $("#proColor");// 色系对象
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
				proColor.html("<option value='-1'>全部</option>");
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.sid + "'>"
							+ ele.colorName + "</option>");
					option.appendTo(proColor);
				}
				return;
			}
		});
	}
	$("#proTypeSid").select2({
		minimumResultsForSearch: -1
	});
	/* 商品类型字典列表 */
	function findModelNum() {
		var proTypeSid = $("#proTypeSid");
		$
				.ajax({
					type : "post",
					async : false,
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/product/selectProductType",
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").prop("class",
								"loading-container");
					},
					ajaxStop : function() {
						$("#loading-container").addClass("loading-inactive");
					},
					success : function(response) {
						var result = response.data;
						proTypeSid.html("");
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							if (ele.sid == 1) {
								var option = $("<option selected='selected' value='" + ele.sid + "'>"
										+ ele.typeName + "</option>");
								proTypeSid.append(option);
							} else {
								var option = $("<option value='" + ele.sid + "'>"
										+ ele.typeName + "</option>");
								proTypeSid.append(option);
							}
						}
						return;
					}
				});
		$("#proTypeSid").select2({
			minimumResultsForSearch: -1
		});
		$(".select2-arrow b").attr("style", "line-height: 2;");
	}
	
	/* 门店列表 */
	function findShop() {
		$("#proShopCode").html("");
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
/* 	// 查询所有集团品牌
	function findBrand() {
		$("#BrandCode").html("");
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/brandDisplay/queryBrandGroupList",
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
						"pageSize" : 10
					},
					success : function(response) {
						var result = response.list;
						var option = "<option value='-1'>请选择</option>";
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							option += "<option sid='"+ele.brandSid+"' value='"+ele.sid+"'>"
									+ ele.brandName + "</option>";
						}
						$("#BrandCode").append(option);
						return;
					}
				});
		$("#BrandCode").select2();
		$(".select2-arrow b").attr("style", "line-height: 2;");
		return;
	} */
	/* 门店点击后查询门店品牌方法 */
	function findShopBrand() {
		$("#shopBrandCode").html("");
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/brandDisplay/getShopBrandByShopSidAndSkuSid",
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

	/* 查询数据字典 */
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
		/* 弹窗 */
		$("#baseDivTable").hide();
		$("#proDivTable").hide();
		/* 特殊属性控制 */
		$("#TStype").change(function() {
			if ($("#type").val() != 0) {
				$("#TStype").val("in");
				$("#type").val(0);
				$("#productNumDiv").show();
				$("#colorCodeDiv").show();
				$("#mainAttributeDiv").hide();
				$("#featruesDiv").hide();
				$("#baseTableTh_2").text("色码");
			} else {
				$("#TStype").val("on");
				$("#type").val(1);

				$("#productNumDiv").hide();
				$("#colorCodeDiv").hide();
				$("#mainAttributeDiv").show();
				$("#featruesDiv").show();
				$("#baseTableTh_2").text("特性");
			}
		});
		$("#mainAttributeDiv").hide();
		$("#featruesDiv").hide();
		$("#loading-container").prop("class", "loading-container");
		// 查询所有集团品牌
		//findBrand();
		$("#BrandCode_input").keyup(function(e){
			var e = e || event;
			var code = e.keyCode;
			if(code != 32 && !(code >=37 && code <= 40) && !(code >=16 && code <= 18) && code != 93){
				seachData($("#BrandCode_input").val());
			}
		});
		// 控制tree
		
		$("#baseA").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#baseBtnGroup").attr("class", "btn-group open");

				$("#proTreeDown").attr("treeDown", "true");
				$("#proBtnGroup").attr("class", "btn-group");

				$("#tjTreeDown").attr("treeDown", "true");
				$("#tjBtnGroup").attr("class", "btn-group");
			} else {
				$(this).attr("treeDown", "true");
				$("#baseBtnGroup").attr("class", "btn-group");
			}
		});
		$("#treeDown").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#baseBtnGroup").attr("class", "btn-group open");

				$("#proTreeDown").attr("treeDown", "true");
				$("#proBtnGroup").attr("class", "btn-group");

				$("#tjTreeDown").attr("treeDown", "true");
				$("#tjBtnGroup").attr("class", "btn-group");
			} else {
				$(this).attr("treeDown", "true");
				$("#baseBtnGroup").attr("class", "btn-group");
			}
		});
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
		/* 统计分类的 */
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
		/* 展示分类的 */
		$("#righttreeDown").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#rightbaseBtnGroup").attr("class", "btn-group open");
			} else {
				$(this).attr("treeDown", "true");
				$("#rightbaseBtnGroup").attr("class", "btn-group");
			}
		});
		// 添加专柜商品的门店没有选择禁用专柜,楼层,供应商,管理分类
		$("#floor").attr("disabled", "disabled");
		$("#counterCode").attr("disabled", "disabled");
		$("#supplierCode").attr("disabled", "disabled");
		$("#proA").attr("disabled", "disabled");
		$("#proTreeDown").attr("disabled", "disabled");
		// 
		/* $("#isAdjustPrice").click(function() {
			isAdjustPrice();
		});
		$("#isPromotion").click(function() {
			isPromotion();
		}); */
		// 绑定#base 保存按钮
		$("#baseSave").click(function() {
			baseFrom();
		});
		$("#rightbaseSave").click(function() {
			rightbaseSave();
		});
		$("#proSave").click(function() {
			proForm();
		});
		$("#close").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		});
		$("#rightclose").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		});
		$("#loading-container").addClass("loading-inactive");
		$(".select2-arrow b").attr("style", "line-height: 2;");
		$("#productQuery").attr("disabled", "disabled");
		$("#resetQuery").attr("disabled", "disabled");
		$("#pageSelect").change(productQuery);
		/* 供应商绑定事件 */
		$("#supplierCode")
				.change(
						function() {
							if ($(this).val() / 1 != -1) {
								/* 加工类型 */
								for (var i = 0; i < dictResponse.data.length; i++) {
									if (dictResponse.data[i].jglx != null) {
										var jglx = dictResponse.data[i].jglx;
										var option="<option value='-1'>全部</option>";
										for (var j = 0; j < jglx.length; j++) {
											var ele = jglx[j];
											option += "<option value='"+ele.code+"'>"
													+ ele.name + "</option>";
										}
										$("#processingType").html(option);
									} 
								}
								
								var businessPattern = $("#supplierCode").find(
										"option:selected").attr(
										"businessPattern");
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
								/* 查询专柜列表 */
								counterCodeClick();
							} else {
								$("#counterCode").prop("disabled", "disabled");
							}
						});
		/* 集团品牌改变 */
		$("#BrandCode").change(function() {
			// 清理工业分类标签显示和工业属性
			$("#baseA").text("请选择");
			$("#baseHr").html("");
			// Tree工业分类
			treeDeme();
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
										var option="<option value='-1'>全部</option>";
										for (var j = 0; j < wllx.length; j++) {
											var ele = wllx[j];
											option += "<option value='"+ele.code+"'>"
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
							if((YTtype == 0 && $("#manageType").val() != 2)||YTtype == 1){
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
				tjTreeDemo();// Tree统计分类
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
	// sku列表数据-百货
function querySkulist() {
	var now = "";
	var colorNamelist = new Array();
	var colorCodelist = new Array();
	var sizelist = new Array();
	$("td[name='baseTableTd_colorName']").each(function() {
		colorNamelist.push($(this).html().trim());
	});
	$("td[name='baseTableTd_colorCode']").each(function() {
		colorCodelist.push($(this).html().trim());
	});
	$("td[name='baseTableTd_sizeCode']").each(function() {
		sizelist.push($(this).html().trim());
	});
	for (var i = 0; i < colorNamelist.length; i++) {
		if((colorNamelist[i] == $("#proColor").find("option:selected").html().trim()
				&& colorCodelist[i] != $("#colorCode").val().trim()) 
				|| (colorNamelist[i] != $("#proColor").find("option:selected").html().trim()
					&& colorCodelist[i] == $("#colorCode").val().trim())){
			now = "色系或色码填写错误！";
			return now;
		}
		if((colorCodelist[i] == $("#colorCode").val().trim()
					&& sizelist[i] == $("#sizeCode").val().trim())){
			now = "单品信息已存在!";
			return now;
		}
	}
	return now;
}
	// sku列表数据-超市
	function querySkulistCs() {
		var now = true;
		var colorlist = new Array();
		var sizelist = new Array();
		$("td[name='baseTableTd_featrues']").each(function() {
			colorlist.push($(this).html().trim());
		});
		$("td[name='baseTableTd_sizeCode']").each(function() {
			sizelist.push($(this).html().trim());
		});
		for (var i = 0; i < colorlist.length; i++) {
			if ((colorlist[i] + sizelist[i]) == ($("#featrues").val().trim() + $(
					"#sizeCode").val().trim())) {
				now = false;
				return now;
			}
		}
		return now;
	}
	var count = 100;
	// 追加新的SKU
	function addSku() {
		var proColorSid = $("#proColor").val();// 色系id
		var proColorText = "";
		if (proColorSid != -1) {
			proColorText = $("#proColor").find("option:selected").text();// 色系文本
		}
		var option = "";
		if ($("#type").val() == 0) {// 百货
			if (proColorSid == -1) {
				$("#warning2Body").text("色系必选!");
				$("#warning2").show();
				return;
			}
			if ($("#colorCode").val().trim() == "") {
				$("#warning2Body").text("色码必填!");
				$("#warning2").show();
				return;
			}
			if ($("#sizeCode").val().trim() == "") {
				$("#warning2Body").text("规格必填!");
				$("#warning2").show();
				return;
			}
			// 获取sku列表数据-百货
			var now = querySkulist();
			if (now != "") {
				$("#warning2Body").text(now);
				$("#warning2").show();
				return;
			}
			count++;
			option = "<tr id='baseTableTr_"+count+"'><td style='text-align: center;'>"
					+ "<div class='checkbox'>"
					+ "<label style='padding-left: 5px;'>"
					+ "<input type='checkbox' id='baseTableTd_colorSid_"+count+"' value='"+count+"'>"
					+ "<span class='text'></span>"
					+ "</label>"
					+ "</div>"
					+ "<input type='hidden' value='"+proColorSid+"'  name='baseTableTd_proColorSid'>"
					+ "</td>"
					+ "<td style='text-align: center;' name='baseTableTd_colorName'>"
					+ proColorText
					+ "</td>"
					+ "<td style='text-align: center;' name='baseTableTd_colorCode'>"
					+ $("#colorCode").val().trim()
					+ "</td>"
					+ "<td style='text-align: center;' name='baseTableTd_sizeCode'>"
					+ $("#sizeCode").val().trim() + "</td></tr>";
		} else {// 超市
			if ($("#sizeCode").val().trim() == "") {
				$("#warning2Body").text("主属性必填!");
				$("#warning2").show();
				return;
			}
			if ($("#featrues").val().trim() == "") {
				$("#warning2Body").text("特性必填!");
				$("#warning2").show();
				return;
			}
			// 获取sku列表数据-超市
			var now = querySkulistCs();
			if (!now) {
				$("#warning2Body").text("单品信息已存在!");
				$("#warning2").show();
				return;
			}
			if (proColorSid == -1) {
				count++;
				option = "<tr id='baseTableTr_"+count+"'><td style='text-align: center;'>"
				        + "<div class='checkbox'>"
				        + "<label style='padding-left: 5px;'>"
				        + "<input type='checkbox' id='baseTableTd_colorSid_"+count+"' value='"+count+"'>"
				        + "<span class='text'></span>"
				        + "</label>"
				        + "</div>"
				        + "<input type='hidden' value=''  name='baseTableTd_proColorSid'>"
				        + "</td>"
				        + "<td style='text-align: center;' name='baseTableTd_colorName'>"
				        + "--"
				        + "</td>"
						+ "<td style='text-align: center;' name='baseTableTd_featrues'>"
						+ $("#featrues").val().trim()
						+ "</td>"
						+ "<td style='text-align: center;' name='baseTableTd_sizeCode'>"
						+ $("#sizeCode").val().trim() + "</td></tr>";
			} else {
				count++;
				option = "<tr id='baseTableTr_"+count+"'><td style='text-align: center;'>"
						+ "<div class='checkbox'>"
						+ "<label style='padding-left: 5px;'>"
						+ "<input type='checkbox' id='baseTableTd_colorSid_"+count+"' value='"+count+"'>"
						+ "<span class='text'></span>"
						+ "</label>"
						+ "</div>"
						+ "<input type='hidden' value='"+proColorSid+"'  name='baseTableTd_proColorSid'>"
						+ "</td>"
						+ "<td style='text-align: center;' name='baseTableTd_colorName'>"
						+ proColorText
						+ "</td>"
						+ "<td style='text-align: center;' name='baseTableTd_featrues'>"
						+ $("#featrues").val().trim()
						+ "</td>"
						+ "<td style='text-align: center;' name='baseTableTd_sizeCode'>"
						+ $("#sizeCode").val().trim() + "</td></tr>";
			}
		}
		$("#baseTable tbody").append(option);
		$("#baseDivTable").show();
		return;
	}
	// 删除选中的SKU
	function deleteSku() {
		$("input[type='checkbox']:checked").each(function() {
			$("#baseTableTr_" + $(this).val()).remove();
		});
		return;
	}
	var productPagination;
	function productQuery() {
		$("#sxStanCode_from").val($("#sxStanCode").val());
		$("#sxColorCode_from").val($("#sxColorCode").val());
		var params = $("#product_form").serialize();
		params = decodeURI(params);
		productPagination.onLoad(params);
	}
	function resetQuery() {
		$("#sxStanCode").val("");
		$("#sxColorCode").val("");
		productQuery();
	}
	// SKU数据
	function initProduct(spuCode) {
		productPagination = $("#productPagination").myPagination(
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
						url : __ctxPath + "/product/selectAllProduct",
						dataType : 'json',
						param : 'spuCode=' + $("#spuCode_from").val(),
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
							$("#product_tab tbody").setTemplateElement(
									"product-list").processTemplate(data);
							for(var i=0;i<data.list.length;i++){
								if(data.list[i].spuCode == spuCode){
									$("#spuSid_from").val(data.list[i].spuSid);
								}
							}
						}
					}
				});
	}
	// 属性下拉框事件
	function valueSelectClick(data, valueSid) {
		// 赋值
		$("#valueSid_" + data).val(valueSid);
		$("#valueName_" + data).val($("#valueSidSelect_" + data).val());
	}
	// 属性文本框事件
	function valueInputChange(propSid) {
		// 赋值
		$("#valueSid_" + propSid).val(null);
		$("#valueName_" + propSid).val($("#valueInput_" + propSid).val());
	}
</script>
<!-- 经营方式和要约事件 -->
<script type="text/javascript">
	/* ERP集合 */
	var erpList;
	//经营方式点击
	 function manageTypeFunct() {
		//$("#divOfferNumber").show();
		var manageType = $("#manageType").val();
		/* if (manageType == -1) {
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
		/* if (manageType == 2 && $("#YTtype").val() == 0) {// 百货联营
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
		} else {
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
		}*/
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
		if (manageType == 2 && $("#YTtype").val() == 0) {// 百货联营
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
	function erpProductCodeChange() {
		var commissionRate = $("#erpProductCode").find("option:selected").attr(
				"commissionRate");
		$("#rate").val(commissionRate);
	}
</script>
<!-- base保存控制 -->
<script type="text/javascript">
	//属性属性值提交数据
	function inTJson() {
		var propName = new Array();
		var propSid = new Array();
		var valueSid = new Array();
		var valueName = new Array();
		var parameters = new Array();
		// 整理属性名
		$("label[name='propName']").each(function(i) {
			propName.push($(this).text().replace("*", "").trim());
		});
		// 整理属性SID
		$("input[name='propSid']").each(function(i) {
			propSid.push($(this).val());
		});
		// 整理值SID
		$("input[name='valueSid']").each(function(i) {
			if ($(this).val() == "") {
				valueSid.push(null);
			} else {
				valueSid.push($(this).val());
			}
		});
		// 整理值名称
		$("input[name='valueName']").each(function(i) {
			valueName.push($(this).val());
		});
		for (var i = 0; i < parametersLength; i++) {
			if(valueSid[i] == -1){
				
			}else if(valueName[i] == ""){
				
			}else{
				parameters.push({
					'propSid' : propSid[i],
					'propName' : propName[i],
					'valueSid' : valueSid[i],
					'valueName' : valueName[i]
				});
			}
		}
		var inT = JSON.stringify(parameters);
		inT = inT.replace(/\%/g, "%25");
		inT = inT.replace(/\#/g, "%23");
		inT = inT.replace(/\&/g, "%26");
		inT = inT.replace(/\+/g, "%2B");
		return inT;
	}
	// SKU数据
	function skuJson() {
		var proColor = new Array();// 色系
		var colorCode = new Array();// 色码
		var sizeCode = new Array();// 规格
		if ($("#type").val() == 0) {// 百货
			$("input[name='baseTableTd_proColorSid']").each(function() {
				proColor.push($(this).val());
			});
			$("td[name='baseTableTd_colorCode']").each(function() {
				colorCode.push($(this).html().trim());
			});
			$("td[name='baseTableTd_sizeCode']").each(function() {
				sizeCode.push($(this).html().trim());
			});
			var json = new Array();
			for (var i = 0; i < proColor.length; i++) {
				json.push({
					'proColor' : proColor[i],
					'colorCode' : colorCode[i],
					'colorName' : colorCode[i],
					'sizeCode' : sizeCode[i]
				});
			}
			var inT = JSON.stringify(json);
			inT = inT.replace(/\%/g, "%25");
			inT = inT.replace(/\#/g, "%23");
			inT = inT.replace(/\&/g, "%26");
			inT = inT.replace(/\+/g, "%2B");
			return inT;
		} else {
			$("input[name='baseTableTd_proColorSid']").each(function() {
				if ($(this).val() > 100) {
					proColor.push(null);
				} else {
					proColor.push($(this).val());
				}
			});
			$("td[name='baseTableTd_featrues']").each(function() {
				colorCode.push($(this).html().trim());
			});
			$("td[name='baseTableTd_sizeCode']").each(function() {
				sizeCode.push($(this).html().trim());
			});
			var json = new Array();
			for (var i = 0; i < proColor.length; i++) {
				json.push({
					'proColor' : proColor[i],
					'features' : colorCode[i],
					'sizeCode' : sizeCode[i]
				});
			}
			var inT = JSON.stringify(json);
			inT = inT.replace(/\%/g, "%25");
			inT = inT.replace(/\#/g, "%23");
			inT = inT.replace(/\&/g, "%26");
			inT = inT.replace(/\+/g, "%2B");
			return inT;
		}
	}
	// 保存#baseFrom
	function baseFrom() {
		var message = requiredBaseForm();
		if (message == false) {
			return;
		}
		var inT = inTJson();
		var sku = skuJson();
		if (sku == '[]') {
			$("#warning2Body").text("请添加单品");
			$("#warning2").show();
			return;
		}
		$("#parameters").html(inT);
		$("#skuProps").html(sku);
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/product/addProduct",
					dataType : "json",
					async : false,
					ajaxStart : function() {
						$("#loading-container").prop("class",
								"loading-container");
					},
					ajaxStop : function() {
						$("#loading-container").addClass("loading-inactive");
					},
					data : $("#baseForm").serialize(),
					success : function(response) {
						if (response.success == 'true') {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'><strong>添加成功</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;z-index:9999;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							$("#spuCode_from").val(response.data);
							initProduct(response.data);
							findChannel();
							$("#li_base").prop("class", " ");
							$("#base").prop("class", "tab-pane");
							$("#li_pro").addClass("active");
							$("#pro").addClass("active");
							$("#baseSave").prop("disabled", "disabled");
							// 保存成功置灰整个页面的按钮
							$("#shopCode").attr("disabled", "disabled");
							$("#type").attr("disabled", "disabled");
							$("#BrandCode").attr("disabled", "disabled");
							$("#baseA").attr("disabled", "disabled");
							$("#treeDown").attr("disabled", "disabled");
							//$("#tjA").attr("disabled", "disabled");
							//$("#tjTreeDown").attr("disabled", "disabled");
							$("#productNum").attr("disabled", "disabled");/* 款号 */
							$("#mainAttribute").attr("disabled", "disabled");/* 主属性 */
							$("#TStype").attr("disabled", "disabled");/* 特殊属性 */
							$("#proTypeSid").attr("disabled", "disabled");/* 类型 */
							$(".sxz").each(function() {
								$(this).attr("disabled", "disabled");
							});
							$("#proColor").attr("disabled", "disabled");
							$("#colorCode").attr("disabled", "disabled");
							$("#sizeCode").attr("disabled", "disabled");
							$("#baseBtnGroup").attr("disabled", "disabled");
							$("#addSku").attr("disabled", "disabled");
							$("#deleteSku").attr("disabled", "disabled");
							$("#productQuery").removeAttr("disabled");
							$("#resetQuery").removeAttr("disabled");
							/* 放开2345tab */
							$("#li_pro a").attr("data-toggle", "tab");
							$("#li_profile a").attr("data-toggle", "tab");
							$("#li_show a").attr("data-toggle", "tab");
							//$("#li_FinePack a").attr("data-toggle", "tab");
							isShowFinePackimg();
							rightTreeDemo();
							/* $("#li_show a").click(function() {
								loadColors();
							}); */

							if ($("#type").val() == 0) {
								$("#TeShutype").html("色码");
							} else if ($("#type").val() == 1) {
								$("#TeShutype").html("特性");
							}

						} else {
							$("#warning2Body").text(response.data.errorMsg);
							$("#warning2").show();
						}
						return;
					},
					/* error : function() {
						$("#warning2Body").text("系统出错");
						$("#warning2").show();
					} */
					error : function(XMLHttpRequest, textStatus) {		      
						var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
						if(sstatus != "sessionOut"){
							$("#warning2Body").text("系统出错");
							$("#warning2").show();
						}
						if(sstatus=="sessionOut"){     
			            	 $("#warning3").css('display','block');     
			             }
					}
				});
	}
</script>
<!-- 专柜商品保存 -->
<script type="text/javascript">
var inputTax_decimalLength = 0;
var KLNum_decimalLength = 0;
    /* 自动计算含税扣率 */
    function getHSKL(){
    	if(inputTax != "" && KLNum != ""){
    		var inputTax = Number($("#inputTax").val().trim());
        	var KLNum = Number($("#KLNum").val().trim());
        	var inputTaxStrs = inputTax.toString().split(".");
        	var KLNumStrs = KLNum.toString().split(".");
        	if(inputTaxStrs.length != 1){
        		inputTax_decimalLength = inputTaxStrs[1].length;
        	}
        	if(KLNumStrs.length != 1){
        		KLNum_decimalLength = KLNumStrs[1].length;
        	}
        //alert(inputTaxStrs.length+"--"+KLNumStrs.length);
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
		if ($("#type").val() == 0) {
			if ($("#productNum").val().trim() == "") {
				$("#warning2Body").text("款号没有填写");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return;
			}
		} else {
			if ($("#mainAttribute").val().trim() == "") {
				$("#warning2Body").text("主属性没有填写");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return;
			}
		}
		var urlPath = "";
		if($("#YTtype").val()==2){
			urlPath = "/product/saveShoppeProductDs";
		}else{
			urlPath = "/product/saveShoppeProduct";
		}
		
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + urlPath,
					dataType : "json",
					async : false,
					ajaxStart : function() {
						$("#loading-container").prop("class",
								"loading-container");
					},
					ajaxStop : function() {
						$("#loading-container").addClass("loading-inactive");
					},
					data : $("#proForm").serialize(),
					success : function(response) {
						var skuSid = $("#skuSid").val();
						if (response.success == 'true') {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'><strong>添加成功</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;z-index:9999;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							initShopp(skuSid);
							/* findChannel(); */
							clearAll();
							/* rightTreeDemo(); */
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
</script>
<!-- 多条码控制 -->
<script type="text/javascript">
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
				+ "<input type='text' name='proTableTd_placeOfOrigin' class='form-control' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20 />"
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
				+ "<input type='text' name='proTableTd_standardBarCode' onkeyup='clearNoNum2(event,this)' onblur='checkNum2(this)' onpaste='return false;' placeholder='只允许数字' class='form-control' maxLength=18/>"
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
		if ($("#"+id).val() == "on") {
			$("#"+id).val("in");
			$("#"+id+"Input").val(0);
		} else {
			$("#"+id).val("on");
			$("#"+id+"Input").val(1);
		}
	}
</script>
<!-- 显示专柜商品列表 -->
<script type="text/javascript">
	function skuClick(data, num) {
		if (num == 0) {
			/* 第一次点击是选中 */
			if ($("#tdCheckbox_" + data).attr("or") == "false") {
				$("#tdCheckbox_" + data).attr("or", "true");
			} else {
				$("#tdCheckbox_" + data).attr("or", "false");
				data = "0";
			}
			$("input[type='checkbox']:checked").each(function(i, team) {
				if ($(this).val() != data) {
					$(this).attr("or", "false");
					$(this).attr("checked", false);
				}
			});
		}
		initShopp(data);
	}
	var shoppPagination;
	function initShopp(data) {
		shoppPagination = $("#shoppPagination").myPagination(
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
						url : __ctxPath + "/product/selectShoppeProductBySku",
						dataType : 'json',
						param : 'productDetailSid=' + data,
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
							$("#shopp_tab tbody").setTemplateElement(
									"shopp-list").processTemplate(data);
						}
					}
				});
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

		var data;
		/* 获取选择的SKU */
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一列!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要添加的标准商品!");
			$("#warning2").show();
			return false;
		}
		data = checkboxArray[0];

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
		$("#skuSid").val(data);
		$("#manageType").prop("disabled", "disabled");
		$("#kh").text($("#productNum").val());
		$("#zsx").text($("#mainAttribute").val());
		var skuName = $("#name_" + data).text().trim();
		$("#skuName").val(skuName);
		$("#productName").val(skuName);
		$("#gg").text($("#gg_" + data).html().trim());
		$("#divProcessingType").hide();
		$("a[class='accordion-toggle collapsed']").each(function() {
			$(this).attr("class", "accordion-toggle");
			$("#" + this.id + "_1").addClass("in");
			$("#" + this.id + "_1").attr("style", "");
		});

		$("#ys").text($("#ys_" + data).html().trim());
		$("#tx").text($("#tx_" + data).html().trim());
		$("#sm").text($("#tx_" + data).html().trim());

		$("#appProDiv").show(function() {
			$("#appProScrollTop").scrollTop(0);
		});
	}
</script>
<!-- 展示分类 -->
<script type="text/javascript">
	//属性下拉框事件
	function rightvalueSelectClick(data, valueSid) {
		 // 赋值
		$("#rightvalueSid_" + data).val(valueSid);
		$("#rightvalueName_" + data).val(
				$("#rightvalueSidSelect_" + data).val()); 
	}
	// 属性文本框事件
	function rightvalueInputChange(propSid) {
		// 赋值
		$("#rightvalueSid_" + propSid).val(null);
		$("#rightvalueName_" + propSid).val(
				$("#rightvalueInput_" + propSid).val());
	}
	/* function rightcheckboxClick(data) {
		if ($("#rightcheckId_" + data).val() == 'righton') {
			var option = "";
			for (var i = 0; i < cData_change2.length; i++) {
				var c = cData_change2[i];
				if (c.propsSid == data) {
					option += "<ol id='rightdd-list_"+data+"' class='dd-list' style='cursor: pointer;'>"
							+ "<li class='dd-item bordered-danger'>"
							+ "<div class='dd-handle'>"
							+ "<div class='col-md-6' name='rightpropName'>"
							+ c.propsName
							+ "</div>"
							+ "<input type='hidden' value='"+c.propsSid+"' name='rightpropSid'>"
							+ "<div class='col-md-5'>"
							+ "<input id='rightvalueSid_"+c.propsSid+"' type='hidden' name='rightvalueSid' value='"+c.valueSid+"'>"
							+ "<input id='rightvalueName_"+c.propsSid+"' type='hidden' name='rightvalueName' value='"+c.valueName+"'>";
					if (c.isEnumProp == 1) {
						if (c.valueName == undefined) {
							option += "<input type='text' id='rightvalueInput_"
									+ c.propsSid
									+ "' onchange='rightvalueInputChange("
									+ c.propsSid
									+ ")' value='' style='padding: 0 12px;width: 100%;'/>";
						} else {
							option += "<input type='text' id='rightvalueInput_"
									+ c.propsSid
									+ "' onchange='rightvalueInputChange("
									+ c.propsSid
									+ ")' value='"
									+ c.valueName
									+ "' style='padding: 0 12px;width: 100%;'/>";
						}
					} else {
						option += "<select class='rightyz' id='rightvalueSidSelect_"
								+ c.propsSid
								+ "' style='padding: 0 12px;width: 100%;'>"
								+ "<option value='-1'>请选择</option>";
						for (var j = 0; j < c.values.length; j++) {
							var values = c.values[j];
							option += "<option  onclick='rightvalueSelectClick("
									+ c.propsSid
									+ ","
									+ values.valuesSid
									+ ")' value='"
									+ values.valuesName
									+ "'>"
									+ values.valuesName + "</option>";
						}
						option += "</select>";
					}
					option += "</div>"
							+ "<div class='col-md-1'>"
							+ "<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("
							+ c.propsSid + ",2);'>删除</span>" + "</div>"
							+ "</div>" + "</li>" + "</ol>";
				}
			}
			$("#rightddlist").append(option);
			$("#rightcheckId_" + data).val("rightin");
		} else {
			$("#rightdd-list_" + data).remove();
			$("#rightcheckId_" + data).val("righton");
		}
	} */
	function rightdeleteDDlist(data, num) {
		if (num == 1) {
			$("#rightdd-list_" + data).remove();
		} else {
			$("#rightcheckId_" + data).removeAttr("checked");
			$("#rightcheckId_" + data).val("righton");
			$("#rightdd-list_" + data).remove();
		}
	}
	function rightbaseSave() {
		// 必选都已经选择
		if ($("input[value='righton']").length == 0) {
			var yz = 0;
			var nameMeg = "";
			$(".rightyz").each(function() {
				if ($(this).val() == -1 || $(this).val().trim() == "") {
					yz++;
					nameMeg += $(this).attr("name") + ",";
				}
			});
			if (yz == 0) {
				var sppvs = new Array();
				var sppvsLenght = $("div[name='div_sppv']").length;

				$("div[name='div_sppv']")
						.each(
								function(i) {
									var div_id = $(this).attr("id");
									var div_cache = div_id.split("_")[1];

									var propName = new Array();
									var propSid = new Array();
									var valueSid = new Array();
									var valueName = new Array();
									var parameters = new Array();
									var dataLength = $(this).find(
											"span[name='rightpropName']").length;
									// 整理属性名
									$(this)
											.find("span[name='rightpropName']")
											.each(
													function(i) {
														propName.push($(this)
																.text().trim());
													});
									// 整理属性SID
									$(this).find("input[name='rightpropSid']")
											.each(function(i) {
												propSid.push($(this).val());
											});
									// 整理值SID
									$(this)
											.find("input[name='rightvalueSid']")
											.each(
													function(i) {
														if ($(this).val() == "") {
															valueSid.push(null);
														} else if ($(this)
																.val() == "undefined") {
															valueSid.push(null);
														} else {
															valueSid
																	.push($(
																			this)
																			.val());
														}
													});
									// 整理值名称
									$(this)
											.find(
													"input[name='rightvalueName']")
											.each(function(i) {
												valueName.push($(this).val());
											});
									for (var i = 0; i < dataLength; i++) {
										parameters.push({
											'propSid' : propSid[i],
											'propName' : propName[i],
											'valueSid' : valueSid[i],
											'valueName' : valueName[i]
										});
									}
									var inT = JSON.stringify(parameters);
									inT = inT.replace(/\%/g, "%25");
									inT = inT.replace(/\#/g, "%23");
									inT = inT.replace(/\&/g, "%26");
									inT = inT.replace(/\+/g, "%2B");

									sppvs
											.push({
												"categoryType" : "3",
												"categorySid" : $(
														"#rightCategorySid"
																+ div_cache)
														.val(),
												"spuSid" : $("#spuSid_from")
														.val(),
												"parameters" : inT,
												"categoryName" : $(
														"#rightCategoryName"
																+ div_cache)
														.val(),
												"channelSid" : $(
														"#rightChannelSid"
																+ div_cache)
														.val()
											});

								});
				var sppvsJSON = JSON.stringify(sppvs);
				$
						.ajax({
							type : "post",
							contentType : "application/x-www-form-urlencoded;charset=utf-8",
							url : __ctxPath
									+ "/productprops/addProductParameters",
							dataType : "json",
							data : {
								"jsonPara" : sppvsJSON
							},
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
							success : function(response) {
								if (response.success == 'true') {
                                    $("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功!</strong></div>");
                                    $("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
								} else {
									$("#warning2Body", parent.document).text(
											"添加失败!");
									$("#warning2", parent.document).attr(
											"style", "z-index:9999");
									$("#warning2", parent.document).show();
								}
							}
						});
			} else {
				$("#warning2Body", parent.document).text("枚举属性（"+nameMeg.substring(0,nameMeg.length-1)+"）未选择或未填写!");
				$("#warning2", parent.document).attr("style", "z-index:9999");
				$("#warning2", parent.document).show();
			}
		} else {
			$("#warning2Body", parent.document).text("存在必选属性未设置!");
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
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
	function proWarningBtn() {
		$("#proWarning").hide();
	}
	// 关闭DIV
	function closeProDiv() {
		$("#appProDiv").hide();
	}
	function iframeSuccessBtn2() {
		$("#iframeSuccess2").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		//$("#rightdd").html("");
		//$("#rightddlist").html("");
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
<!-- 验证表单Tab1商品信息 -->
<script type="text/javascript">
	function requiredBaseForm() {
		if ($("#BrandCode").val() == -1) {
			$("#warning2Body").text("请选择集团品牌");
			$("#warning2").show();
			return false;
		}
		if ($("#prodCategoryCode").val().trim() == "") {
			$("#warning2Body").text("请选择工业分类");
			$("#warning2").show();
			return false;
		}
		/*  */
		if ($("#type").val() == 0) {
			if ($("#productNum").val().trim() == "") {
				$("#warning2Body").text("请填写款号");
				$("#warning2").show();
				return false;
			}
		} else {
			if ($("#mainAttribute").val().trim() == "") {
				$("#warning2Body").text("请填写主属性");
				$("#warning2").show();
				return false;
			}
		}
		return true;
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
		if($("#YTtype").val() != 2){
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
	if ($("#marketPrice").val().trim() == "" || $("#marketPrice").val().trim() == 0) {
		$("#warning2Body").text("请填写吊牌价");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
		return false;
	}
	if ($("#salePrice").val().trim() == "" || $("#salePrice").val().trim() == 0) {
		$("#warning2Body").text("请填写销售价");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
		return false;
	}
	if ($("#inventory").val().trim() == "" || $("#inventory").val().trim() == 0) {
		$("#warning2Body").text("请填写可售库存");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
		return false;
	}
	if ($("#KLNum").val().trim() == "") {
		if((YTtype == 0 && $("#manageType").val() != 2)||YTtype == 1){
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

	}else if ($("#YTtype").val() == 1) {//超市
		if ($("#proTable").find("tbody").html().trim() == "") {
			$("#warning2Body").text("请新增条码");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
	} else if ($("#YTtype").val() == 2) {//电商
		
	} 
	return true;
}
//添加一个专柜商品后或取消添加专柜商品后清除已填的条码数据
function clearAll(){
	$("#tmlist").val("");
	$("#KLNum").val("");
	$("#HSKLNum").val("");
}
	
</script>

<script type="text/javascript">
	function loadColors() {
		$("#show").load("${pageContext.request.contextPath}/upImg/loadColors",
				{
					"proSid" : $('#spuCode_from').val(),
					"mark" : "3"
				});
	}
	function loadProPacking() {
		$("#FinePack").load("${pageContext.request.contextPath}/productDesc/loadProPacking",
				{
					"proSid" : $('#spuCode_from').val(),
					"mark" : "3"
				});
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
		if (Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos) == 0) {
			return "";
		} else {
			return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);
		}
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
<script type="text/javascript">
  $(function(){
	  $("#myTab").on("click","#li_pro",function(){		  
		  var status = $("#li_pro a").attr("data-toggle");
		  if(status == " "){
			  $("#warning2Body").text("请先添加产品基本信息！");
			  $("#warning2").show();
		  }
	  });
	  $("#myTab").on("click","#li_profile",function(){		  
		  var status = $("#li_profile a").attr("data-toggle");
		  if(status == " "){
			  $("#warning2Body").text("请先添加产品基本信息！");
			  $("#warning2").show();
		  } else{
			  findChannel();
			  rightTreeDemo();
		  }
	  });
	  $("#myTab").on("click","#li_show",function(){		  
		  var status = $("#li_show a").attr("data-toggle");
		  if(status == " "){
			  $("#warning2Body").text("请先添加产品基本信息！");
			  $("#warning2").show();
		  }
	  });
	  $("#myTab").on("click","#li_FinePack",function(){		  
		  var status = $("#li_FinePack a").attr("data-toggle");
		  if(status == " "){
			  $("#warning2Body").text("请先添加产品基本信息和上传图片！");
			  $("#warning2").show();
		  }
	  });
  });
</script>
<script type="text/javascript">
	function isShowFinePackimg(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/upImg/loadProImgs1",
			dataType : "json",
			data : {
				"proSid" : $('#spuCode_from').val()
			},
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
			success : function(response) {
				if (response.success == 'true') {
					var data = response.data;
					if(data != "undefined" && data != null && data.length != 0){
						$("#li_FinePack a").attr("data-toggle", "tab");
					} else {
						$("#li_FinePack a").attr("data-toggle", " ");
					}
				}
			}
		});
	}
	function findChannel(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/findChannelBySPUPara",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			data : {
				"spuCode" : $('#spuCode_from').val()
			},
			success : function(response) {
				if(response.success == "true"){
					var channelList = response.data;
					for(var i=0;i<channelList.length;i++){
						if(channelList[i].channelCode == "0"){
							channelCodeList.push(channelList[i].channelCode);
						} else {
							channelCodeList.push(channelList[i].sid);
						}
						
					}
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
								<span class="widget-caption">添加商品</span>
							</div>
							<div class="widget-body">
								<div class="tabbable">
									<ul class="nav nav-tabs" id="myTab">
										<li class="active" id="li_base"><a data-toggle="tab"
											href="#base"> <span>基本信息</span>
										</a></li>

										<li class="tab-red" id="li_pro"><a data-toggle="tab"
											href="#pro"> <span>专柜商品</span>
										</a></li>

										<li class="tab-red" id="li_profile"><a data-toggle="tab"
											href="#propfile"> <span>展示分类</span>
										</a></li>

										<li class="tab-red" id="li_show"><a data-toggle="tab"
											href="#show"> <span>图片上传</span>
										</a></li>
										<li class="tab-red" id="li_FinePack"><a data-toggle="tab"
											href="#FinePack"> <span>精包装</span>
										</a></li>
									</ul>
									<!-- BaseMessage start -->
									<div class="tab-content">
										<div id="base" class="tab-pane in active">
											<form id="baseForm" method="post" class="form-horizontal">
												<div class="col-md-12">
													<h5>
														<strong>产品信息添加</strong> <font style="color: red;">(以下信息必填)</font>
													</h5>
													<hr class="wide" style="margin-top: 0;">
													<div class="col-md-6">
														<label class="col-md-3 control-label">集团品牌</label>
														<div class="col-md-9 js-data-example-ajax">
															<select id="BrandCode" name="brandSid"
																style="width: 100%;display: none;">
																<option value="-1">请选择</option>	
															</select>
															<input id="BrandCode_input" class="_input" type="text"
																   value="" placeholder="请输入集团品牌" autocomplete="off">
															<div id="dataList_hidden" class="_hiddenDiv" style="width:91%;">
																<ul></ul>
															</div>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-3 control-label">特殊属性</label>
														<div class="col-md-9">
															<label class="control-label"> <input
																type="checkbox" id="TStype" value="on"
																class="checkbox-slider toggle yesno"> <span
																class="text"></span>
															</label> <input type="hidden" id="type" name="type" value="0">
														</div>
														&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-3 control-label">工业分类</label>
														<div class="col-md-9">
															<div class="btn-group" style="width: 100%"
																id="baseBtnGroup">
																<a href="javascript:void(0);" class="btn btn-default"
																	id="baseA" treeDown="true" style="width: 87%;">请选择</a> <a id="treeDown"
																	href="javascript:void(0);" class="btn btn-default"
																	treeDown="true"><i class="fa fa-angle-down"></i></a>
																<ul id="treeDemo" class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 98%; position: absolute;
																	max-height: 200px;overflow-y: auto;"></ul>
																<input type="hidden" id="prodCategoryCode"
																	name="prodCategoryCode" />
															</div>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-3 control-label">类型</label>
														<div class="col-md-9 js-data-example-ajax">
															<select id="proTypeSid" name="proTypeSid"
																style="width: 100%"></select>
														</div>
														&nbsp;
													</div>
													<div class="col-md-6" id="productNumDiv">
														<label class="col-md-3 control-label">款号</label>
														<div class="col-md-9">
															<input type="text" class="form-control" id="productNum"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																onkeyup="value=value.replace(/[\u4E00-\u9FA5]/g,'');"
																oninput="value=value.replace(/[\u4E00-\u9FA5]/g,'');"
																maxLength=20 placeholder="不可为汉字，并且长度小于20"
																name="productNum" />
														</div>
													</div>
													<div class="col-md-6" id="mainAttributeDiv">
														<label class="col-md-3 control-label">主属性</label>
														<div class="col-md-9">
															<input type="text" class="form-control"
																id="mainAttribute" name="mainAttribute" />
														</div>
														&nbsp;
													</div>
												</div>
												<div class="col-md-12">
													<h5>
														<strong>工业属性添加</strong> <font style="color: red;">(*为必填属性)</font>
													</h5>
													<hr class="wide" style="margin-top: 0;">
												</div>
												<div class="col-md-12" id="baseHr"></div>
												<div class="col-md-12">
													<h5>
														<strong>商品信息添加</strong> <font style="color: red;">(单品必填)</font>
													</h5>
													<hr class="wide" style="margin-top: 0;">
													<div class="col-md-3" >
														<label class="col-md-4 control-label">色系</label>
														<div class="col-md-8">
															<select class="form-control" id="proColor">
																<option value="">请选择</option>
															</select>
														</div>
													</div>
													<div class="col-md-3" id="colorCodeDiv" >
														<label class="col-md-4 control-label">色码</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="colorCode"
																onkeydown=if(event.keyCode==13)event.keyCode=9
                                                                oninput="value=value.replace(/[<>]/g,'');"
																maxLength=10 />
														</div>
													</div>
													<div class="col-md-3" id="featruesDiv" >
														<label class="col-md-4 control-label">特性</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="featrues"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=10 />
														</div>
													</div>
													<div class="col-md-3" id="sizeCodeDiv" >
														<label class="col-md-4 control-label">规格</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="sizeCode"
																onkeydown=if(event.keyCode==13)event.keyCode=9
                                                                oninput="value=value.replace(/[<>]/g,'');"
																maxLength=10 />
														</div>
													</div>
													<div class="col-md-3" >
														<div class="col-md-12 buttons-preview">
															<a class="btn btn-default purple" id="addSku"
																onclick="addSku();">添加单品</a>&nbsp; <a
																class="btn btn-danger" id="deleteSku"
																onclick="deleteSku();">删除单品</a>
														</div>
														&nbsp;
													</div>
												</div>
												<div class="col-md-12">
													<div class="col-md-12" id="baseDivTable">
														<table id="baseTable"
															class="table table-bordered table-striped table-condensed table-hover flip-content">
															<thead class="flip-content bordered-darkorange">
																<tr>
																	<th width="50px;"></th>
																	<th style="text-align: center;" id="baseTableTh_1">色系</th>
																	<th style="text-align: center;" id="baseTableTh_2">色码</th>
																	<th style="text-align: center;" id="baseTableTh_3">规格</th>
																</tr>
															</thead>
															<tbody>
															</tbody>
														</table>
													</div>
													&nbsp;
												</div>
												<div style="display: none;">
													<input type="hidden" id="categoryName" name="categoryName" />
													<textarea id="parameters" name="parameters"></textarea>
													<textarea id="skuProps" name="skuProps"></textarea>
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;"
															id="baseSave" type="button" value="保存" />&emsp;&emsp; <input
															class="btn btn-danger" style="width: 25%;" id="close"
															type="button" value="取消" />
													</div>
												</div>
											</form>
										</div>
										<!-- BaseMessage end -->
										<!-- ProMessage start -->
										<div id="pro" class="tab-pane">
											<div class="row">
												<div class="col-xs-12 col-md-12">
													<div class="col-xs-6">
														<div class="col-md-12">
															<hr class="wide" style="border-top: 0 solid #e5e5e5;">
														</div>

													</div>
												</div>
												<div class="col-xs-12 col-md-6">
													<div class="well with-header with-footer">
														<div class="header bordered-pink">
															<code>商品列表</code>
														</div>
														<div  style="height: 447px;overflow-x: auto;">
														<div class="table-scrollable" style="overflow: visible;">
															<table id="product_tab"
																class="table table-striped table-bordered table-hover">
																<thead>
																	<tr>
																		<th style="text-align: center;">选择</th>
																		<th style="text-align: center;">商品编号</th>
																		<th style="text-align: center;">商品名称</th>
																		<th style="text-align: center;">集团品牌</th>
																		<th style="text-align: center;">颜色</th>
																		<th style="text-align: center;">规格</th>
																		<th id="TeShutype" style="text-align: center;">特性</th>
																	</tr>
																</thead>
																<tbody></tbody>
															</table>
														</div>
														</div>
														<div class="footer">
															<form id="product_form" action="">
																<input type="hidden" id="spuCode_from" name="spuCode"
																	value="200000136" /> <input type="hidden" id="spuSid_from" name="spuSid"
																	value="100000136" /><input type="hidden"
																	id="sxColorCode_from" name="sxColorCode" value="" /> <input
																	type="hidden" id="sxStanCode_from" name="sxStanCode"
																	value="" />
															</form>
															<div id="productPagination"></div>
														</div>
													</div>
												</div>
												<div class="col-xs-12 col-md-6">
													<div class="well with-header with-footer">
														<div class="header bordered-success" style="padding: 0;">
															<code style="margin: 10px 10px 0 10px; float: left;">专柜商品列表</code>
															<a style="margin: 3px 17px; float: right;"
																class="btn btn-default purple" id="addZGpro"
																onclick="addZGpro();">添加专柜商品</a>
														</div>

														<div  style="height: 447px;overflow-x: auto;">
														<div class="table-scrollable" style="overflow: visible;">
															<table id="shopp_tab"
																class="table table-striped table-bordered table-hover">
																<thead>
																	<tr>
																		<th style="text-align: center;">门店</th>
																		<th style="text-align: center;">专柜编码</th>
																		<th style="text-align: center;">编码</th>
																		<th style="text-align: center;">名称</th>
																		<th style="text-align: center;">供应商</th>
																		<th style="text-align: center;">门店品牌</th>
																		<th style="text-align: center;">管理分类</th>
																		<th style="text-align: center;">状态</th>
																	</tr>
																</thead>
																<tbody></tbody>
															</table>
														</div>
														</div>
														<div class="footer">
															<div id="shoppPagination"></div>
														</div>
													</div>

												</div>
											</div>
										</div>
										<!-- ProMessage end -->
										<!-- propfileMessage start -->
										<div id="propfile" class="tab-pane">
											<form id="rightbaseForm" method="post"
												class="form-horizontal">
												<div class="row">
													<div class="col-lg-12 col-sm-12 col-xs-12">
														<div class="col-md-4" style="width: 40%; float: left;">
															<div class="col-md-12 well" style="padding: 10px;">
																<div class="col-md-12">
																	<a class="notbtn purple fa fa-star"
																		style="width: 99.9%;cursor:default;">&nbsp;展示分类树信息</a>
																</div>

																<div class="col-md-12"
																style="overflow-y: auto; max-height: 400px;margin-top:15px;">
																	<ul id="rightTreeDemo" class="ztree">
																	</ul>
																</div>
																&nbsp;
															</div>
														</div>
														<div style="width: 58%; float: left;">
															<div class="widget">
																<div class="widget-header ">
																	<h5 class="widget-caption" id="widget">
																		<strong>展示属性</strong>
																	</h5>

																</div>

																<div class="widget-body" id="pro"
																	style="overflow-y: auto; max-height: 400px;">

																	<div class="col-md-12" id="rightddlist"
																		 style="overflow-y: auto; max-height: 400px;"></div>
																	&nbsp;

																	<div id="categoryPagination"></div>
																</div>


															</div>
														</div>
													</div>
												</div>

												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;"
															id="rightbaseSave" type="button" value="保存" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;"
															id="rightclose" type="button" value="取消" />
													</div>
												</div>
											</form>
										</div>
										<!-- propfileMessage end -->
										<!-- #show start -->
										<div id="show" class="tab-pane"></div>
										<!-- #show end -->
										
										<!-- #FinePack start -->
										<div id="FinePack" class="tab-pane"></div>
										<!-- #FinePack end -->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Templates -->
	<p style="display: none">
		<textarea id="product-list" rows="0" cols="0">
			<!--
			{#template MAIN}
				{#foreach $T.list as Result}
					<tr class="gradeX">
						<td align="left" style="vertical-align: text-top;">
							<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
								<label style="padding-left: 4px;">
									<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" or="false"  onclick="skuClick({$T.Result.sid},0);">
									<span class="text"></span>
								</label>
							</div>
						</td>
						<td align="center"><a onclick="skuClick({$T.Result.sid},1);" style="cursor:pointer;">{$T.Result.skuCode}</a></td>
						<td align="center" id="name_{$T.Result.sid}">
							<a onclick="skuClick({$T.Result.sid},1);" style="cursor:pointer;">{$T.Result.skuName}</a></td>
						<td align="center">{$T.Result.brandGroupName}</td>
						<td align="center" id="ys_{$T.Result.sid}">
							{#if $T.Result.colorName==null}
							{#else}
								{$T.Result.colorName}
							{#/if}
						</td>
						<td align="center" id="gg_{$T.Result.sid}">
							{$T.Result.stanCode}
						</td>
						<td align="center" id="tx_{$T.Result.sid}">
							{#if $T.Result.features==null}
							    {$T.Result.colorCode}
							{#else}
								{$T.Result.features}
							{#/if}
						</td>
		       		</tr>
				{#/for}
		    {#/template MAIN}	-->
		</textarea>
	</p>
	<p style="display: none">
		<textarea id="shopp-list" rows="0" cols="0">
			<!--
			{#template MAIN}
				{#foreach $T.list as Result}
					<tr class="gradeX">
						<td align="center">{$T.Result.storeName}</td>
						<td align="center">{$T.Result.counterCode}</td>
						<td align="center">{$T.Result.productCode}</td>
						<td align="center">{$T.Result.productName}</td>
						<td align="center">{$T.Result.supplierName}</td>
						<td align="center">{$T.Result.brandName}</td>
						<td align="center">
							{#if $T.Result.isSale == 'Y'}<span class="label label-success graded"> 可售</span>
							{#elseif $T.Result.isSale == 'N'}<span class="label label-darkorange graded"> 不可售</span>
							{#/if}
						</td>
		       		</tr>
				{#/for}
		    {#/template MAIN}	-->
		</textarea>
	</p>
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
															id="YTtype" style="width: 70%; height: 32px; float: right;"
															 disabled="disabled"></select>
														<input type="hidden" id="YTtype_" name="type" />
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
														<label class="control-label"><font id="erpCode_font_"
															style="color: red;">*</font>扣率码：</label> <select
															id="erpProductCode" onchange="erpProductCodeChange();"
															name="erpProductCode" style="width: 70%; height: 32px; float: right;"></select>
													</div>
													<!-- <div class="col-md-4" id="divRate">
														<label class="control-label">扣率：</label> <input
															class="form-control" id="rate" name="rate"
															style="width: 70%; float: right;" readonly />
													</div> -->
													<div class="col-md-4" id="divJyType">
														<label class="control-label">经营方式：</label> <select
														    id="manageType" style="width: 70%; height: 32px; float: right;"></select>
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
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
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
														<label class="col-md-4 control-label" >统计分类</label>
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
														&nbsp;
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
														<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>专柜商品名称：</label>
														<div class="col-md-8">
															<input class="form-control" id="productName"
																name="productName"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=20 style="width: 100%" />
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" style="padding: 0;">
														<label class="col-md-4 control-label" style="padding: 8px 0;"><font
															style="color: red;">*</font>专柜商品简称：</label>
														<div class="col-md-8">
															<input class="form-control" id="productAbbr"
																name="productAbbr"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=20  style="width: 100%"/>
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" style="padding: 0;">
														<label class="col-md-4 control-label" style="padding: 8px 0;"><font
															style="color: red;">*</font>销售单位：</label>
														<div class="col-md-8">
															<select id="unitCode" name="unitCode" style="width: 100%;height: 32px;margin-bottom: 4px;"></select>
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" id="discountLimitDiv" style="padding: 0">
														<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>折扣底限：</label>
														<div class="col-md-8">
															<input class="form-control" id="discountLimit"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																onpaste="return false;" maxLength=5 name="discountLimit" style="width: 100%"/>
														</div>
														&nbsp;
													</div>
													<input type="hidden" id="isAdjustPriceInput" name="isAdjustPrice" value="1">
													<input type="hidden" id="s" name="isPromotion" value="1">
													
													<div class="col-md-4" id="divProcessingType" style="padding: 0">
														<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>加工类型：</label>
														<div class="col-md-8">
															<select id="processingType" name="processingType"
																style="width: 100%;height: 32px;">	
															</select>
														</div>
														&nbsp;
													</div>
													<div class="col-md-4" id="modelNumDiv" style="padding: 0;">
														<label class="col-md-4 control-label" style="padding: 8px 0;"><font
															style="color: red;">*</font>货号：</label>
														<div class="col-md-8">
															<input class="form-control" id="modelNum"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																onpaste="return false;" maxLength=20 name="modelNum" style="width: 100%"/>
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
														style="overflow-y: auto; width: 100%;margin:0;">
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
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>物流类型：</label>
															<div class="col-md-8" style="height:36px;">
															    <select id="tmsParam" name="tmsParam" style="width: 100%;height: 32px;">
															    	<option value="1" code="Z001">液体</option>
															    	<option value="2" code="Z002">易碎</option>
															    	<option value="3" code="Z003">液体与易碎</option>
															    	<option value="4" code="Z004">粉末</option>
															    </select>
															</div>
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>基本计量单位：</label>
															<div class="col-md-8">
																<input class="form-control" id="baseUnitCode"onpaste="return false;"
																	name="baseUnitCode" style="width: 100%"/>
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>原产国：</label>
															<div class="col-md-8">
																<input class="form-control" id="originCountry" onpaste="return false;"
																	maxLength=20 name="originCountry" style="width: 100%"/>
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>原产地：</label>
															<div class="col-md-8">
																<input class="form-control" id="countryOfOrigin" onpaste="return false;"
																	maxLength=20 name="countryOfOrigin" style="width: 100%"/>
															</div>
															&nbsp;
														</div>
														<div class="col-md-4"  style="padding: 0">
															<label class="col-md-4 control-label" style="padding: 8px 0"><font
															style="color: red;">*</font>赠品范围：</label>
															<div class="col-md-8">
																<input class="form-control" id="isGift" onpaste="return false;"
																	maxLength=20 name="isGift" style="width: 100%"/>
															</div>
															&nbsp;
														</div>
														
														<!-- <div class="col-md-4" style="padding: 0">
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
														
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">虚库标志：</label>
															<div class="col-md-8">
															    <label class="control-label"> <input
																    type="checkbox" value="on" id="stockMode" onclick="isCheckButton('stockMode')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="stockModeInput"
																    name="stockMode" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">可COD：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																    type="checkbox" value="on" id="isCod" onclick="isCheckButton('isCod')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="isCodInput"
																    name="isCod" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">可贺卡：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																    type="checkbox" id="isCard" value="on" onclick="isCheckButton('isCard')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="isCardInput"
																    name="isCard" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">可包装：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																    type="checkbox" id="isPacking" value="on" onclick="isCheckButton('isPacking')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="isPackingInput"
																    name="isPacking" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4"  style="padding: 0">
															<label class="col-md-4 control-label" style="padding: 8px 0">是否有原厂包装：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																    type="checkbox" id="isOriginPackage" value="on" onclick="isCheckButton('isOriginPackage')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="isOriginPackageInput"
																    name="isOriginPackage" value="1">
															</div>
															&nbsp;
														</div>
														<div class="col-md-4" style="padding: 0" >
															<label class="col-md-4 control-label" style="padding: 8px 0">先销后采：</label>
															<div class="col-md-8">
																<label class="control-label"> <input
																    type="checkbox" id="xxhcFlag" value="on" onclick="isCheckButton('xxhcFlag')"
																    class="checkbox-slider toggle yesno"> <span
																    class="text"></span>
															    </label> <input type="hidden" id="xxhcFlagInput"
																    name="xxhcFlag" value="1">
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
										<input type="hidden" id="skuSid" name="skuSid" /> <input
											type="hidden" id="skuName" name="skuName" /> <input
											type="hidden" id="tmlist" name="barcodes" />
									</div>
									<!-- /yincangDiv -->
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input type="button" class="btn btn-success"
												style="width: 25%;" id="proSave" value="保存">&emsp;&emsp;
											<input onclick="closeProDiv();clearAll();" class="btn btn-danger"
												style="width: 25%;" id="close" type="button" value="取消" />
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
	
	<!-- <div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;z-index: 9999"
		id="selectBrandGroup">
		<div class="modal-dialog"
			style="width: 600px; height: auto; margin: 50px auto;">
			<div class="modal-content" style="width: 600px;">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBrandGroup();">×</button>
					<h4 class="modal-title" id="divTitle">请双击选择集团品牌</h4>
				</div>
				<div class="page-body" id="pageBodyBrandGroup"></div>
			</div>
		</div>
	</div> -->
	
	<!-- /Page Body -->
	<!-- 成功 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="proSaveSuccess">
		<div class="modal-dialog" style="margin: 150px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<i class="glyphicon glyphicon-check"></i>
				</div>
				<div class="modal-body" id="proSaveSuccess2">添加成功!</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="proSaveSuccess()">确定</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /成功 -->
	<!-- 成功2 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="iframeSuccess2">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<i class="glyphicon glyphicon-check"></i>
				</div>
				<div class="modal-body" id="modal-body-success">保存成功</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="iframeSuccessBtn2()">确定</button>
				</div>
			</div>
			<!-- / .modal-content -->
		</div>
		<!-- / .modal-dialog -->
	</div>
	<!-- /成功2 -->
	<!-- 失败 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-warning fade" id="proWarning">
		<div class="modal-dialog" style="margin: 150px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<i class="fa fa-warning"></i>
				</div>
				<div class="modal-body" id="model-body-proWarning">操作失败</div>
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