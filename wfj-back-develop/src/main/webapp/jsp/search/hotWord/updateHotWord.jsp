<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("ctx", request.getContextPath());%>
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
	$(function(){
		//点击事件，获取站点的信息
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/hotWord/queryListSite",
				dataType: "json",
				success: function(response) {
				    if(response.success != false){
						var result = response.list;
				  		var site = $("#site");
				  		var site_ = $("#site_").val();
						for ( var i = 0; i < result.length; i++) {
							var ele = result[i];
							if(site_ == ele.id){
								var option = $("<option value='" + ele.id + "' selected='selected'>" + ele.name + "</option>");
							}else{
							var option = $("<option value='" + ele.id + "'>" + ele.name + "</option>");
							}
							option.appendTo(site);
						}
				    }else{
						$("#warning2Body").text("没有站点的信息!");
						$("#warning2").show();
				    }
					return;
				}
			}); 
		
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/hotWord/queryListChannel",
				dataType: "json",
				data: {
					"siteId":$("#site_").val()
				},
				success: function(response) {
				    if(response.success != false){
						var result = response.list;
						var channel = $("#channel");
						var channel_ = $("#channel_").val();
						for ( var i = 0; i < result.length; i++) {
							var ele = result[i];
							if(channel_ == ele.id){
								var option = $("<option value='" + ele.id + "' selected='selected'>" + ele.name + "</option>");
							}else{
							var option = $("<option value='" + ele.id + "'>" + ele.name + "</option>");
							}
							option.appendTo(channel);
						}
				    }else{
						$("#warning2Body").text("当前站点下没有频道信息!");
						$("#warning2").show();
				    }
					return;
				},
				error: function() {
					$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
			  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
				}
			}); 
	 	
	 	//选择站点查询频道
	 	function classifyOne(){
	 		var channel = $("#channel");
			channel.html("<option value=''>请选择</option>");
			var sid = $("#site").val();
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/hotWord/queryListChannel",
				dataType: "json",
				data: {
					"siteId":sid
				},
				success: function(response) {
				    if(response.success != false){
						var result = response.list;
						for ( var i = 0; i < result.length; i++) {
							var ele = result[i];
							var option = $("<option value='" + ele.id + "'>" + ele.name + "</option>");
							option.appendTo(channel);
						}
				    }else{
						$("#warning2Body").text("当前站点下没有频道信息!");
						$("#warning2").show();
				    }
					return;
				},
				error: function() {
					$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
			  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
				}
			}); 
		}
		
		$("#save").click(function(){
			saveFrom();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/search/hotWord/hotWordManage.jsp");
		});
	});
	
	function saveFrom(){
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/hotWord/updateHotWord",
			dataType:"json",
			data: $("#theForm").serialize(),
			ajaxStart: function() {$("#loading-container").attr("class","loading-container");},
			ajaxStop: function() {
				setTimeout(function() {$("#loading-container").addClass("loading-inactive");},300);
			},
			
			success: function(response) {
				if(response.success==true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>修改成功，返回列表页!</strong></div>");
		     	  	$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else {
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
		     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			},
		});
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
		},
		fields : {
			value : {
				validators : {
					notEmpty : {
						message : '显示内容不能为空'
					}
				}
			},
			link : {
				validators : {
					notEmpty : {
						message : '链接不能为空'
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
	$("#pageBody").load(__ctxPath+"/jsp/search/hotWord/hotWordManage.jsp");
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
								<span class="widget-caption">修改热词</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="sid" id="sid" value="${param.sid }"/>
									<input type="hidden" name="site_" id="site_" value="${param.site }"/>
									<input type="hidden" name="channel_" id="channel_" value="${param.channel }"/>
									<div class="form-group" >
										<label class="col-lg-3 control-label">站点：</label>
										<div class="col-lg-6">
											<select onchange="classifyOne();" id="site" name="site" style="padding: 0 0;width: 200px">												
											</select>
										</div>
									</div>
									
        							<div class="form-group" >
										<label class="col-lg-3 control-label">频道：</label>
										<div class="col-lg-6">
											<select id="channel" name="channel" style="padding: 0 0;width: 200px">
											</select>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">显示内容：</label>
										<div class="col-lg-6" style="width:230px;">
											<input maxlength="20" type="text" class="form-control" id="value" name="value" value="<%=new String(request.getParameter("value").getBytes("iso8859-1"),"UTF-8") %>" />
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">链接：</label>
										<div class="col-lg-6" style="width:230px;">
											<input  maxlength="1000" type="text" class="form-control" id="link" name="link" value="${param.link }" />
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">显示顺序：</label>
										<div class="col-lg-6" style="width:230px;">
											<input  maxlength="20" type="text" class="form-control" id="orders" name="orders" value="${param.orders }" />
										</div>
									</div>
									
									<div class="form-group">
									    <div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="修改" />&emsp;&emsp;
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