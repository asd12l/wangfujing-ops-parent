<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>品牌坑位添加</title>
<script type="text/javascript">
	
	__ctxPath = "${pageContext.request.contextPath}";
	$(function(){
  		$("#save").click(function(){
  		    var spuId=$("#spuId").val();
  		    var orders=$("#orders").val();
  			if(spuId==""||spuId==null){
  				
  				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"spuId不能为空！"+"</strong></div>");
				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
  				return;
  			} else if(orders==""||orders==null){
  				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"顺序不能为空！"+"</strong></div>");
				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
  				return;
  			}
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/search/BrandStick/brandStick.jsp");
  		});
	});
  	//保存数据
  	function saveFrom(){
  		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/back/brandStickSave",
	        dataType: "json",
	        data:$("#theForm").serialize(),
	        success:function(response) {
	        	console.log(response);
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class=''></i><strong>添加成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
        	}
		});
  	}
  	
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/search/BrandStick/brandStick.jsp");
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
								<span class="widget-caption">新增坑位</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data"> 
									<input type="hidden" id="username" name="username" value="${username}"/> 
									<input type="hidden" id="brandId" name="brandId" value="${param.brandId}"/>      
									<div class="form-group">
										<label class="col-lg-3 control-label">spuId</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="spuId" name="spuId" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">顺序</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="orders" name="orders" />
										</div>
									</div>
									<!-- <div class="form-group">
										<label class="col-lg-3 control-label">操作人</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="createOperator" name="createOperator" />
										</div>
									</div> -->
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