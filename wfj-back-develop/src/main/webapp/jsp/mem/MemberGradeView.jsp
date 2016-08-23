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
		var url = __ctxPath+"/member/getByMemberGrade";
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
		$("#pageBody").load(__ctxPath+"/jsp/mem/MemberGradeView.jsp");
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
                                    <h5 class="widget-caption">会员等级</h5>
                                   <div class="widget-buttons">
										<a href="#" data-toggle="maximize"></a> <a href="#"
											data-toggle="collapse" onclick="tab('pro');"> <i
											class="fa fa-minus" id="pro-i"></i>
										</a> <a href="#" data-toggle="dispose"></a>
									</div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
                                    		<div class="mtb10">
                                    		<span class="titname">等级变更时间：</span> <input type="text" id="reservation" />
											<span class="titname">账号：</span> <input type="text" id="Account_number" />&nbsp;&nbsp;&nbsp;&nbsp;
											<span class="titname">手机号码：</span> <input type="text" id="mobile_number" />&nbsp;&nbsp;&nbsp;&nbsp;
											<span class="titname">身份证号：</span> <input type="text" id="identity_card_no_input" />&nbsp;&nbsp;&nbsp;&nbsp;
											<span class="titname">当前会员等级：</span> <input type="text" id="member_grade" />&nbsp;&nbsp;&nbsp;&nbsp;
											<span class="titname">会员来源：</span> <select  id="member_regist_from" >
																						<option value="">===请选择===</option>
																						<option value="">线上</option>
																						<option value="">门店</option>
																						<option value="">第三方</option>
																				</select>&nbsp;&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;&nbsp; <a class="btn btn-default shiny"
												onclick="query();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
												class="btn btn-default shiny" onclick="reset();">重置</a>
									</div>                             
                                   <table class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="olv_tab" style="width: 120%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                            <th style="text-align: center;" width="2%">选择</th>
											<th style="text-align: center;" width="10%">账号</th>
											<th style="text-align: center;" width="10%">昵称</th>
											<th style="text-align: center;" width="10%">真实姓名</th>
											<th style="text-align: center;" width="10%">手机</th>
											<th style="text-align: center;" width="10%">邮箱</th>
											<th style="text-align: center;" width="10%">会员来源</th>
											<th style="text-align: center;" width="10%">会员等级</th>
											<th style="text-align: center;" width="10%">注册时间</th>
											<th style="text-align: center;" width="10%">初始等级</th>
											<th style="text-align: center;" width="10%">升降级</th>
											<th style="text-align: center;" width="10%">升降级名称</th>
											<th style="text-align: center;" width="10%">升降级时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>                          
                                  <div class="pull-left" style="padding: 10px 0;">
									<form id="product_form" action="">
											<input type="hidden" id="username_form" name="username" />
											<input type="hidden" id="mobile_form" name="mobile" /> 
											<input type="hidden" id="identity_card_no_form" name="identity_card_no" />
											<input type="hidden" id="member_grade_form" name="membergrade"/>
											<input type="hidden" id="changetime_form" name="changetime"/> 
											<input type="hidden" id="regist_from_form" name="regist_from"  />
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
													<td align="center" id="mobile_{$T.Result.sid}">
														{#if $T.Result.mobile == "" || $T.Result.mobile == null}{$T.Result.features}
													    {#else}{$T.Result.mobile}
													    {#/if}
														{#if $T.Result.mobile == "" || $T.Result.gender == null}无
						                   				{#/if}	
													</td>
													<td align="center" id="email_{$T.Result.sid}">
														{#if $T.Result.email == "" || $T.Result.email == null}{$T.Result.features}
													    {#else}{$T.Result.email}
													    {#/if}
													    {#if $T.Result.email == "" || $T.Result.email == null}无
						                   				{#/if}														
													</td>
													<td align="center" id="regist_from_{$T.Result.sid}">
														{#if $T.Result.regist_from == "" || $T.Result.regist_from == null}{$T.Result.features}
													    {#else}{$T.Result.regist_from}
													    {#/if}
													    {#if $T.Result.regist_from == "" || $T.Result.regist_from == null}无
						                   				{#/if}
													</td>
													<td align="center" id="cust_typename_{$T.Result.sid}">
														{#if $T.Result.cust_typename == "" || $T.Result.cust_typename == null}{$T.Result.features}
													    {#else}{$T.Result.cust_typename}
													    {#/if}
													    {#if $T.Result.cust_typename == "" || $T.Result.cust_typename == null}无
						                   				{#/if}
													</td>
													<td align="center" id="regist_time_{$T.Result.sid}">
														{#if $T.Result.regist_time == "" || $T.Result.regist_time == null}{$T.Result.features}
													    {#else}{$T.Result.regist_time}
													    {#/if}
													    {#if $T.Result.regist_time == "" || $T.Result.regist_time == null}无
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