<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
    	String tid = request.getParameter("tid");
	%>
<!--Page Related Scripts-->
<html>
<head>
<!--Jquery Select2-->
<script
	src="${pageContext.request.contextPath}/assets/js/select2/select2.js"></script>
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
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";
	var stockPagination;
	
	$(function() { 
		var tid = "<%=tid%>";
		initOlv(tid);
	});
	
	//初始化包装单位列表
 	function initOlv(tid) {
		var url = __ctxPath+"/ediHlmOrder/selectHlmOrderItemList?tid="+tid;
		stockPagination = $("#stockPagination").myPagination(
		{
			 panel: {
	             tipInfo_on: true,
	             tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
	             tipInfo_css: {
	               width: '25px',
	               height: "20px",
	               border: "2px solid #f0f0f0",
	               padding: "0 0 0 5px",
	               margin: "0 5px 0 5px",
	               color: "#48b9ef"
	             }
	           },
	           debug: false,
	           ajax: {
	             on: true,
	             url: url,
	             dataType: 'json',
	             data: $("#stock_form").serialize(),
	             ajaxStart: function() {
	               ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
	             },
	             ajaxStop: function() {
	               //隐藏加载提示
	               setTimeout(function() {
	                 ZENG.msgbox.hide();
	               }, 300);
	             },
	             callback: function(data) {
	            	// alert($("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data));
	           		 $("#stock_tab tbody").setTemplateElement("stock-list").processTemplate(data);
	             }
	           }
	         });
    }
	
 	//保存数据
  	function save(){
 		var oidT=document.getElementsByName("oid");
 		var salecodeT=document.getElementsByName("outerSkuId");
 		/* alert(oidT);
 		alert(salecodeT);
 		return; */
 		var oids = '', salecodes = '';
 	    for(var i = 0; i< oidT.length; i++)
 		{
 	    	if(i !=0 )
 			{
 	        	oids += "," + oidT[i].value ;
 			}else
 			{
 				oids +=  oidT[i].value ;
 			}
 		}
 	    for(var i = 0; i< salecodeT.length; i++)
 		{
 	    	var salecodeV =  salecodeT[i].value;
 	    	if(i !=0 )
 			{
 	    		salecodes += "," + salecodeV;
 	    	}else
 			{
 	    		salecodes += salecodeV;
 			}
 		}
 	   	$("#tid_form").val($("#tid").val());
 	   	$("#oid_form").val(oids);
 	  	$("#outerSkuId_form").val(salecodes);
  		$.ajax({
	        type:"post",
	        dataType: "json",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/ediOkbuyOrder/updatechild",
	        async : false,
			ajaxStart : function() {
				$("#loading-container").prop("class",
						"loading-container");
			},
			ajaxStop : function() {
				$("#loading-container").addClass("loading-inactive");
			},
	        data: $("#stock_form").serialize(),
	        success : function(data) {
				if (data == true) {
					/* $("#modal-body-success")
							.html(
									"<div class='alert alert-success fade in'><strong>异常订单修改成功</strong></div>");
					$("#modal-success").attr({
						"style" : "display:block;z-index:9999;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					}); */
					alert("修改成功");	
					retException();
	  				back();
				} else {
					$("#oid_form").val("");
			 	  	$("#outerSkuId_form").val("");
					alert("该商品没有关联关系，请确保存在关联关系");
					/* alert(response);
					$("#warning2Body").text(response);
					$("#warning2").show(); */
				}
				retException();
	        },
	        error : function() {
				$("#warning2Body").text("系统出错");
				$("#warning2").show();
				retException();
			}
		});
  	} 
	
	function retException(){
		var url = __ctxPath + "/jsp/edi/HLM/orderabnormal.jsp";
		$("#pageBody").load(url);
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
</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<!-- Main Container -->
	<div class="main-container container-fluid" id="btDiv3">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">好乐买行项目修改</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
																		
								<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="stock_tab">
                                       <thead class="flip-content bordered-darkorange">
										<tr role="row">
												<th style="text-align: center;">行项目编号</th>
												<!-- oid -->
												<th style="text-align: center;">商品编号</th>
												<th style="text-align: center;">商品名称</th>
												<!--title -->
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="stock_form" action="">
										<div class="col-lg-12">
	                                        	<!-- <select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option >10</option>
													<option selected="selected">15</option>
													<option>20</option>
												</select> -->
											</div>&nbsp; 
										 	<input type="hidden" id="tid_form" name="tid" />
									 		<input type="hidden" id="oid_form" name="oid" />
									  		<input type="hidden" id="outerSkuId_form" name="outerSkuId" />
									  		<input type="hidden" id="subStock_form" name="subStock" />
									</form>
								</div>
								<div id="stockPagination1"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="stock-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<input align="center" id="oid" name="oid" type="hidden" value="{$T.Result.oid}"/>
													<input align="center" id="tid" name="tid" type="hidden" value="{$T.Result.tid}"/>
													<td align="center" id="oid">{$T.Result.oid}</td>
													<td align="center" id="unitCode_{$T.Result.sid}"><input id="outerSkuId" name="outerSkuId" value="{$T.Result.outerSkuId}" type="text" /></td>
													<td align="center" id="unitName_{$T.Result.sid}">{$T.Result.title}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	
									</textarea>
							</p>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" onclick="save()" type="submit">保存</button>&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消" onclick="retException()" />
										</div>
									</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /Page Body -->
		</div>
		<!-- /Page Content -->
	</div>
	<!-- /Page Container -->
	<!-- Main Container -->
	</div>
</body>
</html>