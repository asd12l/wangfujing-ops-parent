<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dateTime/datePicker.css"/>
<!--Bootstrap Date Range Picker-->
<script src="${pageContext.request.contextPath}/assets/js/datetime/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/datetime/datepicker.js"></script>
<script type="text/javascript"src="http://10.6.2.152:8081/log-analytics/wfj-log.js"></script>
<style type="text/css">
.trClick>td,.trClick>th{
 color:red;
}
</style>
<script type="text/javascript">
//上下文路径
__ctxPath = "${pageContext.request.contextPath}";
//接入log监控start
var userName;
var logJs;	
var sessionId = '<%=request.getSession().getId()%>';
function reloadjs(){
      var head= document.getElementsByTagName('head')[0]; 
      var script= document.createElement('script'); 
           script.type= 'text/javascript'; 
           script.onload = script.onreadystatechange = function() { 
      if (!this.readyState || this.readyState === "loaded" || this.readyState === "complete" ) { 
               script.onload = script.onreadystatechange = null; 
               }}; 
        script.src= logJs; 
            head.appendChild(script);  
}
function sendParameter(){
         LA.sysCode = '57';
       }
//接入log监控end
//页码
var olvPagination;
//var format=new RegExp("^(((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})/(0?[13578]|1[02])/(0?[1-9]|[12]\\d|3[01]))|((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})/(0?[13456789]|1[012])/(0?[1-9]|[12]\\d|30))|((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})/0?2/(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((04|08|12|16|[2468][048]|[3579][26])00))/0?2-29)) (20|21|22|23|[0-1]?\\d):[0-5]?\\d:[0-5]?\\d$");
//只做了简单的日期格式效验(不能效验瑞年) 格式为  yyyy-MM-dd hh:mm:ss 年月日分隔符可以为(-和/)  
var format=/^[\s]*[\d]{4}(\/|-)(0?[1-9]|1[012])(\/|-)(0?[1-9]|[12][0-9]|30|31)[\s]*(0?[0-9]|1[0-9]|2[0-3])(:([0-5][0-9])){2}[\s]*$/;
//初始时间选择器
function timePickInit(){
	var endTime=new Date();
	var startTime=new Date();
	startTime.setDate(endTime.getDate()-30);
	$('#verifyStartTime_input').daterangepicker({
		startDate:startTime,
//		endDate:endTime,
		timePicker:true,
		timePickerSeconds:true,
		timePicker24Hour:true,
//		minDate:startTime,
		maxDate:endTime,
//		linkedCalendars:false,
		opens:'center',
		showDropdowns : true,
		locale : {
		  format: "YYYY/MM/DD HH:mm:ss",
          applyLabel : '确定',
          cancelLabel : '取消',
          fromLabel : '起始时间',
          toLabel : '结束时间',
          customRangeLabel : '自定义',
          daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
          monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
              '七月', '八月', '九月', '十月', '十一月', '十二月' ],
          firstDay : 1
      },
		singleDatePicker:true});
	$('#verifyEndTime_input').daterangepicker({
		startDate:endTime,
//		endDate:endTime,
		timePicker:true,
		timePickerSeconds:true,
		timePicker24Hour:true,
//		minDate:startTime,
		maxDate:endTime,
//		linkedCalendars:false,
		opens:'center',
		showDropdowns : true,
		locale : {
		  	format: "YYYY/MM/DD HH:mm:ss",
          applyLabel : '确定',
          cancelLabel : '取消',
          fromLabel : '起始时间',
          toLabel : '结束时间',
          customRangeLabel : '自定义',
          daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
          monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
              '七月', '八月', '九月', '十月', '十一月', '十二月' ],
          firstDay : 1
      },
		singleDatePicker:true});
}

//页面加载完成后自动执行
$(function() {
	//渲染日期
	timePickInit();
	//初始化
    initOlv();
});

