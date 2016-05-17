<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
__ctxPath = "${pageContext.request.contextPath}";
var url = __ctxPath + "/category/getAllCategory";
	$(function(){
		$("#sid").val(sid_); 
		$("#parentSid").val(parentSid_);
		$("#groupSid").val(groupSid_);
		$("#organizationCode").val(organizationCode_);
		$("#organizationName").val(organizationName_);
		$("#organizationStatus").val(organizationStatus_);
		$("#storeType").val(storeType_);
		
		var parentSid = $("#parentSid");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/organization/queryListOrganization?organizationType=2",
			dataType: "json",
			success: function(response) {
				var result = response;
				/* parentSid.html("<option value='-1'>请选择</option>"); */
				for ( var i = 0; i < result.list.length; i++) {
					var ele = result.list[i];
					var option;
					if(parentSid_ == ele.sid){
						option = $("<option selected='selected' groupSid='" + ele.groupSid + "' value='" + ele.sid + "'>"
								+ ele.organizationName + "</option>");
					}else{
						option = $("<option groupSid='" + ele.groupSid + "' value='" + ele.sid + "'>"
								+ ele.organizationName + "</option>");
					}
					option.appendTo(parentSid);
				}
				return;
			}
		});
		
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/organization/organizationThreeView.jsp");
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
			// Do nothing
			var groupSid = $("#parentSid option:selected").attr("groupSid");
			$("#groupSid").val(groupSid);
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
				        $("#warning2").show();
				        }
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
						message : '门店名称不能为空'
					},
					regexp : {
						regexp : /^[-\u4E00-\u9FA5]{1,20}$/,
						message : '门店名称必须是由1到20位的中文或"-"组成'
					}
				}
			},
			organizationCode:{
				validators : {
					notEmpty : {
						message : '门店编码不能为空'
					},
					regexp : {
						regexp : /^[1-9]{1}[0-9]{0,17}$/,
						message : '门店编码第一位不能为0且不超过18位的数字组成'
					}
				}
			}
		}

	}).find('button[data-toggle]').on('click',function() {
		var $target = $($(this).attr('data-toggle'));
		$target.toggle();
		if (!$target.is(':visible')) {
			$('#theForm').data('bootstrapValidator')
					.disableSubmitButtons(false);
		}
	});
	
	function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	$("#pageBody").load(__ctxPath+"/jsp/organization/organizationThreeView.jsp");
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
								<span class="widget-caption">修改门店</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="sid" id="sid"/>
									<input type="hidden" name="groupSid" id="groupSid"/>
									<input type="hidden" name="organizationType" id="organizationType" value="3"/>
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left: 12%;">所属上级：</label>
											<div class="col-lg-6" style="width: 250px;">
												<select class="form-control" id="parentSid" name="parentSid"></select>
											</div>
										</div>
									</div>
									
        							<div class="form-group">
        								<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left: 12%;">门店编码：</label>
											<div class="col-lg-6" style="width:250px">
												<input maxlength="20" type="text" class="form-control"  id="organizationCode" name="organizationCode" readonly="true"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left: 12%;">门店名称：</label>
											<div class="col-lg-6" style="width:250px">
												<input maxlength="20" type="text" class="form-control" id="organizationName" name="organizationName" onpaste="return false;"/>
											</div>
										</div>
									</div>
        							
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left: 12%;">门店类型：</label>
											<div class="col-lg-6" style="width: 250px;">
												<select class="form-control" id="storeType" name="storeType" data-bv-field="country">
													<option value="0" selected="selected">北京</option>
													<option value="1" >外埠</option>
													<option value="2" >电商</option>
													<option value="4" >集货仓</option>
													<option value="5" >门店物流室</option>
													<option value="6" >拍照室</option>
												</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
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