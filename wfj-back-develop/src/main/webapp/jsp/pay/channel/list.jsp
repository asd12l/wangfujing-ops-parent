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
	$('#timeStart_input').daterangepicker({
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
	$('#timeEnd_input').daterangepicker({
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
	//动态获取支付渠道
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

function parseTime(strTime){
	if(format.test(strTime)){
		var ymdArr=strTime.split(" ")[0].split("-");//年月日
		var hmsArr=strTime.split(" ")[1].split(":");//时分秒
		return new Date(ymdArr[0],ymdArr[1]-1,ymdArr[2],hmsArr[0],hmsArr[1],hmsArr[2]).getTime();
	}
}

//以特定格式格式日期           格式：  年-月-日 时：分：秒
function formatDate(time){
	if(isNaN(time)){
		return "";
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
function excelChannel() {
	sendParameter();
	LA.log('statistics-channel-excel', '统计管理按渠道查询结果导出Excel', userName, sessionId);
	var url=__ctxPath+"/wfjpay/statistics/checkStatisticsExport";
//	var remoteUrl="http://10.6.2.150/wfjpay/admin/statistics_type/export.do?";
	var remoteUrl=__ctxPath+"/wfjpay/statisticsType/getChannelToExcel?";
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
		if(data.success=="true"){
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
//设置表单
function setFormData(){
	$("#bpId_form").val($("#bpId_input").val());
	$("#finalPayTerminal_form").val($("#finalPayTerminal_input").val());
	$("#payType_form").val($("#payType_input").val());
	$("#payService_form").val($("#payService_input").val());
	if($("#payBank_input").val()!="0"){
		$("#payBank_form").val($("#payBank_input").val());
	}else{
		$("#payBank_form").val("");
	}
	var strStartTime = $("#timeStart_input").val();
	var strEndTime = $("#timeEnd_input").val();
	$("#startTime_form").val(parseTime1(strStartTime));
	$("#endTime_form").val(parseTime1(strEndTime));
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
//重置
function reset(){
	sendParameter();
	LA.log('statistics-channel-reset', '统计管理按渠道查询条件重置', userName, sessionId);
	$("#bpId_input").val("");
	$("#payType_input").val("");
	$("#finalPayTerminal_input").val("");
	$("#payType_input").html("");
	$("#payService_input").html("");
	$("#payBank_input option:eq(0)").attr('selected','selected');
	$("#payBank_input").html("");
	timePickInit();
	olvQuery();
}
var payChannelOption = "<option value=''>全部</option>";
//动态获取支付渠道类型
function payChannelType(){
		var url=__ctxPath+"/wfjpay/selectPayChannel";
		$.ajax({
			url:url,
			type:"post",
			dataType:"json",
			success:function(data){
				if(data.success=="true"){
				//	option="";
					for(var i in data.list){
						payChannelOption+="<option value='"+data.list[i].name+"'>"+data.list[i].value+"</option>";
					}
					//$("#payType_input").html("<option value=''>全部渠道</option>"+option);
				}
			},
			error:function(){
				alert("获取支付渠道类型失败！");
			}
		});
	}

//初始化函数
	function initOlv() {
	//请求地址
	var url = __ctxPath+"/wfjpay/channel";
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
         //请求开始函数
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
        	 userName = data.userName ;
     	   	logJs = data.logJs;
     		reloadjs();
     		sendParameter();
     		LA.log('statistics-channel-query', '统计管理按渠道查询', userName, sessionId);
        	 for(var i in data.list){
        		 data.list[i].createDate=formatDate(data.list[i].createDate);
        	 }
       		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
         }
       }
     });
	
	//业务接口
	var bpIdDateUrl=__ctxPath+"/wfjpay/businessStation";
	$.post(bpIdDateUrl,{flag:"0"},function(data){
		if(data.success=="true"){
			var html="";
			var arr=data.list;
			for(var i=0;i<arr.length;i++){
				html+="<option value='"+arr[i].id+"'>"+arr[i].name+"</option>";
			}
			$("#bpId_input").html(html);
		}
		
	},"json");
    
	setFormData();
	
	//菜单联动
/* 	var payChannelOption="<option value=''>全部</option>"
						+"<option value='ALIPAY'>支付宝</option>"
						+"<option value='TENPAY'>财付通</option>"
						+"<option value='NETPAY'>银联</option>"
						+"<option value='ICBCPAY'>工商银行</option>"
    					+"<option value='CMBPAY'>招商银行</option>"
    					+"<option value='CGBPAY'>广发银行</option>"
    					+"<option value='WECHATPAY'>微信</option>"
    					+"<option value='WECHATPAY_SHB'>微信扫货邦</option>"
    					+"<option value='ALIPAY_OFFLINE'>支付宝线下</option>"
    					+"<option value='ALIPAY_MOBILE'>支付宝WAP </option>"
    					+"<option value='WECHATPAY_MOBILE'>微信WAP</option>"; */
	var payServiceOption0="<option value='0'>全部</option>"
						+"<option value='1'>网银直连</option>"
						+"<option value='2'>第三方渠道</option>"
						+"<option value='3'>银行直连</option>"
						+"<option value='4'>IC卡</option>";
	var payServiceOption1="<option value=''>全部</option>"
						+"<option value='3'>手机卡支付</option>"
						+"<option value='4'>游戏卡支付</option>";
	var payServiceOption2="<option value='5'>移动支付</option>";
	
	var terminalValue;
	var typeValue;
	$("#finalPayTerminal_input").on("change",function(){
		$("#payType_input").html("");
		$("#payService_input").html("");
		$("#payBank_input").html("");
		terminalValue=$("#finalPayTerminal_input").val();
		if(terminalValue=="01"){
			$("#payType_input").html(payChannelOption);
		}else if(terminalValue=="02"){
			$("#payType_input").html(payChannelOption);
		}else if(terminalValue=="03"){
			$("#payType_input").html(payChannelOption);
		}else if(terminalValue=="04"){
			$("#payType_input").html(payChannelOption);
		}
	});
	//支付渠道改变选择时，动态改变支付服务的下拉列表
	$("#payType_input").on("change",function(){
		typeValue=$(this).val();
		$("#payService_input").html("");
		$("#payBank_input").html("");
		if(typeValue==""){
			return;
		}
		if(terminalValue=="01"){
			$("#payService_input").html(payServiceOption0);
		}else if(terminalValue=="02"){
			$("#payService_input").html(payServiceOption2);
		}else if(terminalValue=="03"){
			$("#payService_input").html(payServiceOption0);
		}else if(terminalValue=="04"){
			$("#payService_input").html(payServiceOption0);
		}
	});
	//支付服务改变时，动态改变支付方式的下拉列表
	$("#payService_input").on("change",function(){
		$("#payBank_input").html("");
		payService=$(this).val();
		findPayBank(payService);
	});
}
//查询充值方式
	function findPayBank(payService){
		var url=__ctxPath+"/wfjpay/business/selectBankList";
		var param={
				payService:payService
		};
		$.post(url,param,function(data){
			if(data.success=="true"){
				var html="<option value='0'>全部</option>";
				var arr=data.list;
				for(var i=0;i<arr.length;i++){
					html+="<option value='"+arr[i].name+"'>"+arr[i].value+"</option>";
				}
				$("#payBank_input").html(html);
			}
			
		},"json");
	}
	
//关闭导出Excel面板
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
                                <h5 class="widget-caption">按渠道查询</h5>
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
                                					<label class="titname">所属业务接口：</label>
                                    				<select id="bpId_input" style="padding:0 0;">
			                                		</select>
                            				</li>
                                			<li class="col-md-4">
                               					<label class="titname">订单终端类型：</label>
                               					<select id="finalPayTerminal_input" style="padding:0 0;">
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
	                               				</select>
                               				</li>
                               				<li class="col-md-4">
                           					<label class="titname">支付服务：</label>
	                           					<select id="payService_input" style="padding:0 0;">
			                                	</select>
		                                	</li>
		                                	<li class="col-md-4">
                           					<label class="titname">支付方式：</label>
	                           					<select id="payBank_input" style="padding:0 0;">
			                                	</select>
		                                	</li>
                            				<li class="col-md-4">
                            					<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
                            					<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;
												<a class="btn btn-yellow" onclick="excelChannel();">导出Excel</a>
											</li>
                                		</ul>
                                	<!--隐藏参数-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
										<input type="hidden" id="bpId_form" name="bpId"/>
										<input type="hidden" id="payType_form" name="payType"/>
										<input type="hidden" id="startTime_form" name="startTime"/>
										<input type="hidden" id="endTime_form" name="endTime"/>
										<input type="hidden" id="finalPayTerminal_form" name="finalPayTerminal"/>
										<input type="hidden" id="payBank_form" name="payBank"/>
										<input type="hidden" id="payService_form" name="payService"/>
                                  	</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%; min-height:400px; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 150%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="3%" style="text-align: center;">订单终端</th>
                                            <th width="2%" style="text-align: center;">创建时间</th>
                                            <th width="2%" style="text-align: center;">业务接口</th>
                                            <th width="3%" style="text-align: center;">支付渠道</th>
                                            <th width="3%" style="text-align: center;">支付服务</th>
                                            <th width="3%" style="text-align: center;">支付方式</th>
                                            <th width="2%" style="text-align: center;">支付金额(元)</th>
                                            <th width="2%" style="text-align: center;">应付金额(元)</th>
                                            <th width="2%" style="text-align: center;">实际收入(元)</th>
                                            <th width="2%" style="text-align: center;">费率</th>
                                            <th width="2%" style="text-align: center;">手续费支出(元)</th>
                                            <th width="2%" style="text-align: center;display:none;">议价收入(元)</th>
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
										<tr class="gradeX" id="gradeX{$T.Result.orderTradeNo}" onclick="" style="height:35px;">
											<!--订单终端-->	
											<td align="center" id="finalPayTerminalName_{$T.Result.bpOrderId}">
												{#if $T.Result.finalPayTerminalName != '[object Object]'}{$T.Result.finalPayTerminalName}
				                   				{#/if}
											</td>
											<!--时间-->	
											<td align="center" id="createDate_{$T.Result.bpOrderId}">
												{#if $T.Result.createDate != '[object Object]'}{$T.Result.createDate}
				                   				{#/if}
											</td>
											<!--接口名称-->	
											<td align="center" id="bpName_{$T.Result.bpOrderId}">
												{#if $T.Result.bpName != '[object Object]'}{$T.Result.bpName}
				                   				{#/if}
											</td>
											<!--支付渠道-->
											<td align="center" id="outOrderNo_{$T.Result.payType}">
												{#if $T.Result.payType != '[object Object]'}{$T.Result.payType}
				                   				{#/if}
											</td>
											<!--支付服务-->
											<td align="center" id="accountNo_{$T.Result.payService}">
												{#if $T.Result.payService!= '[object Object]'}{$T.Result.payService}
				                   				{#/if}
											</td>
											<!--充值方式-->
											<td align="center" id="memberNo_{$T.Result.payBank}">
												{#if $T.Result.payBank!= '[object Object]'}{$T.Result.payBank}
				                   				{#/if}
											</td>
											<!--应付金额-->
											<td align="center" id="orderStatusDesc_{$T.Result.price}">
											{#if $T.Result.price!= '[object Object]'}{$T.Result.price}
											{#/if}
											</td>
											<!--支付金额(元)-->
											<td align="center" id="memberType_{$T.Result.needPayPrice}">
												{#if $T.Result.needPayPrice != '[object Object]'}{$T.Result.needPayPrice}
				                   				{#/if}
											</td>
											<!--实际收入-->
											<td align="center" id="paymentNo_{$T.Result.realIncome}">
												{#if $T.Result.realIncome!= '[object Object]'}{$T.Result.realIncome}
				                   				{#/if}
											</td>
											<!--费率(元)-->
											<td align="center" id="salesPaymentNo_{$T.Result.rate}">
												{#if $T.Result.rate != '[object Object]'}{$T.Result.rate}
				                   				{#/if}
											</td>
											<!--手续费支出(元)-->
											<td align="center" id="orderSource_{$T.Result.channelCost}">
												{#if $T.Result.channelCost != '[object Object]'}{$T.Result.channelCost}
				                   				{#/if}
											</td>
											<!--议价收入(元)-->
											<td align="center" id="orderType_{$T.Result.bargainIncome}" style="display:none">
												{#if $T.Result.bargainIncome != '[object Object]'}{$T.Result.bargainIncome}
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