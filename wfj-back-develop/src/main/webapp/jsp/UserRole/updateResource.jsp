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
		$("#rsName").val(rsName_);
		$("#rsCode").val(rsCode_);
		$("#rsUrl").val(rsUrl_);
		$("#isLeaf").val(isLeaf_);
		$("#delFlag").val(delFlag_);
		$("#parentSid").val(parentSid_);
  		$("#save").click(function(){
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/roleResource.jsp");
  		});
	});
  	//保存数据
  	function saveFrom(){
  		$.ajax({
  			 type:"post",
 	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
 	        url:__ctxPath + "/limitResource/updateLimitResources",
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
		$("#pageBody").load(__ctxPath+"/jsp/roleResource.jsp");
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
								<span class="widget-caption">编辑资源</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">   
									<input type="hidden" id="sid" name="sid"/>
									<div class="form-group">
										<label class="col-lg-3 control-label">资源名称</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="rsName" name="rsName" placeholder="必填"/>
											<input type="hidden" class="form-control" id="parentSid" name="parentSid"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">资源编码</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="rsCode" name="rsCode" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">资源路径</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="rsUrl" name="rsUrl" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">是否为叶子节点</label>
										<div class="col-lg-6">
											<select class="form-control" id="isLeaf" name="isLeaf" data-bv-field="country">
												<option value=""></option>
												<option value="0">否</option>
												<option value="1">是</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">是否有效</label>
										<div class="col-lg-6">
											<select class="form-control" id="delFlag" name="delFlag" data-bv-field="country">
												<option value=""></option>
												<option value="0">有效</option>
												<option value="1">无效</option>
											</select>
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