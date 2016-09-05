<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
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
<!--Bootstrap Date Range Picker-->
<script
	src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
<style type="text/css">
.trClick>td, .trClick>th {
	color: red;
}
</style>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	var olvPagination;
	$(function() {
		$("#reservationAp").daterangepicker();
		$("#reservationCh").daterangepicker();
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		initOlv();
	});

	function productQuery() {
		$("#login_from").val($("#login_input").val());
		$("#sid_from").val($("#sid_input").val());
		$("#applyName_from").val($("#applyName_input").val());
		$("#mobile_from").val($("#mobile_input").val());
		$("#email_from").val($("#email_input").val());
		$("#fromOrder_from").val($("#from_order_input").val());
		$("#check_status_from").val($("#check_status_input").val());
		var strApTime = $("#reservationAp").val();
		debugger;
		var strChTime = $("#reservationCh").val();
		if (strApTime != "") {
			strApTime = strApTime.split("- ");
			$("#m_timeApStartDate_form").val(
					strApTime[0].replace("/", "-").replace("/", "-"));
			$("#m_timeApEndDate_form").val(
					strApTime[1].replace("/", "-").replace("/", "-"));
		} else {
			$("#m_timeApStartDate_form").val("");
			$("#m_timeApEndDate_form").val("");
		}
		if (strChTime != "") {
			strChTime = strChTime.split("- ");
			$("#m_timeChStartDate_form").val(
					strChTime[0].replace("/", "-").replace("/", "-"));
			$("#m_timeChEndDate_form").val(
					strChTime[1].replace("/", "-").replace("/", "-"));
		} else {
			$("#m_timeChStartDate_form").val("");
			$("#m_timeChEndDate_form").val("");
		}
		var params = $("#product_form").serialize();
		params = decodeURI(params);
		olvPagination.onLoad(params);
	}
	// 查询
	function query() {
		$("#cache").val(0);
		productQuery();
	}
	//重置
	function reset() {
		$("#cache").val(1);
		$("#login_input").val("");
		$("#sid_input").val("");
		$("#order_input").val("");
		$("#applyName_input").val("");
		$("#reservationAp").val("");
		$("#reservationCh").val("");
		productQuery();
	}
	//初始化包装单位列表
	function initOlv() {
		var url = __ctxPath + "/memberIntegral/getByMemberIntegral";
		olvPagination = $("#olvPagination").myPagination(
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
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						callback : function(data) {
							$("#olv_tab tbody").setTemplateElement("olv-list")
									.processTemplate(data);
						}
					}
				});
		function toChar(data) {
			if (data == null) {
				data = "";
			}
			return data;
		}
	}
	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(__ctxPath + "/jsp/mem/MemberIntegralApply.jsp");
	}
	//查看积分申请
	function showIntegralDetail() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一条申请记录!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要查看的申请!");
			$("#warning2").show();
			return;
		}
		var value = checkboxArray[0];
		var fromOrder = $("#from_order_" + value).text().trim().split(":");
		$("#apply_cid").val(fromOrder[1]);
		$("#sid").val(value);
		$("#apply_name").val($("#apply_name_" + value).text().trim());
		$("#apply_num").val($("#apply_point_num_" + value).text().trim());
		$("#apply_reason").val($("#apply_reason_" + value).text().trim());
		$("#show_check_memo").val($("#checkMemo_" + value).text().trim());

		var applyType = $("#apply_type_" + value).text().trim();
		if (applyType == "2") {
			$("#apply_type_1").attr("checked", true);
		} else {
			$("#apply_type_0").attr("checked", true);
		}

		var sourceType = $("#source_type_" + value).text().trim();
		if (sourceType == "2") {
			$("#source_type_1").attr("checked", true);
		} else {
			$("#source_type_0").attr("checked", true);
		}

		$("#editLabelDiv").show();
	}
	//隐藏div
	//新建积分申请
	function closeAddIntegral() {
		$("#addIntegralDiv").hide();
	}
	//查看积分申请
	function closeMerchant(){
		$("#editLabelDiv").hide();
	}
	function showAddIntegral() {
		//清空表单内容
		$("#login_name_add").val("");
		$("#apply_name_add").val("");
		$("#from_order_add").val("");
		$("#apply_reason_add").val("");
		$("#apply_reason_add").val("");
		$("#addIntegralDiv").show();
	}
	//查看会员基本信息
	function showMemberMsg() {
		var loginName = $("#login_name_add").val().trim();
		if (loginName == "" || loginName == null) {
			$("#login_msg").show();
			return false;
		}
		debugger;
		$.ajax({
			type : "post",
			contentype : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/memberIntegral/ShowMemberInfo",
			datatype : "json",
			data : {
				"loginName" : loginName,
			},
			async : false,
			success : function(response) {
				debugger;
				var login = JSON.parse(response).loginName;
				var mobile = JSON.parse(response).mobile;
				var email = JSON.parse(response).email;
				var realName = JSON.parse(response).realName;
				var nick_name = JSON.parse(response).nick_name;
				
				$("#show_username_input").val(login);
				$("#show_nickname_input").val(nick_name);
				$("#show_realname_input").val(realName);
				$("#show_email_input").val(email);
				$("#show_mobile_input").val(mobile);
				$("#showMemberInfoDiv").show();
			}
		})
		
	}
	//隐藏会员基本信息
	function closeShowMemberView() {
		$("#showMemberInfoDiv").hide();
	}
	//添加积分申请
	function submitAddIntegral() {
		$(".add_msg").hide();
		var loginName = $("#login_name_add").val().trim();
		var applyName = $("#apply_name_add").val().trim();
		var applyType = $("input[name='apply_type_add']:checked").val();
		var sourceType = $("input[name='source_type_add']:checked").val();
		var orderNo = $("#from_order_add").val().trim();
		var applyNo = $("#apply_num_add").val().trim();
		var applyReason = $("#apply_reason_add").val().trim();
		if (loginName == "" || loginName == null) {
			$("#login_msg").show();
			return false;
		}
		if (applyName == "" || applyName == null) {
			$("#applyName_msg").show();
			return false;
		}
		if (orderNo == "" || orderNo == null) {
			$("#orderNo_msg").show();
			return false;
		}
		if (applyNo == "" || applyNo == null) {
			$("#applyNo_msg").html("不能为空!")
			$("#applyNo_msg").show();
			return false;
		}
		if (isNaN(applyNo)) {
			$("#applyNo_msg").html("请输入数字!")
			$("#applyNo_msg").show();
		}
		var url = __ctxPath + "/memberIntegral/addMemberIntegral";
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : url,
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					data : {
						"loginName" : loginName,
						"applyName" : applyName,
						"applyType" : applyType,
						"sourceType" : sourceType,
						"orderNo" : orderNo,
						"applyNo" : applyNo,
						"applyReason" : applyReason
					},
					success : function(response) {
						if (response.code == "0") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;z-index:9999",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							$("#addIntegralDiv").hide();
						} else if (response.code == "1") {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
													+ "用户名无效!"
													+ "</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;z-index:9999",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
							$("#addIntegralDiv").hide();
						} else if (response.code == "2") {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
													+ "订单无效"
													+ "</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;z-index:9999",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
							$("#addIntegralDiv").hide();
						} else {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
													+ "添加失败"
													+ "</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;z-index:9999",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
							$("#addIntegralDiv").hide();
						}
						return;
					},
					error : function() {
						$("model-body-warning")
								.html(
										"<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
						$("#modal-warning").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-error"
						});
					}

				});

	}

	//编辑积分申请
	function editIntegralApply() {
		$(".edit_msg").hide();

		//回显
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一条申请记录!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要查看的申请!");
			$("#warning2").show();
			return;
		}
		var value = checkboxArray[0];
		var checkStatus = $("#check_status_" + value).text().trim();
		if (checkStatus == "审核通过") {
			$("#warning2Body").text("该申请已通过,请选择其他申请记录!!");
			$("#warning2").show();
			return;
		}
		var fromOrder = $("#from_order_" + value).text().trim().split(":");
		$("#edit_orderNo").val(fromOrder[1]);
		$("#edit_sid").val(value);
		$("#edit_applynName").val($("#apply_name_" + value).text().trim());
		$("#edit_applyNum").val($("#apply_point_num_" + value).text().trim());
		$("#edit_applyReason").val($("#apply_reason_" + value).text().trim());
		$("#edit_checkMemo").val($("#checkMemo_" + value).text().trim());

		var applyType = $("#apply_type_" + value).text().trim();
		if (applyType == "2") {
			$("#edit_applyType_1").attr("checked", true);
		} else {
			$("#edit_applyType_0").attr("checked", true);
		}

		var sourceType = $("#source_type_" + value).text().trim();
		if (sourceType == "2") {
			$("#edit_sourceType_1").attr("checked", true);
		} else {
			$("#edit_sourceType_0").attr("checked", true);
		}
		$("#editIntegralDiv").show();
	}

	function submitIntegralApply() {
		var sid = $("#edit_sid").val();
		var applyType = $("input[name='apply_type_edit']:checked").val();
		var sourceType = $("input[name='source_type_edit']:checked").val();
		var orderNo = $("#edit_orderNo").val().trim();
		var applyNum = $("#edit_applyNum").val().trim();
		var applyReason = $("#edit_applyReason").val().trim();
		if (orderNo == "" || orderNo == null) {
			$("#editOrderNo_msg").show();
			return false;
		}
		if (applyNum == "" || applyNum == null) {
			$("#editApplyNum_msg").html("不能为空!")
			$("#editApplyNum_msg").show();
			return false;
		}
		if (isNaN(applyNum)) {
			$("#editApplyNum_msg").html("请输入数字!")
			$("#editApplyNum_msg").show();
		}
		if (applyReason == "" || applyReason == null) {
			$("#editReason_msg").show();
			return false;
		}

		var url = __ctxPath + "/memberIntegral/editMemberIntegral";
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : url,
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					data : {
						"sid" : sid,
						"applyType" : applyType,
						"sourceType" : sourceType,
						"orderNo" : orderNo,
						"applyNum" : applyNum,
						"applyReason" : applyReason
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'><strong>修改成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;z-index:9999",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							$("#editIntegralDiv").hide();

						} else {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
													+ "修改失败!"
													+ "</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;z-index:9999",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
						}
						return;
					},
					error : function() {
						$("model-body-warning")
								.html(
										"<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
						$("#modal-warning").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-error"
						});
					}

				});
	}
	function closeEditIntegral() {
		$("#editIntegralDiv").hide();
	}

	//审核积分申请
	function showCheckApply() {
		$("#checkName_msg").hide();
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一条申请记录!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要审核的申请!");
			$("#warning2").show();
			return;
		}
		var sid = checkboxArray[0];
		var checkStatus = $("#check_status_" + sid).text().trim();
		if (checkStatus == "审核通过") {
			$("#warning2Body").text("审核通过不能取消!");
			$("#warning2").show();
			return;
		}
		$("#check_sid").val(sid);
		$("#checkIntegralDiv").show();
	}
	function closeCheckApply() {
		$("#checkIntegralDiv").hide();
	}
	function checkIntegralApply() {
		var sid = $("#check_sid").val().trim();
		var checkName = $("#checkName").val().trim();
		var checkStatus = $("input[name='check_status']:checked").val().trim();
		var checkMemo = $("#check_memo").val().trim();
		if (checkName == "" || checkName == null) {
			$("#checkName_msg").show();
			return false;
		}
		var url = __ctxPath + "/memberIntegral/checkMemberIntegral";
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : url,
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					data : {
						"sid" : sid,
						"checkName" : checkName,
						"checkStatus" : checkStatus,
						"checkMemo" : checkMemo
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'><strong>审核操作成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;z-index:9999",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							$("#checkIntegralDiv").hide();

						} else {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
													+ "操作失败!"
													+ "</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;z-index:9999",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
						}
						return;
					},
					error : function() {
						$("model-body-warning")
								.html(
										"<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
						$("#modal-warning").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-error"
						});
					}

				});
	}

	//取消积分申请
	function cancleApply() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一条申请记录!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要取消的积分申请!");
			$("#warning2").show();
			return;
		}
		var sid = checkboxArray[0];
		var checkStatus = $("#check_status_" + sid).text().trim();
		if (checkStatus == "审核通过") {
			$("#warning2Body").text("审核通过不能取消!");
			$("#warning2").show();
			return;
		}
		var url = __ctxPath + "/memberIntegral/cancleMemberIntegral";
		$
				.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : url,
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					data : {
						"sid" : sid
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'><strong>取消成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;z-index:9999",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							$("#checkIntegralDiv").hide();

						} else {
							$("#model-body-warning")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
													+ "操作失败!"
													+ "</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;z-index:9999",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
						}
						return;
					},
					error : function() {
						$("model-body-warning")
								.html(
										"<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
						$("#modal-warning").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-error"
						});
					}

				});
	}
