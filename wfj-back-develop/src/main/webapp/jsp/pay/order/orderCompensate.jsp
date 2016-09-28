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
	startTime.setDate(endTime.getDate()-2);
	$('#timeStart_input').daterangepicker({
		startDate:startTime,
//		endDate:endTime,
		timePicker:true,
		timePickerSeconds:true,
		timePicker24Hour:true,
		minDate:startTime,
		maxDate:endTime,
//		linkedCalendars:false,
		opens:'center',
//		showDropdowns : true,
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
	$('#timeEnd_input').daterangepicker({
		startDate:endTime,
//		endDate:endTime,
		timePicker:true,
		timePickerSeconds:true,
		timePicker24Hour:true,
		minDate:startTime,
		maxDate:endTime,
//		linkedCalendars:false,
		opens:'center',
//		showDropdowns : true,
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
//	$('#timeSelect_input').val(formateDate2(startTime)+" - "+formateDate2(endTime));
	//初始化
    initOlv();
	//获取支付渠道
	payChannelType();
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
function parseTime(str,separator){
	if(str){
		var arr=str.split(separator);
		return new Date(arr[0],arr[1]-1,arr[2]).getTime();
	}
}

//以特定格式格式日期           格式：  年-月-日 时：分：秒
function formatDate(time){
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
//
function singleOrderQuery(orderTradeNo) {
	sendParameter();
	LA.log('payOrderCompensate-batchObtaining', '支付日志异常获取订单状态', userName, sessionId);
	if(orderTradeNo){
		$("#orderTradeNo_form").val(orderTradeNo);
	}else{
		setFormData();
	}
	var url=__ctxPath+"/wfjpay/order/singleOrderQuery";
	var params = $("#olv_form").serialize();
//    params = decodeURI(params);
	//加载框...
	$("#loading-container").attr("class","loading-container");
	//请求后台数据
	$.post(url,params,function(data){
		if(data.success=="true"){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
		}else{
			$("#model-body-warning")
			.html(
					"<div class='alert alert-warning fade in'><strong>操作失败</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
		}
	},"json").complete(function() { 
		//请求完成后隐藏加载框
		$("#loading-container").removeClass("loading-container");
		$("#loading-container").addClass("loading-inactive");
	});
}

//设置表单数据
function setFormData(){
	$("#orderTradeNo_form").val($("#orderTradeNo_input").val());
	$("#bpId_form").val($("#bpId_input").val());
	$("#payType_form").val($("#payType_input").val());
	$("#bpOrderId_form").val($("#bpOrderId_input").val());
	$("#initOrderTerminal_form").val($("#initOrderTerminal_input").val());
	var strStartTime = $("#timeStart_input").val();
	var strEndTime = $("#timeEnd_input").val();
	$("#startTime_form").val(parseTime1(strStartTime));
	$("#endTime_form").val(parseTime1(strEndTime));
}

//查询数据
function olvQuery(){
	sendParameter();
	LA.log('payOrderCompensate-query', '支付日志异常状态明细查询', userName, sessionId);
	//设置表单数据
	setFormData();
	//生成表单请求参数
    var params = $("#olv_form").serialize();
    params = decodeURI(params);
    //根据参数读取数据
    olvPagination.onLoad(params);
	}
//重置
function reset(){
	sendParameter();
	LA.log('payOrderCompensate-reset', '支付日志异常状态明细查询条件明细重置', userName, sessionId);
	$("#orderTradeNo_input").val("");
	$("#bpId_input").val("");
	$("#bpOrderId_input").val("");
	$("#payType_input").val("");
	$("#initOrderTerminal_input").val("");
	timePickInit();
	olvQuery();
}
//初始化函数
	function initOlv() {
		
	//请求地址
	var url = __ctxPath+"/wfjpay/order/findAllOrderCompensate";
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
         on: true,
         url: url,
         //数据类型
         dataType: 'json',
         param:$("#olv_form").serialize(),
//         //请求开始函数
//         ajaxStart: function() {
//           ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
//         },
//         //请求结束函数
//         ajaxStop: function() {
//           //隐藏加载提示
//           setTimeout(function() {
//             ZENG.msgbox.hide();
//           }, 300);
//         },
         ajaxStart : function() {
				$("#loading-container").attr("class","loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive");
				}, 300);
			},
         //回调
         callback: function(data) {
    		 for(var i in data.list){
    			 data.list[i ].createDate=formatDate(data.list[i].createDate);
    		 }
    		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
         }
       }
     });
	
	//业务接口
	var bpIdDateUrl=__ctxPath+"/wfjpay/businessStation";
	$.post(bpIdDateUrl,{flag:"0"},function(data){
		if(data.success=="true"){
			userName = data.userName ;
    		logJs = data.logJs;
    		reloadjs();
			var html="";
			var arr=data.list;
			for(var i=0;i<arr.length;i++){
				html+="<option value='"+arr[i].id+"'>"+arr[i].name+"</option>";
			}
			$("#bpId_input").html(html);
		}
		
	},"json");
    
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
}
//动态获取支付渠道类型
function payChannelType(){
		var url=__ctxPath+"/wfjpay/selectPayChannel";
		$.ajax({
			url:url,
			type:"post",
			dataType:"json",
			success:function(data){
				if(data.success=="true"){
					option="";
					for(var i in data.list){
						option+="<option value='"+data.list[i].name+"'>"+data.list[i].value+"</option>";
					}
					$("#payType_input").html("<option value=''>全部渠道</option>"+option);
				}
			},
			error:function(){
				alert("获取支付渠道类型失败！");
			}
		});
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
                                <h5 class="widget-caption">异常状态查询</h5>
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
                                				<label class="titname">订单开始时间：</label>
                                				<input type="text" id="timeStart_input" />
                               				</li>
                               				<li class="col-md-4">
	                            				<label class="titname">订单结束时间：</label>
	                            				<input type="text" id="timeEnd_input" />
                            				</li>
                               				<li class="col-md-4">
	                               				<label class="titname">业务接口：</label>
	                               				<select id="bpId_input" style="padding:0 0;">
	                               				</select>
                               				</li>
                               				<li class="col-md-4">
	                           					<label class="titname">订单终端类型：</label>
	                           					<select id="initOrderTerminal_input" style="padding:0 0;">
	                               					<option value="">全部</option>
	                               					<option value="01">PC端</option>
													<option value="02">移动端</option>
													<option value="03">PAD端</option>
													<option value="04">POS端</option>
			                                	</select>
		                                	</li>
		                                	<li class="col-md-4">
	                        					<label class="titname">支付渠道：</label>
	                        					<select id="payType_input" style="padding:0 0;">
	                        					<option value="">全部</option>
	                        					<!--
	                        					<option value="ALIPAY">支付宝</option>
	                        					<option value="TENPAY">财付通</option>
	                        					<option value="NETPAY">银联</option>
	                        					<option value="ICBCPAY">工商银行</option>
	                        					<option value="CMBPAY">招商银行</option>
	                        					<option value="CGBPAY">广发银行</option>
	                        					<option value="WECHATPAY">微信</option>
	                        					<option value="WECHATPAY_SHB ">微信扫货邦</option>
												<option value="ALIPAY_OFFLINE">支付宝线下</option>
												<option value=" ALIPAY_MOBILE ">支付宝WAP</option>
												<option value="WECHATPAY_MOBILE">微信WAP</option>
	                            					<option value="YEEBAO">富汇易达</option>
	                            					<option value="PAYPAL">Paypal</option>
	                        					-->
		                                		</select>
	                                		</li>
	                                		<li class="col-md-4">
	                            				<label class="titname">业务平台订单号：</label>
	                            				<input type="text" id="bpOrderId_input"/>
                            				</li>     
	                                		<li class="col-md-4">
	                           					<label class="titname">支付平台订单号：</label>
	                           					<input type="text" id="orderTradeNo_input"/>
                           					</li>
                            				<li class="col-md-4">
                            					<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
                            					<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;
												<a class="btn btn-yellow" onclick="singleOrderQuery();">批量获取订单状态</a>
											</li>
                                		</ul>
                                	<!--隐藏参数-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
										<input type="hidden" id="orderTradeNo_form" name="orderTradeNo"/>
										<input type="hidden" id="bpOrderId_form" name="bpOrderId"/>
										<input type="hidden" id="bpId_form" name="bpId"/>
										<input type="hidden" id="payType_form" name="payType"/>
										<input type="hidden" id="status_form" name="status" value="1"/>
										<input type="hidden" id="startTime_form" name="startTime"/>
										<input type="hidden" id="endTime_form" name="endTime"/>
										<input type="hidden" id="initOrderTerminal_form" name="initOrderTerminal"/>
										<input type="hidden" id="sortType_form" name="sortType" value="-1"/>
										<input type="hidden" id="sortParam_form" name="sortParam" value="createDate"/>
                                  	</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%; min-height:400px; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 150%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="2%" style="text-align: center;">支付平台订单号</th>
                                            <th width="2%" style="text-align: center;">业务平台订单号</th>
                                            <th width="3%" style="text-align: center;">业务接口</th>
                                            <th width="3%" style="text-align: center;">订单生成时间</th>
                                            <th width="4%" style="text-align: center;">订单内容</th>
                                            <th width="2%" style="text-align: center;">订单金额(元)</th>
                                            <th width="2%" style="text-align: center;">应付金额(元)</th>
                                            <th width="2%" style="text-align: center;">支付渠道</th>
                                            <th width="2%" style="text-align: center;">状态 </th>
                                            <th width="2%" style="text-align: center;">支付平台流水号 </th>
                                            <th width="2%" style="text-align: center;">订单终端类型</th>
                                            <th width="2%" style="text-align: center;">操作</th>
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
										<tr class="gradeX" id="gradeX{$T.Result.orderTradeNo}" style="height:35px;">
											<td align="center" id="orderTradeNo_{$T.Result.orderTradeNo}">
												{#if $T.Result.orderTradeNo!= '[object Object]'}{$T.Result.orderTradeNo}
												{#/if}
											</td>
											<td align="center" id="orderNo_{$T.Result.orderTradeNo}">
												{$T.Result.bpOrderId}
											</td>
											<td align="center" id="bpName_{$T.Result.orderTradeNo}">
												{#if $T.Result.bpName != '[object Object]'}{$T.Result.bpName}
				                   				{#/if}
											</td>
											<td align="center" id="createDate_{$T.Result.orderTradeNo}">
												{#if $T.Result.createDate!= '[object Object]'}{$T.Result.createDate}
				                   				{#/if}
											</td>
											<td align="center" id="content_{$T.Result.orderTradeNo}">
												{#if $T.Result.content != '[object Object]'}{$T.Result.content}
				                   				{#/if}
											</td>
											<td align="center" id="totalFee_{$T.Result.orderTradeNo}">
												{#if $T.Result.totalFee != '[object Object]'}{$T.Result.totalFee}
				                   				{#/if}
											</td>
											<td align="center" id="needPayPrice_{$T.Result.orderTradeNo}">
												{#if $T.Result.needPayPrice != '[object Object]'}{$T.Result.needPayPrice}
				                   				{#/if}
											</td>
											<td align="center" id="payTypeName_{$T.Result.orderTradeNo}">
												{#if $T.Result.payTypeName != '[object Object]'}{$T.Result.payTypeName}
				                   				{#/if}
											</td>
											<td align="center" id="statusName_{$T.Result.orderTradeNo}">
												{#if $T.Result.statusName != '[object Object]'}{$T.Result.statusName}
				                   				{#/if}
											</td>
											<td align="center" id="paySerialNumber_{$T.Result.orderTradeNo}">
												{#if $T.Result.paySerialNumber != '[object Object]'}{$T.Result.paySerialNumber}
				                   				{#/if}
											</td>
											<td align="center" id="initOrderTerminalName_{$T.Result.orderTradeNo}">
												{#if $T.Result.initOrderTerminalName != '[object Object]'}{$T.Result.initOrderTerminalName}
				                   				{#/if}
											</td>
											<td align="center">
												<a class="btn btn-default purple btn-sm fa fa-edit" onclick="singleOrderQuery('{$T.Result.orderTradeNo}');"> 手动获取订单状态</a>
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