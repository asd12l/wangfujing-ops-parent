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
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
__ctxPath = "${pageContext.request.contextPath}";
var url = __ctxPath + "/category/getAllCategory";
	$(function(){
		$("#sid").val(sid_); 
		$("#parentSid").val(parentSid_);
		$("#organizationCode").val(organizationCode_);
		$("#organizationName").val(organizationName_);
		$("#organizationStatus").val(organizationStatus_);
		 
		var parentSid = $("#parentSid");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/organization/queryListOrganization?organizationType=1",
			dataType: "json",
			success: function(response) {
				var result = response;
				parentSid.html("<option value='-1'>请选择</option>");
				for ( var i = 0; i < result.list.length; i++) {
					var ele = result.list[i];
					var option;
					if(parentSid_ == ele.sid){
						option = $("<option selected='selected' value='" + ele.sid + "'>"
								+ ele.organizationName + "</option>");
					}else{
						option = $("<option value='" + ele.sid + "'>"
								+ ele.organizationName + "</option>");
					}
					option.appendTo(parentSid);
				}
				return;
			}
		});
		
		$("#save").click(function(){
			saveFrom();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/organization/organizationTwoView.jsp");
		});
});
	function saveFrom(){
		if($("#organizationName").val() == "" || $("#organizationCode").val() == ""){
  			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>集团必填缺失!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
  		}else{
		$.ajax({
		type: "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url: __ctxPath + "/organization/updateOrganizationZero",
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
		data: $("#theForm").serialize(),
		success: function(response) {
			if(response.success=="true"){
				$("#modal-body-success").html("<div class='alert alert-success fade in'><i class='fa-fw fa fa-times'></i><strong>修改成功，返回列表页!</strong></div>");
	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			}else if(response.msg!=""){
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.msg+"</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
			return;
		},
		/* error: function() {
			$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
	  				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
		} */
		error: function(XMLHttpRequest, textStatus) {		      
			var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
			if(sstatus != "sessionOut"){
				$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
	  				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
			}
			if(sstatus=="sessionOut"){     
            	 $("#warning3").css('display','block');     
             }
		}
	});
	}
	}
	
	$('#theForm').bootstrapValidator({
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
			shopSid : {
				validators : {
					notEmpty : {
						message : '门店SID'
					}
				}
			},
			code : {
				validators : {
					notEmpty : {
						message : '付款方式编码'
					}
				}
			},
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
	
	function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	$("#pageBody").load(__ctxPath+"/jsp/organization/organizationTwoView.jsp");
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
								<span class="widget-caption">修改门店支付方式</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="sid" id="sid"/>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">门店SID：</label>
										<div class="col-lg-6">
											<select class="form-control" id="shopSid" name="shopSid"></select>
										</div>
									</div>
									
        							<div class="form-group">
										<label class="col-lg-3 control-label">付款方式编码：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"  id="code" name="code"  readonly="true"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">城市名称：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="organizationName" name="organizationName"/>
										</div>
									</div>
        							
									<div class="col-lg-6">
											<select class="form-control" id="organizationStatus" name="organizationStatus" data-bv-field="country">
												<option value="1">无效</option>
												<option value="0" selected="selected">有效</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
											
									</div>
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="修改" />&emsp;&emsp;
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