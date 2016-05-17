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
		$("#name").val(name_);
		$("#payCode").val(payCode_);
		$("#bankBIN").val(bankBIN_);
		$("#remark").val(remark_);
		if (isAllowInvoice_ == "Y") {
			$("#isAllowInvoiceY").attr("checked","checked");
		}
		if (isAllowInvoice_ == "N") {
			$("#isAllowInvoiceN").attr("checked","checked");
		}
		
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/PaymentType/PaymentTypeView.jsp");
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
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath + "/payment/updatePaymentType",
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
					if(response.success == "true"){
						$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>修改成功，返回列表页!</strong></div>");
			     	  	$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
					}else if(response.data.errorMsg != ""){
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.data.errorMsg+"</strong></div>");
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
		},
		fields : {
			name : {
				validators : {
					notEmpty : {
						message : '支付方式名称不能为空'
					},
					regexp : {
						regexp : /^[A-Za-z0-9\u4E00-\u9FA5]{1,20}$/,
						message : '支付方式名称必须由1到20位的数字、字母或者中文组成'
					}
				}
			},
			payCode:{
				validators : {
					notEmpty : {
						message : '支付方式编码不能为空'
					},
					regexp : {
                    	regexp : /^[0-9]{1,20}$/,
                    	message : '支付方式编码必须由1到20位的数字组成'
                    }
				}
			},
			remark:{
				validators: {
					stringLength :{
						max : 200,
						message : "备注信息不能超过200字符！"
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
					$('#theForm').data('bootstrapValidator').disableSubmitButtons(false);
				}
			});
	
	function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	$("#pageBody").load(__ctxPath+"/jsp/PaymentType/PaymentTypeView.jsp");
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
								<span class="widget-caption">修改支付方式</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="sid" id="sid"/>
        							<div class="form-group has-feedback">
        								<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">付款方式名称：</label>
											<div class="col-lg-6" style="width:50%;">
												<input type="text" placeholder="必填" name="name" id="name" class="form-control" data-bv-field="name" onpaste="return false"><i style="display: none;" class="form-control-feedback" data-bv-field="name"></i>
											</div>
										</div>
									</div>
									
        							<div class="form-group has-feedback">
        								<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">付款方式编码：</label>
											<div class="col-lg-6" style="width:50%;">
												<input type="text" placeholder="必填" name="payCode" id="payCode" class="form-control" data-bv-field="payCode" readonly="readonly"><i style="display: none;" class="form-control-feedback" data-bv-field="payCode"></i>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">银行标识：</label>
											<div class="col-lg-6" style="width:50%;">
												<input type="text" class="form-control" id="bankBIN" name="bankBIN" placeholder="非必填" onpaste="return false"/>
											</div>
										</div>
									</div>
								
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">能否开发票：</label>
											<div class="col-lg-3" style="width:50%">
												<div class="radio" style="margin-left:17%">
													<label style="width:45%"> 
														<input class="basic" type="radio" name="isAllowInvoice" checked="checked" value="Y" id="isAllowInvoiceY"> 
														<span class="text">是</span>
													</label> 
													<label style="width:40%"> 
														<input class="basic" type="radio" name="isAllowInvoice" value="N" id="isAllowInvoiceN"> 
														<span class="text">否</span>
													</label>
												</div>
												<div style="display: none;" class="radio">
													<label> 
														<input type="radio" name="isAllowInvoice" class="inverted"> 
														<span class="text"></span>
													</label>
												</div>
											</div>
										</div>
									</div>
								
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">备注：</label>
											<div class="col-lg-6">
											 <textarea class="form-control" id="remark" name="remark" cols="5" rows="5" style="resize:none"></textarea>
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