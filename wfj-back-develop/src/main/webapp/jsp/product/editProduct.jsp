<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
WFJBackWeb - 商品修改
Version: 1.0.0
Author: WangSy
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
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
<!-- 验证 -->
<script
	src="${pageContext.request.contextPath}/assets/js/validation/bootstrapValidator.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<style>
.notbtn {
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 2px;
	color: #444;
	font-size: 12px;
	line-height: 1.39;
	padding: 4px 9px;
	text-align: center;
	text-decoration: none;
}

.notbtn:hover {
	text-decoration: none;
}

.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control
	{
	cursor: pointer;
}
</style>

<!-- tree -->
<script type="text/javascript">
<!--
	var url = __ctxPath + "/category/getAllCategory";
	channelSid = 0;

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
			autoParam : [ "id", "channelSid", "shopSid", "categoryType" ],
			otherParam : {
				"productSid" : productDetail.spuSid
			},
			dataFilter : filter
		},
		callback : {
			onCheck : zTreeOnCheck,
			beforeClick : beforeClick,
			/* onClick : onClick, */
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
		/*  alert(treeNode.tId + ", " + treeNode.name + "," + treeNode.checked); */

		var categorySid = $("rightCategorySid" + treeNode.id);
		var categoryName = $("rightCategoryName" + treeNode.id);
		var channelSid = $("rightChannelSid" + treeNode.id);
		
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
									"productSid" : productDetail.spuSid
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
									var option = "<div style='overflow: auto;width:100%;' id='div_"
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
					option += "<input class='rightyz' name='"+ c.propsName +"' type='text' id='rightvalueInput_"
							+ category_id
							+ "' onchange='rightvalueInputChange("
							+ category_id
							+ ")' value='' style='padding: 0 12px;width: 100%;'/>";
				} else {
					option += "<input class='rightyz' name='"+ c.propsName +"' type='text' id='rightvalueInput_"
							+ category_id + "' onchange='rightvalueInputChange("
							+ category_id + ")' value='" + c.valueName
							+ "' style='padding: 0 12px;width: 100%;'/>";
				}
			} else {
				option += "<select class='rightyz' id='rightvalueSidSelect_"
						+ category_id
						+ "' name='" + c.propsName + "' onchange='rightvalueSelectChange(" + category_id + ")'"
						+ " style='padding: 0 12px;width: 100%;'>"
						+ "<option value='-1'>请选择</option>";
				for (var j = 0; j < c.values.length; j++) {
					var values = c.values[j];
					option += "<option valueSid='" + values.valuesSid
							+ "' value='" + values.valuesName + "'>"
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
						+ "' name='" + cp.propName + "' onchange='rightvalueSelectChange(" + category_id + ")'"
						+ "  style='padding: 0 12px;width: 100%;' >"
						+ "<option valueSid='-1' value='-1'>请选择</option>";
				for (var j = 0; j < cp.values.length; j++) {
					var values = cp.values[j];
					if (cp.valueSid == values.valuesSid) {
						option += "<option valueSid='" + values.valuesSid
								+ "' selected='selected' value='"
								+ values.valuesName + "'>" + values.valuesName
								+ "</option>";
					} else {
						option += "<option valueSid='" + values.valuesSid
								+ "' value='" + values.valuesName + "'>"
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

	$("#li_show a").click(function() {
		loadColors(0);
	});
	
	$("#shoppe_a").click(function() {
		//加载专柜商品
		$("#shoppe").load(__ctxPath + "/product/toShoppeProduct/" + productDetail.sid);
	});
	
	$("#profile_a").click(function() {
		findChannel();
		rightTreeDemo();
	});
	
	$("#li_FinePack a").click(function() {
		var status = $("#li_FinePack a").attr("data-toggle");
	  　　if(status == " "){
		  　　$("#warning2Body").text("请先上传图片！");
		　  　$("#warning2").show();
	  　　} else {
		   loadProPacking(0);
	  　　}
	});

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
			if (treeNode.categoryType == 3) {
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
								"productSid" : productDetail.spuSid
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
													+ ")' value='' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20 />";
										} else {
											option += "<input type='text' id='rightvalueInput_"
													+ cp.propSid
													+ "' onchange='rightvalueInputChange("
													+ cp.propSid
													+ ")' value='"
													+ cp.valueName
													+ "' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20 />";
										}
									} else {
										option += "<select class='yz' id='rightvalueSidSelect_"
												+ cp.propSid
												+ "' onchange='rightvalueSelectChange(" + cp.propSid + ")'"
												+ " style='padding: 0 12px;width: 100%;'>"
												+ "<option valueSid='-1' value='-1'>请选择</option>";
										for (var j = 0; j < cp.values.length; j++) {
											var values = cp.values[j];
											if (cp.valueSid == values.valuesSid) {
												option += "<option valueSid='"
														+ values.valuesSid
														+ "' selected='selected' value='"
														+ values.valuesName
														+ "'>"
														+ values.valuesName
														+ "</option>";
											} else {
												option += "<option valueSid='"
														+ values.valuesSid
														+ "' value='"
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
								$("#rightddlist").append(option += "&nbsp;");
							}
						});
				$("#rightbaseSave").removeAttr("disabled");
			}
			if (treeNode.categoryType == 2) {
				// 更换请选择汉字
				//$("#statcatebaseA").html(treeNode.name);
				//$("#statcateDown").attr("treeDown", "true");
				//$("#statCategoryName").val(treeNode.name);
				//$("#statCategorySid").val(treeNode.id);
				//$("#statIsLeaf").val(treeNode.isLeaf);
			}
			$("#rightbaseBtnGroup").attr("class", "btn-group");
			//$("#statcateBtnGroup").attr("class", "btn-group");
		} else {
			$("#warning2Body").text("请选择末级分类!");
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
	//格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动    
	function formatAsText(item) {
		var itemFmt = "<div style='display:inline'>" + item.name + "</div>";
		return itemFmt;
	}
//-->
</script>
<script type="text/javascript">
	function loadColors(mark) {
		$("#show").load("${pageContext.request.contextPath}/upImg/loadColors",
				{
					"proSid" : productDetail.spuCode,
					"mark" : mark
				});
	}
	
	function loadProPacking(mark) {
		$("#FinePack").load("${pageContext.request.contextPath}/productDesc/loadProPacking",
				{
					"proSid" : productDetail.spuCode,
					"mark" : mark
				});
	}
	//根据spuCode查询渠道

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
					"spuCode" : productDetail.spuCode
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
<script type="text/javascript">
var tabMark1 = "base";
$(function(){
	tabMark1 = tabMark;
	if(tabMark == "show"){
		loadColors(0);
	}
	if(tabMark == "shoppe"){
		$("#shoppe_a").click();
	}
	if(tabMark == "FinePack"){
		loadProPacking(0);
	}
	$('#' + tabMark + '_a').tab('show');
});
</script>
<script type="text/javascript">
/* $(window).unload(function(){
	 alert("Goodbye!");
}); */
var channelCodeList = new Array();
$(function(){
	
$("#featruesDiv").hide();
var yt,splx,sx;
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
		"codes" : "yt,splx,sx"
	},
	success : function(response) {
		dictResponse = response.data;
		for(var i=0;i<dictResponse.length;i++){
			if(dictResponse[i].yt != null){
				yt = dictResponse[i].yt;
			}
			if(dictResponse[i].sx != null){
				sx = dictResponse[i].sx;
			}
			if(dictResponse[i].splx != null){
				splx = dictResponse[i].splx;
			}
		}
	}
});
	__ctxPath = "${pageContext.request.contextPath}";
	$("#skuSid").val(productDetail.sid);
	$("#skuCode").val(productDetail.skuCode);
	$("#brandGroupName_lb").text(productDetail.brandGroupName);
	/* $("#YTtype_1").val(productDetail.industryCondition); */
	/* for(var i=0;i<yt.length;i++){
		if(productDetail.industryCondition==yt[i].code){
			$("#industryCondition_lb").text(yt[i].name);
			break;
		}
	} */
	for(var i=0;i<splx.length;i++){
		if(productDetail.proType==splx[i].code){
			$("#proType_lb").text(splx[i].name);
			break;
		}
	}
	for(var i=0;i<sx.length;i++){
		/* var option = "<option value='"+ sx[i].code +"'>"+ sx[i].name +"</option>";
		$("#proColor").append(option); */
		if($("td[id='colorName_" + sx[i].code +"']").html() == sx[i].code){
			$("td[id='colorName_" + sx[i].code +"']").html(sx[i].name);
		}
		$("td[id='colorName_null']").html("--");
	}
	//$("#statCategorySid").val(productDetail.statCategory);
	//$("#statCategoryName").val(productDetail.statCategoryName);
	//关键字和活动关键字
	$("#keyWord").val(productDetail.keyWord);
	$("#keyWordHidden").val(productDetail.keyWord);
	$("#searchKey").val(productDetail.searchKey);
	$("#searchKeyHidden").val(productDetail.searchKey);

	$("#spuSid_lb").text(productDetail.skuCode);
	$("#SkuColorSid").val(productDetail.colorSid);
	$("#colorName_lb").text(productDetail.colorName == null ? "--" : productDetail.colorName);
	$("#skuName_lb").text(productDetail.skuName);
	if(productDetail.colorSid != null){
		$("#baseTableTd_colorSid_0").val(productDetail.colorSid);
	}
	if(productDetail.primaryAttr != null && productDetail.primaryAttr != ""){
		$("#industryCondition_lb").text("是");
	    $("#primary_attrHidden").val(productDetail.primaryAttr);
	    $("#primary_attr").val(productDetail.primaryAttr);
		$("#khDiv").hide();
		$("#smDiv").hide();
		$("#zsxDiv").show();
		$("#txDiv").show();
		$("#baseTableTh_2").html("特性");
	    /* $("#featuresHidden").val(productDetail.features); */
	    $("#colorCode_lb").text(productDetail.features);
		$("#smDiv").hide();
		$("#txDiv").show();
	}else{
		$("#industryCondition_lb").text("否");
		$("#product_skuHidden").val(productDetail.modelCode);
		$("#product_sku").val(productDetail.modelCode);
		$("#khDiv").show();
		$("#smDiv").show();
		$("#zsxDiv").hide();
		$("#txDiv").hide();
		/* $("#colorCodeHidden").val(productDetail.colorCode); */
		$("#colorCode_lb").text(productDetail.colorCode);
		$("#smDiv").show();
		$("#txDiv").hide();
	}
	$("#stanCode_lb").text(productDetail.stanName);
	/* $("#stanCodeHidden").val(productDetail.stanName); */
	
	//加载工业属性值
    $.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/productprops/selectPropValueBySid",
					async : false,
					dataType : "json",
					data : {
						"cid" : productDetail.category,
						"productSid" : productDetail.spuSid
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
						response = response[0];
						var categoryPropsDiv = "";
						if(response.cp!=""||response.cp!==null){
							for(var i=0;i<response.cp.length;i++){
								if(response.cp[i].values == undefined) continue;
								categoryPropsDiv += "<div class='col-md-6'>"
								                  + "<input type='hidden' value='" + response.cp[i].propSid + "' name='propSidEdit'/>"
								                  + "<input type='hidden' value='" + response.cp[i].propName + "' name='propNameEdit'/>"
									              + "<label class='col-md-4 control-label'>"
								                  + response.cp[i].propName + "： </label>"
								                  + "<div class='col-md-6' style='margin-bottom: 20px;'>";
						        if(response.cp[i].values.length != 0 &&  response.cp[i].values != 'undefined'){
						        	categoryPropsDiv += "<select class='form-control' style='width:240px;' name='propValueEdit' mark='0' oldValue='" + response.cp[i].valueSid + "'>";
						        	for(var j=0;j<response.cp[i].values.length;j++){
						        		if(response.cp[i].values[j].sid==response.cp[i].valueSid){
							        		categoryPropsDiv += "<option value='" + response.cp[i].values[j].sid + "' selected='selected'>"
							        		                  + response.cp[i].values[j].valuesName + "</option>";
							        	}else{
							        		categoryPropsDiv += "<option value='"+response.cp[i].values[j].sid+"'>"
							        		                  + response.cp[i].values[j].valuesName + "</option>";
							        	}
						        	}
						        	categoryPropsDiv += "</select>";
						        }else{
						        	categoryPropsDiv += "<input class='form-control' style='width:240px;' value='" + response.cp[i].valueName + "' name='propValueEdit' mark='1' oldValue='" + response.cp[i].valueName + "'/>";
						        }
								categoryPropsDiv += "</div></div></div>";
							}
						}
						if(response.c!=""||response.c!==null){
							for(var i=0;i<response.c.length;i++){
								categoryPropsDiv += "<div class='col-md-6'>"
									              + "<input type='hidden' value='" + response.c[i].propsSid + "' name='propSidEdit'/>"
									              + "<input type='hidden' value='" + response.c[i].propsName + "' name='propNameEdit'/>"
						                          + "<label class='col-md-4 control-label'>"
					                              + response.c[i].propsName + "： </label>"
					                              + "<div class='col-md-6' style='margin-bottom: 20px;'>";
								if(response.c[i].isEnumProp == 0){
									categoryPropsDiv += "<select class='form-control' style='width:240px;' name='propValueEdit' mark='0' oldValue='-1'>"
									                  + "<option value='-1'>请选择</option>";
						        	for(var j=0;j<response.c[i].values.length;j++){
							        	categoryPropsDiv += "<option value='" + response.c[i].values[j].valuesSid + "'>"
							        		              + response.c[i].values[j].valuesName + "</option>";
						        	}
						        	categoryPropsDiv += "</select>";
								}else{
									categoryPropsDiv += "<input class='form-control' style='width:240px;' name='propValueEdit' mark='1' oldValue=''";
								}
								categoryPropsDiv += "</div></div></div>";
							}
						}
						$("#categoryPropsDiv").append(categoryPropsDiv);
					}
				});
	
	
	$("#prodCategoryCode").val(category_Sid);
	$("#categoryName").val(category_Name);
	$("#baseA").text(category_Name);
	//$("#statcatebaseA").text(statcate_Name);
	$("#spuCode_from").val(productSid);
});
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
	/* function statcatetreeDemo() {
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
				$.fn.zTree.init($("#statcateTreeDemo"), setting, response);
			}
		});
	} */
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
	fingColorDict();
	
