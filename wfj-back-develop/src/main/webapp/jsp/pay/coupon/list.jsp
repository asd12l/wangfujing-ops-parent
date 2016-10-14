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
<!--ztree-->
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/js/jquery.ztree.excheck-3.5.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ztree/css/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="http://10.6.2.152:8081/log-analytics/wfj-log.js"></script>
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
         LA.sysCode = '48';
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
	//	maxDate:endTime,
//		linkedCalendars:false,
		opens:'center',
		showDropdowns : true,
		locale : {
		  	format: "YYYY-MM-DD HH:mm:ss",
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
	//	maxDate:endTime,
//		linkedCalendars:false,
		opens:'center',
		showDropdowns : true,
		locale : {
		  	format: "YYYY-MM-DD HH:mm:ss",
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
		var ymdArr=strTime.split(" ")[0].split("-");//年月日
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
	$("#bpOrderId_form").val($("#bpOrderId_input").val())
	$("#uid_form").val($("#uid_input").val());
	$("#userName_form").val($("#userName_input").val());
	$("#orderTradeNo_form").val($("#orderTradeNo_input").val());
	$("#bpId_form").val($("#bpId_input").val());
	$("#payType_form").val($("#payType_input").val());
	$("#status_form").val($("#status_input").val());
	$("#initOrderTerminal_form").val($("#initOrderTerminal_input").val());
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
//初始化函数
	function initOlv() {
	//请求地址
	var url=__ctxPath+"/wfjpay/coupon/findAllList";
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
     		 LA.log('couponDeploy-query', '有赞券活动配置查询', userName, sessionId);
     		 
    		 for(var i in data.list){
    			 data.list[i ].beginTime=formatDate(data.list[i].beginTime);
    			 data.list[i ].endTime=formatDate(data.list[i].endTime);
    			 data.list[i ].updateTime=formatDate(data.list[i].updateTime);
    		 }
    		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
         }
       }
     });  
}
//关闭修改面板
function closeSuccessEditDiv(){
	successBtn();
	closeEditDiv();
}
//关闭设置活动门店信息面板
function closeSuccessActivityDiv(){
	successBtn();
	$("#setOutletEncodeDiv").hide();
	//initOlv();
}
function closeBtDiv(){
	$("#btDiv").hide();
}
//关闭修改面板
function closeEditDiv(){
	$("#editDiv").hide();
	//initOlv();
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
	$("#pageBody").load(__ctxPath+"/jsp/pay/coupon/list.jsp");
}
function zTreeBeforeCheck(treeId, treeNode){
/* 	for(var i in oldZtree){
		if(oldZtree[i].id==treeNode.id){
			return false;
		}
	} */
	return true;
}
//时间格式转换
Date.prototype.Format = function (fmt) {  
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
//显示修改窗口
var oldInfo;
var newInfo;
function showEditDiv(id){
	$("#editDiv").show();
//	$("#editForm").data('bootstrapValidator').resetForm();
    $("#oldCodeParam_edit").val(id);
	$("#activityID_input").val($("#activityID_"+id).text().trim());
	$("#timeStart_input").val($("#activityBeginTime_"+id).text().trim());
	$("#timeEnd_input").val($("#activityEndTime_"+id).text().trim());
    oldInfo = "修改前数据活动ID:"+$("#activityID_input").val().trim()+"修改前对应的核销时间:"+
    "核销开始时间:"+$("#timeStart_input").val().trim()+
    "核销结束时间:"+$("#timeEnd_input").val().trim();       
}
function editInfo(){
	 sendParameter();
	 LA.log('couponDeploy-timeModify', '有赞券活动时间修改', userName, sessionId);
		newInfo = "修改后对应的核销时间:"+"核销开始时间:"+$("#timeStart_input").val().trim()+
	                  "核销结束时间:"+$("#timeEnd_input").val().trim();
	        var url=__ctxPath+"/wfjpay/coupon/updateActivity";
	    	setParamForm();
	    	var param=$("#data_form").serialize();
	    	savelog();
	    	$.ajax({
	    		url:url,
	    		type:"post",
	    		data:param,
	    		dataType:"json",
	    		success:function(data){
	    			if(data.success==true){
	    				$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
	    				$("#modal-success .btn-success").attr("onclick","closeSuccessEditDiv();");
	    			}else{
	    				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+data.msg+"</strong></div>");
	    				$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
	    			}	
	    		},
	    		error:function(){
	    			alert("修改数据失败！");
	    		}
	    	});
}
//设置参数表单数据
function setParamForm(){
    $("#activity_form").val($("#oldCodeParam_edit").val());
	$("#activityID_form").val($("#activityID_input").val());
	var timeStart = $("#timeStart_input").val();
	$("#activityBeginTime_form").val(parseTime1(timeStart));	
	var timeEnd = $("#timeEnd_input").val();
	$("#activityEndTime_form").val(parseTime1(timeEnd));
	var timeupdate = new Date().Format("yyyy-MM-dd hh:mm:ss");
	$("#activityUpdateTime_form").val(parseTime1(timeupdate));
}
//记录日志
function savelog(){
	url=__ctxPath + "/wfjpay/coupon/saveLogInfo";
	setLogFrom();
	$.ajax({
		url:url,
		type:"post",
	    data:$("#logInfo_form").serialize(),
		success:function(data){
			if(data.success==true){
				alert("保存操作日志成功！");
			}	
		},
		error:function(){
			alert("保存操作日志失败！");
		}
	});	
}
 //设置日志表单
