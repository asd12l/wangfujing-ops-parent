<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--Page Related Scripts-->
<script
	src="${pageContext.request.contextPath}/assets/js/validation/bootstrapValidator.js"></script>
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
  	$(function(){
  		$('#theForm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			submitHandler : function(validator, form, submitButton) {
				// Do nothing
				$.ajax({
					type: "post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					dataType:"json",
					ajaxStart: function() {
				       	 $("#loading-container").attr("class","loading-container");
				        },
			        ajaxStop: function() {
			          //隐藏加载提示
			          setTimeout(function() {
			       	        $("#loading-container").addClass("loading-inactive")
			       	 },300);
			        },
					url: __ctxPath + "/photo/insertPhotoguige",
					data: $("#theForm").serialize(),
					success: function(response) {
						if(response.success==true){
							$("#warning2Body").text("图片规格添加成功!");
							//$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>图片规格添加成功!</strong></div>");
		 	     	  		//$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
		 	     	  		$("#pageBody").load(__ctxPath+"/jsp/photo/photoRedu.jsp");
						}else if(response.errMsg!=""){
							$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.errMsg+"</strong></div>");
		 	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
						}
						return;
					},
					/* error: function() {
						//$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
		 	  			//$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
						$("#pageBody").load(__ctxPath+"/jsp/photo/photoRedu.jsp");
					} */
					error: function(XMLHttpRequest, textStatus) {		      
						var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
						if(sstatus != "sessionOut"){
							$("#pageBody").load(__ctxPath+"/jsp/photo/photoRedu.jsp");	
						}
						if(sstatus=="sessionOut"){     
			            	 $("#warning3").css('display','block');     
			            }
					}
				});
			},
			fields : {
				photoname : {
					validators : {
						notEmpty : {
							message : '规格名称不能为空'
						//},
						//regexp : {
						//	regexp : /^[-\u4E00-\u9FA5]{1,20}$/,
						//	message : '规格名称必须是由1到20位的中文或者"-"组成'
						}
					}
				},
			width : {
				validators : {
					notEmpty : {
						message : '规格宽不能为空'
					},
					regexp : {
						regexp : /^[1-9]\d{0,3}$/,
						message : '规格宽必须是小于1000的正整数'
					}
				}
			},
				height : {
					validators : {
						notEmpty : {
							message : '规格高不能为空'
						},
						regexp : {
							regexp : /^[1-9]\d{0,3}$/,
							message : '规格高必须是小于1000的正整数'
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
				});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/photo/photoRedu.jsp");
  		});
	});
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
								<span class="widget-caption">添加图片规格</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">宽：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">

												<input maxlength="20" type="text" class="form-control" id="width" name="width"  onpaste="return false;"/>

											</div>	
											<label class="control-label" >（像素）</label>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">高：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">

												<input maxlength="20" type="text" class="form-control" id="height" name="height"  />

											</div>		
											<label  class="control-label"  >（像素）</label>					
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">名字：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">

												<input maxlength="20" type="text" class="form-control" id="photoname" name="photoname" />

											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">备注：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">

												<input maxlength="20" type="text" class="form-control" id="remark" name="remark" />

											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">&nbsp;</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
											<button class="btn btn-success" style="width: 25%;" id="save" type="submit" >确定</button>&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消" />
											</div>
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