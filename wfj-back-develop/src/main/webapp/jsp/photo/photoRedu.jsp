<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script>
__ctxPath = "${pageContext.request.contextPath}";

var organizationOnePagination;
var onlineSid;
$(function() {
	
	initSelectList();
	initOrganizationOne();
	$("#groupSid_select").change(organizationOneQuery); 
	$("#pageSelect").change(organizationOneQuery);
	
});
function initSelectList() {
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/photo/queryListguige",
			dataType: "json",
			success: function(response) {
				var result = response;
				var groupSid = $("#groupSid_select");
				for ( var i = 0; i < result.list.length; i++) {
					var ele = result.list[i];
					var option;
					option = $("<option value='" + ele + "'>"
							+ ele+"</option>");
					option.appendTo(groupSid);
				}
				return;
			}
		});
}
function reset() {
	$("#groupSid_select").val("");
	$("#organizationName_input").val("");
	$("#organizationCode_input").val("");
	organizationOneQuery();
}

function initOrganizationOne() {
		var url = $("#ctxPath").val() + "/photo/queryPhotoguige";
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


function organizationOneQuery() {
	$("#groupSid_form").val($("#groupSid_select").val());
	$("#photoname_form").val($("#organizationName_input").val());
	//$("#organizationCode_form").val($("#organizationCode_input").val());
	var params = $("#organization_form").serialize();
	params = decodeURI(params);
	organizationOnePagination.onLoad(params);
}
function find() {
	organizationOneQuery();
}
function addOrganization() {
	var url = __ctxPath + "/jsp/photo/addguige.jsp";
	$("#pageBody").load(url);
		
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
		$("#warning2Body").text("请选取要删除的规格!");
		$("#warning2").show();
		return false;
	}
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath
				+ "/photo/deletePhotoguige",
		async : false,
		dataType : "json",
		data : {
			"photo_id":checkboxArray[0]
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
				$("#warning2Body").text("成功删除规格！");
				$("#warning2").show();
				productQuery();
			}else{
				alert(response.errMsg);
				$("#warning2Body").text(response.errMsg);
				$("#warning2").show();
				
			}
		}	
	});
}
function productQuery() {
	var url = __ctxPath + "/jsp/photo/photoRedu.jsp";
	$("#pageBody").load(url);
}
function edit() {
	var checkboxArray = new Array();
	var checkboxArray_width = new Array();
	var checkboxArray_height = new Array();
	$("input[type='checkbox']:checked").each(function(i, team) {
		var productSid = $(this).val();
		
		checkboxArray.push(productSid);
		
		var widthVal = $("#width_"+productSid).html().trim();
		checkboxArray_width.push(widthVal);
		
		var heightVal = $("#height_"+productSid).html().trim();
		checkboxArray_height.push(heightVal);
		
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
	var val1 = checkboxArray_width[0];
	var val2= checkboxArray_height[0];
	
	sid = value;
	width=val1;
	height=val2;
	
	var url = __ctxPath + "/jsp/photo/editguige.jsp";
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
								<h5 class="widget-caption">图片压缩管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<span>规格：</span>
										<select id="groupSid_select" style="width:200px;padding: 0px 0px">
											<option value="" selected="selected">请选择</option>
										</select>&nbsp;&nbsp;&nbsp;&nbsp;
									<span>名称：</span> <input type="text" maxlength="20" id="organizationName_input" />&nbsp;&nbsp;&nbsp;&nbsp; 
									<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;&nbsp;&nbsp;
										<a id="editabledatatable_new" onclick="addOrganization();"
											class="btn btn-primary"> <i class="fa fa-plus"></i> 添加规格
										</a>&nbsp;&nbsp;&nbsp;&nbsp; 
										<a id="editabledatatable_new" onclick="delPropsdict();"
												class="btn btn-danger glyphicon glyphicon-trash"> 删除规格
										</a>&nbsp;&nbsp;&nbsp;&nbsp;
										<a id="editabledatatable_new" onclick="edit();" 
											class="btn btn-info"> <i class="fa fa-wrench"></i> 修改规格名称
										</a>&nbsp;&nbsp;&nbsp;&nbsp; 
									
								</div>
									
									
								
								<table
									class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="organizationZero_tab">
									<thead class="flip-content bordered-darkorange">
										<tr role="row">
											<th width="5%" style="text-align: center;">选择</th>
											<th style="text-align: center;">宽（单位：像素）</th>
											<th style="text-align: center;">高（单位：像素）</th>
											<th style="text-align: center;">名称</th>
											<th style="text-align: center;">备注</th>
											<!-- <th style="text-align: center;">编辑</th> -->
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
										<input type="hidden" id="photoname_form" name="photoname" />
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
																<input type="checkbox" id="tdCheckbox_{$T.Result.photo_id}" value="{$T.Result.photo_id}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="width_{$T.Result.photo_id}">{$T.Result.width}</td>
													<td align="center" id="height_{$T.Result.photo_id}">{$T.Result.height}</td>
													<td align="center" id="photoname_{$T.Result.photo_id}">{$T.Result.photoname}</td>
													<td align="center" id="remark_{$T.Result.photo_id}">{$T.Result.remark}</td>
													
												<!-- 	<td align="center">
														<a onclick="edit('{$T.Result.photo_id}')" style="cursor:pointer;color:blue">
															编辑
														</a>
													</td> -->
													
													
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
	
	
	
		
			
		
</body>
</html>