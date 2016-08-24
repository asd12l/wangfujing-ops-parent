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
		$("#username_from").val($("#username").val());
		$("#mobile_from").val($("#mobile_input").val());
		$("#email_from").val($("#email_input").val());
		$("#loginchannel_from").val($("#loginchannel_input").val());
		
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("- ");
			$("#loginTimeStartDate_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#loginTimeEndDate_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#loginTimeStartDate_form").val("");
			$("#loginTimeEndDate_form").val("");
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
		$("#reservation").val("");
		$("#mobile_input").val("");
		$("#email_input").val("");
		$("#loginchannel_input").val("");
		productQuery();
	}

	
	
	//初始化包装单位列表
 	function initOlv() {
		
		var url = __ctxPath+"/memLogin/getLoginLogList";
		
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
            	 $("#loginchannel_input").setTemplateElement("olv-listB").processTemplate(data);
            	 $("#loginchannel_input").prepend("<option vaue='' selected='selected'>===请选择===</option>");
            
            	
            	
            	 
             	  //debugger;
           /*  	 var orderStatusSpace = $(".orderStatusSpace");
            		 var status=data.listB;
            		 status.unshift({sDomain:"",sDesc:"===请选择==="});

            		// alert("status=====:"+status);
            		orderStatusSpace.html("");
            		//alert("status.length=====:"+status.length);
            		//alert("status[0]=====:"+status[0].sDomain);
            		for ( var i = 0; i < status.length; i++) {
 					var ele = status[i];
 					if(ele.sDomain!= null){
 						var option = $("<option value='" + ele.sDomain + "'>"
 	 							+ ele.sDesc + "</option>");
 						option.appendTo(orderStatusSpace);
 					}
            		}   */

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
		$("#pageBody").load(__ctxPath+"/jsp/mem/MemberLogin.jsp");
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
                                    <h5 class="widget-caption">用户登录历史记录</h5>
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
                                    		 
                                    			<li class="col-md-4">
                                    				<label class="titname">账号：</label>
                                    				<input type="text" id="username"/>
                                   				</li>                         			
                                    			<li class="col-md-4">
                                    				<label class="titname">登录时间：</label>
                                    				<input type="text" id="reservation" />
                                   				</li>
                                   				
                                   				<li class="col-md-4">
                                    				<label class="titname">手机号：</label>
                                    				<input type="text" id="mobile_input"/>
                                   				</li>
                                   				<li class="col-md-4">
                                    				<label class="titname">邮箱：</label>
                                    				<input type="text" id="email_input"/>
                                   				</li>
                                   				  
                                   			
                                   			<li class="col-md-4" id="loginchannel">
                                   			<label class="titname"  style="width:105px;">第三方登录渠道：</label>
                                   			<select id="loginchannel_input" class="orderStatusSpace">
                                   		      
											</select>
											
										<textarea id="olv-listB" rows="0" cols="0" style="display:none">
                                   			{#template MAIN}
										{#foreach $T.listB as Result}
											 <option value="{$T.Result.sDomain}" selected="selected">{$T.Result.sDesc}</option>
											{#/for}
									    {#/template MAIN}
											</textarea>
											</li>
											
                                   				<li class="col-md-4">
                                   					<a class="btn btn-default shiny" onclick="query();">查询</a>&nbsp;&nbsp;
													<a class="btn btn-default shiny" onclick="reset();">重置</a>
                                    			</li>
                                    		</ul>

                               <!-- 没有滚动条 <div style="width:100%; height:0%; overflow-Y: hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" 
                                    style="width: 100%;background-color: #fff;margin-bottom: 0;"> -->
                                        <div style="width:100%; height:0%; min-height:300px; overflow-Y:hidden;">
									<table class="table-striped table-hover table-bordered"
										   id="olv_tab" style="width: 220%;background-color: #fff;margin-bottom: 0;">
                                        
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                            	<th width="8%" style="text-align: center;">账号</th>
                                            	<th width="5%" style="text-align: center;">昵称</th>
                                            	<th width="7%" style="text-align: center;">真实姓名</th>
                                            	<th width="5%" style="text-align: center;">会员来源</th>
                                            	<th width="5%" style="text-align: center;">手机</th>
                                            	<th width="5%" style="text-align: center;">邮箱</th>
                                            	<th width="8%" style="text-align: center;">注册时间</th>
                                            	<th width="9%" style="text-align: center;">登录时间</th>
                                            	<th width="7%" style="text-align: center;">IP地址</th>
                                                <th width="20%" style="text-align: center;">浏览器</th>
                                                <th width="5%" style="text-align: center;">登录结果</th>
                                            	<th width="8%" style="text-align: center;">第三方登录渠道</th>
                                            	<th width="8%" style="text-align: center;">第三方登录账号</th>
                                               <!--  <th width="5%" style="text-align: center;">会员编号</th>
                                               <th width="15%" style="text-align: center;">用户名</th>
                                               <th width="15%" style="text-align: center;">登录系统</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                   </div>
                                  <div class="pull-left" style="padding: 10px 0;">
									<form id="product_form" action="">
											<input type="hidden" id="username_from" name="username" />
											<input type="hidden" id="loginTimeStartDate_form" name="loginTimeStartDate"/>
											<input type="hidden" id="loginTimeEndDate_form" name="loginTimeEndDate"/> 
											<input type="hidden" id="cache" name="cache" value="1" />
											<input type="hidden" id="mobile_from" name="mobile_input" />
											<input type="hidden" id="email_from" name="email_input" />
											<input type="hidden" id="loginchannel_from" name="loginchannel_input" />
									</form>
								</div>
                                    <div id="olvPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										
										{#template MAIN}
										{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px;">
													<!-- <td align="center" id="sid_{$T.Result.sid}">
														会员编号
						                   				{#if $T.Result.sid != '[object Object]'}{$T.Result.sid}
						                   				{#/if}
													</td> -->
													<td align="center" id="username_{$T.Result.sid}">
													<!-- 账号 -->
														{#if $T.Result.username == "" || $T.Result.username == null}--
													    {#else}{$T.Result.username}
													    {#/if}
													</td>
													
													<td align="center" id="nick_name_{$T.Result.sid}">
													<!-- 昵称 -->
														{#if $T.Result.nick_name == "" || $T.Result.nick_name == null}--
													    {#else}{$T.Result.nick_name}
													    {#/if}
													</td>
													<td align="center" id="real_name_{$T.Result.sid}">
													<!-- 真实姓名 -->
														{#if $T.Result.real_name == "" || $T.Result.real_name == null}--
													    {#else}{$T.Result.real_name}
													    {#/if}
													</td>
													<td align="center" id="regist_from_{$T.Result.sid}">
													<!-- 会员来源 -->
														{#if $T.Result.regist_from == "" || $T.Result.regist_from == null}--
													    {#else}{$T.Result.regist_from}
													    {#/if}
													</td>
													<td align="center" id="mobile_{$T.Result.sid}">
													<!-- 手机 -->
														{#if $T.Result.mobile == "" || $T.Result.mobile == null}--
													    {#else}{$T.Result.mobile}
													    {#/if}
													</td>
													<td align="center" id="email_{$T.Result.sid}">
													<!-- 邮箱 -->
														{#if $T.Result.email == "" || $T.Result.email == null}--
													    {#else}{$T.Result.email}
													    {#/if}
													</td>
													<td align="center" id="regist_time_{$T.Result.sid}">
													<!-- 注册时间 -->
														{#if $T.Result.regist_time == "" || $T.Result.regist_time == null}--
													    {#else}{$T.Result.regist_time}
													    {#/if}
													</td>
													<td align="center" id="loginTime_{$T.Result.sid}">
														<!-- 登录时间 -->
														{#if $T.Result.loginTime == "" || $T.Result.loginTime == null}--
													    {#else}{$T.Result.loginTime}
													    {#/if}
													</td>
													<td align="center" id="ip_{$T.Result.sid}">
													<!-- IP地址 -->
														{#if $T.Result.ip == "" || $T.Result.ip == null}{$T.Result.features}
													    {#else}{$T.Result.ip}
													    {#/if}
													    {#if $T.Result.ip == "" || $T.Result.ip == null}无
						                   				{#/if}
													</td>
													<td align="center" id="browser_{$T.Result.sid}">
													<!-- 浏览器 -->
														{#if $T.Result.browser == "" || $T.Result.browser == null}{$T.Result.features}
													    {#else}{$T.Result.browser}
													    {#/if}
													</td>
													<!-- <td align="center" id="system_{$T.Result.sid}">
													登录系统
														{#if $T.Result.system == "" || $T.Result.system == null}{$T.Result.features}
													    {#else}{$T.Result.system}
													    {#/if}
													</td> -->
													<td align="center" id="isSuccess_{$T.Result.sid}">
													<!-- 登录结果 -->
														{#if $T.Result.isSuccess == 1}成功
						                   				{#/if}
						                   				{#if $T.Result.isSuccess == 0}失败
						                   				{#/if}
													</td>
													<td align="center" id="description_{$T.Result.sid}">
													<!-- 第三方登录渠道-->
														{#if $T.Result.description == "" || $T.Result.description == null}--
													    {#else}{$T.Result.description}
													    {#/if}
													</td>
													<td align="center" id="username_{$T.Result.sid}">
													<!-- 第三方登录账号 -->
													  	{#if $T.Result.tSid == "" || $T.Result.tSid == null}--
													    {#else}{$T.Result.username}
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