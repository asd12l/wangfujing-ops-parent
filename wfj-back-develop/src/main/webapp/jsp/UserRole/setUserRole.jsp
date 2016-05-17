<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<title>商品基本信息</title>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function(){
		$("#sid").val(sid);
		$("#realName").val(realName_);
		$("#userName").val(userName_);
  		$("#save").click(function(){
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/backUser.jsp");
  		});
  		var roleSid=$("#roleSid");
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/LimitRole/getAllUserfullRole",
			dataType: "json",
			success: function(response) {
				var result = response.list;
				roleSid.html("<option value='-1'></option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					if(roleSid_==ele.sid){
						var option = $("<option value='" + ele.sid + "'selected='selected'>"
								+ ele.roleName + "</option>");
						option.appendTo(roleSid);
					}else{
						var option = $("<option value='" + ele.sid + "'>"
								+ ele.roleName + "</option>");
						option.appendTo(roleSid);
					}
					
				}
				return;
			}
		});
  		$("#roleSid").val(roleSid_);
  		$("#oldRole").val(roleSid_);
	});
  	//保存数据
  	function saveFrom(){
  		$.ajax({
  			 type:"post",
 	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
 	        url:__ctxPath + "/backUser/updateBackUserRole",
 	        dataType: "json",
 	        data: $("#theForm").serialize(),
	        success:function(response) {
	        	if(response.success == 'true'){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>修改成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#warning2Body").text(buildErrorMessage("","修改失败！"));
					$("#warning2").show();
				}
        	}
		});
  	}
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/backUser.jsp");
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
								<span class="widget-caption">用户赋角色</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">   
									<input type="hidden" id="sid" name="userSid"/>
									<div class="form-group">
										<label class="col-lg-3 control-label">用户名</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="userName" name="userName" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">真实姓名</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="realName" name="realName" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">角色</label>
										<div class="col-lg-6">
											<select class="form-control" id="roleSid" name="roleSid" data-bv-field="country">
												<option value=""></option>
											</select>
											<input name="oldRole" id="oldRole" type="hidden">
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