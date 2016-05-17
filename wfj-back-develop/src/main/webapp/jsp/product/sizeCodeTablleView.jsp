<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
WFJBackWeb - 尺码对照表
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--Jquery Select2-->
<script
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
<!-- 图片上传 -->
<script type="text/javascript" 
	src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
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
<script type="text/javascript">
//查询所有集团品牌
/* function findBrand() {
	$("#BrandCode").html("");
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/brandDisplay/queryBrandGroupListPartInfo",
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
			if(response.list == null || response.list == "")
				return;
			var result = response.list;
			var option = "<option value=''>请选择</option>";
			for (var i = 0; i < result.length; i++) {
				var ele = result[i];
				option += "<option value='"+ele.brandSid+"'>"
						+ ele.brandName + "</option>";
			}
			$("#BrandCode").html(option);
			return;
		}
	});
	$("#BrandCode").select2();
	$(".select2-arrow b").attr("style", "line-height: 2;");
	return;
} */

function findCategory(cateCode){
	var brandCode = $("#BrandCode option:selected").attr("sid");
	if(brandCode == ""){
		$("#warning2Body").text("请选择集团品牌!");
		$("#warning2").attr("style", "z-index:9999;");
		$("#warning2").show();
	} else {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/product/getBrandCateInfo",
			async : false,
			data : {
				"brandCode" : brandCode,
				"categoryCode" : cateCode
			},
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr(
						"class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(
						function() {
							$("#loading-container")
									.addClass(
											"loading-inactive");
						}, 300);
			},
			success : function(response) {
				if(response.data == null || response.data == ""){
					$("#warning2Body").text("本集团品牌下没有该品类!");
					$("#warning2").attr("style", "z-index:9999;");
					$("#warning2").show();
					$("#addSizeCodeButton").hide();
					$("#editSizeCodeButton").hide();
					$("#imgDiv").html("");
					return;
				}
				var result = response.data[0];
				$("#category").val(result.cateCode);
				$("#category").attr("cateName", result.cateName)
				              .attr("sizeCodeUrl", result.sizePictureUrl);
				showSizeCodeTableImg();
				return;
			}
		});
	}
	return;
}

function showSizeCodeTableImg(){
	var imgUrl = $("#category").attr("sizeCodeUrl");
	//var imgUrl = "${pageContext.request.contextPath}/images/cloud.png";
	if(imgUrl != ""){
		$("#imgDiv").html("<img src='"+imgUrl+"?"+(new Date()).valueOf()+"' style='width:500px;height:370px;'>");
		$("#editSizeCodeButton").show();
		$("#addSizeCodeButton").hide();
	} else {
		$("#imgDiv").html("无");
		$("#addSizeCodeButton").show();
		$("#editSizeCodeButton").hide();
	}
}
</script>
<!-- zTree品类 -->
<script type="text/javascript">
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
function onClick(event, treeId, treeNode, clickFlag) {
	if (treeNode.isLeaf == "Y") {
		if (treeNode.categoryType == 0) {
			$("div[name='after']").remove();
			// 更换请选择汉字
			$("#baseA").html(treeNode.name);
			$("#categoryCode").val(treeNode.code);
			$("#treeDown").attr("treeDown", "true");
			findCategory(treeNode.code);
		}
		$("#baseBtnGroup").attr("class", "btn-group");
	} else {
		$("#warning2Body").text("请选择末级分类!");
		$("#warning2").attr("style", "z-index:9999;");
		$("#warning2").show();
	}
}

//Tree工业分类请求
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
			$("#loading-container").attr(
					"class",
					"loading-container");
		},
		ajaxStop : function() {
			//隐藏加载提示
			setTimeout(
					function() {
						$("#loading-container")
								.addClass(
										"loading-inactive");
					}, 300);
		},
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
</script>
<script type="text/javascript">
//添加尺码对照表
function addSizeCodeTable(){
	$("#sizeCodeImage").click();
}
//修改尺码对照表
function editSizeCodeTable(){
	$("#sizeCodeImage").click();
}

function saveSizeCodeTable(url){
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/product/addBrandCateInfo",
		async : false,
		data : {
			"brandCode" : $("#BrandCode option:selected").attr("sid"),
			"categoryCode" : $("#category").val(),
			"sizeCodeUrl" : url,
			"status" : 0,
			"optUser" : $("#userName").val()
		},
		dataType : "json",
		ajaxStart : function() {
			$("#loading-container").attr(
					"class",
					"loading-container");
		},
		ajaxStop : function() {
			//隐藏加载提示
			setTimeout(
					function() {
						$("#loading-container")
								.addClass(
										"loading-inactive");
					}, 300);
		},
		success : function(response) {
			if(response.success == "true"){
				$("#imgDiv").html(
	     				"<img src='"+url+"?"+(new Date()).valueOf()+"' style='width:500px;height:370px;'>");
				$("#editSizeCodeButton").show();
				$("#addSizeCodeButton").hide();
			} else {
				$("#warning2Body").text(response.data);
	    		$("#warning2").attr("style", "z-index:9999;");
	    		$("#warning2").show();
			}
			return;
		}
	});
}

