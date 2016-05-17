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
<style>
	.btn:active,.btn.active {
 		box-shadow:  0 0px 0px rgba(0,0,0)
	}
</style>
<title>商品基本信息</title>
<!--图片上传
<link href="${pageContext.request.contextPath}/js/stream/css/stream-v1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/stream/js/stream-v1.js"></script>-->


<script type="text/javascript">
	$("#li_show a").click(function() {
		loadColors();
	});

	__ctxPath = "${pageContext.request.contextPath}";

	//--Bootstrap Date Picker--
	$('.date-picker').datepicker();
	$("#li_pro a").attr("data-toggle", " ");
	$("#li_profile a").attr("data-toggle", " ");
	$("#li_show a").attr("data-toggle", " ");

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
		var currentNode = treeNode;
		while(!currentNode.pId==0){			
			currentNode = currentNode.getParentNode();
			pathName = currentNode.name + " > " + pathName;
		}
		if (!treeNode.checked) {
			$("#div_" + treeNode.tId).remove();
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
					// Tree统计分类
					tjTreeDemo();
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
												"loading-inactive")
									}, 300);
								},
								success : function(response) {
									cData_change2 = response[0].c;
									var option = "<div style='overflow-y: auto;width:100%;' id='div_"
											+ treeNode.tId
											+ "' name='div_sppv'>"
											+ "<span style='width:100%;'>"
											+ pathName + "</span>";
									for (var i = 0; i < cData_change2.length; i++) {
										var c = cData_change2[i];

										option += "<ol id='rightdd-list_"+c.propsSid+"' class='dd-list' style='cursor: pointer;'>"
												+ "<li class='dd-item bordered-danger'>"
												+ "<div class='dd-handle'>"
												+ "<div class='col-md-6' name='rightpropName'>"
												+ "<span style='color:red;'>";
										if(c.notNull==1){
											option += "* &nbsp";
										}
										else{
											option += "  &nbsp;";
										}
										option += "</span>" + c.propsName
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
														+ values.valuesName
														+ "</option>";
											}
											option += "</select>";
										}
										option += "</div>";
												
										if(c.notNull==0){
											option +=  "<div class='col-md-1'>"
											        +"<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("
												    + c.propsSid
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
									$("#rightddlist").append(option);
								}
							});
				} else {// 统计分类
					$("#tjA").html(treeNode.name);
					$("#finalClassiFicationCode").val(treeNode.id);
					$("#tjTreeDown").attr("treeDown", "true");
					// 查询色系
					fingColorDict();
					/* 查询类型字典 */
					findModelNum();
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
				// Tree统计分类
				tjTreeDemo();
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
											"loading-inactive")
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
				// 查询色系
				fingColorDict();
				/* 查询类型字典 */
				findModelNum();
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
				"shopSid" : $("#shopCode").find("option:selected").attr(
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
				$.fn.zTree.init($("#rightTreeDemo"), setting2, response);
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
					url : __ctxPath + "/shoppe/queryShoppe",
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
						"businessTypeSid" : $("#manageTypeForm").val(),
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
												"<option industryConditionSid='"+ele.industryConditionSid+"' value='"+ele.sid+"'>"
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
						"shopSid" : $("#shopCode").find("option:selected")
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
								option.appendTo(proTypeSid);
							} else {
								var option = $("<option value='" + ele.sid + "'>"
										+ ele.typeName + "</option>");
								option.appendTo(proTypeSid);
							}
						}
						return;
					}
				});
	}
	/* 门店列表 */
	function findShop() {
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/organization/queryOrganizationZero",
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
						"storeType" : 0,
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
						$("#proShopCode").append(option);
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
	// 查询所有集团品牌
	function findBrand() {
		$("#BrandCode").html("");
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
	}
	/* 门店点击后查询门店品牌方法 */
	function findShopBrand() {
		$("#shopBrandCode").html("");
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/product/selectAllBrand",
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
						"shopCode" : $("#proShopCode").find("option:selected")
								.attr("storeCode")
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
				"codes" : "xsdw,splx,jglx,tmlx,yt"
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
		findBrand();
		// 控制tree
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
		$("#isAdjustPrice").click(function() {
			isAdjustPrice();
		});
		$("#isPromotion").click(function() {
			isPromotion();
		});
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
										for (var j = 0; j < jglx.length; j++) {
											var ele = jglx[j];
											var option = "<option value='"+ele.code+"'>"
													+ ele.name + "</option>";
											$("#processingType").append(option);
										}
									} else {
										break;
									}
								}
								/* 查询专柜列表 */
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
		$("#YTtype").change(
			function() {
				var YTtype = $(this).val();
				
				if(YTtype==1){						
					$("#tmDiv_font").show();				
				}
				else{
					$("#tmDiv_font").hide();
				}
                if(YTtype==-1){
					$("#yyDiv").html("合同信息<font id='yyDiv_font' style='color: red;'>(以下信息必填)</font>");					
					$("#dqdDiv_font").hide();
					  
					$("#divOfferNumber").hide();
					$("#ERP").hide();
					$("#materialNumber").show();
				}
                else{
                	$("#yyDiv").html("要约信息<font id='yyDiv_font' style='color: red;'>(以下信息必填)</font>");
                	$("#dqdDiv_font").show();
                	
                	$("#divOfferNumber").show();
                	$("#ERP").show();
                	$("#materialNumber").hide();
                }
				
				
		});	
		/* 门店品牌变更事件 */
		$("#shopBrandCode").change(function() {
			if ($(this).val() / 1 != -1) {
				supplierCodeClick();
				proTreeDemo();// Tree管理分类
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
		var now = true;
		var colorlist = new Array();
		var sizelist = new Array();
		$("td[name='baseTableTd_colorCode']").each(function() {
			colorlist.push($(this).html().trim());
		});
		$("td[name='baseTableTd_sizeCode']").each(function() {
			sizelist.push($(this).html().trim());
		});
		for (var i = 0; i < colorlist.length; i++) {
			if ((colorlist[i] + sizelist[i]) == ($("#colorCode").val().trim() + $(
					"#sizeCode").val().trim())) {
				now = false;
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
			if (!now) {
				$("#warning2Body").text("单品信息已存在!");
				$("#warning2").show();
				return;
			}
			option = "<tr id='baseTableTr_"+proColorSid+"'><td style='text-align: center;'>"
					+ "<div class='checkbox'>"
					+ "<label style='padding-left: 5px;'>"
					+ "<input type='checkbox' id='baseTableTd_colorSid_"+proColorSid+"' value='"+proColorSid+"'  name='baseTableTd_proColorSid'>"
					+ "<span class='text'></span>"
					+ "</label>"
					+ "</div></td>"
					+ "<td style='text-align: center;'>"
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
						+ "<input type='checkbox' id='baseTableTd_colorSid_"+count+"' value='"+count+"' name='baseTableTd_proColorSid'>"
						+ "<span class='text'></span>"
						+ "</label>"
						+ "</div></td>"
						+ "<td style='text-align: center;'>"
						+ proColorText
						+ "</td>"
						+ "<td style='text-align: center;' name='baseTableTd_featrues'>"
						+ $("#featrues").val().trim()
						+ "</td>"
						+ "<td style='text-align: center;' name='baseTableTd_sizeCode'>"
						+ $("#sizeCode").val().trim() + "</td></tr>";
			} else {
				option = "<tr id='baseTableTr_"+proColorSid+"'><td style='text-align: center;'>"
						+ "<div class='checkbox'>"
						+ "<label style='padding-left: 5px;'>"
						+ "<input type='checkbox' id='baseTableTd_colorSid_"+proColorSid+"' value='"+proColorSid+"' name='baseTableTd_proColorSid' >"
						+ "<span class='text'></span>"
						+ "</label>"
						+ "</div></td>"
						+ "<td style='text-align: center;'>"
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
	function initProduct() {
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
						param : 'spuCode=' + $("#spuSid_from").val(),
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						callback : function(data) {
							$("#product_tab tbody").setTemplateElement(
									"product-list").processTemplate(data);
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
		$("#divOfferNumber").show();
		var manageType = $("#manageType").val();
		if (manageType == -1) {
			$("#divOfferNumber").hide();
			$("#divInputTax").hide();
			$("#divOutputTax").hide();
			$("#divConsumptionTax").hide();
			$("#divRate").hide();
			return;
		}
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
						"manageType" : manageType
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
		if (manageType == 2 && $("#YTtype").val() == 0) {// 百货联营
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
		}
	}
	// 要约号改变事件
	function offerNumberChange() {
		$("#erpProductCode").html("");
		var option = "<option value='-1'>请选择</option>";
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
							$("#spuSid_from").val(response.data);
							initProduct(response.data);
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
							$("#tjA").attr("disabled", "disabled");
							$("#tjTreeDown").attr("disabled", "disabled");
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
							/* 放开234tab */
							$("#li_pro a").attr("data-toggle", "tab");
							$("#li_profile a").attr("data-toggle", "tab");
							$("#li_show a").attr("data-toggle", "tab");
							rightTreeDemo();
							$("#li_show a").click(function() {
								loadColors();
							});
							
							if($("#type").val()==0){
								$("#TeShutype").html("色码");
							}else if($("#type").val()==1){s
								$("#TeShutype").html("特性");
							}
							
							
						} else {
							$("#warning2Body").text(response.data.errorMsg);
							$("#warning2").show();
						}
						return;
					},
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
		
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/product/saveShoppeProduct",
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
						if (response.success == 'true') {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'><strong>添加成功</strong></div>");
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
										"loading-inactive")
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
		$("#divInputTax").hide();
		$("#divOutputTax").hide();
		$("#divConsumptionTax").hide();
		$("#divRate").hide();
		$("#divOfferNumber").hide();
		$("#proDivTable").hide();
		$("#skuSid").val(data);
		$("#manageType").prop("disabled", "disabled");
		$("#kh").text($("#productNum").val());
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
			$(".rightyz").each(function() {
				if ($(this).val() == -1) {
					yz++;
				}
			});
			if (yz == 0) {
				var sppvs = new Array();
				var sppvsLenght = $("div[name='div_sppv']").length;

				$("div[name='div_sppv']")
						.each(
								function(i) {
									var div_id = $(this).attr("id");
									var div_cache = div_id.split("_")[1] + "_"
											+ div_id.split("_")[2];

									var propName = new Array();
									var propSid = new Array();
									var valueSid = new Array();
									var valueName = new Array();
									var parameters = new Array();
									var dataLength = $(this).find(
											"div[name='rightpropName']").length;
									// 整理属性名
									$(this)
											.find("div[name='rightpropName']")
											.each(
													function(i) {
														propName.push($(this)
																.html().trim());
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
							data : {"jsonPara":sppvsJSON},
							ajaxStart : function() {
								$("#loading-container").attr("class",
										"loading-container");
							},
							ajaxStop : function() {
								setTimeout(function() {
									$("#loading-container").addClass(
											"loading-inactive")
								}, 300);
							},
							success : function(response) {
								if (response.success == 'true') {
									$("#iframeSuccess2")
											.attr(
													{
														"style" : "display:block;",
														"aria-hidden" : "false",
														"class" : "modal modal-message modal-success"
													});
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
				$("#warning2Body", parent.document).text("枚举属性存在未选择!");
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
		if ($("#prodCategoryCode").val() == "") {
			$("#warning2Body").text("请选择工业分类");
			$("#warning2").show();
			return false;
		}
		if ($("#finalClassiFicationCode").val() == "") {
			$("#warning2Body").text("请选择统计分类");
			$("#warning2").show();
			return false;
		}
		if ($("#type").val() == 0) {
			if ($("#productNum").val() == "") {
				$("#warning2Body").text("请填写款号");
				$("#warning2").show();
				return false;
			}
		} else {
			if ($("#mainAttribute").val() == "") {
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
	function requiredProForm(){//校验
		
		if($("#proShopCode").val()==-1){
		    $("#warning2Body").text("请选择门店");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#shopBrandCode").val()==-1){
		    $("#warning2Body").text("请选择门店品牌");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#supplierCode").val()==-1){
		    $("#warning2Body").text("请选择供应商");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#counterCode").val()==-1){
		    $("#warning2Body").text("请选择专柜");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#manageCateGory").val()==""){
		    $("#warning2Body").text("请选择管理分类");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#productName").val()==""){
		    $("#warning2Body").text("请填写专柜商品名称");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#productAbbr").val()==""){
		    $("#warning2Body").text("请填写专柜商品简称");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#unitCode").val()==-1){
		    $("#warning2Body").text("请选择销售单位");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#discountLimit").val()==""){
		    $("#warning2Body").text("请填写折扣底限");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#processingType").val()==-1){
		    $("#warning2Body").text("请选择加工类型");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#marketPrice").val()==""||$("#marketPrice").val()==0){
		    $("#warning2Body").text("请填写吊牌价");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#salePrice").val()==""||$("#salePrice").val()==0){
		    $("#warning2Body").text("请填写销售价");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		if($("#inventory").val()==""||$("#inventory").val()==0){
		    $("#warning2Body").text("请填写可售库存");
		    $("#warning2").attr("style","z-index:9999");
			$("#warning2").show();
			return false;
		}
		
		if($("#YTtype").val()==1){//超市
			if($("#offerNumber").val()==-1){
			    $("#warning2Body").text("请选择要约号");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
			if($("#manageType").val()==3){
			    if($("#erpProductCode").val()==-1){
				    $("#warning2Body").text("请选择ERP编码");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			    if($("#rate").val()==""){
				    $("#warning2Body").text("请填写扣率");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			}else{
			    if($("#inputTax").val()==""){
				    $("#warning2Body").text("请填写进项税");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			    if($("#consumptionTax").val()==""){
				    $("#warning2Body").text("请填写销项税");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			}
			if($("#proTable").find("tbody").html().trim()==""){
			    $("#warning2Body").text("请新增条码");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
			// 整理条码
			var tm = tmJson();
			if(tm.length==0){
			    $("#warning2Body").text("条码未填写或存在空值");
				$("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return;
			}
			$("#tmlist").val(tm);
		}else if($("#YTtype").val()==-1){//电商
			if($("#entryNumber").val()==""){
			    $("#warning2Body").text("请填写录入人员编号");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
			if($("#procurementPersonnelNumber").val()==""){
			    $("#warning2Body").text("请填写采购人员编号");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
			if($("#inputMat").val()==""){
			    $("#warning2Body").text("请填写物料号");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
		}else if($("#YTtype").val()==0){//百货
			if($("#offerNumber").val()==-1){
			    $("#warning2Body").text("请选择要约号");
			    $("#warning2").attr("style","z-index:9999");
				$("#warning2").show();
				return false;
			}
			// 百货联营 
			if($("#YTtype").val()==0&&$("#manageType").val()==3){
			    if($("#erpProductCode").val()==-1){
				    $("#warning2Body").text("请选择ERP编码");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			    if($("#rate").val()==""){
				    $("#warning2Body").text("请填写扣率");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			}else{
			    if($("#inputTax").val()==""){
				    $("#warning2Body").text("请填写进项税");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			    if($("#consumptionTax").val()==""){
				    $("#warning2Body").text("请填写销项税");
				    $("#warning2").attr("style","z-index:9999");
					$("#warning2").show();
					return false;
			    }
			}
		}
    	return true;
	} 
</script>

<script type="text/javascript">
	function loadColors() {
		$("#show").load("${pageContext.request.contextPath}/upImg/loadColors",
				{
					"proSid" : $('#spuSid_from').val()
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
																style="width: 100%"></select>
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
																	id="baseA" style="width: 87%;">请选择</a> <a id="treeDown"
																	href="javascript:void(0);" class="btn btn-default"
																	treeDown="true"><i class="fa fa-angle-down"></i></a>
																<ul id="treeDemo" class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 98%; position: absolute;"></ul>
																<input type="hidden" id="prodCategoryCode"
																	name="prodCategoryCode" />
															</div>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-3 control-label">统计分类</label>
														<div class="col-md-9">
															<div class="btn-group" style="width: 100%"
																id="tjBtnGroup">
																<a href="javascript:void(0);" class="btn btn-default"
																	id="tjA" style="width: 87%;">请选择</a> <a id="tjTreeDown"
																	href="javascript:void(0);" class="btn btn-default"
																	treeDown="true"><i class="fa fa-angle-down"></i></a>
																<ul id="tjTreeDemo"
																	class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 98%; position: absolute;"></ul>
																<input type="hidden" id="finalClassiFicationCode"
																	name="finalClassiFicationCode" />
															</div>
														</div>
														&nbsp;
													</div>
													<div class="col-md-6" id="productNumDiv">
														<label class="col-md-3 control-label">款号</label>
														<div class="col-md-9">
															<input type="text" class="form-control" onpaste="return false;" id="productNum"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																onkeyup="value=value.replace(/[^0-9- ]/g,'');"
																maxLength=20 placeholder="只能为数字并且长度小于20"
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
													<div class="col-md-6">
														<label class="col-md-3 control-label">类型</label>
														<div class="col-md-9">
															<select id="proTypeSid" name="proTypeSid"
																style="width: 100%"></select>
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
													<div class="col-md-3">
														<label class="col-md-4 control-label">色系</label>
														<div class="col-md-8">
															<select class="form-control" id="proColor">
																<option value="">请选择</option>
															</select>
														</div>
													</div>
													<div class="col-md-3" id="colorCodeDiv">
														<label class="col-md-4 control-label">色码</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="colorCode"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=10 />
														</div>
													</div>
													<div class="col-md-3" id="featruesDiv">
														<label class="col-md-4 control-label">特性</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="featrues"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=10 />
														</div>
													</div>
													<div class="col-md-3" id="sizeCodeDiv">
														<label class="col-md-4 control-label">规格</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="sizeCode"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=10 />
														</div>
													</div>
													<div class="col-md-3">
														<div class="col-md-12 buttons-preview">
															<a class="btn btn-default" id="addSku"
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
													<div class="well with-header with-footer" style="height:600px;">
														<div class="header bordered-pink">
															<code>商品列表</code>
														</div>
														<div class="table-scrollable">
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
														<div class="footer">
															<form id="product_form" action="">
																<input type="hidden" id="spuSid_from" name="spuCode"
																	value="200000136" /> <input type="hidden"
																	id="sxColorCode_from" name="sxColorCode" value="" /> <input
																	type="hidden" id="sxStanCode_from" name="sxStanCode"
																	value="" />
															</form>
															<div id="productPagination"></div>
														</div>
													</div>
												</div>
												<div class="col-xs-12 col-md-6">
													<div class="well with-header with-footer" style="height:600px;">
														<div class="header bordered-success" style="padding:0;">
															<code style="margin:10px 10px 0 10px;float:left;">专柜商品列表</code>
															<a style="margin:3px 17px;float:right;" class="btn btn-default purple" id="addZGpro"
																onclick="addZGpro();">添加专柜商品</a>
														</div>
														
														<div class="table-scrollable">
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
																	<a class="btn purple btn-sm fa fa-star"
																		style="width: 99.9%;cursor:default;">&nbsp;展示分类树信息</a>
																</div>

																<div class="col-md-12">
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
																	style="overflow-y: scroll; max-height: 350px;">

																	<div class="col-md-12" id="rightddlist" style="overflow-y: auto;"></div>
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
							{#if $T.Result.colorCode==null}
							{#else}
								{$T.Result.colorCode}
							{#/if}
						</td>
						<td align="center" id="gg_{$T.Result.sid}">
							{$T.Result.stanCodfe}
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
						<td align="center">{$T.Result.glCategoryName}</td>
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
						style="overflow-x: hidden; overflow-y: auto; height: 420px;">
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
														<label class="control-label">业态：</label> <select
															id="YTtype" style="width: 70%; float: right;"
															onchange="manageTypeFunct();" disabled="disabled"></select>
														<input type="hidden" id="YTtype_" name="type" />
													</div>
													<div class="col-md-12">
														<hr class="wide"
															style="margin-top: 0; border-top: 0px solid #e5e5e5;">
													</div>
													<div class="col-md-4">
														<label class="control-label">供应商：</label> <select
															style="width: 70%; float: right;" id="supplierCode"
															name="supplierCode">
															<option value="-1">全部</option>
														</select>
													</div>
													<div class="col-md-4">
														<label class="control-label">专柜：</label> <select
															style="width: 70%; float: right;" id="counterCode"
															name="counterCode">
															<option value="-1">全部</option>
														</select>
													</div>
													<div class="col-md-4">
														<label class="control-label">经营方式：</label> <select
															id="manageType" style="width: 70%; float: right;"></select>
														<input type="hidden" id="manageTypeForm" name="manageType" />
													</div>
												</div>
											</div>
										</div>
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
													<a onclick="aClick(this.id);" id="yyDiv"
														class="accordion-toggle" style="cursor: pointer;">
														要约信息<font style="color: red;">(以下信息必填)</font>
													</a>
												</h4>
											</div>
											<div class="panel-collapse collapse in" id="yyDiv_1">
												<div class="panel-body border-red">
												    <div class="col-md-4" id="materialNumber">
														<label class="control-label">物料号：</label>
															<input type="text" class="form-control" id="inputMat" name="inputMat"
																 style="width: 70%;float: right;" 
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)" onpaste="return false;" maxLength=20
															/>
													</div>
													<div class="col-md-4" id="divOfferNumber">
														<label class="control-label"><font
															style="color: red;">*</font>要约号：</label> <select id="offerNumber"
															name="offerNumber" onchange="offerNumberChange();"
															style="width: 70%; float: right;">
															<option value="-1">请选择</option>
														</select>
													</div>
													<div class="col-md-4">
														<label class="control-label">ERP编码：</label> <select
															id="erpProductCode" onchange="erpProductCodeChange();"
															name="erpProductCode" style="width: 70%; float: right;"></select>
													</div>
													<div class="col-md-4" id="divRate">
														<label class="control-label">扣率：</label> <input
															class="form-control" id="rate" name="rate"
															style="width: 70%; float: right;" readonly />
													</div>
													<div class="col-md-12">
														<hr class="wide"
															style="margin-top: 0; border-top: 0px solid #e5e5e5;">
													</div>
													<div class="col-md-4" id="divInputTax">
														<label class="control-label">进项税：</label> <input
															type="text" class="form-control" id="inputTax"
															name="inputTax" style="width: 70%; float: right;"
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
															onpaste="return false;" maxLength=10 />
													</div>
													<div class="col-md-4" id="divOutputTax">
														<label class="control-label">消费税：</label> <input
															type="text" class="form-control" id="outputTax"
															name="outputTax" style="width: 70%; float: right;"
															onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
															onpaste="return false;" maxLength=10 />
													</div>
													<div class="col-md-4" id="divConsumptionTax">
														<label class="control-label">销项税：</label> <input
															type="text" class="form-control" id="consumptionTax"
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
														管理分类信息<font style="color: red;">(以下信息必填)</font>
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
																	id="proA" style="width: 85%;">请选择</a> <a
																	id="proTreeDown" href="javascript:void(0);"
																	class="btn btn-default" treeDown="true"><i
																	class="fa fa-angle-down"></i></a>
																<ul id="proTreeDemo"
																	class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 98%; position: absolute;"></ul>
																<input type="hidden" id="manageCateGory"
																	name="manageCateGory" />
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
														专柜商品信息<font style="color: red;">(以下信息必填)</font>
													</a>
												</h4>
											</div>
											<div class="panel-collapse collapse in" id="skuDiv_1">
												<div class="panel-body border-red">
													<div class="col-md-3">
														<label class="col-md-4">款号：</label>
														<div class="col-md-8">
															<span id="kh"></span>
														</div>
													</div>
													<div class="col-md-3" id="divYs">
														<label class="col-md-4">颜色：</label>
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
													<div class="col-md-3">
														<label class="col-md-4">规格：</label>
														<div class="col-md-8">
															<span id="gg"></span>
														</div>
														&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">专柜商品名称：</label>
														<div class="col-md-8">
															<input class="form-control" id="productName"
																name="productName"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=20 />
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">专柜商品简称：</label>
														<div class="col-md-8">
															<input class="form-control" id="productAbbr"
																name="productAbbr" style="width: 100%"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=20 />
														</div>
														&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">销售单位：</label>
														<div class="col-md-8">
															<select id="unitCode" name="unitCode" style="width: 100%"></select>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">折扣底限：</label>
														<div class="col-md-8">
															<input class="form-control" id="discountLimit"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																onpaste="return false;" maxLength=5 name="discountLimit"
																style="width: 100%" />
														</div>
														&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">是否允许ERP促销：</label>
														<div class="col-md-8">
															<label class="control-label"> <input
																type="checkbox" id="isAdjustPrice" value="on"
																class="checkbox-slider toggle yesno"> <span
																class="text"></span>
															</label> <input type="hidden" id="isAdjustPriceInput"
																name="isAdjustPrice" value="1">
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">是否允许ERP调价：</label>
														<div class="col-md-8">
															<label class="control-label"> <input
																type="checkbox" id="isPromotion" value="on"
																class="checkbox-slider toggle yesno"> <span
																class="text"></span>
															</label> <input type="hidden" id="isPromotionInput"
																name="isPromotion" value="1">
														</div>
														&nbsp;
													</div>
													<div class="col-md-6" id="divProcessingType">
														<label class="col-md-4 control-label">加工类型：</label>
														<div class="col-md-8">
															<select id="processingType" name="processingType"
																style="width: 100%">
																<option value="-1">全部</option>
																<option value="1">单品</option>
																<option value="2">分割原材料</option>
																<option value="3">原材料</option>
																<option value="4">成品</option>
															</select>
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
														</div>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label">销售价：</label>
														<div class="col-md-8">
															<input class="form-control" id="salePrice"
																onkeyup="clearNoNum(event,this)" onblur="checkNum(this)"
																onpaste="return false;" maxLength=20 name="salePrice"
																style="width: 100%" />
														</div>
													</div>
													<div class="col-md-4">
														<label class="col-md-4 control-label">可售库存：</label>
														<div class="col-md-8">
															<input class="form-control" id="inventory"
																name="inventory" style="width: 100%"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																onkeyup="value=value.replace(/[^0-9- ]/g,'');"
																maxLength=20 />
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
														其他信息 <font style="color: red;">(以下信息必填)</font>
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
														条码信息 <font style="color: red;">(以下信息必填)</font>
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
											<input onclick="closeProDiv();" class="btn btn-danger"
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