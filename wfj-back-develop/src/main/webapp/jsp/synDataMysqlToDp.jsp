<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<!--Bootstrap Date Range Picker-->
<script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var olvPagination;
	$(function() {
		$('#reservation').daterangepicker(); 
	});
	function olvQuery(){
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startSaleTime_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endSaleTime_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startSaleTime_form").val("");
			$("#endSaleTime_form").val("");
		}
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#reservation").val("");
		olvQuery();
	}

 	function order() {
 		
 		var startTime = $("#startSaleTime_form").value;
		var endTime = $("#endSaleTime_form").value;
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/order/synOrderOrSale",
			dataType: "json",
			data: {
				type:"order",
				saleTimeFrom:startTime,
				saleTimeTo:endTime
			},
			success: function(response) {
				if(response.success==true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>订单同步成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>订单同步失败</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
    }
 	function selling() {
 		var startTime = $("#startSaleTime_form").get("startSaleTime").dom.value;
		var endTime = $("#endSaleTime_form").get("endSaleTime").dom.value;
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/order/synOrderOrSale",
			dataType: "json",
			data: {
				type:"sale",
				saleTimeFrom:startTime,
				saleTimeTo:endTime
			},
			success: function(response) {
				if(response.success==true){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>销售单同步成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>销售单同步失败</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
    }
	
	</script> 
  
  

</head>
<body>
	<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
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
                                    <span class="widget-caption"><h5>订单/销售单同步管理</h5></span>
                                    <div class="widget-buttons">
                                        <a href="#" data-toggle="maximize"></a>
                                        <a href="#" data-toggle="collapse" onclick="tab('pro');">
                                            <i class="fa fa-minus" id="pro-i"></i>
                                        </a>
                                        <a href="#" data-toggle="dispose"></a>
                                    </div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                    	<div class="col-md-6">
	                                		<div class="col-lg-5">时间：</div>
	                                		<div class="col-lg-7">
                                   				<input type="text" id="reservation"  style="width: 100%;"/>
                                   			</div>
                                		</div>
										<div class="col-md-2">
											<a id="editabledatatable_new" onclick="order();"
												class="btn btn-darkorange" style="width: 100%;"> <i class="fa fa-arrow-up"></i>
												订单同步 </a>
										</div>
										<div class="col-md-2">
											<a id="editabledatatable_new" onclick="selling();"
												class="btn btn-maroon" style="width: 100%;"> <i class="fa fa-arrow-up"></i>
												销售单同步 </a>
										</div>
                               			<form id="olv_form" action="">
											<input type="hidden" id="startSaleTime_form" name="startSaleTime"/>
											<input type="hidden" id="endSaleTime_form" name="endSaleTime"/>
                                      	</form>
	                                	
                                      	<div style="width:100%; height:225px; ">
                                      	</div>
                                      	<div style="width:100%; height:225px; ">
                                      		<p align="center"><span ><font size=6>执行结果稍后请查看单品系统数据是否与MYSQL一致。</font></span></p>
                                      	</div>
                                      	
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>    
</body>
</html>