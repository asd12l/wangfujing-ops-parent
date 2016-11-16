<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script> 
<!--Bootstrap Date Range Picker-->
<script src="${pageContext.request.contextPath}/assets/js/datetime/moment.min.js"></script> 
<script src="${pageContext.request.contextPath}/assets/js/datetime/datepicker.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dateTime/datePicker.css"/>
<!-- Bootstrap multiselect -->
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap_master/dist/js/jquery-2.1.3.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/bootstrap_master/dist/css/bootstrap-3.3.2.min.css" type="text/css">      
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap_master/dist/js/bootstrap-3.3.2.min.js"></script>  --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/bootstrap_master/dist/css/bootstrap-multiselect.css" type="text/css"> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap_master/dist/js/bootstrap-multiselect.js"></script> 
<!-- end --> 
<script type="text/javascript"src="http://10.6.2.152:8081/log-analytics/wfj-log.js"></script>
<style type="text/css">
.trClick>td,.trClick>th{
 color:red;
}
 .topList li input,.topList li select{
 min-width:100px;
 } 
 
 .multiselect-selected{
  background-color:#ebebeb;
  width:170px
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
$(document).ready(function() {
	selectStart();
  });

//页面加载完成后自动执行
$(function() {
	//渲染日期
	timePickInit();
	//动态获取支付渠道
   // payChannelType();
    //获取门店编码
    neibuMerchant();
    //初始化
    initOlv();  
   // olvQuery();
});
function selectStart(){
    $('#payTypes_info').multiselect({
    	buttonWidth: '180px',
    	selectedClass: 'multiselect-selected',
    	includeSelectAllOption: true,
    	enableFiltering: true,
        nonSelectedText:'请选择平台类型',
        selectAllText:"全选/取消全选",
        filterPlaceholder:'搜索',
        allSelectedText:'已选中所有平台类型',
        nSelectedText:'项被选中',
        maxHeight:300 
    		});
   
     $('#merCodes_info').multiselect({
    	buttonWidth: '165px',
    	includeSelectAllOption: true,
    	selectedClass: 'multiselect-selected',
    	enableFiltering: true,
        nonSelectedText:'请选择门店',
        selectAllText:"全选/取消全选",
        filterPlaceholder:'搜索',
        allSelectedText:'已选中所有门店',
        nSelectedText:'项被选中',
        maxHeight:300
    });    
}
function parseTime1(strTime){
	if(format.test(strTime)){
		var ymdArr=strTime.split(" ")[0].split("/");//年月日
		var hmsArr=strTime.split(" ")[1].split(":");//时分秒
		return new Date(ymdArr[0],ymdArr[1]-1,ymdArr[2],hmsArr[0],hmsArr[1],hmsArr[2]).getTime();
	}
	return "";
}
//解析时间
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
	var hour=date.getHours();
	var minute=date.getMinutes();
	var second=date.getSeconds();
	return year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second; 
}
//导出excel
function excelBalance() {
	sendParameter();
	LA.log('accountDetails-excel', '对账明细导出Excel', userName, sessionId);
	var url=__ctxPath+"/wfjpay/selectpayMentDate";
	var remoteUrl=__ctxPath+"/wfjpay/getPayMentDateToExcel?";
	var params = $("#olv_form").serialize();
  params = decodeURI(params);
  
//根据参数读取数据
  var errorMsg=validate();
	if(errorMsg!=""){
		showWarning(errorMsg);
		return;
	}
  
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
	$("#payTypes_form").val($("#payTypes_info").val());
	$("#merCodes_form").val($("#merCodes_info").val());
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
    var errorMsg=validate();
	if(errorMsg!=""){
		showWarning(errorMsg);
		return;
	}
    olvPagination.onLoad(params);
}
function validate(){
	var payType = $("#payTypes_info").val();
	var merCode = $("#merCodes_info").val();
	if(payType == null || merCode == null){
		return "支付渠道或门店信息不能为空！";
	}
	return "";
}
//警告窗口
function showWarning(msg){
	$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+msg+"</strong></div>");
	$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
}
//重置
function reset(){
	sendParameter();
	LA.log('accountDetails-reset', '对账明细查询条件重置', userName, sessionId);
	$("#payTypes_info").multiselect().val([]).multiselect("refresh");
	$("#merCodes_info").multiselect().val([]).multiselect("refresh");
	timePickInit();
}

