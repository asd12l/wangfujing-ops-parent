<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!--Page Related Scripts-->
<html>
<head>
	<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
	<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script>
	<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
	<!--Bootstrap Date Range Picker-->
	<script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
	<style type="text/css">
		.trClick>td,.trClick>th{
			color:red;
		}
		#pay_content{
			text-align:center;
		}
		#login_content{
			text-align:center;
		}
	</style>
	<script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
		saleMsgImage="http://images.shopin.net/images";
		ctx="http://www.shopin.net";

		var olvPagination;
		$(function() {
			initOlv();
		});

		function productQuery(){
			$("#cid_from").val($("#cid_input").val().trim());
			$("#belongStore_from").val($("#belongStore_input").val().trim())
			$("#mobile_from").val($("#mobile_input").val().trim());
			$("#identityNo_from").val($("#identityNo_input").val().trim());
			$("#email_from").val($("#email_input").val().trim());
			$("#idType_from").val($("#idType_input").val().trim());
			var params = $("#product_from").serialize();
			params = decodeURI(params);
			olvPagination.onLoad(params);
		}
		// 查询
		function query() {
			$("#cache").val(0);
			productQuery();
		}
		//重置
		function reset(){
			$("#cache").val(1);
			$("#cid_input").val("");
			$("#belongStore_input").val("");
			$("#mobile_input").val("");
			$("#identityNo_input").val("");
			$("#email_input").val("");
			$("#idType_input").val("1");
			productQuery();
		}
		//初始化包装单位列表
		function initOlv() {
			var url = __ctxPath+"/memBasic/getMemBasicInfo";
			olvPagination = $("#olvPagination").myPagination({
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
					callback: function(data) {
						$("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
					}
				}
			});
			function toChar(data) {
				if(data == null) {
					data = "";
				}
				return data;
			}
		}
		function successBtn(){
			$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
			$("#pageBody").load(__ctxPath+"/jsp/mem/MemberAndInfoView.jsp");
		}
		//重置支付密码
		function showResetPayPwd(){
			//清空表单内容
			$("#payCode_msg").html("");
			$("#payPwd_msg").html("");
			$("#pay_cid").val("");
			$("#pay_mobile").val("");
			$("#pay_code").val("");
			$("#payCode").val("");

			var checkboxArray=[];
			$("input[type='checkbox']:checked").each(function(i,team){
				var cid=$(this).val().trim();
				checkboxArray.push(cid);
			});
			if (checkboxArray.length > 1) {
				$("#warning2Body").text("只能选择一个用户重置支付密码!");
				$("#warning2").show();
				return;
			} else if (checkboxArray.length == 0) {
				$("#warning2Body").text("请选择要重置支付密码的用户!");
				$("#warning2").show();
				return;
			}
			var cid=checkboxArray[0];
			$("#pay_cid").val(cid);
			var mobile=$("#mobile_"+cid).text().trim();
			if(mobile=="--"){
				$("#warning2Body").text("该用户未绑定手机号!");
				$("#warning2").show();
				return;
			}else{
				$("#pay_mobile").val(mobile);
			}
			$("#resetPayPwdDiv").show();
		}
		function closePay(){
			$("#resetPayPwdDiv").hide();
		}
		function sendPayCodeToPhone(){
			var pay_mobile=$("#pay_mobile").val().trim();
			$("#payCode_msg").html("");
			var url = __ctxPath+"/memBasic/sendPayCodeToPhone";
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : url,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr(
							"class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(
							function() {
								$("#loading-container")
										.addClass(
										"loading-inactive")
							}, 300);
				},
				data :{"pay_mobile":pay_mobile},
				success : function(response) {
					if (response.code == "1") {
						$("#payCode_msg").html("验证码已发送");
						$("#payCode").val(response.object);
					}else{
						$("#payCode_msg").html("验证码发送失败");
					}
				},
				error : function() {
					$("#payCode_msg").html("验证码发送失败");
				}

			});
		}
		function sendPayPwdToPhone(){
			var verCode_input=$("#pay_code").val().trim();
			var verCode=$("#payCode").val().trim();
			$("#payPwd_msg").html("");
			if(verCode!=verCode_input){
				$("#payPwd_msg").html("验证失败");
				return;
			}else{
				var cid=$("#pay_cid").val().trim();
				var pay_mobile=$("#pay_mobile").val().trim();
				$("#payPwd_msg").html("");
				var url = __ctxPath+"/memBasic/sendPayPwdToPhone";
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : url,
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr(
								"class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(
								function() {
									$("#loading-container")
											.addClass(
											"loading-inactive")
								}, 300);
					},
					data :{"cid":cid,"pay_mobile":pay_mobile},
					success : function(response) {
						if (response.code == "1") {
							$("#payPwd_msg").html("新密码已发送");
						}else{
							$("#payPwd_msg").html("新密码发送失败");
						}
					},
					error : function() {
						$("#payPwd_msg").html("新密码发送失败");
					}

				});
			}
		}
		//重置登录密码
		function showResetLoginPwd(){
			//清空表单内容
			$("#mobileCode_msg").html("");
			$("#emailCode_msg").html("");
			$("#login_msg").html("");
			$("#loginStatus").val("");
			$("#login_cid").val("");
			$("#loginCode").val("");
			$("#login_mobile").val("");
			$("#login_email").val("");
			$("#login_code").val("");

			var checkboxArray=[];
			$("input[type='checkbox']:checked").each(function(i,team){
				var cid=$(this).val().trim();
				checkboxArray.push(cid);
			});
			if (checkboxArray.length > 1) {
				$("#warning2Body").text("只能选择一个用户重置登录密码!");
				$("#warning2").show();
				return;
			} else if (checkboxArray.length == 0) {
				$("#warning2Body").text("请选择要重置登录密码的用户!");
				$("#warning2").show();
				return;
			}
			var cid=checkboxArray[0];
			$("#login_cid").val(cid);
			var mobile=$("#mobile_"+cid).text().trim();
			var email=$("#email_"+cid).text().trim();
			if(mobile=="--"&&email=="--"){
				$("#warning2Body").text("该用户未绑定手机号和邮箱!");
				$("#warning2").show();
				return;
			}else{
				$("#login_mobile").val(mobile);
				$("#login_email").val(email);

			}
			$("#resetLoginPwdDiv").show();
		}
		function closeLogin(){
			$("#resetLoginPwdDiv").hide();
		}
		//发送重置登录密码的验证码至手机
		function sendLoginCodeToPhone(){
			$("#mobileCode_msg").html("");
			$("#emailCode_msg").html("");
			$("#login_msg").html("");
			var mobile=$("#login_mobile").val().trim();
			if(mobile==""||mobile=="--"){
				$("#mobileCode_msg").html("未绑定手机号，无法发送验证码");
				return;
			}
			var url = __ctxPath+"/memBasic/sendPayCodeToPhone";
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : url,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr(
							"class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(
							function() {
								$("#loading-container")
										.addClass(
										"loading-inactive")
							}, 300);
				},
				data :{"pay_mobile":"13260068344"},
				success : function(response) {
					if (response.code == "1") {
						$("#mobileCode_msg").html("验证码已发送");
						$("#loginCode").val(response.object);
						$("#loginStatus").val("1");
					}else{
						$("#mobileCode_msg").html("验证码发送失败");
					}
				},
				error : function() {
					$("#mobileCode_msg").html("验证码发送失败");
				}

			});
		}
		//发送登录密码的验证码至邮箱
		function sendLoginCodeToEmail(){
			$("#mobileCode_msg").html("");
			$("#emailCode_msg").html("");
			$("#login_msg").html("");
			var email=$("#login_email").val().trim();
//			if(email==""||email=="--"){
//				$("#emailCode_msg").html("未绑定邮箱，无法发送验证码");
//				return;
//			}
			var url = __ctxPath+"/memBasic/sendCodeToEmail";
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : url,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr(
							"class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(
							function() {
								$("#loading-container")
										.addClass(
										"loading-inactive")
							}, 300);
				},
				data :{"email":"1461186899@qq.com"},
				success : function(response) {
					if (response.code == "1") {
						$("#emailCode_msg").html("验证码已发送");
						$("#loginCode").val(response.object);
						$("loginStatus").val("2");
					}else{
						$("#emailCode_msg").html("验证码发送失败");
					}
				},
				error : function() {
					$("#emailCode_msg").html("验证码发送失败");
				}

			});
		}
		function sendLoginPwd(){
			var loginStatus=$("#loginStatus").val().trim();
			if(loginStatus!="1"&&loginStatus!="2"){
				$("#login_msg").html("未发送验证码");
				return;
			}
			var verCode=$("#loginCode").val().trim();
			var verCode_input=$("#login_code").val().trim();
			if(verCode!=verCode_input){
				$("#login_msg").html("验证失败");
				return;
			}else{
				var cid=$("#login_cid").val().trim();
				var mobile=$("#login_mobile").val().trim();
				var email=$("#login_email").val().trim();
				var url = __ctxPath+"/memBasic/sendLoginPwd";
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : url,
					dataType : "json",
					ajaxStart : function() {
						$("#loading-container").attr(
								"class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(
								function() {
									$("#loading-container")
											.addClass(
											"loading-inactive")
								}, 300);
					},
					data :{"cid":cid,"mobile":mobile,"email":email,"loginStatus":loginStatus},
					success : function(response) {
						if (response.code == "1") {
							$("#login_msg").html("新密码已发送");
						}else{
							$("#login_msg").html("新密码发送失败");
						}
					},
					error : function() {
						$("#login_msg").html("新密码发送失败");
					}

				});
			}
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
							<h5 class="widget-caption">会员基本信息</h5>
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
									<a onclick="showResetLoginPwd();" class="btn btn-primary"> <i
											class="fa fa-edit"></i> 登录密码重置
									</a>&nbsp;&nbsp;&nbsp;&nbsp; <a onclick="showResetPayPwd();" class="btn btn-primary"> <i
										class="fa fa-edit"></i> 支付密码重置
								</a>
								</div>
								<div class="table-toolbar">
									<ul class="topList clearfix">
										<li class="col-md-4"><label class="titname">账号：</label>
											<input type="text" id="cid_input" /></li>
										<li class="col-md-4"><label class="titname">所属门店：</label>
											<input type="text" id="belongStore_input" /></li>
										<li class="col-md-4"><label class="titname">手机号码：</label>
											<input type="text" id="mobile_input" /></li>
										<br/>
										<li class="col-md-4"><label class="titname">证件类型：</label>
											<select id="idType_input">
												<option value="1" checked="checked">身份证</option>
												<option value="2">护照</option>
												<option value="3">驾驶证</option>
												<option value="4">警官证</option>
												<option value="5">军官证</option>
												<option value="6">其他</option>
											</select>
											</li>
										<li class="col-md-4"><label class="titname">证件号：</label>
											<input type="text" id="identityNo_input" />
										</li>
										<li class="col-md-4"><label class="titname">邮箱：</label>
											<input type="text" id="email_input" /></li>

										<li class="col-md-6">
											<a onclick="query();" class="btn btn-yellow"> <i class="fa fa-eye"></i> 查询</a>
											<a onclick="reset();"class="btn btn-primary"> <i class="fa fa-random"></i> 重置</a>
										</li>
									</ul>
								</div>
								<div style="width:100%; height:0%; min-height:300px; overflow-Y:hidden;">
									<table class="table-striped table-hover table-bordered"
										   id="olv_tab" style="width: 220%;background-color: #fff;margin-bottom: 0;">
										<thead>
										<tr role="row" style='height:35px;'>
											<th style="text-align: center;" width="2%">选择</th>
											<th style="text-align: center;" width="5%">账户</th>
											<th style="text-align: center;" width="5%">昵称</th>
											<th style="text-align: center;" width="5%">真实姓名</th>
											<th style="text-align: center;" width="5%">所属门店</th>
											<th style="text-align: center;" width="5%">会员等级</th>
											<th style="text-align: center;" width="5%">注册时间</th>
											<th style="text-align: center;" width="5%">手机</th>
											<th style="text-align: center;" width="5%">邮箱</th>
											<th style="text-align: center;" width="5%">地址</th>
											<th style="text-align: center;" width="5%">性别</th>
											<th style="text-align: center;" width="5%">生日</th>
											<th style="text-align: center;" width="5%">身份证号</th>
											<th style="text-align: center;" width="5%">所在行业</th>
											<th style="text-align: center;" width="5%">绑定状态</th>
											<th style="text-align: center;" width="5%">绑定时间</th>
											<th style="text-align: center;" width="5%">手机验证</th>
											<th style="text-align: center;" width="5%">邮箱验证</th>
											<th style="text-align: center;" width="5%">支付密码</th>

										</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
								<div class="pull-left" style="padding: 10px 0;">
									<form id="product_from" action="">
										<input type="hidden" id="cid_from" name="cid" />
										<input type="hidden" id="belongStore_from" name="belongStore" />
										<input type="hidden" id="mobile_from" name="mobile" />
										<input type="hidden" id="identityNo_from" name="identityNo" />
										<input type="hidden" id="email_from" name="email"/>
										<input type="hidden" id="idType_from" name="idType"/>
									</form>
								</div>
								<div id="olvPagination"></div>
							</div>
							<!-- Templates -->
							<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.cid}" value="{$T.Result.cid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="cid_{$T.Result.cid}">
														{#if $T.Result.cid == "" || $T.Result.cid == null}--
													    {#else}{$T.Result.cid}
													    {#/if}
													</td>
													<td align="center" id="nickname_{$T.Result.cid}">
														{#if $T.Result.cmnickname == "" || $T.Result.cmnickname == null}--
													    {#else}{$T.Result.cmnickname}
													    {#/if}
													</td>
													<td align="center" id="realname_{$T.Result.cid}">
														{#if $T.Result.cmname == "" || $T.Result.cmname == null}--
													    {#else}{$T.Result.cmname}
													    {#/if}
													</td>
													<td align="center" id="belongStore_{$T.Result.cid}">
														{#if $T.Result.cmmkt == "" || $T.Result.cmmkt == null}--
													    {#else}{$T.Result.cmmkt}
													    {#/if}
													</td>
													<td align="center" id="levelName_{$T.Result.cid}">
														{#if $T.Result.levelName == "" || $T.Result.levelName == null}V钻会员
														{#else}{$T.Result.levelName}
														{#/if}
													</td>
													<td align="center" id="registTime_{$T.Result.cid}">
														{#if $T.Result.cmkhdate == "" || $T.Result.cmkhdate == null}--
													    {#else}{$T.Result.cmkhdate}
													    {#/if}
													</td>
													<td align="center" id="mobile_{$T.Result.cid}">
														{#if $T.Result.cmmobile1 == "" || $T.Result.cmmobile1 == null}--
														{#else}{$T.Result.cmmobile1}
														{#/if}
													</td>
													<td align="center" id="email_{$T.Result.cid}">
														{#if $T.Result.cmemail == "" || $T.Result.cmemail == null}--
														{#else}{$T.Result.cmemail}
														{#/if}
													</td>
													<td align="center" id="address_{$T.Result.cid}">
														{#if $T.Result.address == "" || $T.Result.address == null}--
														{#else}{$T.Result.address}
														{#/if}
													</td>
													<td align="center" id="gender_{$T.Result.cid}">
														{#if $T.Result.cmsex == "F"}女
						                   				{#/if}
						                   				{#if $T.Result.cmsex == "M"}男
						                   				{#/if}
						                   				{#if $T.Result.cmsex == ""||$T.Result.cmsex ==null}--
						                   				{#/if}
													</td>
													<td align="center" id="birthdate_{$T.Result.cid}">
														{#if $T.Result.cmbirthdate == "" || $T.Result.cmbirthdate == null}--
													    {#else}{$T.Result.cmbirthdate}
													    {#/if}
													</td>
													<td align="center" id="identityNo_{$T.Result.cid}">
														{#if $T.Result.cmidno == "" || $T.Result.cmidno == null}--
													    {#else}{$T.Result.cmidno}
													    {#/if}
													</td>
													<td align="center" id="work_{$T.Result.cid}">
														{#if $T.Result.cmoccup == "" || $T.Result.cmoccup == null}--
													    {#else}{$T.Result.cmoccup}
													    {#/if}
													</td>
													<td align="center" id="bindStatus_{$T.Result.cid}">
														{#if $T.Result.bindStatus == "" || $T.Result.bindStatus == null}--
														{#else}{$T.Result.bindStatus}
													    {#/if}
													</td>
													<td align="center" id="bindTime_{$T.Result.cid}">
														{#if $T.Result.bindTime == "" || $T.Result.bindTime == null}--
														{#else}{$T.Result.bindTime}
														{#/if}
													</td>
													<td align="center" id="mobileStatus_{$T.Result.cid}">
														{#if $T.Result.mobileStatus == "" || $T.Result.mobileStatus == null}--
														{#else}{$T.Result.mobileStatus}
														{#/if}
													</td>
													<td align="center" id="emailStatus_{$T.Result.cid}">
														{#if $T.Result.emailStatus == "" || $T.Result.emailStatus == null}--
														{#else}{$T.Result.emailStatus}
														{#/if}
													</td>
													<td align="center" id="payPwdStatus_{$T.Result.cid}">
														{#if $T.Result.payPwdStatus == "" || $T.Result.payPwdStatus == null}--
														{#else}{$T.Result.payPwdStatus}
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
<!--重置登录密码 -->
<div class="modal modal-darkorange"
	 id="resetLoginPwdDiv">
	<div class="modal-dialog"
		 style="width: 800px; height: auto; margin: 4% auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeLogin();">×</button>
				<h4 class="modal-title">重置登录密码</h4>
			</div>
			<div class="page-body">
				<div class="row" id="login_content">
					<form method="post" class="form-horizontal">
						<div class="col-xs-12 col-md-12">
							<input type="hidden" name="login_cid" id="login_cid">
							<input type="hidden" name="loginCode" id="loginCode">
							<input type="hidden" name="loginStatus" id="loginStatus">
							<div class="col-md-12"  style="padding: 10px 100px;">
								<label class="col-md-5 control-label"
									   style="line-height: 20px; text-align: right;">手机号：</label>
								<div class="col-md-6">
									<input type="text" class="form-control" name="login_mobile"
										   id="login_mobile" />
									<span id="mobileCode_msg" style="color:red;"></span>
								</div>
								<br>&nbsp;
							</div>

							<div class="col-md-12"  style="padding: 10px 100px;">
								<label class="col-md-5 control-label"
									   style="line-height: 20px; text-align: right;">邮箱：</label>
								<div class="col-md-6">
									<input type="text" class="form-control" name="login_email"
										   id="login_email" />
									<span id="emailCode_msg" style="color:red;"></span>
								</div>
								<br>&nbsp;
							</div>

							<div class="col-md-12"  style="padding: 10px 100px;">
								<label class="col-md-5 control-label"
									   style="line-height: 20px; text-align: right;">输入验证码：</label>
								<div class="col-md-6">
									<input type="text" class="form-control" name="login_code"
										   id="login_code" />
									<span id="login_msg" style="color:red"></span>
								</div>
								<br>&nbsp;
							</div>
						</div>
						<br>&nbsp;
						<div class="mtb10">
							<a onclick="sendLoginCodeToPhone();" class="btn btn-info">发送验证码至手机</a>&nbsp;&nbsp;
							<a onclick="sendLoginCodeToEmail();" class="btn btn-info">发送验证码至邮箱</a>&nbsp;&nbsp;
							<a onclick="sendLoginPwd();" class="btn btn-info">发送新密码</a>&nbsp;&nbsp;
							<a onclick="closeLogin();" class="btn btn-primary">取消</a>&nbsp;&nbsp;
						</div>
				</form>
			</div>
		</div>
	</div>
	<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>

<!--重置支付密码 -->
<div class="modal modal-darkorange"
	 id="resetPayPwdDiv">
	<div class="modal-dialog"
		 style="width: 800px; height: auto; margin: 4% auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closePay();">×</button>
				<h4 class="modal-title" id="divTitle">重置支付密码</h4>
			</div>
			<div class="page-body">
				<div class="row" id="pay_content">
					<form method="post" class="form-horizontal" id="editForm">
						<div class="col-xs-12 col-md-12">
							<input type="hidden" name="pay_cid" id="pay_cid">
							<input type="hidden" name="payCode" id="payCode">
							<div class="col-md-12"  style="padding: 10px 100px;">
								<label class="col-md-5 control-label"
									   style="line-height: 20px; text-align: right;">手机号：</label>
								<div class="col-md-6">
									<input type="text" class="form-control" name="pay_mobile"
										   id="pay_mobile" />
									<span id="payCode_msg" style="color:red;"></span>
								</div>
								<br>&nbsp;
							</div>

							<div class="col-md-12"  style="padding: 10px 100px;">
								<label class="col-md-5 control-label"
									   style="line-height: 20px; text-align: right;">输入验证码：</label>
								<div class="col-md-6">
									<input type="text" class="form-control" name="pay_code"
										   id="pay_code" />
									<span id="payPwd_msg" style="color:red"></span>
								</div>
								<br>&nbsp;
							</div>
						</div>
						<br>&nbsp;
						<div class="mtb10">
							<a onclick="sendPayCodeToPhone();" class="btn btn-info">发送验证码</a>&nbsp;&nbsp;
							<a onclick="sendPayPwdToPhone();" class="btn btn-info">发送新密码</a>&nbsp;&nbsp;
							<a onclick="closePay();" class="btn btn-primary">取消</a>&nbsp;&nbsp;
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