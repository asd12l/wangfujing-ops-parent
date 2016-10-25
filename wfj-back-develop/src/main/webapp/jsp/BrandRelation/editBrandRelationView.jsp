<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--Jquery Select2-->
<script
	src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script	src="${pageContext.request.contextPath}/assets/js/select2/selectAjax.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/selectAjax.css" />
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var selectName= '';
	$(function(){
		$("#BrandCode").html("<option value='"+parentSid_+"' sid=''>"+brandFatherName_+"</option>");
		$("#BrandCode_input").val(brandFatherName_);
		$("#sid_").val(sid_);
		$("#brandName_").val(brandName_);
		var sid = $("#BrandCode");
		/* $.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/brandRelationDisplay/queryBrandGroup",
			dataType: "json",
			async:false,
			success: function(response) {
				var result = response;
				sid.html("<option value='-1'>请选择</option>");
				for ( var i = 0; i < result.list.length; i++) {
					var ele = result.list[i];
					var option;
					if(brandFatherName_ == ele.brandName){
						selectName = ele.brandName;
						option = $("<option selected='selected' value='" + ele.sid + "'>"
								+ ele.brandName + "</option>");
						option.appendTo(sid);
					}else{
						option = $("<option value='" + ele.sid + "'>"
								+ ele.brandName + "</option>");
						option.appendTo(sid);
					}
				}
				return;
			}
		});
		$("#sid").select2(); */
		$("#BrandCode_input").keyup(function(e){
			var e = e || event;
			var code = e.keyCode;
			if(code != 32 && !(code >=37 && code <= 40) && !(code >=16 && code <= 18) && code != 93){
				seachData($("#BrandCode_input").val());
			}
		});
		//$("#s2id_sid a span:gt(0)").html(selectName);
		//$(".select2-arrow b").html(<b></b>);
		$(".select2-arrow b").attr("style", "line-height: 2;");
  		$("#save").click(function(){
  			saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/BrandRelation/BrandRelationView.jsp");
  		});
	});
  	//保存数据
  	function saveFrom(){
        LA.sysCode = '10';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('brand.modifyBrandRelation', '修改门店品牌与集团品牌的关系：' + params, getCookieValue("username"),  sessionId);

		var url = __ctxPath + "/brandRelationDisplay/modifyBrandRelation";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: url,
			dataType:"json",
			data: $("#theForm").serialize(),
			success: function(response) {
				if(response.success == "true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>修改成功，返回列表页!</strong></div>");
 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else if(response.data.errorMsg != ""){
				    $("#warning2Body").text(response.data.errorMsg);
					$("#warning2").show();
				}
				return;
			}
		});
  		
  	}
  	
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/BrandRelation/BrandRelationView.jsp");
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
								<span class="widget-caption">修改品牌关联</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
									<div class="form-group">
										<label class="col-lg-3 control-label">门店品牌名称：</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="brandName_" name="brandName" disabled="disabled" placeholder="必填"/>
										</div>
									</div>
        
									<div class="form-group">
										<label class="col-lg-3 control-label">集团品牌名称：</label>
										<div class="col-lg-6">
											<!-- <select style="width:100%;" id="sid" name="parentSid"></select> -->
											<select id="BrandCode" name="parentSid"
												style="width: 100%;display: none;">
												<option value="" sid="">请选择</option>	
											</select>
											<input id="BrandCode_input" class="_input" type="text"
												   value="" placeholder="请输入集团品牌" autocomplete="off">
											<div id="dataList_hidden" class="_hiddenDiv" style="width:95%;">
												<ul></ul>
											</div>
										</div>
									</div>
									<input type="hidden" id="sid_" name="sid"/>
        
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