</script>
<!-- <script type="text/javascript">
	$(function() {
		$('.form_datetime').datetimepicker({
			format : 'yyyy-mm-dd hh:ii:00',
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0,
			showMeridian : 1
		});
		$('.form_date').datetimepicker({
			format : 'yyyy-mm-dd hh:ii:00',
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			minView : 2,
			forceParse : 0
		});
		$('.form_time').datetimepicker({
			format : 'yyyy-mm-dd hh:ii:00',
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 1,
			minView : 0,
			maxView : 1,
			forceParse : 0
		});
	});

</script> -->
<script type="text/javascript">
	
	// 初始化
	$(function() {
		$("a[data-toggle='tab']").on('shown.bs.tab', function (e){
			tabMark1 = $(e.target).attr("id").split("_")[0];
		});
		findChannel();
		$("#baseA").attr("disabled", "disabled");
		$("#treeDown").attr("disabled", "disabled");
		$("#treeDemo").attr("disabled", "disabled");
		$("#loading-container").prop("class", "loading-container");
		// 控制tree
		rightTreeDemo();
		$("#righttreeDown").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#rightbaseBtnGroup").attr("class", "btn-group open");
			} else {
				$(this).attr("treeDown", "true");
				$("#rightbaseBtnGroup").attr("class", "btn-group");
			}
		});
		/* statcatetreeDemo(); */
		/* $("#statcatetreeDown").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				//$("#statcateBtnGroup").attr("class", "btn-group open");
			} else {
				$(this).attr("treeDown", "true");
				$("#statcateBtnGroup").attr("class", "btn-group");
			}
		}); */
		
		/* $("#base").bind('beforeunload',function(){
			return '您输入的内容尚未保存，确定离开此页面吗？';
		}); */

		// 绑定#base 保存按钮
		$("#baseSave").click(function() {
			baseSave();return false;
		});
		$("#rightbaseSave").click(function() {
			rightbaseSave();
		});
		$("#statcatebaseSave").click(function() {
			statcatebaseSave();
		});
		$("#close").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		});
		$("#shoppeclose").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		});
		$("#rightclose").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		});
		$("#statcateclose").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		});
		$("#loading-container").addClass("loading-inactive");

		
		function blurJiaoYan(id){
			if(id=='product_sku'||id=='primary_attr'){
				$("#"+id).blur(function(){
					if($(this).val() == $("#"+id+"Hidden").val()){
						$("#"+id+"_i").attr({
					        "style" : "display: none;margin: -25px 60px;color:red;",
					        "class" : "form-control-feedback glyphicon glyphicon-ok"
				        });
						return;
					}
					$.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/product/changeProductSkuBySKU",
						async : false,
						data : {
							skuCode : $("#skuCode").val(),
							productSku : $("#product_sku").val(),
							primaryAttr : $("#primary_attr").val()
						},
						dataType : "json",
						ajaxStart : function() {
							$("#loading-container").prop("class", "loading-container");
						},
						ajaxStop : function() {
							$("#loading-container").addClass("loading-inactive");
						},
						success : function(response) {
							if(response.success=='true'){
							    $("#"+id+"_i").attr({
								    "style" : "display: block;margin: -25px 60px;color:#33FF00;",
								    "class" : "form-control-feedback glyphicon glyphicon-ok"
							    });
							}else{
							    $("#"+id+"_i").attr({
							        "style" : "display: block;margin: -25px 60px;color:red;",
							        "class" : "form-control-feedback glyphicon glyphicon-remove"
						        });
							}
						}
					});
				});
			}/* else{
				$("#"+id).blur(function(){
					$.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/product/updateSkuColorStan",
						async : false,
						data : {
							"skuCode" : $("#skuCode").val(),
							"proStanSid" : $("#stanCode").val(),
							"proColorName" : $("#colorCode").val(),
							"features" : $("#features").val()
						},
						dataType : "json",
						ajaxStart : function() {
							$("#loading-container").prop("class", "loading-container");
						},
						ajaxStop : function() {
							$("#loading-container").addClass("loading-inactive");
						},
						success : function(response) {
							if(response.success=='true'){
								$("#"+id+"_i").attr({
								    "style" : "display: block;margin: -25px 100px;color:#33FF00;",
								    "class" : "form-control-feedback glyphicon glyphicon-ok"
							    });
							}else{
								$("#"+id+"_i").attr({
							        "style" : "display: block;margin: -25px 100px;color:red;",
							        "class" : "form-control-feedback glyphicon glyphicon-remove"
						        });
							}
						}
			        });
				}); 
			}*/
		}
		blurJiaoYan("product_sku");
		blurJiaoYan("primary_attr");
		/* blurJiaoYan("features");
		blurJiaoYan("colorCode");
		blurJiaoYan("stanCode"); */

	});
