<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("ctx", request.getContextPath());
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<title>系统设置</title>
<script type="text/javascript">
__ctxPath = "${pageContext.request.contextPath}";
$(function(){
	
	$.ajax({
        type:"post",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        dataType: "json",
        ajaxStart: function() {
	       	 $("#loading-container").attr("class","loading-container");
	        },
        ajaxStop: function() {
          //隐藏加载提示
          setTimeout(function() {
       	        $("#loading-container").addClass("loading-inactive")
       	 },300);
        },
        url: __ctxPath + "/config/load_systemconfig",
        success: function(response) {
        	if(response.success == 'true'){
				$("#port").val(response.port);
				$("#defImg").val(response.defImg);
				$("#dbFileUri").val(response.dbFileUri);
				if(response.emailValidate=="false"){
					$("#emailValidate_0").arr("checked");
				}else if(response.emailValidate=="true"){
					$("#emailValidate_1").arr("checked");
				}
				if(response.uploadToDb=="false"){
					$("#uploadToDb_0").arr("checked");
				}else if(response.uploadToDb=="true"){
					$("#uploadToDb_1").arr("checked");
				}
				if(response.viewOnlyChecked=="false"){
					$("#viewOnlyChecked_0").arr("checked");
				}else{
					$("#viewOnlyChecked_1").arr("checked");
				}
				$("#config_id").val(response.id);
        	}else if(response.msg!=""){
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.msg+"</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
    	}
	});
	
	/* $('#theForm').bootstrapValidator({
		message : 'This value is not valid',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		submitHandler : function(validator, form, submitButton) {
			// Do nothing
		},
		fields : {
			mainTitle : {
				validators : {
					notEmpty : {
						message : '名称不能为空'
					}
				}
			}
		} 

	}).find('button[data-toggle]').on(
			'click',
			function() {
				var $target = $($(this).attr('data-toggle'));
				$target.toggle();
				if (!$target.is(':visible')) {
					$('#theForm').data('bootstrapValidator')
							.disableSubmitButtons(false);
				}
			});*/
	
		$("#save").click(function(){
			saveFrom();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/web/config/system_config.jsp");
		});
});
	//保存数据
	function saveFrom(){
		if($("#mainTitle").val() == ""&&$("#link").val() == ""){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>必填缺失!</strong></div>");
		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}else{
		/* $("#theForm").ajaxSubmit({ */
  		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        dataType: "json",
	        ajaxStart: function() {
		       	 $("#loading-container").attr("class","loading-container");
		        },
	        ajaxStop: function() {
	          //隐藏加载提示
	          setTimeout(function() {
	       	        $("#loading-container").addClass("loading-inactive")
	       	 },300);
	        },
	        url: __ctxPath + "/config/systemconfig",
	        data: $("#theForm").serialize(),
	        success: function(response) {
	        	if(response.success == 'true'){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>添加成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	        	}else if(response.msg!=""){
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.msg+"</strong></div>");
 	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
        	}
		});
		}
	}
	function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
	$("#pageBody").load(__ctxPath+"/jsp/web/system_config.jsp");
}
</script>

</head>
<body>
<div class="page-body">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">添加引导链接</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">  
									<input type="hidden" name="config_id" id="config_id" value="" /> 
									<div class="form-group">
										<label class="col-lg-3 control-label">部署路径</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="contextPath" name="contextPath" placeholder="部署在根目录请留空"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">端口号</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="port" name="port" placeholder=""/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">默认图片</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="defImg" name="defImg" placeholder=""/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">附件地址</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="dbFileUri" name="dbFileUri" placeholder=""/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">开启邮箱验证</label>
										<div class="col-lg-5">
											<div class="radio">
												<label>
													<input class="basic" type="radio" id="emailValidate_1" name="emailValidate" value="1">
													<span class="text">是</span>
												</label>
												<label>
													<input class="basic" type="radio" id="emailValidate_0" name="emailValidate" value="0">
													<span class="text">否</span>
												</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">数据库附件</label>
										<div class="col-lg-5">
											<div class="radio">
												<label>
													<input class="basic" type="radio" id="uploadToDb_1" name="uploadToDb" value="1">
													<span class="text">是</span>
												</label>
												<label>
													<input class="basic" type="radio" id="uploadToDb_0" name="uploadToDb" value="0">
													<span class="text">否</span>
												</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">只终审浏览内容页</label>
										<div class="col-lg-5">
											<div class="radio">
												<label>
													<input class="basic" type="radio" id="viewOnlyChecked_1" name="viewOnlyChecked" value="1">
													<span class="text">是</span>
												</label>
												<label>
													<input class="basic" type="radio" id="viewOnlyChecked_0" name="type" value="0">
													<span class="text">否</span>
												</label>
											</div>
										</div>
									</div>
									
									<!-- <div id="form-group">
									<label class="col-lg-3 control-label">图片上传</label>
										<p class="col-lg-6">
											<span id="ufc1" style="position:relative">
											<input class="browse" type='button' value=''/>
											<input onchange="" type="file" id="uploadFile1" class="file-button"/>
											</span>
											<input class="upload-button" type="button" value="" onclick=""/>
											</p>
									</div> -->
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消"/>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
 <!-- /Page Body -->
	<script>
    </script>
</body>
</html>