function setLogFrom(){
	var logInfo = oldInfo + newInfo;
	var createTime = parseTime1(new Date().Format("yyyy-MM-dd hh:mm:ss"));
	console.log("保存日志的信息："+logInfo+createTime+userName);
	$("#content_form").val(oldInfo+">>>>>>"+newInfo);
	$("#uesrName_form").val(userName);
	$("#creatTime_form").val(createTime);
} 
//获取活动配置的门店信息
function findAllCouponList(itemId){
	$("#numberParam_set").val(itemId);
	url=__ctxPath + "/wfjpay/coupon/findAllCouponList";
	$.ajax({
		url:url,
		type:"post",
		dataType:"json",
	    data:{"itemId":itemId},
		success:function(data){
				var setting = {
						check: {
							enable: true,
							chkboxType:{ "Y" : "p", "N" : "s" }
						},
						data: {
							simpleData: {
								enable: true
							}
						},
						callback: {
							beforeCheck: zTreeBeforeCheck
						}
					};
				var zNodes=data.list;
				//日志
			    oldInfo ="修改前本活动编号"+itemId+"对应门店信息:";
				for(var i in zNodes){
					if(zNodes[i].checked==true){
						oldInfo += zNodes[i].name+","+zNodes[i].id+";";
					}
				}
				//
				oldZtree=[];
				for(var i in zNodes){
					zNodes[i].name=zNodes[i].name+" ("+zNodes[i].id+")";
				}
				for(var i in zNodes){
					if(zNodes[i].checked){
						oldZtree.push(zNodes[i]);
					}
				}
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			    $("#setOutletEncodeDiv").show();
		},
		error:function(){
			alert("获取活动配置的门店信息失败！");
		}
	});
}
function saveSetCoupon(){
	sendParameter();
	LA.log('couponDeploy-saveSetCoupon', '有赞券活动对应门店配置信息保存', userName, sessionId);
	addZtree=[];
	delZtree=[];
	newZtree=[];
	var obj=$.fn.zTree.getZTreeObj("treeDemo");
	var nodes=obj.getNodes();
	var arr=obj.transformToArray(nodes);
	for(var i=0;i<arr.length;i++){
		if(arr[i].checked){
			newZtree.push(arr[i]);
		}
	}
	//获取新增的
	var flag;
	var addInfo="";
	for(var i=0;i<newZtree.length;i++){
		flag=true;
		for(var j in oldZtree){
			if(newZtree[i].id==oldZtree[j].id){
				flag=false;
				break;
			}
		}
		if(flag){
			var obj=new Object();
			obj.id=newZtree[i].id;
			obj.pId=newZtree[i].pId;
			obj.name=newZtree[i].name;
			obj.checked=true;
			addZtree.push(obj);
		}
		addInfo += newZtree[i].name;
	}
	//获取删除的
	var delInfo = "";
	for(var i=0;i<oldZtree.length;i++){
		flag=true;
		for(var j in newZtree){
			if(oldZtree[i].id==newZtree[j].id){
				flag=false;
				break;
			}
		}
		if(flag){
			var obj=new Object();
			obj.id=oldZtree[i].id;
			obj.pId=oldZtree[i].pId;
			obj.name=oldZtree[i].name;
			obj.checked=false;
			delZtree.push(obj);
		}
		delInfo += oldZtree[i].name;
	}
	var item_id=$("#numberParam_set").val();
	newInfo = "修改后本活动编号"+item_id+"对应门店信息:增加的门店:"+addInfo+",删除的门店:"+delInfo;
	savelog();
	var bpIdDateUrl=__ctxPath+"/wfjpay/coupon/saveActivityInfo";
	var param={
			item_id:item_id,
			addZtree:JSON.stringify(addZtree),
			delZtree:JSON.stringify(delZtree)
	};
	$.post(bpIdDateUrl,param,function(data){
		if(data.success){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
			$("#modal-success .btn-success").attr("onclick","closeSuccessActivityDiv();");
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+data.msg+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
		
	},"json");
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
                                <h5 class="widget-caption">有赞券活动配置</h5>
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
                                 	<!--参数表单，修改用-->
                                <form id="data_form" action="">
                                    <input type="hidden" id="activity_form" name="activityCode"/>
                                 	<input type="hidden" id="activityID_form" name="activityID"/>
                                 	<input type="hidden" id="activityBeginTime_form" name="activityBeginTime"/>
                                 	<input type="hidden" id="activityEndTime_form" name="ctivityEndTime"/>
                                 	<input type="hidden" id="activityUpdateTime_form" name="activityUpdateTime"/>
								</form>
								<!-- log日志信息 -->
								<form id="logInfo_form" action="">
								    <input type="hidden" id="content_form" name="logInfo"/>
								    <input type="hidden" id="uesrName_form" name="userName"/>
								    <input type="hidden" id="creatTime_form" name="createTime"/>
								</form>
								<!--查询表单-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
										<input type="hidden" id="name_form" name="name"/>
                                  	</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%; min-height:400px; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                       <tr role="row" style='height:35px;'>
                                            <th width="3%" style="text-align: center;">活动ID</th>
                                            <th width="3%" style="text-align: center;">核销开始时间</th>
                                            <th width="3%" style="text-align: center;">核销结束时间</th>
                                            <th width="3%" style="text-align: center;">操作</th>
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
							<!--默认隐藏  -->
							  <p style="display:none">
								<textarea id="olv-list" rows="0" cols="0">
								 {#template MAIN}
									{#foreach $T.list as Result}
										<tr class="gradeX" id="gradeX{$T.Result.orderTradeNo}" ondblclick="trClick('{$T.Result.orderTradeNo}',this)" style="height:35px;">
											<!-- 活动ID -->
											<td align="center" id="activityID_{$T.Result.id}">
												{$T.Result.itemId}
											</td>
											<!-- 活动开始时间 -->
											<td align="center" id="activityBeginTime_{$T.Result.id}">
												{#if $T.Result.beginTime != '[object Object]'}{$T.Result.beginTime}
												{#/if}
											</td>
											<!-- 活动结束时间 -->
											<td align="center" id="activityEndTime_{$T.Result.id}">
												{#if $T.Result.endTime != '[object Object]'}{$T.Result.endTime}
												{#/if}
											</td>
											<td align="center" >
												<a class="btn btn-default purple btn-sm fa fa-edit" onclick="showEditDiv('{$T.Result.id}');">修改</a>
												<a class="btn btn-default purple btn-sm fa fa-cog" onclick="findAllCouponList('{$T.Result.itemId}')">配置活动门店</a>
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
<!--修改-->
<div class="modal modal-darkorange" id="editDiv">
	<div class="modal-dialog" style="width: 500px;height:400px;margin: 10% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">修改</span>
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="document.getElementById('editDiv').style.display='none';" style="margin-right:10px;">×</button>
			</div>
			<form>
				<input type="hidden" id="oldNameParam_edit"/>
				<input type="hidden" id="oldCodeParam_edit"/>
			</form>
			<form id="editForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
			    <div class="widget-body">
					<div class="form-group" >
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">活动ID：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="activityID_input" name="code" placeholder="必填" readonly="readonly"/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">核销开始时间：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text"  class="form-control" id="timeStart_input" />
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">核销结束时间：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="timeEnd_input" />
							</div>											
						</div>
					</div>
					
				</div>
	        
			<!--修改保存/取消-->
	        <div class="modal-footer" style="text-align:center;">
	        	<button class="btn btn-success" style="width: 100px;"  type="button" onclick="editInfo();">保存</button>&emsp;&emsp;
	        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('editDiv').style.display='none';"/>
	        	<input class="btn btn-danger" style="display:none" id="editReset" type="reset" value="取消""/>
	        </div>
	    </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>  
<!--设置门店编码-->
<div class="modal modal-darkorange" id="setOutletEncodeDiv">
	<div class="modal-dialog" style="width: 350px;height:30%;margin: 5% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">配置活动门店</span>
				<div class="widget-buttons">
					<a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square-o" id="open1" style="font-size:20px;"></i>
	            	</a>
	            	<a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square"  style="font-size:20px;" id="open2"></i>
	            	</a>
	            	<a href="#" data-toggle="collapse" onclick="document.getElementById('setOutletEncodeDiv').style.display='none';" style="margin-right:10px;">
            			<i class="fa fa-times"  style="font-size:20px;" id="pro-i"></i>
            		</a>
				</div>
			</div>
			<div class="widget-body" style="">
				<form id="setPayMediumForm">
					<input type="hidden" name="id" id="numberParam_set">
				</form>
				<div class="zTreeDemoBackground left" style="padding-left:20px;">
					<ul id="treeDemo" class="ztree" style="overflow-y:scroll;height:400px;" ></ul>
				</div>
			</div>
			<!--修改保存/取消-->
	        <div class="modal-footer" style="text-align:center;">
	        	<button class="btn btn-success" style="width: 100px;" id="saveSet" type="submit"  onclick="saveSetCoupon();">保存</button>&emsp;&emsp;
	        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('setOutletEncodeDiv').style.display='none';"/>
	        	<input class="btn btn-danger" style="display:none" id="editReset" type="reset" value="取消""/>
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