<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var url = __ctxPath + "/category/getAllCategory";

	//门店名称
	var shopName_input = $("#shopName_input");
	$
			.ajax({
				type : "post",
				url : __ctxPath + "/shoppe/queryShopListAddPermission",
				async : false,
				dataType : "json",
				success : function(response) {
					$.ajax({
						type : "get",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/priceLimit/findAllShopSidFromPriceLimit",
						dataType : "json",
						success : function(json){
							if(json.success != "false"){
								var shopsSid=json["shopsSid"];
							    var isShow=true;			    
								var result = response.list;
								shopName_input.html("<option value='-1'>请选择门店</option>");
								for ( var i = 0; i < result.length; i++) {
									var ele = result[i];
									if(shopsSid != undefined) isShow=shopsSid.indexOf(ele.sid)<0;
									
									if(isShow){
										var option = $("<option value='" + ele.sid + "'>"
												+ ele.organizationName + "</option>");
										option.appendTo(shopName_input);
									}	
								}
							} 
						}
					});					
					return;
				},
				error : function(XMLHttpRequest, textStatus) {		      
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
    
  	$('#theForm').bootstrapValidator({
		message : 'This value is not valid',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		submitHandler : function(validator, form, submitButton) {
			var url = __ctxPath + "/priceLimit/savePriceLimit";
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
						$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
	 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
					}else if(response.data.errorMsg!=""){
		     	  		$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
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
	}).find('button[data-toggle]').on(
			'click',
			function() {
				var $target = $($(this).attr('data-toggle'));
				$target.toggle();
				if (!$target.is(':visible')) {
					$('#theForm').data('bootstrapValidator')
							.disableSubmitButtons(false);
				}
			});
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/Price/priceLimitView.jsp");
	}
  	
  	$("#save").click(function() {
  		return requiredBaseForm();
	});
  	$("#close").click(function() {
		$("#pageBody").load(__ctxPath + "/jsp/Price/priceLimitView.jsp");
	});
  	
  	function requiredBaseForm() {
		if ($("#shopName_input").val() == -1) {
			$("#warning2Body").text("请选择门店");
			$("#warning2").show();
			return false;
		}
		if ($("#upper").val().trim() == "" && $("#upperStatus").val() == 0) {
			$("#warning2Body").text("请填写上限值");
			$("#warning2").show();
			return false;
		}
		if(!(parseFloat($("#upper").val().trim())>=1) && $("#upperStatus").val() == 0){
			$("#warning2Body").text("请填写正确的上限值");
			$("#warning2").show();
			return false;
		}
		if ($("#lower").val().trim() == "" && $("#lowerStatus").val() == 0) {
			$("#warning2Body").text("请填写下限值");
			$("#warning2").show();
			return false;
		}	
		if(!(parseFloat($("#lower").val().trim())>=0 && parseFloat($("#lower").val().trim())<=1)
				&& $("#upperStatus").val() == 0){
			$("#warning2Body").text("请填写正确的下限值");
			$("#warning2").show();
			return false;
		}
		return true;
  	}
  	
  	function isEdit(){
		if($("#upperStatus").val()==1){
			$("#upper").attr("disabled","disabled");
		}
		else{
			$("#upper").removeAttr("disabled");
		}
		if($("#lowerStatus").val()==1){
			$("#lower").attr("disabled","disabled");
		}
		else{
			$("#lower").removeAttr("disabled");
		}
	}
	$("#upperStatus").change(isEdit);
	$("#lowerStatus").change(isEdit);
	

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
								<span class="widget-caption">添加价格阀值</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
								    <input type="hidden" name="createName" value="">
									<script type="text/javascript">
										$("input[name='createName']").val(getCookieValue("username"));
									</script>
									<div class="form-group">
										<label class="col-lg-3 control-label" style="margin-left:150px;">门店：</label>
										<div class="col-md-2" style="width:372px">
											<select class="form-control" id="shopName_input" name="shopSid" data-bv-field="country">
												<option value="-1">请选择门店</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
										</div>
									</div>
									
        							<div class="form-group">
										<label class="col-lg-3 control-label" style="margin-left:150px;">阀值上限：</label>
										<div class="col-md-2">
										    <input type="text" style="width: 150px" class="form-control" id="upper" name="upper"
										           onkeyup="value=value.replace(/[^0-9\.]/g,'');" onpaste="return false;"
										           placeholder="输入大于等于1的数" maxlength="5"/>
										</div>
										<div class="col-lg-2">
											<select class="form-control" style="width: 110px;" id="upperStatus" name="upperStatus" data-bv-field="country">
												<option value="1">禁用</option>
												<option value="0" selected="selected">启用</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label" style="margin-left:150px;">阀值下限：</label>
										<div class="col-md-2">
											<input type="text" style="width: 150px" class="form-control" id="lower" name="lower" 
											       onkeyup="value=value.replace(/[^0-9\.]/g,'');" onpaste="return false;"
											       placeholder="输入0到1的数" maxlength="4"/>
										</div>
										<div class="col-lg-2">
											<select class="form-control" style="width: 110px;" id="lowerStatus" name="lowerStatus" data-bv-field="country">
												<option value="1">禁用</option>
												<option value="0" selected="selected">启用</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
										</div>	
									</div>

                                    <div class="form-group">
                                        <label style="width:500px;color:red;size:12px;margin: 0 30%;padding-left:5px">
                                            备注：阀值=售价/原价；上限值为大于等于1；下限最小值为0.01(保留两位小数)
                                        </label>
                                    </div>
						            
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;"
												id="save" type="submit" >保存</button>&emsp;&emsp;
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