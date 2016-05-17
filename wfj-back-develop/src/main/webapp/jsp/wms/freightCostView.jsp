<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
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
<style type="text/css">
.trClick>td,.trClick>th {
	color: red;
}
</style>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	$(function() {
		initBrandRelation();
		/*   $("#brandName_input").change(brandRelationQuery); */
		$("#pageSelect").change(brandRelationQuery);
	});
	function brandRelationQuery() {
		var paramsPostcode = $("#postcode_input").val();
		var paramsFreghtName = $("#freghtName_input").val();
		var paramstypePost = $("#typePost").val();
		if(paramsFreghtName==null || ""==paramsFreghtName){
			
			$("#warning2").addClass("input_textarea");
			$("#warning2Body").text("运费为能空！");
			$("#warning2").show();
		}
		if(paramsPostcode==""){
			
			$("#warning2").addClass("input_textarea");
			$("#warning2Body").text("邮编为能空！");
			$("#warning2").show();
		}
// 		alert("邮编:"+paramsPostcode); 
//		alert("type:"+paramstypePost);
//		alert("运费:"+paramsFreghtName); 
		
		
		
		
		
		
		
		
		
		
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath
			+ "/wms/configAreaFreight",
			async : false,
			dataType : "json",
			data : {
				"paramstypePost":paramstypePost,
				"paramsPostcode":paramsPostcode,
				"paramsFreghtName":paramsFreghtName
			},
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				setTimeout(function() {
					$("#loading-container").addClass(
							"loading-inactive")
				}, 300);
			},
			success : function(response) {
				if(response.success==true){
					$("#warning2").addClass("input_textarea");
					$("#warning2Body").text("设置成功！");
					$("#warning2").show();
					productQuery();
				}else{
					$("#warning2").addClass("input_textarea");
					$("#warning2Body").text(response.mess);
					$("#warning2").show();
				}
			}	
		});
		
	
	}
	function find() {
		/* $("#brandName_input").change(brandRelationQuery); */
		brandRelationQuery();
	}
	function reset() {
		$("#brandName_input").val("");
		brandRelationQuery();
	}
	function initBrandRelation() {
		var url = __ctxPath + "/wms/queryProvince";
		brandRelationPagination = $("#brandRelationPagination")
				.myPagination(
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
												"loading-inactive");
									}, 300);
								},
								callback : function(data) {
									//使用模板
									$("#ProvinceRelation_tab tbody")
											.setTemplateElement(
													"ProvinceRelation-list")
											.processTemplate(data);
								}
							}
						});
	}
	//点击查询市列表 
	function trClick(sid, obj, name, code) {
		//		brandFatherName_ = $("#brandName1_" + sid).text().trim();
		$("#cityName_input").val("");
		$("#areaName_input").val("");
		$("#freghtName_input").val("");
		$("#provinceName_input").val(name);
		$("#postcode_input").val(code);
		$("#typePost").val("1");
		//		$(obj).addClass("trClick").siblings().removeClass("trClick");
		var type = "1";
		var url = $("#ctxPath").val() + "/wms/queryCity";
		brandRelationPagination1 = $("#brandRelationPagination1").myPagination(
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
						param : 'sid=' + sid,
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive");
							}, 300);
						},
						callback : function(data) {
							//使用模板
							$("#CityRelation_tab tbody").setTemplateElement(
									"CityRelation-list").processTemplate(data);
							//使用模板
							$("#AreaRelation_tab tbody").setTemplateElement(
									"AreaRelation-list").processTemplate(null);
						}
					}
				});
		$(".brandGroupName").css("color","#428bca");
		$("#ProvinceName_" + name).css("color","red");
	}
	//点击查询区列表  
	function trCityClick(sid, obj, name, code) {

		//		brandFatherName_ = $("#brandName1_" + sid).text().trim();
		//		$(obj).addClass("trClick").siblings().removeClass("trClick");
		$("#cityName_input").val(name);
		$("#postcode_input").val(code);
		$("#typePost").val("2");
		var url = $("#ctxPath").val() + "/wms/queryArea";
		areaRelationPagination = $("#areaRelationPagination").myPagination(
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
						param : 'sid=' + sid,
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive");
							}, 300);
						},
						callback : function(data) {
							//使用模板
							$("#AreaRelation_tab tbody").setTemplateElement(
									"AreaRelation-list").processTemplate(data);
						}
					}
				});
		$(".brandGroupName").css("color","#428bca");
		$("#cityName_" + name).css("color","red");
	}

	//点击查询 
	function trAreaClick(sid, obj, name, code) {
		$("#areaName_input").val(name);
		$("#postcode_input").val(code);
		$("#typePost").val("3");
		freigthQuery(code);
		
		$(".brandGroupName").css("color","#428bca");
		$("#areaName_" + name).css("color","red");

	}
	function freigthQuery(code) {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath
			+ "/wms/queryFreight",
			async : false,
			dataType : "json",
			data : {
				"paramsPostcode":code
			},
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				setTimeout(function() {
					$("#loading-container").addClass(
							"loading-inactive")
				}, 300);
			},
			success : function(response) {
				if(response.success==true){
					$("#freghtName_input").val(response.mess);

					
				}else{
					$("#warning2").addClass("input_textarea");
					$("#warning2Body").text(response.mess);
					$("#warning2").show();
				}
			}	
		});
		
	
	}
	

	function addBrandRelation() {
		var url = __ctxPath + "/jsp/BrandRelation/addBrandRelation.jsp";
		$("#pageBody").load(url);
	}
	function modifyBrandRelation() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要修改的品牌关系");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		sid_ = value;
		parentSid_ = $("#parentSid_" + value).text().trim();
		brandName_ = $("#brandName_" + value).text().trim();
		//		brandFatherName_ = $("#brandFatherName_" + value).text().trim();
		var url = __ctxPath + "/jsp/BrandRelation/editBrandRelationView.jsp";
		$("#pageBody").load(url);
	}
	function deleteBrandRelation() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要删除的门店品牌");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		var sid = $("#sid_" + value).text().trim();
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/brandRelationDisplay/deleteRelationBrand",
			dataType : "json",
			data : {
				"sid" : sid
			/* "brandSid":value */
			},
			success : function(response) {
				if (response.success == "true") {
					$("#modal-body-success").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>删除成功，返回列表页!</strong></div>");
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
				} else {
					$("#warning2Body").text("删除失败");
					$("#warning2").show();
				}
				return;
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
	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(
				__ctxPath + "/jsp/BrandRelation/BrandRelationView.jsp");
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
								<h5 class="widget-caption">运费设置管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body clearfix" id="pro">

								<div class="table-toolbar">

									<div class="table-toolbar">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span>省：</span>
										<input type="text" id="provinceName_input" readOnly="true"
											style="width: 120px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span>市：</span> <input type="text" id="cityName_input"
											readOnly="true" style="width: 120px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span>区：</span> <input type="text" id="areaName_input"
											readOnly="true" style="width: 120px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span>邮编：</span> <input type="text" id="postcode_input"
											readOnly="true" style="width: 120px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span style="color: red;">设定邮费(*)：</span> <input type="text"
											id="freghtName_input" style="width: 120px;" onkeyup="this.value=this.value.replace(/\D/g,'')"   onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="4" size="20"/>&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="find();"
											style="height: 32px; margin-top: -4px; color: red;">设置</a>&nbsp;&nbsp;
											<input type="text" id="typePost"  style="display:none;"/>
									</div>
									<div class="clearfix"
										style="border: 1px solid #ddd; padding: 10px;">
										<div
											style="float: left; width: 32%; height: 382px; overflow-y: auto;">
											<table
												class="table table-bordered table-striped table-condensed table-hover flip-content"
												id="ProvinceRelation_tab">
												<thead class="flip-content bordered-darkorange">
													<tr role="row">
														<th style="text-align: center;">省</th>
													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>

										</div>
										<div style="float: left; width: 2%;">&nbsp;</div>
										<div
											style="float: left; width: 32%; height: 382px; overflow-y: auto;">
											<table
												class="table table-bordered table-striped table-condensed table-hover flip-content"
												id="CityRelation_tab">
												<thead class="flip-content bordered-darkorange">
													<tr role="row">
														<th style="text-align: center;">市</th>
													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>
											<!-- <div class="pull-left" style="margin-top: 5px;">
										<form id="brandRelation_form" action="">
											<div class="col-lg-12">
												<select id="pageSelect" name="pageSize"
													style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>
											&nbsp; <input type="hidden" id="brandName_from"
												name="brandName" />
										</form>
									</div> -->
											<div id="brandRelationPagination2"></div>
										</div>
										<div style="float: left; width: 2%;">&nbsp;</div>
										<div
											style="float: left; width: 32%; height: 382px; overflow-y: auto;">
											<table
												class="table table-bordered table-striped table-condensed table-hover flip-content"
												id="AreaRelation_tab">
												<thead class="flip-content bordered-darkorange">
													<tr role="row">
														<th style="text-align: center;">区</th>
													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>
											<!-- <div class="pull-left" style="margin-top: 5px;">
									<form id="brandRelation_form" action="">
										&nbsp; <input type="hidden" id="brandName_from"
											name="brandName" />
									</form>
								</div> -->
										</div>
									</div>
								</div>

								<!-- Templates -->
								<p style="display: none">
									<textarea id="ProvinceRelation-list" rows="0" cols="0">
										
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}"
											onclick="trClick('{$T.Result.sid}',this,'{$T.Result.region_name}','{$T.Result.region_code}')"
											style="height: 35px; cursor: pointer">
													
													<td align="center">
														<a id="ProvinceName_{$T.Result.region_name}"
												class="brandGroupName">
															{$T.Result.region_name}
														</a>
													</td>
													<td align="center" style="display:none;" id="region_name_{$T.Result.region_name}">{$T.Result.region_name}</td>
													
									       		</tr>
											{#/for}
									    {#/template MAIN}	
									</textarea>
								</p>
								<!-- Templates -->
								<p style="display: none">
									<textarea id="CityRelation-list" rows="0" cols="0">
										
											{#template MAIN}
											{#foreach $T.list as Result}
											<tr class="gradeX" id="gradeX{$T.Result.sid}"
											onclick="trCityClick('{$T.Result.sid}',this,'{$T.Result.region_name}','{$T.Result.region_code}')"  style="height: 35px; cursor: pointer">
											
												
													<td align="center">
													<a id="cityName_{$T.Result.region_name}" class="brandGroupName">
													{$T.Result.region_name}
													</a>
													</td>
													<td align="center" style="display:none;" id="region_name_{$T.Result.region_name}">{$T.Result.region_name}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}		
									</textarea>
								</p>
								<!-- Templates -->
								<p style="display: none">
									<textarea id="AreaRelation-list" rows="0" cols="0">
										
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}"
											onclick="trAreaClick('{$T.Result.sid}',this,'{$T.Result.region_name}','{$T.Result.region_code}')" style="height: 35px; cursor: pointer">
													<td align="center">
													<a id="areaName_{$T.Result.region_name}" class="brandGroupName">
													{$T.Result.region_name}
													</a>
													</td>
													<!-- <td align="center" style="display:none" id="sid_{$T.Result.sid}">{$T.Result.sid}</td> -->
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