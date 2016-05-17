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
		var url = __ctxPath+"/memberAccount/getByMemberIntegral";
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
		$("#pageBody").load(__ctxPath+"/jsp/mem/MemberIntegralView.jsp");
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
                                    <h5 class="widget-caption">积分记录</h5>
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
                                    		<span class="titname">积分变动时间：</span> <input type="text" id="reservation" />
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
											<th style="text-align: center;" width="10%">账号</th>
											<th style="text-align: center;" width="10%">昵称</th>
											<th style="text-align: center;" width="10%">真实姓名</th>
											<th style="text-align: center;" width="10%">会员来源</th>
											<th style="text-align: center;" width="10%">会员等级</th>
											<th style="text-align: center;" width="10%">积分类别</th>
											<th style="text-align: center;" width="10%">收入/支出</th>
											<th style="text-align: center;" width="10%">时间（积分变动）</th>
											<th style="text-align: center;" width="10%">详细说明</th>
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
													<td align="center" id="mobile_{$T.Result.sid}">
														{#if $T.Result.mobile == "" || $T.Result.mobile == null}{$T.Result.features}
													    {#else}{$T.Result.mobile}
													    {#/if}
													    {#if $T.Result.mobile == "" || $T.Result.mobile == null}无
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
													
													<td align="center" id="email_{$T.Result.sid}">
														{#if $T.Result.email == "" || $T.Result.email == null}{$T.Result.features}
													    {#else}{$T.Result.email}
													    {#/if}
														{#if $T.Result.email == "" || $T.Result.email == null}无
						                   				{#/if}	
													</td>
													<td align="center" id="income_{$T.Result.sid}">
														{#if $T.Result.income == "" || $T.Result.income == null}{$T.Result.features}
													    {#else}{$T.Result.income}
													    {#/if}
													    {#if $T.Result.income == "" || $T.Result.income == null}无
						                   				{#/if}
													</td>
													<td align="center" id="income_{$T.Result.sid}">
														{#if $T.Result.income == "" || $T.Result.income == null}{$T.Result.features}
													    {#else}{$T.Result.income}
													    {#/if}
													    {#if $T.Result.income == "" || $T.Result.income == null}无
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