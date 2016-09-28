<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!-- 登录和支付密码  -->
<%@ include file="PayAndLoginPassword.jsp"%>
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
	  	<%-- <script src="${pageContext.request.contextPath}/assets/js/datetime/Pageload.js"></script> --%>
 	
   <script type="text/javascript" src="js/member/comment/MemberAndInfoView.js"></script>
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
										<li class="col-md-4"><label class="titname">手机号：</label>
											<input type="text" id="mobile_input" /></li>
										<br/>
										<li class="col-md-4"><label class="titname">证件类型：</label>
											<select id="idType_input">
											   <option value="" checked="checked">请选择</option>
												<option value="1">身份证</option>
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
										<!--先不展示 可能二期展示  -->
										<!-- <li class="col-md-4"><label class="titname">注册时间：</label>
											<input type="text" id="registrationTime_input" /></li> -->
										<!--先不展示 可能二期展示  -->
										<!-- <li class="col-md-4"><label class="titname">会员等级-X：</label>
											<input type="text" id="memberLevel_input" />
											<select id="memberLevel_input">
											   <option value="" checked="checked">请选择</option>
												<option value="I">V钻会员</option>
												<option value="L">金钻会员</option>
												<option value="K">红钻会员</option>
												<option value=" ">黑钻会员</option>
											</select>
											</li> -->

										<li class="col-md-6">
											<a onclick="query();" class="btn btn-yellow"> <i class="fa fa-eye"></i> 查询</a>
											<a onclick="reset();" class="btn btn-primary"> <i class="fa fa-random"></i> 重置</a>
										</li>
									</ul>
								</div>
								<div style="width:100%; height:0%; min-height:300px; overflow-Y:hidden;">
									<table class="table-striped table-hover table-bordered"
										   id="olv_tab" style="width: 220%;background-color: #fff;margin-bottom: 0;">
										<thead>
										<tr role="row" style='height:35px;'>
											<th style="text-align: center;" width="2%">选择</th>
											<th style="text-align: center;" width="5%">账号</th>
											<th style="text-align: center;" width="5%">昵称</th>
											<th style="text-align: center;" width="5%">真实姓名</th>
											<th style="text-align: center;" width="5%">所属门店</th>
											<th style="text-align: center;" width="5%">会员等级</th>
											<th style="text-align: center;" width="5%">注册时间</th>
											<th style="text-align: center;" width="4%">手机号</th>
											<th style="text-align: center;" width="4%">邮箱</th>
											<th style="text-align: center;" width="4%">地址</th>
											<th style="text-align: center;" width="4%">性别</th>
											<th style="text-align: center;" width="4%">生日</th>
											<th style="text-align: center;" width="4%">兴趣</th>
											<th style="text-align: center;" width="4%">婚姻状况</th>
											<th style="text-align: center;" width="4%">月收入</th>
											<th style="text-align: center;" width="5%">证件号</th>
											<th style="text-align: center;" width="5%">教育程度</th>
											<th style="text-align: center;" width="4%">所在行业</th>
											<th style="text-align: center;" width="4%">绑定状态</th>
											<th style="text-align: center;" width="4%">绑定时间</th>
											<th style="text-align: center;" width="4%">手机验证</th>
											<th style="text-align: center;" width="4%">邮箱验证</th>
											<th style="text-align: center;" width="4%">无卡化</th>
										</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
								<div class="pull-left" style="padding: 10px 0;">
									<form id="product_from" action="">
									<select id="pageSelect" name="pageSize">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
										<input type="hidden" id="cid_from" name="cid" />
										<input type="hidden" id="belongStore_from" name="belongStore" />
										<input type="hidden" id="mobile_from" name="mobile" />
										<input type="hidden" id="identityNo_from" name="identityNo" />
										<input type="hidden" id="email_from" name="email"/>
										<input type="hidden" id="idType_from" name="idType"/>
										<!-- 注册时间 -->
										<input type="hidden" id="timeStartDate_form" name="m_timeStartDate"/>
										<input type="hidden" id="timeEndDate_form" name="m_timeEndDate"/>
										<!-- 会员等级 -->
										<input type="hidden" id="memberLevel_from" name="memberLevel"/>
										<input type="hidden" id="cache" name="cache" />
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
													<td align="center" id="cmnickname_{$T.Result.cid}">
														{#if $T.Result.cmnickname == "" || $T.Result.cmnickname == null}--
													    {#else}{$T.Result.cmnickname}
													    {#/if}
													</td>
													<td align="center" id="cmname_{$T.Result.cid}">
														{#if $T.Result.cmname == "" || $T.Result.cmname == null}--
													    {#else}{$T.Result.cmname}
													    {#/if}
													</td>
													<td align="center" id="cmmkt_{$T.Result.cid}">
														{#if $T.Result.cmmkt == "" || $T.Result.cmmkt == null}--
													    {#else}{$T.Result.cmmkt}
													    {#/if}
													</td>
													<td align="center" id="levelName_{$T.Result.cid}">
														{#if $T.Result.levelName == "" || $T.Result.levelName == null}V钻会员
														{#else}{$T.Result.levelName}
														{#/if}
													</td>
													<td align="center" id="cmkhdate_{$T.Result.cid}">
														{#if $T.Result.cmkhdate == "" || $T.Result.cmkhdate == null}--
													    {#else}{$T.Result.cmkhdate}
													    {#/if}
													</td>

													<td align="center" id="mobile_{$T.Result.cid}">
														<input type="hidden" id="phone5_{$T.Result.cid}" value="{$T.Result.phone5}">
														{#if $T.Result.cmmobile1 == "" || $T.Result.cmmobile1 == null}--
														{#else}{$T.Result.cmmobile1}
														{#/if}
													</td>

													<td align="center" id="email_{$T.Result.cid}">
														<input type="hidden" id="email1_{$T.Result.cid}" value="{$T.Result.email1}">
														{#if $T.Result.cmemail == "" || $T.Result.cmemail == null}--
														{#else}{$T.Result.cmemail}
														{#/if}
													</td>
													<td align="center" id="address_{$T.Result.cid}">
														{#if $T.Result.address == "" || $T.Result.address == null}--
														{#else}{$T.Result.address}
														{#/if}
													</td>
													<td align="center" id="cmsex_{$T.Result.cid}">
														{#if $T.Result.cmsex == "F"}女
						                   				{#/if}
						                   				{#if $T.Result.cmsex == "M"}男
						                   				{#/if}
						                   				{#if $T.Result.cmsex == ""||$T.Result.cmsex ==null}--
						                   				{#/if}
													</td>
													<td align="center" id="cmbirthdate_{$T.Result.cid}">
														{#if $T.Result.cmbirthdate == "" || $T.Result.cmbirthdate == null}--
													    {#else}{$T.Result.cmbirthdate}
													    {#/if}
													</td>
													
													<td align="center" id="hobby_{$T.Result.cid}"> 
														<!-- 兴趣 -->
														{#if $T.Result.hobby == "" || $T.Result.hobby == null}--
													    {#else}{$T.Result.hobby}
													    {#/if}
													</td>
													
													<td align="center" id="wedding_status_{$T.Result.cid}">
													<!-- 婚姻状况 -->
														{#if $T.Result.wedding_status == "" || $T.Result.wedding_status == null}--
													    {#else}{$T.Result.wedding_status}
													    {#/if}
													</td>
													
													<td align="center" id="income_{$T.Result.cid}">
													<!-- 月收入 -->
														{#if $T.Result.income == "" || $T.Result.income == null}--
													    {#else}{$T.Result.income}
													    {#/if}
													</td>
													
													<td align="center" id="cmidno_{$T.Result.cid}">
														{#if $T.Result.cmidno == "" || $T.Result.cmidno == null}--
													    {#else}{$T.Result.cmidno}
													    {#/if}
													</td>
													
													
													<td align="center" id="teach_level_{$T.Result.cid}">
													<!-- 教育程度 -->
														{#if $T.Result.teach_level == "" || $T.Result.teach_level == null}--
													    {#else}{$T.Result.teach_level}
													    {#/if}
													</td>
													
													<td align="center" id="cmoccup_{$T.Result.cid}">
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

</body>
</html>