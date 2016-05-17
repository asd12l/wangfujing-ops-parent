<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<% String id=request.getParameter("sid");
		request.setAttribute("sid",id);
		String pageLayoutSid=request.getParameter("pageLayoutSid");
		request.setAttribute("pageLayoutSid",pageLayoutSid);
	%>
<!--
WFJBackWeb - 商品列表页
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script type="text/javascript">
	var productPagination;
	$(function(){
		initProduct();
		$("#proType_select").change(productQuery);
		$("#pageSelect").change(productQuery);
	});
	function productQuery(){
		$("#skuCode_from").val($("#skuCode_input").val());
		$("#skuName_from").val($("#skuName_input").val());
		$("#proType_from").val($("#proType_select").val());
		var params = $("#product_form").serialize();
		params = decodeURI(params);
		productPagination.onLoad(params);
	}
	// 查询
	function query(){
	    $("#cache").val(0);
		productQuery();
	}
	// 重置
	function reset(){
	    $("#cache").val(1);
		$("#skuCode_input").val("");
		$("#skuName_input").val("");
		$("#proType_select").val("");
		productQuery();
	}
	//初始化商品列表
	function initProduct() {
		var url = $("#ctxPath").val()+"/product/selectAllProduct";
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
				ajaxStart: function() {$("#loading-container").attr("class","loading-container");},
				ajaxStop: function() {setTimeout(function() {$("#loading-container").addClass("loading-inactive")},300);},
				callback: function(data) {
					$("#product_tab tbody").setTemplateElement("product-list").processTemplate(data);
				}
			}
		});
	}
	</script>
