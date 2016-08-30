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
		/* $("#organizationName").val(organizationName_);
		$("#organizationStatus").val(organizationStatus_);
		$("#storeType").val(storeType_); */
		
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/storeInfo/queryListStoreInfo",
			data : {
				"organizationCode" : organizationCode_,
				"groupSid" : groupSid_ 
			},
			dataType: "json",
			success: function(response) {
				if(response.success){
					var result = (response.list)[0];
					$("#organizationName").val(result.organizationName);
					$("#organizationStatus").val(result.organizationStatus);
					$("#storeType").val(result.storeType);

                    if(typeof result.registeredAddress != "object") {
                        $("#registeredAddress").val(result.registeredAddress);
                    }
                    if(typeof result.postCode != "object") {
                        $("#postCode").val(result.postCode);
                    }
                    if(typeof result.legalRepresentative != "object") {
                        $("#legalRepresentative").val(result.legalRepresentative);
                    }
                    if(typeof result.agent != "object") {
                        $("#agent").val(result.agent);
                    }
                    if(typeof result.taxRegistrationNumber != "object") {
                        $("#taxRegistrationNumber").val(result.taxRegistrationNumber);
                    }
                    if(typeof result.bank != "object") {
                        $("#bank").val(result.bank);
                    }
                    if(typeof result.bankAccount != "object") {
                        $("#bankAccount").val(result.bankAccount);
                    }
                    if(typeof result.telephoneNumber != "object") {
                        $("#telephoneNumber").val(result.telephoneNumber);
                    }
                    if(typeof result.faxNumber != "object") {
                        $("#faxNumber").val(result.faxNumber);
                    }
				}
				return;
			}
		});
		
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
			},
			registeredAddress:{
				validators : {
					notEmpty : {
						message : '注册地址不能为空'
					}
				}
			},
			postCode:{
				validators : {
					notEmpty : {
						message : '邮编不能为空'
					},
					regexp : {
						regexp : /^[1-9]\d{5}$/,
						message : '邮政编码是1-9开头的6位数字'
					}
				}
			},
			legalRepresentative:{
				validators : {
					notEmpty : {
						message : '法定代表人不能为空'
					},
					regexp : {
						regexp : /^[A-Za-z\.\s\u4E00-\u9FA5]{1,20}$/,
						message : '法定代理人必须是中文或英文或点或空格且不超过20位'
					}
				}
			},
			agent:{
				validators : {
					notEmpty : {
						message : '委托代理人不能为空'
					},
					regexp : {
						regexp : /^[A-Za-z\.\s\u4E00-\u9FA5]{1,20}$/,
						message : '委托代理人必须是中文或英文或点或空格且不超过20位'
					}
				}
			},
			taxRegistrationNumber:{
				validators : {
					notEmpty : {
						message : '税务登记号不能为空'
					},
					regexp : {
						regexp : /^[A-Za-z0-9]{1,20}$/,
						message : '税务登记号必须是数字或英文且不超过20位'
					}
				}
			},
			bank:{
				validators : {
					notEmpty : {
						message : '开户行不能为空'
					}
				}
			},
			bankAccount:{
				validators : {
					notEmpty : {
						message : '开户行账号不能为空'
					},
					regexp : {
						regexp : /^[A-Za-z0-9]{1,30}$/,
						message : '开户行账号必须是数字或英文且不超过30位'
					}
				}
			},
			telephoneNumber:{
				validators : {
					notEmpty : {
						message : '电话不能为空'
					},
					regexp : {
						regexp : /^\d{3}-\d{8}|\d{4}-\d{7}$/,
						message : '电话号码格式不正确'
					}
				}
			},
			faxNumber:{
				validators : {
					notEmpty : {
						message : '传真不能为空'
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
											<label class="col-lg-3 control-label" style="width: 18%;">所属上级：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<select class="form-control" id="parentSid" name="parentSid"></select>
											</div>
										</div>
									</div>
									
        							<div class="form-group">
        								<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="width: 18%;">门店编码：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<input maxlength="20" type="text" class="form-control"  id="organizationCode" name="organizationCode" readonly="true"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="width: 18%;">门店名称：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<input maxlength="20" type="text" class="form-control" id="organizationName" name="organizationName" onpaste="return false;"/>
											</div>
										</div>
									</div>
        							
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="width: 18%;">门店类型：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
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
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">注册地址：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<input  maxlength="20" type="text" class="form-control" id="registeredAddress" name="registeredAddress" placeholder="必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">邮编：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<input  maxlength="20" type="text" class="form-control" id="postCode" name="postCode" placeholder="必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">法定代表人：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 28%;">
												<input  maxlength="20" type="text" class="form-control" id="legalRepresentative" name="legalRepresentative" placeholder="必填"/>
											</div>
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 19%;">委托代理人：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 28%;">
												<input  maxlength="20" type="text" class="form-control" id="agent" name="agent" placeholder="必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">税务登记号：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<input  maxlength="20" type="text" class="form-control" id="taxRegistrationNumber" name="taxRegistrationNumber" placeholder="必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">开户行：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<input  maxlength="20" type="text" class="form-control" id="bank" name="bank" placeholder="必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">开户行账号：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<input  maxlength="20" type="text" class="form-control" id="bankAccount" name="bankAccount" placeholder="必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">电话：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 28%;">
												<input  maxlength="20" type="text" class="form-control" id="telephoneNumber" name="telephoneNumber" placeholder="必填"/>
											</div>
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 19%;">传真：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 28%;">
												<input  maxlength="20" type="text" class="form-control" id="faxNumber" name="faxNumber" placeholder="必填"/>
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