function uploadImg(){
	$.ajaxFileUpload({
	     url:__ctxPath+"/upImg/uploadSizeCodeTable-noMulti",
	     type: "POST",
	     secureuri: true,
	     fileElementId: 'sizeCodeImage',
	     data : {
	    	 "brandCode" : $("#BrandCode option:selected").attr("sid"),
	    	 "cateCode" : $("#category").val()
	     },
	     dataType: "json",
	     ajaxStart : function() {
			$("#loading-container").attr("class","loading-container");
		 },
		 ajaxStop : function() {
				//隐藏加载提示
			setTimeout(function() {
				$("#loading-container").addClass("loading-inactive");
					}, 300);
			},
	     success: function (data) {
	     	if(data.success == "true"){
	     		saveSizeCodeTable(data.url);
	     	} else {
	     		$("#warning2Body").text(data.data);
	    		$("#warning2").attr("style", "z-index:9999;");
	    		$("#warning2").show();
	     	}
	     },
 		 error: function (data, status, e){//服务器响应失败处理函数
 			$("#warning2Body").text("系统错误，上传失败");
    		$("#warning2").attr("style", "z-index:9999;");
    		$("#warning2").show();
         }
	 });
}

</script>
<script type="text/javascript">
	function showBrandGroup(){
		$("#pageBodyBrandGroup").load(__ctxPath + "/jsp/product/selectBrand.jsp");
		$("#selectBrandGroup").show();
	}
	function closeBrandGroup(){
		$("#selectBrandGroup").hide();
	}
</script>
<script type="text/javascript">
$(function(){
	//$("#BrandCode").select2();
	//findBrand();
	$("#BrandCode_input").keyup(function(e){
		var e = e || event;
		var code = e.keyCode;
		if(code != 32 && !(code >=37 && code <= 40) && !(code >=16 && code <= 18) && code != 93){
			seachData($("#BrandCode_input").val());
		}
		});
	treeDeme();
	
	$("#BrandCode").change(function(){
		if($("#categoryCode").val() != ""){
			findCategory($("#categoryCode").val());
		}
	});
	
	// 控制tree
	$("#treeDown").click(function() {
		if ($(this).attr("treeDown") == "true") {
			$(this).attr("treeDown", "false");
			$("#baseBtnGroup").attr("class", "btn-group open");
		} else {
			$(this).attr("treeDown", "true");
			$("#baseBtnGroup").attr("class", "btn-group");
		}
	});
	
	
});
</script>
</head>
<body>
	
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight" style="min-height:600px;">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">尺码对照表管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
								<input type="hidden" id="userName" value="">
								<script type="text/javascript">
									$("input[name='userName']").val(getCookieValue("username"));
								</script>
							</div>
							<div class="widget-body clearfix" id="pro" style="padding-top: 20px;">
								<div class="col-md-4" style="padding: 0">
									<label class="col-md-4 control-label" 
										style="text-align:right;margin-top:6px;width:80px;padding:0;">集团品牌：</label>
									<div class="col-md-10 js-data-example-ajax" style="width:270px;">
										<!-- <select id="BrandCode" name="brandSid"
											style="width: 100%;display: none;">
											<option value="-1" sid="">请选择</option>	
										</select>
										<input id="BrandCode_input" type="text" readonly="readonly" value="请单击选择集团品牌" code="-1"
											style="width:100%;height:35px;background: white;"> -->
										<select id="BrandCode" name="brandSid"
											style="width: 100%;display: none;">
											<option value="" sid="">请选择</option>	
										</select>
										<input id="BrandCode_input" class="_input" type="text"
											   value="" placeholder="请输入集团品牌" autocomplete="off">
										<div id="dataList_hidden" class="_hiddenDiv" style="width:91%;">
											<ul></ul>
										</div>
									</div>
								</div>
								<div class="col-md-4" style="padding: 0">
									<label class="col-md-4 control-label" 
										style="text-align:right;margin-top:6px;width:80px;padding:0;">品类：</label>
									<div class="col-md-10" style="width:270px;">
										<div class="btn-group" style="width: 100%"
												id="baseBtnGroup">
											<a href="javascript:void(0);" class="btn btn-default"
												id="baseA" style="width: 83%;">请选择</a> <a id="treeDown"
												href="javascript:void(0);" class="btn btn-default"
												treeDown="true"><i class="fa fa-angle-down"></i></a>
											<ul id="treeDemo" class="dropdown-menu ztree form-group"
												style="margin-left: 0; width: 98%; position: absolute;;max-height: 200px;overflow-y: auto;"></ul>
											<input type="hidden" id="categoryCode"
												name="categoryCode" />
										</div>
									</div>
									<input type="hidden" id="category"/>
								</div>
								<div class="col-md-4">
									<a id="addSizeCodeButton" onclick="addSizeCodeTable();" style="display: none"
										class="btn btn-primary">
										<i class="fa fa-plus"></i>
										新增尺码对照表
									</a>
									<a id="editSizeCodeButton" onclick="editSizeCodeTable();" style="display: none">
										<span class="btn btn-blue">
											<i class="fa fa-edit"></i>
											修改尺码对照表
										</span>
									</a>
								</div>
								<div style="display: none">
								    <form action="">
								        <input type="file" onchange="uploadImg();" name="sizeCodeImage" id="sizeCodeImage"/>
								    </form>
								</div>
								<br>
								<hr class="" style="margin: 30px 10px 20px 10px;">
								<div class="col-md-10">
									<label class="col-md-2 control-label">尺码对照表：</label>
									<div class="col-md-10 js-data-example-ajax" id="imgDiv">
										无
									</div>
								</div>
							</div>
							
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
</body>
</html>