<!-- 按钮事件-添加商品 -->
<script type="text/javascript">
//按钮事件-添加商品
	function addProduct(){
		bootbox.confirm("确定添加商品吗？", function(r){
			if(r){
				var checkboxArray=[];
				$("input[type='checkbox']:checked").each(function(i, team){
					var productSid = $(this).val();
					checkboxArray.push(productSid);
				});
				if (checkboxArray.length==0){
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要查看的列!</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					 return false;
				}
				
				var value="";
				for(i=0;i<checkboxArray.length;i++){
					value+=checkboxArray[i]+",";
				}
				$.ajax({
			        type:"post",
			        url: __ctxPath+"/web/addProduct",
			        contentType: "application/x-www-form-urlencoded;charset=utf-8",
			        dataType: "json",
			        data:{
			        	"ids":value,
			        	"pageLayoutSid":${pageLayoutSid}
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
// 	function addProduct(){
// 		$("#pageBody").load(__ctxPath+"/jsp/product/productSaveView.jsp");
// 	}
</script>
<!-- 按钮事件-查询商品详情 -->
<script type="text/javascript">
	function getProduct(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
		    $("#warning2Body").text("只能选择一列!");
			$("#warning2").show();
			 return false;
		}else if(checkboxArray.length==0){
		    $("#warning2Body").text("请选取要查看的列!");
			$("#warning2").show();
			 return false;
		}
		var value=	checkboxArray[0];
		var url = __ctxPath+"/product/getProductDetail/"+value;
		$("#pageBody").load(url);
	}
</script>
<!-- 按钮事件-添加专柜商品 -->	
<script type="text/javascript">
	function appendProduct (){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
		    $("#warning2Body").text("只能选择一列!");
			$("#warning2").show();
			 return false;
		}else if(checkboxArray.length==0){
		    $("#warning2Body").text("请选取要添加专柜商品的商品!");
			$("#warning2").show();
			 return false;
		}
		var value=	checkboxArray[0];
		var url = __ctxPath+"/product/toShoppeProduct/"+value;
		$("#pageBody").load(url);
	}
</script>
<!-- 按钮事件-商品维护 -->
<script type="text/javascript">
	function updateProduct (){
	    var checkboxArray=[];
	    $("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
		    $("#warning2Body").text("只能选择一列!");
			$("#warning2").show();
			 return false;
		}else if(checkboxArray.length==0){
		    $("#warning2Body").text("请选取要维护的商品!");
			$("#warning2").show();
			 return false;
		}
		var value	=	checkboxArray[0];
		var url = __ctxPath+"/product/getProductDetails/"+value;
		$("#pageBody").load(url);
	}
</script>
<!--  -->
<script type="text/javascript">
	var productChangePropId = "";
	var category_Sid = "";
	var category_Name = "";
	var spuSid = "";
	/* 修改商品工业属性和展示分类+属性 */
	function editProductSX(){
	    var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
		    $("#warning2Body").text("只能选择一列!");
			$("#warning2").show();
			 return false;
		}else if(checkboxArray.length==0){
		    $("#warning2Body").text("请选取要修改的商品!");
			$("#warning2").show();
			 return false;
		}
		productChangePropId = checkboxArray[0];
		category_Sid = $("#category_"+productChangePropId).html().trim();
		category_Name = $("#categoryName_"+productChangePropId).html().trim();
		statcate_Name = $("#statCategoryName_"+productChangePropId).html().trim();
		productSid = $("#spuCode_"+productChangePropId).html().trim();
		productSid2 = $("#spuSid_"+productChangePropId).html().trim();
		var url = __ctxPath+"/jsp/product/productChangeProp.jsp";
		$("#pageBody").load(url);
	}
</script>
<!-- 操作 -->
<script type="text/javascript">
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
		$("#pageBody").load(__ctxPath+"/jsp/product/ProductView.jsp");
	}
</script>
<!-- 点击编码或者名称查询详情 -->
<script type="text/javascript">
	function getView(data){
	    var url = __ctxPath+"/product/getProductDetail/"+data;
		$("#pageBody").load(url);
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
                                    <h5 class="widget-caption">商品管理</h5>
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
                                    	<div class="clearfix">
                                    		<a id="editabledatatable_new" onclick="addProduct();" class="btn btn-primary">
		                                        	<i class="fa fa-plus"></i>
													添加商品
		                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;
		                                        <a id="editabledatatable_new" onclick="appendProduct();" class="btn btn-primary">
		                                        	<i class="fa fa-plus"></i>
													新增专柜商品
		                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;
		                                        <a id="editabledatatable_new" onclick="updateProduct();" class="btn btn-primary">
		                                        	<i class="fa fa-edit"></i>
													商品维护
		                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;
		                                        <a id="editabledatatable_new" onclick="editProductSX();" class="btn btn-primary">
		                                    		<i class="fa fa-edit"></i>
													商品修改
		                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                    	</div>
                                    	<div class="mtb10">
                                    		<span>编码:</span>
                                			<input type="text" id="skuCode_input"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                			<span>标准品名：</span>
		                                	<input type="text" id="skuName_input" />&nbsp;&nbsp;&nbsp;&nbsp;
		                                	<span>类型:</span>
                                			<select id="proType_select" style="width: 200px;padding: 0px 0px">
	                                			<option value="">全部</option>
	                                			<option value="1">普通商品</option>
	                                			<option value="2">赠品</option>
	                                			<option value="3">礼品</option>
	                                			<option value="4">虚拟商品</option>
	                                			<option value="5">服务类商品</option>
	                                		</select>&nbsp;&nbsp;&nbsp;&nbsp;
	                                		<a class="btn btn-default shiny" onclick="query();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
                           					<a class="btn btn-default shiny" onclick="reset();">重置</a>
                                    	</div>
                                	</div>
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="product_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr>
                                            	<th style="text-align: center;" width="5%">选择</th>
                                                <th style="text-align: center;">编码</th>
                                                <th style="text-align: center;">标准品名</th>
                                                <th style="text-align: center;">产品名称</th>
                                                <th style="text-align: center;">集团品牌名称</th>
                                                <th style="text-align: center;">类型</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                     <div class="pull-left" style="padding: 10px 0;">
                                   		 <form id="product_form" action="">
                                     		<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp;
											<input type="hidden" id="skuCode_from" name="skuCode"/>
											<input type="hidden" id="skuName_from" name="skuName"/>
											<input type="hidden" id="proType_from" name="proType"/>
											<input type="hidden" id="cache" name="cache" value="1"/>
                                      	</form>
                                      </div>
                                    <div id="productPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="product-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center">
														<a onclick="getView({$T.Result.sid});" style="cursor:pointer;">{$T.Result.skuCode}</a></td>
													<td align="center">
														<a onclick="getView({$T.Result.sid});" style="cursor:pointer;">{$T.Result.skuName}</a></td>
													<td align="center">{$T.Result.spuName}</td>
													<td align="center">{$T.Result.brandGroupName}</td>
													<td align="center">
														{#if $T.Result.proType == 1}普通商品
														{#elseif $T.Result.proType == 2}赠品
														{#elseif $T.Result.proType == 3}礼品
														{#elseif $T.Result.proType == 4}虚拟商品
														{#elseif $T.Result.proType == 5}服务类商品
														{#/if}
													</td>
													<td style="display:none;" id="category_{$T.Result.sid}">{$T.Result.category}</td>
													<td style="display:none;" id="categoryName_{$T.Result.sid}">{$T.Result.categoryName}</td>
													<td style="display:none;" id="statCategoryName_{$T.Result.sid}">{$T.Result.statCategoryName}</td>
													<td style="display:none;" id="spuCode_{$T.Result.sid}">{$T.Result.spuCode}</td>
													<td style="display:none;" id="spuSid_{$T.Result.sid}">{$T.Result.spuSid}</td>
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
</body>
</html>