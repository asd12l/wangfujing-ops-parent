<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<!-- 
 <script type="text/javascript" src="${ctx}/sysjs/TreeSelector.js"></script>
  <script type="text/javascript" src="${ctx}/outh/userRoleview.js"></script>
  <script type="text/javascript" src="${ctx}/outh/addUserRole.js"></script>
  <script type="text/javascript" src="${ctx}/outh/updateUserRole.js"></script>
  <script type="text/javascript" src="${ctx}/outh/roleGrantWindow.js"></script>
 -->
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<style type='text/css'>
#bg{ display: none; position: absolute; top: 0%; left: 0%; width: 100%; height: 100%; background-color: black; z-index:1001; -moz-opacity: 0.7; opacity:.70; filter: alpha(opacity=70);}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>业务类型</title>

  <script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var productPagination;
	$(function() {    	
	    initUserRole();
	    $("#pageSelect").change(userRoleQuery);
	});
	function userRoleQuery(){
        var params = $("#product_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        productPagination.onLoad(params);
   	}
	//初始化角色列表
 	function initUserRole() {
		var url = __ctxPath+"/searchIndex/getProIndexList";
		productPagination = $("#productPagination").myPagination({
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
             url: url,
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
               $("#product_tab tbody").setTemplateElement("product-list").processTemplate(data);
             }
           }
         });
    }	
	//跳到编辑角色页面
	function updateIndex(){
		
		 //  /admin/indexOp/all/fresh.json
		 $.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/searchIndex/proIndexFresh",
				dataType: "json",
				success: function(response) {
					if(response.success=="true"){
						ZENG.msgbox.show(" 正在刷新中，请稍后查看...", 1, 8000);
						//ZENG.msgbox.hide();
						initUserRole();
					}else{
						ZENG.msgbox.hide();
						alert("刷新失败！");
					}
					return;
				}
			});
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/userRole.jsp");
	}
	function openSingleIndexFresh(){
		$("#divTitle").html("单件商品索引管理");
		$("#opt").val(0);
		$("#sid").val("");
		$("#btDiv").show();
	}
	function openSingleIndexDel(){
		$("#divTitle").html("单件商品索引剔除");
		$("#opt").val(1);
		$("#sid").val("");
		$("#btDiv").show();
	}
	function saveDivForm(){
		var opt=$("#opt").val();
		var sid=$("#sid").val();
	  	if(!isNaN(sid)&&sid!=""){
	  		var url = "";
		  	if(opt==0){
		  		url=__ctxPath + "/searchIndex/proIndexSigleFresh.json";
		  	}else if(opt==1){
		  		url=__ctxPath+"/searchIndex/proIndexSigleDel.json";
		  	}
		  	$.ajax({
		  		type: "post",
		  		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		  		url: url,
		  		dataType: "json",
		  		data: $("#divForm").serialize(),
		  		success: function(response) {
		  			if(response.success=="true"){
		  				$("#btDiv").hide();
		  				$("#sid").val("");
		  		  		alert("操作成功！");
		  			}else{
		  				alert("操作失败！"+response.msg);
		  			}
		  			return;
		  		}
		  	});
	  	}else{
	  		alert("sid必须为非空数字！");
	  	}
	  }
	function freshWebCache(){
		  		var url=__ctxPath+"/searchIndex/flushWebCache.json";
			  	$.ajax({
			  		type: "post",
			  		contentType: "application/x-www-form-urlencoded;charset=utf-8",
			  		url: url,
			  		dataType: "json",
			  		data: $("#divForm").serialize(),
			  		success: function(response) {
			  			if(response.success==true){
			  		  		alert("操作成功！");
			  			}else{
			  				alert("操作失败！");
			  			}
			  			return;
			  		}
			  	});
		  }
	function closeBtDiv(){
	  	$("#btDiv").hide();
	  }
  </script>
</head>
<body>
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
                                    <span class="widget-caption"><h5>商品索引管理</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div id="bg"></div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                        <a id="editabledatatable_new" onclick="updateIndex();" class="btn btn-info glyphicon glyphicon-wrench">
											全量商品刷新索引
                                        </a>
                                        <a id="editabledatatable_new" onclick="openSingleIndexFresh();" class="btn btn-info glyphicon glyphicon-wrench">
											单件商品刷新索引
                                        </a>
                                        <a id="editabledatatable_new" onclick="openSingleIndexDel();" class="btn btn-danger glyphicon glyphicon-trash">
											单件商品索引剔除
                                        </a>
                                        <a id="editabledatatable_new" onclick="freshWebCache();" class="btn btn-info glyphicon glyphicon-wrench">
											刷新前台搜索缓存
                                        </a>
                                       <div class="btn-group pull-right">
                                       		 <form id="product_form" action="">
	                                        	<select id="pageSelect" name="pageSize">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
	                                       	</form>
                                        </div>
                                    </div>
                                    <table class="table table-striped table-hover table-bordered" id="product_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th></th>
                                            	<th>触发原因</th>
                                                <th>启动时间</th>
                                                <th>结束时间</th>
                                                <th>状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <div id="productPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
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
													<td id="caller_{$T.Result.sid}" value="{$T.Result.caller}">
													{#if $T.Result.caller == 'SYSTEM'}
						           							系统定时
						                      			{#else}
						           							手动
						                   				{#/if}
													</td>
													<td id="starttime_{$T.Result.sid}">{$T.Result.starttime}</td>
													<td id="endtime_{$T.Result.sid}" value="{$T.Result.endtime}">
														{#if $T.Result.endtime==null}
															无
														{#else}
														{$T.Result.endtime}
														{#/if}
													</td>
													<td id="status_{$T.Result.sid}" value="{$T.Result.status}">
														{#if $T.Result.status == 0}
						           							执行中
						                      			{#elseif $T.Result.status == 1}
						           							完成
						                   				{#else $T.Result.status == -1}
						           							失败
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
         <div class="modal modal-darkorange" id="btDiv">
        <div class="modal-dialog" style="width: 400px;margin: 160px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv();">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="divForm" method="post" class="form-horizontal" enctype="multipart/form-data">
					                <div class="form-group">
					 					商品SID:
					 					<input type="hidden" value="0" id="opt"/>
					 					<input type="text" placeholder="必填" class="form-control" id="sid" name="sid">
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivForm();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
</body>
</html>