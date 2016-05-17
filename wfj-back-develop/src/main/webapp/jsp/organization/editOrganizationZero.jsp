<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function(){
		$("#sid").val(sid);
		if (parentSid_ != '[object Object]') {
			$("#parentSid").val(parentSid_);
		}else{
			$("#parentSid").val(0);
		}
		if (groupSid_ != '[object Object]') {
			$("#groupSid").val(groupSid_);
		}else{
			$("#groupSid").val(0);
		}
		$("#organizationCode").val(organizationCode_);
		$("#organizationName").val(organizationName_);
		$("#organizationType").val(organizationType_);
		$("#organizationStatus").val(organizationStatus_);
		$("#createName").val(createName_);
		$("#updateName").val(updateName_);
		
		$('#theForm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			submitHandler : function(validator, form, submitButton) {
				// Do nothing
				var url = __ctxPath + "/organization/updateOrganizationZero";
				$.ajax({
					type: "post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					url: url,
					dataType:"json",
					ajaxStart: function() {
				       	 $("#loading-container").attr("class","loading-container");
				        },
			        ajaxStop: function() {
			          //隐藏加载提示
			          setTimeout(function() {
			       	        $("#loading-container").addClass("loading-inactive");
			       	 },300);
			        },
					data: $("#theForm").serialize(),
					success: function(response) {
						if(response.success=="true"){
							$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>修改成功，返回列表页!</strong></div>");
		 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
						}else if(response.data.errorMsg!=""){
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					        $("#warning2").show();}
						return;
					},
					error: function(XMLHttpRequest, textStatus) {		      
						var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
						if(sstatus != "sessionOut"){
							$("#warning2Body").text(buildErrorMessage("","系统出错！"));
					        $("#warning2").show();
						}
						if(sstatus=="sessionOut"){     
			            	 $("#warning3").css('display','block');     
			             }
					}
				});
			},
			fields : {
				organizationName : {
					validators : {
						notEmpty : {
							message : '集团名称不能为空'
						},
						regexp : {
							regexp : /^[-\u4E00-\u9FA5]{1,20}$/,
							message : '集团名称必须是由1到20位的中文或"-"组成'
						}
					}
				},
				organizationCode:{
					validators : {
						notEmpty : {
							message : '集团编码不能为空'
						},
						regexp : {
							regexp : /^[1-9]{1}[0-9]{0,17}$/,
							message : '集团编码第一位不能为0且不超过18位的数字组成'
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
		
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/organization/organizationZeroView.jsp");
  		});
	});
  	
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/organization/organizationZeroView.jsp");
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
								<span class="widget-caption">修改集团</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">    
									<input type="hidden" id="sid" name="sid"/> 
									<input type="hidden" name="userName" value=""/>   
									<input type="hidden" id="createName" name="createName"/>    
									<input type="hidden" value="" name="updateName"/> 
									<script type="text/javascript">
										$("input[name='userName']").val(getCookieValue("username"));
										$("input[name='updateName']").val(getCookieValue("username"));
									</script>    
									<input type="hidden" id="parentSid" name="parentSid"/>    
									<input type="hidden" id="groupSid" name="groupSid"/>    
									<input type="hidden" id="organizationType" name="organizationType"/>    
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:12%">集团编码：</label>
											<div class="col-lg-6" style="width:250px">
												<input maxlength="20" type="text" class="form-control" id="organizationCode" name="organizationCode"  readonly="true" placeholder="必填"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:12%">集团名称：</label>
											<div class="col-lg-6" style="width:250px">
												<input maxlength="20" type="text" class="form-control" id="organizationName" name="organizationName" placeholder="必填" onpaste="return false;"/>
											</div>
										</div>
									</div>
									
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save" type="submit">修改</button>&emsp;&emsp;
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