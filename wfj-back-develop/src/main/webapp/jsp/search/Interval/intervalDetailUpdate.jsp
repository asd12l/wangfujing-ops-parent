<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
  		$("#save").click(function(){
  			var lower_limit=$("#lower_limit").val();
  			var upper_limit=$("#upper_limit").val();
  			var order_by=$("#order_by").val();
  			if(Check1(lower_limit)&&Check1(upper_limit)&&Check2(order_by)){
  				if(Check3(lower_limit)&&Check3(upper_limit)){
  					if(upper_limit >= lower_limit){
  						saveFrom();
  					}else{
  						alert("上限必须大于等于下限");
  						return;
  					}
  				}
  				saveFrom();
  			}else{
  				
  				return;
  			}
  			saveFrom();
  		});
  		$("#close").click(function(){
  			var contentSid = $("#contentSid1").val();
  			$("#pageBody").load(__ctxPath+"/jsp/search/Interval/showIntervalDetail.jsp"+"?contentSid="+contentSid);
  		});
	});
	
	function Check1(limit) {
		 var filter  =  /[\d\*]/g ;
		 if (filter.test(limit)) return true;
		 else {
		 alert('上限或下限只能输入数字或*');
		 return false;}
		}
	function Check2(order) {
		 var filter  = /[\d]/g;
		 if (filter.test(order)) return true;
		 else {
		 alert('顺序只能是数字');
		 return false;}
		}
	function Check3(order) {
		 var filter  = /[\d]/g;
		 if (filter.test(order)) return true;
		 else {
		 return false;}
		}
	
  	//保存数据
  	function saveFrom(){
  		$.ajax({
  			 type:"post",
 	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
 	        url:__ctxPath + "/back/intervalDetailUpdate",
 	        dataType: "json",
 	        data: $("#theForm").serialize(),

	        success:function(response) {
	        	if(response.success == true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>修改成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
        	}
		});
  	}
  	function successBtn(){
  		var contentSid = $("#contentSid1").val();
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/search/Interval/showIntervalDetail.jsp"+"?contentSid="+contentSid);
	}
	</script> 
</head>
<body>
<input type="hidden" id="contentSid1" value="${param.contentSid }"/>
	<div class="page-body">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">修改</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">   
									<input type="hidden" id="sid" name="sid" value="${param.sid }"/>
									<input type="hidden" class="form-control" id="contentSid" value="${param.contentSid }" name="contentSid" />
								
									<div class="form-group">
										<label class="col-lg-3 control-label">修改下限</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="lower_limit" value="${param.lower_limit }" name="lower_limit" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">修改上限</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="upper_limit" value="${param.upper_limit }" name="upper_limit" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">修改顺序</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="order_by" value="${param.order_by }" name="order_by" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">修改显示内容</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" id="show_text" value=<%=java.net.URLDecoder.decode((String)request.getParameter("show_text"), "UTF-8")%> name="show_text" />
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