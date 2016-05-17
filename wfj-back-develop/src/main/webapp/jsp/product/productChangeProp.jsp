<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 商品修改
Version: 1.0.0
Author: WangSy
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--Jquery Select2-->
<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<!-- zTree -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<!-- 分页JS -->
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<link href="${pageContext.request.contextPath}/js/bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.zh-CN.js"></script>
<!-- tree -->
<script type="text/javascript">
	<!--
	var url = __ctxPath + "/category/getAllCategory";
	channelSid = 0;
	
	
	var setting2 = {
		check: {
			enable: true,
			chkboxType: { "Y": "", "N": "p" }
		},
		data : {
			key : {
				title : "t"
			},
			simpleData : {
				enable : true
			}
		},
		async: {
			enable: true,
			url: __ctxPath+"/category/ajaxAsyncList",
			dataType: "json",
			autoParam:["id", "channelSid", "shopSid","categoryType"],
			otherParam:{"productSid":productSid},
			dataFilter: filter
		},
		callback : {
		    onCheck: zTreeOnCheck,
			beforeClick : beforeClick,
			/* onClick : onClick, */
			asyncSuccess: zTreeOnAsyncSuccess,//异步加载成功的fun
			asyncError: zTreeOnAsyncError //加载错误的fun 
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
			async: {
				enable: true,
				url: __ctxPath+"/category/ajaxAsyncList",
				dataType: "json",
				autoParam:["id", "channelSid", "shopSid","categoryType"],
				otherParam:{},
				dataFilter: filter
			},
			callback : {
				beforeClick : beforeClick,
				onClick : onClick,
				asyncSuccess: zTreeOnAsyncSuccess,//异步加载成功的fun
				asyncError: zTreeOnAsyncError //加载错误的fun 
			}
		};
	
	/* 每次点击 checkbox */
	function zTreeOnCheck(event, treeId, treeNode) {
		/*  alert(treeNode.tId + ", " + treeNode.name + "," + treeNode.checked); */
		 
		var categorySid =  $("rightCategorySid" + treeNode.id);
		var categoryName =  $("rightCategoryName" + treeNode.id);
	    var channelSid =  $("rightChannelSid" + treeNode.id);
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
									var option = "<div style='overflow: auto;width:100%;' id='div_"
										+ treeNode.id
										+ "' name='div_sppv'>"
										+ "<span style='width:100%;'>"
										+ treeNode.name + "</span>";
									option += addOption(response[0].c);
									if(response[0].cp.length>0){
										option += addOption1(response[0].cp);
									}
									option += "<div style='display: none;'>"
								        + "<input type='hidden' id='rightCategorySid" +treeNode.id+ "' value='"+treeNode.id+"'/>"
								        + "<input type='hidden' id='rightCategoryName" +treeNode.id+ "' value='"+treeNode.name+"'/>"
								        + "<input type='hidden' id='rightChannelSid" +treeNode.id+ "' value='"+treeNode.channelSid+"'/>"
							            + "</div>"
									    + "</div>";
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

	function addOption(cData_change2){
		var option = "";
		for (var i = 0; i < cData_change2.length; i++) {
			var c = cData_change2[i];
			option += "<ol id='rightdd-list_"+c.propsSid+"' class='dd-list' style='cursor: pointer;'>"
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
							+ values.valuesName
							+ "</option>";
				}
				option += "</select>";
			}
			option += "</div>"
					+ "<div class='col-md-1'>"
					+ "<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("
					+ c.propsSid
					+ ",2);'>删除</span>" + "</div>"
					+ "</div>" + "</li>" + "</ol>";
		}
		return option;
	}
	function addOption1(cData_change2){
		var option = "";
		for (var i = 0; i < cData_change2.length; i++) {
			var cp = cData_change2[i];
			option += "<ol id='rightdd-list_"+cp.propid+"' class='dd-list' style='cursor: pointer;'>"
					+ "<li class='dd-item bordered-danger'>"
					+ "<div class='dd-handle'>"
					+ "<div class='col-md-6' name='rightpropName'>"
					+ cp.propName
					+ "</div>"
					+ "<input type='hidden' value='"+cp.propSid+"' name='rightpropSid'>"
					+ "<div class='col-md-5'>"
					+ "<input id='rightvalueSid_"+cp.propid+"' type='hidden' name='rightvalueSid' value='"+cp.valueSid+"'>"
					+ "<input id='rightvalueName_"+cp.propid+"' type='hidden' name='rightvalueName' value='"+cp.valueName+"'>";
			if(cp.valueSid==null){
			    if(cp.valueName=='undefined'){
					option +=	"<input type='text' id='rightvalueInput_"+ cp.propSid+ "' onchange='rightvalueInputChange("+ cp.propSid+ ")' value='' style='padding: 0 12px;width: 100%;'  onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
			    }else{
					option +=	"<input type='text' id='rightvalueInput_"+ cp.propSid+ "' onchange='rightvalueInputChange("+ cp.propSid+ ")' value='"+cp.valueName+"' style='padding: 0 12px;width: 100%;'  onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
			    }
			}else{
				option +=	"<select class='yz' id='rightvalueSidSelect_"+cp.propSid+"' style='padding: 0 12px;width: 100%;' >"+
								"<option onclick='rightvalueSelectClick("+cp.propSid+",-1)' value='-1'>请选择</option>";
				for(var j=0;j<cp.values.length;j++){
					var values = cp.values[j];
					if(cp.valueSid==values.valuesSid){
						option +="<option onclick='rightvalueSelectClick("+cp.propSid+","+values.valuesSid+")' selected='selected' value='"+values.valuesName+"'>"+values.valuesName+"</option>";
					}else{
						option +="<option onclick='rightvalueSelectClick("+cp.propSid+","+values.valuesSid+")' value='"+values.valuesName+"'>"+values.valuesName+"</option>";
					}
				}
				option +=	"</select>";
			}
			option += "</div>"
					+ "<div class='col-md-1'>"
					+ "<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("
					+ cp.propid
					+ ",2);'>删除</span>" + "</div>"
					+ "</div>" + "</li>" + "</ol>";
		}
		return option;
	}
	
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	
	$("#li_show a").click(function(){
		loadColors();
	});
	
	
	function zTreeOnAsyncError(event, treeId, treeNode){
		$("#warning2Body").text("异步加载失败!");
		$("#warning2").show();
	}
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg){
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
			    $.ajax({
					type:"post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					url:__ctxPath + "/productprops/selectPropValueBySid",
					async:false,
					dataType: "json",
					data:{
						"cid":treeNode.id,
						"productSid":productSid
					},
					ajaxStart: function() { $("#loading-container").attr("class","loading-container");},
					ajaxStop: function() {setTimeout(function() {$("#loading-container").addClass("loading-inactive")},300);},
					success:function(response) {
						cData_change2 = response[0].c;
						var opt = "";
						for(var i=0;i<response[0].c.length;i++){
						    var c = response[0].c[i];
							opt +=	"<div class='col-md-4'>"+
										"<label class='col-md-12 control-label'>"+
											"<div class='checkbox'  style='float:left;'>";
											if(c.notNull=='1'){
										opt+=	"<label>"+
													"<input type='checkbox' id='rightcheckId_"+c.propsSid+"' name='notNull' value='righton' onclick='rightcheckboxClick("+c.propsSid+");' >"+
													"<span id='rightcheckSpanId_"+c.propsSid+"' class='text'>"+c.propsName+"</span><span style='color:red;'>(必选)</span>"+
												"</label>"+
												"<span></span>";
											}else{
										opt+=	"<label>"+
													"<input type='checkbox' id='rightcheckId_"+c.propsSid+"' value='righton' onclick='rightcheckboxClick("+c.propsSid+");' >"+
													"<span id='rightcheckSpanId_"+c.propsSid+"' class='text'>"+c.propsName+"</span>"+
												"</label>";
											}
											opt +=	"</div>"+
										"</label>&nbsp;"+
									"</div>";
						}
						$("#rightdd").append(opt);
						var option = "";
						for(var i=0;i<response[0].cp.length;i++){
							var cp = response[0].cp[i];
							option += 
								"<ol id='rightdd-list_"+cp.propSid+"' class='dd-list' style='cursor: pointer;'>"+
									"<li class='dd-item bordered-danger'>"+
										"<div class='dd-handle'>"+
											"<div class='col-md-6' name='rightpropName'>"+cp.propName+"</div>"+
											"<input type='hidden' value='"+cp.propSid+"' name='rightpropSid'>"+
											"<div class='col-md-5'>"+
												"<input id='rightvalueSid_"+cp.propSid+"' type='hidden' name='rightvalueSid' value='"+cp.valueSid+"'>"+
												"<input id='rightvalueName_"+cp.propSid+"' type='hidden' name='rightvalueName' value='"+cp.valueName+"'>";
								if(cp.valueSid==null){
								    if(cp.valueName=='undefined'){
										option +=	"<input type='text' id='rightvalueInput_"+ cp.propSid+ "' onchange='rightvalueInputChange("+ cp.propSid+ ")' value='' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20 />";
								    }else{
										option +=	"<input type='text' id='rightvalueInput_"+ cp.propSid+ "' onchange='rightvalueInputChange("+ cp.propSid+ ")' value='"+cp.valueName+"' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20 />";
								    }
								}else{
									option +=	"<select class='yz' id='rightvalueSidSelect_"+cp.propSid+"' style='padding: 0 12px;width: 100%;'>"+
													"<option onclick='rightvalueSelectClick("+cp.propSid+",-1)' value='-1'>请选择</option>";
									for(var j=0;j<cp.values.length;j++){
										var values = cp.values[j];
										if(cp.valueSid==values.valuesSid){
											option +="<option onclick='rightvalueSelectClick("+cp.propSid+","+values.valuesSid+")' selected='selected' value='"+values.valuesName+"'>"+values.valuesName+"</option>";
										}else{
											option +="<option onclick='rightvalueSelectClick("+cp.propSid+","+values.valuesSid+")' value='"+values.valuesName+"'>"+values.valuesName+"</option>";
										}
									}
									option +=	"</select>";
								}
								option +=	"</div>"+
											"<div class='col-md-1'>"+
												"<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("+cp.propSid+",1);'>删除</span>"+
											"</div>"+
										"</div>"+
									"</li>"+
								"</ol>";
						}
						$("#rightddlist").append(option+="&nbsp;");
					}
				});
			    $("#rightbaseSave").removeAttr("disabled");
			}
			if (treeNode.categoryType == 2) {
				// 更换请选择汉字
				$("#statcatebaseA").html(treeNode.name);
				$("#statcateDown").attr("treeDown", "true");
				$("#statCategoryName").val(treeNode.name);
				$("#statCategorySid").val(treeNode.id);
				$("#statIsLeaf").val(treeNode.isLeaf);
			}
			$("#rightbaseBtnGroup").attr("class", "btn-group");
			$("#statcateBtnGroup").attr("class", "btn-group");
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
		var itemFmt = "<div style='display:inline'>" + item.name + "</div>"
		return itemFmt;
	}
	//-->
