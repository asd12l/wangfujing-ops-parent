<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--Page Related Scripts-->
<html>
<head>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/customize/getchannelTree.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customize/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsp/web/css/webStyle.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

	
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";
	var myPagination="";
	$(function(){
		/* $("#site_list").change(function(){
			siteSid=$("#site_list").val();
		}); */
	});
	function initTree(){
		
	}
	function createIndex() {
		$
		.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/statics/index",
			dataType : "json",
			data:{
				"_site_id_param":siteSid,
				"channelId":1,
				"indexFlag":1
			},
			success : function(response) {
				if (response.respStatus==1) {
					$("#modal-body-success")
							.html(
									"<strong>成功创建，返回列表页!</strong>");
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
				} else {
					$("#model-body-warning")
							.html(
									"<strong>生成失败!</strong>");
					$("#modal-warning").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-warning"
					});
				}
				return;
			}
		});
	}
	function deleteIndex() {
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/statics/indexRemove",
					dataType : "json",
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<strong>删除成功，返回列表页!</strong>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
						} else {
							$("#model-body-warning")
									.html(
											"<strong>删除失败!</strong>");
							$("#modal-warning").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
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
		//$("#pageBody").load(__ctxPath + "/jsp/Brand/BrandView.jsp");
	}
</script>
<script src="${pageContext.request.contextPath}/js/customize/common/common.js"></script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
			<%@ include file="../web/site/site_chose.jsp"%>
				<div class="widget">
				    <div class="widget-header ">
						<h5 class="widget-caption">页面静态化</h5>
						<div class="widget-buttons">
							<a href="#" data-toggle="collapse" onclick="tab('pro');"> <i class="fa fa-minus" id="pro-i"></i></a>
						</div>
					</div>
					<div class="widget-body" id="pro">
						<div class="table-toolbar">
							<a id="createButton" onclick="createIndex();" class="btn btn-info"><i class="fa fa-wrench"></i> 生成首页HTML </a>&nbsp;&nbsp;
							<a id="deleteButton" onclick="deleteIndex();" class="btn btn-danger"><i class="fa fa-times"></i> 删除首页HTML </a>
						</div>
					</div>
				</div>
			</div>
			<!-- /Page Body -->
		</div>
		<!-- /Page Content -->
</body>
</html>