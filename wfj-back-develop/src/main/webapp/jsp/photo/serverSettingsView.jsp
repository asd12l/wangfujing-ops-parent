<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="${pageContext.request.contextPath}/assets/js/validation/bootstrapValidator.js"></script>
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
/* 	var url = __ctxPath + "/category/getAllCategory"; */
  	$(function(){
  		
  		initOrganizationOne();
		$('#theForm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			submitHandler : function(validator, form, submitButton) {
		  		$.ajax({
					type: "post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					dataType:"json",
					ajaxStart: function() {
				       	 $("#loading-container").attr("class","loading-container");
				       	 alert(__ctxPath + "/photo/saveFtp");
				        },
			        ajaxStop: function() {
			          //隐藏加载提示
			          setTimeout(function() {
			       	        $("#loading-container").addClass("loading-inactive");
			       	 },300);
			        },
			        url: __ctxPath + "/photo/saveFtp",
					data: $("#theForm").serialize(),
					success: function(response) {
						if(response.success==true){
		 	     	  		$("#warning2Body").text("保存成功!");
		 					$("#warning2").show();
		 				
		 	     	  		initOrganizationOne();
						}else if(response.data.errorMsg!=""){
							$("#warning2Body").text(response.data.errorMsg);
		 					$("#warning2").show();
						}
						return;
					},
					/* error: function() {
						$("#warning2Body").text("系统出错!");
	 					$("#warning2").show();
	 					
					} */
					error: function(XMLHttpRequest, textStatus) {		      
						var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
						if(sstatus != "sessionOut"){
							$("#warning2Body").text("系统出错!");
		 					$("#warning2").show();
						}
						if(sstatus=="sessionOut"){     
			            	 $("#warning3").css('display','block');     
			            }
					}
				});
			},
			fields : {
				ftp_address : {
					validators : {
						notEmpty : {
							message : 'IP地址不能为空'
						},
						regexp : {
							regexp : /^((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))$/,
							message : 'ip不符合规范'
						}
					}
				},
				ftp_name : {
					validators : {
						notEmpty : {
							message : '用户名不能为空'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9]{6,20}$/,
							message : '用户名必须是由6到20位的字母或数字组成'
						}
					}
				},
				ftp_pwd:{
					validators : {
						notEmpty : {
							message : '密码不能为空'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9]{6,20}$/,
							message : '密码必须是由6到20位的字母或数字组成'
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
		
  		$("#editButton").click(function(){
  			$("#title_id").html("配置服务器");
			
			$('#ftp_address').attr("disabled",false);
			$('#ftp_name').attr("disabled",false);
			$('#ftp_pwd').attr("disabled",false);
			
			$('#save1').hide();
			$('#save2').show();
			$('#editButton').hide();
			$('#closeButton').show();
			
  		});
  		$("#closeButton").click(function(){
  			initOrganizationOne();
  		});
	});
  	
  //初始化
	function initOrganizationOne() {
	  
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
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
			url: __ctxPath + "/photo/queryFtp",
			//data: $("#theForm").serialize(),
			success: function(response) {
				if(response.success==true){
					
					$("#title_id").html("服务器当前配置");
					var ftp_address=response.ftp_address;
					var ftp_name=response.ftp_name;
					var ftp_pwd = response.ftp_pwd;
					//IP 
					$("#ftp_address").val(ftp_address);
					//用户名
					$("#ftp_name").val(ftp_name);
					//密码
					$("#ftp_pwd").val(ftp_pwd);
					
					$('#ftp_address').attr("disabled",true);
					$('#ftp_name').attr("disabled",true);
					$('#ftp_pwd').attr("disabled",true);
					
					$('#save1').hide();
					$('#save2').hide();
					$('#editButton').show();
					$('#closeButton').hide();
				}else {
					
					$("#title_id").html("配置服务器");
					
					$('#ftp_address').attr("disabled",false);
					$('#ftp_name').attr("disabled",false);
					$('#ftp_pwd').attr("disabled",false);
					
					$('#save1').show();
					$('#save2').hide();
					$('#editButton').hide();
					$('#closeButton').hide();
					
				}
				return;
				
			},
			/* error: function() {
				$("#title_id").html("配置服务器");
				
				$('#ftp_address').attr("disabled",false);
				$('#ftp_name').attr("disabled",false);
				$('#ftp_pwd').attr("disabled",false);
				
				$('#save1').show();
				$('#save2').hide();
				$('#editButton').hide();
				$('#closeButton').hide();
			} */
			error: function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					$("#title_id").html("配置服务器");
					
					$('#ftp_address').attr("disabled",false);
					$('#ftp_name').attr("disabled",false);
					$('#ftp_pwd').attr("disabled",false);
					
					$('#save1').show();
					$('#save2').hide();
					$('#editButton').hide();
					$('#closeButton').hide();
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
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
								<span class="widget-caption" id="title_id">服务器设置</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">本地服务器IP地址：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">

												<input maxlength="20" type="text" class="form-control" id="ftp_address" name="ftp_address" placeholder="必填"  onpaste="return false;"/>

											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">用户名：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">

												<input maxlength="20" type="text" class="form-control" id="ftp_name" name="ftp_name" placeholder="必填"  onpaste="return false;"/>

											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">密码：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">

												<input maxlength="20" type="text" class="form-control" id="ftp_pwd" name="ftp_pwd" placeholder="必填"  />

											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">&nbsp;</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">

												<button  class="btn btn-success" style="width: 40%;display:none;" id="save1" type="submit" >确定</button>
												<button class="btn btn-success" style="width: 25%;display:none;" id="save2" type="submit" >确定</button>
												<input  class="btn btn-info" style="width: 40%;display:none;" id="editButton" type="button"  value="编辑" />&emsp;&emsp;
												<input class="btn btn-danger" style="width: 25%;display:none;" id="closeButton" type="button" value="取消" />

											</div>											
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