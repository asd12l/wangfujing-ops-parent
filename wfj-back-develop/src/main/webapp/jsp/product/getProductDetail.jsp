<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.lang.String"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--
WFJBackWeb - 商品详情
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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

<script type="text/javascript">
$(function(){
	$('#${tabMark1 }_a').tab('show');
	if('${tabMark1 }' == 'show'){
		loadColors(1);
	}
});
</script>
<script type="text/javascript">
var channelCodeList = new Array();

function goEditPro(b){
	productDetail = ${jsonsSku[0] };
	productChangePropId = "${jsonsSku[0].sid }";
	category_Sid = "${jsonsSku[0].category }";
	category_Name = "${jsonsSku[0].categoryName }";
	statcate_Name = "${jsonsSku[0].statCategoryName }";
	spuSid = "${jsonsSku[0].spuSid }";
	productSid = "${jsonsSku[0].spuCode }";
	productSid2 = "${jsonsSku[0].spuSid }";
	tabMark = b;
	$("#pageBody").load(__ctxPath + "/jsp/product/editProduct.jsp");
}
//初始化
$(function() {
	if("${backUrl }" != "/jsp/product/ProductView.jsp" && "${backUrl }" != ""){
		$("input[id='save']").hide();
	}
	
	//修改按钮事件
	$("input[id='save']").click(function(){
		var a = $(this).attr("name");
		skuSale_productChangePropId = $("#skuSale").val();
		if($("#skuSale").val() != 1){
			goEditPro(a);
		} else if(a == "FinePack" && $("#skuSale").val() == 1) {
			goEditPro(a);
		} else {
			$("#warning2Body").text("上架商品不能修改!");
			$("#warning2").show();
		}
	});
	
	$("#li_show a").click(function() {
		loadColors(1);
	});
	
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
			"spuCode" : "${jsonsSku[0].spuCode }"
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
	
	//关闭按钮事件
	$("input[id='close']").click(function() {
		$("#pageBody").load(__ctxPath + "${backUrl }");
	});
	$("#loading-container").addClass("loading-inactive");
});
</script>
<script type="text/javascript">
    
    function openSMTable(){
    	$.ajax({
    		type : "post",
    		contentType : "application/x-www-form-urlencoded;charset=utf-8",
    		url : __ctxPath + "/product/getBrandCateInfo",
    		async : false,
    		data : {
    			"brandCode" : "${jsonsSku[0].brandGroupCode }",
    			"categoryCode" : "${jsonsSku[0].category }"
    		},
    		dataType : "json",
    		success : function(response) {
    			if(response.data == null || response.data == "")
    				return;
    			var url = response.data[0].sizePictureUrl;
    			if(url != null && url != ""){
    				$("#SMTable_id").html("<img alt='' src='"+url+"' style='width:570px;height:270px;'>");
    			} else {
    				$("#SMTable_id").html("<h1 style='margin:120px 230px'>无数据</h1>");
    			}
    		}
    	});
    	$("#SMTableDiv").show();
    }
    function closeSMTable(){
    	$("#SMTableDiv").hide();
    }
    
	function loadColors(mark) {
		$("#show").load("${pageContext.request.contextPath}/upImg/loadColors",
				{
					"proSid" : "${jsonsSku[0].spuCode}",
					"mark" : mark
				});
	}
	
	function openShow(){
		var sku = $("#skuCodeOne").val();
		var packimg_url = $("#packimgUrl").val();
		window.open(packimg_url+"/item/"+sku+".jhtml");
	}
	function down(){
		window.open("${pageContext.request.contextPath}/proPicPack/picPacking?"
				+ "spuCode=" + $("#spuCode_from").val()
				+ "&colorCode=" + $("#hid_color").val() );
	}
