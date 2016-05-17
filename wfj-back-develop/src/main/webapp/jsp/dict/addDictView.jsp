<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<title>数据字典信息</title>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function() {

		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/dataDict/queryDataDictList",
			dataType : "json",
			data : "pid=0",
			success : function(response) {
				var result = response.list;
				var pid_select = $("#pid_select");
				/* pid_select.html("<option value='0'>请选择</option>"); */
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					if (ele.status == 0) {
						var option = $("<option value='" + ele.sid + "'>" + ele.name + "</option>");
						option.appendTo(pid_select);
					}
				}
				return;
			},
			error : function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					$("#warning2Body").text("系统错误!");
					$("#warning2").show();
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
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
					url : __ctxPath + "/dataDict/addDataDict",
					data : $("#theForm").serialize(),
					success : function(response) {
						if (response.success == 'true') {
							$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
							$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
						} else if (response.data.errorMsg != "") {
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
							$("#warning2").show();
						}
					}
				});
			},
			fields : {
				name : {
					validators : {
						notEmpty : {
							message : '字典名称不能为空'
						},
						stringLength : {
							max : 20,
							message : "最多只能输入20个字符"
						}
					}
				},
				code : {
					validators : {
						notEmpty : {
							message : '字典编码不能为空'
						},
						regexp : {
							regexp : /^[A-Za-z0-9]{1,20}$/,
							message : "编码只能填1到20位的数字或者字母"
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

		$("#close").click(function() {
			pid_ = $("#pid_select").val();
			$("#pageBody").load(__ctxPath + "/jsp/dict/dictView.jsp");
		});
	});
		
	function successBtn() {
		pid_ = $("#pid_select").val();
		$("#modal-success").attr({"style" : "display:none;","aria-hidden" : "true","class" : "modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/dict/dictView.jsp");
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
								<span class="widget-caption">添加数据字典</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" name="userName" value="" />
									<script type="text/javascript">$("input[name='userName']").val(getCookieValue("username"));</script>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="margin-left:13%">字典类型：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width:230px;">
												<select class="form-control" id="pid_select" name="pid"></select>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="margin-left:13%">字典编码：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width:230px;">
												<input type="text" class="form-control" id="code" name="code"
												placeholder="必填" onpaste="return false" />
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="margin-left:13%">字典名称：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width:230px;">
												<input type="text" class="form-control" id="name" name="name"
												placeholder="必填" onpaste="return false" />
											</div>											
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
	<script>
		
	</script>
</body>
</html>