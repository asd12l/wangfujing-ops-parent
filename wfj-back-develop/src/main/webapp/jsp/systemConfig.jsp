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
<title>系统开关配置管理</title>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var sysCofPagination;

	$(function() {
		initSysConfig();
	});
	function initSysConfig() {
		var url = __ctxPath + "/sysConfig/findAll";
		sysCofPagination = $("#sysCofPagination").myPagination(
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
							ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 100);
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								ZENG.msgbox.hide();
							}, 300);
						},
						callback : function(data) {
							//使用模板
							$("#sysCof_tab tbody").setTemplateElement("sysCof-list")
									.processTemplate(data);
						}
					}
				});
	}
	
	function tab(data){
		if(data=='sysCof'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#sysCof").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#sysCof").css({"display":"block"});
			}
		}
	}
	
	//添加
	function addSysConfig(){
		$("#sysKey").val("");
		$("#sysValue").val("");
		$("#sysDesc").val("");
		$("#divTitle").html("增加系统配置参数");
		$("#sysConfigDiv").show();
	}

	function modifySysConfig(){
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
		var value = checkboxArray[0];
		$("#sid").val(value);
		$("#sysKey").val($("#sysKey_"+value).text().trim());
		$("#sysValue").val($("#sysValue_"+value).text().trim());
		$("#sysDesc").val($("#sysDesc_"+value).text().trim());
		$("#divTitle").html("修改系统配置参数");
		$("#sysConfigDiv").show();
	}
	function saveDivFrom(){
		if($("#sysKey").val().trim() == ""){
			$("#warning2Body").text("参数名不能为空");
			$("#warning2").attr("style", "z-index: 9999;");
			$("#warning2").show();
			return;
		}
		if($("#sysValue").val().trim() == ""){
			$("#warning2Body").text("参数值不能为空");
			$("#warning2").attr("style", "z-index: 9999;");
			$("#warning2").show();
			return;
		}
		var url = "";
		if($("#sid").val().trim() != ""){
			url=__ctxPath + "/sysConfig/editSysConfigByKey";
		}else{
			url=__ctxPath+"/sysConfig/saveSysConfig";
		}
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType: "json",
			data: $("#divForm").serialize(),
			success: function(response) {
				if(response.success){
					$("#btDiv").hide();
					$("#sid").val("");
					$("#sysKey").val("");
					$("#sysValue").val("");
					$("#sysDesc").val("");
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<strong>保存成功</strong></div>");
		  			$("#modal-success").attr({"style":"display:block;z-index: 9999;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><strong>"+response.msg+"</strong></div>");
					$("#modal-warning").attr({"style":"display:block;z-index: 9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	}
	
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		closeSysConfigDiv()
		sysCofPagination.onReload();
	}
	function closeSysConfigDiv(){
		$("#sysConfigDiv").hide();
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
								<span class="widget-caption"><h5>系统配置管理</h5></span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('sysCof');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="sysCof">
								<form id="bt_form">
                                    <div class="table-toolbar">
                                    	<a id="editabledatatable_new" onclick="addSysConfig();" class="btn btn-primary glyphicon glyphicon-plus">
											增加
                                        </a>&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="modifySysConfig();" class="btn btn-info glyphicon glyphicon-wrench">
											修改
                                        </a>&nbsp;&nbsp;
                                    </div>
                                </form>
								<table class="table table-striped table-hover table-bordered"
									id="sysCof_tab">
									<thead>
										<tr role="row">
											<th width="7.5%" style="text-align: center;">选择</th>
											<th style="text-align: center;">参数名</th>
											<th style="text-align: center;">参数值</th>
											<th style="text-align: center;">参数描述</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<!-- <div id="sysCofPagination"></div> -->
							</div>

							<!-- Templates -->
							<p style="display: none">
								<textarea id="sysCof-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.data as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="sysKey_{$T.Result.sid}">{$T.Result.sysKey}</td>
													<td align="center" id="sysValue_{$T.Result.sid}">{$T.Result.sysValue}</td>
													<td align="center" id="sysDesc_{$T.Result.sid}">{$T.Result.sysDesc}</td>
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
	<div class="modal modal-darkorange" id="sysConfigDiv">
        <div class="modal-dialog" style="width: 400px;margin: 160px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeSysConfigDiv();">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="divForm" method="post" class="form-horizontal" enctype="multipart/form-data">
				            		<input type="hidden" id="sid" name="sid"/>
					                <div class="form-group">
					 					参数名：
					 					<input type="text" placeholder="必填" class="form-control" id="sysKey" name="sysKey">
					                </div>
					                <div class="form-group">
										参数值：
										<input type="text" placeholder="必填" class="form-control" id="sysValue" name="sysValue">
					                </div>
					                <div class="form-group">
					 					参数描述：
					 					<input type="text" class="form-control" id="sysDesc" name="sysDesc">
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeSysConfigDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivFrom();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
</body>
</html>