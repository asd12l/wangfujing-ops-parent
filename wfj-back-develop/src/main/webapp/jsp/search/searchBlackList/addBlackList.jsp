<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script src="${ctx}/js/ajaxfileupload.js"></script>
<title>品牌信息</title>
<style type="text/css">
.hide{display: none;}
.img_error{color: #e46f61; font-size: 85%;}
</style>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	LA.sysCode = '43';
	var sessionId = "<%=request.getSession().getId() %>";
	 $(function(){
		t=0;
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
			        type:"post",
			        contentType: "application/x-www-form-urlencoded;charset=utf-8",
			        dataType: "json",
			        ajaxStart: function() {
				       	 $("#loading-container").attr("class","loading-container");
				        },
			        ajaxStop: function() {
			          //隐藏加载提示
			          setTimeout(function() {
			       	        $("#loading-container").addClass("loading-inactive")
			       	 },300);
			        },
			        url: __ctxPath + "/blackList/addBlackList",
			        data: $("#theForm").serialize(),
			        success: function(response) {
						LA.log('search.blackListAdd', '添加黑名单 type:'+$("#type").val() +" id:"+$("#id").val(), getCookieValue("username"), sessionId);
						if(response.success == true){
							$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
								"<strong>添加成功，返回列表页!</strong></div>");
		  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			        	}else {
			        	    $("#warning2Body").text(response.message);
							$("#warning2").show();
						}
		        	}
				});
			},
			fields : {
				type : {
					validators : {
						notEmpty : {
							message : '类型不能为空'
						}
					}
				},
				id:{
					validators : {
						notEmpty : {
							message : '编号不能为空'
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
  			$("#pageBody").load(__ctxPath+"/jsp/search/searchBlackList/BlackList.jsp");
  		});
	}); 
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
		$("#pageBody").load(__ctxPath+"/jsp/search/searchBlackList/BlackList.jsp");
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
								<span class="widget-caption">添加黑名单</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">  
									<div class="form-group">
										<label class="col-lg-3 control-label">类型</label>
										<div class="col-lg-6">
											<select id="type" name="type" style="width:200px;padding: 0px 0px">
												<option value="">--请选择--</option>
												<option value="ITEM">商品</option>
												<option value="SKU">SKU</option>
												<option value="SPU">SPU</option>
												<option value="BRAND">品牌</option>
											</select>   
										</div>
									</div>   
									<div class="form-group">
										<label class="col-lg-3 control-label">编号</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="id" name="id" placeholder="必填"/>
										</div>
									</div>
        							
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save" type="submit" >保存</button>&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消"/>
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