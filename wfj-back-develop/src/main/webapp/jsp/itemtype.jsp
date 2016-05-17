<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
  <script type="text/javascript">
  __ctxPath = "${pageContext.request.contextPath}";
  var itPagination;
  var nodeId = "";
  var nodeName = "";
$(function(){
	$.ajax({
		type:"post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url:__ctxPath +"/DataDictionary/selectList",
		async:false,
		dataType: "json",
		success:function(response) {
			$('#tree').treeview({
				data: response,
				onNodeSelected: function(event, node) {
					itQuery(node.id);
					nodeId = node.id;
					nodeName = node.text;
		        }
			});
		}
	});
	initIt()
	var params = $("#it_form").serialize();
	params = decodeURI(params);
	itPagination.onLoad(params);
    //$("#pageSelect").change(categoryQuery);
});
function itQuery(data){
	if(data!=''){
		$("#navSid").val(data);
	}
    var params = $("#it_form").serialize();
    params = decodeURI(params);
    itPagination.onLoad(params);
}

function initIt() {
	itPagination = $(this).myPagination({
       debug: false,
       ajax: {
         on: true,
         url: __ctxPath+"/DataDictionary/getItemTypeAll",
         dataType: 'json',
         ajaxStart: function() {
           ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
         },
         ajaxStop: function() {
           //隐藏加载提示
           setTimeout(function() {
             ZENG.msgbox.hide();
           }, 300);
         },
         callback: function(data) {
           //使用模板
           $("#it_tab tbody").setTemplateElement("it-list").processTemplate(data);
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
//添加分类
function append(){
	var html = $("li[class='list-group-item node-tree node-selected']").html();
	if(html!=undefined){
		$("#divTitle").html("您正在为业务类型<span style='color:red;'>"+nodeName+"</span>添加类型项");
		$("#dictTypeCode").val(nodeId);
		$("#categoryDIV").show();
	}else{
		$("#model-body-warning").html("<div class='alert alert-warning fade in'>"+
				"<i class='fa-fw fa fa-times'></i><strong>请确定要为哪个业务类型添加!</strong></div>");
		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
	}
}
//修改分类
function edit(){
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
		$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选择一条要修改的资源!</strong></div>");
		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		 return false;
	}
	var value = checkboxArray[0];
	$("#sid2").val(value);
	$("#dictTypeCode2").val($("#dictTypeCode_"+value).text().trim());
	$("#dictItemCode2").val($("#dictItemCode_"+value).text().trim());
	$("#dictItemName2").val($("#dictItemName_"+value).text().trim());
	$("#showSeq2").val($("#showSeq_"+value).text().trim());
	$("#memo2").val($("#memo_"+value).text().trim());
	if($("#activeFlag_"+value).text().trim()=="有效"){
		$("#activeFlag2").val(1);
	}else{
		$("#activeFlag2").val(0);
	}
	$("#itDiv2").show();
}
function itDel(){
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
		$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选择一条要修改的资源!</strong></div>");
		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		 return false;
	}
	var value = checkboxArray[0];
	bootbox.confirm("确定删除吗？", function(r){
		if(r){
			$.ajax({
		        type:"post",
		        url:__ctxPath + "/DataDictionary/deleteItemType?sid="+value,
		        dataType: "json",
		        success:function(response) {
		        	if(response.success == 'true'){
						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
							"<i class='fa-fw fa fa-times'></i><strong>操作成功!</strong></div>");
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
//新增
function saveDivFrom(){
	$.ajax({
        type:"post",
        url:__ctxPath + "/DataDictionary/saveItemType",
        dataType: "json",
        data: $("#divForm").serialize(),
        success:function(response) {
        	if(response.success == 'true'){
        		$("#categoryDIV").hide();
				$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"</strong></div>");
	  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			}else{
				$("#model-body-success").html("<div class='alert alert-warning fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"</strong></div>");
     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
    	}
	});
}
//修改
function saveDiv2From(){
	$.ajax({
        type:"post",
        url:__ctxPath + "/DataDictionary/updateItemType",
        dataType: "json",
        data: $("#div2Form").serialize(),
        success:function(response) {
        	if(response.success == 'true'){
        		$("#itDiv2").hide();
				$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"</strong></div>");
	  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			}else{
				$("#model-body-success").html("<div class='alert alert-warning fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"</strong></div>");
     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
    	}
	});
}
function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	//$("#pageBody").load(__ctxPath+"/jsp/itemtype.jsp");
	itQuery(nodeId);
}
function closeCategoryDiv(){
	$("#categoryDIV").hide();
	$("#itDiv2").hide();
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
					<div class="well" style="width: 23%;float:left;">
						<a class="btn btn-default shiny fa fa-plus" onclick="append()">添加</a>
				        <a class="btn btn-default shiny fa fa-edit" onclick="edit()">修改</a>
				        <a class="btn btn-default shiny fa fa-times" onclick="itDel()">禁用</a>
				        <div id="tree"></div>
					</div>
					<div style="width: 2%;float:left;">&nbsp;</div>
					<div  style="width: 70%;float:left;">
						<div class="widget">
                                <div class="widget-header ">
                                    <h5 class="widget-caption">类型项管理</h5>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <form id="it_form" action="">
									<input type="hidden" id="navSid" name="navSid" value="0" />
                             	</form>
                                <div class="widget-body" id="pro">
                                    <table class="table table-hover table-bordered" id="it_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th width="8.5%"></th>
                                            	<th style="text-align: center;" width="8%">SID</th>
                                                <th style="text-align: center;" width="10%">类型编码</th>
                                                <th style="text-align: center;" width="8%">编号</th>
                                                <th style="text-align: center;" width="15%">名称</th>
                                                <th style="text-align: center;" width="8%">序列号</th>
                                                <%--<th style="text-align: center;">备注</th>--%>
                                                <th style="text-align: center;" width="11%">有效标志位</th>
                                                <th style="text-align: center;" width="11%">创建时间</th>
                                                <th style="text-align: center;" width="11%;">修改时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <div id="itPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="it-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.propsSid}">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td style="text-align:center;vertical-align:middle;">{$T.Result.sid}</td>
													<td id="dictTypeCode_{$T.Result.sid}" style="text-align:center;vertical-align:middle;">{$T.Result.dictTypeCode}</td>
													<td id="dictItemCode_{$T.Result.sid}" style="text-align:center;vertical-align:middle;">{$T.Result.dictItemCode}</td>
													<td id="dictItemName_{$T.Result.sid}" style="text-align:center;vertical-align:middle;">{$T.Result.dictItemName}</td>
													<td id="showSeq_{$T.Result.sid}" style="text-align:center;vertical-align:middle;">{$T.Result.showSeq}</td>
													<td id="memo_{$T.Result.sid}" style="display:none;text-align:center;vertical-align:middle;">{$T.Result.memo}</td>
													<td id="activeFlag_{$T.Result.sid}" style="text-align:center;vertical-align:middle;">
														{#if $T.Result.activeFlag == 0}
						           							<span class="btn btn-danger btn-xs">无效</span>
						                      			{#elseif $T.Result.activeFlag == 1}
						           							<span class="btn btn-success btn-xs">有效</span>
						                   				{#/if}
													</td>
													<td id="createdTime_{$T.Result.sid}" style="text-align:center;vertical-align:middle;">{$T.Result.createdTime}</td>
													<td id="updatedTime_{$T.Result.sid}" style="text-align:center;vertical-align:middle;">{$T.Result.updatedTime}</td>
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
	<div class="modal modal-darkorange" id="categoryDIV">
        <div class="modal-dialog" style="width: 400px;margin: 80px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeCategoryDiv();">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="divForm" method="post" class="form-horizontal" enctype="multipart/form-data">
				            		<input type="hidden" id="dictTypeCode" name="dictTypeCode"/>
					                <div class="form-group">
					 					类型项编码：
					 					<input type="text" placeholder="必填" class="form-control" id="dictItemCode" name="dictItemCode">
					                </div>
					                <div class="form-group">
										类型项名称：
										<input type="text" placeholder="必填" class="form-control" id="dictItemName" name="dictItemName">
					                </div>
					                <div class="form-group">
					 					序列号：
										<input type="text" placeholder="必填" class="form-control" id="showSeq" name="showSeq">
					                </div>
					                <div class="form-group">
					 					备注：
										<input type="text" placeholder="非必填" class="form-control" id="memo" name="memo">
					                </div>
					                <div class="form-group">
					 					有效标志位：
										<select id="activeFlag" name="activeFlag">
											<option value="1" selected="selected">有效</option>
											<option value="0">无效</option>
										</select>
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
    <div class="modal modal-darkorange" id="itDiv2">
        <div class="modal-dialog" style="width: 400px;margin: 80px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeCategoryDiv();">×</button>
                    <h4 class="modal-title">修改类型项</h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="div2Form" method="post" class="form-horizontal" enctype="multipart/form-data">
				            		<input type="hidden" id="sid2" name="sid"/>
				            		<div class="form-group">
				            			业务类型编码：
				            			<input type="text" placeholder="必填" class="form-control" id="dictTypeCode2" name="dictTypeCode"/>
				            		</div>
					                <div class="form-group">
					 					类型项编码：
					 					<input type="text" placeholder="必填" class="form-control" id="dictItemCode2" name="dictItemCode">
					                </div>
					                <div class="form-group">
										类型项名称：
										<input type="text" placeholder="必填" class="form-control" id="dictItemName2" name="dictItemName">
					                </div>
					                <div class="form-group">
					 					序列号：
										<input type="text" placeholder="必填" class="form-control" id="showSeq2" name="showSeq">
					                </div>
					                <div class="form-group">
					 					备注：
										<input type="text" placeholder="非必填" class="form-control" id="memo2" name="memo">
					                </div>
					                <div class="form-group">
					 					有效标志位：
										<select id="activeFlag2" name="activeFlag">
											<option value="1" selected="selected">有效</option>
											<option value="0">无效</option>
										</select>
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeCategoryDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDiv2From();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
</div>
</body>
</html>