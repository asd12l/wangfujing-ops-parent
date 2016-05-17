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
		$.ajax({
			type : 'post',
			url : __ctxPath + "/leaveMessageType/selectByParentId?pid="+0,
			dataType : "json",
			success : function(response) {
				console.log(response);
				var r1 = response.leaveMsgTypeList;
				for ( var i = 0; i < r1.length; i++) {
					var ele = r1[i];
					var option = "<option value='"+ele.tid+"'>"
							+ ele.catename + "</option>";
					$("#parentId_select").append(option);
				}
			}
		});
	    initProduct();
	    $("#parentId_select").change(productQuery);
	});
	
	function productQuery(){
		$("#parentId_from").val($("#parentId_select").val());
        var params = $("#product_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        productPagination.onLoad(params);
   	}
	function initProduct() {
		var url = $("#ctxPath").val() + "/leaveMessageType/selectByParentIdBack";
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
					 data:$("#product_form").serialize(),
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
						$.ajax({
							url : __ctxPath
									+ "/leaveMessageType/selectByParentIdBack",
							dataType : "json",
							async : false,
							success : function(response) {
								var result = response.leaveMsgTypeList;
								for ( var j = 0; j < result.length; j++) {
									for ( var i = 0; i < data.leaveMsgTypeList.length; i++) {
										var ele = data.leaveMsgTypeList[i];
										if (ele.pid == result[j].tid) {
											data.leaveMsgTypeList[i].pid = result[j].catename;
										}else if(ele.pid == 0){
											data.leaveMsgTypeList[i].pid = "";
										}
									}
								}
							}
						});
						//使用模板
						$("#product_tab tbody").setTemplateElement(
								"product-list").processTemplate(data);
					}
				}
			});
		}
	function add() {
		$.ajax({
			type : 'post',
			url : __ctxPath + "/leaveMessageType/selectByParentId?pid="+0,
			dataType : "json",
			success : function(response) {
				console.log(response);
				var r1 = response.leaveMsgTypeList;
				for ( var i = 0; i < r1.length; i++) {
					var ele = r1[i];
					var option = "<option value='"+ele.tid+"'>"
							+ ele.catename + "</option>";
					$("#parentId_select2").append(option);
				}
			}
		});
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
			$.ajax({
				type : 'post',
				url : __ctxPath + "/leaveMessageType/selectByParentId?pid="+0,
				dataType : "json",
				success : function(response) {
					console.log(response);
					var r1 = response.leaveMsgTypeList;
					for ( var i = 0; i < r1.length; i++) {
						var ele = r1[i];
						var option = "<option value='"+ele.tid+"'>"
								+ ele.catename + "</option>";
						$("#parentId_select1").append(option);
					}
				}
			});	
			var tid = value;
			var catename = $("#catename_"+value).text().trim();
			var pid = $("#pid_"+value).text().trim();
			$.ajax({
				url : __ctxPath
						+ "/leaveMessageType/selectByParentIdBack",
				dataType : "json",
				async : false,
				success : function(response) {
					var result = response.leaveMsgTypeList;
					for ( var j = 0; j < result.length; j++) {
						if (pid == result[j].catename) {
							pid = result[j].tid;
						}else if(pid == ""){
							pid = 0;
						}
					}
				}
			});
			var typeorder = $("#typeorder_"+value).text().trim();
			var contenttype = $("#contenttype_"+value).text().trim();
		 	var targettype = $("#targettype_"+value).text().trim();
		 	var ordernoneed = $("#ordernoneed_"+value).text().trim();
			var viewcontent = $("#viewcontent_"+value).text().trim();
			$("#bcategoryDIV2").show();
			
			$("#catename1").val(catename);
			
			$("#parentId_select1").val(pid);
			
			
			$("#typeorder1").val(typeorder);
			$("#contenttypeId_select1").val(contenttype);
			if(targettype=="新窗口"){
  				$("#targettype1").attr("checked","checked");
	  		}else{
	  			$("#targettype2").attr("checked","checked");
	  		}
			if(ordernoneed=="是"){
  				$("#ordernoneed1").attr("checked","checked");
	  		}else{
	  			$("#ordernoneed2").attr("checked","checked");
	  		}
			$("#viewcontent1").val(viewcontent);
			$("#tid").val(checkboxArray[0]);
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
				url: __ctxPath+"/leaveMessageType/deleteByPrimaryKey",
				dataType: "json",
				data: {
					"tid":value
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
		var tid = $("#tid").val();
		var catename = $("#catename1").val();
		var parentId_select = $("#parentId_select1").val();
		var typeorder = $("#typeorder1").val();
		var contenttypeId_select = $("#contenttypeId_select1").val();
		
		var targettype = $("#targettype1").val();
		var ordernoneed = $("#ordernoneed1").val();
		
		var viewcontent = $("#viewcontent1").val();
   		$.ajax({
			type:"post",
   	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
   	        url:__ctxPath + "/leaveMessageType/update",
   	        dataType: "json",
	   	     data:{
		   	    	"tid":tid,
		   	    	"catename":catename,
	   	        	"pid":parentId_select,
	   	        	"typeorder":typeorder,
	   	        	"contenttype":contenttypeId_select,
	   	        	"targettype":targettype,
	   	        	"ordernoneed":ordernoneed,
	   	        	"viewcontent":viewcontent
		        },
   	        success:function(response) {
   	        	if(response.success == "true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-check'></i><strong>操作成功，返回列表页!</strong></div>");
		  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>操作失败!</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
       		}
		});
   		$("#bcategoryDIV2").hide();
	}
	function saveDivFrom(){
		var catename = $("#catename").val();
		var parentId_select2 = $("#parentId_select2").val();
		var typeorder = $("#typeorder").val();
		var contenttypeId_select = $("#contenttypeId_select").val();
		
		var targettype = $("#targettype:checked").val();
		var ordernoneed = $("#ordernoneed:checked").val();
		var viewcontent = $("#viewcontent").val();
		
   		$.ajax({
			type:"post",
   	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
   	        url:__ctxPath + "/leaveMessageType/save",
   	        dataType: "json",
   	        data:{
   	        	"catename":catename,
   	        	"pid":parentId_select2,
   	        	"typeorder":typeorder,
   	        	"contenttype":contenttypeId_select,
   	        	"targettype":targettype,
   	        	"ordernoneed":ordernoneed,
   	        	"viewcontent":viewcontent
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
		$("#pageBody").load(__ctxPath+"/jsp/leaveMsgType.jsp");
	}
	function closeCategoryDiv() {
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/leaveMsgType.jsp");
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
								<span class="widget-caption"><h5>留言类型维护</h5> </span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<form id="product_form" action="">
								<input type="hidden" id="parentId_from" name="pid" value="9999" />
								<input type="hidden" id="contenttypeId_from" name="contenttypeId" />
							</form>
							<div class="widget-body" id="pro">

								<div class="table-toolbar">

									<div class="col-md-4">
										<span>上级类别：</span> <select id="parentId_select"
											style="padding: 0 0; width: 30%;">
											<option id="select1" value="9999">所有</option>
											<option id="select2" value="0">无父类别</option>
										</select>
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

								<table class="table table-hover table-bordered" id="product_tab">
									<thead>
										<tr role="row">
											<th width="7.5%"></th>

											<th style="text-align: center;">TID</th>
											<th style="text-align: center;">类型别名</th>
											<th style="text-align: center;">内容类型</th>
											<th style="text-align: center;" width="10%">显示内容</th>
											<th style="text-align: center;">上级类别</th>
											<th style="text-align: center;">排序号</th>
											<th style="text-align: center;">订单号必须</th>
											<th style="text-align: center;">新窗口</th>
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
											{#foreach $T.leaveMsgTypeList as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.tid}" value="{$T.Result.tid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="tid_{$T.Result.tid}">{$T.Result.tid}</td>
													<td align="center" id="catename_{$T.Result.tid}">{$T.Result.catename}</td>
													<td align="center" id="contenttype_{$T.Result.tid}">{$T.Result.contenttype}</td>
													<td align="center" id="viewcontent_{$T.Result.tid}">{$T.Result.viewcontent}</td>
													<td align="center" id="pid_{$T.Result.tid}">{$T.Result.pid}</td>
													
													<td align="center" id="typeorder_{$T.Result.tid}">{$T.Result.typeorder}</td>
													<td align="center" id="ordernoneed_{$T.Result.tid}">
														{#if $T.Result.ordernoneed == 0}
						           							<span class="btn btn-danger btn-xs">否</span>
						                      			{#elseif $T.Result.ordernoneed == 1}
						           							<span class="btn btn-success btn-xs">是</span>
						                   				{#/if}
													</td>
													<td align="center" id="targettype_{$T.Result.tid}">
														{#if $T.Result.targettype == 0}
						           							<span class="btn btn-danger btn-xs">当前窗口</span>
						                      			{#elseif $T.Result.targettype == 1}
						           							<span class="btn btn-success btn-xs">新窗口</span>
						                   				{#/if}
													</td>
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


	
	<div class="modal modal-darkorange" id="bcategoryDIV">
		<div class="modal-dialog" style="width: 500px; margin: 80px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">添加新的留言类别</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row" style="padding: 10px;">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" id="type" /> 
									<span>类别名称:&nbsp;</span><input type="text" id="catename" />
									<span>上级类别：</span><select id="parentId_select2" style="padding: 0 0; width: 30%;">
										<option id="select1" value=""></option>
										<option id="select2" value="0">无父类别</option>
									</select> <br>
									<br> <span>&nbsp;&nbsp;&nbsp;排序号:&nbsp;</span><input type="text" id="typeorder" />
									<span>内容类型：</span><select id="contenttypeId_select" style="padding: 0 0; width: 30%;">
										<option id="select3" value=""></option>
										<option id="select4" value="0">html链接</option>
										<option id="select5" value="1">文字提示</option>
										<option id="select6" value="2">直接进入留言板</option>
										<option id="select7" value="3">无</option>
									</select><br>
									
									<div class="form-group">
										<label class="col-lg-4 control-label">新窗口：</label>
											<div class="radio">
												<label>
													<input class="basic" type="radio" id="targettype" name="targettype" value="1">
													<span class="text">是</span>
												</label>
												<label>
													<input class="basic" type="radio" id="targettype" checked="checked" name="targettype" value="0">
													<span class="text">否</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label>
													<input class="inverted" type="radio" name="status1">
													<span class="text"></span>
												</label>
											</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">是否填写订单：</label>
											<div class="radio">
												<label>
													<input class="basic" type="radio" id="ordernoneed" checked="checked" name="ordernoneed" value="1">
													<span class="text">是</span>
												</label>
												<label>
													<input class="basic" type="radio" id="ordernoneed" name="ordernoneed" value="0">
													<span class="text">否</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label>
													<input class="inverted" type="radio" name="status">
													<span class="text"></span>
												</label>
											</div>
									</div>
									<br> <span style="height:14px;display:block;vetical-align:top;float:left;font-size:13px;">显示内容:</span>
									<textarea rows="3" cols="45" id="viewcontent"></textarea><br>
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

	<div class="modal modal-darkorange" id="bcategoryDIV2">
		<div class="modal-dialog" style="width: 500px; margin: 80px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCategoryDiv();">×</button>
					<h4 class="modal-title">修改留言类别</h4>
				</div>
				<div class="modal-body">
					<div class="bootbox-body">
						<div class="row" style="padding: 10px;">
							<div class="col-md-12">
								<form id="divForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" id="tid" /> 
									<span>类别名称:&nbsp;</span><input type="text" id="catename1" />
									<span>上级类别：</span><select id="parentId_select1" style="padding: 0 0; width: 30%;">
										<option id="select1" value=""></option>
										<option id="select2" value="0">无父类别</option>
									</select> <br>
									<br> <span>&nbsp;&nbsp;&nbsp;排序号:&nbsp;</span><input type="text" id="typeorder1" />
									<span>内容类型：</span><select id="contenttypeId_select1" style="padding: 0 0; width: 30%;">
										<option id="select3" value=""></option>
										<option id="select4" value="0">html链接</option>
										<option id="select5" value="1">文字提示</option>
										<option id="select6" value="2">直接进入留言板</option>
										<option id="select7" value="3">无</option>
									</select><br>
									
									<div class="form-group">
										<label class="col-lg-4 control-label">新窗口：</label>
											<div class="radio">
												<label>
													<input class="basic" type="radio" id="targettype1" name="targettype" value="1">
													<span class="text">是</span>
												</label>
												<label>
													<input class="basic" type="radio" id="targettype2" name="targettype" value="0">
													<span class="text">否</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label>
													<input class="inverted" type="radio" name="status1">
													<span class="text"></span>
												</label>
											</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">是否填写订单：</label>
											<div class="radio">
												<label>
													<input class="basic" type="radio" id="ordernoneed1" name="ordernoneed" value="1">
													<span class="text">是</span>
												</label>
												<label>
													<input class="basic" type="radio" id="ordernoneed2" name="ordernoneed" value="0">
													<span class="text">否</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label>
													<input class="inverted" type="radio" name="status">
													<span class="text"></span>
												</label>
											</div>
									</div>
									<br> <span style="height:14px;display:block;vetical-align:top;float:left;font-size:13px;">显示内容:</span>
									<textarea rows="3" cols="45" id="viewcontent1"></textarea><br>
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

</body>
</html>