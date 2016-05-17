<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<style type='text/css'>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>业务类型</title>
  <!--  
  <script type="text/javascript" src="${ctx}/sysjs/search/hotKeyView.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/search/addHotKey.js"></script>
  <script type="text/javascript" src="${ctx}/sysjs/search/updateHotKey.js"></script>
  <script type="text/javascript" src="${ctx}/outh/updateUserRole.js"></script>
  <script type="text/javascript" src="${ctx}/outh/backUserGrantRoleWindow.js"></script>
  -->
  <script type="text/javascript">
			__ctxPath = "${pageContext.request.contextPath}";
  </script> 
		
  <script type="text/javascript">
  var btPagination;
  $(function() {    	
      	initBt();
  		var sysParameterTypeSid=$("#sysParameterTypeSid");
  		$.ajax({
  		type: "post",
  		contentType: "application/x-www-form-urlencoded;charset=utf-8",
  		url: __ctxPath + "/channel/selectAllChannels",
  		dataType: "json",
  		success: function(response) {
  			var result = response.list;
  			sysParameterTypeSid.html("<option value='-1'></option>");
  			for ( var i = 0; i < result.length; i++) {
  				var ele = result[i];
  				var option = $("<option value='" + ele.sid + "'>"
  							+ ele.displayName + "</option>");
  					option.appendTo(sysParameterTypeSid);
  				
  			}
  			return;
  		}
  	});
  });
  function btQuery(){
	  var sysParameterTypeSid=$("#sysParameterTypeSid").val();
      var params = $("#bt_form").serialize();
      params = decodeURI(params);
      btPagination.onLoad(params);
		$.ajax({
	  		type: "post",
	  		contentType: "application/x-www-form-urlencoded;charset=utf-8",
	  		url: __ctxPath + "/hotKey/getShowCount.json",
	  		dataType: "json",
	  		data: {
					"chnId":sysParameterTypeSid
				},
	  		success: function(response) {
	  			var result = response.count;
	  			var param="页面中显示以下热词中前";
	  			if(result!="-1"){
	  				param=param+result+"个";
	  			}else{
	  				param="未配置页面中显示热词个数，默认显示前5个";
	  			}
	  			$("#count1").val(result);
	  			$("#editabledatatable_text").text(param);
	  			//sysParameterTypeSid.html("<option value='-1'></option>");
	  			return;
	  		}
	  	});
  	}
  function reset(){
  	btQuery();
  }
  function test(){
	  var param="{\"currency\": \"NCUSeuWzIkw\",\"failCallbackUrl\": \"gOjcf/qhrz25zNCdpObzTMT8aWKGuXXA/mI4aLHhj7AMTjHpkyBsqkUrB9xzyyRGzv0SGex6dZE=\",\"merchantNum\": \"110020313003\",\"version\": \"2.0\"}";
	  var obj = $.parseJSON(param);
	  alert($("#aaaa").val(obj.version));

  }
  //初始化商品列表
  	function initBt() {
  	var url = __ctxPath + "/hotKey/getChnHotKeys.json";
  	btPagination = $("#btPagination").myPagination({
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
             ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 100);
           },
           ajaxStop: function() {
             //隐藏加载提示
             setTimeout(function() {
               ZENG.msgbox.hide();
             }, 300);
           },
           callback: function(data) {
             //使用模板
             $("#bt_tab tbody").setTemplateElement("bt-list").processTemplate(data);
           }
         }
       });
  }
  //添加
  function addBt(){
  	var sysParameterTypeSid=$("#sysParameterTypeSid").val();
  	if(sysParameterTypeSid!=""&&sysParameterTypeSid!=-1){
  		$("#sid").val("");
  		$("#hotWord").val("");
  		$("#sequence").val(0);
  		$("#sysParameterTypeSid1").val(sysParameterTypeSid);
  		$("#divTitle").html("新建热词");
  		$("#btDiv").show();
  	}else{
  		alert("请选择频道");
  	}
  }

  function modifyBt(){
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
  		$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的记录!</strong></div>");
  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
  		 return false;
  	}
  	var value=	checkboxArray[0];
  	var sysParameterTypeSid=$("#sysParameterTypeSid").val();
  	$("#sid").val(value);
  	$("#hotWord").val($("#hotWord_"+value).text().trim());
	$("#sequence").val($("#sequence_"+value).text().trim());
	$("#sysParameterTypeSid1").val(sysParameterTypeSid);
  	//$("#sysParameterTypeSid1").val($("#sysParameterTypeSid_"+value).text().trim());
  	$("#divTitle").html("修改系统参数");
  	$("#btDiv").show();
  }
  function showDivNum(){
	  var sysParameterTypeSid=$("#sysParameterTypeSid").val();
	  if(sysParameterTypeSid!=""&&sysParameterTypeSid!=-1){
		  $("#sysParameterTypeSid2").val(sysParameterTypeSid);
		  var count=$("#count1").val();
		  if(count=="-1"){
			  $("#count").val("5");
		  }else{
			  $("#count").val(count);
		  }
		  $("#divNumTitle").html("修改热词显示数");
		  $("#btDivNum").show();
	  }else{
		  alert("请选择频道！");
	  }
  }
  //保存divNum中数据
  function saveDivNumFrom(){
  	var url = "";
  	if($("#count1").val()!="-1"){
  		url=__ctxPath + "/hotKey/updateShowCount.json";
  	}else{
  		url=__ctxPath+"/hotKey/newShowCount.json";
  	}
  	$.ajax({
  		type: "post",
  		contentType: "application/x-www-form-urlencoded;charset=utf-8",
  		url: url,
  		dataType: "json",
  		data: $("#divNumForm").serialize(),
  		success: function(response) {
  			//alert(response.success);
  			if(response.success==true){
  				$("#btDivNum").hide();
  				$("#count1").val("");
  				$("#count").val("");
  		  		alert("操作成功！");
  		  		btQuery();
  				//$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
  				//	"<i class='fa-fw fa fa-times'></i><strong>操作成功</strong></div>");
  	  				//$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
  			}else{
  				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.obj+"</strong></div>");
  				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
  			}
  			return;
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

  function deleteBt(){
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
  		$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要删除的记录!</strong></div>");
  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
  		 return false;
  	}
  	var value=	checkboxArray[0];
  	bootbox.confirm("确定删除吗？", function(r){
  		if(r){
  			$.ajax({
  				type: "post",
  				contentType: "application/x-www-form-urlencoded;charset=utf-8",
  				url: __ctxPath+"/hotKey/destroyHotKey.json",
  				dataType: "json",
  				data: {
  					"sid":value
  				},
  				success: function(response) {
  					if(response.success==true){
  						alert("操作成功！");
  		  		  		btQuery();
  						//$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
  						//	"<i class='fa-fw fa fa-times'></i><strong>删除成功</strong></div>");
  	  	  				//$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
  					}else{
  						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>禁用失败</strong></div>");
  						$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
  					}
  					return;
  				}
  			});
  		}
  	});
  }
  //保存div中数据
  function saveDivFrom(){
  	var url = "";
  	if($("#sid").val()!=""){
  		url=__ctxPath + "/hotKey/updateHotKey.json";
  	}else{
  		url=__ctxPath+"/hotKey/addHotKey.json";
  	}
  	$.ajax({
  		type: "post",
  		contentType: "application/x-www-form-urlencoded;charset=utf-8",
  		url: url,
  		dataType: "json",
  		data: $("#divForm").serialize(),
  		success: function(response) {
  			//alert(response.success);
  			if(response.success==true){
  				$("#btDiv").hide();
  				$("#sid").val("");
  				$("#hotWord").val("");
  		  		$("#sequence").val(0);
  		  		alert("操作成功！");
  		  		btQuery();
  				//$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
  				//	"<i class='fa-fw fa fa-times'></i><strong>操作成功</strong></div>");
  	  				//$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
  			}else{
  				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.obj+"</strong></div>");
  				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
  			}
  			return;
  		}
  	});
  }
  function successBtn(){
	  var sysParameterTypeSid=$("#sysParameterTypeSid").val();
	  $("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	  $("#pageBody").load(__ctxPath+"/jsp/hotKey.jsp");
	  $("#sysParameterTypeSid").val(sysParameterTypeSid);
	  btQuery();
  }
  function closeBtDiv(){
  	$("#btDiv").hide();
  }
  function closeBtDivNum(){
	  	$("#btDivNum").hide();
	  }
  </script>
</head>
<body>
  <div class="main-container container-fluid">
        <!-- Page Container -->
        <div class="page-container">
                <!-- Page Body -->
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>热词词库</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                <form id="bt_form">
                                    <div class="table-toolbar">
                                    	频道:<select id="sysParameterTypeSid" name="chnId" onchange="btQuery();"></select>
                                    	<a id="editabledatatable_new" onclick="addBt();" class="btn btn-primary glyphicon glyphicon-plus">
											增加
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="modifyBt();" class="btn btn-info glyphicon glyphicon-wrench">
											修改
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="deleteBt();" class="btn btn-danger glyphicon glyphicon-trash">
											删除
                                        </a>
                                       <div class="btn-group pull-right">
                                       	 <a id="editabledatatable_text" onclick="showDivNum();" class="btn btn-info glyphicon glyphicon-wrench">
											修改
                                        </a>
                                        </div>
                                    </div>
                                    </form>
                                    <table class="table table-striped table-hover table-bordered" id="bt_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th width="7.5%"></th>
                                            	<th style="text-align: center;">Sid</th>
                                                <th style="text-align: center;">热词名称</th>
                                                <th style="text-align: center;">排序</th>
                                                <th style="text-align: center;">启用状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                               
								<!-- Templates -->
								<p style="display:none">
									<textarea id="bt-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center">{$T.Result.sid}</td>
													<td align="center" id="hotWord_{$T.Result.sid}">{$T.Result.hotWord}</td>
													<td align="center" id="sequence_{$T.Result.sid}">{$T.Result.sequence}</td>
													
													<td align="center" id="valid_{$T.Result.sid}" value="{$T.Result.valid}">
														{#if $T.Result.valid == true}
						           							已启用
						                      			{#elseif $T.Result.valid == false}
						           							未启用
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
				            		<input type="hidden" id="sysParameterTypeSid1" name="chnId"/>
				            		<input type="hidden" id="sid" name="sid">
					                <div class="form-group">
					 					热词名称：
					 					<input type="text" placeholder="必填" class="form-control" id="hotWord" name="hotWord">
					                </div>
					                <div class="form-group">
										排序：
										<input type="text" placeholder="必填" class="form-control" id="sequence" name="sequence">
					                </div>
					                <div class="form-group">
										是否启用：
										<select name="valid" id="valid">
											<option value="true">启用</option>
											<option value="false">不启用</option>
										</select>
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivFrom();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    <div class="modal modal-darkorange" id="btDivNum">
        <div class="modal-dialog" style="width: 400px;margin: 160px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="divNumTitle"></h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="divNumForm" method="post" class="form-horizontal" enctype="multipart/form-data">
				            		<input type="hidden" id="sysParameterTypeSid2" name="chnId"/>
				            		<input type="hidden" id="count1"/>
					                <div class="form-group">
					 					输入显示数：
					 					<input type="text" placeholder="必填" class="form-control" id="count" name="count">
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDivNum();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivNumFrom();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
</body>
</html>