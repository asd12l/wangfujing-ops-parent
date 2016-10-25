<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script	src="${ctx}/assets/js/select2/select2.js"></script>
<script src="${ctx}/js/ajaxfileupload.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js">
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script	src="${pageContext.request.contextPath}/assets/js/select2/selectAjax.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/selectAjax.css" />
<style type="text/css">
.img_error{color: #e46f61; font-size: 85%;}
.hide{display: none;}
.showImgNameA,.showImgNameA:hover {background-color: #fbfbfb;float:left;top:0;color:black;
				width:135px;height:25px;line-height: 25px;text-decoration:none;
				margin-left:65px;position: absolute;}
</style>
<title>商品基本信息</title>
<!-- <script type="text/javascript">
	function showBrandGroup(){
		$("#pageBodyBrandGroup").load(__ctxPath + "/jsp/product/selectBrand.jsp");
		$("#selectBrandGroup").show();
	}
	function closeBrandGroup(){
		$("#selectBrandGroup").hide();
	}
</script> -->
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function(){
		
		$("#sid").val(value);
		$("#brandSid").val(brandSid_);
		$("#status").val(status_);
		$("#BrandCode").html("<option value='"+parentSid_+"'>parentName_</option>");
		$("#BrandCode_input").val(parentName_);
		$("#shopSid").val(shopSid_);
		$("#shopSidInput").val(shopSid_);
		$("#brandName").val(brandName_);
		$("#brandType").val(brandType_);
		$("#spell").val(spell_);
		$("#brandNameSecond").val(brandNameSecond_);
		$("#brandNameEn").val(brandNameEn_);
		$("#brandcorp").val(brandcorp_);
		$("#brandSpecialty").val(brandSpecialty_);
		$("#brandSuitability").val(brandSuitability_);
		$("#shopType").val(shopType_);
        if(brandpic1_ != "" && brandpic1_ != '[object Object]') {
            $("#input_brand1").val(brandpic1_);
        }
        if(brandpic1_ != "" && brandpic1_ != '[object Object]'){
			 $("#msg1").html("<img src='"+brandUrl+brandpic1_+"' height='60px' width='60px' />");
			 $("#showImgNameA1").text(brandpic1_);
		} else {
			$("#showImgNameA1").text("未选择图片");
		}
        if(brandpic2_ != "" && brandpic2_ != '[object Object]') {
            $("#input_brand2").val(brandpic2_);
        }
        if(brandpic2_ != "" && brandpic2_ != '[object Object]') {
			 $("#msg2").html("<img src='"+brandUrl+brandpic2_+"' height='60px' width='60px' />");
			 $("#showImgNameA2").text(brandpic2_);
		} else {
			$("#showImgNameA2").text("未选择图片");
		}
		if(isDisplay_ == 1){
			$("#isDisplay2").attr("checked","checked");
		}else{
			$("#isDisplay1").attr("checked","checked");
		}
		$("#status").val(status_);
		$("#brandDesc").val(brandDesc_);
		
		//查询集团品牌
		/* $.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/brandDisplay/queryBrandGroupList",
			dataType: "json",
			async: false,
			data: "brandType=0", 
			success: function(response) {
				var result = response.list;
				var parentSid = $("#parentSid");
				parentSid.html("<option value=''>请选择</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option;
					if(parentSid_ == ele.sid){
						option = $("<option selected='selected' value='" + ele.sid + "'>" + ele.brandName + "</option>");
					}else{
						option = $("<option value='" + ele.sid + "'>" + ele.brandName + "</option>");
					}
					option.appendTo(parentSid);
				}
				return;
			},
			error: function() {
			    $("#warning2Body").text("系统出错");
				$("#warning2").show();
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
		}); */
		$("#BrandCode_input").keyup(function(e){
			var e = e || event;
			var code = e.keyCode;
			if(code != 32 && !(code >=37 && code <= 40) && !(code >=16 && code <= 18) && code != 93){
				seachData($("#BrandCode_input").val());
			}
		});
		/* $("#BrandCode").select2(); */
		
		$('#theForm').bootstrapValidator({
			message : '无效的值！',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			submitHandler : function(validator, form, submitButton) {
				// Do nothing
				var parentSid = $("#BrandCode").val();
				if (parentSid == "") {
					$("#warning2Body").text(buildErrorMessage("","请选择集团品牌！"));
			        $("#warning2").show();
					return;
				}

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

				$("#shopTypeHidden").val($("#shopType").val());

                LA.sysCode = '10';
                var sessionId = '<%=request.getSession().getId() %>';
                LA.log('brand.modifyBrandGroup', '修改门店品牌：' + $("#theForm").serialize(), getCookieValue("username"),  sessionId);

		  		$.ajax({
			        type:"post",
			        dataType: "json",
			        contentType: "application/x-www-form-urlencoded;charset=utf-8",
			        url:__ctxPath + "/brandDisplay/modifyBrandGroup",
			        data: $("#theForm").serialize(),
			        success:function(response) {
			        	if(response.success == 'true'){
							$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>修改成功，返回列表页!</strong></div>");
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
	                        regexp: /^[A-Za-z0-9\s]+$/,
	                        message: '必须由数字或字母或空格组成'
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
	                        regexp: /^[0-9\s\u4E00-\u9FA5]+$/,
	                        message: '必须由数字或中文或空格组成'
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
  			t = 1;
  			$("#pageBody").load(__ctxPath+"/jsp/Brand/BrandView.jsp");
  		});
	});
  	
	function show(i){
		$("#brandimg"+i).click();
	}
	
  	function successBtn(){
  		t = 1;
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
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
	  			 $("#msg"+param).html("<span>系统错误，上传失败</span>");
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
								<span class="widget-caption">修改门店品牌</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">   
									<input type="hidden" id="sid" name="sid"/>
									<input type="hidden" id="brandType" name="brandType" value="1"/>
									<input type="hidden" id="shopSidInput" name="shopSidInput"/>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">品牌名称</label>
											<div class="col-lg-6">
												<input type="text" maxlength="20" class="form-control" id="brandName" name="brandName" readonly="readonly" placeholder="必填"/>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">品牌编码</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="brandSid" name="brandSid" readonly="readonly" placeholder="必填"/>
											</div>
										</div>
									</div>
									<!-- <div class="form-group">
										<label class="col-lg-3 control-label">机构类别：</label>
										<div class="col-lg-6">
											<select class="form-control" id="brandType" name="brandType">
												<option value="0" selected="selected">集团品牌</option>
												<option value="1">门店品牌</option>
											</select>
										</div>
									</div> -->
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">中文拼音</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="spell" name="spell" placeholder="非必填"/>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">中文名称</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="brandNameSecond" name="brandNameSecond" placeholder="非必填"/>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">英文名</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="brandNameEn" name="brandNameEn" placeholder="非必填"/>
											</div>
										</div>
									</div>
									<!-- <div class="form-group">
										<label class="col-lg-3 control-label">门店名称：</label>
										<div class="col-lg-6">
											<select class="form-control" id="shopSid" name="shopSid" disabled="disabled" data-bv-field="country">
											</select><i class="form-control-feedback" data-bv-field="country"></i>
										</div>
									</div> -->
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">门店类型：</label>
											<div class="col-lg-6">
												<input type="hidden" name="shopType" id="shopTypeHidden">
												<select class="form-control" id="shopType"  data-bv-field="country" disabled="disabled">
													<option value="0" selected="selected">北京</option>
													<option value="1">外埠</option>
													<option value="2">电商</option>
												</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">所属集团品牌：</label>
											<div class="col-lg-6">
												<!-- <select style="width: 100%" id="parentSid" name="parentSid"></select> -->
												<select id="BrandCode" name="parentSid"
													style="width: 100%;display: none;">
													<option value="" sid="">请选择</option>	
												</select>
												<input id="BrandCode_input" class="_input" type="text"
													   value="" placeholder="请输入集团品牌" autocomplete="off">
												<div id="dataList_hidden" class="_hiddenDiv" style="width:91%;">
													<ul></ul>
												</div>
											</div>
										</div>
									</div>
									<!-- <div class="form-group">
										<label class="col-lg-3 control-label">品牌公司</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="brandcorp" name="brandcorp" placeholder="非必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">品牌特点</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="brandSpecialty" name="brandSpecialty" placeholder="非必填"/>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">适合人群</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="brandSuitability" name="brandSuitability" placeholder="非必填"/>
										</div>
									</div> -->
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">logo图片</label>
											<div class="col-lg-6">
												<input onchange="upLoadImg('1')" type="file" id="brandimg1"  name="brandimg1" accept=".jpg,.gif,.png"/>
												<a class="showImgNameA" id="showImgNameA1" href="javascript:show(1);"></a>
												<input type="hidden"  id="input_brand1"  name="brandpic1">
												<div id="msg1"></div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">banner图片</label>
											<div class="col-lg-6">
												<input onchange="upLoadImg('2')" type="file" id="brandimg2" name="brandimg2" accept=".jpg,.gif,.png"/>
												<a class="showImgNameA" id="showImgNameA2" href="javascript:show(2);"></a>
												<input type="hidden" id="input_brand2" name="brandpic2">											
												<div id="msg2" ></div>
											</div>
										</div>
									</div>
        							<div class="form-group">
        								<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">是否展示</label>
											<div class="col-lg-6">
												<div class="radio">
													<label>
														<input class="basic" type="radio" id="isDisplay1" name="isDisplay" value="0">
														<span class="text">是</span>
													</label>
													<label>
														<input class="basic" type="radio" id="isDisplay2" name="isDisplay" value="1">
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
        							<!-- <div class="form-group">
										<label class="col-lg-3 control-label">是否有效</label>
										<div class="col-lg-6">
											<div class="radio">
												<label>
													<input class="inverted" type="radio" checked="checked" name="status" value="0">
													<span class="text">是</span>
												</label>
												<label>
													<input class="basic" type="radio" name="status" value="1">
													<span class="text">否</span>
												</label>
											</div>
											<div class="radio" style="display: none;">
												<label>
													<input class="inverted" type="radio" name="status">
													<span class="text"></span>
												</label>
											</div>
										</div>
        							</div> -->
        							<div class="form-group">
        								<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
											<label class="col-lg-3 control-label">品牌描述</label>
											<div class="col-lg-2">
												<textarea style="width: 500px;height: 240px;max-width: 500px;max-height: 240px;min-width: 200px;min-height: 100px;" id="brandDesc" name="brandDesc" placeholder="必填"></textarea>
                                                <small style="display: none;color: #e46f61;" class="help-block" id="brandDescSmall">描述不能为空且不能超过500字</small>
											</div>
										</div>
        							</div>
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" id="save" type="submit">保存</button>&emsp;&emsp;
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
	<!-- <div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;z-index: 9999"
		id="selectBrandGroup">
		<div class="modal-dialog"
			style="width: 600px; height: auto; margin: 50px auto;">
			<div class="modal-content" style="width: 600px;">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBrandGroup();">×</button>
					<h4 class="modal-title" id="divTitle">请双击选择集团品牌</h4>
				</div>
				<div class="page-body" id="pageBodyBrandGroup"></div>
			</div>
		</div>
	</div> -->
</body>
</html>