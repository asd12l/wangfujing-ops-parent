<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 广告版位列表
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsp/web/css/webStyle.css" />
<script src="${pageContext.request.contextPath}/js/jquery/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery.validate.messages_cn.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/js/bootstrap/css/components.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/js/customize/advertise/edit_advertise_space.js"></script>
<script src="${pageContext.request.contextPath}/js/customize/advertise/add_advertise_space.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var sessionId = "<%=request.getSession().getId() %>";
	image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";
	//查询出的广告版位 位置的个数
	var spaceCount="";
	var advertisingSpacePagination;
	$(function() {
		$("#pageSelect").change(advertisingSpaceQuery);
	});
	function initTree(){
		$("#_site_id_param").val(siteSid);
		initPropsdict();
		loadLogJs();
	}
	function loadLogJs(){
        $.ajax({
            type : "get",
            contentType : "application/x-www-form-urlencoded;charset=utf-8",
            url : __ctxPath + "/loadSystemParam/findValueFronSystemParamByKey",
            async : false,
            data : {
                "key" : "log_js"
            },
            dataType : "json",
            ajaxStart : function() {
                $("#loading-container").prop("class", "loading-container");
            },
            ajaxStop : function() {
                $("#loading-container").addClass("loading-inactive");
            },
            success : function(response) {
                if(response.success){
                    var logjs_url = response.value;
                    var _script=document.createElement('script');
                    _script.setAttribute('charset','gbk');
                    _script.setAttribute('type','text/javascript');
                    _script.setAttribute('src',logjs_url);
                    document.getElementsByTagName('head')[0].appendChild(_script);
                } else {
                    $("#warning2Body").text(response.msg);
                    $("#warning2").show();
                }
            }
        });
    }
	function initPropsdict() {
		var url = __ctxPath + "/advertisingSpace/list_by_position?_site_id_param="+siteSid;
		
		advertisingSpacePagination = $("#advertisingSpacePagination").myPagination(
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
						contentType : "application/json;charset=utf-8",
						url : url,
						dataType : 'json',
						data : $("#advertisingSpace_form").serialize(),
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
						callback : function(data) {
							//使用模板
							$("#propsdict_tab tbody").setTemplateElement(
									"propsdict-list").processTemplate(data);
						}
					}
				});
	}
	function queryAdvertising(){
		$("#pageBody").load(__ctxPath + "/jsp/advertise/list.jsp");
	}
	function addPropsdict() {
		userName = getCookieValue("username");
    	LA.sysCode = '54';
		LA.log('advertiseSpace-addPropsdict', '添加广告版位', userName,  sessionId);
		initPosition();
		if(spaceCount==0){
			$("#model-body-warning")
			.html(
					"<strong>位置已满!</strong>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
		}else{
			clearInput();
			$("#name").parent().find("i").removeClass("fa-warning");
			$("#name").parent().parent().parent().removeClass("has-error");
			$("#addSpaceDIV").show();
			$("#site_id_add").val(siteSid);
			
		}
		//$("#pageBody").load(__ctxPath + "/jsp/advertise_space/add.jsp?siteSid="+siteSid);
	}
	function editPropsdict() {
		userName = getCookieValue("username");
    	LA.sysCode = '54';
		LA.log('advertiseSpace-editPropsdict', '编辑广告版位', userName,  sessionId);
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#model-body-warning")
					.html(
							"<strong>只能选择一列!</strong>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		} else if (checkboxArray.length == 0) {
			$("#model-body-warning")
					.html(
							"<strong>请选取要修改的列!</strong>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		value = checkboxArray[0];
		adspaceName = $("#adspaceName" + value).text().trim();
		position=$("#position"+value).text().trim();
		adspaceDesc = $("#adspaceDesc" + value).text().trim();
		position_name = $("#position_name"+value).text().trim();
		adspaceEnabled = $("#adspaceEnabled" + value).text().trim();
		position_id = $("#position_id"+value).text().trim();
		//initPosition();
		$("#editSpaceDIV").show();
		if(adspaceEnabled == "启用"){
			$("#edit_enabled1").click();
		}else if(adspaceEnabled == "未启用"){
			$("#edit_enabled2").click();
		}
		$("#position_id").val(position_id);
		$("#space_id").val(value);
		$("#edit_name").val(adspaceName);
		$("#edit_desc").val(adspaceDesc);
		$("#edit_position").val(position_name);
		
		//$("#pageBody").load(__ctxPath + "/jsp/advertise_space/edit.jsp");
	}
	function delPropsdict() {
		userName = getCookieValue("username");
    	LA.sysCode = '54';
		LA.log('advertiseSpace-delPropsdict', '删除 广告版位', userName,  sessionId);
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#model-body-warning")
					.html(
							"<strong>只能选择一列!</strong>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		} else if (checkboxArray.length == 0) {
			$("#model-body-warning")
					.html(
							"<strong>请选取要补充的列!</strong>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		var value = checkboxArray[0];
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
		
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/advertisingSpace/del",
					dataType : "json",
					ajaxStart: function() {
						$("#loading-container").attr("class","loading-container");
					},
					ajaxStop: function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container").addClass("loading-inactive")
						},300);
					},
					data : {
						"id" : value
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							initPropsdict();
						} else {
							$("#model-body-warning")
									.html(
											"<strong>删除失败!</strong>");
							$("#modal-warning").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
						}
						return;
					}
				});
		
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
	function advertisingSpaceQuery() {
		$("#_site_id_param").val(siteSid);
		var params = $("#advertisingSpace_form").serialize();
		params = decodeURI(params);
		advertisingSpacePagination.onLoad(params);
	}
	
	//成功后确认
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
		//$("#pageBody").load(__ctxPath + "/jsp/advertise_space/list.jsp");
	}