</script>
<script type="text/javascript">
	<!--
	__ctxPath = "${pageContext.request.contextPath}";
	
	$("#prodCategoryCode").val(category_Sid);
	$("#categoryName").val(category_Name);
	$("#baseA").text(category_Name);
	$("#statcatebaseA").text(statcate_Name);
	$("#spuSid_from").val(productSid);
	function rightTreeDemo(){
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
	function statcatetreeDemo(){
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
	}
	$(function() {    	
		$('.form_datetime').datetimepicker({
			 format: 'yyyy-mm-dd hh:ii:00',  
			  language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			forceParse: 0
	    });
		$('.form_date').datetimepicker({
			 format: 'yyyy-mm-dd hh:ii:00',  
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
	    });
		$('.form_time').datetimepicker({
			 format: 'yyyy-mm-dd hh:ii:00',  
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 1,
			minView: 0,
			maxView: 1,
			forceParse: 0
	    });
	});
	// 初始化
	$(function() {
	    $("#baseA").attr("disabled","disabled");
	    $("#treeDown").attr("disabled","disabled");
	    $("#treeDemo").attr("disabled","disabled");
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
		statcatetreeDemo();
		$("#statcatetreeDown").click(function() {
			if ($(this).attr("treeDown") == "true") {
				$(this).attr("treeDown", "false");
				$("#statcateBtnGroup").attr("class", "btn-group open");
			} else {
				$(this).attr("treeDown", "true");
				$("#statcateBtnGroup").attr("class", "btn-group");
			}
		});
		
		// 绑定#base 保存按钮
		$("#baseSave").click(function() {
		    baseSave();
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
		$("#rightclose").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		});
		$("#statcateclose").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/product/ProductView.jsp");
		});
		$("#loading-container").addClass("loading-inactive");
	});
	//-->
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
		$("#rightvalueName_" + data).val($("#rightvalueSidSelect_" + data).val());
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
		$("#rightvalueName_" + propSid).val($("#rightvalueInput_" + propSid).val());
	}
	// 复选框点击事件
	function checkboxClick(data){
		if($("#checkId_"+data).val()=='on'){
			var option = "";
			for(var i=0;i<cData_change.length;i++){
				var c = cData_change[i];
				if(c.propsSid==data){
					option += 
						"<ol id='dd-list_"+data+"' class='dd-list' style='cursor: pointer;'>"+
							"<li class='dd-item bordered-danger'>"+
								"<div class='dd-handle'>"+
									"<div class='col-md-6' name='propName'>"+c.propsName+"</div>"+
									"<input type='hidden' value='"+c.propsSid+"' name='propSid'>"+
									"<div class='col-md-5'>"+
										"<input id='valueSid_"+c.propsSid+"' type='hidden' name='valueSid' value='"+c.valueSid+"'>"+
										"<input id='valueName_"+c.propsSid+"' type='hidden' name='valueName' value='"+c.valueName+"'>";
						if(c.isEnumProp==1){
						    if(c.valueName==undefined){
								option +=	"<input type='text' id='valueInput_"+ c.propsSid+ "' onchange='valueInputChange("+ c.propsSid+ ")' value='' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
						    }else{
								option +=	"<input type='text' id='valueInput_"+ c.propsSid+ "' onchange='valueInputChange("+ c.propsSid+ ")' value='"+c.valueName+"' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
						    }
						}else{
							option +=	"<select class='yz' id='valueSidSelect_"+c.propsSid+"' style='padding: 0 12px;width: 100%;'>"+
											"<option value='-1'>请选择</option>";
							for(var j=0;j<c.values.length;j++){
								var values = c.values[j];
								option +="<option  onclick='valueSelectClick("+c.propsSid+","+values.valuesSid+")' value='"+values.valuesName+"'>"+values.valuesName+"</option>";
							}
							option +=	"</select>";
						}
						option +=	"</div>"+
									"<div class='col-md-1'>"+
										"<span class='btn btn-danger btn-xs' onclick='deleteDDlist("+c.propsSid+",2);'>删除</span>"+
									"</div>"+
								"</div>"+
							"</li>"+
						"</ol>";
				}
			}
			$("#ddlist").append(option+="&nbsp;");
			$("#checkId_"+data).val("in");
		}else{
			$("#dd-list_"+data).remove();
			$("#checkId_"+data).val("on");
		}
	}
	// 删除事件
	function deleteDDlist(data,num){
		if(num==1){
			$("#dd-list_"+data).remove();
		}else{
			$("#checkId_"+data).removeAttr("checked");
			$("#checkId_"+data).val("on");
			$("#dd-list_"+data).remove();
		}
	}
	// 保存
	function baseSave(){
		// 必选都已经选择
		if($("input[value='on']").length==0){
		    var yz = 0;
		    $(".yz").each(function(){
				if($(this).val()==-1){
				    yz++;
				}
		    });
		    if(yz==0){
				var propName = new Array();
				var propSid = new Array();
				var valueSid = new Array();
				var valueName = new Array();
				var parameters = new Array();
				var dataLength = $("div[name='propName']").length;
				// 整理属性名
				$("div[name='propName']").each(function(i) {
					propName.push($(this).html().trim());
				});
				// 整理属性SID
				$("input[name='propSid']").each(function(i) {
					propSid.push($(this).val());
				});
				// 整理值SID
				$("input[name='valueSid']").each(function(i) {
					if ($(this).val() == "") {
						valueSid.push(null);
					}else if($(this).val() == "undefined"){
						valueSid.push(null);
					} else {
						valueSid.push($(this).val());
					}
				});
				// 整理值名称
				$("input[name='valueName']").each(function(i) {
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
				$.ajax({
					type:"post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					url:__ctxPath + "/productprops/addProductParameters",
					dataType: "json",
					data:{
						"categorySid":category_Sid,
						"spuSid":productSid,
						"parameters":inT,
						"categoryName":$("#categoryName").val(),
						"channelSid":channelSid
					},
					ajaxStart: function() { $("#loading-container").attr("class","loading-container");},
					ajaxStop: function() {setTimeout(function() {$("#loading-container").addClass("loading-inactive")},300);},
					success:function(response){
						if(response.success=='true'){
							$("#iframeSuccess").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
						}else{
						    $("#warning2Body",parent.document).text("添加失败!");
							$("#warning2",parent.document).attr("style","z-index:9999");
							$("#warning2",parent.document).show();
						}
					}
				});
		    }else{
				$("#warning2Body",parent.document).text("枚举属性存在未选择!");
				$("#warning2",parent.document).attr("style","z-index:9999");
				$("#warning2",parent.document).show();
		    }
		}else{
		    $("#warning2Body",parent.document).text("存在必选属性未设置!");
		    $("#warning2",parent.document).attr("style","z-index:9999");
			$("#warning2",parent.document).show();
		}
	}
</script>
<!-- 加载已经挂好的展示分类属性和属性值信息 -->
<script type="text/javascript">
    var nativeCp;
function clickSelect(cid,propSid){//alert(propSid);
$("#rightvalueSidSelect_"+propSid).removeAttr("onclick");
	$
	.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath
				+ "/productprops/selectPropValueBySid",
		async : false,
		dataType : "json",
		data : {
			"cid" : cid,
			"productSid" : productSid
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
		    nativeCp = response[0].cp;
		    var option="";
		    for(var nativeCp_i=0;nativeCp_i<nativeCp.length;nativeCp_i++){
				if(nativeCp[nativeCp_i].propSid==propSid){
					for(var j=0;j<nativeCp[nativeCp_i].values.length;j++){
						var values = nativeCp[nativeCp_i].values[j];
						if(nativeCp[nativeCp_i].valueSid==values.valuesSid){
							option +="<option onclick='rightvalueSelectClick("+nativeCp[nativeCp_i].propSid+","+values.valuesSid+")' selected='selected' value='"+values.valuesName+"'>"+values.valuesName+"</option>";
						}else{
							option +="<option onclick='rightvalueSelectClick("+nativeCp[nativeCp_i].propSid+","+values.valuesSid+")' value='"+values.valuesName+"'>"+values.valuesName+"</option>";
						}
					} 
				}
				
			}
		    $("#rightvalueSidSelect_"+propSid).html(option);
		}
    });
}
	$(function(){
	    /* $("#rightbaseSave").attr("disabled","disabled"); */
	    $.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/productprops/selectPropValueBySid1",
			async:false,
			dataType: "json",
			data:{
				"spuSid":productSid
			},
			ajaxStart: function() { $("#loading-container").attr("class","loading-container");},
			ajaxStop: function() {setTimeout(function() {$("#loading-container").addClass("loading-inactive")},300);},
			success:function(response) {
				var listData = response.data;
				
				for(var list_i=0;list_i<listData.length;list_i++){
					var category = listData[list_i];
					var option = "<div style='overflow: auto;width:100%;' id='div_" + category.categorySid
					+ "' name='div_sppv'>"
					+ "<span style='width:100%;'>"
					+ category.categoryName + "</span>";
					
					var parametersList = category.parameters;
					
					for(var i=0;i<parametersList.length;i++){
						var cp = parametersList[i];
						
						option += 
							"<ol id='rightdd-list_"+cp.propSid+"' class='dd-list' style='cursor: pointer;'>"+
								"<li class='dd-item bordered-danger'>"+
									"<div class='dd-handle'>"+
										"<div class='col-md-6' name='rightpropName'>"+cp.propName+"</div>"+
										"<input type='hidden' value='"+cp.propSid+"' name='rightpropSid'>"+
										"<div class='col-md-5'>"+
											"<input id='rightvalueSid_"+cp.propSid+"' type='hidden' name='rightvalueSid' value='"+cp.valueSid+"'>"+
											"<input id='rightvalueName_"+cp.propSid+"' type='hidden' name='rightvalueName' value='"+cp.valueName+"'>";
							if(cp.valueSid==null){
							    if(cp.valueName=='undefined'){
									option +=	"<input type='text' id='rightvalueInput_"+ cp.propSid+ "' onchange='rightvalueInputChange("+ cp.propSid+ ")' value='' style='padding: 0 12px;width: 100%;'  onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
							    }else{
									option +=	"<input type='text' id='rightvalueInput_"+ cp.propSid+ "' onchange='rightvalueInputChange("+ cp.propSid+ ")' value='"+cp.valueName+"' style='padding: 0 12px;width: 100%;'  onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
							    }
							}else{
								option +=	"<select onclick='clickSelect(" + category.categorySid +"," + cp.propSid + ")' class='yz' id='rightvalueSidSelect_"+cp.propSid+"' style='padding: 0 12px;width: 100%;' >"+
												"<option onclick='rightvalueSelectClick("+cp.propSid+","+cp.valueSid+")' selected='selected' value='"+cp.valueName+"'>"+cp.valueName+"</option>";
								
								option +=	"</select>";
							}
							option +=	"</div>"+
									"</div>"+
								"</li>"+
							"</ol>";		
					}
					option += "<div style='display: none;'>"
				        + "<input type='hidden' id='rightCategorySid" + category.categorySid + "' value='" + category.categorySid +"'/>"
				        + "<input type='hidden' id='rightCategoryName" + category.categorySid  + "' value='" + category.categoryName +"'/>"
				        + "<input type='hidden' id='rightChannelSid" + category.categorySid + "' value='" + category.channelSid +"'/>"
		                + "</div>"
					    + "</div>";
					$("#rightddlist").append(option+="&nbsp;");
				
				}
			}
		});
	});
