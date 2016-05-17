<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% request.setAttribute("ctx", request.getContextPath());%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

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
			autoParam : [ "id", "categoryType" ],
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
		var now = new Date(), h = now.getHours(), m = now.getMinutes(), s = now.getSeconds();
		return (h + ":" + m + ":" + s);
	}
	var parametersLength = "";
	var categorySid = "";
	var categoryName = "";
	function onClick(event, treeId, treeNode, clickFlag) {
		if (treeNode.isLeaf == "Y") {
			if (treeNode.categoryType == 0) {
				// 更换请选择
				$("#baseA").html(treeNode.name);
				categorySid = treeNode.id;
				categoryName = treeNode.name;
				$("#treeDown").attr("treeDown", "true");
			} 
			$("#baseBtnGroup").attr("class", "btn-group");
		} else {
			$("#warning2Body").text("请选择末级分类!");
			$("#warning2").attr("style", "z-index:9999;");
			$("#warning2").show();
		}
	}
	
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
	
	// Tree工业分类请求
	function treeGetCategory() {
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
	
	$("#treeDown").click(function(){
		$("#baseA").text("请选择");
		categorySid = "";
		categoryName = "";
		treeGetCategory();
	});
	
	$(function() {
		
		$("#brandSid_select").one("click",function(){
			$.ajax({
				type : "post",
				url : __ctxPath + "/brandDisplay/queryBrandGroupList",
				async : false,
				data : "brandType=0",
				dataType : "json",
				success : function(response) {
					var list = response.list;
					for (var i = 0; i < list.length; i++) {
						var ele = list[i];
						var option = "<option value='"+ele.sid+"'>" + ele.brandName + "</option>";
						$("#brandSid_select").append(option);
					}
					return;
				},
				error : function(XMLHttpRequest, textStatus) {
					var sstatus = XMLHttpRequest
							.getResponseHeader("sessionStatus");
					if (sstatus != "sessionOut") {
						$("#warning2Body").text(buildErrorMessage("","系统出错！"));
						$("#warning2").show();
					}
					if (sstatus == "sessionOut") {
						$("#warning3").css('display', 'block');
					}
				}
			});
		});
		
		$("#save").click(function(){
			var flag = false;
			$("input[name='limitValues']").each(function(){
				var limitValue = $(this).val().trim();
				var reg = /^[1-9]{1}[0-9]{0,4}$/;
				if(limitValue.match(reg) == null){
					flag = true;
				}
			});
			if (flag) {
				$("#warning2Body").text("阀值必须是正整数!");
				$("#warning2").show();
				return false;
			}
		});
		
		$('#theForm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			submitHandler : function(validator, form, submitButton) {
				// Do nothing
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr("class","loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container").addClass("loading-inactive");
						}, 300);
					},
					url : __ctxPath + "/productlimit/addProductLimitList",
					data : $("#theForm").serialize(),
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
							$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
						} else if (response.data.errorMsg != "") {
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
							$("#warning2").show();
						}
						return;
					},
					error : function(XMLHttpRequest, textStatus) {
						var sstatus = XMLHttpRequest
								.getResponseHeader("sessionStatus");
						if (sstatus != "sessionOut") {
							$("#warning2Body").text(buildErrorMessage("","系统出错！"));
							$("#warning2").show();
						}
						if (sstatus == "sessionOut") {
							$("#warning3").css('display', 'block');
						}
					}
				});
		}

	}).find('button[data-toggle]').on('click',function() {
		var $target = $($(this).attr('data-toggle'));
		$target.toggle();
		if (!$target.is(':visible')) {
			$('#theForm').data('bootstrapValidator').disableSubmitButtons(false);
		}
	});

	$("#close").click(
		function() {
			$("#pageBody").load(__ctxPath + "/jsp/productLimit/productLimitView.jsp");
		});
	});

	function successBtn() {
		$("#modal-success").attr({"style" : "display:none;","aria-hidden" : "true","class" : "modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/productLimit/productLimitView.jsp");
	}

	function addLimit() {
		var brandSid = $("#brandSid_select").val();
		if (brandSid == "") {
			$("#warning2Body").text("请选择品牌!");
			$("#warning2").show();
			return;
		}
		
		var flag = false;
		$("input[name='limitCheckbox']").each(function(i) {
			if (brandSid == $(this).attr("brandSid") && categorySid == $(this).attr("categorySid")) {
				flag = true;
			}
		});
		if (flag) {
			$("#warning2Body").text("不能重复添加!");
			$("#warning2").show();
			return;
		}
		var brandName = $("#brandSid_select").find("option:selected").html().trim();
		var option = "<tr id='limitTableTr_"+ brandSid +"'>"
				+ "<td><div><label style='padding-left: 5px;'>"
				+ "<input type='checkbox' name='limitCheckbox' brandSid='" + brandSid + "' categorySid='" + categorySid + "'>"
				+ "<span class='text'></span></label></div></td>"
				+ "<td align='center'>" + brandName	
				+ "<input type='hidden' name='brandSids' value='" + brandSid + "'/></td>"
				+ "<td align='center'>" + categoryName 
				+ "<input type='hidden' name='categorySids' value='" + categorySid + "'/></td>"
				+ "<td align='center'><input type='text' name='limitValues' placeholder='阀值必须是大于1的20位的数字!' style='width:170px;'/></td>"
				+ "<td align='center' style='display:none'><select name='statuses' style='width:60px;text-align:center;'>"
				+ "<option value='1'>禁用</option><option selected='selected' value='0'>启用</option></select></td>"
				+ "</tr>";
		$("#limitTable tbody").append(option);
		return;
	}
	function deleteLimit() {
		$("input[type='checkbox']:checked").each(function() {
			$("#limitTableTr_" + $(this).attr("brandSid")).remove();
		});
		return;
	}
</script>
</head>
<body>
	<div class="page-body">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">添加库存阀值</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="optName" value="" />
									<script type="text/javascript">
										$("input[name='optName']").val(getCookieValue("username"));
									</script>
									<div class="table-toolbar">
											<span>集团品牌<font style="color: red;">(*必选)</font></span>&nbsp;
											<select class="form-control" style="padding: 0 0;width: 200px" id="brandSid_select">
												<option value="">请选择</option>
											</select>&nbsp;&nbsp;&nbsp;
											<span>工业分类</span>&nbsp;
											<div class="btn-group" id="baseBtnGroup" style="width: 25%">
												<a href="javascript:void(0);" class="btn btn-default" id="baseA" style="width: 80%;">请选择</a> 
												<a id="treeDown" href="javascript:void(0);" class="btn btn-default" treeDown="true">
													<i class="fa fa-angle-down"></i>
												</a>
												<ul id="treeDemo" class="dropdown-menu ztree form-group" style="margin-left: 0; width: 98%; position: absolute;"></ul>
											</div>
											<a class="btn btn-default" onclick="addLimit();">添加</a>&nbsp; 
											<a class="btn btn-danger" onclick="deleteLimit();">删除</a>
									</div>
									<div class="form-group">
										<div class="col-md-12">
											<table id="limitTable" class="table table-bordered table-striped table-condensed table-hover flip-content">
												<thead class="flip-content bordered-darkorange">
													<tr>
														<th width="20px;"></th>
														<th style="text-align: center;">集团品牌</th>
														<th style="text-align: center;">工业分类</th>
														<th style="text-align: center;">下限阀值</th>
													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>
										</div>
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save" type="submit">保存</button>&emsp;&emsp; 
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消" />
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
	<!-- /Page Body -->
</body>
</html>