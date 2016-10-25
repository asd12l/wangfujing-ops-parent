<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script	src="${pageContext.request.contextPath}/assets/js/select2/selectAjax.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/selectAjax.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<style type="text/css">
.demo{width:800px; margin:50px auto}
.select_side{float:left; width:200px;}
select{width:300px; height:120px}
.select_opt{float:left; width:40px; height:100%; margin-top:36px; margin-left:120px; margin-right:10px; margin-bottom:15px}
.select_opt p{width:26px; height:26px; margin-top:6px; background:url(images/arr.gif) no-repeat; cursor:pointer; text-indent:-999em}
.select_opt p#toright{background-position:2px 0}
.select_opt p#toleft{background-position:2px -22px}
.sub_btn{clear:both; height:42px; line-height:42px; padding-top:10px; text-align:center}
</style>
<script type="text/javascript">
$(function(){
	//集团品牌
	var parentSid = $("#BrandCode");
	/* $.ajax({
		type: "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url: __ctxPath+"/brandDisplay/queryBrandGroupList",
		dataType: "json",
		data: "brandType=0",
		async: false,
		success: function(response) {
			var result = response.list;
			parentSid.html("<option value='-1'>请选择</option>");
			for ( var i = 0; i < result.length; i++) {
				var ele = result[i];
				var option = "";
				if(sid_ == ele.sid){
					option = $("<option selected='selected' value='" + ele.sid + "'>"
							+ ele.brandName + "</option>");
				}else{
					option = $("<option value='" + ele.sid + "'>"
							+ ele.brandName + "</option>");
				}
				option.appendTo(parentSid);
			}
			return;
		}
	}); */
	$("#BrandCode_input").keyup(function(e){
		var e = e || event;
		var code = e.keyCode;
		if(code != 32 && !(code >=37 && code <= 40) && !(code >=16 && code <= 18) && code != 93){
			seachData($("#BrandCode_input").val());
		}
	});
	
	inselect();
	
	 	var leftSel = $("#selectL");
		var rightSel = $("#selectR");
		$("#toright").bind("click",function(){		
			leftSel.find("option:selected").each(function(){
				$(this).remove().appendTo(rightSel);
			});
		});
		$("#toleft").bind("click",function(){		
			rightSel.find("option:selected").each(function(){
				$(this).remove().appendTo(leftSel);
			});
		});
		leftSel.dblclick(function(){
			$(this).find("option:selected").each(function(){
				$(this).remove().appendTo(rightSel);
			});
		});
		rightSel.dblclick(function(){
			$(this).find("option:selected").each(function(){
				$(this).remove().appendTo(leftSel);
			});
		});
		$("#sub").click(function(){
			var selVal = [];
			rightSel.find("option").each(function(){
				selVal.push(this.value);
			});
			selVals = selVal.join(",");
			//selVals = rightSel.val();
			if(selVals==""){
				alert("没有选择任何项！");
			}else{
				alert(selVals);
			}
		});
		$("#save").click(function(){
			if(parentSid.val()==-1){
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选择集团品牌!</strong></div>");
				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}else{
	  			saveFrom();
			}
  		});
		
		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/BrandRelation/BrandRelationView.jsp");
  		});
		
});
function inselect(){
	//没有集团品牌的门店品牌
	var selectR = $("#selectR");
	$("#selectL").empty();
	$.ajax({
		type: "post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url: __ctxPath+"/brandRelationDisplay/queryShopBrandNoParent",
		dataType: "json",
//		data: "brandType=1", 
		async: false,
		success: function(response) {
			if(response.list!=null){
				var result = response.list;
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.sid + "'>"
							+ ele.brandName + "</option>");
					option.appendTo(selectL);
				}
			}
			return;
		}
	});
}
	//点击下拉框触发改选框变更
	//集团品牌下所有的门店品牌
	function classifyTwo(sid){
		inselect();
		var sid = $("#BrandCode").val();
		$("#selectR").find("option").remove();
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/brandRelationDisplay/queryShopBrand",
			dataType: "json",
			ajaxStart: function() {
		       	 $("#loading-container").attr("class","loading-container");
		        },
	        ajaxStop: function() {
	          //隐藏加载提示
	          setTimeout(function() {
	       	        $("#loading-container").addClass("loading-inactive")
	       	 },300);
	        },
			data: "sid="+sid,
			async: false,
			success: function(response) {
				if(response.success!="false"){
					var result = response.list;
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						if(ele.status==0){
							var option = $("<option value='" + ele.sid + "'>"
									+ ele.brandName + "</option>");
							option.appendTo(selectR);
						}
					}
				}else{
					return;
				}
			}
		});
	}
	
  	function saveFrom(){
  		if($("#organizationName").val() == "" || $("#organizationCode").val() == ""){
  			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>集团必填缺失!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
  		}else{
  			var selectR = new Array();
  			$("#selectR").find("option").each(function(){
  				selectR.push($(this).val());
  			});
  			if (selectR.length == 0) {
  				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选择门店品牌！</strong></div>");
	     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
	     	  	return;
			}
  			$("#selectRHidden").val(selectR);

            LA.sysCode = '10';
            var sessionId = '<%=request.getSession().getId() %>';
            LA.log('brand.addBrandRelation', '添加门店品牌与集团品牌的关系：' + $("#theForm").serialize(), getCookieValue("username"),  sessionId);

  			var url = __ctxPath + "/brandRelationDisplay/addBrandRelation";
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
					}else if(response.data.msg!=""){
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>" + response.data.msg + "</strong></div>");
	 	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					}
					return;
				},
				/* error: function() {
					$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
	 	  				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
				} */
				error: function(XMLHttpRequest, textStatus) {		      
					var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
					if(sstatus != "sessionOut"){
						$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
	 	  				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
					}
					if(sstatus=="sessionOut"){     
		            	 $("#warning3").css('display','block');     
		             }
				}
			});
  		}
  	} 
  	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({
					"display" : "none"
				});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({
					"display" : "block"
				});
			}
		}
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
								<span class="widget-caption">添加品牌关联</span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" name="userName" value=""/>
									<script type="text/javascript">$("input[name='userName']").val(getCookieValue("username"));</script>
									<input type="hidden" name="organizationType" value="0"/>
									<input type="hidden" name="createName" value=""/>
									<script type="text/javascript">$("input[name='createName']").val(getCookieValue("username"));</script>
									<input type="hidden" id="selectRHidden" name="selectR" value=""/>
									<div class="form-group">
										<label class="col-lg-3 control-label">集团品牌名称：</label>
										<div class="col-lg-6">
											<!-- <select class="form-control" id="parentSid" name="parentSid"></select> -->
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
							
								<div id="main">
  
								  <div class="demo">
								     <div class="select_side">
								     	<p>待选门店品牌</p>
								     	<select id="selectL" name="selectL" multiple="multiple">
								     	</select>
								     </div>
								     <div class="select_opt">
								        <p id="toright" title="添加">&gt;</p>
								        <p id="toleft" title="移除">&lt;</p>
								     </div>
								     <div class="select_side">
								     	<p>选中的门店品牌</p>
								     	<select id="selectR" multiple="multiple">
								     	</select>
								     </div>
								   <!--   <div class="sub_btn"><input type="button" id="sub" value="getValue" /></div> -->
								 	&nbsp;&nbsp;&nbsp;&nbsp;
								  </div>
								  &nbsp;&nbsp;&nbsp;&nbsp;
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