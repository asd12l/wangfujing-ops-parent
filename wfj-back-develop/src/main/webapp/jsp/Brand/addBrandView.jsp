<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script src="${ctx}/js/ajaxfileupload.js"></script>
<title>品牌信息</title>
<style type="text/css">
.hide{display: none;}
.img_error{color: #e46f61; font-size: 85%;}
.showImgNameA,.showImgNameA:hover {background-color: #fbfbfb;float:left;top:0;color:black;
				width:135px;height:25px;line-height: 25px;text-decoration:none;
				margin-left:65px;position: absolute;}
</style>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	 $(function(){
         //校验品牌名称
         var brandExistence = false;
         $("#brandName").blur(function(){
              $.ajax({
                  type: "post",
                  contentType: "application/x-www-form-urlencoded;charset=utf-8",
                  url: __ctxPath+"/brandDisplay/validateBrandExistence",
                  dataType: "json",
                  data: {
                      "brandType" : 0,
                      "brandName" : $(this).val().trim()
                  },
                  success: function(response) {
                      if(typeof response.data.errorMsg != "undefined"){
                          $("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
                          $("#warning2").show();
                          brandExistence = true;
                      } else {
                          brandExistence = false;
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
         $("#spell").keydown(function(){
             if(brandExistence) {
                 $("#warning2Body").text("品牌已存在，请修改。");
                 $("#warning2").show();
             }
         });

		$('#theForm').bootstrapValidator({
			message : '无效的值！',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			submitHandler : function(validator, form, submitButton) {
				// Do nothing
                /*var brandpic1 = $("#input_brand1").val();
                if(brandpic1 == ""){
                    $("#warning2Body").text(buildErrorMessage("","必须上传logo图片，尺寸必须是180*120！"));
                    $("#warning2").show();
                    return;
                }

                var brandpic2 = $("#input_brand2").val();
                if(brandpic2 == ""){
                    $("#warning2Body").text(buildErrorMessage("","必须上传banner图片，尺寸必须是790*316！"));
                    $("#warning2").show();
                    return;
                }*/

                LA.sysCode = '10';
                var sessionId = '<%=request.getSession().getId() %>';
                LA.log('brand.addBrandGroup', '添加集团品牌：' + $("#theForm").serialize(), getCookieValue("username"),  sessionId);

				$.ajax({
			        type:"post",
			        contentType: "application/x-www-form-urlencoded;charset=utf-8",
			        dataType: "json",
			        ajaxStart: function() {
				       	 $("#loading-container").attr("class","loading-container");
				        },
			        ajaxStop: function() {
			          //隐藏加载提示
			          setTimeout(function() {
			       	        $("#loading-container").addClass("loading-inactive");
			       	 },300);
			        },
			        url: __ctxPath + "/brandDisplay/addBrandGroup",
			        data: $("#theForm").serialize(),
			        success: function(response) {
			        	if(response.success == 'true'){
							$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
		  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			        	}else if(response.data.errorMsg != ""){
							$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					        $("#warning2").show();
						}
		        	}
				});
			},
			fields : {
				brandName : {
					validators : {
						notEmpty : {
							message : '品牌名称不能为空'
						}
					}
				},
				spell:{
					validators : {
						regexp: {
	                        regexp: /^[A-Za-z0-9\s]{1,20}$/,
	                        message: '必须由数字或字母或空格20位组成'
	                    }
					}
				},
				brandNameEn:{
					validators : {
						regexp: {
	                        regexp: /^[^\u3000-\u303F\u4E00-\u9FA5\uFF00-\uFFEF]{1,20}$/,
	                        message: '必须由数字或字母或空格或标点符号20位组成'
	                    }
					}
				},
				brandNameSecond:{
					validators : {
						regexp: {
	                        regexp: /^[0-9\s\u4E00-\u9FA5]{1,20}$/,
	                        message: '必须由数字或中文或空格20位组成'
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

         $("#brandDesc").keyup(function(){
             var brandDesc = $("#brandDesc").val().trim();
             if(brandDesc.length > 500 || brandDesc == ""){
                $("#brandDescSmall").css("display","block");
                $("#save").attr("disabled","disabled");
             }else {
                 $("#brandDescSmall").css("display","none");
                 $("#save").removeAttr("disabled","disabled");
             }
         });
		
  		$("#close").click(function(){
  			t = 0;
  			$("#pageBody").load(__ctxPath+"/jsp/Brand/BrandView.jsp");
  		});

         $("#save").click(function(){
             var brandDesc = $("#brandDesc").val().trim();
             if(brandDesc.length > 500 || brandDesc == ""){
                 $("#brandDescSmall").css("display","block");
                 $("#save").attr("disabled","disabled");
                 return;
             }else {
                 $("#brandDescSmall").css("display","none");
                 $("#save").removeAttr("disabled","disabled");
             }
         });
	}); 
	 
	function show(i){
		$("#brandimg"+i).click();
	}
	 
  	function successBtn(){
  		t = 0;
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
		$("#pageBody").load(__ctxPath+"/jsp/Brand/BrandView.jsp");
	}
  	
  	/*图片上传*/
  	function upLoadImg(param){
  		$("#msg"+param).addClass('hide');
  		$("#msg"+param).html("");
  		$("#input_brand"+param).val("");
  		 /* var obj = {
                 "param1": '参数1',
                 "param2": ''
             }; */
  		 $.ajaxFileUpload({
  	         url:__ctxPath+"/upImg/uploadBrand-noMulti",
  	         type: "POST",
  	         secureuri: true,
  	         fileElementId: 'brandimg'+param,
  	         //data: obj,
  	         //textareas:'',
  	         dataType: "json",
  	         success: function (data) {
  	        	 var str = "";
  	             if(data.success=="true"){
  	            	str = "<img src='"+data.url+"' height='60px' width='60px' />";
  	            	$("#input_brand"+param).val(data.data);
  	            	$("#showImgNameA"+param).text($("#brandimg"+param).val());
  	             }else{
  	            	$("#warning2Body").text(data.data);
					$("#warning2").show();
					$("#showImgNameA"+param).text("未选择图片");
  	            	//str = "<span class='img_error'>"+data.data+"</span>";
  	            	$("#input_brand"+param).val("");
  	           	 }
  	             $("#msg"+param).html(str);
  	             $("#msg"+param).removeClass('hide');
  	         },
	  		error: function (data, status, e)//服务器响应失败处理函数
	        {
	  			 $("#msg"+param).html("<span class='img_error'>系统错误，上传失败</span>");
	  			 $("#msg"+param).removeClass('hide');
	  			 $("#input_brand"+param).val("");
	        }
  	     });
  		
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
								<span class="widget-caption">添加集团品牌</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
									<input type="hidden" name="userName" value=""/>
									<script type="text/javascript">$("input[name='userName']").val(getCookieValue("username"));</script>
									<input type="hidden" name="brandType" value="0"/>
									<input type="hidden" name="shopType" value="0"/>
									<input type="hidden" name="shopSid" value="-1"/>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">品牌名称：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<input type="text" maxlength="20" oninput="value=value.replace(/[<>]/g,'');" class="form-control" id="brandName" name="brandName" placeholder="必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">中文拼音：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<input type="text" class="form-control" id="spell" name="spell" placeholder="非必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">中文名称：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<input type="text" class="form-control" id="brandNameSecond" name="brandNameSecond" placeholder="非必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">英文名称：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<input type="text" class="form-control" id="brandNameEn" name="brandNameEn" placeholder="非必填"/>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">logo图片：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<input onchange="upLoadImg('1')" type="file" id="brandimg1" name="brandimg1" accept=".jpg,.gif,.png"/>
												<a class="showImgNameA" id="showImgNameA1" href="javascript:show(1);">未选择图片</a>
												<input type="hidden" id="input_brand1" name="brandpic1">
												<div id="msg1" class="hide"></div>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">banner图片：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<input onchange="upLoadImg('2')" type="file" id="brandimg2" name="brandimg2" accept=".jpg,.gif,.png"/>
												<a class="showImgNameA" id="showImgNameA2" href="javascript:show(2);">未选择图片</a>
												<input type="hidden" id="input_brand2" name="brandpic2">											
												<div id="msg2" class="hide"></div>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">是否展示：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<div class="radio">
													<label>
														<input class="basic" type="radio" checked="checked" name="isDisplay" value="0">
														<span class="text">是</span>
													</label>
													<label>
														<input class="basic" type="radio" name="isDisplay" value="1">
														<span class="text">否</span>
													</label>
												</div>
												<div class="radio" style="display: none;">
													<label>
														<input class="inverted" type="radio" name="isDisplay">
														<span class="text"></span>
													</label>
												</div>
											</div>											
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 col-sm-3 col-xs-3 control-label">品牌描述：</label>
											<div class="col-lg-6 col-sm-6 col-xs-6">
												<textarea style="width: 500px;height: 240px;max-width: 500px;max-height: 240px;min-width: 200px;min-height: 100px;resize: none" id="brandDesc" name="brandDesc" placeholder="必填"></textarea>
                                                <small style="display: none;color: #e46f61;" class="help-block" id="brandDescSmall">描述不能为空且不能超过500字</small>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save" type="submit" >保存</button>&emsp;&emsp;
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