<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
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
<style type='text/css'>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<!--  
  <script type="text/javascript" src="${ctx}/sysjs/TreeSelector.js"></script>
  <script type="text/javascript" src="${ctx}/outh/backUserview.js"></script>
  <script type="text/javascript" src="${ctx}/outh/addBackUser.js"></script>
  <script type="text/javascript" src="${ctx}/outh/addLogisticsUser.js"></script>
 <script type="text/javascript" src="${ctx}/outh/backUserGrantRoleWindow.js"></script>
  <script type="text/javascript" src="${ctx}/outh/updateUserRole.js"></script>
  -->
<script
	src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var brandPagination;
	var activePagination;
	var channelId = "";
	var navId="";
	$(function() {
		//初始化树形频道
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/channel/channeltree",
			async : false,
			dataType : "json",
			success : function(response) {
				$('#tree').treeview({
					data : response,
					onNodeSelected : function(event, node) {
						channelId = node.id;
						loadNavTree(channelId);
					}
				});
				loadNavTree(0);
			}
		});
	});
	
	//折叠面板函数
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
			}
		}
	}
	
	//加载导航树
	function loadNavTree(channelSid){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/navigation/selecNavTree",
			async : false,
			dataType : "json",
			data :{"channelSid":channelSid},
			success : function(response) {
				$('#navtree').treeview({
					data : response,
					onNodeSelected : function(event, node) {
						navId = node.id;
						initBrand(navId);
						initActive(navId);
						
					}
				});
				initBrand(0);
				initActive(0);
			}
		});
	}
	
	
	//添加导航分类
	function addNav(){
		var html = $("#navtree .node-selected").html();
		if(html!=undefined){			
			$("#addNave").show();
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>为选中节点!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	}
	
	//修改导航分类
	function editNav(){  
		var html = $("li[class='list-group-item node-tree node-selected']").html();
		if(html!=undefined){
			$("#divId").val("");
			$.ajax({
		        type:"post",
		        url:__ctxPath + "/category/edit?id="+nodeId,
		        dataType: "json",
		        success:function(response) {
		        	$("#name").val(response.name);
		        	if(response.status==1){
		        		$("#status1").attr("checked","checked");
		        	}else{
		        		$("#status0").attr("checked","checked");
		        	}
		        	if(response.isDisplay == 1){
		        		$("#isDisplay1").attr("checked","checked");
		        	}else{
		        		$("#isDisplay0").attr("checked","checked");
		        	}
		    	}
			});
			$("#divSid").val(nodeId);
			$("#categoryDIV").show();
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>为选中节点!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	}
	
	//删除导航分类
	function delNav(){
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				$.ajax({
			        type:"post",
			        url:__ctxPath + "/category/del?id="+nodeId,
			        dataType: "json",
			        success:function(response) {
			        	if(response.status == 'success'){
							$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
								"<i class='fa-fw fa fa-times'></i><strong>操作成功，返回列表页!</strong></div>");
				  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
						}else{
							$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>操作失败!</strong></div>");
			     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
						}
			    	}
				});
			}
		});
	}
	
	
	
	//频道信息初始化
	function initBrand(navSid) {
		brandPagination = $("#brandPagination").myPagination(
				{
					panel : {
						tipInfo_on : true,
						tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
						tipInfo_css : {
							width : '25px',
							height : "20px",
							border : "2px solid #f0f0f0",
							padding : "0 0 0 5px",
							margin : "0 5px 0 5px",
							color : "#48b9ef"
						}
					},
					debug : false,
					ajax : {
						on : true,
						url : __ctxPath + "/navigation/queryNavBrand?navSid="+navSid,
						dataType : 'json',
						ajaxStart : function() {
							//ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								ZENG.msgbox.hide();
							}, 300);
						},
						callback : function(data) {
							//使用模板
							$("#brand_tab tbody").setTemplateElement(
									"brand-list").processTemplate(data);
						}
					}
				});
	}
	
	//编辑频道栏目
	function editPageLayout(propsSid, categorySid, channelSid) {
		
	}	
	
	
	//初始化活动列表
	function initActive(navSid) {
		activePagination = $("#activePagination").myPagination(
				{
					panel : {
						tipInfo_on : true,
						tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
						tipInfo_css : {
							width : '25px',
							height : "20px",
							border : "2px solid #f0f0f0",
							padding : "0 0 0 5px",
							margin : "0 5px 0 5px",
							color : "#48b9ef"
						}
					},
					debug : false,
					ajax : {
						on : true,
						url : __ctxPath + "/navigation/queryNavPromotion?navSid="+navSid,
						dataType : 'json',
						ajaxStart : function() {
							//ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								ZENG.msgbox.hide();
							}, 300);
						},
						callback : function(data) {
							//使用模板
							$("#active_tab tbody").setTemplateElement(
									"active-list").processTemplate(data);
							$('.desc').each(function(){
								$(this).html($(this).text());
							});
						}
					}
				});
	}
	
	//按钮事件-添加活动
	function addAdv(){
		bootbox.confirm("确定添加活动吗？", function(r){
			if(r){
				var url = __ctxPath+"/jsp/web/addAdv.jsp";
				$("#pageBody").load(url);
			}
		});
	}
	//删除活动
	function delActive(propsSid, categorySid, Sid) {

	}
	
	</script>
