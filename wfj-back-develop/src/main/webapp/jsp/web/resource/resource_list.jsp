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

<title>资源管理</title>
	
<script src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-contextmenu.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script type="text/javascript"> 
 __ctxPath = "${pageContext.request.contextPath}";
 var sessionId = "<%=request.getSession().getId() %>";
</script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/resources/resource.js"></script>
<%-- <script src="${pageContext.request.contextPath}/js/customize/common/common.js"></script> --%>

</head>
<body>
    <div id="context-menu-channel">
	  <ul class="dropdown-menu" role="menu">
	      <li><a tabindex="1">创建目录</a></li>
	      <li class="divider"></li>
	      <!-- <li><a tabindex="2">添加</a></li> -->
	  </ul>
	</div>
	<div class="page-body" style="style:width:100%;">
	<%@ include file="../site/site_chose.jsp"%>
		<div class="widget-body">
			<div class="row">
				<div class="col-lg-3 col-sm-3 col-xs-3">
					<div class="web-header">资源加载</div>
					<div class="m10">
						<a id="sitDirUpload" class="btn btn-primary glyphicon glyphicon-plus" onclick="openZipPage();">站点目录上传 </a>
					</div>
					<div id="tree" class="tree web-tree" style="height:320px;"></div>
				</div>
				<div class="col-lg-9 col-sm-9 col-xs-9 p0 rightdiv">
					<div class="widget-header">
						<h5 class="widget-caption">资源管理</h5>
					</div>
					<form id="category_form" action="">
						<input type="hidden" id="cid" name="cid" />
					</form>
					<%@include file="resoureManage.jsp" %>
				</div>
				<%@include file="uploadDir.jsp" %>
		        <%@include file="uploadFile.jsp" %>
		        <%@include file="addResDir.jsp" %>
				<%@include file="renameRes.jsp" %>
			</div>
		</div>      
      </div>
</body>
</html>