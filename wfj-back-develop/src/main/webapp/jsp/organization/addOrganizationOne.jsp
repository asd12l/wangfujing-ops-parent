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
  		var parentSid = $("#parentSid");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/organization/queryListOrganization?organizationType=0",
			dataType: "json",
			success: function(response) {
				var result = response;
				if(result.success == "true"){
					parentSid.html("<option value=''>请选择集团(必填)</option>");
					for ( var i = 0; i < result.list.length; i++) {
						var ele = result.list[i];
						var option;
						option = $("<option value='" + ele.sid + "'>" + ele.organizationName + "</option>");
						option.appendTo(parentSid);
					}
				}
				return;
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
				var parentSid = $("#parentSid").val();
				if(parentSid == ""){
		  			$("#warning2Body").text(buildErrorMessage("","请选择所属集团！"));
			        $("#warning2").show();
		  			return;
				}
				$("#groupSid").val(parentSid);

                LA.sysCode = '10';
                var sessionId = '<%=request.getSession().getId() %>';
                LA.log('organization.saveOrganizationOne', '添加大区：' + $("#theForm").serialize(), getCookieValue("username"),  sessionId);

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
							message : '大区名称不能为空'
						},
						regexp : {
							regexp : /^[-\u4E00-\u9FA5]{1,20}$/,
							message : '大区名称必须是由1到20位的中文或者"-"组成'
						}
					}
				},
				organizationCode:{
					validators : {
						notEmpty : {
							message : '大区编码不能为空'
						},
						regexp : {
							regexp : /^[1-9]{1}[0-9]{0,17}$/,
							message : '大区编码第一位不能为0且不超过18位的数字组成'
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
  			$("#pageBody").load(__ctxPath+"/jsp/organization/organizationOneView.jsp");
  		});
	});
  	
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/organization/organizationOneView.jsp");
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
								<span class="widget-caption">添加大区</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="userName" value=""/>
									<input type="hidden" name="createName" value=""/>
									<script type="text/javascript">
										$("input[name='userName']").val(getCookieValue("username"));
										$("input[name='createName']").val(getCookieValue("username"));
									</script>
									<input type="hidden" name="organizationType" value="1"/>
									<input type="hidden" name="groupSid" id="groupSid" value=""/>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="margin-left:12%;">所属上级：</label><!-- <font style="color: red;">*(必填)</font> -->
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 232px;">
												<select class="form-control" id="parentSid" name="parentSid">
													<option value="">请选择集团(必填)</option>
												</select>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="margin-left:12%;">大区编码：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 232px;">
												<input maxlength="20" type="text" class="form-control" id="organizationCode" name="organizationCode" placeholder="必填" onpaste="return false;"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="margin-left:12%;">大区名称：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 232px;">
												<input maxlength="20" type="text" class="form-control" id="organizationName" name="organizationName" placeholder="必填"/>
											</div>											
										</div>
									</div>
        							<!-- <div class="form-group">
										<label class="col-lg-3 control-label">机构类别：</label>
										<div class="col-lg-6">
											<select class="form-control" id="organizationType" name="organizationType">
												<option value="0">集团</option>
												<option value="1">大区</option>
												<option value="2">城市</option>
												<option value="3" selected="selected">门店</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
										</div>
									</div> -->
									
									<div class="form-group" style="display: none">
										<label class="col-lg-3 control-label">大区状态：</label>
										<div class="col-lg-6" style="width: 230px;">
											<select class="form-control" id="organizationStatus" name="organizationStatus" data-bv-field="country">
												<option value="0" selected="selected">可用</option>
												<option value="1">禁用</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
										</div>
									</div>
        
									<!-- <div class="form-group">
										<label class="col-lg-3 control-label">门店类型：</label>
										<div class="col-lg-6">
											<select class="form-control" id="storeType" name="storeType" data-bv-field="country">
												<option value="1" selected="selected">电商</option>
												<option value="2">北京</option>
												<option value="3">其他门店</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
										</div>
									</div>
        
									<div class="form-group">
										<label class="col-lg-3 control-label">集货地编码：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="shippingPoint" name="shippingPoint" placeholder="必填"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">门店所属城市在省市区字典中的编码：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="areaCode" name="areaCode" placeholder="必填"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">创始人：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="createName" name="createName" placeholder="必填"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">最后一次修改人：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="updateName" name="updateName" placeholder="必填"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">录入时间：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="createTime" name="createTime" placeholder="必填"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">更新时间：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="updateTime" name="updateTime" placeholder="必填"/>
										</div>
									</div> -->

         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save" type="submit" >保存</button>&emsp;&emsp;
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