</script>
<script type="text/javascript">
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
var className = "dark";
function beforeClick(treeId, treeNode, clickFlag) {
	className = (className === "dark" ? "" : "dark");
	showLog("[ " + getTime() + " beforeClick ]&nbsp;&nbsp;" + treeNode.name);
	return (treeNode.click != false);
}

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
				"productSid" : "${jsonsSku[0].spuSid }"
			},
			dataFilter : filter
		},
		callback : {
			/* onCheck : zTreeOnCheck, */
			beforeClick : beforeClick,
			/* onClick : onClick, */
			asyncSuccess : zTreeOnAsyncSuccess,//异步加载成功的fun
			asyncError : zTreeOnAsyncError
		//加载错误的fun 
		}
	};
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
$(function(){
	var primaryAttr = "${jsonsSku[0].primaryAttr }";
	if(primaryAttr == ""){
		$("#TSSXLabel").html("否");
		$("#KH_div_1").show();
		$("#ZSX_div_1").hide();
		$("#SM_div_1").show();
		$("#TX_div_1").hide();
	}else{
		$("#TSSXLabel").html("是");
		$("#KH_div_1").hide();
		$("#ZSX_div_1").show();
		$("#SM_div_1").hide();
		$("#TX_div_1").show();
	}
	
	rightTreeDemo();
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/productprops/selectPropValueBySid1",
		async : false,
		dataType : "json",
		data : {
			"spuSid" : "${jsonsSku[0].spuSid }"
		},
		ajaxStart : function() {
			$("#loading-container").attr("class",
					"loading-container");
		},
		ajaxStop : function() {
			setTimeout(function() {
				$("#loading-container")
						.addClass("loading-inactive")
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
							option += "<input type='text' disabled='disabled' id='rightvalueInput_"
									+ cp.propSid
									+ "' onchange='rightvalueInputChange("
									+ cp.propSid
									+ ")' value='' style='padding: 0 12px;width: 100%;'  onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
						} else {
							option += "<input type='text' disabled='disabled' id='rightvalueInput_"
									+ cp.propSid
									+ "' onchange='rightvalueInputChange("
									+ cp.propSid
									+ ")' value='"
									+ cp.valueName
									+ "' style='padding: 0 12px;width: 100%;'  onkeydown=if(event.keyCode==13)event.keyCode=9 maxLength=20/>";
						}
					} else {
						option += "<select disabled='disabled' onclick='clickSelect("
								+ category.categorySid
								+ ","
								+ cp.propSid
								+ ")' class='yz' id='rightvalueSidSelect_"
								+ cp.propSid
								+ "' style='padding: 0 12px;width: 100%;' >"
								+ "<option onclick='rightvalueSelectClick("
								+ cp.propSid + "," + cp.valueSid
								+ ")' selected='selected' value='"
								+ cp.valueName + "'>"
								+ cp.valueName + "</option>";

						option += "</select>";
					}
					option += "</div>";

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

    //查询工业分类（面包线）
    $.ajax({
        type : "post",
        contentType : "application/x-www-form-urlencoded;charset=utf-8",
        url : __ctxPath + "/category/findAllParentCategoryByParam",
        async : false,
        data : {
            "categoryType" : "0",
            "sid" : '${jsonsSku[0].category }'
        },
        dataType : "json",
        ajaxStart : function() {
            $("#loading-container").prop("class", "loading-container");
        },
        ajaxStop : function() {
            $("#loading-container").addClass("loading-inactive");
        },
        success : function(response) {
            if(response.success == "true"){
                $("#industryCategoryNames").text(response.data.categoryNames);
            }
        }
    });
});

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
</script>
</head>
<body>
    <input type="hidden" id="backUrl" value="${backUrl }">
	<div class="page-body" id="productSaveBody">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">商品详情</span>
							</div>
							<div class="widget-body">
								<div class="tabbable">
									<ul class="nav nav-tabs" id="myTab">
										<li class="active" id="li_base"><a id="base_a" data-toggle="tab" href="#base">
												<span>基本信息</span>
										</a></li>

										<li class="tab-red" id="li_pro"><a id="shoppe_a" data-toggle="tab" href="#pro">
												<span>专柜商品</span>
										</a></li>

										<li class="tab-red" id="li_profile"><a id="profile_a" data-toggle="tab" href="#propfile">
												<span>展示分类</span>
										</a></li>
										
										<li class="tab-red" id="li_show"><a id="show_a" data-toggle="tab" href="#show">
												<span>图片展示</span>
										</a></li>
										
										<li class="tab-red" id="li_FinePack"><a id="FinePack_a" data-toggle="tab" href="#FinePack">
												<span>精包装</span>
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
													<input type="hidden" id="spuSid_from" value="${jsonsSku[0].spuCode}">
													<input type="hidden" id="spuCode_from" value="${jsonsSku[0].spuCode}">
													<div class="col-md-6">
														<label class="col-md-4 control-label">集团品牌：</label>
														<div class="col-md-8 js-data-example-ajax">
															<label class="control-label">${jsonsSku[0].brandGroupName }</label>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">特殊属性：</label>
														<div class="col-md-8">
															<%-- <c:if test="${jsonsSku[0].industryCondition=='0' }"> --%>
																<label class="control-label" id="TSSXLabel">是</label>
															<%-- </c:if>
															<c:if test="${jsonsSku[0].industryCondition=='1' }">
																<label class="control-label">超市</label>
															</c:if> --%>
														</div>&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">工业分类：</label>
														<div class="col-md-8">
															<label class="control-label" id="industryCategoryNames">${jsonsSku[0].categoryName }</label>
														</div>
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">类型：</label>
														<div class="col-md-8">
															<c:if test="${jsonsSku[0].proType==1 }">
																<label class="control-label">普通商品</label>
															</c:if>
															<c:if test="${jsonsSku[0].proType==2}">
																<label class="control-label">赠品</label>
															</c:if>
															<c:if test="${jsonsSku[0].proType==3 }">
																<label class="control-label">礼品</label>
															</c:if>
															<c:if test="${jsonsSku[0].proType==4 }">
																<label class="control-label">虚拟商品</label>
															</c:if>
															<c:if test="${jsonsSku[0].proType==5 }">
																<label class="control-label">服务类商品</label>
															</c:if>
														</div>&nbsp;
													</div> 
													<%-- <div class="col-md-6">
														<label class="col-md-4 control-label">统计分类：</label>
														<div class="col-md-8">
															<label class="control-label">
																<c:if test="${empty jsonsSku[0].statCategoryName }">
																	无															
																</c:if>
																<c:if test="${not empty jsonsSku[0].statCategoryName }">
																	${jsonsSku[0].statCategoryName }															
																</c:if>
															</label>
														</div>
														&nbsp;
													</div> --%>
													
													<%-- <c:if test="${jsonsSku[0].industryCondition!='1' }"> --%>
													<div class="col-md-6" id="KH_div_1">
														<label class="col-md-4 control-label">款号：</label>
														<div class="col-md-8">
															<label class="control-label">
																<c:if test="${empty jsonsSku[0].modelCode }">
																	无
																</c:if>
																<c:if test="${not empty jsonsSku[0].modelCode }">
																	${jsonsSku[0].modelCode }
																</c:if>
															</label>
														</div>
													</div>
													<%-- </c:if>
													
													<c:if test="${jsonsSku[0].industryCondition=='1' }"> --%>
														<div class="col-md-6" id="ZSX_div_1">
															<label class="col-md-4 control-label">主属性：</label>
															<div class="col-md-8">
																<label class="control-label">${jsonsSku[0].primaryAttr }</label>
															</div>
														</div>
													<%-- </c:if> --%>
													
												</div>
												
												<div class="col-md-12">
													<h5><strong>工业属性</strong></h5>
													<hr class="wide" style="margin-top: 0;">
													<c:if test="${empty json_2 }">
														<div class="col-md-6">
															<label class="col-md-4 control-label">无</label>
															<div class="col-md-8">
																<label class="control-label"></label>
															</div>
														</div>
													</c:if>
													<c:forEach items="${json_2 }" var="json2">
														<div class="col-md-6">
															<label class="col-md-4 control-label">
																${json2.propName } ：
															</label>
															<div class="col-md-8">
																<label class="control-label">
																	<c:if test="${json2.valueName == 'undefined'}">
																		无
																	</c:if>
																	<c:if test="${json2.valueName != 'undefined'}">
																		${json2.valueName}
																	</c:if>
																</label>
															</div>&nbsp;
														</div>
													</c:forEach>
												</div>
												<div class="col-md-12" id="baseHr">
												</div>
												<div class="col-md-12">
													<h5><strong>商品信息</strong></h5>
													<hr class="wide" style="margin-top: 0;">
													<div class="col-md-6">
														<label class="col-md-4 control-label">标准品名：</label>
														<div class="col-md-8">
															<label class="control-label">${jsonsSku[0].skuName }</label>
														</div>&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">拍照状态：</label>
														<div class="col-md-8">
														    <c:if test="${jsonsSku[0].photoStatus == 0 }"><label class="control-label">未拍照</label></c:if>
															<c:if test="${jsonsSku[0].photoStatus == 1 }"><label class="control-label">已加入计划</label></c:if>
															<c:if test="${jsonsSku[0].photoStatus == 3 }"><label class="control-label">已拍照已上传</label></c:if>
															<c:if test="${jsonsSku[0].photoStatus == 4 }"><label class="control-label">已编辑</label></c:if>
														</div>&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">上架状态：</label>
														<div class="col-md-8">
														    <c:if test="${jsonsSku[0].skuSale == 0 }"><label class="control-label">未上架</label></c:if>
															<c:if test="${jsonsSku[0].skuSale == 1 }"><label class="control-label">上架</label></c:if>
															<c:if test="${jsonsSku[0].skuSale == 2 }"><label class="control-label">已下架</label></c:if>
														</div>&nbsp;
														<input type="hidden" id="skuSale" value="${jsonsSku[0].skuSale }">
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">关键字：</label>
														<div class="col-md-8">
															<label class="control-label">
																<c:if test="${empty jsonsSku[0].searchKey }">
																	无
																</c:if>
																<c:if test="${not empty jsonsSku[0].searchKey }">
																	${jsonsSku[0].searchKey }
																</c:if>
															</label>
														</div>&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">活动关键字：</label>
														<div class="col-md-8">
															<label class="control-label">
																<c:if test="${empty jsonsSku[0].keyWord }">
																	无
																</c:if>
																<c:if test="${not empty jsonsSku[0].keyWord }">
																	${jsonsSku[0].keyWord }
																</c:if>
															</label>
														</div>&nbsp;
													</div>
													<div class="col-md-6">
														<label class="col-md-4 control-label">色系：</label>
														<div class="col-md-8">
															<label class="control-label">${jsonsSku[0].colorName }</label>
															<input type="hidden" id="SkuColorSid" value="${jsonsSku[0].colorSid }">
														</div>&nbsp;
													</div>
													<%-- <c:if test="${jsonsSku[0].industryCondition=='0' }"> --%>
														<div class="col-md-6" id="SM_div_1">
															<label class="col-md-4 control-label">色码：</label>
															<div class="col-md-8">
																<label class="control-label">${jsonsSku[0].colorCode }</label>
															</div>&nbsp;
														</div>
													<%-- </c:if>
													<c:if test="${jsonsSku[0].industryCondition=='1' }"> --%>
														<div class="col-md-6" id="TX_div_1">
															<label class="col-md-4 control-label">特性：</label>
															<div class="col-md-8">
																<label class="control-label">${jsonsSku[0].features }</label>
															</div>&nbsp;
														</div>
													<%-- </c:if> --%>
													<div class="col-md-6">
														<label class="col-md-4 control-label">规格：</label>
														<div class="col-md-8">
															<label class="control-label">${jsonsSku[0].stanName }</label>
														</div>&nbsp;
													</div>
													<div class="col-md-6">
													    <label class="col-md-4 control-label">色码对照表:</label>
														<div class="col-md-8">
															<label class="control-label"><a href="javascript:openSMTable();">点此查看</a></label>
														</div>&nbsp;
													</div>
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="修改" name="base">&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="关闭"/>
													</div>
												</div>
											</form>
										</div>
										<!-- BaseMessage end -->
										<!-- ProMessage start -->
										<div id="pro" class="tab-pane">
				                            <div class="well">
			                                    <table id="product_tab" style="text-align: center;" class="table table-bordered table-striped table-condensed table-hover flip-content" >
		                                            <thead class="flip-content bordered-darkorange">
		                                                <tr>
			                                            	<th style="text-align: center;">门店</th>
			                                                <th style="text-align: center;">专柜编码</th>
			                                                <th style="text-align: center;">专柜商品编码</th>
			                                                <th style="text-align: center;">专柜商品名称</th>
			                                                <th style="text-align: center;">供应商</th> 
			                                                <th style="text-align: center;">门店品牌</th>
			                                                <th style="text-align: center;">管理分类</th>
			                                                <th style="text-align: center;">状态</th>
			                                            </tr>
		                                            </thead>
		                                            <tbody>
			                                            <c:forEach items="${json.data.list }" var="list">
			                                            	<tr class="gradeX">
																<td align="center">${list.storeName}</td>
																<td align="center">${list.counterCode}</td>
																<td align="center">${list.productCode}</td>
																<td align="center">${list.productName}</td>
																<td align="center">${list.supplierName}</td>
																<td align="center">${list.brandName}</td>
																<td align="center">${list.glCategoryName}</td>
																<td align="center">
																	<c:if test="${list.isSale == 'Y'}">
																		<span class="label label-success graded"> 可售</span>
																	</c:if>
																	<c:if test="${list.isSale == 'N'}">
																		<span class="label label-darkorange graded"> 不可售</span>
																	</c:if>
																</td>
												       		</tr>
			                                            </c:forEach>
		                                            </tbody>
		                                        </table>
		                                        <br/>
		                                        <div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
													    <input class="btn btn-success" style="width: 25%;" id="save" type="button" value="修改" name="shoppe">&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="关闭"/>
													</div>
												</div>
												<br/>
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
															id="save" type="button" value="修改" name="profile"/>&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;"
															id="close" type="button" value="关闭" />
													</div>
												</div>
											</form>
											<div style="display: none;">
												<form id="statcateForm" method="post" class="form-horizontal">
													<input type="hidden"  id="statCategorySid" />
													<input type="hidden"  id="statCategoryName"/>
													<input type="hidden"  id="statIsLeaf"/>
											    </form>
									        </div>
										</div>
										<!-- propfileMessage end -->
										<!-- #show start -->
										<div id="show" class="tab-pane"></div>
										<!-- #show end -->
										
										<!-- #FinePack start -->
										<div id="FinePack" class="tab-pane">
											<div class="main-container container-fluid">
												<!-- Page Container -->
												<div class="page-container">
													<div class="page-body">
														<div class="row">
															<div class="col-lg-12 col-sm-12 col-xs-12">
																<div style="width: 25%; float: left;">
																	<div class="widget">
																		<div class="widget-header ">
																			<h5 class="widget-caption" id="widget">色系</h5>
																			<input id="hid_color" type="hidden"> <input
																				id="hid_product" type="hidden" value="${productCode}">
																		</div>
																		<div class="widget-body clearfix" id="colorBox1">
																			<c:forEach items="${colors}" var="color">
																				<a class="colorbox" colorSid="${color.sid}"
																					href="javascript:void(0);" title="${color.color_name}"
																					style="background: url('${pageContext.request.contextPath}/images/colorImg/${color.rgb}');"><i></i></a>
																			</c:forEach>
																		</div>
																	</div>
																</div>
																<div style="width: 72%; float: left; margin-left: 20px;">
																	<div class="widget">
																		<div class="widget-header ">
																			<h5 class="widget-caption" id="widget">精包装</h5>
																			<input type="hidden" id="skuCodeOne" value="">
																			<input type="hidden" id="packimgUrl" value="">
																			<a class="btn btn-default purple" id="addSku" onclick="openShow();"
																				style="margin: 2px 20px">预览</a>
																		</div>
																		<div class="widget-body clearfix" id="">
																			<div>
																				<span>标准名：</span>
																				<span id="productName_1"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																				<span type="text" id="shortDesc" style="float: right;margin-right: 20px;width: 40%"></span>
																				<span  style="float: right;">短名称：</span>
																				<br>
																				<br>
																				<span>描述名称：</span>
																				<span type="text" id="longDesc" style="width: 90%"></span>
																			</div>
																			<br>
																			<div id="showFinePack" style="max-height: 500px;min-height: 100px;overflow: auto;">
																				
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
														<div class="form-group">
															<div class="col-lg-offset-4 col-lg-6">
																<input class="btn btn-success" style="width: 25%;"
																	id="save" type="button" value="修改" name="FinePack"/>&emsp;&emsp;
																<input class="btn btn-danger" style="width: 25%;"
																	id="close" type="button" value="关闭" />
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
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
	
	<div class="modal modal-darkorange" id="SMTableDiv">
		<div class="modal-dialog" style="width: 600px; margin: 100px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeSMTable();">×</button>
					<h4 class="modal-title">色码对照表</h4>
				</div>
				<div class="modal-body" style="width:600px;height:300px;" id="SMTable_id">
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeSMTable();" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
</body>
<script type="text/javascript">
	$("#colorBox1 a").click(function() {
		$("#colorBox1 a").removeClass("color_on");
		$(this).addClass("color_on");
	});
	
	var list = jQuery('.colorbox');
	list.click(function() {
		var colorSid = $(this).attr("colorSid");
		getProPacking(colorSid);
		getSkuBySpuAndColor(colorSid);
		getSpuName($(this).attr("title"));
		return false;
	});
	
	function getProPacking(colorSid){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/productDesc/getProPackingBySkuAndColorSid",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			data : {
				"proSid" : $('#spuCode_from').val(),
				"colorSid" : colorSid
			},
			success : function(response) {
				if(response.success == "true" && response.data != ""){
					var data = response.data[0];
					$("#showFinePack").html(data.contents);
				} else {
					$("#showFinePack").html("");
				}
			}
		});
	}
	
	function getSpuName(color){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/getProBySpuCode",
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
				if(response != "undefined"){
					$("#productName_1").html(response[0].productName + "&nbsp;" + color);
					$("#shortDesc").html(response[0].shortDes=="null"?"无":response[0].shortDes || "无");
					$("#longDesc").html(response[0].longDesc=="null"?"无":response[0].longDesc || "无");
				}
			}
		});
	}
	
	$(function(){
		$("#colorBox1 a").each(function(){
			if($(this).attr("colorSid") == $("#SkuColorSid").val().trim()){
				$(this).click();
			} else {
				$(this).hide();
			}
		});
	});
	
	function getSkuBySpuAndColor(color){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/selectSkuProductBySpuAndColor",
			dataType : "json",
			async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class", "loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
			data : {
				"spuCode" : $('#spuCode_from').val(),
				"colorSid" : color
			},
			success : function(response) {
				var prolist = response.list;
				if(prolist != "undefined"){
					$("#skuCodeOne").val(prolist[0].skuCode);
					$("#packimgUrl").val(response.packimgUrl);
				}
			}
		});
	}
</script>
</html>