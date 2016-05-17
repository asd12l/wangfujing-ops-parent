<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var productSellingPagination;
	$(function() {    	
	    initProductSelling();
	    $("#productSku_input").change(productSellingQuery);
	    $("#proSelling_input").change(productSellingQuery);
	    $("#pageSelect").change(productSellingQuery);
	});
	function productSellingQuery(){
		$("#productSku_from").val($("#productSku_input").val());
		$("#proSelling_from").val($("#proSelling_input").val());
        var params = $("#productSelling_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        productSellingPagination.onLoad(params);
   	}
	function reset(){
		$("#productSku_input").val("");
		$("#proSelling_input").val("");
		productSellingQuery();
	}
	//初始化商品列表
 	function initProductSelling() {
		var url = $("#ctxPath").val()+"/product/selectAllProduct";
		productSellingPagination = $("#productSellingPagination").myPagination({
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
               //使用模板
               $("#productSelling_tab tbody").setTemplateElement("productSelling-list").processTemplate(data);
             }
           }
         });
    }
	//上架
	function upSelling(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else if(checkboxArray.length==0){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要上架的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var value=	checkboxArray[0];
		bootbox.confirm("确定添加上架吗？", function(r){
			if(r){
				$.ajax({
					type: "post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					url: __ctxPath+"/productSelling/updateProSelling",
					dataType: "json",
					data: {
						"sid":value,"pro_selling":1
					},
					success: function(response) {
						if(response.success==true){
							$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
								"<i class='fa-fw fa fa-times'></i><strong>上架成功，返回列表页!</strong></div>");
		  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
						}else{
							$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.rows+"</strong></div>");
							$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
						}
						return;
					}
				});
			}
		})
	}
	//下架
	function downSelling(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else if(checkboxArray.length==0){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要下架的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var value=	checkboxArray[0];
		bootbox.confirm("确定添加下架吗？", function(r){
			if(r){
				$.ajax({
					type: "post",
					contentType: "application/x-www-form-urlencoded;charset=utf-8",
					url: __ctxPath+"/productSelling/updateProSelling",
					dataType: "json",
					data: {
						"sid":value,"pro_selling":0
					},
					success: function(response) {
						if(response.success==true){
							$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
								"<i class='fa-fw fa fa-times'></i><strong>下架成功，返回列表页!</strong></div>");
		  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
						}else{
							$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>下架失败!</strong></div>");
							$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
						}
						return;
					}
				});
			}
		});
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
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/productSelling.jsp");
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
								<span class="widget-caption"><h5>商品上下架管理</h5>
								</span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="upSelling();"
											class="btn btn-darkorange" style="width: 100%;"> <i class="fa fa-arrow-up"></i>
											上架商品 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="downSelling();"
											class="btn btn-maroon" style="width: 100%;"> <i class="fa fa-arrow-down"></i>
											下架商品 </a>
									</div>
									<div class="col-md-8">
										<div class="btn-group pull-right">
											<form id="productSelling_form" action="">
												<div class="col-lg-12">
													<select id="pageSelect" name="pageSize">
														<option>5</option>
														<option selected="selected">10</option>
														<option>15</option>
														<option>20</option>
													</select> <input type="hidden" id="productSku_from"
														name="productSku" /> <input type="hidden"
														id="proSelling_from" name="proSelling" />
												</div>
												&nbsp;
											</form>
										</div>
									</div>
								</div>
								<div class="table-toolbar">
								<div class="col-md-4">
									<div class="col-lg-4"><span>商品SKU：</span></div>
									<div class="col-lg-8"><input type="text" id="productSku_input" /></div>
								</div>
								<div class="col-md-4">
									<div class="col-lg-4"><span>是否上架：</span></div>
									<div class="col-lg-8"><select id="proSelling_input"
										style="padding: 0 0;width: 100%">
										<option value="">全部</option>
										<option value="1">上架</option>
										<option value="0">下架</option>
									</select>
									</div>
								</div>
								<div class="col-md-4">
								<div class="col-lg-12">
									<a class="btn btn-default"
										onclick="reset();" style="height: 32px; margin-top: -4px;">重置</a>
										</div>&nbsp;
								</div>
								</div>
								<table class="table table-striped table-hover table-bordered"
									id="productSelling_tab">
									<thead>
										<tr role="row">
											<th width="7.5%"></th>
											<th style="text-align: center;">商品名称</th>
											<th style="text-align: center;">商品款号</th>
											<th style="text-align: center;">品牌</th>
											<th style="text-align: center;">是否启用</th>
											<th style="text-align: center;">是否上架</th>
											<th style="text-align: center;">商品类型</th>
											<th style="text-align: center;">供应时间</th>
											<th style="text-align: center;">上架时间</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div id="productSellingPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="productSelling-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.productList as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center">{$T.Result.productName}</td>
													<td align="center">{$T.Result.productSku}</td>
													<td align="center">{$T.Result.brandName}</td>
													<td align="center">
														{#if $T.Result.proActiveBit == 0}
						           							未启用
						                      			{#elseif $T.Result.proActiveBit == 1}
						           							已启用
						                   				{#/if}
													</td>
													<td align="center">
														{#if $T.Result.proSelling == 0}
						           							未上架
						                      			{#elseif $T.Result.proSelling == 1}
						           							已上架
						                   				{#/if}
													</td>
													<td align="center">
														{#if $T.Result.proType == 0}
						           							非正式商品
						                      			{#elseif $T.Result.proType == 1}
						           							正式商品
						                   				{#/if}
													</td>
													<td align="center">{$T.Result.supplyTime}</td>
													<td align="center">
														{#if $T.Result.proSellingTime == null}
														{#else}
															{$T.Result.proSellingTime}
														{#/if}
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
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