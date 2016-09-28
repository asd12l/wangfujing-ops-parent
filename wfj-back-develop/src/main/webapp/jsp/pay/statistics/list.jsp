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
<script src="${pageContext.request.contextPath}/assets/js/charts/chartjs/Chartq.js"></script>
<script type="text/javascript"src="http://10.6.2.152:8081/log-analytics/wfj-log.js"></script>
<style type="text/css">
.trClick>td, .trClick>th {
	color: red;
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
	var params;
	var tuTime=[];
	var noOrder=[];
	var selectValue;
	var tubiaoselect;
	//var format=new RegExp("^(((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})-(0?[13578]|1[02])-(0?[1-9]|[12]\\d|3[01]))|((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})-(0?[13456789]|1[012])-(0?[1-9]|[12]\\d|30))|((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})-0?2-(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((04|08|12|16|[2468][048]|[3579][26])00))-0?2-29)) (20|21|22|23|[0-1]?\\d):[0-5]?\\d:[0-5]?\\d$");
	var format=/^[\s]*[\d]{4}(\/|-)(0?[1-9]|1[012])(\/|-)(0?[1-9]|[12][0-9]|30|31)[\s]*(0?[0-9]|1[0-9]|2[0-3])(:([0-5][0-9])){2}[\s]*$/;
	//初始化参数
	var labelPagination;
	//初始时间选择器
	function timePickInit(){
		var endTime=new Date();
		var startTime=new Date();
		startTime.setDate(endTime.getDate()-30);
		$('#timeStart_input').daterangepicker({
			startDate:startTime,
//			endDate:endTime,
			timePicker:true,
			timePickerSeconds:true,
			timePicker24Hour:true,
//			minDate:startTime,
			maxDate:endTime,
//			linkedCalendars:false,
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
//			endDate:endTime,
			timePicker:true,
			timePickerSeconds:true,
			timePicker24Hour:true,
//			minDate:startTime,
			maxDate:endTime,
//			linkedCalendars:false,
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
		timePickInit();
		initOlv();
		selectBusissStion()
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
	function parseTime(strTime){
		if(format.test(strTime)){
			var ymdArr=strTime.split(" ")[0].split("-");//年月日
			var hmsArr=strTime.split(" ")[1].split(":");//时分秒
			return new Date(ymdArr[0],ymdArr[1]-1,ymdArr[2],hmsArr[0],hmsArr[1],hmsArr[2]).getTime();
		}
	}

	//解析时间
	/* function parseTime(str,separator,type){
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
	 */
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
	function excelChannel() {
		sendParameter();
		LA.log('statistics-excel', '统计查询结果导出Excel', userName, sessionId);
		var url=__ctxPath+"/wfjpay/statistics/checkStatisticsExport";
//		var remoteUrl="http://10.6.2.150/wfjpay/admin/statistics_type/export.do?";
		var remoteUrl=__ctxPath+"/wfjpay/statistics/getStatisticsToExcel?";
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
//				$("#downloadLink").attr("href",downloadUrl);
//				$("#excelDiv").show();
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
		
		
		
		/* setFormData();
		params = $("#olv_form").serialize();
		var url = __ctxPath + "/wfjpay/statistic/statisticsExport";
		var remoteUrl = "http://10.6.2.150/wfjpay/admin/statistics/export.do?";
		var params = params;
		params = decodeURI(params);
		var downloadUrl = remoteUrl + params;
		$
				.post(
						url,
						params,
						function(data) {
							if ($("#olv_tab tbody tr").size() == 0) {
								$("#model-body-warning")
										.html(
												"<div class='alert alert-warning fade in'><strong>查询结果为空，无法导出Excel!</strong></div>");
								$("#modal-warning")
										.attr(
												{
													"style" : "display:block;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-warning"
												});
								return;
							}
							if (data.success) {
								$("#downloadLink").attr("href", downloadUrl);
								$("#excelDiv").show();
							} else {
								$("#model-body-warning")
										.html(
												"<div class='alert alert-warning fade in'><strong>参数检查失败，无法正常导出Excel!</strong></div>");
								$("#modal-warning")
										.attr(
												{
													"style" : "display:block;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-warning"
												});
							}
						}, "json");
 */
 }
	//设置表单
	function setFormData() {
		$("#bpId_form").val($("#bpId_input").val());
		$("#finalPayTerminal_form").val($("#finalPayTerminal_input").val());
		$("#groupTime_form").val($("#groupTime_input").val());
		$("#startList_form").val($("#startList_input").val());
		var strStartTime = $("#timeStart_input").val();
		var strEndTime = $("#timeEnd_input").val();
		$("#startTime_form").val(parseTime1(strStartTime));
		$("#endTime_form").val(parseTime1(strEndTime));
	}
	
	function init(){
		//请求地址
		var url = __ctxPath + "/wfjpay/statistic/staticsSelect";
		//分页工具
		olvPagination = $("#olvPagination")
				.myPagination(
						{
							panel : {
								//启用跳页
								tipInfo_on : true,
								//跳页信息
								tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
								//跳页样式
								tipInfo_css : {
									width : '25px',
									height : "20px",
									border : "2px solid #f0f0f0",
									padding : "0 0 0 5px",
									margin : "0 5px 0 5px",
									color : "#48b9ef"
								}
							},
							debug : false,
							//ajax请求
							ajax : {
								on : true,
								url : url,
								//数据类型
								dataType : 'json',
								param : params,
								//请求开始函数
								ajaxStart : function() {
									ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
								},
								//请求结束函数
								ajaxStop : function() {
									//隐藏加载提示
									setTimeout(function() {
										ZENG.msgbox.hide();
									}, 300);
								},
								//回调
								callback : function(data) {
									
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
							}
							
				});
	}
     //加载业务平台id
     function selectBusissStion(){
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
	//查询数据
	function olvQuery() {
		sendParameter();
		LA.log('statistics-query', '统计查询', userName, sessionId);
			  
			   // alert(selectValue);
			
			/* alert($(this).children('option:selected').val()) */
			   //alert(tubiaoselect);
		
		
		initOlv();
	} 
	//重置
	/* function reset(){
	 $("#bpId_input").val("");
	 $("#payType_input").val("");
	 $("#finalPayTerminal_input").val("");
	 $("#payType_input").html("");
	 $("#payService_input").html("");
	 $('#timeSelect_input').val(formateDate2(startTime)+" - "+formateDate2(endTime));
	 $("#payBank_input option:eq(0)").attr('selected','selected');
	 olvQuery();
	 } */
	//查询函数
	function initOlv() {
		//请求地址
		var url = __ctxPath + "/wfjpay/statistic/staticsSelect";
		var  selectText=$("#startList_input").find("option:selected").text();
		   tubiaoselect= $("#thId_p").html(selectText);
		//设置表单数据
		setFormData();
		//生成表单请求参数
		params = $("#olv_form").serialize();
		params = decodeURI(params);
		//分页工具
		olvPagination = $("#olvPagination")
				.myPagination(
						{
							panel : {
								//启用跳页
								tipInfo_on : true,
								//跳页信息
								tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
								//跳页样式
								tipInfo_css : {
									width : '25px',
									height : "20px",
									border : "2px solid #f0f0f0",
									padding : "0 0 0 5px",
									margin : "0 5px 0 5px",
									color : "#48b9ef"
								}
							},
							debug : false,
							//ajax请求
							ajax : {
								on : true,
								url : url,
								//数据类型
								dataType : 'json',
								param : params,
								//请求开始函数
								ajaxStart : function() {
									ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
								},
								//请求结束函数
								ajaxStop : function() {
									//隐藏加载提示
									setTimeout(function() {
										ZENG.msgbox.hide();
									}, 300);
								},
								//回调
								callback : function(data) {
									 tuTime=[];
									 noOrder=[];
									for ( var i in data.list) {
										 data.list[i].createDate=formatDate(data.list[i].createDate);
										
										 tuTime[i]=data.list[i].time;
										 noOrder[i]=parseFloat(data.list[i].data);
																		
									}
									 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data); 
									 
									
									var data = {
										    labels: tuTime,
										    datasets: [									       
										        {//曲线
										            fillColor: "rgba(151,187,205,0.5)",
										            strokeColor: "rgba(151,187,205,1)",
										            pointColor: "rgba(151,187,205,1)",
										            pointStrokeColor: "#fff",
										            data: noOrder
										        }
										    ]
										}
										var options = {//图表参数

										    //Boolean - If we show the scale above the chart data
										    scaleOverlay : false,

										    //是否使用自定义格式
										    scaleOverride : false,

										    //** 当scaleOverride为true时必须要写下面三个值并且只有为true时下面三个值可用，默认都为NULL **
										    //图表纵轴行数
										    scaleSteps : 5,
										    //图表纵轴单位长度
										    scaleStepWidth : 30,
										    //图表纵轴最小值
										    scaleStartValue : 0,

										    //坐标轴颜色
										    scaleLineColor : "rgba(0,0,0,.1)",

										    //坐标轴宽度
										    scaleLineWidth : 1,

										    //是否显示纵轴数值标记
										    scaleShowLabels : true,

										    //Interpolated JS string - can access value
										    //scaleLabel :'',

										    //坐标轴字体
										    scaleFontFamily : "'Arial'",

										    //坐标轴文字大小，单位为像素
										    scaleFontSize : 12,

										    //坐标轴字体的粗细,可能的值为normal、bold、bolder、lighter或100-900
										    scaleFontStyle : "normal",

										    //坐标轴文字颜色
										    scaleFontColor : "#666",

										    //是否显示网格线
										    scaleShowGridLines : false,

										    //网格线颜色
										    scaleGridLineColor : "rgba(0,0,0,.05)",

										    //网格线宽度
										    scaleGridLineWidth : 1,

										    //连接线是否为曲线
										    bezierCurve : true,

										    //是否在线上显示点
										    pointDot : true,

										    //点半径，单位像素
										    pointDotRadius : 3,

										    //点外的环半径，单位像素
										    pointDotStrokeWidth : 1,

										    //Boolean - Whether to show a stroke for datasets
										    datasetStroke : true,

										    //线宽，单位像素
										    datasetStrokeWidth : 2,

										    //是否填充颜色
										    datasetFill : true,

										    //是否显示动画
										    animation : true,

										    //动画分多少步完成
										    animationSteps : 60,

										    //动画过度效果，具体值看Chart.js第494行
										    animationEasing : "easeOutQuart",

										    //动画进行中
										    //onAnimationProgress: function(){},

										    //动画结束后
										    //onAnimationComplete : null//function(){}
										};
									         
									//document.getElementById("myChart").destroy();
										//Get the context of the canvas element we want to select
										 $('#myChart').remove(); // this is my <canvas> element
                                         $('#chartDiv').append('<canvas id="myChart" width="1000" height=" 600"></canvas>');
										var ctx = document.getElementById("myChart").getContext("2d");
										var chartObj=new Chart(ctx).Line(data,options);								
									//alert("进入该方法");
									  // alert(noOrder);
									    var check_value;
									    var checks = document.getElementsByName("table_ch");
									    n = 0;
									for(i=0;i<checks.length;i++){
										if(checks[i].checked)
											n++;
									}
									//alert("选中项目数为："+n);
									if(n==0){
										alert("至少选中一项");
										 $("#myChart").hide();
										 $("#olv_tab").hide();
										 $("#olvPagination").hide();
									}
									else if(n==1){														
											 $("input[name='table_ch']:checked").each(function() {
													if ("checked" == $(this).attr("checked")) {
														check_value = $(this).attr("value");
														//alert(check_value+n);
														if (check_value == "1") {
															 $("#olv_tab").show();
															  $("#olvPagination").show();
															  $("#myChart").hide();
														}else if(check_value=="0"){
															 $("#olv_tab").hide();
															    $("#myChart").show();
															    $("#olvPagination").hide();
														
															}
													}
											 });
									}else if(n==2){
										$("input[name='table_ch']:checked").each(function() {
											if ("checked" == $(this).attr("checked")) { 
												check_value = $(this).attr("value");
												 $("#olv_tab").show();
												 $("#olvPagination").show();
												   $("#myChart").show();
									        }
										});
									}
										
	            		 }
								
					}
							
			});
	 }
	 
	
	
	//关闭导出Excel面板
	function closeExcelDiv() {
		$("#excelDiv").hide();
	}

	//折叠页面
	function tab(data) {
		if ($("#" + data + "-i").attr("class") == "fa fa-minus") {
			$("#" + data + "-i").attr("class", "fa fa-plus");
			$("#" + data).css({
				"display" : "none"
			});
		} else if (data == 'pro') {
			$("#" + data + "-i").attr("class", "fa fa-minus");
			$("#" + data).css({
				"display" : "block"
			});
		} else {
			$("#" + data + "-i").attr("class", "fa fa-minus");
			$("#" + data).css({
				"display" : "block"
			});
			$("#" + data).parent().siblings().find(".widget-body").css({
				"display" : "none"
			});
			$("#" + data).parent().siblings().find(".fa-minus").attr("class",
					"fa fa-plus");
		}
	}

/* 	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(__ctxPath + "/jsp/OrderListView.jsp");
	} */
	
	
	
	/* function showMsg(obj) {
	    selectValue = obj.options[obj.selectedIndex].text;
	    alert(selectValue);
	    $("#thId_p").html(selectValue);
	    tubiaoselect= $("#thId_p").html();
	    alert(tubiaoselect);
	    
	    
	} */
</script>  

<script type="text/javascript">
//曲线图

</script>


</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<!-- Main container -->
	<div class="main-container container-fluid">
		<!-- 内容显示区域 -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header ">
								<h5 class="widget-caption">统计查询</h5>
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
		                						<label class="titname">订单开始时间：</label>
			                    				<input type="text" id="timeStart_input" />
			                   				</li>
			                   				<li class="col-md-4">
			                    				<label class="titname">订单结束时间：</label>
			                    				<input type="text" id="timeEnd_input" />
			                				</li>
										<li class="col-md-4"><label class="titname">所属业务接口：</label>
											<select id="bpId_input" style="padding: 0 0;">
												
										</select></li>
										<li class="col-md-4"><label class="titname">统计间隔：</label>
											<select id="groupTime_input" style="padding: 0 0;">
												<option value="2">按日</option>
												<option value="1">按月</option>
												<option value="0">按季度</option>
										</select></li>
										<li class="col-md-4"><label class="titname">订单终端类型：</label>
											<select id="finalPayTerminal_input" style="padding: 0 0;">
												<option value="">全部</option>
												<option value="01">PC端</option>
												<option value="02">移动端</option>
												<option value="03">PAD端</option>
												<option value="04">POS端</option>
										</select></li>
										<li class="col-md-4"><label class="titname">统计内容：</label>
											<select id="startList_input" style="padding: 0 0;">
										<!-- 	<select id="startList_input" style="padding: 0 0;"  onchange="showMsg(this)"> -->
												<option value="0">支付成功金额</option>
												<option value="1">生成订单数</option>
												<option value="2">支付成功订单数</option>
												<option value="3">支付账号数</option>
										</select></li>
										
										<li class="col-md-4">
											<div class="row">
												<div class="col-lg-4 col-sm-4 col-xs-4">
													<div class="checkbox">
														<!-- <label> <input class="colored-blue" checked
															type="checkbox" id="chart_show" name="table_ch" value="0">
															<span class="text">图表</span>
														</label> -->
														<label> <input class="colored-blue" checked
															type="checkbox" id="chart_show" name="table_ch" value="0">
															<span class="text">图表</span>
														</label>
													</div>
												</div>

												<div class="col-lg-4 col-sm-4 col-xs-4">
													<div class="checkbox">
														<label> <input class="colored-success" checked
															type="checkbox" id="table_show" name="table_ch" value="1">
															<span class="text">表格</span>
														</label>
													</div>
												</div>
											</div>

										</li>


										<li class="col-md-4">
										<a class="btn btn-default shiny" 	onclick="olvQuery();">统计</a>&nbsp;&nbsp;
										 <!-- <a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp; -->
											<a class="btn btn-yellow" onclick="excelChannel();">导出Excel</a>
										</li>
									</ul>
									<!--隐藏参数-->
									<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize"
											value="10" /> <input type="hidden" id="bpId_form"
											name="bpId" /> <input type="hidden" id="groupTime_form"
											name="groupTime" /> <input type="hidden" id="startList_form"
											name="statList" /> <input type="hidden" id="startTime_form"
											name="startTime" /> <input type="hidden" id="endTime_form"
											name="endTime" /> <input type="hidden"
											id="finalPayTerminal_form" name="initOrderTerminal" />
									</form>
									<!--数据列表显示区域-->
									<div style="width: 100%; height: 0%; overflow-Y: hidden;">
									<div id="chartDiv">
                                    <canvas id="myChart" width="1000" height=" 600"></canvas>
									</div>
										<table class="table-striped table-hover table-bordered"
											id="olv_tab"
											style="width: 100%; background-color: #fff; margin-bottom: 0;">
											<thead>
												<tr role="row" style='height: 35px;'>
													<th width="33%" style="text-align: center;">时间区间</th>
													<th width="33%" style="text-align: center;">所属接口业务</th>
													<th id="thId_p" width="33%" style="text-align: center;"></th>
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
								<p style="display: none">
									<textarea id="olv-list" rows="0" cols="0">
								{#template MAIN}
									{#foreach $T.list as Result}
										<tr class="gradeX" id="gradeX{$T.Result.orderTradeNo}"
											onclick="" style="height: 35px;">
											<!--时间区间-->	
											<td align="center" id="orderNo_{$T.Result.time}">
												{$T.Result.time}
											</td>
											<!--所属业务接口-->
											<td align="center" id="outOrderNo_{$T.Result.bpName}">
												{#if $T.Result.bpName != '[object Object]'}{$T.Result.bpName}
				                   				{#/if}
											</td>
											<!--支付成功金额-->
											<td align="center" id="accountNo_{$T.Result.data}">
												{#if $T.Result.data!= '[object Object]'}{$T.Result.data}
				                   				{#/if}
											</td>
											<!--充值方式-->
											
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
		<!-- /Page container -->
		<!-- Main container -->
	</div>
	<!--下载显示区域-->
	<div class="modal modal-darkorange" id="excelDiv">
		<div class="modal-dialog"
			style="width: 450px; height: 50%; margin: 10% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeExcelDiv();">×</button>
					<h4 class="modal-title" id="dowloadTitle">下载</h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<a class="btn btn-default shiny" href="" id="downloadLink">点击下载</a>
				</div>

				<!--关闭按钮-->
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeExcelDiv();" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<script>
	

	    
	    
		//页面加载完成后执行函数
		jQuery(document).ready(function() {
			$('#divTitle').mousedown(function(event) {
				var isMove = true;
				var abs_x = event.pageX - $('#btDiv').offset().left;
				var abs_y = event.pageY - $('#btDiv').offset().top;
				$(document).mousemove(function(event) {
					if (isMove) {
						var obj = $('#btDiv');
						obj.css({
							'left' : event.pageX - abs_x,
							'top' : event.pageY - abs_y
						});
					}
				}).mouseup(function() {
					isMove = false;
				});
			});
		});
		
		
	</script>
	
</html>