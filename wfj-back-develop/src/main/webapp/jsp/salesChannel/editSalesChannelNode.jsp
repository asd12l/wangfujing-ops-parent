<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("ctx", request.getContextPath());
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function() {

		$("#sid").val(sid_);
		$("#channelCode").val(channelCode_);
		$("#channelName").val(channelName_);
		$("#status").val(status_);

		/* $("#save").click(function() {
			saveFrom();
		}); */
		$("#close")
				.click(
						function() {
							$("#pageBody")
									.load(
											__ctxPath
													+ "/jsp/salesChannel/salesChannelNode.jsp");
						});
		$('#theForm').bootstrapValidator();
	});
	//保存数据
	/* function saveFrom() {
		
	} */
	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(
				__ctxPath + "/jsp/salesChannel/salesChannelNode.jsp");
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
            LA.sysCode = '10';
            var sessionId = '<%=request.getSession().getId() %>';
            LA.log('channel.modifyChannel', '修改销售渠道：' + $("#theForm").serialize(), getCookieValue("username"),  sessionId);

			var url = __ctxPath + "/channelDisplay/modifyChannel";
			$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : url,
					dataType : "json",
					data : $("#theForm").serialize(),
					success : function(response) {
						if (response.success == 'true') {
							$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>修改成功，返回列表页!</strong></div>");
							$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
						} else if(response.data.errorMsg != "") {
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
			channelCode : {
				validators : {
					notEmpty : {
						message : '销售渠道编码不能为空'
					},
					regexp : {
						regexp : /^[0-9A-Za-z]{1,20}$/,
						message : '编码只能是1到20位的数字'
					}
				}
			},
			channelName : {
				validators : {
					notEmpty : {
						message : '销售渠道名称不能为空'
					},
					regexp : {
						regexp : /^[0-9A-Za-z\u4E00-\u9FA5]{1,20}$/,
						message : '名称只能是1到20位的数字、字母、中文'
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
								<span class="widget-caption">修改销售渠道</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" id="sid" name="sid" value="${sid }" /> <input
										type="hidden" name="un" value="${json.record.optUser }" />

									<div class="form-group">
										<label class="col-lg-3 control-label" style="margin-left:18%">销售渠道编码：</label>
										<div class="col-lg-6" style="width:233px">
											<input type="text" class="form-control" id="channelCode"
												name="channelCode" value="${json.record.channelCode }"
												placeholder="必填" data-bv-notempty="true" readonly="readonly"
												data-bv-notempty-message="销售渠道编码不能为空!" />
										</div>
									</div>

									<div class="form-group">
										<label class="col-lg-3 control-label" style="margin-left:18%">销售渠道名称：</label>
										<div class="col-lg-6" style="width:233px">
											<input type="text" class="form-control" id="channelName"
												name="channelName" value="${json.record.channelName }"
												placeholder="必填" data-bv-notempty="true" onpaste="return false"
												data-bv-notempty-message="销售渠道名称不能为空!" />
										</div>
									</div>

									<div class="form-group" style="display:none">
										<label class="col-lg-3 control-label" style="margin-left:18%">销售渠道状态：</label>
										<div class="col-lg-6">
											<select class="form-control" id="isLeaf1" name="status"
												data-bv-field="country">
												<option value="0" selected="selected">启用</option>
												<option value="1">禁用</option>
											</select><i class="form-control-feedback" data-bv-field="country"
												style="display: none;"></i>
										</div>
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save"
												type="submit">保存  </button>  &emsp;&emsp; <input
												class="btn btn-danger" style="width: 25%;" id="close"
												type="button" value="取消" />
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