<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var on_line_name;
	var username ;
	var organizationOnePagination;
	var on_line_id;
	$(function() {
		
		initOrganizationOne();
		$("#colorCode_select").change(organizationOneQuery); 
		
	});
	
	
	
	
	function organizationOneQuery() {
		$("#colorCode_form").val($("#colorCode_select").val());
		$("#colorName_form").val($("#colorCode_select").find("option:selected").text().trim());
		$("#modelCode_form").val($("#modelCode_input").val());
		$("#productName_form").val($("#productName_input").val());
		$("#productCode_form").val($("#productCode_input").val());
		$("#brandName_form").val($("#brandName_input").val());
		var params = $("#organization_form").serialize();
		params = decodeURI(params);
		organizationOnePagination.onLoad(params);
	}
	function find() {
		organizationOneQuery();
	}
	function reset() {
		$("#productName_input").val("");
		$("#productCode_input").val("");
		$("#colorCode_select").val("");
		$("#modelCode_input").val("");
		$("#brandName_input").val("");
		organizationOneQuery();
	}
	//初始化
	function initOrganizationOne() {
		on_line_id=sid;	
		
		username = '<%=session.getAttribute("username")%>';
		var url = $("#ctxPath").val() + "/photo/queryProductList";
		organizationOnePagination = $("#organizationOnePagination").myPagination(
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
						$("#loading-container").attr("class","loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container").addClass("loading-inactive");
						}, 300);
					},
					callback : function(data) {
						//使用模板
						$("#organizationZero_tab tbody").setTemplateElement("organizationZero-list").processTemplate(data);
					}
				}
			});
	}
	
	function addOrganization() {
		var url = __ctxPath + "/jsp/photo/onlinePlanView.jsp";
		$("#pageBody").load(url);
	}
	
	
	
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({"display" : "none"});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({"display" : "block"});
			}
		}
	}
	function successBtn() {
		$("#modal-success").attr({"style" : "display:none;","aria-hidden" : "true","class" : "modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/SupplierInfomationNode/SupplierInfomationNode.jsp");
	}
function editOrganization() {
	var checkboxArray = new Array();
	var checkboxArray_product_name = new Array();
	var checkboxArray_modelcode = new Array();
	var checkboxArray_colorcode = new Array();
	var checkboxArray_colorcodename = new Array();
	var checkboxArray_brandcode = new Array();
	var checkboxArray_brandname = new Array();
	var checkboxArray_categotyscode = new Array();
	var checkboxArray_categotys = new Array();
	var checkboxArray_sexsid = new Array();
	//var checkboxArray_storeCodes = new Array();
	//var checkboxArray_storeNames = new Array();
	$("input[type='checkbox']:checked").each(function(i, team) {
		var productSid = $(this).val();
		checkboxArray.push($("#product_sid_"+productSid).html().trim());
		var product_name = $("#product_name_"+productSid).html().trim();
		checkboxArray_product_name.push(product_name);
		var modelcode = $("#modelCode_"+productSid).html().trim();
		checkboxArray_modelcode.push(modelcode);
		var colorcode = $("#colorCode_"+productSid).html().trim();
		checkboxArray_colorcode.push(colorcode);
		var colorcodename = $("#colorName_"+productSid).html().trim();
		checkboxArray_colorcodename.push(colorcodename);
		var brandcode = $("#brandCode_"+productSid).html().trim();
		checkboxArray_brandcode.push(brandcode);
		var brandname = $("#brandName_"+productSid).html().trim();
		checkboxArray_brandname.push(brandname);
		var categotyscode = $("#categoryCode_"+productSid).html().trim();
		checkboxArray_categotyscode.push(categotyscode);
		var categotys = $("#categoryName_"+productSid).html().trim();
		checkboxArray_categotys.push(categotys);
		var sexsid = $("#sex_"+productSid).html().trim();
		checkboxArray_sexsid.push(sexsid);
		//var storeCodes = $("#storeCode_"+productSid).html().trim();
		//checkboxArray_storeCodes.push(storeCodes);
		//var storeNames = $("#storeName_"+productSid).html().trim();
		//checkboxArray_storeNames.push(storeNames);
	});
	
	var inT = JSON.stringify(checkboxArray);
	inT = inT.replace(/\%/g, "%25");
	inT = inT.replace(/\#/g, "%23");
	inT = inT.replace(/\&/g, "%26");
	inT = inT.replace(/\+/g, "%2B");
	var inT_product_name = JSON.stringify(checkboxArray_product_name);
	inT_product_name = inT_product_name.replace(/\%/g, "%25");
	inT_product_name = inT_product_name.replace(/\#/g, "%23");
	inT_product_name = inT_product_name.replace(/\&/g, "%26");
	inT_product_name = inT_product_name.replace(/\+/g, "%2B");
	var inT_modelcode = JSON.stringify(checkboxArray_modelcode);
	inT_modelcode = inT_modelcode.replace(/\%/g, "%25");
	inT_modelcode = inT_modelcode.replace(/\#/g, "%23");
	inT_modelcode = inT_modelcode.replace(/\&/g, "%26");
	inT_modelcode = inT_modelcode.replace(/\+/g, "%2B");
	var inT_colorcode = JSON.stringify(checkboxArray_colorcode);
	inT_colorcode = inT_colorcode.replace(/\%/g, "%25");
	inT_colorcode = inT_colorcode.replace(/\#/g, "%23");
	inT_colorcode = inT_colorcode.replace(/\&/g, "%26");
	inT_colorcode = inT_colorcode.replace(/\+/g, "%2B");
	var inT_colorcodename = JSON.stringify(checkboxArray_colorcodename);
	inT_colorcodename = inT_colorcodename.replace(/\%/g, "%25");
	inT_colorcodename = inT_colorcodename.replace(/\#/g, "%23");
	inT_colorcodename = inT_colorcodename.replace(/\&/g, "%26");
	inT_colorcodename = inT_colorcodename.replace(/\+/g, "%2B");
	var inT_brandcode = JSON.stringify(checkboxArray_brandcode);
	inT_brandcode = inT_brandcode.replace(/\%/g, "%25");
	inT_brandcode = inT_brandcode.replace(/\#/g, "%23");
	inT_brandcode = inT_brandcode.replace(/\&/g, "%26");
	inT_brandcode = inT_brandcode.replace(/\+/g, "%2B");
	var inT_brandname = JSON.stringify(checkboxArray_brandname );
	inT_brandname = inT_brandname.replace(/\%/g, "%25");
	inT_brandname = inT_brandname.replace(/\#/g, "%23");
	inT_brandname = inT_brandname.replace(/\&/g, "%26");
	inT_brandname = inT_brandname.replace(/\+/g, "%2B");
	var inT_categotyscode = JSON.stringify(checkboxArray_categotyscode );
	inT_categotyscode = inT_categotyscode.replace(/\%/g, "%25");
	inT_categotyscode = inT_categotyscode.replace(/\#/g, "%23");
	inT_categotyscode = inT_categotyscode.replace(/\&/g, "%26");
	inT_categotyscode = inT_categotyscode.replace(/\+/g, "%2B");
	var inT_categotys = JSON.stringify(checkboxArray_categotys );
	inT_categotys = inT_categotys.replace(/\%/g, "%25");
	inT_categotys = inT_categotys.replace(/\#/g, "%23");
	inT_categotys = inT_categotys.replace(/\&/g, "%26");
	inT_categotys = inT_categotys.replace(/\+/g, "%2B");
	var inT_sexsid = JSON.stringify(checkboxArray_sexsid );
	inT_sexsid = inT_sexsid.replace(/\%/g, "%25");
	inT_sexsid = inT_sexsid.replace(/\#/g, "%23");
	inT_sexsid = inT_sexsid.replace(/\&/g, "%26");
	inT_sexsid = inT_sexsid.replace(/\+/g, "%2B");
	//var inT_storeCodes = JSON.stringify(checkboxArray_storeCodes );
	//inT_storeCodes = inT_storeCodes.replace(/\%/g, "%25");
	//inT_storeCodes = inT_storeCodes.replace(/\#/g, "%23");
	//inT_storeCodes = inT_storeCodes.replace(/\&/g, "%26");
	//inT_storeCodes = inT_storeCodes.replace(/\+/g, "%2B");
	//var inT_storeNames = JSON.stringify(checkboxArray_storeNames );
	//inT_storeNames = inT_storeNames.replace(/\%/g, "%25");
	//inT_storeNames = inT_storeNames.replace(/\#/g, "%23");
	//inT_storeNames = inT_storeNames.replace(/\&/g, "%26");
	//inT_storeNames = inT_storeNames.replace(/\+/g, "%2B");
	
	if (checkboxArray.length == 0) {
		$("#warning2Body").text("请至少选择一件商品!");
		$("#warning2").show();
		return false;
	}
	
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath
				+ "/photo/editAddProduct",
		async : false,
		dataType : "json",
		data : {
			"sids" : inT,
			"on_line_id" : on_line_id,
			"on_line_name":on_line_name,
			"product_names":inT_product_name,
			"modelcodes" : inT_modelcode,
			"colorcodes" : inT_colorcode,
			"colorcodenames":inT_colorcodename,
			"brandcodes":inT_brandcode,
			"brandnames" : inT_brandname,
			"categotyscodes" : inT_categotyscode,
			"categotyss":inT_categotys,
			"sexsids":inT_sexsid
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
				$("#warning2Body").text("上线计划添加商品成功！");
				$("#warning2").show();
				productQuery();
			}else{
				$("#warning2Body").text(response.data.errorMsg);
				$("#warning2").show();
				
			}
		}	
	});
}
function productQuery() {
	var url = __ctxPath + "/jsp/photo/onlinePlanView.jsp";
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
								<h5 class="widget-caption">添加商品</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<div class="clearfix">
										<a id="editabledatatable_new" onclick="editOrganization();"
											class="btn btn-success"> <i class="fa fa-plus"></i> 添加商品创建计划
										</a>&nbsp;&nbsp;&nbsp;&nbsp; 
										<a id="editabledatatable_new" onclick="addOrganization();" 
											class="btn btn-danger"> <i class="fa fa-wrench"></i> 取消
										</a>&nbsp;&nbsp;&nbsp;&nbsp; 
									</div>
								</div>
								<div class="table-toolbar">
									<span>商品名称：</span> <input type="text" maxlength="20" id="productName_input" />&nbsp;&nbsp;&nbsp;&nbsp; 
									<span>商品编码：</span> <input type="text" maxlength="20" id="productCode_input" />&nbsp;&nbsp;&nbsp;&nbsp; 
									<span>色系：</span>
										<select id="colorCode_select" style="width:200px;padding: 0px 0px">
											<option value="" selected="selected">全部</option>
											<option value="1" >白色</option>
											<option value="2" >黄色</option>
											<option value="3" >紫色</option>
											<option value="4" >红色</option>
											<option value="5" >黑色</option>
											<option value="6" >绿色</option>
											<option value="7" >灰色</option>
											<option value="8" >桔色</option>
											<option value="9" >蓝色</option>
											<option value="10" >粉色</option>
											<option value="11" >棕色</option>
											<option value="12" >花色</option>
										</select>&nbsp;&nbsp;&nbsp;&nbsp; 
								</div>
								<div class="table-toolbar">
									<span>款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</span> <input type="text" maxlength="20" id="modelCode_input" />&nbsp;&nbsp;&nbsp;&nbsp; 
									<span>品牌名称：</span> <input type="text" maxlength="20" id="brandName_input" />&nbsp;&nbsp;&nbsp;&nbsp; 
									<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a class="btn btn-default shiny" onclick="reset();">重置</a>
								</div>
								<table
									class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="organizationZero_tab">
									<thead class="flip-content bordered-darkorange">
										<tr role="row">
											<th width="5%" style="text-align: center;">选择</th>
											<th style="text-align: center;">商品名称</th>
											<th style="text-align: center;">商品编码</th>
											<th style="text-align: center;">色系名称</th>
											<th style="text-align: center;">款号</th>
											<th style="text-align: center;">品牌名称</th>
											<!--  
											<th style="text-align: center;">门店名称</th>
											-->
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="organization_form" action="">
										<div class="col-lg-12">
										</div>
										&nbsp; 
										<input type="hidden" id="colorCode_form" name="colorCode" />
										<input type="hidden" id="colorName_form" name="colorName" />
										<input type="hidden" id="modelCode_form" name="modelCode" />
										<input type="hidden" id="productName_form" name="productName" />
										<input type="hidden" id="productCode_form" name="productCode" />
										<input type="hidden" id="brandName_form" name="brandName" />
									</form>
								</div>
								<div id="organizationOnePagination"></div>
							</div>
						</div>
						<!-- Templates -->
						<p style="display: none">
							<textarea id="organizationZero-list" rows="0" cols="0">
							
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.skuCode}" value="{$T.Result.skuCode}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="product_name_{$T.Result.skuCode}">{$T.Result.product_name}</td>
													<td align="center" id="product_sid_{$T.Result.skuCode}">{$T.Result.product_sid}</td>
													<td align="center" style="display:none;" id="colorCode_{$T.Result.skuCode}">{$T.Result.colorCode}</td>
													<td align="center" id="colorName_{$T.Result.skuCode}">{$T.Result.colorName}</td>
													<td align="center" id="modelCode_{$T.Result.skuCode}">{$T.Result.modelCode}</td>
													<td align="center" style="display:none;" id="brandCode_{$T.Result.skuCode}">{$T.Result.brandCode}</td>
													<td align="center" id="brandName_{$T.Result.skuCode}">{$T.Result.brandName}</td>
													<!--  
													<td align="center" style="display:none;" id="storeCode_{$T.Result.skuCode}">{$T.Result.storeCode}</td>
													<td align="center" id="storeName_{$T.Result.skuCode}">{$T.Result.storeName}</td>
													-->
													<td align="center" style="display:none;" id="categoryCode_{$T.Result.skuCode}">{$T.Result.categoryCode}</td>
													<td align="center" style="display:none;" id="categoryName_{$T.Result.skuCode}">{$T.Result.categoryName}</td>
													<td align="center" style="display:none;" id="sex_{$T.Result.skuCode}">{$T.Result.sex}</td>
													<td align="center" style="display:none;" id="content_{$T.Result.skuCode}">{$T.Result.content}</td>
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
</body>
</html>