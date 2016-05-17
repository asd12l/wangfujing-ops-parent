<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var url = __ctxPath + "/category/getAllCategory";
  	$(function(){
  		$("#productName").val(productName_);
  		$("#priceType").val(priceType_);
  		$("#erpProductCode").val(erpProductCode_);
  		$("#supplierName").val(supplierName_);
  		$("#negativeStock").val(negativeStock_);
  		$("#marketPrice").val(marketPrice_);
  		$("#counterName").val(counterName_);
  		$("#edefectiveStock").val(edefectiveStock_);
  		$("#returnStock").val(returnStock_);
  		$("#lockedStock").val(lockedStock_);
  		$("#stockMode").val(stockMode_);
  		$("#channelSid").val(channelSid_);
  		$("#productCode").val(productCode_);
  		$("#counterCode").val(counterCode_);
  		$("#supplierCode").val(supplierCode_);
  		$("#productType").val(productType_);
  		$("#storeName").val(storeName_);
  		$("#saleStock").val(saleStock_);
  		$("#storeCode").val(storeCode_);
  		$("#salesPrice").val(salesPrice_);
  		$("#isSale").val(isSale_);
  		$("#skuCode").val(skuCode_);
  		$("#stockType").val(stockType_);
  		$("#colorCode").val(colorCode_);
  		$("#colorName").val(colorName_);
  		$("#stanCode").val(stanCode_);
  		$("#stanName").val(stanName_);
  		$("#modelCode").val(modelCode_);
  		$("#articleNum").val(articleNum_);
  		$("#brandGroupCode").val(brandGroupCode_);
  		$("#brandGroupName").val(brandGroupName_);
  		
  		$("#save").click(function(){
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/Price/priceView.jsp");
  		});
	});
  	//保存数据
  	function saveFrom(){
		var url = __ctxPath + "/supplierDisplay/updateSupplier";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType:"json",
			ajaxStart: function() {
		       	 $("#loading-container").attr("class","loading-container");
		        },
	        ajaxStop: function() {
	          //隐藏加载提示
	          setTimeout(function() {
	       	        $("#loading-container").addClass("loading-inactive")
	       	 },300);
	        },
			data: $("#theForm").serialize(),
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'><i class='fa-fw fa fa-times'></i><strong>修改成功，返回列表页!</strong></div>");
 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改失败!</strong></div>");
 	     	  		$("#model-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
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
		$("#pageBody").load(__ctxPath+"/jsp/Price/priceView.jsp");
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
								<span class="widget-caption">商品详情</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
								
									<input type="hidden" name="sid" id="sid" value="${json.record.sid }"/>
									<div class="form-group" >
										<label class="col-lg-3 control-label" style="width:200px">商品名称：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="productName" name="productName" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">大码：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="erpProductCode" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">价格类型：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="priceType" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">供应商名称：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="supplierName" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">是否负库存销售：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="negativeStock" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">市场价：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="marketPrice" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">零售价：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="salesPrice" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">专柜名：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="counterName" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">残次品库存：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="edefectiveStock" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">退货库存：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="returnStock" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">锁定库存：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="lockedStock" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">渠道Sid：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="channelSid" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">专柜商品编码：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="productCode" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">专柜编码：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="counterCode" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">供应商编码：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="supplierCode" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">商品类型：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="productType" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">门店名称：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="storeName" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">可售库存：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="saleStock" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">门店编码：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="storeCode" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">专柜商品可售状态：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="isSale" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">商品表SKU 编码：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="skuCode" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">库存方式：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="stockType" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">颜色编码：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="colorCode" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">颜色：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="colorName" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">规格编码：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="stanCode" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">规格名称：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="stanName" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">款号：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="modelCode" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">货号：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="articleNum" readonly="readonly"/>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="width:200px">集团品牌编码：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="brandGroupCode" readonly="readonly"/>
										</div>
										<label class="col-lg-3 control-label" style="width:200px">集团品牌：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="brandGroupName" readonly="readonly"/>
										</div>
									</div>
									
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="返回" />
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



