<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
    <!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"> </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"> </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >  </script>
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
	
	var olvPagination,olvPagination1;
	$(function() {
		$("#week").hide();
		var today = new Date(); 
		var m_timeStartDate=(today.getFullYear()-1)+"/"+(today.getMonth()+1)+"/"+today.getDate();
		var m_timeEndDate=today.getFullYear()+"/"+(today.getMonth()+1)+"/"+today.getDate();
		$("#reservation").daterangepicker();
		$("#reservation").val(m_timeStartDate + " - " +m_timeEndDate);
	    initOlv();
	    
	    $("#month_a").click(function(){
	    	$("#week").hide();
	    });
	    $("#week_a").click(function(){
	    	$("#week").show();
	    });
	});
	
	function productQuery(){
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
        olvPagination1.onLoad(params);
   	}
	// 查询
	function query() {
		$("#cache").val(0);
		productQuery();
	}
	//重置
	function reset(){
		$("#cache").val(1);
		$("#reservation").val("");
		productQuery();
	}
	
	
	//初始化月的数据
 	function initOlv() {		
 		var url = __ctxPath+"/mem/getMemberByMonthMTime";
		olvPagination = $("#olvPagination").myPagination({
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
		//初始化周的数据
		var url1 = __ctxPath+"/mem/getMemberRegister";
		olvPagination1 = $("#olvPagination1").myPagination({
	           ajax: {
	        	   on: true,
	               url: url1,
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
	           		 $("#olv_tab1 tbody").setTemplateElement("olv-list1").processTemplate(data);
	             }
	           }
	         });
		
    } 
 	function toChar(data) {
		if(data == null) {
			data = "";
		}
		return data;
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/mem/MemberRegister.jsp");
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
	<div class="page-body" id="productSaveBody">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<h5 class="widget-caption">统计会员周，月注册总数</h5>
								 <div class="widget-buttons">
										<a href="#" data-toggle="maximize"></a> <a href="#"
											data-toggle="collapse" onclick="tab('pro');"> <i
											class="fa fa-minus" id="pro-i"></i>
										</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body">
								<div class="table-toolbar">
	                                	<ul class="topList clearfix">                           			
	                                		<li class="col-md-4">
	                                			<span class="titname">注册时间：</span>
	                                			<input type="text" id="reservation"/>
	                               			</li>
	                               			<li class="col-md-4">
	                               				<a class="btn btn-default shiny" onclick="query();">查询</a>&nbsp;&nbsp;
												<a class="btn btn-default shiny" onclick="reset();">重置</a>
	                                		</li>
	                                	</ul>
	                                  <div class="pull-left" style="padding: 10px 0;">
										<form id="product_form" action="">
												<input type="hidden" id="m_timeStartDate_form" name="m_timeStartDate"/>
												<input type="hidden" id="m_timeEndDate_form" name="m_timeEndDate"/> 
												<input type="hidden" id="cache" name="cache" value="1" />
										</form>
									</div>
	                                </div>
								<div class="tabbable">
									<ul class="nav nav-tabs" id="myTab">
										<li class="active" id="li_base"><a data-toggle="tab"
											id="month_a" href="#month"> <span>月统计</span>
										</a></li>
										<li class="tab-red" id="li_shoppe"><a data-toggle="tab"
											id="week_a" href="#week"> <span>周统计</span>
										</a></li>
									</ul>
									<!-- BaseMessage start -->
									<div class="tab-content">
										<div id="month" class="tab-pane in active">
											<form id="baseForm" method="post" class="form-horizontal">
												<div class="col-md-12">
													<hr class="wide" style="margin-top: 0;">
													<div class="table-toolbar">
					                                <div style="width:100%; height:0%; overflow-Y: hidden;">
					                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
					                                        <thead>
					                                            <tr role="row" style='height:35px;'> 
					                                            	
					                                                <th width="10%" style="text-align: center;">月</th>
					                                                <th width="15%" style="text-align: center;">注册总数</th>
					                                            </tr>
					                                        </thead>
					                                        <tbody>
					                                        </tbody>
					                                    </table>
					                                   </div>
					                                   <!-- <div id="olvPagination"></div> --> 
					                                </div>
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
													</div>
												</div>
											</form>
										</div>
										<div id="week" class="tab-pane in active">
											<form id="baseForm" method="post" class="form-horizontal">
												<div class="col-md-12">
													<hr class="wide" style="margin-top: 0;">
													<div class="table-toolbar">
					                                <div style="width:100%; height:0%; overflow-Y: hidden;">
					                                    <table class="table-striped table-hover table-bordered" id="olv_tab1" style="width: 100%;background-color: #fff;margin-bottom: 0;">
					                                        <thead>
					                                            <tr role="row" style='height:35px;'> 
					                                            	
					                                                <th width="10%" style="text-align: center;">周</th>
					                                                <th width="15%" style="text-align: center;">注册总数</th>
					                                            </tr>
					                                        </thead>
					                                        <tbody>
					                                        </tbody>
					                                    </table>
					                                   </div>
					                                   <!-- <div id="olvPagination1"></div> --> 
					                                </div>
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
													</div>
												</div>
											</form>
										</div>

										<!-- ProMessage start -->
										<p style="display:none">
											<textarea id="olv-list" rows="0" cols="0">
												<!--
												{#template MAIN}
													{#foreach $T.list as Result}
														<tr class="gradeX" id="gradeX{$T.Result.sid}"  style="height:35px;">
															
															<td align="center" id="days_{$T.Result.sid}">
															    {$T.Result.days}
															</td>
															<td align="center" id="total_{$T.Result.sid}">
															    {$T.Result.total}
															</td>
											       		</tr>
													{#/for}
											    {#/template MAIN}	-->
											</textarea>
										</p>
										<p style="display:none">
											<textarea id="olv-list1" rows="0" cols="0">
												<!--
												{#template MAIN}
													{#foreach $T.list as Result}
														<tr class="gradeX" id="gradeX{$T.Result.sid}"  style="height:35px;">
															<td align="center" id="days_{$T.Result.sid}">
															    {$T.Result.days}
															</td>
															<td align="center" id="total_{$T.Result.sid}">
															    {$T.Result.total}
															</td>
											       		</tr>
													{#/for}
											    {#/template MAIN}	-->
											</textarea>
										</p>
										<div id="show" class="tab-pane"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>