</script>
<script src="${pageContext.request.contextPath}/js/customize/common/common.js"></script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
			
			<%@ include file="../web/site/site_chose.jsp"%>
			
				<div class="widget">
					<div class="widget-header">
						<h5 class="widget-caption">广告版位</h5>
						<div class="widget-buttons">
							<a href="#" data-toggle="collapse" onclick="tab('pro');"> <i class="fa fa-minus" id="pro-i"></i></a>
						</div>
					</div>
					<div class="widget-body clearfix" id="pro">
						<div class="table-toolbar clearfix">
							<a id="editabledatatable_new" onclick="addPropsdict();" class="btn btn-primary glyphicon glyphicon-plus">添加广告版位 </a>&nbsp;&nbsp;
							<a id="editabledatatable_new" onclick="editPropsdict();" class="btn btn-info glyphicon glyphicon-wrench">修改广告版位 </a>&nbsp;&nbsp;
							<a id="editabledatatable_new" onclick="delPropsdict();" class="btn btn-danger glyphicon glyphicon-trash">删除广告版位 </a>
						</div>
						<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="propsdict_tab">
							<thead class="flip-content bordered-darkorange">
								<tr role="row">
									<th style="text-align: center;" width="75px;">选择</th>
									<th style="text-align: center;">名称</th>		
									<th style="text-align: center;">位置</th>				
									<th style="text-align: center;">状态</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<div class="pull-left" style="margin-top: 5px;">
							<form id="advertisingSpace_form" action="">
								<select id="pageSelect" name="pageSize">
									<option>5</option>
									<option selected="selected">10</option>
									<option>15</option>
									<option>20</option>
								</select>
								<input type="hidden" name="_site_id_param" id="_site_id_param"/>
							</form>
						</div>
						<div id="advertisingSpacePagination"></div>
						<!-- Templates -->
						<p style="display: none">
							<textarea id="propsdict-list" rows="0" cols="0">
								<!--
								{#template MAIN}
									{#foreach $T.list as Result}
										<tr class="gradeX">
											<td align="left">
												<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
													<label>
														<input type="checkbox" id="tdCheckbox_{$T.Result.adspace_id}" value="{$T.Result.adspace_id}" >
														<span class="text"></span>
													</label>
												</div>
											</td>
											<td align="center" id="adspaceName{$T.Result.adspace_id}">{$T.Result.ad_name}</td>
											<td align="center" id="position_name{$T.Result.adspace_id}">{$T.Result.name}</td>
											<td align="center" style="display:none;" id="position{$T.Result.adspace_id}">{$T.Result.position}</td>
											<td align="center" style="display:none;" id="position_id{$T.Result.adspace_id}">{$T.Result.Id}</td>
											<td align="center" style="display:none;" id="adspaceDesc{$T.Result.adspace_id}">{$T.Result.description}</td>
											{#if $T.Result.is_enabled==true}
											<td align="center" id="adspaceEnabled{$T.Result.adspace_id}" value="{$T.Result.is_enabled}">
												<span class="label label-success graded">启用</span>
											</td>
											{#else}
											<td align="center" id="adspaceEnabled{$T.Result.adspace_id}" value="{$T.Result.is_enabled}">
											        <span>未启用</span>
											</td>
											{#/if}
							       		</tr>
									{#/for}
							    {#/template MAIN}	-->
							</textarea>
						</p>
					</div>
				</div>
				<!-- /Page Body -->
			</div>
			<!-- /Page Content -->
		</div>
		<!-- /Page Container -->
<%@ include file="editSpace.jsp"%>
<%@ include file="addSpace.jsp"%>

</body>
</html>