</script>
<!-- 加载样式 -->
<script type="text/javascript">
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
								<h5 class="widget-caption">积分申请</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<ul class="topList clearfix">
										<li class="col-md-4"><label class="titname">申请单号：</label>
											<input type="text" id="sid_input" /></li>
										<li class="col-md-4"><label class="titname">申请时间：</label>
											<input type="text" id="reservationAp" /></li>
										<li class="col-md-4"><label class="titname">账号：</label> <input
											type="text" id="login_input" /></li>
										<li class="col-md-4"><label class="titname">手机号：</label>
											<input type="text" id="mobile_input" /></li>
										<li class="col-md-4"><label class="titname">邮箱：</label> <input
											type="text" id="email_input" /></li>
										<li class="col-md-4"><label class="titname">来源单号：</label>
											<input type="text" id="from_order_input" /></li>
										<li class="col-md-4"><label class="titname">申请人：</label>
											<input type="text" id="applyName_input" /></li>
										<li class="col-md-4"><label class="titname">单据状态：</label>
											<select id="check_status_input">
												<option value="">===请选择===</option>
												<option value="1">待审核</option>
												<option value="2">审核通过</option>
												<option value="3">审核不通过</option>
												<option value="4">取消审核</option>
										</select></li>
										<li class="col-md-4"><label class="titname">审核时间：</label>
											<input type="text" id="reservationCh" /></li>
										<li class="col-md-6"><a onclick="query();"
											class="btn btn-yellow"> <i class="fa fa-eye"></i> 查询
										</a> <a onclick="reset();" class="btn btn-primary"> <i
												class="fa fa-random"></i> 重置
										</a></li>
									</ul>
									<div class="mtb10">
										<a onclick="showIntegralDetail();" class="btn btn-info"> <i
											class="fa fa-wrench"></i>查看积分申请
										</a>&nbsp;&nbsp; <a onclick="showAddIntegral();"
											class="btn btn-info"> <i class="fa fa-wrench"></i>新建积分申请
										</a>&nbsp;&nbsp; <a onclick="editIntegralApply();"
											class="btn btn-info"> <i class="fa fa-wrench"></i>编辑积分申请
										</a>&nbsp;&nbsp; <a onclick="showCheckApply();"
											class="btn btn-info"> <i class="fa fa-wrench"></i>审核积分申请
										</a>&nbsp;&nbsp; <a onclick="cancleApply();" class="btn btn-info">
											<i class="fa fa-wrench"></i>取消积分申请
										</a>&nbsp;&nbsp;
									</div>
									<table
										class="table table-bordered table-striped table-condensed table-hover flip-content"
										id="olv_tab"
										style="width: 120%; background-color: #fff; margin-bottom: 0;">
										<thead>
											<tr role="row" style='height: 35px;'>
												<th style="text-align: center;" width="2%">选择</th>
												<th style="text-align: center;" width="10%">申请单号</th>
												<th style="text-align: center;" width="10%">申请时间</th>
												<th style="text-align: center;" width="10%">账号</th>
												<th style="text-align: center;" width="10%">昵称</th>
												<th style="text-align: center;" width="10%">真实姓名</th>
												<th style="text-align: center;" width="10%">会员等级</th>
												<th style="text-align: center;" width="10%">手机</th>
												<th style="text-align: center;" width="10%">邮箱</th>
												<th style="text-align: center;" width="10%">积分类型</th>
												<th style="text-align: center;" width="10%">积分值</th>
												<th style="text-align: center;" width="10%">剩余积分</th>
												<th style="text-align: center;" width="10%">单据状态</th>
												<th style="text-align: center;" width="10%">申请人</th>
												<th style="text-align: center;" width="10%">审核时间</th>
												<th style="text-align: center;" width="10%">订单号/退货单号</th>
												<th style="text-align: center;" width="10%">申请理由</th>
												<th style="text-align: center;" width="10%">备注</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="pull-left" style="padding: 10px 0;">
										<form id="product_form" action="">
											<input type="hidden" id="login_from" name="login" /> <input
												type="hidden" id="sid_from" name="sid" /> <input
												type="hidden" id="m_timeApStartDate_form"
												name="m_timeApStartDate" /> <input type="hidden"
												id="m_timeApEndDate_form" name="m_timeApEndDate" /> <input
												type="hidden" id="m_timeChStartDate_form"
												name="m_timeChStartDate" /> <input type="hidden"
												id="m_timeChEndDate_form" name="m_timeChEndDate" /> <input
												type="hidden" id="mobile_from" name="mobile" /> <input
												type="hidden" id="email_from" name="email" /> <input
												type="hidden" id="fromOrder_from" name="fromOrder" /> <input
												type="hidden" id="applyName_from" name="applyName" /> <input
												type="hidden" id="check_status_from" name="check_status" />
											<input type="hidden" id="cache" name="cache" value="1" />
										</form>
									</div>
									<div id="olvPagination"></div>
								</div>
								<!-- Templates -->
								<p style="display: none">
									<textarea id="olv-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox"
													style="margin-bottom: 0; margin-top: 0; padding-left: 3px;">
															<label style="padding-left: 9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}"
														value="{$T.Result.sid}">
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="sid_{$T.Result.sid}">
														{#if $T.Result.sid == "" || $T.Result.sid == null}--
													    {#else}{$T.Result.sid}
													    {#/if}
													
											<td align="center" id="apply_time_{$T.Result.sid}">
														{#if $T.Result.apply_time == "" || $T.Result.apply_time == null}--
													    {#else}{$T.Result.apply_time}
													    {#/if}
													</td>
													
													<td align="center" id="login_name_{$T.Result.sid}">
														{#if $T.Result.login_name == "" || $T.Result.login_name == null}--
													    {#else}{$T.Result.login_name}
													    {#/if}
													</td>
													<td align="center" id="nick_name_{$T.Result.sid}">
														{#if $T.Result.nick_name == "" || $T.Result.nick_name == null}--
													    {#else}{$T.Result.nick_name}
													    {#/if}
													</td>
													<td align="center" id="real_name_{$T.Result.sid}">
														{#if $T.Result.real_name == "" || $T.Result.real_name == null}--
													    {#else}{$T.Result.real_name}
													    {#/if}
													</td>
													<td align="center" id="levelName_{$T.Result.sid}">
														{#if $T.Result.levelName == "" || $T.Result.levelName == null}--
													    {#else}{$T.Result.levelName}
													    {#/if}
													</td>
													<td align="center" id="mobile_{$T.Result.sid}">
														{#if $T.Result.mobile == "" || $T.Result.mobile == null}--
													    {#else}{$T.Result.mobile}
													    {#/if}
													</td>
													<td align="center" id="email_{$T.Result.sid}">
														{#if $T.Result.email == "" || $T.Result.email == null}--
													    {#else}{$T.Result.email}
													    {#/if}
													</td>
													<td align="center" id="apply_type_{$T.Result.sid}">
														{#if $T.Result.apply_type == "" || $T.Result.apply_type == null}--
													    {#else}{$T.Result.apply_type}
													    {#/if}
													</td>
													<td align="center" id="apply_point_num_{$T.Result.sid}">
														{#if $T.Result.apply_point_num == "" || $T.Result.apply_point_num == null}--
													    {#else}{$T.Result.apply_point_num}
													    {#/if}
													</td>
													<td align="center" id="cmJfTo_{$T.Result.sid}">
														{#if $T.Result.cmJfTo == "" || $T.Result.cmJfTo == null}--
													    {#else}{$T.Result.cmJfTo}
													    {#/if}
													</td>
													
													<td align="center" id="check_status_{$T.Result.sid}">
														{#if $T.Result.check_status == "" || $T.Result.check_status == null}--
													    {#/if}
                                                        {#if $T.Result.check_status == "1"}待审核
                                                        {#/if}
                                                        {#if $T.Result.check_status == "2"}审核通过
                                                        {#/if}
                                                        {#if $T.Result.check_status == "3"}审核不通过
                                                        {#/if}
                                                        {#if $T.Result.check_status == "4"}取消审核
                                                        {#/if}
													</td>
													<td align="center" id="apply_name_{$T.Result.sid}">
														{#if $T.Result.apply_name == "" || $T.Result.apply_name == null}--
													    {#else}{$T.Result.apply_name}
													    {#/if}
													</td>
													<td align="center" id="checkTime_{$T.Result.sid}">
														{#if $T.Result.checkTime== "" || $T.Result.checkTime == null}--
													    {#else}{$T.Result.checkTime}
													    {#/if}
													</td>
													<td align="center" id="from_order_{$T.Result.sid}">
                                                        {#if $T.Result.from_order== "" || $T.Result.from_order== null}--
                                                        {#else}
                                                        {#if $T.Result.source_type == "1"}订单号:{$T.Result.from_order}
                                                        {#else}退货单号:{$T.Result.from_order}
                                                        {#/if}
                                                        {#/if}
													</td>
													 <td align="center" id="apply_reason_{$T.Result.sid}">
                                                        {#if $T.Result.apply_reason== "" || $T.Result.apply_reason == null}--
                                                        {#else}{$T.Result.apply_reason}
                                                        {#/if}
                                                    </td>
													<td align="center" id="checkMemo_{$T.Result.sid}">
                                                        {#if $T.Result.check_memo== "" || $T.Result.check_memo == null}--
                                                        {#else}{$T.Result.check_memo}
                                                        {#/if}
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
	<!--查看积分申请 -->
	<div class="modal modal-darkorange" id="editLabelDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeMerchant();">×</button>
					<h4 class="modal-title" id="divTitle">查看积分详情</h4>
				</div>
				<div class="page-body">
					<div class="row">
						<form method="post" class="form-horizontal" id="editForm">
							<div class="col-xs-12 col-md-12">
								<input type="hidden" name="id" id="merchant_id">
								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">单据号：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="name" id="sid" readonly="readonly"/>
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">来源单号：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="feeCostRate"
											id="apply_cid" readonly="readonly"/>
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">申请人：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="apply_name"
											readonly="readonly" />
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">申请类型：</label>
									<div class="radio">
										<label> <input class="basic divtype cart_flag"
											type="radio" id="apply_type_0" name="apply_type" value="1"
											checked="checked" onclick="return false;"> <span
											class="text">增积分</span>
										</label> <label> <input class="basic divtype cart_flag"
											type="radio" id="apply_type_1" name="apply_type" value="2"
											onclick="return false;"> <span class="text">减积分</span>
										</label>
									</div>
								</div>


								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">凭证类型：</label>
									<div class="radio">
										<label> <input class="basic divtype cart_flag"
											type="radio" id="source_type_0" name="source_type" value="1"
											checked="checked" onclick="return false;"> <span
											class="text">订单号</span>
										</label> <label> <input class="basic divtype cart_flag"
											type="radio" id="source_type_1" name="source_type" value="2"
											onclick="return false;"> <span class="text">退货单号</span>
										</label>
									</div>
								</div>

								<div class="col-md-12" style="padding: 10px 100px;"
									id="old_input">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">积分数量：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="apply_num"
											readonly="readonly" />
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;"
									id="old_input">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">申请理由：</label>
									<div class="col-md-6">
										<input type="textarea" class="form-control" id="apply_reason"
											readonly="readonly" />
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;"
									id="old_input">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">审核备注：</label>
									<div class="col-md-6">
										<input type="textarea" class="form-control" id="show_check_memo"
											readonly="readonly" />
									</div>
									<br>&nbsp;
								</div>

							</div>
							<br>&nbsp;
							<div class="form-group">
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <input
									class="btn btn-danger" onclick="closeMerchant();"
									style="width: 25%;" id="submitEdit" type="button" value="关闭" />
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!--新建积分申请 -->
	<div class="modal modal-darkorange" id="addIntegralDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeAddIntegral();">×</button>
					<h4 class="modal-title">积分申请单</h4>
				</div>
				<div class="page-body">
					<div class="row">
						<form method="post" class="form-horizontal">
							<div class="col-xs-12 col-md-12">
								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">客户登录账号：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="name"
											id="login_name_add" />
										<button type="button" onclick="showMemberMsg();">查看</button>

										<span id="login_msg" style="color: red; display: none;"
											class="add_msg">不能为空!</span>
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">申请人：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="name"
											id="apply_name_add" /> <span id="applyName_msg"
											style="color: red; display: none;" class="add_msg">不能为空!</span>
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">申请类型：</label>
									<div class="radio">
										<label> <input class="basic divtype cart_flag"
											type="radio" name="apply_type_add" value="1"
											checked="checked"> <span class="text">增积分</span>
										</label> <label> <input class="basic divtype cart_flag"
											type="radio" name="apply_type_add" value="2"> <span
											class="text">减积分</span>
										</label>
									</div>
								</div>


								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">凭证类型：</label>
									<div class="radio">
										<label> <input class="basic divtype cart_flag"
											type="radio" name="source_type_add" value="1"
											checked="checked"> <span class="text">订单号</span>
										</label> <label> <input class="basic divtype cart_flag"
											type="radio" name="source_type_add" value="2"> <span
											class="text">退货单号</span>
										</label>
									</div>
								</div>

								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">订单/退货编码：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="name"
											id="from_order_add" /> <span id="orderNo_msg"
											style="color: red; display: none;" class="add_msg">不能为空!</span>
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">积分数量：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="apply_num_add" />
										<span id="applyNo_msg" style="color: red; display: none;"
											class="add_msg">不能为空!</span>
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">申请理由：</label>
									<div class="col-md-6">
										<input type="textarea" class="form-control"
											id="apply_reason_add" />
									</div>
									<br>&nbsp;
								</div>

							</div>
							<br>&nbsp;
							<div class="form-group">
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <input
									class="btn btn-danger" onclick="submitAddIntegral();"
									style="width: 25%;" id="submit" type="button" value="提交" />
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!--编辑积分申请 -->
	<div class="modal modal-darkorange" id="editIntegralDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeEditIntegral();">×</button>
					<h4 class="modal-title">编辑积分申请单</h4>
				</div>
				<div class="page-body">
					<div class="row">
						<form method="post" class="form-horizontal">
							<div class="col-xs-12 col-md-12">
								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">单据号：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="sid"
											readonly="readonly" id="edit_sid" />
									</div>
									<br><!-- &nbsp; <label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">用户编号：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="applyCid"
											readonly="readonly" id="edit_cid" />
									</div>
									<br> -->&nbsp; <label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">申请人：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="applyName"
											id="edit_applynName" />
									</div>
									<br>&nbsp;
									<div class="col-md-12" style="padding: 10px 100px;">
										<label class="col-md-5 control-label"
											style="line-height: 10px; text-align: right;">申请类型：</label>
										<div class="radio">
											<label> <input class="basic divtype cart_flag"
												type="radio" id="edit_applyType_0" name="apply_type_edit"
												value="1" checked="checked"> <span class="text">增积分</span>
											</label> <label> <input class="basic divtype cart_flag"
												type="radio" id="edit_applyType_1" name="apply_type_edit"
												value="2"> <span class="text">减积分</span>
											</label>
										</div>
									</div>
									<br />&nbsp;
									<div class="col-md-12" style="padding: 10px 100px;">
										<label class="col-md-5 control-label"
											style="line-height: 10px; text-align: right;">凭证类型：</label>
										<div class="radio">
											<label> <input class="basic divtype cart_flag"
												type="radio" id="edit_sourceType_0" name="source_type_edit"
												value="1" checked="checked"> <span class="text">订单号</span>
											</label> <label> <input class="basic divtype cart_flag"
												type="radio" id="edit_sourceType_1" name="source_type_edit"
												value="2"> <span class="text">退货单号</span>
											</label>
										</div>
									</div>
									<br />&nbsp; <label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">积分数量：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="edit_applyNum" />
										<span id="editApplyNum_msg" style="color: red; display: none;"
											class="edit_msg"></span>
									</div>
									<br>&nbsp; <label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">订/退货单号：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="edit_orderNo" readonly="readonly"/> <span
											id="editOrderNo_msg" style="color: red; display: none;"
											class="edit_msg">不能为空!</span>
									</div>
									<br>&nbsp; <label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">申请理由：</label>
									<div class="col-md-6">
										<input type="textarea" class="form-control"
											id="edit_applyReason" /> <span id="editReason_msg"
											style="color: red; display: none;" class="edit_msg">不能为空!</span>
									</div>
									<br>&nbsp; <label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">审核备注：</label>
									<div class="col-md-6">
										<input type="textarea" class="form-control"
											id="edit_checkMemo"  />
									</div>
									<br>&nbsp;
								</div>

							</div>
							<br>&nbsp;
							<div class="form-group">
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <input
									class="btn btn-danger" onclick="submitIntegralApply();"
									style="width: 25%;" type="button" value="确认提交" />
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 审核积分申请-->
	<div class="modal modal-darkorange" id="checkIntegralDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeCheckApply();">×</button>
					<h4 class="modal-title">审核积分申请</h4>
				</div>
				<div class="page-body">
					<div class="row">
						<form method="post" class="form-horizontal">
							<input type="hidden" id="check_sid" />
							<div class="col-xs-12 col-md-12">
								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">审核人：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="name"
											id="checkName" /> <span id="checkName_msg"
											style="color: red; display: none;" class="check_msg">不能为空!</span>
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">审核状态：</label>
									<div class="radio">
										<label> <input class="basic divtype cart_flag"
											type="radio" name="check_status" value="1" checked="checked">
											<span class="text">待审核</span>
										</label> <label> <input class="basic divtype cart_flag"
											type="radio" name="check_status" value="2"> <span
											class="text">通过</span>
										</label> <label> <input class="basic divtype cart_flag"
											type="radio" name="check_status" value="3"> <span
											class="text">驳回</span>
										</label> <label> <input class="basic divtype cart_flag"
											type="radio" name="check_status" value="4"> <span
											class="text">取消</span>
										</label>
									</div>
								</div>


								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">审核备注：</label>
									<div class="col-md-6">
										<input type="textarea" class="form-control" name="memo"
											id="check_memo" />
									</div>
									<br>&nbsp;
								</div>

							</div>
							<br>&nbsp;
							<div class="form-group">
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
								&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <input
									class="btn btn-danger" onclick="checkIntegralApply();"
									style="width: 25%;" id="submitCheck" type="button" value="确定" />
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 查看会员基本信息 -->
	<div class="modal modal-darkorange" id="showMemberInfoDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeShowMemberView();">×</button>
					<h4 class="modal-title">该用户基本信息</h4>
				</div>
				<div class="page-body">
					<div class="row">
					<form method="post" class="form-horizontal" id="editForm">
							<div class="col-xs-12 col-md-12">
								<input type="hidden" name="id" id="merchant_id">
								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">客户账号：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="name" id="show_username_input" readonly="readonly"/>
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">姓名：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="feeCostRate"
											id="show_realname_input" readonly="readonly"/>
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">昵称：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="show_nickname_input"
											readonly="readonly" />
									</div>
									<br>&nbsp;
								</div>
								<div class="col-md-12" style="padding: 10px 100px;"
									id="old_input">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">手机号：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="show_mobile_input"
											readonly="readonly" />
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" style="padding: 10px 100px;"
									id="old_input">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">邮箱：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="show_email_input"
											readonly="readonly" />
									</div>
								</div>
							</div>
							
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

</body>
</html>