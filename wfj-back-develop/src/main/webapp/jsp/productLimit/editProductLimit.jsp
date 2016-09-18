<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% request.setAttribute("ctx", request.getContextPath());%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	
	$(function() {
		
		$("#sid").val(sid_);
		$("#brandSid").val(brandSid_);
		$("#brandName").val(brandName_);
		$("#categorySid").val(categorySid_);
		$("#categoryName").val(categoryName_);
		$("#limitValue").val(limitValue_);
		$("#status").val(status_);
		
		$('#theForm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			submitHandler : function(validator, form, submitButton) {
				// Do nothing
                LA.sysCode = '16';
                var sessionId = '<%=request.getSession().getId() %>';
                LA.log('productlimit.modifyProductLimit', '修改库存阀值：' + $("#theForm").serialize(), getCookieValue("username"),  sessionId);

				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr("class","loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container").addClass("loading-inactive");
						}, 300);
					},
					url : __ctxPath + "/productlimit/modifyProductLimit",
					data : $("#theForm").serialize(),
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
							$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
						} else if (response.data.errorMsg != "") {
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
							$("#warning2").show();
						}
						return;
					},
					error : function(XMLHttpRequest, textStatus) {
						var sstatus = XMLHttpRequest
								.getResponseHeader("sessionStatus");
						if (sstatus != "sessionOut") {
							$("#warning2Body").text(buildErrorMessage("","系统出错！"));
							$("#warning2").show();
						}
						if (sstatus == "sessionOut") {
							$("#warning3").css('display', 'block');
						}
					}
				});
		},
		fields : {
			limitValue : {
				validators : {
					notEmpty : {
						message : '阀值不能为空'
					},
					regexp : {
						regexp : /^[1-9]{1}[0-9]{1,19}$/,
						message : '阀值必须是大于1的20位的数字'
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

	$("#close").click(
		function() {
			$("#pageBody").load(__ctxPath + "/jsp/productLimit/productLimitView.jsp");
		});
	});

	function successBtn() {
		$("#modal-success").attr({"style" : "display:none;","aria-hidden" : "true","class" : "modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/productLimit/productLimitView.jsp");
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
								<span class="widget-caption">修改库存阀值</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="optName" value="" />
									<script type="text/javascript">
										$("input[name='optName']").val(getCookieValue("username"));
									</script>
									<input type="hidden" name="sid" id="sid" value=""/>
									<input type="hidden" name="brandSid" id="brandSid" value=""/>
									<input type="hidden" name="categorySid" id="categorySid" value=""/>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="margin-left:17%">品牌名称：</label>
										<div class="col-lg-6" style="width:230px">
											<input type="text" class="form-control" id="brandName" readonly="readonly" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label" style="margin-left:17%">分类名称：</label>
										<div class="col-lg-6" style="width:230px">
											<input type="text" class="form-control" id="categoryName" readonly="readonly" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label" style="margin-left:17%">阀值：</label>
										<div class="col-lg-6" style="width:230px">
											<input type="text" class="form-control" name="limitValue" id="limitValue" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label" style="margin-left:17%">状态：</label>
										<div class="col-lg-6" style="width:230px">
											<select name="status" id="status" class="form-control">
												<option value="1">禁用</option>
												<option selected="selected" value="0">启用</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save" type="submit">保存</button>&emsp;&emsp; 
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
</body>
</html>