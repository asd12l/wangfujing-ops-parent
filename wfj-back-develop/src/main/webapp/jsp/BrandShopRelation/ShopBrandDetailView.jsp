<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.img_error{color: #e46f61; font-size: 85%;}
.hide{display: none;}
</style>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<title></title>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function(){
		
		$("#brandSid").text(brandSid_);
		$("#brandName").text(brandName_);
		$("#spell").text(spell_);
		$("#brandNameSecond").text(brandNameSecond_);
		$("#brandNameEn").text(brandNameEn_);
		if(typeof(shopType_) != "undefined"){
			if(shopType_ == "0"){
				shopType_ = "北京";
			}
			if(shopType_ == "1"){
				shopType_ = "外阜";
			}
			if(shopType_ == "2"){
				shopType_ = "电商";
			}
		}
		$("#shopType").text(shopType_);
		if(typeof(isDisplay_) != "undefiend"){
			if(isDisplay_ == 0){
				isDisplay_ = "是";
			}
			if(isDisplay_ == 1){
				isDisplay_ = "否";
			}
		}
		$("#isDisplay").text(isDisplay_);
		$("#brandDesc").text(brandDesc_);
		$("#brandpic1").attr("src", url_ + brandpic1_);
		$("#brandpic2").attr("src", url_ + brandpic2_);
  		
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath + "/jsp/BrandShopRelation/ShopBrandRelationView.jsp");
  		});
	});
  	
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/BrandShopRelation/ShopBrandRelationView.jsp");
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
								<span class="widget-caption">门店品牌详情</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" id="sid" name="sid"/>
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">品牌名称：</label>
											<div class="col-lg-6" style="width:230px">
												<label class="control-label" id="brandName"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">品牌编码：</label>
											<div class="col-lg-6" style="width:230px">
												<label class="control-label" id="brandSid"></label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">中文拼音：</label>
											<div class="col-lg-6" style="width:230px">
												<label class="control-label" id="spell"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">中文名称：</label>
											<div class="col-lg-6" style="width:230px">
												<label class="control-label" id="brandNameSecond"></label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">英文名：</label>
											<div class="col-lg-6" style="width:230px">
												<label class="control-label" id="brandNameEn"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">门店类型：</label>
											<div class="col-lg-6">
												<label class="control-label" id="shopType"></label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">图片1：</label>
											<div class="col-lg-6">
												<img src="" height="60px" width="60px" id="brandpic1"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">图片2：</label>
											<div class="col-lg-6">
												<img src="" height="60px" width="60px" id="brandpic1"/>
											</div>
										</div>
									</div>
        							<div class="form-group">
        								<div class="col-md-6">
											<label class="col-lg-3 control-label">是否展示：</label>
											<div class="col-lg-6">
												<label class="control-label" id="isDisplay"></label>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">品牌描述：</label>
											<div class="col-lg-2">
												<label class="control-label" id="brandDesc"></label>
											</div>
										</div>
        							</div>
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="关闭"/>
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