<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("ctx", request.getContextPath());%>
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
  	$(function(){
  		$("#close").click(function(){ 
  			$("#pageBody").load(__ctxPath+"/jsp/region/regionView.jsp");
  		});
	});
  	
  	$('#theForm').bootstrapValidator({
		message : 'This value is not valid',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		submitHandler : function(validator, form, submitButton) {
			var regionLevel = $("#regionLevel").val();
	  		if (regionLevel == 1) {
	  			var province = $("#province").val();
				if (province == "") {
					$("#warning2Body").text(buildErrorMessage("","请选择省！"));
					$("#warning2").show();
					return;
				}
			}
	  		if (regionLevel == 2) {
	  			var province = $("#province").val();
				if (province == "") {
					$("#warning2Body").text(buildErrorMessage("","请选择省！"));
					$("#warning2").show();
					return;
				}
				var city = $("#city").val();
				if (city == "") {
					$("#warning2Body").text(buildErrorMessage("","请选择市！"));
					$("#warning2").show();
					return;
				}
			}
	  		if (regionLevel == 3) {
	  			var province = $("#province").val();
				if (province == "") {
					$("#warning2Body").text(buildErrorMessage("","请选择省！"));
					$("#warning2").show();
					return;
				}
				var city = $("#city").val();
				if (city == "") {
					$("#warning2Body").text(buildErrorMessage("","请选择市！"));
					$("#warning2").show();
					return;
				}
			}
			
			var provinceSid = $("#province").val();
			var citySid = $("#city").val();
			if (provinceSid != "") {
				$("#parentId").val(provinceSid);
			}
			if (citySid != "") {
				$("#parentId").val(citySid);
			}
			
			var url = __ctxPath + "/region/addRegion";
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
		       	        $("#loading-container").addClass("loading-inactive");
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
	  	
		},
		fields : {
			regionName : {
				validators : {
					notEmpty : {
						message : '行政区域名称不能为空'
					},
					regexp : {
						regexp : /^[A-Za-z0-9\u4e00-\u9fa5]{1,20}$/,
						message : '行政区域名称只能由1到20位的数字、字母或者中文组成'
					}
				}
			},
			regionCode:{
				validators : {
					notEmpty : {
						message : '邮编不能为空'
					},
					regexp : {
						regexp : /^[0-9]{1,20}$/,
						message : '邮编只能由1到20位的数字组成'
					}
				}
			},
            regionInnerCode:{
                validators : {
                    notEmpty : {
                        message : '行政区域编码不能为空'
                    },
                    regexp : {
                        regexp : /^[0-9]{1,20}$/,
                        message : '行政区域只能由1到20位的数字组成'
                    }
                }
            }
		}

	}).find('button[data-toggle]').on('click',function() {
		var $target = $($(this).attr('data-toggle'));
		$target.toggle();
		if (!$target.is(':visible')) {
			$('#theForm').data('bootstrapValidator').disableSubmitButtons(false);
		}
	});
  	
  	//选择等级
  	$("#regionLevel").change(function(){
  		var regionLevel = $("#regionLevel").val();
  		if (regionLevel == 0) {
			$("#provinceDiv").css("display","none");
			$("#cityDiv").css("display","none");
			$("#areaDiv").css("display","none");
			$("#countryDiv").css("display","none");
		}
  		if (regionLevel == 1) {
  			$("#provinceDiv").css("display","block");
			$("#cityDiv").css("display","none");
			$("#areaDiv").css("display","none");
			$("#countryDiv").css("display","none");
		}
  		if (regionLevel == 2) {
  			$("#provinceDiv").css("display","block");
  			$("#cityDiv").css("display","block");
			$("#areaDiv").css("display","none");
			$("#countryDiv").css("display","none");
		}
  		if (regionLevel == 3) {
  			$("#provinceDiv").css("display","block");
  			$("#cityDiv").css("display","block");
			$("#areaDiv").css("display","none");
			$("#countryDiv").css("display","none");
		}
  	});
  	
  	//点击事件，获取省的信息
 	$("#province").one("click",function(){
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/region/queryListRegion",
			dataType: "json",
			data: "regionLevel=0",
			success: function(response) {
			    if(response.success != "false"){
					var result = response.list;
			  		var province = $("#province");
			  		province.html("<option value=''>请选择</option>");
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>" + ele.regionName + "</option>");
						option.appendTo(province);
					}
			    }else{
					$("#warning2Body").text("没有省的信息!");
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
	});
 	
 	//选择省查询市
 	function classifyOne(){
 		var city = $("#city");
		city.html("<option value=''>请选择</option>");
		var sid = $("#province").val();
        if(sid == ""){
            return;
        }
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/region/queryListRegion",
			dataType: "json",
			data: "parentId="+sid,
			success: function(response) {
			    if(response.success != "false"){
					var result = response.list;
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.sid + "'>" + ele.regionName + "</option>");
						option.appendTo(city);
					}
			    }else{
					$("#warning2Body").text("当前省下没有市信息!");
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
		$("#pageBody").load(__ctxPath+"/jsp/region/regionView.jsp");
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
								<span class="widget-caption">添加行政区域</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="parentId" id="parentId" value="0"/>
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2" >
											<label class="col-lg-3 control-label" style="margin-left:18%">等级：</label>
											<div class="col-lg-6">
												<select id="regionLevel" name="regionLevel" style="width:200px;height:35px">
													<option value="0" selected="selected">省</option>
													<option value="1" >市</option>
													<option value="3" >区</option>
													<option value="3" >县</option>
												</select>
										    </div>
										</div>
									</div>
									
									<div class="form-group" style="display:none" id="provinceDiv">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%">省：</label>
											<div class="col-lg-2">
												<select onchange="classifyOne();" style="width:200px;height:35px" id="province">
													<option value="">请选择</option>
												</select>
											</div>
										</div>
									</div>
										
									<div class="form-group" style="display:none" id="cityDiv">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">									
											<label class="col-lg-3 control-label" style="margin-left:18%">市：</label>
											<div class="col-lg-2">
												<select style="width:200px;height:35px" id="city">
													<option value="">请选择</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="form-group" style="display:none" id="areaDiv">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%">区：</label>
											<div class="col-lg-2">
												<select style="width:200px;height:35px" id="area">
													<option value="">请选择</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="form-group" style="display:none" id="countryDiv">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%">县：</label>
											<div class="col-lg-2">
												<select style="width:200px;height:35px" id="country">
													<option value="">请选择</option>
												</select>
											</div>
										</div>
									</div>
										
        							<div class="form-group" style="display: none">
        								<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%">邮编：</label>
											<div class="col-lg-6" style="width:230px;">
												<input maxlength="20" type="text" class="form-control" id="regionCode" name="regionCode" placeholder="必填" onpaste="return false"/>
											</div>
										</div>
									</div>

                                    <div class="form-group">
                                        <div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
                                            <label class="col-lg-3 control-label" style="margin-left:18%">编码：</label>
                                            <div class="col-lg-6" style="width:230px;">
                                                <input maxlength="20" type="text" class="form-control" id="regionInnerCode" name="regionInnerCode" placeholder="必填" onpaste="return false"/>
                                            </div>
                                        </div>
                                    </div>
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%">名称：</label>
											<div class="col-lg-6" style="width:230px;">
												<input  maxlength="20" type="text" class="form-control" id="regionName" name="regionName" placeholder="必填" onpaste="return false"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label" style="margin-left:18%">名称拼音：</label>
											<div class="col-lg-6" style="width:230px;">
												<input  maxlength="20" type="text" class="form-control" id="regionNameEn" name="regionNameEn" placeholder="选填" onpaste="return false"/>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2" >
											<label class="col-lg-3 control-label" style="margin-left:18%;padding-left:5px">名称拼音简称：</label>
											<div class="col-lg-6" style="width:230px;">
												<input  maxlength="20" type="text" class="form-control" id="regionShortnameEn" name="regionShortnameEn" placeholder="选填" onpaste="return false"/>
											</div>
										</div>
									</div>
									
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save" type="submit" >保存</button>&emsp;&emsp;
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