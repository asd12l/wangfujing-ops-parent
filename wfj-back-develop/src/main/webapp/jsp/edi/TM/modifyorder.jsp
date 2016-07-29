<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
    	String tid = request.getParameter("tid");
	%>
<!--Page Related Scripts-->
<html>
<head>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js">   </script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<!--Bootstrap Date Range Picker-->
<script
	src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
<style type="text/css">
.trClick>td, .trClick>th {
	color: red;
}
</style>
<script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var olvPagination;
	$(function() {
		var tid = "<%=tid%>";
		/* $.ajax({url:__ctxPath + "/DataDictionary/getItemType?dictTypeCode="+51,dataType:"json",async:false,success:function(response){
    		var result = response.list;
           	 var option = "<option value=''>所有</option>";
           	 for(var i=0;i<result.length;i++){
           		 var ele = result[i];
           		 option+="<option value='"+ele.dictItemCode+"'>"+ele.dictItemName+"</option>";
           	 }
           	 $("#shopName_select").append(option);
 		}}); */
		//$('#reservation').daterangepicker();
		initOlv(tid);
	});
	function olvQuery(){
		$("#tid_form").val($("#tid_input").val());
		$("#ordersId_form").val($("#ordersId_input").val());
		$("#receiverName_form").val($("#receiverName_input").val());
		$("#title_form").val($("#title_input").val());
		$("#status_form").val($("#status_select").val());
		var strTime = $("#startDate").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startDate_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endDate_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startDate_form").val("");
			$("#endDate_form").val("");
		}
        var params = $("#olv_form").serialize(); 
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function back(){
		var url = __ctxPath + "/jsp/edi/TM/orderabnormal.jsp";
		$("#pageBody").load(url);
	}
	
	function reset(){
		$("#orderNo_input").val("");
		$("#outOrderNo_input").val("");
		$("#orderStatus_select").val("");
		$("#payStatus_select").val("");
		$("#memberNo_input").val("");
		$("#reservation").val("");
		olvQuery();
	}
	// 导出excel
	function exportexcle(){
		$("#tid_form").val($("#tid_input").val());
		$("#ordersId_form").val($("#ordersId_input").val());
		$("#receiverName_form").val($("#receiverName_input").val());
		$("#title_form").val($("#title_input").val());
		$("#status_form").val($("#status_select").val());
		var strTime = $("#startDate").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startDate_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endDate_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startDate_form").val("");
			$("#endDate_form").val("");
		}
		var url = __ctxPath+"/ediOrder/exportExcle";
		olvPagination = $("#olvPagination").myPagination({
           panel: {
            // tipInfo_on: true,
            // tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
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
             data: $("#olv_form").serialize(),
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
           		// $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
		
	}
	
	
	//初始化包装单位列表
 	function initOlv(tid) {
		var url = __ctxPath+"/ediOrder/selectOrderItemList?tid="+tid;
		olvPagination = $("#olvPagination").myPagination({
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
             data: $("#olv_form").serialize(),
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
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
    }
	
 	
	function closeBtDiv(){
		$("#btDiv").hide();
	}
	
	//保存数据
  	function save(){
 		var oidT=document.getElementsByName("oid");
 		var salecodeT=document.getElementsByName("outerSkuId");
 		  
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

 	   $("#tid_form").val($("#tid").val()+"channel;C7");
 	   $("#oid_form").val(oids);
 	   $("#outerSkuId_form").val(salecodes);
  	
  		$.ajax({
	        type:"post",
	        dataType: "json",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/ediOrder/updatechild/",
	        data: $("#olv_form").serialize(),
	    
  		success: function(data){
  			
  			if(data==true){
  				alert("修改成功");	
  				back();
  			}else{
  				$("#oid_form").val("");
  		 	    $("#outerSkuId_form").val("");
  				alert("该商品没有关联关系，请确保存在关联关系");
  			}
  			
  		}
  		
		});
  	} 
	
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/OrderListView.jsp");
	}
	</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
								<div class="widget-header ">
								<h5 class="widget-caption">天猫行项目修改</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
									<form id="olv_form" action="">
										<input type="hidden" id="pageSelect" name="pageSize"	value="10" />
										 <input type="hidden" id="tid_form" name="tid" />
										<input type="hidden" id="oid_form" name="oid" />
										 <input type="hidden" id="outerSkuId_form" name="outerSkuId" />
									</form>
								<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="olv_tab">
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
													<option>10</option>
													<option selected="selected">15</option>
													<option>20</option>
												</select> -->
											</div>&nbsp; 
										 <input type="hidden" id="productSku_from" name="skuId" /> 
										 <input type="hidden" id="productCode_from" name="title" /> 
									</form>
								</div>
								<div id="stockPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="olv-list" rows="0" cols="0">
									{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
												<input align="center" id="oid" name="oid" type="hidden" value="{$T.Result.oid}"/>
												<input align="center" id="tid" name="tid" type="hidden" value="{$T.Result.tid}"/>
												
													<td align="center" id="oid">{$T.Result.oid}</td>
													<td align="center" id="unitCode_{$T.Result.sid}">
														<input id="outerSkuId" name="outerSkuId" value="{$T.Result.outerSkuId}" type="text"/>
														
													</td>
													<td align="center" id="unitName_{$T.Result.sid}">{$T.Result.title}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}
									</textarea>
							</p>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" onclick="save()" type="submit">保存</button>&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button"  onClick ="back()" value="取消"/>
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