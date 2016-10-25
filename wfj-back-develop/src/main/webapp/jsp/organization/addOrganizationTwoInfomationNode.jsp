<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var url = __ctxPath + "/category/getAllCategory";
  	$(function(){
  		$("#close").click(function(){ 
 			 $("#pageBody").load(__ctxPath+"/jsp/organization/organizationTwoView.jsp"); 
 			
 		});
  		
		var group = $("#group");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/organization/queryListOrganization",
			dataType: "json",
			 data: "organizationType=0", 
			success: function(response) {
				if(response.success == "true"){
					var result = response.list;
					group.html("<option value=''>请选择集团(必填)</option>");
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>" + ele.organizationName + "</option>");
						option.appendTo(group);
					}
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
		
		$("#group").change(classifyTwo);
	});
  	
  	$('#theForm').bootstrapValidator({
		message : 'This value is not valid',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		submitHandler : function(validator, form, submitButton) {
			var group = $("#group").val();
			if (group == "") {
	  			$("#warning2Body").text(buildErrorMessage("","请选择所属集团！"));
		        $("#warning2").show();
				return;
			}
			var parentSid = $("#area").val();
			if(parentSid == ""){
	  			$("#warning2Body").text(buildErrorMessage("","请选择所属大区！"));
		        $("#warning2").show();
				return;
			}

            LA.sysCode = '10';
            var sessionId = '<%=request.getSession().getId() %>';
            LA.log('organization.saveOrganizationOne', '添加城市：' + $("#theForm").serialize(), getCookieValue("username"),  sessionId);

			var url = __ctxPath + "/organization/saveOrganizationOne";
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
						$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
	 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
					}else if(response.data.errorMsg!=""){
						$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
				        $("#warning2").show();
					}
					return;
				},
				error: function() {
	 	  				$("#warning2Body").text(buildErrorMessage("","系统出错!"));
				        $("#warning2").show();
				}
			});
	  		
		},
		fields : {
			organizationName : {
				validators : {
					notEmpty : {
						message : '城市名称不能为空'
					},
					regexp : {
						regexp : /^[-\u4E00-\u9FA5]{1,20}$/,
						message : '城市名称必须是由1到20位的中文或者"-"组成'
					}
				}
			},
			organizationCode:{
				validators : {
					notEmpty : {
						message : '城市编码不能为空'
					},
					regexp : {
						regexp : /^[1-9]{1}[0-9]{0,17}$/,
						message : '城市编码第一位不能为0且不超过18位的数字组成'
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
	//二级分类
	function classifyTwo(){
		var sid = $("#group").val();
  		var area = $("#area");
		area.html("<option value=''>请选择大区(必填)</option>");
  		if(sid == ""){
  			return;
  		}
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/organization/queryListOrganization",
			dataType: "json",
			data: "parentSid="+sid,
			success: function(response) {
				if(response.success != "false"){
					var result = response.list;
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>" + ele.organizationName + "</option>");
						option.appendTo(area);
					}
				} else{
					$("#warning2Body").text("当前集团下没有大区信息!");
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
	}
	
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
								<span class="widget-caption">添加城市</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
								<input type="hidden" name="organizationType" id="organizationType" value="2"/>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="margin-left:5%;">所属上级：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<div class="col-lg-6 col-sm-6 col-xs-6" style="padding-left:0px;padding-right:0px;">											
													<select class="form-control" name="groupSid" id="group" data-bv-field="country">
														<option value="">请选择集团(必填)</option>
													</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
												</div>
												<div class="col-lg-6 col-sm-6 col-xs-6" style="padding-left:0px;padding-right:0px;">
													<select class="form-control" id="area" name="parentSid" data-bv-field="country">
														<option value="">请选择大区(必填)</option>
													</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
												</div>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="margin-left:5%;">城市编码：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 50%;">
												<input maxlength="20" type="text" class="form-control" id="organizationCode" name="organizationCode" placeholder="必填" onpaste="return false;"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="margin-left:5%;">城市名称：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 50%;">
												<input maxlength="20" type="text" class="form-control" id="organizationName" name="organizationName" placeholder="必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group" style="display:none">
										<label class="col-lg-3 control-label" style="margin-left:5%;">是否可用：</label>
										<div class="col-lg-6" style="width: 230px;">
											<select class="form-control" id="organizationStatus" name="organizationStatus" data-bv-field="country">
												<option value="0" selected="selected" >启用</option>
												<option value="1">禁用</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
										</div>
									</div>
									
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;"
												id="save" type="submit" >保存</button>&emsp;&emsp;
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