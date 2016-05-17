<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("ctx", request.getContextPath());
%>
<%
	String id = request.getParameter("sid");
	request.setAttribute("sid", id);
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
<title>模板管理</title>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function(){
		$("#divSid").val(divSid_);
		$("#divTitle").val(divTitle_);
		
		/* $("#divType").val(divType_); */
		
			$("#save").click(function(){
				saveFrom();
			});
			$("#close").click(function(){
				$("#pageBody").load(__ctxPath+"/jsp/web/template/templateList.jsp");
			});
	});
	//保存数据
	function saveFrom(){
		var divTitle=$("#divTitle").val();
		if($("#divTitle").val() == ""){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>必填缺失!</strong></div>");
		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}else{
			$.ajax({
		        type:"post",
		        dataType: "json",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        url:__ctxPath + "/web/modifyFloorDiv",
		        data: $("#theForm").serialize(),
		        success:function(response) {
		        	if(response.success == 'true'){
						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
							"<i class='fa-fw fa fa-times'></i><strong>修改成功，返回列表页!</strong></div>");
			  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
		        	}else if(response.msg!=""){
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.msg+"</strong></div>");
			     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					}
		    	}
			});
		}
	}
	//弹出框的确定按钮
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/web/template/templateList.jsp");
	}
	//返回按钮
	function back(){
		$("#pageBody").load(__ctxPath+"/jsp/web/template/templateList.jsp");
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
								<span class="widget-caption">ftp设置</span>
								<div class="btn-group pull-right">
               						<a id="editabledatatable_edit" onclick="back();" 
               							class="btn btn-info glyphicon glyphicon-wrench">
               							返回列表
               						</a>
								</div>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" name="divSid" id="divSid" value="" />
									<div class="form-group">
										<label class="col-lg-3 control-label">默认方案</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="divTitle"
												name="divTitle" placeholder="default" />
											<a id="" onclick="setThis();" class="btn btn-danger glyphicon glyphicon-trash">
												设置
                       						</a>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">导出</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="divTitle"
												name="divTitle" placeholder="default" />
											<a id="" onclick="out();" class="btn btn-danger glyphicon glyphicon-trash">
												导出
                       						</a>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">导入</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="divTitle"
												name="divTitle" placeholder="" />
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