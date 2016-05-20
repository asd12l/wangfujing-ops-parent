<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>

<title>app基本信息</title>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function(){
  		$("#save").click(function(){
			var title = $("#title").val();
			if(title == "" || title == null){
				alert("标题不能为空！");
				return;
			}
			var reg = /^(\d+,?)+$/;
			var ids = $("#ids").val();
			if(!reg.test(ids)){
				alert("商品id只能填写数字和,");
				return;
			}
  			saveFrom();
  		});

	});
  	//保存数据
  	function saveFrom(){

  		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/gp/add",
	        dataType: "json",
	        data:$("#theForm").serialize(),
	        success:function(response) {
	        	if(response.success == true){
					$("#hidGpId").val(response.gp);
					$("#regp").html(response.gp);
					$("#addDIV").show();
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.msg+"</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
        	}
		});
  	}

	$("#confirm").click(function(){
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/gp/confirm",
			dataType: "json",
			data:{
				gp:$("#hidGpId").val()
			},
			success:function(response) {
				if(response.success == true){
					$("#pageBody").load(__ctxPath+"/jsp/search/gp/gp.jsp");
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.msg+"</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
			}
		});

	});
	function cancel(){
		$("#addDIV").hide();
	}
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/search/gp/gp.jsp");
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
								<span class="widget-caption">新增</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">
									<input type="hidden" id="hidGpId" name="gpId"/>
									<div class="form-group">
										<label class="col-lg-3 control-label">标题</label>
										<div class="col-lg-2">
											<input type="text" class="form-control" id="title"  name="title" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">商品ID</label>
										<div class="col-lg-2">
											<textarea type="text" class="form-control" id="ids"  name="ids" placeholder="一行一个编码" rows="12"/>
										</div>
									</div>
         							<div class="form-group">
										<div class="col-lg-offset-3 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />
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

	<div class="modal modal-darkorange" id="addDIV">
		<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
							type="button" onclick="closeDiv();">×</button>
					<h4 class="modal-title">添加</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<form id="addPositionForm" method="post" class="form-horizontal">
								<input type="hidden" id="gpnum" name="gpnum">
								<div class="form-group">
									<label class="col-lg-3 control-label">gp编码为：</label>
									<div class="col-lg-6" id="regp">

									</div>
								</div>
								<div class="form-group">
									<div class="col-lg-offset-4 col-lg-6">
										<input class="btn btn-success" style="width: 35%;" id="confirm"
											   type="button" value="保存" />&emsp;&emsp; <input
											class="btn btn-danger" style="width: 35%;" id="close"
											onclick="cancel();" type="button" value="取消" />
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
		</div>
 <!-- /Page Body -->
</body>
</html>