<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("sid");
	request.setAttribute("sid", id);
	String pageLayoutSid = request.getParameter("pageLayoutSid");
	request.setAttribute("pageLayoutSid", pageLayoutSid);
%>
<!--
WFJBackWeb - productView
Version: 1.0.0
Author: WangSy
-->
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
<script
	src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
<script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var productPagination;
	 $(function() {    	
	    initProduct();
	    /* $('#reservation,#reservation2').daterangepicker();
	    $("#productSku_input").change(productQuery);
	    $("#brandName_input").change(productQuery);
	    $("#proActiveBit_select").change(productQuery);
	    $("#proSelling_select").change(productQuery);
	    $("#proType_select").change(productQuery);
	    $("#pageSelect").change(productQuery); */
	});
	 /*function productQuery(){
		$("#productSku_from").val($("#productSku_input").val());
		$("#brandName_from").val($("#brandName_input").val());
		$("#proActiveBit_from").val($("#proActiveBit_select").val());
		$("#proSelling_from").val($("#proSelling_select").val());
		$("#proType_from").val($("#proType_select").val());
        var params = $("#product_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        productPagination.onLoad(params);
   	}
	// 查询
	function query(){
		productQuery();
	}
	// 重置
	function reset(){
		$("#productSku_input").val("");
		$("#brandName_input").val("");
		$("#proActiveBit_select").val("");
		$("#proSelling_select").val("");
		$("#proType_select").val("");
		productQuery();
	} */
	//初始化品牌列表
 	function initProduct() {
		var brandName="";
		var url = $("#ctxPath").val()+"/web/addBrandList";
		productPagination = $("#productPagination").myPagination({
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
             data:brandName,
             ajaxStart: function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop: function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive")
					},300);
				},
             callback: function(data) {
               //使用模板
               $("#product_tab tbody").setTemplateElement("brand-list").processTemplate(data);
             }
           }
         });
    }
	//按钮事件-添加品牌
	function addBrand(){
		
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var brandSid = $(this).val();
			checkboxArray.push(brandSid);
		});
		if (checkboxArray.length==0){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要查看的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		
		bootbox.confirm("确定添加此品牌吗？", function(r){
			if(r){
				var value="";
				for(i=0;i<checkboxArray.length;i++){
					value+=checkboxArray[i]+",";
				}
				$.ajax({
			        type:"post",
			        url: __ctxPath+"/web/addBrand",
			        contentType: "application/x-www-form-urlencoded;charset=utf-8",
			        dataType: "json",
			        data:{
			        	"ids" : value,
			        	"pageLayoutSid" : ${pageLayoutSid}
			        },
			        ajaxStart: function() {
				       	 $("#loading-container").attr("class","loading-container");
				        },
			        ajaxStop: function() {
			          //隐藏加载提示
			          setTimeout(function() {
			       	        $("#loading-container").addClass("loading-inactive")
			       	 },300);
			        },
			        success: function(response) {
			        	if(response.success == 'true'){
							$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
								"<i class='fa-fw fa fa-times'></i><strong>添加成功，返回列表页!</strong></div>");
		  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			        	}else if(response.msg!=""){
							$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.msg+"</strong></div>");
		 	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
						}
		        	}
				});
			}
		});
		//var url = __ctxPath+"/jsp/product/productSaveView.jsp";
		//$("#pageBody").load(url);
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
		$("#pageBody").load( __ctxPath+"/jsp/nav/GetChannelTree.jsp");
	}
	
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
			}
		}
	}
	function back(){
		var url =  __ctxPath+"/jsp/nav/GetChannelTree.jsp";
		$("#pageBody").load(url);
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
								<span class="widget-caption"><h5>商品管理</h5></span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
								<span> <a id="enterFloor" onclick="back();" 
									class="btn btn-info glyphicon glyphicon-wrench">返回楼层列表 </a></span>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">


									<div class="col-md-4">
										<div class="col-lg-5">
											<span>品牌编号：</span>
										</div>
										<div class="col-lg-7">
											<input type="text" id="orderNo_input" style="width: 100%;" />
										</div>
									</div>

									<div class="col-md-4">
										<div class="col-lg-5">
											<span>品&nbsp;&nbsp;&nbsp; 牌：</span>
										</div>
										<div class="col-lg-7">
											<input type="text" id="shopNo_input" style="width: 100%;" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="olvQuery();"
											class="btn btn-yellow" style="width: 100%;"> <i
											class="fa fa-eye"></i> 查询
										</a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="reset();"
											class="btn btn-primary" style="width: 100%;"> <i
											class="fa fa-random"></i> 重置
										</a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="addBrand();"
											class="btn btn-primary" style="width: 100%;"> <i
											class="fa fa-random"></i> 添加
										</a>&nbsp;
									</div>
									<form id="olv_form" action="">
										<input type="hidden" id="pageSelect" name="pageSize"
											value="10" /> <input type="hidden" id="orderNo_form"
											name="orderNo" /> <input type="hidden" id="saleNo_form"
											name="saleNo" /> <input type="hidden"
											id="salesPaymentNo_form" name="salesPaymentNo" /> <input
											type="hidden" id="saleStatus_form" name="saleStatus" /> <input
											type="hidden" id="shopNo_form" name="shopNo" /> <input
											type="hidden" id="payStatus_form" name="payStatus" /> <input
											type="hidden" id="memberNo_form" name="memberNo" /> <input
											type="hidden" id="startSaleTime_form" name="startSaleTime" />
										<input type="hidden" id="endSaleTime_form" name="endSaleTime" />
									</form>
									<table
										class="table table-bordered table-striped table-condensed table-hover flip-content"
										id="product_tab">
										<thead class="flip-content bordered-darkorange">
											<tr>
												<th style="text-align: center;" width="75px;">选择</th>
												<th style="text-align: center;">编码</th>
												<th style="text-align: center;">品牌名称</th>
												<th style="text-align: center;">品牌链接</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="pull-left" style="padding: 10px 0;">
										<form id="product_form" action="">
											<div class="col-lg-12">
												<select id="pageSelect" name="pageSize"
													style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>
											&nbsp; <input type="hidden" id="productSku_from"
												name="skuCode" /> <input type="hidden" id="brandName_from"
												name="brandName" /> <input type="hidden"
												id="proActiveBit_from" name="proActiveBit" /> <input
												type="hidden" id="proSelling_from" name="proSelling" /> <input
												type="hidden" id="proType_from" name="proType" />
										</form>
									</div>
									<div id="productPagination"></div>
								</div>
								<!-- Templates -->
								<p style="display: none">
									<textarea id="brand-list" rows="0" cols="0">
									<!-- 
									{#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="left">
													<div class="checkbox">
														<label>
															<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
															<span class="text"></span>
														</label>
													</div>
												</td>
												<input type='hidden' id='pageLayoutSid_{$T.Result.sid}' value='{$T.Result.pageLayoutSid}'></input>
												
												<td align="center" id="divSid_{$T.Result.sid}">{$T.Result.sid}</td>
												<td align="center" id="divTitle_{$T.Result.sid}">{$T.Result.brandName}</td>
												<td align="center" id="divLink_{$T.Result.sid}">{$T.Result.brandLink}</td>
								       		</tr>
										{#/for}
								    {#/template MAIN}	 -->
								</textarea>
								</p>
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