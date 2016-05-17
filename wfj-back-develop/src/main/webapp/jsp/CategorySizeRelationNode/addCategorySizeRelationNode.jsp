<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	
	$(function(){
		//类别
		var sizeClassSid = $("#sizeClassSid");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/proStanClassDict/getProStanCategorys",
			dataType: "json",
			success: function(response) {
				var result = response;
				sizeClassSid.html("<option value='-1'>全部</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.category_sid + "'>"
							+ ele.name + "</option>");
					option.appendTo(sizeClassSid);
				}
				return;
			}
		});
		//品牌
		var brandSid = $("#brandSid");
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/brandDisplay/getAllBrandDisplay",
			dataType: "json",
			success: function(response) {
				var result = response;
				brandSid.html("<option value='-1'>全部</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.sid + "'>"
							+ ele.brandName + "</option>");
					option.appendTo(brandSid);
				}
				return;
			}
		});
  		$("#save").click(function(){
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/CategorySizeRelationNode.jsp");
  		});
	});
  	function saveFrom(){
	    $.ajax({
	    	type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/SsdProductStanDict/addPorductSizeClass",
			dataType : 'json', 
			data: $("#theForm").serialize(),
			success: function(response) {
				if(response.success == 'true'){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>添加成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-success").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败!</strong></div>");
 	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
	    });
  	}
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/CategorySizeRelationNode.jsp");
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
								<span class="widget-caption">添加分类计量单位</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
									<input type="hidden" name="lastOptUser" value=""/>
									<script type="text/javascript">$("input[name='lastOptUser']").val(getCookieValue("username"));</script>
									<div class="form-group">
										<label class="col-lg-3 control-label">计量单位：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="sizeName" name="sizeName" placeholder="必填"/>
										</div>
									</div>
        
									<div class="form-group">
										<label class="col-lg-3 control-label">计量单位描述：</label>
										<div class="col-lg-6">
											<textarea class="form-control" id="sizeDesc" name="sizeDesc"></textarea>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">类别对应：</label>
										<div class="col-lg-6">
											<select class="form-control" id="sizeClassSid" name="sizeClassSid"></select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">品牌关联：</label>
										<div class="col-lg-6">
											<select class="form-control" id="brandSid" name="brandSid"></select>
										</div>
									</div>
        
						
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" type="button" id="close" value="取消"/>
										</div>
									</div>
									<div style="display: none;">
										<input id="articleCat" name="productPropValues" />
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