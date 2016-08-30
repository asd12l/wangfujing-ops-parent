<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("ctx", request.getContextPath());%>
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
  		
  		//加载集团
		var group = $("#group");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/organization/queryListOrganization",
			dataType: "json",
			data: "organizationType=0", 
			success: function(response) {
				var result = response.list;
				group.html("<option value=''>请选择集团</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.sid + "'>" + ele.organizationName + "</option>");
					option.appendTo(group);
					
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
			var group = $("#group").val();
			if (group == "") {
         		$("#warning2Body").text(buildErrorMessage("","请选择所属集团！"));
		        $("#warning2").show();
				return;
			}
			var area = $("#area").val();
			if (area == "") {
				$("#warning2Body").text(buildErrorMessage("","请选择所属大区！"));
		        $("#warning2").show();
				return;
			}
			var city = $("#city").val();
			if (city == "") {
				$("#warning2Body").text(buildErrorMessage("","请选择所属城市！"));
		        $("#warning2").show();
				return;
			}
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
  	
  	//加载大区
	function classifyTwo(){
		var sid = $("#group").val();
  		var area = $("#area");
  		var city = $("#city");
  		area.html("<option value=''>请选择大区</option>");
  		city.html("<option value=''>请选择城市</option>");
  		//当点击的是请选择集团的时候，不让查询
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
			    if(response.success!="false"){
					var result = response.list;
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>" + ele.organizationName + "</option>");
						option.appendTo(area);
					}
			    }else{
			    	$("#warning2Body").text(buildErrorMessage("","当前集团下没有大区信息!"));
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
	//加载城市
	function classiyThree(){
	    var sid = $("#area").val();
  		var city = $("#city");
  		city.html("<option value=''>请选择城市</option>");
  		////当点击的是请选择大区的时候，不让查询
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
			    if(response.success!="false"){
					var result = response.list;
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>" + ele.organizationName + "</option>");
						option.appendTo(city);
					}
			    }else{
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
	}
  	
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
								<span class="widget-caption">添加门店</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="organizationType" id="organizationType" value="3"/>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">所属上级：</label>
											<div class="col-lg-9 col-sm-9 col-xs-9">
												<div class="col-lg-4 col-sm-4 col-xs-4" style="padding-left:0px;padding-right:0px;">											
													<select class="form-control" name="groupSid" onchange="classifyTwo();" style="padding-right:0;" id="group" data-bv-field="country">
												<option value="">请选择集团</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
												</div>
												<div class="col-lg-4 col-sm-4 col-xs-4" style="padding-left:0px;padding-right:0px;">
													<select class="form-control" onchange="classiyThree();" style="padding-right:0;" id="area" data-bv-field="country">
												<option value="">请选择大区</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
												</div>
												<div class="col-lg-4 col-sm-4 col-xs-4" style="padding-left:0px;padding-right:0px;">
													<select class="form-control" style="padding-right:0;" id="city" name="parentSid" data-bv-field="country">
												<option value="">请选择城市</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
												</div>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">门店编码：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<input maxlength="20" type="text" class="form-control" id="organizationCode" name="organizationCode" placeholder="必填" onpaste="return false;"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">门店名称：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<input  maxlength="20" type="text" class="form-control" id="organizationName" name="organizationName" placeholder="必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group" style="display: none">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">是否可用：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width: 75%;">
												<select class="form-control" id="organizationStatus" name="organizationStatus" data-bv-field="country">
												<option value="1" disabled="disabled">禁用</option>
												<option value="0" selected="selected">启用</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label" style="width: 18%;">门店类型：</label>
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