</script>
<!-- 展示分类 -->
<script type="text/javascript">
	//属性下拉框事件
	function rightvalueSelectClick(data, valueSid) {
		// 赋值
		$("#rightvalueSid_" + data).val(valueSid);
		$("#rightvalueName_" + data).val($("#rightvalueSidSelect_" + data).val());
	}
	// 属性文本框事件
	function rightvalueInputChange(propSid) {
		// 赋值
		$("#rightvalueSid_" + propSid).val(null);
		$("#rightvalueName_" + propSid).val($("#rightvalueInput_" + propSid).val());
	}
	function rightcheckboxClick(data){
		if($("#rightcheckId_"+data).val()=='righton'){
			var option = "";
			for(var i=0;i<cData_change2.length;i++){
				var c = cData_change2[i];
				if(c.propsSid==data){
					option += 
						"<ol id='rightdd-list_"+data+"' class='dd-list' style='cursor: pointer;'>"+
							"<li class='dd-item bordered-danger'>"+
								"<div class='dd-handle'>"+
									"<div class='col-md-6' name='rightpropName'>"+c.propsName+"</div>"+
									"<input type='hidden' value='"+c.propsSid+"' name='rightpropSid'>"+
									"<div class='col-md-5'>"+
										"<input id='rightvalueSid_"+c.propsSid+"' type='hidden' name='rightvalueSid' value='"+c.valueSid+"'>"+
										"<input id='rightvalueName_"+c.propsSid+"' type='hidden' name='rightvalueName' value='"+c.valueName+"'>";
						if(c.isEnumProp==1){
						    if(c.valueName==undefined){
								option +=	"<input type='text' id='rightvalueInput_"+ c.propsSid+ "' onchange='rightvalueInputChange("+ c.propsSid+ ")' value='' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
						    }else{
								option +=	"<input type='text' id='rightvalueInput_"+ c.propsSid+ "' onchange='rightvalueInputChange("+ c.propsSid+ ")' value='"+c.valueName+"' style='padding: 0 12px;width: 100%;' onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
						    }
						}else{
							option +=	"<select class='rightyz' id='rightvalueSidSelect_"+c.propsSid+"' style='padding: 0 12px;width: 100%;'>"+
											"<option value='-1'>请选择</option>";
							for(var j=0;j<c.values.length;j++){
								var values = c.values[j];
								option +="<option  onclick='rightvalueSelectClick("+c.propsSid+","+values.valuesSid+")' value='"+values.valuesName+"'>"+values.valuesName+"</option>";
							}
							option +=	"</select>";
						}
						option +=	"</div>"+
									"<div class='col-md-1'>"+
										"<span class='btn btn-danger btn-xs' onclick='rightdeleteDDlist("+c.propsSid+",2);'>删除</span>"+
									"</div>"+
								"</div>"+
							"</li>"+
						"</ol>";
				}
			}
			$("#rightddlist").append(option);
			$("#rightcheckId_"+data).val("rightin");
		}else{
			$("#rightdd-list_"+data).remove();
			$("#rightcheckId_"+data).val("righton");
		}
	}
	function rightdeleteDDlist(data,num){
		if(num==1){
			$("#rightdd-list_"+data).remove();
		}else{
			$("#rightcheckId_"+data).removeAttr("checked");
			$("#rightcheckId_"+data).val("righton");
			$("#rightdd-list_"+data).remove();
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

				$("div[name='div_sppv']").each(function(i) {
					var div_id = $(this).attr("id");
					var div_cache = div_id.split("_")[1];
					
					var propName = new Array();
					var propSid = new Array();
					var valueSid = new Array();
					var valueName = new Array();
					var parameters = new Array();
					var dataLength = $(this).find("div[name='rightpropName']").length;
					// 整理属性名
					$(this).find("div[name='rightpropName']").each(function(i) {
						propName.push($(this).html().trim());
					});
					// 整理属性SID
					$(this).find("input[name='rightpropSid']").each(function(i) {
						propSid.push($(this).val());
					});
					// 整理值SID
					$(this).find("input[name='rightvalueSid']").each(function(i) {
						if ($(this).val() == "") {
							valueSid.push(null);
						} else if ($(this).val() == "undefined") {
							valueSid.push(null);
						} else {
							valueSid.push($(this).val());
						}
					});
					// 整理值名称
					$(this).find("input[name='rightvalueName']").each(function(i) {
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
					
					sppvs.push({
						"categoryType" : "3",
						"categorySid" : $("#rightCategorySid" + div_cache).val(),
						"spuSid" : $("#spuSid_from").val(),
						"parameters" : inT,
						"categoryName" : $("#rightCategoryName" + div_cache).val(),
						"channelSid" : $("#rightChannelSid" + div_cache).val()
					});

				});
				var sppvsJSON = JSON.stringify(sppvs);
				$.ajax({
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
	function statcatebaseSave(){
		var cateSid=$("#statCategorySid").val();
		var cateName=$("#statCategoryName").val();
		var ifLeaf=$("#statIsLeaf").val();
		var activeTime=$("#activeTimes").val();
		if(ifLeaf!="Y"||cateSid==null||cateSid==""){
			$("#warning2Body",parent.document).text("请选择统计分类末级节点");
			$("#warning2",parent.document).attr("style","z-index:9999");
			$("#warning2",parent.document).show();
		}else if(activeTime==""||activeTime==null||activeTime=="生效日期"){
			$("#warning2Body",parent.document).text("请选择生效日期");
			$("#warning2",parent.document).attr("style","z-index:9999");
			$("#warning2",parent.document).show();
		}else if(cateName==statcate_Name){
			$("#iframeSuccess3").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-success"
			});
		}else{
			$.ajax({
				type:"post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url:__ctxPath + "/productprops/updateStatCategory",
				dataType: "json",
				data:{
					cateSid:cateSid,
					spuSid:productSid2,
					activeTime:activeTime
				},
				ajaxStart: function() { $("#loading-container").attr("class","loading-container");},
				ajaxStop: function() {setTimeout(function() {$("#loading-container").addClass("loading-inactive")},300);},
				success:function(response){
					if(response.success=='true'){
						$("#iframeSuccess3").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
					}else{
					    $("#warning2Body",parent.document).text(response.data.errorMsg);
						$("#warning2",parent.document).attr("style","z-index:9999");
						$("#warning2",parent.document).show();
					}
				}
			});
		}
	}
</script>

<script type="text/javascript">
function loadColors(){
	$("#show").load(
			"${pageContext.request.contextPath}/upImg/loadColors",
			{ "proSid": productSid}
	  );
} 


</script>

<!-- 保存取消关闭按钮控制 -->
<script type="text/javascript">
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
</head>
<body>
	<div class="page-body" id="productSaveBody">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption"></span>
							</div>
							<div class="widget-body">
								<div class="tabbable">
									<ul class="nav nav-tabs" id="myTab">
										<li class="active" id="li_base"><a data-toggle="tab" href="#base">
												<span>基本信息</span>
										</a></li>

										<li class="tab-red" id="li_profile"><a data-toggle="tab" href="#propfile">
												<span>展示分类</span>
										</a></li>
										
										<li class="tab-red" id="li_profile"><a data-toggle="tab" href="#statcate">
												<span>统计分类</span>
										</a></li>
										<li class="tab-red" id="li_show"><a data-toggle="tab" href="#show">
												<span>图片修改</span>
										</a></li>
									</ul>
									<!-- BaseMessage start -->
									<div class="tab-content">
										<div id="base" class="tab-pane in active">
											<form id="baseForm" method="post" class="form-horizontal">
												<div class="col-md-12">
													<h5><strong>工业分类</strong></h5>
													<hr class="wide" style="margin-top: 0;">
													<div class="col-md-6">
														<label class="col-md-1 control-label"></label>
														<div class="col-md-11">
															<div class="btn-group" style="width: 100%"
																id="baseBtnGroup">
																<a href="javascript:void(0);" class="btn btn-default"
																	id="baseA"
																	style="width: 87%;"></a>
																<a id="treeDown" href="javascript:void(0);"
																	class="btn btn-default" treeDown="true"><i
																	class="fa fa-angle-down"></i></a>
																<ul id="treeDemo" class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 96%; position: absolute;"></ul>
															</div>
														</div>
													</div>
												</div>
												<div class="col-md-12">
													<h5><strong>工业属性</strong></h5>
													<hr class="wide" style="margin-top: 0;">
												</div>
												<div class="col-md-12" id="baseHr">
													<div class="col-md-12" id="dd"></div>
													<div class="col-md-12" id="ddlist"></div>
												</div>
												<div style="display: none;">
													<input type="hidden" 
														id="prodCategoryCode"
														name="prodCategoryCode" />
													<input type="hidden" 
														id="categoryName" 
														name="categoryName" />
													<input type="hidden" 
														id="spuSid_from" />
													<textarea id="parameters" name="parameters"></textarea>
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
										<!-- propfileMessage start -->
										<div id="propfile" class="tab-pane">
											<form id="rightbaseForm" method="post"
												class="form-horizontal">
												<div class="row">
													<div class="col-lg-12 col-sm-12 col-xs-12">
														<div class="col-md-4" style="width: 40%; float: left;">
															<div class="col-md-12 well" style="padding: 10px;">
																<div class="col-md-12">
																	<a class="btn btn-default purple btn-sm fa fa-star"
																		style="width: 99.9%">&nbsp;展示分类树信息</a>
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

																	<div class="col-md-12" id="rightddlist"></div>
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
										<!-- propfileMessage start -->
										<div id="statcate" class="tab-pane">
											<form id="statcateForm" method="post" class="form-horizontal">
												<div class="col-md-12">
													<h5><strong>统计分类</strong></h5>
													<hr class="wide" style="margin-top: 0;">
													<div class="col-md-6">
														<label class="col-md-1 control-label"></label>
														<div class="col-md-11">
															<div class="btn-group" style="width: 100%"
																id="statcateBtnGroup">
																<a href="javascript:void(0);" class="btn btn-default"
																	id="statcatebaseA"
																	style="width: 87%;"></a>
																<a id="statcatetreeDown" href="javascript:void(0);"
																	class="btn btn-default" treeDown="true"><i
																	class="fa fa-angle-down"></i></a>
																<ul id="statcateTreeDemo" class="dropdown-menu ztree form-group"
																	style="margin-left: 0; width: 96%; position: absolute;"></ul>
															</div>
														</div>
													</div>
												</div>
												<div class="col-md-12">
													<h5><strong>生效日期</strong></h5>
													<hr class="wide" style="margin-top: 0;">
													<div class="col-md-6">
														<label class="col-md-1 control-label"></label>
											            <div class="col-md-11">
															<div class="input-group date form_date col-md-5" data-date="" data-date-format="" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd" style="width: 97%;">
																<input class="form-control" type="text" id="activeTimes" name="activeTime" placeholder="生效日期" readonly 
																	style="height: 30px; width: 100%; text-align: center;position:relative;" />
																<span class="input-group-addon">
																	<span class="glyphicon glyphicon-remove"></span>
																</span>
																<span class="input-group-addon">
																    <span class="glyphicon glyphicon-calendar"></span>
																</span>
															</div>
														</div>
													</div>
												</div>
												<div style="display: none;">
													<input type="hidden"  id="statCategorySid" />
													<input type="hidden"  id="statCategoryName"/>
													<input type="hidden"  id="statIsLeaf"/>
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6"  style="margin-top:20px;">
														<input class="btn btn-success" style="width: 25%;"
															id="statcatebaseSave" type="button" value="修改" />&emsp;&emsp; 
														<input
															class="btn btn-danger" style="width: 25%;" id="statcateclose"
															type="button" value="取消" />
													</div>
												</div>
											</form>
										</div>
										<!-- propfileMessage end -->
										<!-- #show start -->
										<div id="show" class="tab-pane">
																	
										</div>
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
	<!-- /Page Body -->
	<!-- 成功 -->
	<div aria-hidden="true" style="display: none;" class="modal modal-message modal-success fade" id="iframeSuccess">
   		<div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <i class="glyphicon glyphicon-check"></i>
	            </div>
	            <div class="modal-body" id="modal-body-success">保存成功</div>
	            <div class="modal-footer">
	                <button data-dismiss="modal" class="btn btn-success" type="button" onclick="iframeSuccessBtn()">确定</button>
	            </div>
	        </div> <!-- / .modal-content -->
	    </div> <!-- / .modal-dialog -->
	</div>
	<!-- /成功 -->
	<!-- 成功2 -->
	<div aria-hidden="true" style="display: none;" class="modal modal-message modal-success fade" id="iframeSuccess2">
   		<div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <i class="glyphicon glyphicon-check"></i>
	            </div>
	            <div class="modal-body" id="modal-body-success">保存成功</div>
	            <div class="modal-footer">
	                <button data-dismiss="modal" class="btn btn-success" type="button" onclick="iframeSuccessBtn2()">确定</button>
	            </div>
	        </div> <!-- / .modal-content -->
	    </div> <!-- / .modal-dialog -->
	</div>
	<!-- /成功2 -->
	<!-- 成功3 -->
	<div aria-hidden="true" style="display: none;" class="modal modal-message modal-success fade" id="iframeSuccess3">
   		<div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <i class="glyphicon glyphicon-check"></i>
	            </div>
	            <div class="modal-body" id="modal-body-success">保存成功</div>
	            <div class="modal-footer">
	                <button data-dismiss="modal" class="btn btn-success" type="button" onclick="iframeSuccessBtn3()">确定</button>
	            </div>
	        </div> <!-- / .modal-content -->
	    </div> <!-- / .modal-dialog -->
	</div>
	<!-- /成功3 -->
	<!-- 失败 -->
	<div aria-hidden="true" style="display: none;" class="modal modal-message modal-warning fade" id="proWarning">
		<div class="modal-dialog" style="margin: 150px auto;">
			<div class="modal-content">
	           <div class="modal-header">
	               <i class="fa fa-warning"></i>
	           </div>
	           <div class="modal-body" id="model-body-proWarning">操作失败</div>
	           <div class="modal-footer">
	               <button data-dismiss="modal" class="btn btn-warning" type="button" onclick="proWarningBtn()">确定</button>
	           </div>
	       </div>
	   </div>
	</div>
	<!-- /失败 -->
</body>
</html>