<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/zTreeStyle/metro.css">
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



<script
	src="${pageContext.request.contextPath}/js/jquery.ztree.all-3.5.min.js"></script>

<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	//初始化列表
	var productPagination;
	$(function() {
	    initProduct();
	    $("#page_template_type_select").change(productQuery);
	});
	
	function productQuery(){
		$("#page_template_type_from").val($("#page_template_type_select").val());
        var params = $("#product_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        productPagination.onLoad(params);
   	}
	function initProduct() {
		var url = $("#ctxPath").val() + "/pageTem/queryPageTemByType";
		productPagination = $("#productPagination").myPagination(
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
						url : url,
						dataType : 'json',
						ajaxStart : function() {
							ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								ZENG.msgbox.hide();
							}, 300);
						},
						callback : function(data) {
							//使用模板
							$("#product_tab tbody").setTemplateElement(
									"product-list").processTemplate(data);
						}
					}
				});
	}
	function flash() {
		    initProduct();
		    $("#page_template_type_select").ready(productQuery);
	}
	function add() {
		var type = $("#page_template_type_from").val();
		if(type==null||type==''){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选择模板类型!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else{
			$("#bcategoryDIV").show();
		}
	}
	//修改
	function modify() {
		var checkboxArray=[];
		var type = $("#page_template_type_from").val();
		if(type==null||type==''){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选择模板类型!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else{
			
			$("input[type='checkbox']:checked").each(function(i, team){
				var record = $(this).val();
				checkboxArray.push(record);
			});
			if(checkboxArray.length>1){
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				 return false;
			}else if(checkboxArray.length==0){
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				 return false;
			}
			if(checkboxArray[0]!=null){
				var value = checkboxArray[0];
				var sid = value;
				var name = $("#name_"+value).text().trim();
				var page = $("#page_"+value).text().trim();
				$("#bcategoryDIV2").show();
				$("#name1").val(name);
				$("#page1").val(page);
				$("#sid").val(checkboxArray[0]);
			}
			
		}
 	}
	function del() {
		var checkboxArray=[];
		var type = $("#page_template_type_from").val();
		if(type==null||type==''){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选择模板类型!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else{
			$("input[type='checkbox']:checked").each(function(i, team){
				var record = $(this).val();
				checkboxArray.push(record);
				var value=	checkboxArray[i];
				$.ajax({
					type: "post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					url: __ctxPath+"/pageTem/delTemplates",
					dataType: "json",
					data: {
						"sid":value
					},
					success: function(response) {
						if(response.success=="true"){
							$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
								"<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong></div>");
		  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
						}else{
							$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
							$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
						}
						return ;
					}
				});
			});
			if(checkboxArray.length==0){
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				 return false;
			}
		}
	}
	function updateDivFrom(){
		var type = $("#page_template_type_from").val();
		var name = $("#name1").val();
		var page = $("#page1").val();
		var sid = $("#sid").val();
   		$.ajax({
			type:"post",
   	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
   	        url:__ctxPath + "/pageTem/updateTemplates",
   	        dataType: "json",
	   	     data:{
		        	"name":name,
		        	"page":page,
		        	"type":type,
		        	"sid":sid
		        },
   	        success:function(response) {
   	        	if(response.success == "true"){
   	        		$("#bcategoryDIV").hide();
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>操作成功，返回列表页!</strong></div>");
		  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#bcategoryDIV").hide();
					$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>操作失败!</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
       		}
		});
   		$("#bcategoryDIV2").hide();
	}
	
	function saveDivFrom(){
		var type = $("#page_template_type_from").val();
		var name = $("#name").val();
		var page = $("#page").val();
		
   		$.ajax({
			type:"post",
   	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
   	        url:__ctxPath + "/pageTem/saveTemplates",
   	        dataType: "json",
   	        data:{
   	        	"name":name,
   	        	"page":page,
   	        	"type":type
   	        },
   	        success:function(response) {
   	        	if(response.success == "true"){
   	        		$("#bcategoryDIV").hide();
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>操作成功，返回列表页!</strong></div>");
		  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#bcategoryDIV").hide();
					$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>操作失败!</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
       		}
		});
	}

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
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		/* $("#pageBody").load(__ctxPath+"/jsp/pagetemplate.jsp"); */
		flash();
	}
	function closeCategoryDiv() {
		$("#bcategoryDIV").hide();
		$("#bcategoryDIV2").hide();
	}
</script>
</head>
<body>
	<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />

	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<span class="widget-caption"><h5>页面模板管理</h5> </span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<form id="product_form" action="">
								<input type="hidden" id="page_template_type_from" name="type"/>
								<input type="hidden" id="page_template_name_from" name="name"/>
								<input type="hidden" id="page_template_page_from" name="page"/>
		                    </form>
							<div class="widget-body" id="pro">

								<div class="table-toolbar">

									<div class="col-md-4">
										<span>页面模板类型：</span> <select id="page_template_type_select"
											style="padding: 0 0; width: 30%;">
											<option value="">请选择</option>
											<option value="1" id="select1">频道模板</option>
											<option value="2" id="select2">活动模板</option>
										</select>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="flash();"
											class="btn btn-yellow" style="width: 100%;"> <i
											class="fa fa-random"></i> 刷新 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="add();"
											class="btn btn-primary glyphicon glyphicon-plus"
											style="width: 100%;"> 添加 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="modify();"
											class="btn btn-info glyphicon glyphicon-wrench"
											style="width: 100%;"> 修改 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="del();"
											class="btn btn-danger glyphicon glyphicon-trash"
											style="width: 100%;"> 删除 </a>&nbsp;
									</div>

								</div>

								<table class="table table-hover table-bordered"
									 id="product_tab">
									<thead>
										<tr role="row">
											<th width="7.5%"></th>

											<th style="text-align: center;">名称</th>
											<th style="text-align: center;">页面</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="product-list" rows="0" cols="0">
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
													<td align="center" id="name_{$T.Result.sid}">{$T.Result.name}</td>
													<td align="center" id="page_{$T.Result.sid}">{$T.Result.page}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
							</p>
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
	
	<div class="modal modal-darkorange" id="bcategoryDIV2">
		<div class="modal-dialog" style="width: 400px; margin: 80px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">修改页面模板</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row" style="padding: 10px;">
							<div class="col-md-12">
								<form id="divForm2" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" id="type" />
									<input type="hidden" id="sid" />
									<span>名称:&nbsp;</span><input type="text" id="name1" /> 
									<br><br>
									<span>页面:&nbsp;</span><input type="text" id="page1" /> 
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeCategoryDiv();" type="button">取消</button>
					<button class="btn btn-default" type="button"
						onclick="updateDivFrom();">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	<div class="modal modal-darkorange" id="bcategoryDIV">
		<div class="modal-dialog" style="width: 400px; margin: 80px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">添加页面模板</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row" style="padding: 10px;">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" id="type" />
									<span>名称:&nbsp;</span><input type="text" id="name" /> 
									<br><br>
									<span>页面:&nbsp;</span><input type="text" id="page" /> 
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeCategoryDiv();" type="button">取消</button>
					<button class="btn btn-default" type="button"
						onclick="saveDivFrom();">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	
</body>
</html>