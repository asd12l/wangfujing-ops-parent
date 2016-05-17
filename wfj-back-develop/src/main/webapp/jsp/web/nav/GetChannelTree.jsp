<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customize/getchannelTree.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customize/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/bootstrap/css/components.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsp/web/css/webStyle.css" />
<!-- 分页插件JS -->
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<!-- zTree -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
<script src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<!-- 文件上传提交方式JS -->
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<!-- 保存验证JS -->
<script src="${pageContext.request.contextPath}/js/jquery/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery.validate.messages_cn.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/common/validate.js"></script>
<!-- 导航tree -->
<script src="${pageContext.request.contextPath}/js/customize/nav/navZtree/navZtree.js"></script>
<!-- 频道JS -->
<script src="${pageContext.request.contextPath}/js/customize/nav/channel/channel.js"></script>
<!-- 商品与品牌JS -->
<script src="${pageContext.request.contextPath}/js/customize/nav/floor/floorlist.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/nav/floor/add_floor_product.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/nav/floor/add_floor_brand.js"></script>
<!-- 热词JS -->
<script src="${pageContext.request.contextPath}/js/customize/nav/hotword/hotword.js"></script>
<!-- 站点JS -->
<script src="${pageContext.request.contextPath}/js/customize/common/common.js"></script>
<!--Fuelux Spinner-->
<script src="${pageContext.request.contextPath}/assets/js/fuelux/spinner/fuelux.spinner.min.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	//查看频道下楼层按钮
	function toFloor() {
		if (channelId == "") {
			channelId = 1;
		}
		initFloorTree();
	}
</script>
<script id="navTreeRightDiv" type="text/html">
	<div id="rMenu">
		<ul class="dropdown-menu" role="menu">
			<li class="nav_root" onclick="addNav();"><a tabindex="1">添加导航</a></li>
			<li class="divider nav_root"></li>
			<li class="nav_child" onclick="updateNav();"><a tabindex="2">编辑导航</a></li>
			<li class="divider nav_child"></li>
			<li class="nav_child" onclick="deleteNav();"><a tabindex="3">删除导航</a></li>
			<li class="divider nav_child"></li>
			<li class="nav_child" onclick="checkNav();"><a tabindex="4">查看导航</a></li>
		</ul>
	</div>
</script>
<script id="floorTreeRightDiv" type="text/html">
	<div id="rMenuFloor">
		<ul class="dropdown-menu" role="menu">
			<li class="floor_root">
				<a tabindex="1" onclick="addFloorNode();">添加楼层</a>
			</li>
			<li class="divider floor_root"></li>
			<li class="floor_frist">
				<a tabindex="2" onclick="editFloor();">编辑楼层</a>
			</li>
			<li class="divider floor_frist"></li>
			<li class="floor_frist">
				<a tabindex="3" onclick="delDiv();">删除楼层</a>
			</li>
			<li class="divider floor_frist"></li>
			<li class="floor_frist"><a tabindex="4" onclick="loadFloorDetail();">查看楼层</a></li>
			<li class="divider floor_frist"></li>
			<li class="floor_two"><a tabindex="5" onclick="addResources();">添加资源</a></li>
			<li class="divider floor_two"></li>
			<li class="floor_two"><a tabindex="5" onclick="delDiv();">删除资源</a></li>
			<li class="divider floor_two"></li>
			<li class="floor_two"><a tabindex="6" onclick="renameFloorDiv();">修改资源</a></li>
		</ul>
	</div>
</script>
<script id="channelTreeRightDiv" type="text/html">
	<div id="rMenuChannel">
		<ul class="dropdown-menu" role="menu">
			<li class="channel_root" onclick="addChannel();"><a tabindex="1">添加频道</a></li>
			<li class="divider channel_child"></li>
			<li class="channel_child" onclick="editChannel();"><a tabindex="2">编辑频道</a></li>
			<li class="divider channel_child"></li>
			<li class="channel_child" onclick="delChannel();"><a tabindex="3">删除频道</a></li>
			<li class="divider channel_child"></li>
			<li class="channel_child" onclick="findChannel();"><a tabindex="4">预览频道</a></li>
		</ul>
	</div>
</script>
<style type="text/css">
	div#rMenu {position:absolute; visibility:hidden; top:0; background-color: #555;text-align: left;}
	div#rMenu ul li{
		margin: 1px 0;
		padding: 0 5px;
		cursor: pointer;
		list-style: none outside none;
	}
</style>
<style type="text/css">
	div#rMenuFloor {position:absolute; visibility:hidden; top:0; background-color: #555;text-align: left;}
	div#rMenuFloor ul li{
		margin: 1px 0;
		padding: 0 5px;
		cursor: pointer;
		list-style: none outside none;
	}
</style>
<style type="text/css">
	div#rMenuChannel {position:absolute; visibility:hidden; top:0; background-color: #555;text-align: left;}
	div#rMenuChannel ul li{
		margin: 1px 0;
		padding: 0 5px;
		cursor: pointer;
		list-style: none outside none;
	}
</style>
</head>
<body>
	<div class="page-body" style="style: width:100%;">
		<!-- 引入站点切换页面 -->
		<%@ include file="../site/site_chose.jsp"%>
		<div class="widget-body">
			<div class="row">
				<div class="col-lg-2 col-sm-2 col-xs-2">
					<div class="web-header">频道目录</span></div>
					<ul id="channelTree" class="ztree"></ul>
				</div>
				<div class="col-lg-10 col-sm-10 col-xs-10">
					<ul class="nav nav-tabs" id="myChannelTab">
						<li class="active"><a data-toggle="tab" href="#nav_page">
								导航 </a></li>
						<li class="tab-green"><a data-toggle="tab"
							id="floor_page_change" href="#floor_page">楼层</a></li>
						<!-- <li class="tab-green"><a data-toggle="tab" id="hot_search"
							href="#hot_search_page">热门搜索</a></li> -->
					</ul>
					<div class="tab-content clearfix">
						<!-- 引入导航页面 -->
						<div id="nav_page" class="tab-pane active">
							<%@ include file="naviManage.jsp"%>
						</div>
						<!-- 引入楼层页面 -->
						<div id="floor_page" class="tab-pane">
							<%@ include file="floor/floorManage.jsp"%>
						</div>
					</div>
				</div>
			</div>			
		</div>
	</div>
	<!-- 添加频道 -->
	<%@ include file="channel/addChannel.jsp"%>
	<!-- 修改频道 -->
	<%@ include file="channel/editChannel.jsp"%>
	<!-- 添加楼层下的品牌 -->
	<%@ include file="floor/addFloorBrand.jsp"%>
	<%-- <%@ include file="channel/viewChannel.jsp"%> --%>
	<!-- 预览框 -->
	<%@ include file="../showView.jsp"%>
</body>
</html>