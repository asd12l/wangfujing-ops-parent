<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<script src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
  <script type="text/javascript">
  __ctxPath = "${pageContext.request.contextPath}";
  var categoryPagination;
  var nodeId = "";
$(function(){
	$.ajax({
		type:"post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url:__ctxPath + "/category/list",
		async:false,
		dataType: "json",
		success:function(response) {
			$('#tree').treeview({
				data: response,
				onNodeSelected: function(event, node) {
					categoryQuery(node.id);
					nodeId = node.id;
		        }
			});
		}
	});
	initCategory();
    $("#pageSelect").change(categoryQuery);
});
function categoryQuery(data){
	if(data!=''){
		$("#cid").val(data);
	}
    var params = $("#category_form").serialize();
    //alert("表单序列化后请求参数:"+params);
    params = decodeURI(params);
    categoryPagination.onLoad(params);
}
function reset(){
	categoryQuery();
}
//初始化包装单位列表
function initCategory() {
	categoryPagination = $("#categoryPagination").myPagination({
       panel: {
         tipInfo_on: true,
         tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
         tipInfo_css: {
           width: '25px',
           height: "20px",
           border: "2px solid #f0f0f0",
           padding: "0 0 0 5px",
           margin: "0 5px 0 5px",
           color: "#48b9ef"
         }
       },
       debug: false,
       ajax: {
         on: true,
         url: __ctxPath+"/props/list",
         dataType: 'json',
         ajaxStart: function() {
           //ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
         },
         ajaxStop: function() {
           //隐藏加载提示
           setTimeout(function() {
             ZENG.msgbox.hide();
           }, 300);
         },
         callback: function(data) {
           //使用模板
           $("#category_tab tbody").setTemplateElement("category-list").processTemplate(data);
         }
       }
     });
}
function editColor(){
	var checkboxArray=[];
	$("input[type='checkbox']:checked").each(function(i, team){
		var productSid = $(this).val();
		checkboxArray.push(productSid);
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
	var value=	checkboxArray[0];
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
function spanTd(propsSid,categorySid,channelSid){
	if($("#spanTd_"+propsSid).attr("class")=="expand-collapse click-expand glyphicon glyphicon-plus"){
		$("#spanTd_"+propsSid).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/values/list",
			async:false,
			dataType: "json",
			data:{
				"propsSid":propsSid,"categorySid":categorySid,"channelSid":channelSid
			},
			success:function(response) {
				var result = response.rows;
				var option = "<tr id='afterTr"+propsSid+"'><td></td><td colspan='4'><div style='padding:2px'>"+
				"<table class='table table-bordered'><tr role='row'><th>属性值编号</th><th>属性值名称</th><th>属性名称</th><th>分类名称</th></tr>";
				for(var i=0;i<result.length;i++){
					var ele = result[i];
					option+="<tr><td>"+ele.valuesSid+"</td><td>"+ele.valuesName+"</td><td>"+ele.propsName+"</td><td>"+ele.categoryName+"</td>";
				}
				option+="</tr></table></div></td></tr>";
				$("#gradeX"+propsSid).after(option);
			}
		});
	}else{
		$("#spanTd_"+propsSid).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
		$("#afterTr"+propsSid).remove();
	}
}
//添加分类
function append(){
	var html = $("li[class='list-group-item node-tree node-selected']").html();
	if(html!=undefined){
		$("#name").val("");
		$("input[name='status']").attr("checked","false");
		$("input[name='isDisplay']").attr("checked","false");
		$("#divId").val(nodeId);
		$("#divSid").val("");
		$("#categoryDIV").show();
	}else{
		$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>为选中节点!</strong></div>");
		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
	}
}
//修改分类
function edit(){  
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
function categoryDel(){
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

function saveDivFrom(){
	$.ajax({
        type:"post",
        url:__ctxPath + "/category/add",
        dataType: "json",
        data: $("#divForm").serialize(),
        success:function(response) {
        	if(response.success == 'true'){
				$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>操作成功，返回列表页!</strong></div>");
	  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	  			$("#categoryDIV").hide();
	  			$("#name").val("");
			}else{
				$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>操作失败!</strong></div>");
     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
    	}
	});
}
function updateRole(){
	var html = $("li[class='list-group-item node-tree node-selected']").html();
	var propsid;
	if(html!=undefined){
		$.ajax({url:__ctxPath+"/propvals/edit?id="+nodeId,dataType:"json",async:false,success:function(response){
			$("#name2").val(response.name);
			propsid = response.propsid;
		}});
		$("#div2Table").html("<tr><td width='20%'></td><td>属性</td><td>属性描述</td></tr>");
		$.ajax({url:__ctxPath+"/propscombox/list?id="+nodeId,dataType:"json",async:false,success:function(response){
			var result = response;
			var option = "";
			var names = "";
			for(var i=0;i<result.length;i++){
				var ele = result[i];
				if(propsid[i]==ele.propsSid){
					if(i==result.length-1){
						names+=ele.propsName;
					}else{
						names+=ele.propsName+",";
					}
					option += "<tr onchange='div2TrChange()'><td><div class='checkbox'><label>"+
					"<input type='checkbox' checked='checked' value="+ele.propsName+" >"+
					"<span class='text'></span></label></div>"+
					"</td><td>"+ele.propsName+"</td><td>"+ele.propsDesc+"</td></tr>";
				}else{
					option += "<tr onchange='div2TrChange()'><td><div class='checkbox'><label>"+
					"<input type='checkbox' value="+ele.propsName+" >"+
					"<span class='text'></span></label></div>"+
					"</td><td>"+ele.propsName+"</td><td>"+ele.propsDesc+"</td></tr>";
				}
			}
			$("#pdict").val(names);
			$("#div2Table").append(option);
		}});
		$("#categoryDIV2").show();
	}else{
		$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>为选中节点!</strong></div>");
		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
	}
}
//tr内容改变触发
function div2TrChange(){
	var names = "";
	var length = $("#div2Table input[type='checkbox']:checked").length;
	$("#div2Table input[type='checkbox']:checked").each(function(i){
		if(i==length-1){
			names += $(this).val();
		}else{
			names += $(this).val()+",";
		}
	});
	$("#pdict").val(names);
}
function divTableApp(){
	if($("#div2Label").attr("class")=="fa fa-minus"){
		$("#div2Label").attr("class","fa fa-plus");
		$("#div2Table").hide();
	}else{
		$("#div2Label").attr("class","fa fa-minus");
		$("#div2Table").show();
	}
}
function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	$("#pageBody").load(__ctxPath+"/jsp/CategoryView.jsp");
}
function closeCategoryDiv(){
	$("#categoryDIV").hide();
	$("#categoryDIV2").hide();
	$("#name").val("");
}
  </script>
</head>
<body>
<div class="page-body" style="position:fixed;">
	<div class="row">
		<div class="col-lg-12 col-sm-12 col-xs-12">
			<div class="row">
				<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="container">
				      <div class="col-md-3" style="padding-left: 0px;width: 28%;margin-top: 2px;">
				          <div class="well" style="padding: 10px;">
				          	<div>
				          		<a class="btn btn-default shiny fa fa-plus" onclick="append()">添加分类</a>&nbsp;
				          		<a class="btn btn-default shiny fa fa-edit" onclick="edit()">修改分类</a>&nbsp;
				          		<a class="btn btn-default shiny fa fa-times" onclick="categoryDel()">删除分类</a>
							</div>
				            <div id="tree"></div>
				          </div>
				      </div>
                      <div class="" style="float: left;width: 68%;overflow:auto;height: 550px;">
                        <div class="col-xs-12 col-md-12" style="padding-left: 0px;">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>类目属性管理</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <form id="category_form" action="">
									<input type="hidden" id="cid" name="cid" />
                             	</form>
                                <div class="widget-body" id="pro">
                             		<div class="tabbable">
										<ul class="nav nav-tabs" id="myTab">
											<li class="active">
												<a data-toggle="tab" href="#channel">
													频道管理
												</a>
											</li>
								
											<li class="tab-red">
												<a data-toggle="tab" href="#active">
													活动管理
												</a>
											</li>
								
											<li class="tab-green">
												<a data-toggle="tab" href="#adv">
													广告管理
												</a>
											</li>
								
										</ul>
								
										<div class="tab-content">
											<div id="channel" class="tab-pane in active">
												<p>这是频道管理</p>
											</div>
								
											<div id="active" class="tab-pane">
												<p>这是活动管理</p>
											</div>
								
											<div id="adv" class="tab-pane">
												<p>这是广告管理</p>
											</div>
										</div>
								   </div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="category-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.propsSid}">
													<td align="center" style="vertical-align:middle;">
														<span id="spanTd_{$T.Result.propsSid}" onclick="spanTd({$T.Result.propsSid},{$T.Result.categorySid},{$T.Result.channelSid})" class="expand-collapse click-expand glyphicon glyphicon-plus"></span>
													</td>
													<td id="sid_{$T.Result.sid}" style="vertical-align:middle;">
														{$T.Result.propsSid}
													</td>
													<td id="roleName_{$T.Result.sid}" style="vertical-align:middle;">{$T.Result.propsName}</td>
													<td id="roleCode_{$T.Result.sid}" style="vertical-align:middle;">{$T.Result.categorySid}</td>
													<td id="createdTime_{$T.Result.sid}" style="vertical-align:middle;">{$T.Result.categoryName}</td>
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
	<div class="modal modal-darkorange" id="categoryDIV">
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
    <div class="modal modal-darkorange" id="categoryDIV2">
        <div class="modal-dialog" style="width: 400px;margin: 80px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeCategoryDiv();">×</button>
                    <h4 class="modal-title">属性信息</h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="div2Form" method="post" class="form-horizontal" enctype="multipart/form-data">
					                <div class="form-group">
					 					分类名称：
					 					<input type="text" readonly="readonly" class="form-control" id="name2" name="name">
					                </div>
					                <div class="form-group">
										属性名称：<br/>
										<input type="text" id="pdict" name="propsid"  style="width: 95%;height: 30px;padding: 6px 12px;">
										<label class="fa fa-plus" id="div2Label" onclick="divTableApp()"></label>
										<table class="table table-hover table-bordered" id="div2Table" style="display: none;">
											<tr><td width="20%"></td><td>属性</td><td>属性描述</td></tr>
										</table>
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeCategoryDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivFrom2();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
</div>
</body>
</html>