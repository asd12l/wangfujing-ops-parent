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
  		
		var shopSid = $("#shopSid");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/organization/queryListOrganization",
			dataType: "json",
			 data: "organizationType=3", 
			success: function(response) {
				if(response.success == "true"){
					var result = response.list;
					shopSid.html("<option value=''>请选择门店(必填)</option>");
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>" + ele.organizationName + "</option>");
						option.appendTo(shopSid);
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
	});
  		
	$("#close").click(function(){ 
		 $("#pageBody").load(__ctxPath+"/jsp/floor/floorView.jsp"); 
		
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
  				var shopSid = $("#shopSid").val();
	  			if (shopSid == "") {
	  				$("#warning2Body").text(buildErrorMessage("","请选择门店！"));
 	  				$("#warning2").show();
	  				return;
				}

                LA.sysCode = '10';
                var sessionId = '<%=request.getSession().getId() %>';
                LA.log('floor.saveFloor', '添加楼层：' + $("#theForm").serialize(), getCookieValue("username"),  sessionId);

  				var url = __ctxPath + "/floor/saveFloor";
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
  				floorName : {
  					validators : {
  						notEmpty : {
  							message : '楼层名称不能为空'
  						}
  					}
  				},
  				floorCode:{
  					validators : {
  						notEmpty : {
  							message : '楼层编码不能为空'
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
  			
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/floor/floorView.jsp");
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
								<span class="widget-caption">添加楼层</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:12%">所属门店：</label>
											<div class="col-lg-6" style="width:232px">
												<select class="form-control" id="shopSid" name="shopSid" data-bv-field="country">
													<option value="">请选择门店(必填)</option>
												</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
											</div>
										</div>											
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:12%">楼层编码：</label>
											<div class="col-lg-6" style="width:232px">
												<input maxlength="20" type="text" class="form-control" id="floorCode" name="floorCode" placeholder="必填" onpaste="return false;"/>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:12%">楼层名称：</label>
											<div class="col-lg-6" style="width:232px">
												<input maxlength="20" type="text" class="form-control" id="floorName" name="floorName" placeholder="必填" onpaste="return false;"/>
											</div>											
										</div>
									</div>
									<div class="form-group" style="display: none">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:12%">楼层状态：</label>
											<div class="col-lg-6" style="width:232px">
												<select class="form-control" id="floorStatus" name="floorStatus" data-bv-field="country">
													<option value="0" selected="selected">启用</option>
													<option value="1">禁用</option>
												</select>
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