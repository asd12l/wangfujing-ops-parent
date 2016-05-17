<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
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
	var url = __ctxPath + "/category/getAllCategory";
  	$(function(){
  		$("#save").click(function(){
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/supplyBrandShop.jsp");
  		});
  		//获取供应商
  		var url = __ctxPath + "/supplyBrandShop/selectAllSupply3";
  		var suppId = $("#suppId");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType: "json",
			success: function(response) {
				var result = response;
				suppId.html("<option value='-1'>全部</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option onclick='selectShop("+ele.sid+")' value='" + ele.sid + "'>"
							+ ele.supplyName + "</option>");
					option.appendTo(suppId);
				}
				return;
			},
			error: function() {
				$("#warning2Body").text(buildErrorMessage("","系统出错！"));
				$("#warning2").show();
			}
		});
		//获取品牌
  		var url = __ctxPath + "/brandDisplay/queryBrandDisplay";
  		var brandId = $("#brandId");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType: "json",
			success: function(response) {
				var result = response;
				brandId.html("<option value='-1'>全部</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.SID + "'>"
							+ ele.brand_name + "</option>");
					option.appendTo(brandId);
				}
				return;
			},
			error: function() {
				$("#warning2Body").text(buildErrorMessage("","系统出错！"));
				$("#warning2").show();
			}
		});
	});
	function selectShop(data){
		//获取门店
  		var url = __ctxPath + "/supplyBrandShop/getShopInfosBySupply";
  		var shopId = $("#shopId");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType: "json",
			data:{
				"supplySid": data
			},
			success: function(response) {
				var result = response;
				shopId.html("<option value='-1'>全部</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.shop_sid + "'>"
							+ ele.shop_name + "</option>");
					option.appendTo(shopId);
				}
				return;
			},
			error: function() {
				$("#warning2Body").text(buildErrorMessage("","系统出错！"));
				$("#warning2").show();
			}
		});
	}
  	//保存数据
  	function saveFrom(){
		var url = __ctxPath + "/supplyBrandShop/insertSupplyBrandShop";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType:"json",
			data: $("#theForm").serialize(),
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'><i class='fa-fw fa fa-times'></i><strong>添加成功，返回列表页!</strong></div>");
 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#warning2Body").text(buildErrorMessage("","添加失败！"));
					$("#warning2").show();
				}
				return;
			},
			error: function() {
				$("#warning2Body").text(buildErrorMessage("","系统出错！"));
				$("#warning2").show();
			}
		});
  	}
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/supplyBrandShop.jsp");
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
								<span class="widget-caption">供应商门店品牌关联管理</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<div class="form-group">
										<label class="col-lg-3 control-label">供应商名称：</label>
										<div class="col-lg-6">
											<select class="form-control" id="suppId" name="supplySid"></select>
										</div>
									</div>
									
        							<div class="form-group">
										<label class="col-lg-3 control-label">门店名称：</label>
										<div class="col-lg-6">
											<select class="form-control" id="shopId" name="shopSid"></select>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">品牌名称：</label>
										<div class="col-lg-6">
											<select class="form-control" id="brandId" name="brandSid"></select>
										</div>
									</div>
        
									<div class="form-group">
										<label class="col-lg-3 control-label">是否网销：</label>
										<div class="col-lg-6">
											<select class="form-control" id="title" name="netBit">
												<option value="0">禁止网销</option>
												<option value="1" selected="selected">允许网销</option>
											</select>
										</div>
									</div>
        
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />&emsp;&emsp;
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