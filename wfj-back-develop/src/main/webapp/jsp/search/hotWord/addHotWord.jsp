<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
  	$(function(){
  		$("#close").click(function(){ 
  			$("#pageBody").load(__ctxPath+"/jsp/search/hotWord/hotWordManage.jsp");
  		});
	});
  	
  	$('#theForm').bootstrapValidator({
		message : 'This value is not valid',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		submitHandler : function(validator, form, submitButton) {
			var url = __ctxPath + "/hotWord/addHotWord";
	  		$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: url,
				dataType:"json",
				data: $("#theForm").serialize(),
				ajaxStart: function() {$("#loading-container").attr("class","loading-container");},
				ajaxStop: function() {
					setTimeout(function() {$("#loading-container").addClass("loading-inactive");},300);
				},
				success: function(response) {
					if(response.success==true){
						$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
	 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
					}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
		     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
					return;
				}
			});
	  	
		},
		fields : {
			value : {
				validators : {
					notEmpty : {
						message : '显示内容不能为空'
					}
				}
			},
			link : {
				validators : {
					notEmpty : {
						message : '链接不能为空'
					}
				}
			}
		}

	}).find('button[data-toggle]').on('click',function() {
		var $target = $($(this).attr('data-toggle'));
		$target.toggle();
		if (!$target.is(':visible')) {
			$('#theForm').data('bootstrapValidator').disableSubmitButtons(false);
		}
	});
  	
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/search/hotWord/hotWordManage.jsp");
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
								<span class="widget-caption">添加热词</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="site" id="site" value="${param.site}"/>
									<input type="hidden" name="channel" id="channel" value="${param.channel}"/>
										
        							<div class="form-group">
										<label class="col-lg-3 control-label">显示内容：</label>
										<div class="col-lg-6" style="width:230px;">
											<input maxlength="200" type="text" class="form-control" id="value" name="value" placeholder="必填" onpaste="return true"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">链接：</label>
										<div class="col-lg-6" style="width:230px;">
											<input  maxlength="1000" type="text" class="form-control" id="link" name="link" placeholder="必填" onpaste="return true"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">显示顺序：</label>
										<div class="col-lg-6" style="width:230px;">
											<input  maxlength="20" type="text" class="form-control" id="orders" name="orders" onpaste="return false"/>
										</div>
									</div>
									
									<!-- <div class="form-group">
										<label class="col-lg-3 control-label">是否有效：</label>
										<div class="col-lg-2">
											<select style="width:200px;padding: 0px 0px;" id="country" name="enabled">
												<option value="true">有效</option>
												<option value="false" selected="selected">无效</option>
											</select>
										</div>
									</div>
									 -->
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save" type="submit" >保存</button>&emsp;&emsp;
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