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
</style>
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	var olvPagination;
	$(function() {
		$("#reservation").daterangepicker();
	    initOlv();
	});
	
	function productQuery(){
		$("#username_from").val($("#username_input").val());
		$("#mobile_from").val($("#mobile_input").val());
		$("#identity_card_no_from").val($("#identity_card_no_input").val());
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("- ");
			$("#m_timeStartDate_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#m_timeEndDate_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#m_timeStartDate_form").val("");
			$("#m_timeEndDate_form").val("");
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
	function reset(){
		$("#cache").val(1);
		$("#username").val("");
		$("#mobile_input").val("");
		$("#identity_card_no_input").val("");
		$("#reservation").val("");
		productQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/member/getByMemberAndInfo";
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
</script>
<!-- 手机重置密码 -->
<script type="text/javascript">
function editMobilePassWord() {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var sid = $(this).val();
		checkboxArray.push(sid);
	});
	if (checkboxArray.length > 1) {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一行!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
		return false;
	} else if (checkboxArray.length == 0) {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的行!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
		return false;
	}
	var value = checkboxArray[0];
	password_= $("#password_" + value).text().trim();
	email_ = $("#email_" + value).text().trim();
	username_ = $("#username_" + value).text().trim();
	mobile_ = $("#mobile_" + value).text().trim();
	sid_ = $("#sid_" + value).text().trim();

	var url = __ctxPath + "/jsp/mem/editMobilePassWord.jsp";
	$("#pageBody").load(url);
}
</script>
<!--邮箱重置密码  -->
<script type="text/javascript">
function editEmailPassWord() {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var sid = $(this).val();
		checkboxArray.push(sid);
	});
	if (checkboxArray.length > 1) {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一行!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
		return false;
	} else if (checkboxArray.length == 0) {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的行!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
		return false;
	}
	var value = checkboxArray[0];
	password_= $("#password_" + value).text().trim();
	email_ = $("#email_" + value).text().trim();
	username_ = $("#username_" + value).text().trim();
	mobile_ = $("#mobile_" + value).text().trim();
	sid_ = $("#sid_" + value).text().trim();
	
	var url = __ctxPath + "/jsp/mem/editEmailPassWord.jsp";
	$("#pageBody").load(url);
	
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
									 		<a id="editabledatatable_new"
												onclick="editMobilePassWord();" class="btn btn-primary"> <i
												class="fa fa-edit"></i> 用户根据手机重置密码
											</a>&nbsp;&nbsp;&nbsp;&nbsp; <a id="editabledatatable_new"
												onclick="editEmailPassWord();" class="btn btn-primary"> <i
												class="fa fa-edit"></i> 用户根据邮箱重置密码
											</a>
										</div>
                                    		<div class="mtb10">
                                    		<span class="titname">登录时间：</span> <input type="text" id="reservation" />
											<span class="titname">账号：</span> <input type="text" id="username_input" />&nbsp;&nbsp;&nbsp;&nbsp;
											<span class="titname">手机号码：</span> <input type="text" id="mobile_input" />&nbsp;&nbsp;&nbsp;&nbsp;
											<span class="titname">身份证号：</span> <input type="text" id="identity_card_no_input" />&nbsp;&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;&nbsp; <a class="btn btn-default shiny"
												onclick="query();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
												class="btn btn-default shiny" onclick="reset();">重置</a>
									</div>                             
                                   <table class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                            <th style="text-align: center;" width="2%">选择</th>
											<th style="text-align: center;" width="10%">账户</th>
											<th style="text-align: center;" width="10%">昵称</th>
											<th style="text-align: center;" width="10%">真实姓名</th>
											<th style="text-align: center;" width="10%">注册时间</th>
											<th style="text-align: center;" width="5%">性别</th>
											<th style="text-align: center;" width="10%">生日</th>
											<th style="text-align: center;" width="10%">兴趣</th>
											<th style="text-align: center;" width="10%">手机</th>
											<th style="text-align: center;" width="10%">邮箱</th>
											<th style="text-align: center;" width="8%">婚姻状况</th>
											<th style="text-align: center;" width="10%">月收入</th>
											<th style="text-align: center;" width="10%">身份证号</th>
											<th style="text-align: center;" width="10%">教育程度</th>
											<th style="text-align: center;" width="10%">所在行业</th>
											<th style="text-align: center;" width="10%">会员来源</th>
											<th style="text-align: center;" width="10%">会员等级</th>
											<th style="text-align: center;" width="10%">第三方平台</th>
											<th style="text-align: center;" width="10%">第三方账号</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>                          
                                  <div class="pull-left" style="padding: 10px 0;">
									<form id="product_form" action="">
											<input type="hidden" id="username_from" name="username" />
											<input type="hidden" id="mobile_from" name="mobile" /> 
											<input type="hidden" id="identity_card_no_from" name="identity_card_no" />
											<input type="hidden" id="m_timeStartDate_form" name="m_timeStartDate"/>
											<input type="hidden" id="m_timeEndDate_form" name="m_timeEndDate"/> 
											<input type="hidden" id="cache" name="cache" value="1" />
									</form>
								</div>
                                    <div id="olvPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="username_{$T.Result.sid}">
														{#if $T.Result.username == "" || $T.Result.username == null}{$T.Result.features}
													    {#else}{$T.Result.username}
													    {#/if}
													</td>
													<td align="center" id="nick_name_{$T.Result.sid}">
														{#if $T.Result.nick_name == "" || $T.Result.nick_name == null}{$T.Result.features}
													    {#else}{$T.Result.nick_name}
													    {#/if}
														{#if $T.Result.nick_name == "" || $T.Result.nick_name == null}无
						                   				{#/if}	
													</td>
													<td align="center" id="real_name_{$T.Result.sid}">
														{#if $T.Result.real_name == "" || $T.Result.real_name == null}{$T.Result.features}
													    {#else}{$T.Result.real_name}
													    {#/if}
														{#if $T.Result.real_name == "" || $T.Result.real_name == null}无
						                   				{#/if}	
													</td>
													<td align="center" id="m_time_{$T.Result.sid}">
														{#if $T.Result.m_time == "" || $T.Result.m_time == null}{$T.Result.features}
													    {#else}{$T.Result.m_time}
													    {#/if}
														{#if $T.Result.m_time == "" || $T.Result.gender == null}无
						                   				{#/if}	
													</td>
													<td align="center" id="gender_{$T.Result.sid}">
														{#if $T.Result.gender == 0}女
						                   				{#/if}
						                   				{#if $T.Result.gender == 1}男
						                   				{#/if}
						                   				{#if $T.Result.gender == 2}保密
						                   				{#/if}
													</td>
													<td align="center" id="birthdate_{$T.Result.sid}">
														{#if $T.Result.birthdate == "" || $T.Result.birthdate == null}{$T.Result.features}
													    {#else}{$T.Result.birthdate}
													    {#/if}
														{#if $T.Result.birthdate == "" || $T.Result.birthdate == null}无
						                   				{#/if}	
													</td>
													<td align="center" id="hobby_{$T.Result.sid}">
														{#if $T.Result.hobby == "" || $T.Result.hobby == null}{$T.Result.features}
													    {#else}{$T.Result.hobby}
													    {#/if}
														{#if $T.Result.hobby == "" || $T.Result.hobby == null}无
						                   				{#/if}	
													</td>
													<td align="center" id="mobile_{$T.Result.sid}">
														{#if $T.Result.mobile == "" || $T.Result.mobile == null}{$T.Result.features}
													    {#else}{$T.Result.mobile}
													    {#/if}
													    {#if $T.Result.mobile == "" || $T.Result.mobile == null}无
						                   				{#/if}														
													</td>
													<td align="center" id="email_{$T.Result.sid}">
														{#if $T.Result.email == "" || $T.Result.email == null}{$T.Result.features}
													    {#else}{$T.Result.email}
													    {#/if}
														{#if $T.Result.email == "" || $T.Result.email == null}无
						                   				{#/if}	
													</td>
													<td align="center" id="wedding_status_{$T.Result.sid}">
														{#if $T.Result.wedding_status == 1}已婚
						                   				{#/if}
						                   				{#if $T.Result.wedding_status == 2}未婚
						                   				{#/if}
						                   				{#if $T.Result.wedding_status == 3}保密
						                   				{#/if}
													</td>
													<td align="center" id="income_{$T.Result.sid}">
														{#if $T.Result.income == "" || $T.Result.income == null}{$T.Result.features}
													    {#else}{$T.Result.income}
													    {#/if}
													    {#if $T.Result.income == "" || $T.Result.income == null}无
						                   				{#/if}
													</td>
													<td align="center" id="identity_card_no_{$T.Result.sid}">
														{#if $T.Result.identity_card_no == "" || $T.Result.identity_card_no == null}{$T.Result.features}
													    {#else}{$T.Result.identity_card_no}
													    {#/if}
													    {#if $T.Result.identity_card_no == "" || $T.Result.identity_card_no == null}无
						                   				{#/if}
													</td>
													<td align="center" id="teach_level_{$T.Result.sid}">
														{#if $T.Result.teach_level == "" || $T.Result.teach_level == null}{$T.Result.features}
													    {#else}{$T.Result.teach_level}
													    {#/if}
													    {#if $T.Result.teach_level == "" || $T.Result.teach_level == null}无
						                   				{#/if}
													</td>
													<td align="center" id="profession_{$T.Result.sid}">
														{#if $T.Result.profession == "" || $T.Result.profession == null}{$T.Result.features}
													    {#else}{$T.Result.profession}
													    {#/if}
													    {#if $T.Result.profession == "" || $T.Result.profession == null}无
						                   				{#/if}
													</td>
													<td align="center" id="profession_{$T.Result.sid}">
														{#if $T.Result.profession == "" || $T.Result.profession == null}{$T.Result.features}
													    {#else}{$T.Result.profession}
													    {#/if}
													    {#if $T.Result.profession == "" || $T.Result.profession == null}无
						                   				{#/if}
													</td>
													<td align="center" id="profession_{$T.Result.sid}">
														{#if $T.Result.profession == "" || $T.Result.profession == null}{$T.Result.features}
													    {#else}{$T.Result.profession}
													    {#/if}
													    {#if $T.Result.profession == "" || $T.Result.profession == null}无
						                   				{#/if}
													</td>
													<td align="center" id="profession_{$T.Result.sid}">
														{#if $T.Result.profession == "" || $T.Result.profession == null}{$T.Result.features}
													    {#else}{$T.Result.profession}
													    {#/if}
													    {#if $T.Result.profession == "" || $T.Result.profession == null}无
						                   				{#/if}
													</td>
													<td align="center" id="profession_{$T.Result.sid}">
														{#if $T.Result.profession == "" || $T.Result.profession == null}{$T.Result.features}
													    {#else}{$T.Result.profession}
													    {#/if}
													    {#if $T.Result.profession == "" || $T.Result.profession == null}无
						                   				{#/if}
													</td>
													
													<td style="display:none;" id="password_{$T.Result.sid}">{$T.Result.password}</td>
													<td style="display:none;" id="cardNo_{$T.Result.sid}">{$T.Result.card_no}</td>
													
													<td style="display:none;" id="statCategoryName_{$T.Result.sid}">{$T.Result.statCategoryName}</td>
													<td style="display:none;" id="spuCode_{$T.Result.sid}">{$T.Result.spuCode}</td>
													
													<td style="display:none;" id="proActiveBit_{$T.Result.sid}">{$T.Result.proActiveBit}</td>
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