<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	var organizationZeroPagination;
	$(function() {
		initOrganizationZero();
		$("#pageSelect").change(organizationZeroQuery);
	});
	function organizationZeroQuery() {
		$("#organizationName_from").val($("#organizationName_input").val());
		$("#organizationCode_from").val($("#organizationCode_input").val());
		var params = $("#supplierInfo_form").serialize();
        LA.sysCode = '16';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('organization.queryOrganizationZero', '集团查询：' + params, getCookieValue("username"),  sessionId);
		params = decodeURI(params);
		organizationZeroPagination.onLoad(params);
	}
	function find() {
		organizationZeroQuery();
	}
	function reset() {
		$("#organizationName_input").val("");
		$("#organizationCode_input").val("");
		organizationZeroQuery();
	}
	//只选一个
	function selectOne(one){
		$("input[type='checkbox']:checked").each(function(){
			if(this != one){
				$(this).attr("checked",false);
			}
		});
	}
	//初始化
	function initOrganizationZero() {
		var url = __ctxPath + "/organization/queryOrganizationZero?organizationType=" + "0";
		organizationZeroPagination = $("#organizationZeroPagination").myPagination(
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
		var url = __ctxPath + "/jsp/organization/addOrganizationZero.jsp";
		$("#pageBody").load(url);
	}
	function editOrganization() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text(buildErrorMessage("","只能选择一行！"));
	        $("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text(buildErrorMessage("","请选取要修改的行！"));
	        $("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		sid = value;
		organizationCode_ = $("#organizationCode_" + value).text().trim();
		organizationName_ = $("#organizationName_" + value).text().trim();
		parentSid_ = $("#parentSid_" + value).text().trim();
		groupSid_ = $("#groupSid_" + value).text().trim();
		organizationType_ = 0;
		organizationStatus = $("#organizationStatus_" + value).text().trim();
		if (organizationStatus == "禁用") {
			organizationStatus_ = 1;
		} else if (organizationStatus == "可用") {
			organizationStatus_ = 0;
		}
		createName_ = $("#createName_" + value).text().trim();
		updateName_ = $("#updateName_" + value).text().trim();

		var url = __ctxPath + "/jsp/organization/editOrganizationZero.jsp";
		$("#pageBody").load(url);
	}
	function delSupplierInfo() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text(buildErrorMessage("","只能选择一行！"));
	        $("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text(buildErrorMessage("","请选取要删除的行！"));
	        $("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		var url = __ctxPath + "/supplierDisplay/deleteSupplier";
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : url,
					dataType : "json",
					data : {
						"sid" : value
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>删除成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
						} else {
							$("#warning2Body").text(buildErrorMessage("","删除失败！"));
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
		$("#pageBody").load(__ctxPath + "/jsp/organization/organizationZeroView.jsp");
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
								<h5 class="widget-caption">集团管理</h5>
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
										<a id="editabledatatable_new" onclick="addOrganization();"
											class="btn btn-primary"> <i class="fa fa-plus"></i> 添加集团
										</a>&nbsp;&nbsp;&nbsp;&nbsp; <a id="editabledatatable_new"
											onclick="editOrganization();" class="btn btn-info"> <i
											class="fa fa-wrench"></i> 修改集团
										</a>&nbsp;&nbsp;
										<!-- <a id="editabledatatable_new" onclick="delSupplierInfo();"
										class="btn btn-danger"> <i class="fa fa-times"></i> 删除集团 </a> -->
									</div>
								</div>
								<div class="table-toolbar">
									<span>集团名称：</span> <input maxlength="20" type="text" id="organizationName_input" />&nbsp;&nbsp;&nbsp;&nbsp;
									<span>集团编码：</span> <input maxlength="20" type="text" id="organizationCode_input" />&nbsp;&nbsp;&nbsp;&nbsp;
									<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a class="btn btn-default shiny" onclick="reset();">重置</a>
								</div>
								<table
									class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="organizationZero_tab">
									<thead class="flip-content bordered-darkorange">
										<tr role="row">
											<th width="5%" style="text-align: center;">选择</th>
											<th style="text-align: center;">集团名称</th>
											<th style="text-align: center;">集团编码</th>
											<th style="text-align: center;">机构类别</th>
											<th style="text-align: center;">集团状态</th>

										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="supplierInfo_form" action="">
										<div class="col-lg-12">
											<select id="pageSelect" name="pageSize">
												<option>5</option>
												<option selected="selected">10</option>
												<option>15</option>
												<option>20</option>
											</select>
										</div>
										&nbsp; 
										<input type="hidden" id="organizationName_from" name="organizationName" />
										<input type="hidden" id="organizationCode_from" name="organizationCode" />
									</form>
								</div>
								<div id="organizationZeroPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display: none">
								<textarea id="organizationZero-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" onclick="selectOne(this);">
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="parentSid_{$T.Result.sid}" style="display:none">{$T.Result.parentSid}</td>
													<td align="center" id="groupSid_{$T.Result.sid}" style="display:none">{$T.Result.groupSid}</td>
													<td align="center" id="organizationName_{$T.Result.sid}">{$T.Result.organizationName}</td>
													<td align="center" id="organizationCode_{$T.Result.sid}">{$T.Result.organizationCode}</td>
													<td align="center" id="organizationType_{$T.Result.sid}">
														{#if $T.Result.organizationType == 0}
															<span>集团</span>
														{#elseif $T.Result.organizationType == 1}
															<span>大区</span>
														{#elseif $T.Result.organizationType == 2}
															<span>城市</span>
														{#elseif $T.Result.organizationType == 3}
															<span>门店</span>
														{#/if}
													</td>
													
													<td align="center" id="organizationStatus_{$T.Result.sid}">
														{#if $T.Result.organizationStatus == 1}
															<span class="label label-darkorange graded">禁用</span>
														{#elseif $T.Result.organizationStatus == 0}
															<span class="label label-success graded">可用</span>
														{#/if}
													</td>
													<td align="center" style="display:none;" id="storeType_{$T.Result.sid}">
														{#if $T.Result.storeType == 1}
															<span>电商</span>
														{#elseif $T.Result.storeType == 2}
															<span>北京</span>
														{#elseif $T.Result.storeType == 3}
															<span>其他门店</span>
														{#/if}
													</td>
													
													<td align="center" style="display:none;" id="shippingPoint_{$T.Result.sid}">
													{#if $T.Result.shippingPoint != '[object Object]'}
														{$T.Result.shippingPoint}
													{#/if}
													</td>
													<td align="center" style="display:none;" id="areaCode_{$T.Result.sid}">
													{#if $T.Result.areaCode != '[object Object]'}
														{$T.Result.areaCode}
													{#/if}
													</td>
													
													<td align="center" style="display:none;" id="createName_{$T.Result.sid}">
													{#if $T.Result.createName != '[object Object]'}
														{$T.Result.createName}
													{#/if}
													</td>
													
													<td align="center" style="display:none;" id="updateName_{$T.Result.sid}">
													{#if $T.Result.updateName != '[object Object]'}
														{$T.Result.updateName}
													{#/if}
													</td>
													
													<td align="center" style="display:none;" id="createTimeStr_{$T.Result.sid}">
													{#if $T.Result.createTimeStr != '[object Object]'}
														{$T.Result.createTimeStr}
													{#/if}
													</td>
													<td align="center" style="display:none;" id="updateTimeStr_{$T.Result.sid}">
													{#if $T.Result.updateTimeStr != '[object Object]'}
														{$T.Result.updateTimeStr}
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
</body>
</html>