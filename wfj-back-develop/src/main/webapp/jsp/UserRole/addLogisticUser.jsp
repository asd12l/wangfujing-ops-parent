<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<title>商品基本信息</title>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function(){
		var supplyoption = $("#supplySid");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/supplyBrandShop/selectAllSupply3",
			dataType: "json",
			success: function(response) {
				var result = response;
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option;
					//if(brandRootName_ == ele.brandName){
					//	option = $("<option selected='selected' value='" + ele.sid + "'>"
					//			+ ele.brandName + "</option>");
					//	option.appendTo(brandRootName_edit);
					//}else{
						option = $("<option value='" + ele.sid + "'>"
								+ ele.supplyName + "</option>");
						option.appendTo(supplyoption);
					//}
				}
				return;
			},
			error: function() {
				$("#warning2Body").text(buildErrorMessage("","系统出错！"));
				$("#warning2").show();
			}
		});
  		$("#save").click(function(){
  			var userName=$("#userName").val();
  	  		var realName=$("#realName").val();
  	  		var passWord=$("#passWord").val();
  	  		var supplySid=$("#supplySid").val();
  	  		var supplyName=$("#supplyName").val();
  	  		var shopName=$("#shopName").val();
  	  		var shopSid=$("#shopSid").val();
  	  		if(userName==""||userName==null){
  	  			alert("用户名不能为空！");
  	  			return ;
  	  		}
  	  		if(realName==""||realName==null){
	  			alert("真实姓名不能为空！");
	  			return ;
	  		}
  	  		if(passWord==""||passWord==null){
	  			alert("密码不能为空！");
	  			return ;
	  		}
  	  		if(supplySid==""||supplySid==null){
  				alert("请选择供应商！");
  				return ;
  			}
  			if(shopSid==""||shopSid==null){
				alert("请选择店铺！");
				return ;
			}
  			var shopdata = document.getElementById("shopSid"); //selectid
  			var shopindex = shopdata.selectedIndex; // 选中索引
  			var shopName = shopdata.options[shopindex].text; // 选中文本
			$("#shopName").val(shopName);
			var supplydata = document.getElementById("supplySid"); //selectid
  			var supplyindex = supplydata.selectedIndex; // 选中索引
  			var supplyName = supplydata.options[supplyindex].text; // 选中文本
			$("#supplyName").val(supplyName);
  	  		//alert("userName:"+userName+";realName:"+realName+";passWord:"+passWord+";supplySid"+supplySid+";shopSid:"+shopSid+";supplyName:"+supplyName+";shopName:"+shopName);
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/backUser.jsp");
  		});
	});
	function loadShop(){
		var shopoption = $("#shopSid");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/supplyBrandShop/getShopInfosBySupply",
			dataType: "json",
			data: $("#theForm").serialize(),
			success: function(response) {
				var result = response;
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option;
					//if(brandRootName_ == ele.brandName){
					//	option = $("<option selected='selected' value='" + ele.sid + "'>"
					//			+ ele.brandName + "</option>");
					//	option.appendTo(brandRootName_edit);
					//}else{
						option = $("<option value='" + ele.shop_sid + "'>"
								+ ele.shop_name + "</option>");
						option.appendTo(shopoption);
					//}
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
  		
  		//if(1==2){
  			$.ajax({
  		        type:"post",
  		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
  		        url:__ctxPath + "/backUser/saveLogiticsUser",
  		        dataType: "json",
  		        data: $("#theForm").serialize(),
  		        success:function(response) {
  		        	if(response.success == 'true'){
  						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
  							"<i class='fa-fw fa fa-times'></i><strong>添加成功，返回列表页!</strong></div>");
  	  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
  					}else{
  						$("#warning2Body").text(buildErrorMessage("","添加失败！"));
						$("#warning2").show();
  					}
  	        	}
  			});
  		//}
  	}
  	
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/backUser.jsp");
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
								<span class="widget-caption">新增物流专员</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
									<div class="form-group">
										<label class="col-lg-3 control-label">用户名</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="userName" name="userName" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">密码</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="passWord" name="passWord" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">真实姓名</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="realName" name="realName" placeholder="必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">供应商</label>
										<div class="col-lg-6">
											<select class="form-control" id="supplySid" name="supplySid" onchange="loadShop();" data-bv-field="country">
												<option value=""></option>
												
											</select>
											<input type="hidden" name="supplyName" id="supplyName"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">门店</label>
										<div class="col-lg-6">
											<select class="form-control" id="shopSid" name="shopSid" data-bv-field="country">
												<option value=""></option>
											</select>
											<input type="hidden" name="shopName" id="shopName">
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