var payChannelOption ="";
//动态获取支付渠道类型
function payChannelType(){
		var url=__ctxPath+"/wfjpay/selectChannelType";
		$.ajax({
			url:url,
			type:"post",
			dataType:"json",
			success:function(data){
				if(data.success=="true"){
						$.each(data.list, function(index, html) {
							if(html.name == "WECHATPAY_OFFLINE"){
								$("#payTypes_info").append( $('<option selected="selected"></option>').text(html.value).val(html.name));
							}else{
								 $("#payTypes_info").append( $('<option></option>').text(html.value).val(html.name));
							}
						 
						  
					      });
					    $("#payTypes_info").multiselect('rebuild');
				}
			},
			error:function(){
				alert("获取支付渠道类型失败！");
			}
		});
	}
//门店信息
function  neibuMerchant(){
  		$.ajax({
	        type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/wfjpay/selectMerCode",
	        dataType: "json",
	        success:function(response) {
	        	if(response.success == 'true'){
	  				$.each(response.list, function(index, html) {
					$("#merCodes_info").append( $('<option selected="selected"></option>').text(html.name).val(html.merCode));
				      });
	  				$("#merCodes_info").multiselect('rebuild');
				}else{
					alert("请求失败");
				}
        	}
		});
  	 }
//初始化函数
	function initOlv() {
	//请求地址
	var url = __ctxPath+"/wfjpay/selectpayMentDate";
	
	setFormData();
	//生成表单请求参数
    var params = $("#olv_form").serialize();
    params = decodeURI(params);
	//分页工具
	olvPagination = $("#olvPagination").myPagination({
       //ajax请求
       ajax: {
         on: true,
         url: url,
         //数据类型
         dataType: 'json',
         param:params,
         //回调
         callback: function(data) {
        	 userName = data.userName ;
    		 logJs = data.logJs;
    		 reloadjs();
        	 sendParameter();
        	 LA.log('accountDetails-query', '对账明细查询', userName, sessionId);
			if(data.success=="true"){
				/* var couponTotalFee = 0;
				var payToalCount = 0;
				var payTotalFee = 0;
				var refundTotalCount = 0;
				var refundTotalFee = 0;
				var arr = data.list;
				for(var i = 0 ;i<arr.length;i++){
					couponTotalFee += arr[i].couponTotalFee;
					payToalCount += arr[i].payToalCount;
					payTotalFee += arr[i].payTotalFee;
					refundTotalCount += arr[i].refundTotalCount;
					refundTotalFee += arr[i].refundTotalFee;
				} */
				
	
		   		$("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
				$("#trShows").css({"display":""}); 
		   		var arr = data.countList;
				$("#payTotalFee_count").html(arr[0]+"万元");
				$("#payToal_count").html(arr[1]+"笔");
				$("#refundTotalFee_count").html(arr[2]+"万元");
				$("#refundTotal_count").html(arr[3]+"笔");
				$("#couponTotalFee_count").html(arr[4]+"元");
			}else{
				$("#olv_tab tbody").setTemplateElement("olv-list").processTemplate("");
				$("#page_form").val(1);
			}
         }
       }
     });
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
                                <h5 class="widget-caption">支付数据统计</h5>
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
		                						<label class="titname">统计开始时间：</label>
			                    				<input type="text" id="timeStart_input" />
			                   				</li>
			                   				<li class="col-md-4">
			                    				<label class="titname">统计结束时间：</label>
			                    				<input type="text" id="timeEnd_input" />
			                				</li>
                                			
                               				<li class="col-md-4">
                               					<label class="titname">支付渠道：</label>
                               					    <select id="payTypes_info"  multiple="multiple">
                               					      <option value="WECHATPAY_OFFLINE"  selected="selected">微信线下支付</option>
                               					      <option value="ALIPAY_OFFLINE">支付宝线下支付</option>
	                               				    </select> 
                               				</li>
                               				
                               				<li class="col-md-4">
                           					<label class="titname">门店信息：</label>
	                           					 <select id="merCodes_info"  multiple="multiple">
			                                	</select> 
		                                	</li>
                            				<li class="col-md-4">
                            					<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
                            					<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;
												<a class="btn btn-yellow" onclick="excelBalance();">导出Excel</a>
											</li>
                                		</ul>
                                	<!--隐藏参数-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="startTime_form" name="startTime" />
										<input type="hidden" id="endTime_form" name="endTime"/>
										<input type="hidden" id="payTypes_form" name="payTypes" >
										<input type="hidden" id="merCodes_form" name="merCodes"/>
                                  	</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%; min-height:400px; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="2.5%" style="text-align: center;">门店编码</th>
                                            <th width="2.5%" style="text-align: center;">门店名称</th>
                                            <th width="2.5%" style="text-align: center;">支付金额(万元)</th>
                                            <th width="2.5%" style="text-align: center;">支付笔数</th>
                                            <th width="2.5%" style="text-align: center;">退款金额(万元)</th>
                                            <th width="2.5%" style="text-align: center;">退款笔数</th>
                                            <th width="2.5%" style="text-align: center;">活动金额(元,正向)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                                </div>

                               <!--  <div style="width:100%;height:50px;margin-top:5px;padding-left:50px;">
                        			 <table style="width:100%;height:40px;text-align:left;">
                        				<tr>
                        				    <td style="width:15px;color:red;">【总计】</td>
                        					<td style="width:30px;">支付金额:</td>
                        					<td style="width:30px;"><span id="payTotalFee_count"></span></td>
                        					<td style="width:30px;">支付笔数:</td>
	                    					<td style="width:30px;"><span id="payToal_count"></span></td>
	                    					<td style="width:30px;">退款金额:</td>
	                    					<td style="width:30px;"><span id="refundTotalFee_count"></span></td>
	                    					<td style="width:30px;">退款笔数:</td>
	                    					<td style="width:30px;"><span id="refundTotal_count"></span></td>
	                    					<td style="width:30px;">活动金额:</td>
	                    					<td style="width:30px;"><span id="couponTotalFee_count"></span></td>
                        				<tr>
                        			</table>  

                       			</div> -->
                                
                                <!--分页工具-->
                               <!--  <div id="olvPagination" ></div> -->
                            </div>
                            <!--模板数据-->
							<!-- Templates -->
							<!--默认隐藏-->
							<p style="display:none">
								<textarea id="olv-list" rows="0" cols="0">
								{#template MAIN}
									{#foreach $T.list as Result}
										<tr class="gradeX" id="gradeX{$T.Result.orderTradeNo}" onclick="" style="height:35px;">
											<!--门店编号-->	
											<td align="center" id="bpOrderId_{$T.Result.storeNo}">
												{#if $T.Result.storeNo != '[object Object]'}{$T.Result.storeNo}
				                   				{#/if}
											</td>
											<!--门店名称-->
											<td align="center" id="outOrderNo_{$T.Result.storeName}">
												{#if $T.Result.storeName != '[object Object]'}{$T.Result.storeName}
				                   				{#/if}
											</td>
											<!--支付金额-->
											<td align="center" id="accountNo_{$T.Result.payTotalFee}">
												{#if $T.Result.payTotalFee!= '[object Object]'}{$T.Result.payTotalFee}
				                   				{#/if}
											</td>
											<!--支付笔数-->
											<td align="center" id="memberNo_{$T.Result.payToalCount}">
												{#if $T.Result.payToalCount!= '[object Object]'}{$T.Result.payToalCount}
				                   				{#/if}
											</td>
											<!--退款金额-->
											<td align="center" id="orderStatusDesc_{$T.Result.content}">
											    {#if $T.Result.refundTotalFee!= '[object Object]'}{$T.Result.refundTotalFee}
											    {#/if}
											</td>
											<!-- 退款笔数 -->
											<td align="center" id="userName_{$T.Result.refundTotalCount}">
												{#if $T.Result.refundTotalCount != '[object Object]'}{$T.Result.refundTotalCount}
				                   				{#/if}
			                   				</td>
											<!--活动金额-->
											<td align="center" id="memberType_{$T.Result.couponTotalFee}" >
												{#if $T.Result.couponTotalFee != '[object Object]'}{$T.Result.couponTotalFee}
				                   				{#/if}
											</td>
											
							       		</tr>
									{#/for}
									
									<tr class="gradeX" id="trShows" style="height:35px;display:none;" >
											<!--门店编号-->	
											<td align="center" id="">
												<b>总计</b>
											</td>
											<!--门店名称-->
											<td align="center" id="">
											</td>
											<!--支付金额-->
											<td align="center">
											    <b><span id="payTotalFee_count"></span></b>   
											</td>
											<!--支付笔数-->
											<td align="center"  id="">
											   <b><span id="payToal_count"></span></b>  
											</td>
											<!--退款金额-->
											<td align="center"  id="">
											   <b><span id="refundTotalFee_count"></span></b>  
											</td>
											<!-- 退款笔数 -->
											<td align="center"  id="">
											   <b><span id="refundTotal_count"></span></b>  
			                   				</td>
											<!--活动金额-->
											<td align="center"  id="" >
											   <b><span id="couponTotalFee_count"></span></b>  
											</td>
							    	</tr>
									
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