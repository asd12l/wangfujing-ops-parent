<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--Page Related Scripts-->
<html>
<head>
<script	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	
	var dataDictPagination;

	$(function() {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/dataDict/queryDataDictList",
			dataType : "json",
			async : false,
			data : "pid=0",
			success : function(response) {
				var result = response.list;
				var pid_select = $("#pid_select");
				/* pid_select.html("<option value=''>请选择</option>"); */
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					if (ele.status == '0') {
						var option = $("<option value='" + ele.sid + "'>" + ele.name + "</option>");
						option.appendTo(pid_select);
					}
				}
				return;
			},
			error : function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					$("#warning2Body").text("系统错误!");
					$("#warning2").show();
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});

		//取值回显
		if (typeof(pid_) != "undefined") {
			$("#pid_select").val(pid_);
		}
		
		initDataDict();
		$("#pageSelect").change(dataDictQuery);
		$("#pid_select").change(dataDictQuery);
	});
	
	function dataDictQuery() {
		$("#pid_from").val($("#pid_select").val());
		var params = $("#dataDict_form").serialize();
        LA.sysCode = '10';
        var sessionId = '<%=request.getSession().getId() %>';
        LA.log('dataDict.queryPageDataDict', '数据字典查询：' + params, getCookieValue("username"),  sessionId);
		params = decodeURI(params);
		dataDictPagination.onLoad(params);
	}

	//初始化数据字典列表
	function initDataDict() {
		var url = $("#ctxPath").val() + "/dataDict/queryPageDataDict";
		dataDictPagination = $("#dataDictPagination").myPagination(
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
				param : 'pid=' + $("#pid_select").val(),
				async : false,
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
					/* 使用模板 */
					$("#brand_tab tbody").setTemplateElement("brand-list").processTemplate(data);
				}
			}
		});
	}
	
	/* 添加数据 */
	function addDataDict() {
		var url;
		url = __ctxPath + "/jsp/dict/addDictView.jsp";
		$("#pageBody").load(url);
	}

	function modifyDataDict() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个数据!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要修改的数据!");
			$("#warning2").show();
			return;
		}
		value = checkboxArray[0];
		code_ = $("#code_" + value).text().trim();
		name_ = $("#name_" + value).text().trim();
		pid_ = $("#pid_" + value).text().trim();
		status_ = $("#status" + value).text().trim();

		pidName_ = $("#pid_select option:selected").text().trim();

		var url = __ctxPath + "/jsp/dict/updateDictView.jsp";
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

	function deleteDataDict() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要删除的数据!");
			$("#warning2").show();
			return false;
		}
		
		pid_ = $("#pid_select").val();
		var value = checkboxArray[0];
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/dataDict/deleteDataDict",
			dataType : "json",
			data : {
				"sid" : value
			},
			ajaxStart : function() {
				$("#loading-container").attr("class","loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive");
				}, 300);
			},
			success : function(response) {
				if (response.success == "true") {
					$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>删除成功，返回列表页!</strong></div>");
					$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
				}else if (response.data.errorMsg != "") {
					$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
					$("#warning2").show();
				}else {
					$("#warning2Body").text("删除失败!");
					$("#warning2").show();
				}
				return;
			}
		});
	}

	function successBtn() {
		$("#modal-success").attr({"style" : "display:none;","aria-hidden" : "true","class" : "modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/dict/dictView.jsp");
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
								<h5 class="widget-caption">数据字典管理</h5>
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
										<a onclick="addDataDict();" class="btn btn-primary"> 
											<i class="fa fa-plus"></i>
											添加数据字典
										</a>&nbsp;&nbsp;&nbsp;&nbsp; 
										<a onclick="modifyDataDict();" class="btn btn-info"> 
											<i class="fa fa-wrench"></i> 
											修改数据字典
										</a>&nbsp;&nbsp;&nbsp;&nbsp; 
										<a onclick="deleteDataDict();" class="btn btn-danger"> 
											<i class="fa fa-times"></i> 
											删除数据字典
										</a>
									</div>
									<div class="mtb10">
										<span>字典类型：</span> 
										<select id="pid_select" style="width: 200px; padding: 0;">
										</select>
									</div>
									<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="brand_tab">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;" width="7.5%">选择</th>
												<th style="text-align: center;">字典编码</th>
												<th style="text-align: center;">字典名称</th>
												<th id="two2" style="text-align: center; display: none;">字典类型名称</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="pull-left" style="margin-top: 5px;">
										<form id="dataDict_form" action="">
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
											<input type="hidden" id="name_from" name="name" /> 
											<input type="hidden" id="pid_from" name="pid" />
										</form>
									</div>
									<div id="dataDictPagination"></div>
								</div>

								<!-- Templates -->
								<p style="display: none">
									<textarea id="brand-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result status}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="code_{$T.Result.sid}">{$T.Result.code}</td>
													<td align="center" id="name_{$T.Result.sid}">{$T.Result.name}</td>
													
													<td align="center" style="display:none;" id="pid_{$T.Result.sid}">{$T.Result.pid}</td>
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