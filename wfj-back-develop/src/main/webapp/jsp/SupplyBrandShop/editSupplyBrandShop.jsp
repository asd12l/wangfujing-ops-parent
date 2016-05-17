<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var url = __ctxPath + "/category/getAllCategory";
  	$(function(){
  		$("#sid").val(SupplyBSsid);
  		$("#supplySid").val(supplySid_);
  		$("#suppId").val(supplyName_);
  		$("#shopId").val(shopName_);
  		if(netBit_sid.trim()=="允许网销"){
  			$("#netBit").append("<option value='0'>禁止网销</option><option value='1' selected='selected'>允许网销</option>");
  		}else{
  			$("#netBit").append("<option value='0' selected='selected'>禁止网销</option><option value='1'>允许网销</option>");
  		}
  		$("#save").click(function(){
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/supplyBrandShop.jsp");
  		});
  		//获取门店
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/supplyBrandShop/getShopInfosBySupply",
			dataType: "json",
			data:{"supplySid": supplySid_},
			success: function(response) {
				var result = response;
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					if(shopName_ == ele.shop_name){
						$("#shopSid").val(ele.shop_sid);
					}
				}
			}
		});
		//获取品牌
		var brandId = $("#brandId");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/brandDisplay/queryBrandDisplay",
			dataType: "json",
			success: function(response) {
				var result = response;
				brandId.html("<option value='-1'>全部</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option;
					if(brandName_ == ele.brand_name){
						option = $("<option selected='selected' value='" + ele.SID + "'>"
							+ ele.brand_name + "</option>");
					}else{
						option = $("<option value='" + ele.SID + "'>"
							+ ele.brand_name + "</option>");
					}
					option.appendTo(brandId);
				}
				return;
			}
		});
	});
  	//保存数据
  	function saveFrom(){
		var url = __ctxPath + "/supplyBrandShop/updataSupplyBrandShop";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType:"json",
			data: $("#theForm").serialize(),
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'><i class='fa-fw fa fa-times'></i><strong>修改成功，返回列表页!</strong></div>");
 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#warning2Body").text(buildErrorMessage("","修改失败！"));
					$("#warning2").show();
				}
				return;
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
								<span class="widget-caption">供应商门店品牌关联维护</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="sid" id="sid"/>
									<input type="hidden" name="supplySid" id="supplySid"/>
									<input type="hidden" name="shopSid" id="shopSid"/>
									<div class="form-group">
										<label class="col-lg-3 control-label">供应商名称：</label>
										<div class="col-lg-6">
											<input type="text" disabled="disabled" class="form-control" id="suppId"></select>
										</div>
									</div>
									
        							<div class="form-group">
										<label class="col-lg-3 control-label">门店名称：</label>
										<div class="col-lg-6">
											<input type="text" disabled="disabled" class="form-control" id="shopId"></select>
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
											<select class="form-control" id="netBit" name="netBit"></select>
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