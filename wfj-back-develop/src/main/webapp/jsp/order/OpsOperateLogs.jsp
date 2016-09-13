<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<script src="${ctx}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${ctx}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${ctx}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${ctx}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/js/pagination/myPagination/page.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/assets/css/dateTime/datePicker.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/css/timeline/css/timeline2.css" />
<!--Bootstrap Date Range Picker-->
<script src="${ctx}/assets/js/datetime/moment.min.js"></script>
<script src="${ctx}/assets/js/datetime/datepicker.js"></script>
<title>操作日志信息</title>
<style type="text/css">
/* .trClick>td,.trClick>th{
 color:red;
} */
</style>
  <script type="text/javascript">
		__ctxPath = "${ctx}";
		image="http://images.shopin.net/images";
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	var olvPagination;
	var logUrl = '';
	var username = '';
	$(function() {
		$('#reservation').daterangepicker({
			timePicker: true,
			timePickerSeconds:true,
			timePicker24Hour:true,
			timePickerIncrement: 1,
            locale : {
				format: 'YYYY/MM/DD HH:mm:ss',
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        });
		$("#reservation").val("");
	    initOlv();
	});
	//引用埋点js方法
	function reloadjs(){
		var head= document.getElementsByTagName('head')[0]; 
		var script= document.createElement('script'); 
		script.type= 'text/javascript'; 
		script.onload = script.onreadystatechange = function() { 
		if (!this.readyState || this.readyState === "loaded" || this.readyState === "complete" ) { 
		/* help(); */ 
		// Handle memory leak in IE 
		script.onload = script.onreadystatechange = null; 
		} }; 
		script.src= logUrl; 
		head.appendChild(script);
	} 
	function olvQuery(){
		LA.env = 'dev';
 		LA.sysCode = '21';
		var sessionId = '<%=request.getSession().getId()%>';
		LA.log('search olvQuery', '操作日志查询', username,  sessionId);
		$("#orderNo_form").val($("#orderNo_input").val().trim());
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startSaleTime_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endSaleTime_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startSaleTime_form").val("");
			$("#endSaleTime_form").val("");
		}
        var params = $("#olv_form").serialize();
		params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#orderNo_input").val("");
		$("#reservation").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/omsOrder/selectOpsOperateLogs";
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
             /* ajaxStart: function() {
               ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
             },
             ajaxStop: function() {
               //隐藏加载提示
               setTimeout(function() {
                 ZENG.msgbox.hide();
               }, 300);
             }, */
             ajaxStart : function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive");
					}, 300);
				},
             callback: function(data) {
            	 username = data.username;
            	 logUrl = data.logUrl;
            	 reloadjs();
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
    }
	//折叠页面
	function tab(data){
		if($("#"+data+"-i").attr("class")=="fa fa-minus"){
			$("#"+data+"-i").attr("class","fa fa-plus");
			$("#"+data).css({"display":"none"});
		}else if(data=='pro'){
			$("#"+data+"-i").attr("class","fa fa-minus");
			$("#"+data).css({"display":"block"});
		}else{
			$("#"+data+"-i").attr("class","fa fa-minus");
			$("#"+data).css({"display":"block"});
			$("#"+data).parent().siblings().find(".widget-body").css({"display":"none"});
			$("#"+data).parent().siblings().find(".fa-minus").attr("class","fa fa-plus");
		}
	}
	function closeBtDiv3(){
		$("#btDiv3").hide();
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/OrderListView.jsp");
	}
	</script> 
</head>
<body>
	<input type="hidden" id="ctxPath" value="${ctx}" />
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
                                    <h5 class="widget-caption">日志信息管理</h5>
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
                                    		<ul class="topList clearfix">                           			
                                    			 <li class="col-md-4">
                                    				<label class="titname">操作时间：</label>
                                    				<input type="text" id="reservation" />
                                   				</li>
                                   				<li class="col-md-4">
                                    				<label class="titname">单据号：</label>
                                    				<input type="text" id="orderNo_input"/>
                                   				</li>
                                    				<li class="col-md-4">
                                    					<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
														<a class="btn btn-default shiny" onclick="reset();">重置</a>
                                    			</li>
                                    		</ul>
                                    	
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="10"/>
											<input type="hidden" id="orderNo_form" name="orderNo"/>
											<input type="hidden" id="startSaleTime_form" name="startSaleTime"/>
											<input type="hidden" id="endSaleTime_form" name="endSaleTime"/>
                                      	</form>
                                	<div style="width:100%; height:0%; min-height:300px; overflow-Y: hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                <th width="2%" style="text-align: center;">单据号</th>
                                                <th width="2%" style="text-align: center;">页面名称</th>
                                                <th width="2%" style="text-align: center;">按钮类型</th>
                                                <th width="2%" style="text-align: center;">备注</th>
                                                <th width="2%" style="text-align: center;">操作人</th>
                                                <th width="2%" style="text-align: center;">操作时间</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    </div>
                                    <div id="olvPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px;">
													<td align="center" id="orderNo_{$T.Result.sid}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.orderNo}
						                   				{#/if}
													</td>
													<td align="center" id="pageName_{$T.Result.sid}">
														{#if $T.Result.pageName != '[object Object]'}{$T.Result.pageName}
						                   				{#/if}
													</td>
													<td align="center" id="buttonType_{$T.Result.sid}">
														{#if $T.Result.buttonType != '[object Object]'}{$T.Result.buttonType	}
						                   				{#/if}
													</td>
													<td align="center" id="remark_{$T.Result.sid}">
														{#if $T.Result.remark != '[object Object]'}{$T.Result.remark}
						                   				{#/if}
													</td>
													<td align="center" id="operateMan_{$T.Result.sid}">
														{#if $T.Result.operateMan != '[object Object]'}{$T.Result.operateMan}
						                   				{#/if}
													</td>
													<td align="center" id="operatorTimeStr_{$T.Result.sid}">
														{#if $T.Result.operatorTimeStr != '[object Object]'}{$T.Result.operatorTimeStr}
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
    <script>
    jQuery(document).ready(
			function () {
				$('#divTitle').mousedown(
					function (event) {
						var isMove = true;
						var abs_x = event.pageX - $('#btDiv').offset().left;
						var abs_y = event.pageY - $('#btDiv').offset().top;
						$(document).mousemove(function (event) {
							if (isMove) {
								var obj = $('#btDiv');
								obj.css({'left':event.pageX - abs_x, 'top':event.pageY - abs_y});
								}
							}
						).mouseup(
							function () {
								isMove = false;
							}
						);
					}
				);
			}
		);	
	</script> 
</body>
</html>