function parseTime1(strTime){
	if(format.test(strTime)){
		var ymdArr=strTime.split(" ")[0].split("/");//年月日
		var hmsArr=strTime.split(" ")[1].split(":");//时分秒
		return new Date(ymdArr[0],ymdArr[1]-1,ymdArr[2],hmsArr[0],hmsArr[1],hmsArr[2]).getTime();
	}
	return "";
}
//解析时间
function parseTime(str,separator,type){
	if(str){
		var arr=str.split(separator);
		var date=new Date(arr[0],arr[1]-1,arr[2]);
		if(type==1){
			date.setHours(0);
			date.setMinutes(0);
			date.setSeconds(0);
		}
		if(type==2){
			date.setHours(23);
			date.setMinutes(59);
			date.setSeconds(59);
		}
		return date.getTime();
	}
}

//以特定格式格式日期           格式：  年-月-日 时：分：秒
function formatDate(time){
	if(isNaN(time)){
		return;
	}
	var date=new Date(parseInt(time));
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	month=month>9?month:'0'+month;
	var day=date.getDate();
	day=day>9?day:'0'+day;
	var hour=date.getHours();
	hour=hour>9?hour:'0'+hour;
	var minute=date.getMinutes();
	minute=minute>9?minute:'0'+minute;
	var second=date.getSeconds();
	second=second>9?second:'0'+second;
	return year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
}
//格式化时间二
function formateDate2(date){
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	var day=date.getDate();
	return year+"/"+month+"/"+day;
}
//导出excel
function excelOrder() {
	sendParameter();
	LA.log('payOrder-excel', '支付日志明细导出Excel', userName, sessionId);
	var url=__ctxPath+"/wfjpay/order/checkOrderExport";
	var remoteUrl=__ctxPath+"/wfjpay/order/getOrderToExcel?";
	var params = $("#olv_form").serialize();
    params = decodeURI(params);
    var downloadUrl=remoteUrl+params;
	$.post(url,params,function(data){
		if($("#olv_tab tbody tr").size()==0){
			$("#model-body-warning")
			.html(
					"<div class='alert alert-warning fade in'><strong>查询结果为空，无法导出Excel!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return;
		}
		
		if(data.success==true){
//			$("#downloadLink").attr("href",downloadUrl);
//			$("#excelDiv").show();
			window.open(downloadUrl);
		}else{
			$("#model-body-warning")
			.html(
					"<div class='alert alert-warning fade in'><strong>参数检查失败，无法正常导出Excel!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
		}
	},"json");
}

//查询数据
function olvQuery(){
	//设置表单数据
	setFormData();
	//生成表单请求参数
    var params = $("#olv_form").serialize();
    params = decodeURI(params);
    //根据参数读取数据
    olvPagination.onLoad(params);
}

//设置表单数据
function setFormData(){
	$("#orderId_form").val($("#orderId_input").val())
	$("#outerTid_form").val($("#outerTid_input").val());
	$("#outerItemId_form").val($("#outerItemId_input").val());
	$("#verifyStoreId_form").val($("#verifyStoreId_input").val());
	var strStartTime = $("#verifyStartTime_input").val();
	var strEndTime = $("#verifyEndTime_input").val();
	$("#verifyStartTime_form").val(parseTime1(strStartTime));
	$("#verifyEndTime_form").val(parseTime1(strEndTime));
}	
	
//重置
function reset(){
	sendParameter();
	LA.log('payOrder-reset', '支付日志明细查询条件重置', userName, sessionId);
	$("#orderId_input").val("");
	$("#outerTid_input").val("");
	$("#outerItemId_input").val("");
	$("#verifyStoreId_input").val("");
	timePickInit();
	olvQuery();
}
//初始化函数
function initOlv() {
	//请求地址
	var url = __ctxPath+"/wfjpay/coupon/findAllYZCouponByPage";
	setFormData();
	//分页工具
	olvPagination = $("#olvPagination").myPagination({
	panel: {
		//启用跳页
		tipInfo_on: true,
		 //跳页信息
		 tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
		 //跳页样式
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
   //ajax请求
   ajax: {
	   //ajax请求开启状态
	   on: true,
	   //请求地址
	   url: url,
	   //数据类型
	   dataType: 'json',
	   param:$("#olv_form").serialize(),
	   ajaxStart : function() {
	   		$("#loading-container").attr("class","loading-container");
   		},
		ajaxStop : function() {
			//隐藏加载提示
			setTimeout(function() {
				$("#loading-container").addClass("loading-inactive");
			}, 300);
		},
		error:function(){
			//隐藏加载提示
			setTimeout(function() {
				$("#loading-container").addClass("loading-inactive");
			}, 300);
			alert("有赞电商券核销查询超时！");
		},
		//超时时间
		timeout:30*1000,
		//回调
		callback: function(data) {
		userName = data.userName ;
		logJs = data.logJs;
		reloadjs();
		sendParameter();
		LA.log('payOrder-query', '支付日志明细查询', userName, sessionId);
		$("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
	 }
		
   }
 });
}

function closeBtDiv(){
	$("#btDiv").hide();
}

function closeExcelDiv(){
	$("#excelDiv").hide();
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

function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	$("#pageBody").load(__ctxPath+"/jsp/OrderListView.jsp");
}
</script> 
</head>
<body>
<input type="hidden" id="ctxPath" value="${pageContext.request.contextPath}" />
<!-- Main Container -->
<div class="main-container container-fluid">
    <!-- 内容显示区域 -->
    <div class="page-container">
            <!-- Page Body -->
            <div class="page-body" id="pageBodyRight">
                <div class="row">
                    <div class="col-xs-12 col-md-12">
                        <div class="widget">
                            <div class="widget-header ">
                                <h5 class="widget-caption">有赞电商券核销查询</h5>
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
                        						<label class="titname">核销开始时间：</label>
			                    				<input type="text" id="verifyStartTime_input" />
			                   				</li>
			                   				<li class="col-md-4">
			                    				<label class="titname">核销结束时间：</label>
			                    				<input type="text" id="verifyEndTime_input" />
			                				</li>
                               				<li class="col-md-4">
	                            				<label class="titname">有赞订单号：</label>
	                            				<input type="text" id="orderId_input"/>
                            				</li>                               				
                               				<li class="col-md-4">
                                				<label class="titname">外部订单号：</label>
                                				<input type="text" id="outerTid_input"/>
                                			</li>
                               				<li class="col-md-4">
                               					<label class="titname">SKU：</label>
                               					<input type="text" id="outerItemId_input"/>
                               				</li>
                                			<li class="col-md-4">
                                					<label class="titname">核销门店：</label>
                                    				<input type="text" id="verifyStoreId_input"/>
											</li>
                            				<li class="col-md-4">
                            					<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
                            					<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;
												<a class="btn btn-yellow" onclick="excelOrder();" style="display:none;">导出Excel</a>
											</li>
                                		</ul>
                                	<!--隐藏参数-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
										<input type="hidden" id="orderId_form" name="orderId"/>
										<input type="hidden" id="outerTid_form" name="outerTid"/>
										<input type="hidden" id="outerItemId_form" name="outerItemId"/>
										<input type="hidden" id="verifyStoreId_form" name="verifyStoreId"/>
										<input type="hidden" id="storeId_form" name="storeId" value="D001"/>
										<input type="hidden" id="verifyStartTime_form" name="verifyStartTime"/>
										<input type="hidden" id="verifyEndTime_form" name="verifyEndTime"/>
										<input type="hidden" id="sortType_form" name="sortType" value="-1"/>
										<input type="hidden" id="sortParam_form" name="sortParam" value="updateTime"/>
                                  	</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%; min-height:400px; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="3%" style="text-align: center;">有赞订单号</th>
                                            <th width="3%" style="text-align: center;">外部订单号</th>
                                            <th width="3%" style="text-align: center;">SKU</th>
                                            <th width="3%" style="text-align: center;">商品名称</th>
                                            <th width="2%" style="text-align: center;">支付日期</th>
                                            <th width="2%" style="text-align: center;">支付时间</th>
                                            <th width="2%" style="text-align: center;">支付金额(元)</th>
                                            <th width="2%" style="text-align: center;">核销门店</th>
                                            <th width="2%" style="text-align: center;">核销金额(元)</th>
                                            <th width="2%" style="text-align: center;">核销日期</th>
                                            <th width="2%" style="text-align: center;">核销时间</th>                             
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                                </div>
                                <!--分页工具-->
                                <div id="olvPagination"></div>
                            </div>
                            <!--模板数据-->
							<!-- Templates -->
							<!--默认隐藏-->
							<p style="display:none">
								<textarea id="olv-list" rows="0" cols="0">
									{#template MAIN}
										{#foreach $T.list as Result}
											<tr class="gradeX" id="gradeX{$T.Result.id}" style="height:35px;">
												
												<td align="center" id="orderId_{$T.Result.id}">
													{#if typeof $T.Result.orderId=="string"}
														{$T.Result.orderId}
					                   				{#/if}
												</td>
												<td align="center" id="outerTid_{$T.Result.id}">
													{#if typeof $T.Result.outerTid=="string"}
														{$T.Result.outerTid}
					                   				{#/if}
												</td>
												<td align="center" id="outerItemId_{$T.Result.id}">
													{#if typeof $T.Result.outerItemId=="string"}
														{$T.Result.outerItemId}
					                   				{#/if}
												</td>
												<td align="center" id="goodsName_{$T.Result.id}">
													{#if typeof $T.Result.goodsName=="string"}
														{$T.Result.goodsName}
					                   				{#/if}
												</td>
												<td align="center" id="paymentDate_{$T.Result.id}">
													{#if typeof $T.Result.paymentDate=="string"}
														{$T.Result.paymentDate}
					                   				{#/if}
												</td>
												<td align="center" id="paymentTime_{$T.Result.id}">
													{#if typeof $T.Result.paymentTime=="string"}
														{$T.Result.paymentTime}
					                   				{#/if}
												</td>
												<td align="center" id="payment_{$T.Result.id}">
													{#if !isNaN($T.Result.payment)}
														{$T.Result.payment}
					                   				{#/if}
				                   				</td>
												<td align="center" id="verifyStoreId_{$T.Result.id}">
													{#if typeof $T.Result.verifyStoreId=="string"}
														{$T.Result.verifyStoreId}
					                   				{#/if}
												</td>
												<td align="center" id="totalFee_{$T.Result.id}">
													{#if !isNaN($T.Result.totalFee)}
														{$T.Result.totalFee}
					                   				{#/if}
												</td>
												<td align="center" id="verifyDate_{$T.Result.id}">
													{#if typeof $T.Result.verifyDate=="string"}
														{$T.Result.verifyDate}
					                   				{#/if}
												</td>
												<td align="center" id="verifyTime_{$T.Result.id}">
													{#if typeof $T.Result.verifyTime=="string"}
														{$T.Result.verifyTime}
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
<!--详细数据显示区域-->
<div class="modal modal-darkorange" id="btDiv">
    <div class="modal-dialog" style="width: 800px;height:80%;margin: 3% auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv();">×</button>
                <h4 class="modal-title" id="divTitle"></h4>
            </div>
            <div class="page-body" id="pageBodyRight">
            </div>
            <div class="tabbable"> <!-- Only required for left/right tabs -->
			      <ul class="nav nav-tabs">
			        <li class="active"><a href="#tab1" data-toggle="tab">支付内容</a></li>
			        <li><a href="#tab2" data-toggle="tab">请求详情</a></li>
			      </ul>
			      <div class="tab-content">
			      	<div class="tab-pane active" id="tab1">
			      		<div style="width:100%;height:200px; overflow:scroll;">
			      			<table class="table-striped table-hover table-bordered" id="OLV1_tab" style="width: 300%;background-color: #fff;margin-bottom: 0;">
			      			</table>
			      </div>
			        </div>
			        <div class="tab-pane" id="tab2">
			         	<div style="width:100%;height:200px; overflow:scroll;">
			                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
			                    </table>
			            </div>
			        </div>
			      </div>
			</div>
			<!--关闭按钮-->
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv();" type="button">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div> 
<!--下载显示区域-->
<div class="modal modal-darkorange" id="excelDiv">
<div class="modal-dialog" style="width: 450px;height:50%;margin: 10% auto;">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeExcelDiv();">×</button>
            <h4 class="modal-title" id="dowloadTitle">下载</h4>
        </div>
        <div class="page-body" id="pageBodyRight">
        	<a class="btn btn-default shiny" href="" id="downloadLink">点击下载</a>
        </div>
        
		<!--关闭按钮-->
        <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-default" onclick="closeExcelDiv();" type="button">关闭</button>
        </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div> 
<script>
//页面加载完成后执行函数
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