</head>
<body>
	<div class="page-body" style="position: fixed;">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="container">
							<div class="col-md-3"
								style="padding-left: 0px; width: 20%; margin-top: 2px;">
								<div class="well with-header">
									<div class="header bordered-green">频道管理</div>
									<div class=" " id="tree" ></div>
								</div>								
							</div>
							 <div class="col-md-3" style="padding-left: 0px;width: 25%;margin-top: 2px;">
						          <div class="well with-header">
						          	<div class="header bordered-green">导航分类</div>
						          	<div>
						          		<a class="btn btn-default shiny fa fa-plus" onclick="addNav();">添加</a>&nbsp;
						          		<a class="btn btn-default shiny fa fa-edit" onclick="edit()">修改</a>&nbsp;
						          		<a class="btn btn-default shiny fa fa-times" onclick="categoryDel()">删除</a>
									</div>
						            <div id="navtree" style="margin-top: 10px;"></div>
						          </div>
						      </div>
							<div class=""
								style="float: left; width: 50%; overflow: auto; height: 550px;">
								<div class="col-xs-12 col-md-12" style="padding-left: 0px;">
									<div class="widget">
										<div class="widget-header ">
											<span class="widget-caption"><h5>选品管理</h5></span>
											<div class="widget-buttons">
												<a href="#" data-toggle="maximize"></a> <a href="#"
													data-toggle="collapse" onclick="tab('pro');"> <i
													class="fa fa-minus" id="pro-i"></i>
												</a> <a href="#" data-toggle="dispose"></a>
											</div>
										</div>
										<form id="category_form" action="">
											<input type="hidden" id="cid" name="cid" />
										</form>
										<div class="widget-body" id="pro">
											<div class="tabbable">
												<ul class="nav nav-tabs" id="myTab">
													<li class="active"><a data-toggle="tab"
														href="#brand"> 热门品牌</a></li>

													<li class="tab-red"><a data-toggle="tab"
														href="#active"> 畅销活动</a></li>

												</ul>

												<div class="tab-content">
													<!-- 热门品牌 -->
													<div id="brand" class="tab-pane in active">
														<div class="widget-body" id="pro">
															<div class="col-md-4">
																<a id="editabledatatable_new" onclick="addBrand();"
																	class="btn btn-primary" style="width: 100%;"> <i class="fa fa-plus"></i>
																	添加品牌 </a>
															</div>
															<div class="col-md-4">
																<a id="editabledatatable_new" onclick="editBrand();"
																	class="btn btn-info" style="width: 100%;"> <i class="fa  fa-wrench"></i>
																	编辑品牌 </a>
															</div>
															<div class="col-md-4">
																<a id="editabledatatable_new" onclick="deleteBrand();"
																	class="btn btn-danger" style="width: 100%;"> <i class="fa fa-times"></i>
																	删除品牌 </a>
															</div>
															<div style="clear: both;"></div>
															<table class="table table-hover table-bordered"	id="brand_tab" style="margin-top:10px; position: relative;">
																<thead>
																	<tr role="row">
																		<th width="35px;"></th>
																		<th width="25%;">中文名称</th>
																		<th width="40%;">品牌链接</th>
																		<th width="25%;">显示顺序</th>
																	</tr>
																</thead>
																<tbody>
																</tbody>
															</table>
															<!-- Templates -->
															<p style="display: none">
																<textarea id="brand-list" rows="0" cols="0">
																	<!--
																	{#template MAIN}
																		{#foreach $T.list as Result}
																			<tr class="gradeX">
																				<td align="left">
																					<div class="checkbox">
																						<label>
																							<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																							<span class="text"></span>
																						</label>
																					</div>
																				</td>
																				<td align="center">
																					{$T.Result.brandName}
																				</td>
																				<td align="center">{$T.Result.brandLink}</td>
																				<td align="center">{$T.Result.seq}</td>
																       		</tr>
																		{#/for}
																    {#/template MAIN}	-->
																</textarea>
															</p>
														</div>
													</div>
													<!-- 畅销活动 -->
													<div id="active" class="tab-pane">
														<div class="widget-body" id="pro">
															<div class="col-md-4">
																<a id="editabledatatable_new" onclick="addActive();"
																	class="btn btn-primary" style="width: 100%;"> <i class="fa fa-plus"></i>
																	添加活动 </a>
															</div>
															<div class="col-md-4">
																<a id="editabledatatable_new" onclick="editActive();"
																	class="btn btn-info" style="width: 100%;"> <i class="fa  fa-wrench"></i>
																	编辑活动 </a>
															</div>
															<div class="col-md-4">
																<a id="editabledatatable_new" onclick="deleteActive();"
																	class="btn btn-danger" style="width: 100%;"> <i class="fa fa-times"></i>
																	删除活动</a>
															</div>
															<div style="clear: both;"></div>
															<table class="table table-hover table-bordered"
																id="active_tab" style=" margin-top: 10px;">
																<thead>
																	<tr role="row">
																		<th width="35px;"></th>
																		<th width="20%">活动名称</th>
																		<th width="50%">活动链接</th>
																		<th width="20%">显示顺序</th>
																	</tr>
																</thead>
																<tbody>

																</tbody>
															</table>
															<!-- Templates -->
															<p style="display: none">
																<textarea id="active-list" rows="0" cols="0">
																	<!--
																	{#template MAIN}
																		{#foreach $T.list as Result}
																			<tr class="gradeX">
																				<td align="left">
																					<div class="checkbox">
																						<label>
																							<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																							<span class="text"></span>
																						</label>
																					</div>
																				</td>
																				<td align="center">{$T.Result.promotionName}</td>
																				<td align="center">{$T.Result.promotionLink}</td>
																				<td align="center">{$T.Result.seq}</td>
																       		</tr>
																		{#/for}
																    {#/template MAIN}	-->
																</textarea>
															</p>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		
	<div class="modal modal-darkorange" id="addNave">
        <div class="modal-dialog" style="width: 400px;margin: 160px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeCategoryDiv();">×</button>
                    <h4 class="modal-title">分类信息</h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="divForm" method="post" class="form-horizontal" enctype="multipart/form-data">
				            		<input type="hidden" id="divId" name="id"/>
				            		<input type="hidden" id="divSid" name="sid"/>
					                <div class="form-group">
					 					分类名称：
					 					<input type="text" placeholder="必填" class="form-control" id="name" name="name">
					                </div>
					                <div class="form-group">
										状态
										<div class="radio">
											<label>
												<input class="basic" type="radio" id="status1" name="status" value="1">
												<span class="text">有效</span>
											</label>
											<label>
												<input class="basic" type="radio" id="status0" name="status" value="0">
												<span class="text">无效</span>
											</label>
										</div>
										<div class="radio" style="display: none;">
											<label>
												<input class="inverted" type="radio" name="status">
												<span class="text"></span>
											</label>
										</div>
					                </div>
					                <div class="form-group">
					 					显示状态
										<div class="radio">
											<label>
												<input class="basic" type="radio" id="isDisplay1" name="isDisplay" value="1">
												<span class="text">显示</span>
											</label>
											<label>
												<input class="basic" type="radio" id="isDisplay0" name="isDisplay" value="0">
												<span class="text">不显示</span>
											</label>
										</div>
										<div class="radio" style="display: none;">
											<label>
												<input class="inverted" type="radio" name="isDisplay">
												<span class="text"></span>
											</label>
										</div>
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeCategoryDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivFrom();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
</body>
</html>