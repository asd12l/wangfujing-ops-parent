<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/bootstrap/css/bootstrap-datetimepicker.min.css"/>
	<script src="${ctx}/js/jquery-1.9.1.js"></script>
	<script src="${ctx}/js/jquery.form.js"></script>
	<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
	<script src="${ctx}/js/bootstrap/bootstrap-datetimepicker.js"></script>
	<title></title>
	<script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		$(function(){
			$(".form_datetime").datetimepicker({
				startView: 4,
				minView: 4,
				format: 'yyyy',
				autoclose: true
			});
			$("#save").click(function(){
				var setupComplaintBal=$("#setupComplaintBal").val();
				var setupCarriageBal=$("#setupCarriageBal").val();
				var filter  = /^[0-9].*$/;
				if(filter.test(setupComplaintBal) && filter.test(setupCarriageBal)){
					saveFrom();
				}else{
					alert("请输入正数！");
					return false;
				}

			});
			$("#close").click(function(){
				$("#pageBody").load(__ctxPath+"/jsp/mem/BalanceYearLimit.jsp");
			});
		});



		function Check(limit) {
			var filter  = /^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$/;
			if (filter.test(limit)) return true;
			else {
				alert('只能填写正数！');
				return false;}
		}
		//保存数据
		function saveFrom(){
			$.ajax({
				type:"post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url:__ctxPath + "/balanceYearLimit/insert",
				dataType: "json",
				data: $("#theForm").serialize(),

				success:function(response) {
					console.log(response);
					if(response.code == "1"){
						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
								"<i class=''></i><strong>添加成功，返回列表页!</strong></div>");
						$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
					}else{
						$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!"+response.desc+"</strong></div>");
						$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					}
				}
			});
		}

		function successBtn(){
			$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
			$("#pageBody").load(__ctxPath+"/jsp/mem/BalanceYearLimit.jsp");
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
							<span class="widget-caption">新增余额年限制</span>
						</div>
						<div class="widget-body">
							<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">
								<div class="form-group">
									<label class="col-lg-3 control-label">投诉补偿额度</label>
									<div class="col-lg-4">
										<input type="text" class="form-control" id="setupComplaintBal" name="setupComplaintBal" placeholder="必填"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-lg-3 control-label">运费补偿额度</label>
									<div class="col-lg-4">
										<input type="text" class="form-control" id="setupCarriageBal"  name="setupCarriageBal" placeholder="必填"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-lg-3 control-label">年份</label>
									<div class="col-lg-6">
										<div class="input-append date form_datetime">
											<input size="16" type="text" name="year" id="year" value="" readonly>
											<span class="add-on"><i class="icon-th"></i></span>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-lg-offset-4 col-lg-6">
										<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />&emsp;&emsp;
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