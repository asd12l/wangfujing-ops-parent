<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/js/My97DatePicker/skin/WdatePicker.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsp/web/css/webStyle.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/customize/common.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-contextmenu.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<!-- JS验证 -->
<script src="${pageContext.request.contextPath}/js/jquery/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery.validate.messages_cn.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/common/validate.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/topic/toplist.js"></script>
<!-- 楼层配置JS -->
<script src="${pageContext.request.contextPath}/js/customize/topic/topicfloor.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/topic/div_manage.js"></script>
<!-- 商品JS -->
<script src="${pageContext.request.contextPath}/js/customize/topic/add_floor_product.js"></script>
<!-- 品牌JS -->
<script src="${pageContext.request.contextPath}/js/customize/topic/add_floor_brand.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/common/common.js"></script>
<!-- 上传JS -->
<script src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
<!--Fuelux Spinner-->
<script src="${pageContext.request.contextPath}/assets/js/fuelux/spinner/fuelux.spinner.min.js"></script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
			<!-- 引入站点切换页面 -->
			<%@ include file="../site/site_chose.jsp"%>
				<div id="topic_list" class="row">
					<div class="widget">
						<div class="widget-header ">
							<h5 class="widget-caption">专题活动管理</h5>
							<div class="widget-buttons">
								<a href="#" data-toggle="collapse" onclick="tab('pro');"> <i class="fa fa-minus" id="pro-i"></i>
								</a>
							</div>
						</div>
						<div class="widget-body" id="pro">
							<div class="m10 clearfix">
                           		<a id="editabledatatable_add" onclick="addDir();" class="btn btn-palegreen glyphicon glyphicon-plus">
								添加活动</a>&nbsp;&nbsp;
                           		<a id="editabledatatable_edit" onclick="editDir();" class="btn btn-info glyphicon glyphicon-wrench">
								编辑活动</a>&nbsp;&nbsp;
                           		<a id="editabledatatable_del" onclick="delDir();" class="btn btn-danger glyphicon glyphicon-trash">
									删除活动</a>
							</div>
							<div class="table-toolbar">
								<table
									class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="topic_tab">
									<thead class="flip-content bordered-darkorange">
										<tr>
											<th style="text-align: center;width:72px;">选择</th>
											<th style="text-align: center;width:120px;">名称</th>
											<th style="text-align: center;width:25%;">描述</th>
											<th style="text-align: center;">链接地址</th>
											<th style="text-align: center;width:130px;">开始时间</th>
											<th style="text-align: center;width:130px;">结束时间</th>
											<th style="text-align: center;width:50px;">顺序</th>
											<th style="text-align: center;">状态</th>
											<th style="text-align: center;width: 100px;">操作</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="topic_form" action="">
										<div class="col-lg-12">
											<select id="pageSelect" name="pageSize">
												<option>5</option>
												<option selected="selected">10</option>
												<option>15</option>
												<option>20</option>
											</select>
										</div>
									</form>
								</div>
								<div id="topicPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="topic-list" rows="0" cols="0">
								<!-- 
								{#template MAIN}
									{#foreach $T.list as Result}
										<tr class="gradeX" style="height: 20px;">
											<td align="left">
												<div class="checkbox">
													<label>
														<input type="checkbox" id="tdCheckbox_{$T.Result.id}" value="{$T.Result.id}" >
														<span class="text"></span>
													</label>
												</div>
											</td>
											<input type='hidden' id='shortName_{$T.Result.id}' value='{$T.Result.shortName}'/>
											<input type='hidden' id='keyWords_{$T.Result.id}' value='{$T.Result.keyWords}'/>
											<input type='hidden' id='description_{$T.Result.id}' value='{$T.Result.description}'/>
											<input type='hidden' id='path_{$T.Result.id}' value='{$T.Result.path}'/>
											<input type='hidden' id='titleImg_{$T.Result.id}' value='{$T.Result.titleImg}'/>
											<input type='hidden' id='tplContent_{$T.Result.id}' value='{$T.Result.tplContent}'/>
											<input type='hidden' id='recommend_{$T.Result.id}' value='{$T.Result.recommend}'/>
											
											<td align="center" id="name_{$T.Result.id}">{$T.Result.name}</td>
											<td align="center" style="display:none;" id="name_{$T.Result.id}">{$T.Result.shortName}</td>
											<td align="center" style="display:none;" id="name_{$T.Result.id}">{$T.Result.keyWords}</td>
											<td align="center" id="desc_{$T.Result.id}">
												<div title="{$T.Result.description}" style="width: 250px;height:35px;overflow: hidden;">{$T.Result.description}</div>
											</td>
											<td align="center" id="topiclink_{$T.Result.id}">
												<a href="{$T.Result.frontUrl}" target="_blank">{$T.Result.frontUrl}</a>
											</td>
											<td align="center" id="startTime_{$T.Result.id}">{$T.Result.startTime}</td>
											<td align="center" id="endTime_{$T.Result.id}">{$T.Result.endTime}</td>
											<td align="center" id="priority_{$T.Result.id}">{$T.Result.priority}</td>
											{#if $T.Result.recommend}
											<td align="center"><span class="label label-success graded">启用</span></td>
											{#else}<td align="center"><span class="label label-danger graded">未启用</span></td>
											{#/if}
											<td align="center">
												<a style="cursor:pointer;" onclick="set_topic({$T.Result.id});">配置</a>&#12288;
												<a style="cursor:pointer;" onclick="static_topic({$T.Result.id});">静态化</a>
											</td>
											
							       		</tr>
									{#/for}
							    {#/template MAIN}	 -->
							</textarea>
							</p>
						</div>
					</div>
				</div>
				<div id="topic_floor" style="display:none;">
					<!-- 右键菜单 -->
					<div id="context-menu-floor" class="tree_parent">
						<ul class="dropdown-menu" role="menu">
							<li class="floor_frist" id="context-menu-floorLi1">
								<a tabindex="1" onclick="addFloor();">添加楼层</a>
							</li>
							<li class="divider floor_frist" id="context-menu-floorLi1_"></li>
							<li class="floor_frist" id="context-menu-floorLi2">
								<a tabindex="3" onclick="addFloorDIV();">添加块/块组</a>
							</li>
							<li class="divider floor_two" id="context-menu-floorLi2_"></li>
							<li class="floor_two" id="context-menu-floorLi3">
								<a tabindex="5" onclick="addResources();">添加资源</a>
							</li>
							<li class="divider floor_frist floor_two" id="context-menu-floorLi3_"></li>
							<li class="floor_frist floor_two" id="context-menu-floorLi4">
								<a tabindex="2" onclick="editDiv();">修改</a>
							</li>
							<li class="divider floor_frist floor_two" id="context-menu-floorLi4_"></li>
							<li class="floor_frist floor_two" id="context-menu-floorLi5">
								<a tabindex="3" onclick="delTreeNode();">删除</a>
							</li>
						</ul>
					</div>
					<div class="col-md-3" style="padding: 0px; width: 25%;">
						<div class="well with-header tree_parent">
							<div class="header bordered-green">
								<label class="col-md-6">楼层树</label>
								<div class="col-md-3">
									<a onclick="initFloorTree();" class="btn btn-default btn-sm">刷新</a>
								</div>
								<div class="col-md-3">
									<a onclick="view_topicfloor();" class="btn btn-default btn-sm">预览</a>
								</div>
							</div>
							<div id="topic_floor_tree" class="" style="height:500px;overflow: auto; border: 1px;"></div>
						</div>
					</div>
					<%@ include file="topic_divManage.jsp" %>
				</div>
				<!-- /Page Body -->
			</div>
			<!-- /Page Content -->
		</div>
		
		<!-- 添加/修改活动 -->
		<%@ include file="add_topic.jsp"%>
		<%@ include file="edit_topic.jsp"%>
		<!-- 添加/修改楼层 -->	
		<%@ include file="addFloor.jsp"%>
		<%@ include file="editFloor.jsp"%>
		<%@ include file="div_rename.jsp"%>
		<%@ include file="add_div.jsp"%>
		<%@ include file="edit_div.jsp"%>
		<%@ include file="edit_floor.jsp"%>
		<%@ include file="addFloorProduct.jsp"%>
		<%@ include file="./addFloorBrand.jsp"%>
		<%@ include file="addFloorLink.jsp"%>
		<%@ include file="editFloorLink.jsp"%>
		<!-- 预览框 -->
		<%@ include file="../showView.jsp"%>
	</div>
</body>
</html>