</script>

<script type="text/javascript">
    var isAddPro = 0;
    var messageList = new Array();
    var mark = true;
    var categoryIsUpdate = false;
    var mage = "";
    
    function baseSave(){
    	/* if($("#statCategorySid").val() != productDetail.statCategory){
    		var cateSid = $("#statCategorySid").val();
    		var cateName = $("#statCategoryName").val();
    		var ifLeaf = $("#statIsLeaf").val();
    		var activeTime = $("#activeTimes").val();
    		if (ifLeaf != "Y" || cateSid == null || cateSid == "") {
    			$("#warning2Body", parent.document).text("请选择统计分类末级节点");
    			$("#warning2", parent.document).attr("style", "z-index:9999");
    			$("#warning2", parent.document).show();
    			return;
    		} else if (activeTime == "" || activeTime == null
    				|| activeTime == "生效日期") {
    			$("#warning2Body", parent.document).text("请选择生效日期");
    			$("#warning2", parent.document).attr("style", "z-index:9999");
    			$("#warning2", parent.document).show();
    			return;
    		}else {
    		$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/productprops/updateStatCategory",
				dataType : "json",
				async : false,
				data : {
					cateSid : cateSid,
					spuSid : productSid2,
					activeTime : activeTime
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
				    messageList.push(response);
				},
				error : function() {
					mark = false;
				}
				});
    		}
	    } */
	    if($("#product_sku").val() != $("#product_skuHidden").val()
			   || $("#primary_attr").val() != $("#primary_attrHidden").val()){
	    	
	    	var skuSid = $("#skuSid").val();
			var skuCode = $("#skuCode").val();
			var primaryAttr = $("#primary_attr").val();
			var productSku = $("#product_sku").val();
			$.ajax({
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
					messageList.push(response);
				},
				/* error : function() {
					mark = false;
				} */
				error : function(XMLHttpRequest, textStatus) {		      
					var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
					if(sstatus != "sessionOut"){
						mark = false;
					}
					if(sstatus=="sessionOut"){     
		            	 $("#warning3").css('display','block');     
		             }
				}
			});
	    }
	    if($("#searchKey").val() != $("#searchKeyHidden").val()
				   || $("#keyWord").val() != $("#keyWordHidden").val()){
		    	
		    	var searchKey = $("#searchKey").val();
				var keyWord = $("#keyWord").val();
				var skuSid = $("#skuSid").val();
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/product/updateSkuInfoBySid",
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
						"skuSid" : skuSid,
						"searchKey" : searchKey,
						"keyWord" : keyWord
					},
					success : function(response) {
						messageList.push(response);
					},
					/* error : function() {
						mark = false;
					} */
					error : function(XMLHttpRequest, textStatus) {		      
						var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
						if(sstatus != "sessionOut"){
							mark = false;
						}
						if(sstatus=="sessionOut"){     
			            	 $("#warning3").css('display','block');     
			             }
					}
				});
		    }
	    if(isAddPro != 0){
	    	
	    	var sppvs = new Array();
	    	var proColorSidList = new Array();
		    var proColorNameList = new Array();
		    var featuresList = new Array();
		    var proStanSidList = new Array();
		    var propLength = 0;
		    	
		    $("input[name='baseTableTd_proColorSid']").each(function(i) {
		    	proColorSidList.push($(this).val());
		    	propLength += 1;
			});
			$("td[name='baseTableTd_colorCode']").each(function(i) {
				proColorNameList.push($(this).html().trim());
			});
			$("td[name='baseTableTd_featrues']").each(function(i) {
				featuresList.push($(this).html().trim());
			});
			$("td[name='baseTableTd_sizeCode']").each(function(i) {
				proStanSidList.push($(this).html().trim());
				
			});
			
			var skuSid = $("#skuSid").val();
			if($("#YTtype_1").val() == 1){
				for (var i = 1; i < propLength; i++) {
			    	sppvs.push({
						'productSid' : productDetail.spuSid,
						'proColorSid' : proColorSidList[i],
						'features' : featuresList[i-1],
						'proStanSid' : proStanSidList[i]
					});
				}
			}else{
				for (var i = 1; i < propLength; i++) {
			    	sppvs.push({
						'productSid' : productDetail.spuSid,
						'proColorSid' : proColorSidList[i],
						'proColorName' : proColorNameList[i],
						'proStanSid' : proStanSidList[i]
					});
				}
			}
		    var spuJson = JSON.stringify(sppvs);
			//alert(spuJson);
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/product/addProByEdit",
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
					"spuList" : spuJson
				},
				success : function(response) {
					messageList.push(response);
					if(response.success=="true"){
						if(response.data.listInfo.length != 0){
							for(var ii=0; ii<response.data.listInfo.length; ii++){
								mage += response.data.listInfo[ii].Info + "\n";
							}
						}
					}
				},
				/* error : function() {
					mark = false;
				} */
				error : function(XMLHttpRequest, textStatus) {      
					var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
					if(sstatus != "sessionOut"){
						mark = false;
					}
					if(sstatus=="sessionOut"){     
		            	 $("#warning3").css('display','block');     
		             }
				}
			});
    	}
    	
	    $("[name='propValueEdit']").each(function(i) {
	        var newValue = $(this).val().trim();
	        var oldValue = $(this).attr("oldValue").trim();
	    	if(newValue != oldValue){
				categoryIsUpdate = true;
			}
	    });
	   if(categoryIsUpdate){
		    var sppvs = new Array();
	    	var propSidEdit = new Array();
	    	var propNameEdit = new Array();
	    	var propValueSidEdit = new Array();
	    	var propValueNameEdit = new Array();
	    	var parametersEdit = new Array();
	    	var propLength = 0;
	    	$("input[name='propSidEdit']").each(function(i) {
	    		propSidEdit.push($(this).val());
	    		propLength += 1;
			});
			$("input[name='propNameEdit']").each(function(i) {
    		    propNameEdit.push($(this).val());
		    });
			$("[name='propValueEdit']").each(function(i) {
				if($(this).attr("mark")=='0'){
					propValueSidEdit.push($(this).find("option:selected").val());
					propValueNameEdit.push($(this).find("option:selected").text().trim());
				}else{
					propValueSidEdit.push(null);
					propValueNameEdit.push($(this).val());
				}
		    });
	    	for (var i = 0; i < propLength; i++) {
	    		if(propValueSidEdit[i] == -1){
	    			
	    		}else if(propValueNameEdit[i] == ""){
	    			
	    		}else{
	    			parametersEdit.push({
						'propSid' : propSidEdit[i],
						'propName' : propNameEdit[i],
						'valueSid' : propValueSidEdit[i],
						'valueName' : propValueNameEdit[i] 
					});
	    		}
			}
	    	if(parametersEdit.length != 0){
	    		var inT = JSON.stringify(parametersEdit);
		    	
				inT = inT.replace(/\%/g, "%25");
				inT = inT.replace(/\#/g, "%23");
				inT = inT.replace(/\&/g, "%26");
				inT = inT.replace(/\+/g, "%2B");
				sppvs.push({
					"categoryType" : "0",
					"categorySid" : category_Sid,
					"spuSid" : productDetail.spuSid,
					"parameters" : inT,
					"categoryName" : $("#categoryName").val(),
					"channelSid" : "0"
				});
	            var sppvsJSON = JSON.stringify(sppvs);
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath
							+ "/productprops/addProductParameters",
					dataType : "json",
					async : false,
					data :{
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
						messageList.push(response);
					},
					/* error : function() {
						mark = false;
					} */
					error : function(XMLHttpRequest, textStatus) {		      
						var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
						if(sstatus != "sessionOut"){
							mark = false;
						}
						if(sstatus=="sessionOut"){     
			            	 $("#warning3").css('display','block');     
			             }
					}
				});
	    	}
	    }
	   
	    if(mark){
	    	var message = "";
	    	var isUpdated = false;
		    for(var jMark=0;jMark<messageList.length;jMark++){
		    	isUpdated = true;
		    	if(messageList[jMark].success == 'false'){
		    		message += messageList[jMark].data.errorMsg + "\n";
		    	}
		    }
		    if(isUpdated){
		    	if(message == ""){
		    		if(mage != ""){
		    			$("#modal-body-success1").html(mage);
		    		}
			        $("#edit-success").attr({
								"style" : "display:block;z-index:9999;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
			    }else{
			    	$("#warning2Body", parent.document).text(message);
					$("#warning2", parent.document).attr("style","z-index:9999");
					$("#warning2", parent.document).show();
			    }
		    }else{
		    	$("#warning2Body", parent.document).text("信息没有改变，不需修改！");
				$("#warning2", parent.document).attr("style","z-index:9999");
				$("#warning2", parent.document).show();
				return;
		    }
		    
	    }else{
	    	$("#warning2Body").text("系统出错");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
	    }
	    
    }
    
</script>

<script type="text/javascript">
	// 属性下拉框事件
	function valueSelectClick(data, valueSid) {
		// 赋值
		$("#valueSid_" + data).val(valueSid);
		$("#valueName_" + data).val($("#valueSidSelect_" + data).val());
	}
	function rightvalueSelectClick(data, valueSid) {
		// 赋值
		$("#rightvalueSid_" + data).val(valueSid);
		$("#rightvalueName_" + data).val(
				$("#rightvalueSidSelect_" + data).val());
	}
	// 属性文本框事件
	function valueInputChange(propSid) {
		// 赋值
		$("#valueSid_" + propSid).val(null);
		$("#valueName_" + propSid).val($("#valueInput_" + propSid).val());
	}
	function rightvalueInputChange(propSid) {
		// 赋值
		$("#rightvalueSid_" + propSid).val(null);
		$("#rightvalueName_" + propSid).val(
				$("#rightvalueInput_" + propSid).val());
	}
	// 复选框点击事件
	function checkboxClick(data) {
		if ($("#checkId_" + data).val() == 'on') {
			var option = "";
			for (var i = 0; i < cData_change.length; i++) {
				var c = cData_change[i];
				if (c.propsSid == data) {
					option += "<ol id='dd-list_"+data+"' class='dd-list' style='cursor: pointer;'>"
							+ "<li class='dd-item bordered-danger'>"
							+ "<div class='dd-handle'>"
							+ "<div class='col-md-6' name='propName'>"
							+ c.propsName
							+ "</div>"
							+ "<input type='hidden' value='"+c.propsSid+"' name='propSid'>"
							+ "<div class='col-md-5'>"
							+ "<input id='valueSid_"+c.propsSid+"' type='hidden' name='valueSid' value='"+c.valueSid+"'>"
							+ "<input id='valueName_"+c.propsSid+"' type='hidden' name='valueName' value='"+c.valueName+"'>";
					if (c.isEnumProp == 1) {
						if (c.valueName == undefined) {
							option += "<input type='text' id='valueInput_"
									+ c.propsSid
									+ "' onchange='valueInputChange("
									+ c.propsSid
									+ ")' value='' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
						} else {
							option += "<input type='text' id='valueInput_"
									+ c.propsSid
									+ "' onchange='valueInputChange("
									+ c.propsSid
									+ ")' value='"
									+ c.valueName
									+ "' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
						}
					} else {
						option += "<select class='yz' id='valueSidSelect_"
								+ c.propsSid
								+ "' style='padding: 0 12px;width: 100%;'>"
								+ "<option value='-1'>请选择</option>";
						for (var j = 0; j < c.values.length; j++) {
							var values = c.values[j];
							option += "<option  onclick='valueSelectClick("
									+ c.propsSid + "," + values.valuesSid
									+ ")' value='" + values.valuesName + "'>"
									+ values.valuesName + "</option>";
						}
						option += "</select>";
					}
					option += "</div>"
							+ "<div class='col-md-1'>"
							+ "<span class='btn btn-danger btn-xs' onclick='deleteDDlist("
							+ c.propsSid + ",2);'>删除</span>" + "</div>"
							+ "</div>" + "</li>" + "</ol>";
				}
			}
			$("#ddlist").append(option += "&nbsp;");
			$("#checkId_" + data).val("in");
		} else {
			$("#dd-list_" + data).remove();
			$("#checkId_" + data).val("on");
		}
	}
	// 删除事件
	function deleteDDlist(data, num) {
		if (num == 1) {
			$("#dd-list_" + data).remove();
		} else {
			$("#checkId_" + data).removeAttr("checked");
			$("#checkId_" + data).val("on");
			$("#dd-list_" + data).remove();
		}
	}
	//专柜商品启用或禁用
	function editStatus(productCode,status){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath
					+ "/product/UpdateProductStatusInfo",
			dataType : "json",
			data :{
				"productCode" : productCode,
				"status" : status
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
				if(response.success == 'true'){
					if(status == 1){
						$("#status_"+productCode).html(
								  "<a href='#' onclick='editStatus(" + productCode + ",0)'>"
								+ "<span class='label label-success graded' style='color:#000;'>启用</span></a>");
						$("#status_1_" + productCode)
				                .html("<span class='label label-darkorange graded'> 不可售</span>");
					}else{
						$("#status_"+productCode).html(
								  "<a href='#' onclick='editStatus(" + productCode + ",1)'>"
								+ "<span class='label label-lightyellow graded' style='color:#000;'>停用</span></a>");
						$("#status_1_" + productCode)
		                        .html("<span class='label label-success graded'> 可售</span>");
					}
				}else{
					$("#warning2Body").text("操作失败");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
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
<!-- 加载已经挂好的展示分类属性和属性值信息 -->
<script type="text/javascript">

    //加载已经挂好的展示分类属性和属性值信息
	var nativeCp;
	function clickSelect(cid, propSid) {
		$("#rightvalueSidSelect_" + propSid).removeAttr("onclick");
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/productprops/selectPropValueBySid",
					async : false,
					dataType : "json",
					data : {
						"cid" : cid,
						"productSid" : productDetail.spuSid
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
						nativeCp = response[0].cp;
						var option = "";
						for (var nativeCp_i = 0; nativeCp_i < nativeCp.length; nativeCp_i++) {
							if (nativeCp[nativeCp_i].propSid == propSid) {
								for (var j = 0; j < nativeCp[nativeCp_i].values.length; j++) {
									var values = nativeCp[nativeCp_i].values[j];
									if (nativeCp[nativeCp_i].valueSid == values.valuesSid) {
										option += "<option valueSid='"
												+ values.valuesSid
												+ "' selected='selected' value='"
												+ values.valuesName
												+ "'>"
												+ values.valuesName
												+ "</option>";
									} else {
										option += "<option valueSid='"
												+ values.valuesSid
												+ "' value='"
												+ values.valuesName
												+ "'>"
												+ values.valuesName
												+ "</option>";
									}
								}
							}

						}
						$("#rightvalueSidSelect_" + propSid).html(option);
					}
				});
	}
	$(function() {
		/* $("#rightbaseSave").attr("disabled","disabled"); */
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/productprops/selectPropValueBySid1",
					async : false,
					dataType : "json",
					data : {
						"spuSid" : productDetail.spuSid
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
						var listData = response.data;

						for (var list_i = 0; list_i < listData.length; list_i++) {
							var category = listData[list_i];
							var option = "<div style='overflow: auto;width:100%;' id='div_"
									+ category.categorySid
									+ "' name='div_sppv'>"
									+ "<span style='width:100%;'>"
									+ category.breadUrl + "</span>";

							var parametersList = category.parameters;

							for (var i = 0; i < parametersList.length; i++) {
								var cp = parametersList[i];

								option += "<ol id='rightdd-list_"+cp.propSid+"' class='dd-list' style='cursor: pointer;'>"
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
										+ "<input id='rightvalueSid_"+cp.propSid+"' type='hidden' name='rightvalueSid' value='"+cp.valueSid+"'>"
										+ "<input id='rightvalueName_"+cp.propSid+"' type='hidden' name='rightvalueName' value='"+cp.valueName+"'>";
								if (cp.valueSid == null) {
									if (cp.valueName == 'undefined') {
										option += "<input type='text' id='rightvalueInput_"
												+ cp.propSid
												+ "' onchange='rightvalueInputChange("
												+ cp.propSid
												+ ")' value='' style='padding: 0 12px;width: 100%;'  onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
									} else {
										option += "<input type='text' id='rightvalueInput_"
												+ cp.propSid
												+ "' onchange='rightvalueInputChange("
												+ cp.propSid
												+ ")' value='"
												+ cp.valueName
												+ "' style='padding: 0 12px;width: 100%;'  onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
									}
								} else {
									option += "<select onclick='clickSelect("
											+ category.categorySid
											+ ","
											+ cp.propSid
											+ ")' class='yz' id='rightvalueSidSelect_"
											+ cp.propSid
											+ "' onchange='rightvalueSelectChange(" + cp.propSid + ")'"
											+ " style='padding: 0 12px;width: 100%;' >"
											+ "<option valueSid='" + cp.valueSid
											+ "' selected='selected' value='"
											+ cp.valueName + "'>"
											+ cp.valueName + "</option>";

									option += "</select>";
								}
								option += "</div>";

								if (cp.notNull == 0) {
									option += "<div class='col-md-1'>"
											+ "<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("
											+ cp.propSid
											+ ",2);'>删除</span>"
											+ "</div>";
								}
								option += "</div>" + "</li>" + "</ol>";
							}
							option += "<div style='display: none;'>"
									+ "<input type='hidden' id='rightCategorySid" + category.categorySid + "' value='" + category.categorySid +"'/>"
									+ "<input type='hidden' id='rightCategoryName" + category.categorySid  + "' value='" + category.categoryName +"'/>"
									+ "<input type='hidden' id='rightChannelSid" + category.categorySid + "' value='" + category.channelSid +"'/>"
									+ "</div>" + "</div>";
							$("#rightddlist").append(option += "&nbsp;");

						}
					}
				});
	});
