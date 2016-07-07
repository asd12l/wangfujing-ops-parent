<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
	<%request.setAttribute("ctx", request.getContextPath());%>
	<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
	<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script>
	<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dateTime/datePicker.css"/>
	<!--Bootstrap Date Range Picker-->
	<script src="${ctx}/assets/js/datetime/moment.js"></script>
	<script src="${ctx}/assets/js/datetime/daterangepicker.js"></script>
	<style type="text/css">
		.trClick>td,.trClick>th{
			color:red;
		}
	</style>
	<script type="text/javascript">
		//上下文路径
		__ctxPath = "${pageContext.request.contextPath}";

		//页码
		var olvPagination;
		//var format=new RegExp("^(((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})/(0?[13578]|1[02])/(0?[1-9]|[12]\\d|3[01]))|((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})/(0?[13456789]|1[012])/(0?[1-9]|[12]\\d|30))|((01[0-9]{2}|0[2-9][0-9]{2}|[1-9][0-9]{3})/0?2/(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((04|08|12|16|[2468][048]|[3579][26])00))/0?2-29)) (20|21|22|23|[0-1]?\\d):[0-5]?\\d:[0-5]?\\d$");
		//只做了简单的日期格式效验(不能效验瑞年) 格式为  yyyy-MM-dd hh:mm:ss 年月日分隔符可以为(-和/)
		var format=/^[\s]*[\d]{4}(\/|-)(0?[1-9]|1[012])(\/|-)(0?[1-9]|[12][0-9]|30|31)[\s]*(0?[0-9]|1[0-9]|2[0-3])(:([0-5][0-9])){2}[\s]*$/;
		//初始时间选择器
		function timePickInit(){
			$('#time').daterangepicker({
				timePicker: true,
				timePicker12Hour:false,
				timePickerIncrement: 30,
				format: 'YYYY/MM/DD HH:mm:ss',
				locale : {
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

		//设置表单数据
		function setFormData(){
			var strTime = $("#time").val();
			if(strTime!="" && strTime != null){
				strTime = strTime.split(" - ");
				$("#hidStartTime").val(strTime[0].replace("/","-").replace("/","-"));
				$("#hidEndTime").val(strTime[1].replace("/","-").replace("/","-"));
			}else{
				$("#hidStartTime").val("");
				$("#hidEndTime").val("");
			}
			$("#hidAccount").val($("#account").val())
			$("#hidPhone").val($("#phone").val());
			$("#hidEmail").val($("#email").val());
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
			$("#phone").val("");
			$("#account").val("");
			$("#email").val("");
			$("#time").val("");
			timePickInit();
			olvQuery();
		}
		//初始化函数
		function initOlv() {
			//请求地址
			var url = __ctxPath+"/balanceRecord/get";
			//var url = __ctxPath+"/memDrawback/getWithdrawlsList";
			/* setFormData(); */


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
					type: "post",
					//数据类型
					dataType: 'json',
					// param:$("#olv_form").serialize(),
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

		function successBtn(){
			$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
			$("#pageBody").load(__ctxPath+"/jsp/mem/balanceApply.jsp");
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
							<h5 class="widget-caption">优惠券记录</h5>
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
										<label class="titname">账号：</label>
										<input type="text" id="account" />
									</li>
									<li class="col-md-4">
										<label class="titname">手机号：</label>
										<input type="text" id="phone" />
									</li>
									<li class="col-md-4">
										<label class="titname">邮箱：</label>
										<input type="text" id="email" />
									</li>
									<li class="col-md-4">
										<label class="titname">积分变动时间：</label>
										<input type="text" id="time"/>
									</li>
									<li class="col-md-4">
										<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;
										<%--<a class="btn btn-yellow" onclick="excelOrder();">导出</a>--%>
									</li>
								</ul>
								<!--隐藏参数-->
								<form id="olv_form" action="">
									<input type="hidden" id="groupId" name="groupId" value="02"/>
									<input type="hidden" id="hidAccount" name="hidAccount"/>
									<input type="hidden" id="hidPhone" name="hidPhone"/>
									<input type="hidden" id="hidEmail" name="hidEmail"/>
									<input type="hidden" id="hidStartTime" name="hidStartTime"/>
									<input type="hidden" id="hidEndTime" name="hidEndTime"/>
								</form>
								<!--数据列表显示区域-->
								<div style="width:100%; min-height:400px; overflow-Y: hidden;">
									<table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
										<thead>
										<tr role="row" style='height:35px;'>
											<th width="2%" style="text-align: center;">时间</th>
											<th width="2%" style="text-align: center;">账号</th>
											<th width="2%" style="text-align: center;">昵称</th>
											<th width="2%" style="text-align: center;">真实姓名</th>
											<th width="2%" style="text-align: center;">手机</th>
											<th width="2%" style="text-align: center;">邮箱</th>
											<th width="2%" style="text-align: center;">会员等级</th>
											<th width="2%" style="text-align: center;">收入/支出</th>
											<th width="2%" style="text-align: center;">操作描述</th>
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
									{#foreach $T.object.data as Result}
										<tr class="gradeX" id="gradeX{$T.Result.sid}" ondblclick="trClick('{$T.Result.orderTradeNo}',this)" style="height:35px;">
											<td align="center">
												{#if $T.Result.logdate != '[object Object]'}{$T.Result.logdate}
												{#/if}
											</td>
											<td align="center">
												{#if $T.object.account != '[object Object]'}{$T.object.account}
												{#/if}
											</td>
											<td align="center">
												{#if $T.object.nickname!= '[object Object]'}{$T.object.nickname}
												{#/if}
											</td>
											<td align="center">
												{#if $T.object.realname!= '[object Object]'}{$T.object.realname}
												{#/if}
											</td>
											<td align="center">
												{#if $T.object.phone!= '[object Object]'}{$T.object.phone}
												{#/if}
											</td>
											<td align="center">
												{#if $T.object.email != '[object Object]'}{$T.object.email}
												{#/if}
											</td>
											<td align="center">
												{#if $T.object.level != '[object Object]'}{$T.object.level}
												{#/if}
											</td>
											<td align="center">
												{#if $T.Result.amount != '[object Object]'}{$T.Result.amount}
												{#/if}
											</td>
											<td align="center">
												{#if $T.Result.memo!= '[object Object]'}{$T.Result.memo}
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

<script>

</script>
</body>
</html>