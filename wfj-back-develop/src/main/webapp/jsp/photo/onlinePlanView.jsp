<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<style>
 .input_textarea{
  z-index:9999;
 }
</style>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	var organizationOnePagination;
	var onlineSid;
	$(function() {
		
		initOrganizationOne();
		$("#groupSid_select").change(organizationOneQuery); 
		$("#pageSelect").change(organizationOneQuery);
	});
	
	
	
	
	function organizationOneQuery() {
		$("#groupSid_form").val($("#groupSid_select").val());
		$("#organizationName_form").val($("#organizationName_input").val());
		$("#organizationCode_form").val($("#organizationCode_input").val());
		var params = $("#organization_form").serialize();
		params = decodeURI(params);
		organizationOnePagination.onLoad(params);
	}
	function find() {
		organizationOneQuery();
	}
	function reset() {
		$("#groupSid_select").val("");
		$("#organizationName_input").val("");
		$("#organizationCode_input").val("");
		organizationOneQuery();
	}
	//初始化
	function initOrganizationOne() {
		var url = $("#ctxPath").val() + "/photo/queryOnlinPlanList";
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
						if(!(data.pageCount==0||data.pageCount=="0")){
							//使用模板
							$("#organizationZero_tab tbody").setTemplateElement("organizationZero-list").processTemplate(data);
						}

					}
				}
			});
	}
	
	function addOrganization() {
		var url = __ctxPath + "/jsp/photo/addOnlinePlan.jsp";
		$("#pageBody").load(url);
	}
	
	function editOrganization() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要修改的行!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		sid = value;
		//alert($("#on_line_state_input_"+sid).val());
		if($("#on_line_state_input_"+sid).val()==2 ||$("#on_line_state_input_"+sid).val()=="2"){
			$("#warning2Body").text("已上线拍照计划不能编辑!");
			$("#warning2").show();
			return false;
		}

		var url = __ctxPath + "/jsp/photo/editOnlinePlanName.jsp";
		$("#pageBody").load(url);
	}
	
	function addProduct() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要增加商品的上线计划!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		sid = value;
		
		if($("#on_line_state_input_"+sid).val()==2 ||$("#on_line_state_input_"+sid).val()=="2"){
			$("#warning2Body").text("已上线拍照计划不能编辑!");
			$("#warning2").show();
			return false;
		}

		var url = __ctxPath + "/jsp/photo/editAddProduct.jsp";
		$("#pageBody").load(url);
	}
	function delProduct() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要删除商品的上线计划!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		sid = value;
		
		if($("#on_line_state_input_"+sid).val()==2 ||$("#on_line_state_input_"+sid).val()=="2"){
			$("#warning2Body").text("已上线拍照计划不能编辑!");
			$("#warning2").show();
			return false;
		}
		
		var url = __ctxPath + "/jsp/photo/editDelProduct.jsp";
		$("#pageBody").load(url);
	}
	
	function excelStock() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要发布的上线计划!");
			$("#warning2").show();
			return false;
		}
		
		if($("#on_line_state_input_"+checkboxArray[0]).val()==2 ||$("#on_line_state_input_"+checkboxArray[0]).val()=="2"){
			$("#warning2Body").text("已上线拍照计划不能重新发布!");
			$("#warning2").show();
			return false;
		}
		
		selectPhotoCenter(checkboxArray[0]);
	}
	
	function selectPhotoCenter(id) {
		onlineSid=id;
		
		$("#selectPhotoCenterDiv").show();
		$("#selectPhotoCenterName").text("选择拍照中心");
		initSelectPhotoCenter();
	}
	function initSelectPhotoCenter() {
		var parentSid = $("#parentSid");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/photo/selectPhotoCenter",
			dataType: "json",
			success: function(response) {
				var result = response;
				parentSid.html("<option value=''>请选择拍照中心</option>");
				for ( var i = 0; i < result.data.length; i++) {
					var ele = result.data[i];
					var option;
					option = $("<option value='" + ele.photocenter + "'>" + ele.photocentername + "</option>");
					option.appendTo(parentSid);
				}
				return;
			}
		});
	}
	function closeSelectPhotoCenterDiv() {
		$("#selectPhotoCenterDiv").hide();
	}
	function confirmSelectPhotoCenterDiv() {
	
		var photoCenterCode = $("#parentSid").val();
		var photoCenterName = $("#parentSid").find("option:selected").text().trim();
		
		if (photoCenterCode=="") {
			$("#warning2").addClass("input_textarea");
			$("#warning2Body").text("请选择拍照中心!");
			$("#warning2").show();
			return false;
		} 
	
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath
					+ "/photo/releaseOnlinePlan",
			async : false,
			dataType : "json",
			data : {
				"on_line_id":onlineSid,
				"photoCenterCode":photoCenterCode,
				"photoCenterName":photoCenterName
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
					$("#warning2Body").text("成功发布上线计划！");
					$("#warning2").show();
					productQuery();
				}else{
					$("#warning2").addClass("input_textarea");
					$("#warning2Body").text(response.errMsg);
					$("#warning2").show();
				}
			}	
		});
	}
	
	
	function delPropsdict() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要删除的上线计划!");
			$("#warning2").show();
			return false;
		}
		
		if($("#on_line_state_input_"+checkboxArray[0]).val()==2 ||$("#on_line_state_input_"+checkboxArray[0]).val()=="2"){
			$("#warning2Body").text("已上线拍照计划不能删除!");
			$("#warning2").show();
			return false;
		}
		
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath
					+ "/photo/delOnlinePlan",
			async : false,
			dataType : "json",
			data : {
				"on_line_id":checkboxArray[0]
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
					$("#warning2Body").text("成功删除上线计划！");
					$("#warning2").show();
					productQuery();
				}else{
					$("#warning2Body").text(response.errMsg);
					$("#warning2").show();
					
				}
			}	
		});
	}
	function productQuery() {
		var url = __ctxPath + "/jsp/photo/onlinePlanView.jsp";
		$("#pageBody").load(url);
	}
	function delSupplierInfo() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一行!</strong></div>");
			$("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
			return false;
		} else if (checkboxArray.length == 0) {
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要删除的行!</strong></div>");
			$("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
			return false;
		}
		var value = checkboxArray[0];
		var url = __ctxPath + "/supplierDisplay/deleteSupplier";
		$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : url,
				dataType : "json",
				data : {
					"sid" : value
				},
				success : function(response) {
					if (response.success == "true") {
						$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>删除成功，返回列表页!</strong></div>");
						$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
					} else {
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
						$("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
					}
					return;
				}
			});
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
	
	function queryDetail(on_line_name,on_line_id) {
		
		$("#stockHisDiv").show();
		//给显示拍照计划名称赋值
		$("#stockHisChannelName").text(on_line_name+"明细");
		initStockHis(on_line_id);
	}
	var stockHisPagination;
	function initStockHis(on_line_id) {
		var url = $("#ctxPath").val() + "/photo/queryOnlinePlanByIDPage?on_line_id=" + on_line_id;
		stockHisPagination = $("#stockHisPagination").myPagination(
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
							$("#stockHis_tab tbody").setTemplateElement(
									"stockHis-list").processTemplate(data);
						}
					}
				});
	}
	function closeStockHisDiv() {
		$("#stockHisDiv").hide();
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
								<h5 class="widget-caption">上线计划管理</h5>
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
											class="btn btn-primary"> <i class="fa fa-plus"></i> 添加上线计划
										</a>&nbsp;&nbsp;&nbsp;&nbsp; 
										<a id="editabledatatable_new" onclick="editOrganization();" 
											class="btn btn-info"> <i class="fa fa-wrench"></i> 修改上线计划名称
										</a>&nbsp;&nbsp;&nbsp;&nbsp; 
										<a id="editabledatatable_new" onclick="addProduct();"
											class="btn btn-info"> <i class="fa fa-wrench"></i> 上线计划中增加商品
										</a>&nbsp;&nbsp;&nbsp;&nbsp; 
										<a id="editabledatatable_new" onclick="delProduct();"
											class="btn btn-info"> <i class="fa fa-wrench"></i> 上线计划中删除商品 
										</a>&nbsp;&nbsp;&nbsp;&nbsp;
										<a id="editabledatatable_new" onclick="delPropsdict();"
												class="btn btn-danger glyphicon glyphicon-trash"> 删除上线计划 
										</a>&nbsp;&nbsp;&nbsp;&nbsp;
										<a id="editabledatatable_new" onclick="excelStock();" 	
											class="btn btn-yellow"> <i class="fa fa-edit"></i> 发布上线计划
										</a>&nbsp;&nbsp;&nbsp;&nbsp; 
									</div>
								</div>
								<div class="table-toolbar">
									<span>上线计划状态：</span>
										<select id="groupSid_select" style="width:200px;padding: 0px 0px">
											<option value="0" selected="selected">全部</option>
											<option value="1" >未发布</option>
											<option value="2" >已发布</option>
										</select>&nbsp;&nbsp;&nbsp;&nbsp;
									<span>上线计划名称：</span> <input type="text" maxlength="20" id="organizationName_input" />&nbsp;&nbsp;&nbsp;&nbsp; 
									<span>上线计划编码：</span> <input type="text" maxlength="20" id="organizationCode_input" />&nbsp;&nbsp;&nbsp;&nbsp; 
									<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a class="btn btn-default shiny" onclick="reset();">重置</a>
								</div>
								<table
									class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="organizationZero_tab">
									<thead class="flip-content bordered-darkorange">
										<tr role="row">
											<th width="5%" style="text-align: center;">选择</th>
											<th style="text-align: center;">上线计划名称</th>
											<th style="text-align: center;">上线计划编码</th>
											<th style="text-align: center;">拍照中心名称</th>
											<th style="text-align: center;">上线计划状态</th>
											<th style="text-align: center;">更新时间</th>
											<th style="text-align: center;">查看明细</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="pull-left" style="margin-top: 5px;">
									<form id="organization_form" action="">
										<div class="col-lg-12">
											<select id="pageSelect" name="pageSize"
												style="padding: 0 12px;">
												<option>5</option>
												<option selected="selected">10</option>
												<option>15</option>
												<option>20</option>
											</select>
										</div>
										&nbsp; 
										<input type="hidden" id="groupSid_form" name="groupSid" />
										<input type="hidden" id="organizationName_form" name="organizationName" />
										<input type="hidden" id="organizationCode_form" name="organizationCode" />
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
																<input type="checkbox" id="tdCheckbox_{$T.Result.on_line_id}" value="{$T.Result.on_line_id}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" style="display:none;" id="createmen_{$T.Result.on_line_id}">{$T.Result.createmen}</td>
													<td align="center" style="display:none;" id="createtime_{$T.Result.on_line_id}">{$T.Result.createtime}</td>
													<td align="center" style="display:none;" id="releasemen_{$T.Result.on_line_id}">{$T.Result.releasemen}</td>
													<td align="center" style="display:none;" id="releasetime_{$T.Result.on_line_id}">{$T.Result.releasetime}</td>
													
													<td align="center" id="on_line_name_{$T.Result.on_line_id}">{$T.Result.on_line_name}</td>
													<td align="center" id="on_line_id_{$T.Result.on_line_id}">{$T.Result.on_line_id}</td>
													<td align="center" style="display:none;" id="photo_store_code_{$T.Result.on_line_id}">{$T.Result.photo_store_code}</td>
													<td align="center" id="photo_store_name_{$T.Result.on_line_id}">{$T.Result.photo_store_name}</td>
													
													<td align="center" id="on_line_state_{$T.Result.on_line_id}">
														<input id="on_line_state_input_{$T.Result.on_line_id}" value="{$T.Result.on_line_state}" style="display:none;" ></input>
														{#if $T.Result.on_line_state == 1}
															<span >未发布</span>
														{#elseif $T.Result.on_line_state == 2}
															<span class="label label-success graded">已发布</span>
														{#/if}
													</td>
													
													<td align="center" style="display:none;" id="opt_name_{$T.Result.on_line_id}">{$T.Result.opt_name}</td>
													<td align="center" id="opt_time_{$T.Result.on_line_id}">{$T.Result.opt_time}</td>
													
													<td align="center">
														<a onclick="queryDetail('{$T.Result.on_line_name}','{$T.Result.on_line_id}')" style="cursor:pointer;color:blue">
															查看明细
														</a>
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
	
	
		<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="stockHisDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeStockHisDiv();">×</button>
					<h2 class="modal-title" id="divTitle"><label id="stockHisChannelName"></label></h2>
				</div>
				<div class="page-body">
					<div class="row">
						<div class="col-xs-12 col-md-12">
							<div class="widget">
								<table id="stockHis_tab"
									class="table table-bordered table-striped table-condensed table-hover flip-content">
									<thead class="flip-content bordered-darkorange">
										<tr role="row">
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
									<form id="stockHis_form" action="">
									</form>
								</div>
								<div id="stockHisPagination"></div>
							</div>

							<!-- Templates -->
							<p style="display: none">
								<textarea id="stockHis-list" rows="0" cols="0">
									  {#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX">
												<td align="center" style="display:none;" id="goods_id_{$T.Result.skucode}">{$T.Result.goods_id}</td>
												<td align="center" style="display:none;" id="on_line_id_{$T.Result.skucode}">{$T.Result.on_line_id}</td>
												<td align="center" id="skuname_{$T.Result.skucode}">{$T.Result.skuname}</td>
												<td align="center" id="skucode_{$T.Result.skucode}">{$T.Result.skucode}</td>
												<td align="center" style="display:none;" id="colorcode_{$T.Result.skucode}">{$T.Result.colorcode}</td>
												<td align="center" id="colorcodename_{$T.Result.skucode}">{$T.Result.colorcodename}</td>
												<td align="center" id="modelcode_{$T.Result.skucode}">{$T.Result.modelcode}</td>
												<td align="center" style="display:none;" id="brandcode_{$T.Result.skucode}">{$T.Result.brandcode}</td>
												<td align="center" id="brandname_{$T.Result.skucode}">{$T.Result.brandname}</td>
												<td align="center" style="display:none;" id="categotyscode_{$T.Result.skucode}">{$T.Result.categotyscode}</td>
												<td align="center" style="display:none;" id="categotys_{$T.Result.skucode}">{$T.Result.categotys}</td>
												<td align="center" style="display:none;" id="sexsid_{$T.Result.skucode}">{$T.Result.sexsid}</td>
												<td align="center" style="display:none;" id="createmen_{$T.Result.skucode}">{$T.Result.createmen}</td>
												<td align="center" style="display:none;" id="createtime_{$T.Result.skucode}">{$T.Result.createtime}</td>
												<td align="center" style="display:none;" id="releasemen_{$T.Result.skucode}">{$T.Result.releasemen}</td>
												<td align="center" style="display:none;" id="releasestate_{$T.Result.skucode}">{$T.Result.releasestate}</td>
												<td align="center" style="display:none;" id="joinmen_{$T.Result.skucode}">{$T.Result.joinmen}</td>
												<td align="center" style="display:none;" id="jointime_{$T.Result.skucode}">{$T.Result.jointime}</td>
												<td align="center" style="display:none;" id="opt_name_{$T.Result.skucode}">{$T.Result.opt_name}</td>
												<td align="center" style="display:none;" id="opt_time_{$T.Result.skucode}">{$T.Result.opt_time}</td>
												<!--  
												<td align="center" style="display:none;" id="storeCode_{$T.Result.skucode}">{$T.Result.storeCode}</td>
												<td align="center" id="storeName_{$T.Result.skucode}">{$T.Result.storeName}</td>
												-->
								       		</tr>
										{#/for}
									{#/template MAIN}	
								</textarea>
							</p>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default" type="button"
						onclick="closeStockHisDiv();">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
			<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="selectPhotoCenterDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeSelectPhotoCenterDiv();">×</button>
					<h2 class="modal-title" id="divTitle"><label id="selectPhotoCenterName"></label></h2>
				</div>
				<div class="page-body">
					<div class="form-group">
						<div class="col-lg-8 col-sm-8 col-xs-8 col-lg-offset-2">
							<label class="control-label ">拍照中心：</label>
							
							<select class="form-control" id="parentSid" name="parentSid">
								<option value="">请选择拍照中心</option>
							</select>
				</div>
				<div class="modal-footer">
				</div>
				<div class="col-lg-offset-4 col-lg-6">
						<input class="btn btn-success" style="width: 25%;" onclick="confirmSelectPhotoCenterDiv();" type="button" value="确定" />&emsp;&emsp;
						<input class="btn btn-danger" style="width: 25%;" onclick="closeSelectPhotoCenterDiv();" type="button" value="取消" />
					</div>
				<div class="modal-footer">
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
</body>
</html>