</script>
<!-- 展示分类 -->
<script type="text/javascript">
	function rightvalueSelectChange(data){
		var valueSid = $("#rightvalueSidSelect_" + data +" option:selected").attr("valueSid");
		rightvalueSelectClick(data, valueSid);
	}
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
	function rightcheckboxClick(data) {
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
							option += "<input type='text' class='rightyz' name='"+ c.propsName +"' id='rightvalueInput_"
									+ c.propsSid
									+ "' onchange='rightvalueInputChange("
									+ c.propsSid
									+ ")' value='' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
						} else {
							option += "<input type='text' class='rightyz' name='"+ c.propsName +"' id='rightvalueInput_"
									+ c.propsSid
									+ "' onchange='rightvalueInputChange("
									+ c.propsSid
									+ ")' value='"
									+ c.valueName
									+ "' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
						}
					} else {
						option += "<select class='rightyz' id='rightvalueSidSelect_"
								+ c.propsSid
								+ "' onchange='rightvalueSelectChange(" + c.propsSid + ")'"
								+ " style='padding: 0 12px;width: 100%;'>"
								+ "<option value='-1'>请选择</option>";
						for (var j = 0; j < c.values.length; j++) {
							var values = c.values[j];
							option += "<option  valueSid='"
									+ values.valuesSid
									+ "' value='"
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
	}
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
		if(productDetail.spuSale == 1){
			var aaa = productDetail.primaryAttr == undefined ? productDetail.modelCode : productDetail.primaryAttr;
			var noEditMessage = "产品" + productDetail.brandGroupName + " " + aaa
								+ "已上架！不能修改！";
			$("#warning2Body", parent.document).text(noEditMessage);
			$("#warning2", parent.document).attr("style", "z-index:9999");
			$("#warning2", parent.document).show();
			return;
		}
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
											'valueSid' : valueSid[i] == "null" ? null : valueSid[i],
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
												"spuSid" : productDetail.spuSid,
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
									$("#edit-success").attr({
										"style" : "display:block;z-index:9999;",
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
				$("#warning2Body", parent.document).text("属性（"+nameMeg.substring(0,nameMeg.length-1)+"）未选择或未填写!");
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

    function goProDetail(){
    	$("#edit-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
        $("#pageBody").load(__ctxPath + "/product/getProductDetail/" +productDetail.sid,
        		{
        	      "tabMark1" : tabMark1  
        		});
    }
    
	function iframeSuccessBtn() {
		$("#iframeSuccess").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#dd").html("");
		$("#ddlist").html("");
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
	function iframeSuccessBtn3() {
		$("#iframeSuccess3").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		// 	$("#rightdd").html("");
		// 	$("#rightddlist").html("");
	}
</script>

<script type="text/javascript"> 
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
	var proColorSid = "";
	var proColorText = "";
	var sizeCode = $("#sizeCode").val().trim();
	var colorCode = "";
	var featrues = "";
	
	proColorSid = $("#proColor").val();// 色系id
	proColorText = "";
	if (proColorSid != -1) {
		proColorText = $("#proColor").find("option:selected").text();// 色系文本
	}
	var option = "";
	if ($("#YTtype_1").val() == 0 || $("#YTtype_1").val() == 2) {// 百货
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
				+ sizeCode + "</td></tr>";
	} else {// 超市
		if ($("#primary_attr").val().trim() == "") {
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
					+ sizeCode + "</td></tr>";
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
					+ sizeCode + "</td></tr>";
		}
	}
	$("#baseTable tbody").append(option);
	isAddPro ++;
	$("#baseDivTable").show();
	return;
}
// 删除选中的SKU
function deleteSku() {
	$("input[type='checkbox']:checked").each(function() {
		$("#baseTableTr_" + $(this).val()).remove();
	});
	isAddPro --;
	return;
}
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
	$(function(){
		isShowFinePackimg();
	});
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
								<h5 class="widget-caption">商品修改</h5>
							</div>
							<div class="widget-body">
								<div class="tabbable">
									<ul class="nav nav-tabs" id="myTab">
										<li class="active" id="li_base"><a data-toggle="tab"
											id="base_a" href="#base"> <span>基本信息</span>
										</a></li>
										<li class="tab-red" id="li_shoppe"><a data-toggle="tab"
											id="shoppe_a" href="#shoppe"> <span>专柜商品</span>
										</a></li>
										<li class="tab-red" id="li_profile"><a data-toggle="tab"
											id="profile_a" href="#propfile"> <span>展示分类</span>
										</a></li>
										<li class="tab-red" id="li_show"><a data-toggle="tab"
											id="show_a" href="#show"> <span>图片修改</span>
										</a></li>
										<li class="tab-red" id="li_FinePack"><a data-toggle="tab"
											id="FinePack_a" href="#FinePack"> <span>精包装</span>
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
															<input id="skuSid" type="hidden" /> <input id="skuCode"
																type="hidden" /> <label id="brandGroupName_lb"
																class="control-label"></label>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">特殊属性：</label>
														<div class="col-md-8">
															<label id="industryCondition_lb" class="control-label"></label>
															<input type="hidden" id="YTtype_1" value="">
														</div>
														&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">工业分类：</label>
														<div class="col-md-8">
															<div class="btn-group" style="width: 100%"
																id="baseBtnGroup">
																<a href="javascript:void(0);" class="btn btn-default"
																	id="baseA" style="width: 70%;"></a> <a id="treeDown"
																	href="javascript:void(0);" class="btn btn-default"
																	treeDown="true"><i class="fa fa-angle-down"></i></a>
																<ul id="treeDemo" class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 96%; position: absolute;"></ul>
															</div>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">类型：</label>
														<div class="col-md-8">
															<label id="proType_lb" class="control-label"></label>
														</div>
														&nbsp;
													</div>
													<!-- <div class="col-md-6">
														<label class="col-md-4 control-label">统计分类：</label>
														<div class="col-md-8">
															<div class="btn-group" style="width: 100%"
																id="statcateBtnGroup">
																<a href="javascript:void(0);" class="btn btn-default"
																	id="statcatebaseA" style="width: 70%;"></a> <a
																	id="statcatetreeDown" href="javascript:void(0);"
																	class="btn btn-default" treeDown="true"><i
																	class="fa fa-angle-down"></i></a>
																<ul id="statcateTreeDemo"
																	class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 84%; position: absolute;"></ul>
															</div>
														</div>
														&nbsp;
													</div> -->

													<div class="col-md-6" id="khDiv">
														<label class="col-md-4 control-label">款号：</label>
														<div class="col-md-8">
															<input id="product_sku" name="product_sku"
																class="form-control" value=""
																onkeyup="value=value.replace(/[\u4E00-\u9FA5]/g,'');"
																oninput="value=value.replace(/[\u4E00-\u9FA5]/g,'');"
																maxLength=20 data-bv-notempty="true"
																data-bv-notempty-message="款号不能为空!" style="width: 240px;" />
															<i id="product_sku_i"
																style="display: none; margin: -25px 60px; color: #33FF00;"
																class="form-control-feedback glyphicon glyphicon-ok"></i>
															<input type="hidden" id="product_skuHidden" value="" />
														</div>
													</div>

													<div class="col-md-6" id="zsxDiv">
														<label class="col-md-4 control-label">主属性：</label>
														<div class="col-md-8">
															<input id="primary_attr" name="primary_attr"
																class="form-control" value="" maxLength=20
																data-bv-notempty="true"
																data-bv-notempty-message="主属性不能为空!"
																style="width: 240px;" /> <i id="primary_attr_i"
																style="display: none; margin: -25px 60px; color: #33FF00;"
																class="form-control-feedback glyphicon glyphicon-ok"></i>
															<input type="hidden" id="primary_attrHidden" value="" />
														</div>
													</div>
													<!-- <div class="col-md-6">
														<label class="col-md-4 control-label">统计分类生效日期：</label>
														<div class="col-md-8">
															<div class="input-group date form_date col-md-5"
																data-date="" data-date-format=""
																data-link-field="dtp_input2"
																data-link-format="yyyy-mm-dd" style="width: 97%;">
																<input class="form-control" type="text" id="activeTimes"
																	name="activeTime" onfocus="this.blur();"
																	placeholder="生效日期" readonly
																	style="height: 30px; width: 160px; text-align: center; position: relative;" />
																<span class="input-group-addon"
																	style="float: left; height: 30px; width: 40px;">
																	<span class="glyphicon glyphicon-remove"></span>
																</span> <span class="input-group-addon"
																	style="float: left; height: 30px; width: 40px;">
																	<span class="glyphicon glyphicon-calendar"></span>
																</span>
															</div>
														</div>
														&nbsp;
													</div>
													 -->
												</div>
												<div class="col-md-12" id="categoryPropsDiv">
													<h5>
														<strong>工业属性</strong>
													</h5>
													<hr class="wide" style="margin-top: 0;">

												</div>
												<div style="display: none;">
													<input type="hidden" id="prodCategoryCode"
														name="prodCategoryCode" /> <input type="hidden"
														id="categoryName" name="categoryName" /> <input
														type="hidden" id="spuCode_from" />
													<textarea id="parameters" name="parameters"></textarea>
												</div>

												<div class="col-md-12">
													<h5>
														<strong>商品信息</strong>
													</h5>
													<hr class="wide" style="margin-top: 0;">
													
													<div class="col-md-6" style="margin-bottom:20px;display: none;">
														<label class="col-md-4 control-label" style="width:100px;">关键字：</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="searchKey"
																maxLength=50 />
															<input type="hidden" id="searchKeyHidden" value="">
														</div>
													</div>
													<div class="col-md-6" style="margin-bottom:20px;display: none;">
														<label class="col-md-4 control-label" style="width:120px;">活动关键字：</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="keyWord"
																maxLength=50 />
															<input type="hidden" id="keyWordHidden" value="">
														</div>
													</div>
													
													<div class="col-md-3">
														<label class="col-md-4 control-label">色系：</label>
														<div class="col-md-8">
															<select class="form-control" id="proColor">
																<option value="">请选择</option>
															</select>
														</div>
													</div>
													<div class="col-md-3" id="smDiv">
														<label class="col-md-4 control-label">色码：</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="colorCode"
																onkeydown=if(event.keyCode==13)event.keyCode=9
                                                                oninput="value=value.replace(/[<>]/g,'');"
																maxLength=10 />
														</div>
													</div>
													<div class="col-md-3" id="txDiv">
														<label class="col-md-4 control-label">特性：</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="featrues"
																onkeydown=if(event.keyCode==13)event.keyCode=9
																maxLength=10 />
														</div>
													</div>
													<div class="col-md-3" id="sizeCodeDiv">
														<label class="col-md-4 control-label">规格：</label>
														<div class="col-md-8">
															<input type="text" class="form-control" id="sizeCode"
																onkeydown=if(event.keyCode==13)event.keyCode=9
                                                                oninput="value=value.replace(/[<>]/g,'');"
																maxLength=10 />
														</div>
													</div>
													<div class="col-md-3">
														<div class="col-md-12 buttons-preview">
															<a class="btn btn-default purple" id="addSku"
																onclick="addSku();">添加单品</a>&nbsp; <a
																class="btn btn-danger" id="deleteSku"
																onclick="deleteSku();">删除单品</a>
														</div>
														&nbsp;
													</div>
													<div class="col-md-12">
														<div class="col-md-12" id="baseDivTable">
															<table id="baseTable"
																class="table table-bordered table-striped table-condensed table-hover flip-content">
																<thead class="flip-content bordered-darkorange">
																	<tr>
																		<th width="50px;"></th>
																		<!-- <th style="text-align: center;" width="200px;">商品编号</th> -->
																		<th style="text-align: center;" id="baseTableTh_1">色系</th>
																		<th style="text-align: center;" id="baseTableTh_2">色码</th>
																		<th style="text-align: center;" id="baseTableTh_3">规格</th>
																	</tr>
																</thead>
																<tbody>
																	<%-- <c:set scope="page" value="" var="spu"></c:set> --%>
																	<%-- <c:forEach items="${jsonSpu.data }" var="spu"> --%>
																	<tr id="baseTableTr_0">
																		<td style="text-align: center;">
																			<div class='checkbox'>
																				<label style="padding-left: 5px;"> <input
																					type='checkbox' disabled="disabled"> 
																					 <span class='text'></span>
																				</label>
																			</div>
																			<input type="hidden"
																					id='baseTableTd_colorSid_0'
																					name='baseTableTd_proColorSid' value="">
																		</td>
																		<!-- <td style='text-align: center;' id="spuSid_lb"></td> -->
																		<td style='text-align: center;' id="colorName_lb"
																			name='baseTableTd_colorName'></td>
																		<input type="hidden" id="SkuColorSid" value="">
																		<td style='text-align: center;'
																			name='baseTableTd_colorCode' id="colorCode_lb"></td>
																		<td style='text-align: center;'
																			name='baseTableTd_sizeCode' id="stanCode_lb"></td>
																	</tr>
																	<%-- </c:forEach> --%>
																</tbody>
															</table>
														</div>
														&nbsp;
													</div>
													
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input type="submit" class="btn btn-success"
															style="width: 25%;" id="baseSave" value="保存" />&emsp;&emsp;
														<input onclick="closeProDiv();" class="btn btn-danger"
															style="width: 25%;" id="close" type="button" value="取消" />
													</div>
												</div>
											</form>
										</div>
										<!-- BaseMessage end -->
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
																		style="width: 99.9%; cursor: default;">&nbsp;展示分类树信息</a>
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

																<div class="widget-body" id="pro">

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
											<!-- <div style="display: none;">
												<form id="statcateForm" method="post"
													class="form-horizontal">
													<input type="hidden" id="statCategorySid" /> <input
														type="hidden" id="statCategoryName" /> <input
														type="hidden" id="statIsLeaf" />
												</form>
											</div> -->
										</div>
										<!-- propfileMessage end -->

										<!-- ProMessage start -->
										<div id="shoppe" class="tab-pane"></div>
										<!-- ProMessage end -->
										
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
	<!-- /Page Body -->
	<!-- 成功 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="iframeSuccess">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5>温馨提示</h5>
				</div>
				<div class="modal-body" id="modal-body-success">保存成功</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="iframeSuccessBtn()">确定</button>
				</div>
			</div>
			<!-- / .modal-content -->
		</div>
		<!-- / .modal-dialog -->
	</div>
	<!-- /成功 -->
	<!-- 成功2 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="iframeSuccess2">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5>温馨提示</h5>
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
	<!-- 成功3 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="iframeSuccess3">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5>温馨提示</h5>
				</div>
				<div class="modal-body" id="modal-body-success">保存成功</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="iframeSuccessBtn3()">确定</button>
				</div>
			</div>
			<!-- / .modal-content -->
		</div>
		<!-- / .modal-dialog -->
	</div>
	<!-- /成功3 -->
	<!-- 失败 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-warning fade" id="proWarning">
		<div class="modal-dialog" style="margin: 150px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<h5>温馨提示</h5>
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
	<!-- 修改成功 -->
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade" id="edit-success">
		<div class="modal-dialog" style="margin-top:200px;">
			<div class="modal-content">
				<div class="modal-header">
					<h5>温馨提示</h5>
				</div>
				<div class="modal-body" id="modal-body-success1">修改成功</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="goProDetail()">确定</button>
				</div>
			</div>
			<!-- / .modal-content -->
		</div>
		<!-- / .modal-dialog -->
	</div>
	<!-- /修改成功 -->
</body>
</html>