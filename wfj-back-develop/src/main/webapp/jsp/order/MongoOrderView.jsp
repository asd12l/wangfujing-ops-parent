<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<script
	src="${ctx}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
<script src="${ctx}/js/pagination/msgbox/msgbox.js">  </script>
<script src="${ctx}/js/pagination/jTemplates/jquery-jtemplates.js">   </script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/pagination/myPagination/page.css" />
<!--Bootstrap Date Range Picker-->
<script src="${ctx}/assets/js/datetime/moment.js"></script>
<script src="${ctx}/assets/js/datetime/daterangepicker.js"></script>
<style type="text/css">
.trClick>td,.trClick>th {
	color: red;
}
</style>
<script type="text/javascript">
		__ctxPath = "${ctx}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	var logUrl = '';
	var username = '';
	$(function(){
		$("#pro102").hide();
		
		//LA埋点
		$.ajax({
			url : __ctxPath + "/omsOrder/buriedPoint",
			type : "post",
			dataType : "json",
			success : function(response){
				logUrl = response.logUrl;
				username - response.username;
				reloadjs();
			}
		});
		
		
	});
	//引用埋点js方法
	function reloadjs(){
		var head= document.getElementsByTagName('head')[0]; 
		var script= document.createElement('script'); 
		script.type= 'text/javascript'; 
		script.onload = script.onreadystatechange = function() { 
		if (!this.readyState || this.readyState === "loaded" || this.readyState === "complete" ) { 
		/* help(); */ 
		// Handle memory leak in IE 
		script.onload = script.onreadystatechange = null; 
		} }; 
		script.src= logUrl; 
		head.appendChild(script);
		console.log(script);
	} 
	function fundOrder(){
		LA.env = 'dev';
// 		LA.sysCode = '47';
		var sessionId = '<%=request.getSession().getId()%>';
		LA.log('search', '订单Mongo查询', userName,  sessionId);
		$("#pro102").show();
		var d = $("#theForm111").serialize();
		var url = __ctxPath + "/omsOrder/foundMongoOrder";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: d,
			success: function(response) {
				if(response.success=='true'){
					$("#fundRefundInput").html(JSON.stringify(response));
				}else{
					$("#fundRefundInput").html(JSON.stringify(response));
				}
				return;
			}
		});
	}
	function fixOrder(){
		var d = $("#theForm111").serialize();
		var url = __ctxPath + "/omsOrder/fixMongoOrder";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: d,
			success: function(response) {
				if (response.success == 'true') {
					$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>修复成功，返回列表页!</strong></div>");
					$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
				} else if (response.data.errorMsg != "") {
					$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					$("#warning2").show();
				}
			}
		});
	}
	//折叠页面
	function tab(data){
		if($("#"+data+"-i").attr("class")=="fa fa-minus"){
			$("#"+data+"-i").attr("class","fa fa-plus");
			$("#"+data).css({"display":"none"});
		}else if(data=='pro'){
			$("#"+data+"-i").attr("class","fa fa-minus");
			$("#"+data).css({"display":"block"});
		}else{
			$("#"+data+"-i").attr("class","fa fa-minus");
			$("#"+data).css({"display":"block"});
			$("#"+data).parent().siblings().find(".widget-body").css({"display":"none"});
			$("#"+data).parent().siblings().find(".fa-minus").attr("class","fa fa-plus");
		}
	}
	
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
//		$("#pageBody").load(__ctxPath+"/jsp/order/OrderListView.jsp");
	}
	</script>
</head>
<body>
	<input type="hidden" id="ctxPath" value="${ctx}" />
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="widget-header ">
					<h5 class="widget-caption">订单缓存信息管理</h5>
					<div class="widget-buttons">
						<a href="#" data-toggle="maximize"></a> <a href="#"
							data-toggle="collapse" onclick="tab('pro');"> <i
							class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
							data-toggle="dispose"></a>
					</div>
				</div>
	<div class="widget-body" id="pro">
				<form id="theForm111" method="post" class="form-horizontal">
					<div class="tabbable">
						<div class="tab-content">
							<div id="home" class="tab-pane in active"
								style="height: 400px; overflow: scroll;">
								<div class="col-md-4">
									<label class="col-md-5 control-label"><font color="red">*</font>订单号：</label>
									<div class="col-md-7">
										<input type="text" class="form-control" id="orderNo"
											name="orderNo" />
									</div>
									&nbsp;
								</div>
								<div class="form-group">
									<div class="col-lg-6">
										<input class="btn btn-success" style="width: 25%;" id="save12"
											onclick="fundOrder()" type="button" value="查询" />&emsp;&emsp;
										<input class="btn btn-success" style="width: 25%;" id="fixBug"
											onclick="fixOrder()" type="button" value="修复" />&emsp;&emsp;
									</div>
									&nbsp;
								</div>
								<!-- 隐藏框 -->
								<div class="col-xs-12 col-md-12" id="hid">
									<div class="widget-body" id="pro102">
										<div
											style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
											id="fundRefundInput"></div>

									</div>
									&nbsp;
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			</div>
		</div>
	</div>
</body>
</html>