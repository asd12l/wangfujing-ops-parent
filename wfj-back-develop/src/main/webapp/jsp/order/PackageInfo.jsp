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
<title>订单包裹信息</title>
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
	var userName;
	var logUrl;
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
		LA.log('packageInfo-search', '包裹单查询', userName,  sessionId);
		var userName = getCookieValue("username");
		var orderNo = $("#saleNo_input").val().trim();
		var deliveryNo = $("#deliveryNo_input").val().trim();
		if(""==orderNo){
			orderNo=deliveryNo;
		}
		//保存日志
		$.ajax({
			type : "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/saveOpsOperateLogs",
			async:false,
			dataType: "json",
			data:{"orderNo":orderNo,"operateMan":userName,"buttonType":"查询","pageName":"PackageInfo.jsp"},
			success : function(response) {
				if (response.success == "true") {
					console.log("日志保存成功！");
				} else{
					console.log("日志保存失败！");
				}
			}
		});
		
		$("#saleNo_form").val($("#saleNo_input").val().trim());
		$("#deliveryNo_form").val($("#deliveryNo_input").val().trim());
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
		$("#saleNo_input").val("");
		$("#deliveryNo_input").val("");
		$("#reservation").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/omsOrder/selectPackageInfoPage";
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
            	 userName = data.userName;
            	    logUrl = data.logUrl;
            	    reloadjs();
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
    }
 	//快递状态
	function trClick(deliveryNo,obj){
		$("#cd-timeline").html("")
		$.ajax({
			type : "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/selectPackageHistoryByOrderNo",
			async:false,
			dataType: "json",
			data : {"deliveryNo":deliveryNo},
			ajaxStart: function() {
		       	 $("#loading-container").attr("class","loading-container");
		        },
	        ajaxStop: function() {
	          //隐藏加载提示
	          setTimeout(function() {
	       	        $("#loading-container").addClass("loading-inactive");
	       	 },300);
	        },
			success : function(response) {
				if (response.success == "true") {
					var result = response.data;
					for (var j = 0; j < result.length; j++) {
						var priceLine;
						var ele = result[j];
						if((ele.deliveryDateStr != "" && ele.deliveryDateStr != undefined) && (ele.deliveryRecord != "" && ele.deliveryRecord != undefined)){
							if(ele.packageStatusDesc != "" && ele.packageStatusDesc != undefined){
								priceLine = "<div class='cd-timeline-block'>"
									+ "<div class='cd-timeline-img cd-picture'>"
									+ ele.packageStatusDesc
									+ "</div><div class='cd-timeline-content'><span class='cd-date'>"
									+ ele.deliveryDateStr  +ele.deliveryRecord
									+ "</span></div></div>";
							}else{
								priceLine = "<div class='cd-timeline-block'>"
									+ "<div class='cd-timeline-img cd-picture'>"
									+"已发出"+
									+ "</div><div class='cd-timeline-content'><span class='cd-date'>"
									+ ele.deliveryDateStr  +ele.deliveryRecord
									+ "</span></div></div>";
							}
						}else{
							if(ele.packageStatusDesc != "" && ele.packageStatusDesc != undefined){
								priceLine = "<div class='cd-timeline-block'>"
									+ "<div class='cd-timeline-img cd-picture'>"
									+ ele.packageStatusDesc
									+ "</div><div class='cd-timeline-content'><span class='cd-date'>"
									+ "</span></div></div>";
							}else{
								priceLine = "<div class='cd-timeline-block'>"
									+ "<div class='cd-timeline-img cd-picture'>"
									+"已发出"+
									+ "</div><div class='cd-timeline-content'><span class='cd-date'>"
									+ "</span></div></div>";
							}
						}
						$("#cd-timeline").append(priceLine);
					}
					$('.shiji').slideDown(600);
					$("#btDiv3").show();
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"快递获取失败"+"</strong></div>");
		     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
			},
			error : function() {
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"快递获取失败"+"</strong></div>");
	     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			}
		});
			
	}
	/*打开时间轴*/
	function showTimeLine() {
		$('.shiji').slideDown(600);

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
                                    <h5 class="widget-caption">包裹单信息管理</h5>
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
                                    				<label class="titname">发送时间：</label>
                                    				<input type="text" id="reservation" />
                                   				</li>
                                   				<li class="col-md-4">
                                    				<label class="titname">销售单号：</label>
                                    				<input type="text" id="saleNo_input"/>
                                   				</li>
                                   				<li class="col-md-4">
                                   					<label class="titname">快递单号：</label>
                                   					<input type="text" id="deliveryNo_input"/>
                                   				</li>
                                    				<li class="col-md-4">
                                    					<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
														<a class="btn btn-default shiny" onclick="reset();">重置</a>
                                    			</li>
                                    		</ul>
                                    	
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="10"/>
											<input type="hidden" id="saleNo_form" name="saleNo"/>
											<input type="hidden" id="deliveryNo_form" name="deliveryNo"/>
											<input type="hidden" id="startSaleTime_form" name="startSaleTime"/>
											<input type="hidden" id="endSaleTime_form" name="endSaleTime"/>
                                      	</form>
                                	<div style="width:100%; height:0%; min-height:300px; overflow-Y: hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                <th width="2%" style="text-align: center;">销售单号</th>
                                                <th width="2%" style="text-align: center;">快递单号</th>
                                                <th width="2%" style="text-align: center;">快递状态</th>
                                                <th width="2%" style="text-align: center;">发送时间</th>
                                                <th width="2%" style="text-align: center;">快递公司</th>
                                                
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
												{#if $T.Result.dayNum ==3}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px; color:yellow;">
													<td align="center" id="saleNo_{$T.Result.sid}">
														{#if $T.Result.saleNo != '[object Object]'}{$T.Result.saleNo}
						                   				{#/if}
													</td>
													<td align="center" id="deliveryNo{$T.Result.sid}">
														{#if $T.Result.deliveryNo != '[object Object]'}{$T.Result.deliveryNo}
						                   				{#/if}
													</td>
													<td align="center">
														<a id="{$T.Result.c2}_" onclick="trClick('{$T.Result.deliveryNo}',this);" style="cursor:pointer;">
															{#if $T.Result.c2 != '[object Object]'}{$T.Result.c2}
						                   					{#/if}
														</a>
													</td>
													<td align="center" id="sendTimeStr_{$T.Result.sid}">
														{#if $T.Result.sendTimeStr != '[object Object]'}{$T.Result.sendTimeStr	}
						                   				{#/if}
													</td>
													<td align="center" id="delComName_{$T.Result.sid}">
														{#if $T.Result.delComName != '[object Object]'}{$T.Result.delComName}
						                   				{#/if}
													</td>
									       		</tr>
												
												{#elseif ($T.Result.dayNum >=4&&$T.Result.dayNum <=7)}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px; color:orange">
						                   			<td align="center" id="saleNo_{$T.Result.sid}">
														{#if $T.Result.saleNo != '[object Object]'}{$T.Result.saleNo}
						                   				{#/if}
													</td>
													<td align="center" id="deliveryNo{$T.Result.sid}">
														{#if $T.Result.deliveryNo != '[object Object]'}{$T.Result.deliveryNo}
						                   				{#/if}
													</td>
													<td align="center">
														<a id="{$T.Result.c2}_" onclick="trClick('{$T.Result.deliveryNo}',this);" style="cursor:pointer;">
															{#if $T.Result.c2 != '[object Object]'}{$T.Result.c2}
						                   					{#/if}
														</a>
													</td>
													<td align="center" id="sendTimeStr_{$T.Result.sid}">
														{#if $T.Result.sendTimeStr != '[object Object]'}{$T.Result.sendTimeStr	}
						                   				{#/if}
													</td>
													<td align="center" id="delComName_{$T.Result.sid}">
														{#if $T.Result.delComName != '[object Object]'}{$T.Result.delComName}
						                   				{#/if}
													</td>
									       		</tr>
												{#elseif $T.Result.dayNum >7}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px; color:red">
						                   			<td align="center" id="saleNo_{$T.Result.sid}">
														{#if $T.Result.saleNo != '[object Object]'}{$T.Result.saleNo}
						                   				{#/if}
													</td>
													<td align="center" id="deliveryNo{$T.Result.sid}">
														{#if $T.Result.deliveryNo != '[object Object]'}{$T.Result.deliveryNo}
						                   				{#/if}
													</td>
													<td align="center">
														<a id="{$T.Result.c2}_" onclick="trClick('{$T.Result.deliveryNo}',this);" style="cursor:pointer;">
															{#if $T.Result.c2 != '[object Object]'}{$T.Result.c2}
						                   					{#/if}
														</a>
													</td>
													<td align="center" id="sendTimeStr_{$T.Result.sid}">
														{#if $T.Result.sendTimeStr != '[object Object]'}{$T.Result.sendTimeStr	}
						                   				{#/if}
													</td>
													<td align="center" id="delComName_{$T.Result.sid}">
														{#if $T.Result.delComName != '[object Object]'}{$T.Result.delComName}
						                   				{#/if}
													</td>
									       		</tr>
						                   		{#/if}
													
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
    <div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;"
		id="btDiv3">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv3();">×</button>
					<h2 class="modal-title" id="divTitle">快递信息</h2>
				</div>
				<div class="page-body" id="pageBodyRight"
					style="overflow-x: hidden; height: 400px;">
					<div class="row">
						<div class="col-xs-12 col-md-12">
							<div class="widget">
								<section id="cd-timeline" class="cd-container">
								</section>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv3();" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
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