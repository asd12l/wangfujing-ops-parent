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
	$(function(){
		$("#sid").val(sid_); 
		$("#parentId").val(parentId_);
		$("#regionCode").val(regionCode_);
		$("#regionInnerCode").val(regionInnerCode_);
		$("#regionName").val(regionName_);
		$("#regionNameEn").val(regionNameEn_);
		$("#regionShortnameEn").val(regionShortnameEn_);
		$("#regionLevel").val(regionLevel_);
		
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/region/queryListRegion",
			data:{"sid": parentId_},
			dataType: "json",
			success: function(response) {
				var parentId = $("#parentId");
				var result = response;
				for ( var i = 0; i < result.list.length; i++) {
					var ele = result.list[i];
					var option;
					if(parentId_ == ele.sid){
						option = $("<option selected='selected' value='" + ele.sid + "'>"
								+ ele.regionName + "</option>");
					}else{
						option = $("<option value='" + ele.sid + "'>"
								+ ele.regionName + "</option>");
					}
					option.appendTo(parentId);
				}
				return;
			}
		}); 
		
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/region/regionView.jsp");
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
            LA.sysCode = '16';
            var sessionId = '<%=request.getSession().getId() %>';
            LA.log('region.modifyRegion', '修改行政区域：' + $("#theForm").serialize(), getCookieValue("username"),  sessionId);

            $.ajax({
                type: "post",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                url: __ctxPath + "/region/modifyRegion",
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
			regionName : {
				validators : {
					notEmpty : {
						message : '行政区域名称不能为空'
					},
					regexp : {
						regexp : /^[A-Za-z0-9\u4e00-\u9fa5]{1,20}$/,
						message : '行政区域名称只能由1到20位的数字、字母或者中文组成'
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
        $("#pageBody").load(__ctxPath+"/jsp/region/regionView.jsp");
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
								<span class="widget-caption">修改行政区域</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="sid" id="sid"/>
									
									<div class="form-group" style="display:none">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%">所属上级：</label>
											<div class="col-lg-6">
												<select class="form-control" id="parentId" name="parentId">
													<option value="">请选择</option>
												</select>
											</div>
										</div>
									</div>
									
									<%--<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%">邮编：</label>
											<div class="col-lg-6" style="width:230px;">
												<input maxlength="20" type="text" class="form-control"  id="regionCode" name="regionCode" readonly="true" onpaste="return false"/>
											</div>
										</div>
									</div>--%>
									
        							<div class="form-group">
        								<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 col-md-3 control-label" style="margin-left:18%">编码：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6" style="width:230px;">
												<input maxlength="20" type="text" class="form-control" id="regionInnerCode" name="regionInnerCode" readonly="true" onpaste="return false"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%">名称：</label>
											<div class="col-lg-6" style="width:230px;">
												<input maxlength="20" type="text" class="form-control" id="regionName" name="regionName" onpaste="return false"/>
											</div>
										</div>
									</div>
									
									<div class="form-group" style="display:none">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%">等级：</label>
											<div class="col-lg-6">
												<select class="form-control" id="regionLevel" name="regionLevel" data-bv-field="country" style="width:200px;height:35px">
													<option value="0" selected="selected">省</option>
													<option value="1" >市</option>
													<option value="3" >区</option>
													<option value="3" >县</option>
													<option value="4" >镇</option>
												</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
											</div>
										</div>
									</div>
        							
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
										 	<label class="col-lg-3 control-label" style="margin-left:18%">名称拼音：</label>
											<div class="col-lg-6" style="width:230px;">
												<input maxlength="20" type="text" class="form-control" id="regionNameEn" name="regionNameEn" onpaste="return false"/>
											</div>
										</div>
									</div>
        
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%;padding-left:5px">名称拼音简称：</label>
											<div class="col-lg-6" style="width:230px;">
												<input maxlength="20" type="text" class="form-control" id="regionShortnameEn" name="regionShortnameEn" onpaste="return false"/>
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