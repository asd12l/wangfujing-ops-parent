<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function(){
		$("#renewPassword").focus(function(){
			$("#errorMsg").hide();
		});
  		$("#edit").click(function(){
  			var vale = $("#newPassword").val();
  			var reVale = $("#renewPassword").val();
  			if(vale == reVale){
  				saveFrom();
  			} else {
  				$("#errorMsg").show();
  			}
  		});
  		/* $("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/userRole.jsp");
  		}); */
	});
  	//保存数据
  	function saveFrom(){
  		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/backUser/editUserPwd",
	        dataType: "json",
	        data: $("#theForm").serialize(),
	        success:function(response) {
	        	if(response.success == 'true'){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<strong>修改成功!</strong></div>");
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
								<span class="widget-caption">修改用户密码</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
									<div class="form-group">
										<label class="col-lg-3 control-label">用户名：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="username" name="userName" readonly="readonly"/>
											<script type="text/javascript">$("input[name='userName']").val(getCookieValue("username"));</script>
										</div>
									</div>
        
									<div class="form-group">
										<label class="col-lg-3 control-label">旧密码：</label>
										<div class="col-lg-6">
											<input type="password" value="" class="form-control" id="password" name="password" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">新密码：</label>
										<div class="col-lg-6">
											<input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">确认密码：</label>
										<div class="col-lg-6">
											<input type="password" class="form-control" id="renewPassword" placeholder="必填"/>
										</div>
										<dir id="errorMsg" style="color: red;display: none;">确认密码与新密码不相同</dir>
									</div>
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="edit" type="button" value="修改" />&emsp;&emsp;
											<!-- <input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消"/> -->
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