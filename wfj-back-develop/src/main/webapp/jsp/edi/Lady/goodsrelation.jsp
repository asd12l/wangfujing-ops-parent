<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	var stockPagination;
	$(function() { 
		//供应商
		$.ajax({
			type : "post",
			url : __ctxPath + "/stock/querySupplyInfoList",
			dataType : "json",
			async:false,
			success : function(response) {
				var result = response.list;
				var option = "<option value=''>所有</option>";
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.sid+"'>" + ele.supplyName
							+ "</option>";
				}
				$("#supplySid_select").append(option);
				return;
			}
		});
		initStock();
		
		$("#pageSelect").change(stockQuery);
	});
	function stockQuery() {
		$("#productSku_from").val($("#productSku_input").val());
		$("#productCode_from").val($("#productCode_input").val());
		var params = $("#stock_form").serialize();
		//alert("表单序列化后请求参数:"+params);
		params = decodeURI(params);
		//alert(params);
		stockPagination.onLoad(params);
		
	}
	function find() {
		/* $("#supplySid_select").change(stockQuery);
		$("#channelSid_select").change(stockQuery);
		$("#shopSid_select").change(stockQuery);
		$("#productSku_input").change(stockQuery); 
		$("#productCode_input").change(stockQuery);  */
		stockQuery();
	}
	function reset() {
		$("#productSku_input").val("");
		$("#productCode_input").val("");
		$("#supplySid_select").val("").trigger("change");
		$("#channelSid_select").val("").trigger("change");
		$("#shopSid_select").val("").trigger("change");
		stockQuery();
	}
	function initStock() {
		var url = $("#ctxPath").val() + "/Commoditymessage/selectCommoditySearch?type=ITEMADD";
		stockPagination = $("#stockPagination").myPagination(
				{
					panel : {
						tipInfo_on : true,
						tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
						tipInfo_css : {
							width : '25px',
							height : "20px",
							border : "2px solid #f0f0f0",
							padding : "0 0 0 5px",
							margin : "0 5px 0 5px",
							color : "#48b9ef"
						}
					},
					debug : false,
					ajax : {
						on : true,
						url : url,
						dataType : 'json',
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						callback : function(data) {
							
							//使用模板
							$("#stock_tab tbody").setTemplateElement(
									"stock-list").processTemplate(data);
						}
					}
					
				});
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
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">爱逛街商品关联</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
																		
								<div class="table-toolbar">
									<ul class="listInfo clearfix">
										<li>
											<span>商品Sku：</span>
											<input type="text" id="productSku_input" style="width: 200px"/>
										</li>
										<li>
											<span>商品标题：</span>
											<input type="text" id="productCode_input" style="width: 200px"/>
										</li>
										<!-- <li>
											<span>供应商：</span>
											<select id="supplySid_select" style="padding: 0 0;width: 200px"></select>
										</li> -->
										
										
										<li style="height:35px;margin-top:0;float:right">
											<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;&nbsp;&nbsp;
										</li>
									</ul>
								</div>
								<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="stock_tab">
                                       <thead class="flip-content bordered-darkorange">
										<tr role="row">
											<th style="text-align: center;">商品SKU</th><!-- sku_id -->
											 <th style="text-align: center;">商品数字Id</th><!--num_iid -->
											<th style="text-align: center;">商品标题</th><!-- title -->
											<th style="text-align: center;">商品数量</th><!--num  -->
											<th style="text-align: center;">卖家昵称</th><!-- nick -->
											<th style="text-align: center;">商品价格</th><!-- price -->
											<th style="text-align: center;">商品状态</th><!-- status -->
											<th style="text-align: center;">商品变化量</th><!-- increment -->
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="stock_form" action="">
										<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option>10</option>
													<option selected="selected">15</option>
													<option>20</option>
												</select>
											</div>&nbsp; 
										 <input type="hidden" id="productSku_from" name="skuId" /> 
										 <input type="hidden" id="productCode_from" name="title" /> 
									</form>
								</div>
								<div id="stockPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="stock-list" rows="0" cols="0">
										
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="center" id="skuCode_{$T.Result.sid}">{$T.Result.sku_id}</td>
													<td align="center"  id="unitCode_{$T.Result.sid}">{$T.Result.num_iid}</td>
													<td align="center" id="productCode_{$T.Result.sid}">{$T.Result.title}</td>
													<td align="center" id="unitName_{$T.Result.sid}">{$T.Result.num}</td>
													
													<td align="center" id="saleStock_{$T.Result.sid}">
													{$T.Result.nick}
													</td>
													<td align="center" id="edefectiveStock_{$T.Result.sid}">
													{$T.Result.price}
													</td>
													<td align="center" id="returnStock_{$T.Result.sid}">
													{$T.Result.status}
													</td>
													<td align="center" id="lockedStock_{$T.Result.sid}">
													{$T.Result.increment}
													</td>
													
									       		
									       		</tr>
											{#/for}
									    {#/template MAIN}	
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