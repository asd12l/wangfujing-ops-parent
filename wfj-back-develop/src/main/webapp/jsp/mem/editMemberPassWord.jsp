<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var url = __ctxPath + "/mem/getByUsername";
  	$(function(){
  		$("#sid").val(sid_);
  		$("#username").val(username_);
  		$("#mobile").val(mobile_);
  		$("#password").val(password_);
  		$("#save").click(function(){
  			saveFrom();
  			$("#pageBody").load(__ctxPath+"/jsp/mem/MemberView.jsp");
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/mem/MemberView.jsp");
  		});
	});
  	function saveFrom(){
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/mem/editPassword",
			dataType:"json",
			data: $("#theForm").serialize(),
			success: function(response) {
				/* if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'><i class='fa-fw fa fa-times'></i><strong>修改成功，返回列表页!</strong></div>");
 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改失败!</strong></div>");
 	     	  		$("#model-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;  */
				alert("密码修改成功，返回页面");
				$("#pageBody").load(__ctxPath+"/jsp/mem/MemberView.jsp");
			},
			error: function() {
				$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
 	  			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
			}
		});
  	}
  	function successBtn(){
  		$("#model-warning").attr({"style":"display:block;z-index:9999","aria-hidden":"false","class":"modal modal-message modal-warning"});
		$("#pageBody").load(__ctxPath+"/jsp/mem/MemberView.jsp");
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
								<span class="widget-caption">用户密码修改</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" id="sid"  name="sid" /> 
									<div class="form-group">
										<label class="col-lg-3 control-label">用户名:</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled"  id="username" name="username" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">手机号:</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled"  id="mobile" name="mobile" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">密码:</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled"  id="password" name="password" />
										</div>
									</div>
									
        							<div class="form-group">
										<label class="col-lg-3 control-label">新密码:</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="password" name="password" maxlength="50"  placeholder="必填" 
											 onkeyup="value=value.replace(/[\u4E00-\u9FA5]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[\u4E00-\u9FA5]/g,''))"/>
										</div>
									</div>
									
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消" />
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