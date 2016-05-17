<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsp/web/css/webStyle.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>模板管理</title>

<script src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-contextmenu.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script type="text/javascript"> 
 __ctxPath = "${pageContext.request.contextPath}";
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>		
<script src="${pageContext.request.contextPath}/js/customize/template/template.js"></script>
<%-- <script src="${pageContext.request.contextPath}/js/customize/common/common.js"></script>
 --%>
</head>
<body>
    <div id="context-menu-channel">
	  <ul class="dropdown-menu" role="menu">
	      <li><a tabindex="1">创建目录</a></li>
	      <li class="divider"></li>
	      <li><a tabindex="2">创建模板</a></li>
	  </ul>
	</div>
	<div class="page-body" style="style:width:100%;">
	<%@ include file="../site/site_chose.jsp"%>
		<div class="widget-body">
			<div class="row">
				<div class="col-lg-3 col-sm-3 col-xs-3">
					<div class="web-header">模板加载</div>
					<div class="m10">
                   		<a id="sitDirUpload" class="btn btn-primary glyphicon glyphicon-plus" onclick="openZipPage();">目录文件上传 </a>
					</div>
					<div id="tree" class="tree web-tree" style="height:320px;"></div>
				</div>
				<div class="col-lg-9 col-sm-9 col-xs-9 p0 rightdiv">
					<div class="widget-header">
						<h5 class="widget-caption">模板管理</h5>
					</div>
					<form id="category_form" action="">
						<input type="hidden" id="cid" name="cid"/>
					</form>
					<%@include file="tplManage.jsp" %>
				</div>
				<%@include file="uploadDir.jsp" %>
				<%@include file="uploadFile.jsp" %>
				<%@include file="addTpl.jsp" %>
				<%@include file="addTplDir.jsp" %>
			</div>
		</div>
	</div>
</body>
</html>