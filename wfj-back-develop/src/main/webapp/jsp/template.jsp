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
	    $("#name_input").change(olvQuery);
	});
	function olvQuery(){
		$("#name_from").val($("#name_input").val());
        var params = $("#product_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        productPagination.onLoad(params);
   	}
	function reset(){
		$("#name_input").val("");
		olvQuery();
	}
	function initProduct() {
		var url = $("#ctxPath").val() + "/flashPageLayoutTemplate/queryBySelect";
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
	
	function add() {
		$("#bcategoryDIV").show();
	}
	//修改
	function modify() {
		var checkboxArray=[];
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
			var template = $("#template_"+value).val();
			var memo = $("#memo_"+value).text().trim();
			var minProQuantity = $("#minProQuantity_"+value).text().trim();
			var maxProQuantity = $("#maxProQuantity_"+value).text().trim();
			$("#bcategoryDIV2").show();
			$("#name1").val(name);
			$("#template1").val(template);
			$("#memo1").val(memo);
			$("#minProQuantity1").val(minProQuantity);
			$("#maxProQuantity1").val(maxProQuantity);
			$("#sid").val(checkboxArray[0]);
		}
			
 	}
	function del() {
		var checkboxArray=[];
			$("input[type='checkbox']:checked").each(function(i, team){
			var record = $(this).val();
			checkboxArray.push(record);
			var value=	checkboxArray[i];
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/flashPageLayoutTemplate/delPageLayoutTemplate",
				dataType: "json",
				data: {
					"sid":value
				},
				success: function(response) {
					if(response.success=="true"){
						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
							"<i class='fa-fw fa fa-check'></i><strong>删除成功，返回列表页!</strong></div>");
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
	function updateDivFrom(){
		var name = $("#name1").val();
		var template = $("#template1").val();
		var memo = $("#memo1").val();
		var sid = $("#sid").val();
		var minProQuantity = $("#minProQuantity").val();
		var maxProQuantity = $("#maxProQuantity").val();
   		$.ajax({
			type:"post",
   	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
   	        url:__ctxPath + "/flashPageLayoutTemplate/updatePageLayoutTemplate",
   	        dataType: "json",
	   	     data:{
	   	    	"name":name,
   	        	"template":template,
   	        	"memo":memo,
   	        	"sid":sid,
   	        	"minProQuantity":minProQuantity,
   	        	"maxProQuantity":maxProQuantity
		        },
   	        success:function(response) {
   	        	if(response.success == "true"){
   	        		$("#bcategoryDIV").hide();
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-check'></i><strong>操作成功，返回列表页!</strong></div>");
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
		
		var name = $("#name").val();
		var template = $("#template").val();
		var memo = $("#memo").val();
		var minProQuantity = $("#minProQuantity").val();
		var maxProQuantity = $("#maxProQuantity").val();
		
   		$.ajax({
			type:"post",
   	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
   	        url:__ctxPath + "/flashPageLayoutTemplate/savePageLayoutTemplate",
   	        dataType: "json",
   	        data:{
   	        	"name":name,
   	        	"template":template,
   	        	"memo":memo,
   	        	"minProQuantity":minProQuantity,
   	        	"maxProQuantity":maxProQuantity
   	        },
   	        success:function(response) {
   	        	if(response.success == "true"){
   	        		$("#bcategoryDIV").hide();
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-check'></i><strong>操作成功，返回列表页!</strong></div>");
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
		$("#pageBody").load(__ctxPath+"/jsp/template.jsp");
	}
	function closeCategoryDiv() {
		$("#bcategoryDIV").hide();
		$("#bcategoryDIV2").hide();
	}
</script>
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
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<span class="widget-caption"><h5>活动管理</h5> </span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<form id="product_form" action="">
								<input type="hidden" id="name_from" name="name" />
							</form>
							<div class="widget-body" id="pro">

								<div class="table-toolbar">

									<div class="col-md-12">
									<div class="col-md-4">
										<div class="col-lg-6">
											<span>栏目模板名称：</span>
										</div>
										<div class="col-lg-6">
											<input type="text" id="name_input" style="width: 100%" />
										</div>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="olvQuery();"
											class="btn btn-info" style="width: 100%;"> <i
											class="fa fa-eye"></i> 查询 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="reset();"
											class="btn btn-yellow" style="width: 100%;"> <i
											class="fa fa-random"></i> 重置 </a>&nbsp;
									</div>
									
									</div>
								</div>
								<div class="table-toolbar">
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="add();"
											class="btn btn-primary glyphicon glyphicon-plus"
											style="width: 100%;"> 增加栏目模板 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="modify();"
											class="btn btn-info glyphicon glyphicon-wrench"
											style="width: 100%;"> 修改栏目模板 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="del();"
											class="btn btn-danger glyphicon glyphicon-trash"
											style="width: 100%;"> 删除栏目模板 </a>&nbsp;
									</div>

								</div>

								<table class="table table-hover table-bordered" id="product_tab">
									<thead>
										<tr role="row">
											<th width="7.5%"></th>

											<th style="text-align: center;">名称</th>
											<th style="text-align: center;">备注</th>
											<th style="text-align: center;">最大商品数量</th>
											<th style="text-align: center;">最小商品数量</th>
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
															<input type="hidden" id="template_{$T.Result.sid}" value="{$T.Result.template}">
														</div>
													</td>
													<td align="center" id="name_{$T.Result.sid}">{$T.Result.name}</td>
													<td align="center" id="memo_{$T.Result.sid}">{$T.Result.memo}</td>
													<td align="center" id="maxProQuantity_{$T.Result.sid}">{$T.Result.maxProQuantity}</td>
													<td align="center" id="minProQuantity_{$T.Result.sid}">{$T.Result.minProQuantity}</td>
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
									<input type="hidden" id="sid" />
									 <span>栏目名称:&nbsp;</span><input type="text" id="name1" /> <br>
									<br> <span style="height:14px;display:block;vetical-align:top;float:left;font-size:13px;">栏目模板:</span><textarea rows="3" cols="30" id="template1"></textarea><br>
									<br> <span style="height:14px;display:block;vetical-align:top;float:left;font-size:13px;">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</span><textarea rows="3" cols="30" id="memo1"></textarea><br> 
									<br> <span>最大商品数量:&nbsp;</span><input type="text" id="maxProQuantity1" /> <br>
									<br> <span>最小商品数量:&nbsp;</span><input type="text" id="minProQuantity1" /> <br>
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
					<h4 class="modal-title">添加栏目模板</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row" style="padding: 10px;">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									 <span>栏目名称:&nbsp;</span><input type="text" id="name" /> <br>
									<br> <span style="height:14px;display:block;vetical-align:top;float:left;font-size:13px;">栏目模板:</span><textarea rows="3" cols="30" id="template"></textarea><br>
									<br> <span style="height:14px;display:block;vetical-align:top;float:left;font-size:13px;">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</span><textarea rows="3" cols="30" id="memo"></textarea><br>
									<br> <span style="float:left;">最大商品数量:&nbsp;</span><input type="text" id="maxProQuantity" /> <br>
									<br> <span style="float:left;">最小商品数量:&nbsp;</span><input type="text" id="minProQuantity" /> <br>
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