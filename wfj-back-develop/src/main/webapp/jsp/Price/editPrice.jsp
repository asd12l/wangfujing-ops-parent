<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var url = __ctxPath + "/category/getAllCategory";
  	$(function(){
  		$("#priceSid").val(priceSid);
  		$("#productSku_").val(productSku_);
  		$("#productName_").val(productName_);
  		$("#proColorName_").val(proColorName_);
  		$("#proStanName_").val(proStanName_);
  		$("#originalPrice_").val(originalPrice_);
  		$("#currentPrice_").val(currentPrice_);
  		$("#promotionPrice_").val(promotionPrice_);
  		$("#supplyName_").val(supplyName_);
  		$("#shopName_").val(shopName_);
  		$("#productDetailSid_").val(productDetailSid_);
  		$("#save").click(function(){
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/priceView.jsp");
  		});
	});
  	function saveFrom(){
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/price/updatePrice",
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
		$("#pageBody").load(__ctxPath+"/jsp/priceView.jsp");
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
								<span class="widget-caption">价格修改</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" id="priceSid" name="sid" />
									<input type="hidden" id="productDetailSid_" name="productDetailSid" />
									<div class="form-group">
										<label class="col-lg-3 control-label">商品名称：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled" id="productName_" name="shopName" placeholder="必填"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">商品sku：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled" id="productSku_" name="productSku" placeholder="必填"/>
										</div>
									</div>
									
        							<div class="form-group">
										<label class="col-lg-3 control-label">供应商：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled" id="supplyName_" name="supplyName" placeholder="必填"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">门店：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled" id="shopName_" name="shopName" placeholder="必填"/>
										</div>
									</div>
        
									<div class="form-group">
										<label class="col-lg-3 control-label">包装单位：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled" id="proColorName_" name="proColorName" placeholder="必填"/>
										</div>
									</div>
        
									<div class="form-group">
										<label class="col-lg-3 control-label">计量单位：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled" id="proStanName_" name="proStanName" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label"><span style="color: red;">*</span>原价：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="originalPrice_" name="originalPrice" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label"><span style="color: red;">*</span>现价：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="currentPrice_" name="currentPrice" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label"><span style="color: red;">*</span>促销价：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="promotionPrice_" name="promotionPrice" placeholder="必填"/>
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