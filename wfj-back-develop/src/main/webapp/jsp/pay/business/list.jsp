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
<!--Bootstrap Date Range Picker-->
<script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/validation/bootstrapValidator.js"></script>
<style type="text/css">
.trClick>td,.trClick>th{
 color:red;
}
.detail_info{
	z-index:999;
	position: absolute;
	display:none;
	padding: 5px;
	text-align: left;
	min-width: 150px;
	min-height: 40px;
	color:#555;
	font-size:14px;
	border-radius: 5px;
	border:2px solid gray;
	background-color:#eff6fc;
}
</style>
<script type="text/javascript">
//上下文路径
__ctxPath = "${pageContext.request.contextPath}";

//页码
var olvPagination;
//初始化参数

//页面加载完成后自动执行
$(function() {
	
    initOlv();
	
});

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

//设置表单
function setFormData(){
	$("#platformName_form").val($("#platformName_input").val());
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

//添加业务平台数据
function add(){
	var url=__ctxPath+"/wfjpay/addBusinessPlatform";
	var bpName=$("#bpName_add").val();
	var redirectUrl=$("#redirectUrl_add").val();
	var notifyUrl=$("#notifyUrl_add").val();
	var mobileRedirectUrl=$("#mobileRedirectUrl_add").val();
	var mobileNotifyUrl=$("#mobileNotifyUrl_add").val();
	var status=$('input[name="status_add"]:checked ').val();
	var description=$("#description_add").val();
	var param={
			bpName:bpName,
			redirectUrl:redirectUrl,
			notifyUrl:notifyUrl,
			mobileRedirectUrl:mobileRedirectUrl,
			mobileNotifyUrl:mobileNotifyUrl,
			status:status,
			description:description
	}
	$.post(url,param,function(data){
		if(data.success=="true"){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
			$("#modal-success .btn-success").attr("onclick","closeAddDiv();successBtn();");
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+data.msg+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	},"json");
}

//修改业务平台数据
function edit(){
	var url=__ctxPath+"/wfjpay/updateBusinessPlatform";
	var id=$("#id_edit").val();
	var bpName=$("#bpName_edit").val();
	var redirectUrl=$("#redirectUrl_edit").val();
	var notifyUrl=$("#notifyUrl_edit").val();
	var mobileRedirectUrl=$("#mobileRedirectUrl_edit").val();
	var mobileNotifyUrl=$("#mobileNotifyUrl_edit").val();
	var status=$('input[name="status_edit"]:checked ').val();
	var description=$("#description_edit").val();
	var param={
			id:id,
			bpName:bpName,
			redirectUrl:redirectUrl,
			notifyUrl:notifyUrl,
			mobileRedirectUrl:mobileRedirectUrl,
			mobileNotifyUrl:mobileNotifyUrl,
			status:status,
			description:description
	}
	$.post(url,param,function(data){
		if(data.success=="true"){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
			$("#modal-success .btn-success").attr("onclick","closeEditDiv();successBtn();");
//			olvPagination.onReload();
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+data.msg+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});

		}
	},"json");
}

//渠道数据验证
function validateData(obj,type){
	var flag=true;
	if(obj.clientType==null||obj.clientType==""){
		$("#clientTypeError_"+type).html("*终端不能为空");
		flag=false;
	}
	if(obj.payType==null||obj.payType==""){
		$("#payTypeError_"+type).html("*渠道不能为空");
		flag=false;
	}
	if(obj.dicCode==null||obj.dicCode==""){
		$("#bankError_"+type).html("*银行不能为空");
		flag=false;
	}
	if(obj.payPartner==null||obj.payPartner==""){
		$("#channelAccountError_"+type).html("*签约账号不能为空");
		flag=false;
	}
	return flag;
}
//渠道错误信息清除
function cleanErrorMsg(type){
	$("#clientTypeError_"+type).html("*");
	$("#payTypeError_"+type).html("*");
	$("#bankError_"+type).html("*");
	$("#channelAccountError_"+type).html("*");
}
//添加支付渠道
function addPayChannel(){
	var url=__ctxPath+"/wfjpay/business/addPayChannel";
	var bpId=$("#cashierBpId").val();
	var clientType=$("#clientType_add").val();
	var payType=$("#payType_add").val();
	var dicCode=$("#bank_add").val();
	var payPartner=$("#channelAccount_add").val();
	var payService=$("#payService").val();
	var param={
			payService:payService,
			bpId:bpId,
			clientType:clientType,
			payType:payType,
			dicCode:dicCode,
			payPartner:payPartner
	}
	if(!validateData(param,"add")){
		return;
	}
	$.post(url,param,function(data){
		if(data.success=="true"){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
			$("#modal-success .btn-success").attr("onclick","closeAddPayChannelDiv();successBtn();");
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+data.msg+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	},"json");
}
//删除支付渠道
function deletePayChannel(id){
	var url=__ctxPath+"/wfjpay/business/deletePayChannel";
	var payService=$("#payService").val();
	var param={
			id:id
	}
	$.post(url,param,function(data){
		if(data.success=="true"){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
			var payService=$("#payService").val();
			selectPayChannel(payService);
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败！</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	},"json");
}
//更新支付渠道
function updatePayChannel(id){
	var url=__ctxPath+"/wfjpay/business/updatePayChannel";
	var bpId=$("#cashierBpId").val();
	var clientType=$("#clientType_edit").val();
	var payType=$("#payType_edit").val();
	var dicCode=$("#bank_edit").val();
	var payPartner=$("#channelAccount_edit").val();
	var payService=$("#payService").val();
	var id=$("#channelId_edit").val();
	var param={
			id:id,
			payService:payService,
			bpId:bpId,
			clientType:clientType,
			payType:payType,
			dicCode:dicCode,
			payPartner:payPartner
	}
	if(!validateData(param,"edit")){
		return;
	}
	$.post(url,param,function(data){
		if(data.success=="true"){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
			$("#modal-success .btn-success").attr("onclick","closeEditPayChannelDiv();successBtn();");
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+data.msg+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	},"json");
}
//查询支付渠道数据
function selectPayChannel(payService){
	//加载框..
	$("#loading-container").attr("class","loading-container");
	$("#payService").val(payService);
	//查询支付渠道列表
	var url=__ctxPath+"/wfjpay/business/selectPayChannelList";
	var bpId=$("#cashierBpId").val();
	var param={
			payService:payService,
			bpId:bpId
	}
	$.post(url,param,function(data){
		$("#cashierDesk_tab tbody").setTemplateElement("cashierDesk-list").processTemplate(data);
		if(data.success=="true"){
		}
	},"json").complete(function() { 
		//请求完成后隐藏加载框
		$("#loading-container").removeClass("loading-container");
		$("#loading-container").addClass("loading-inactive");
	});
}
//查询下拉渠道签约账号
function selectChannelAccount(type,id){
	var url=__ctxPath+"/wfjpay/business/selectPartnerAccount";
	var payType=$("#payType_"+type).val();
	var param={
			payType:payType
	}
	$.post(url,param,function(data){
		var option="";
		if(data.success=="true"){
			for(var i in data.list){
				option+="<option value='"+data.list[i].id+"'>"+data.list[i].partner+"</option>";
			}
		}
		$("#channelAccount_"+type).html(option);
		if(type=="edit"){
			$("#channelAccount_edit").val($("#payPartner_"+id).attr("val"));
		}
	},"json");
}

//初始化函数
	function initOlv() {
	//请求地址
	var url = __ctxPath+"/wfjpay/business";
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
        	 for(var i in data.list){
        		 data.list[i ].lastDate=formatDate(data.list[i].lastDate);
        		 //备注消息大于20个英文字符时，隐藏多余的文字
        		 if(data.list[i].description!= '[object Object]'&&data.list[i].description.replace(/[^\x00-\xff]/g,"01").length>20){
        			 var len=0;
        			 var s="";
        			 var str=data.list[i].description.substr(0,20);
        			 for(var j=0;j<str.length;j++){
        				 if(str.charAt(j).replace(/[^\x00-\xff]/g,"01").length==1){
        					 len++;
        				 }else{
        					 len+=2;
        				 }
        				 if(len>=20){
        					 data.list[i].shortDescription=data.list[i].description.substr(0,j)+"...";
        					 break;
        				 }
        			 }
        		 }else{
        			 data.list[i].shortDescription=data.list[i].description;
        		 }
        	 }
        	 $("#pageNo_form").val(data.pageNo);
       		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
         }
       }
     });
	
	setFormData();
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

//显示添加窗口
function showAddDiv(){
	$("#addReset").click();
	$("#addBusinessForm").data('bootstrapValidator').resetForm();
	$("#addDiv").show();
}

//显示添加渠道窗口
function showAddPayChannel(){
	cleanErrorMsg("add");
	$("#clientType_add option").get(0).selected=true;
	$("#payType_add option").get(0).selected=true;
	$("#bank_add").html("");
	$("#channelAccount_add").html("");
	//查询银行下拉列表
	var url=__ctxPath+"/wfjpay/business/selectBankList";
	var param={
			payService:$("#payService").val()
	}
	$.post(url,param,function(data){
		if(data.success=="true"){
			var option="";
			for(var i in data.list){
				option+="<option value='"+data.list[i].name+"'>"+data.list[i].value+"</option>";
			}
			$("#bank_add").html(option);
		}
	},"json");
	selectChannelAccount("add");
	//显示添加渠道窗口
	$("#addPayChannelDiv").show();
}

//显示修改渠道窗口
function showEditPayChannel(id){
	cleanErrorMsg("edit");
	//查询银行下拉列表
	var url=__ctxPath+"/wfjpay/business/selectBankList";
	var param={
			payService:$("#payService").val()
	}
	$.post(url,param,function(data){
		if(data.success=="true"){
			var option="";
			for(var i in data.list){
				option+="<option value='"+data.list[i].name+"'>"+data.list[i].value+"</option>";
			}
			$("#bank_edit").html(option);
			$("#bank_edit").val($("#dicCode_"+id).attr("val"));
			selectChannelAccount("edit",id);
		}
	},"json");
	$("#channelId_edit").val(id);
	$("#clientType_edit").val($("#clientType_"+id).attr("val"));
	$("#payType_edit").val($("#payType_"+id).attr("val"));
	$("#editPayChannelDiv").show();
}
//显示修改窗口
function showEditDiv(id){
	$("#editBusinessForm").data('bootstrapValidator').resetForm();
	$("#id_edit").val(id);
	$("#bpName_edit").val($("#bpName_"+id).text().trim());
	$("#redirectUrl_edit").val($("#redirectUrl_"+id).text().trim());
	$("#notifyUrl_edit").val($("#notifyUrl_"+id).text().trim());
	$("#mobileRedirectUrl_edit").val($("#mobileRedirectUrl_"+id).text().trim());
	$("#mobileNotifyUrl_edit").val($("#mobileNotifyUrl_"+id).text().trim());
	$("#description_edit").val($("#description_"+id+" div").eq(0).text().trim());
	if($("#status_"+id).text().trim()=="0"){
		$("input[name=status_edit]:eq(1)").get(0).checked=true;
	}else{
		$("input[name=status_edit]:eq(0)").get(0).checked=true;
	}
	$("#editDiv").show();
}
//显示收银台窗口
function showCashierDesk(id){
	channelType_add();
	channelType_edit();
	$("#cashierPlatformName").val($("#bpName_"+id).text().trim());
	$("#cashierBpId").val(id);
	selectPayChannel($("#payService").val());
	$("#cashierDeskDiv").show();
	
}
//显示警告窗口
function showWarningDiv(id){
	$("#modal-warning-1").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
	$("#deleteButton").attr("onclick","deletePayChannel("+id+");closeWarningDiv();");
}
//关闭警告窗口
function closeWarningDiv(){
	$("#modal-warning-1").hide();
}
//关闭添加面板
function closeAddDiv(){
	$("#addDiv").hide();
	olvQuery();
}
//关闭修改面板
function closeEditDiv(){
	$("#editDiv").hide();
	olvQuery();
}
//关闭收银台窗口
function closeCashierDeskDiv(){
	$("#cashierDeskDiv").hide();
}
//关闭添加支付渠道窗口
function closeAddPayChannelDiv(){
	$("#addPayChannelDiv").hide();
	var payService=$("#payService").val();
	selectPayChannel(payService);
}
//关闭修改支付渠道窗口
function closeEditPayChannelDiv(){
	$("#editPayChannelDiv").hide();
	var payService=$("#payService").val();
	selectPayChannel(payService);
}
//关闭成功页面
function proSaveSuccess(){
	$("#proSaveSuccess").hide();
}

//添加渠道
function channelType_add(){
	var url=__ctxPath+"/wfjpay/selectChannelType";
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
				$("#payType_add").html(option);
			}
		},
		error:function(){
			alert("获取渠道类型失败！");
		}
	});
}
//修改渠道
function channelType_edit(){
	var url=__ctxPath+"/wfjpay/selectChannelType";
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
				$("#payType_edit").html(option);
			}
		},
		error:function(){
			alert("获取渠道类型失败！");
		}
	});
}


//showDetail
function showDetail(flag, a) {
    var detailDiv = a.parentNode.getElementsByTagName("div")[0];
    if (flag) {
        detailDiv.style.display = "block";
    }
    else
    	detailDiv.style.display = "none";
}
   
var httpReg=/^((http|ftp|https):\/\/)(([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,4})*(\/[a-zA-Z0-9\&%_\.\/-~-]*)?$/;
//表单验证
$(function(){
		$('#addBusinessForm').bootstrapValidator({
		message : 'This value is not valid',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		submitHandler : function(validator, form, submitButton) {
			add();
		},
		fields : {
			bpName : {
				validators : {
					notEmpty : {
						message : '接口名称不能为空'
					},
					regexp : {
						regexp : /^.{1,128}$/,
						message : '接口名称必须小于128位'
					}
				}
			},
			notifyUrl : {
				validators : {
					regexp : {
						regexp : httpReg,
						message : '地址不合法'
					}
				}
			},
			mobileRedirectUrl : {
				validators : {
					regexp : {
						regexp : httpReg,
						message : '地址不合法'
					}
				}
			},
			mobileNotifyUrl : {
				validators : {
					regexp : {
						regexp : httpReg,
						message : '地址不合法'
					}
				}
			},
			redirectUrl : {
				validators : {
					regexp : {
						regexp : httpReg,
						message : '地址不合法'
					}
				}
			}
			
		}

	})
	$('#save').on(
			'click',
			function() {
				var $target = $($(this).attr('data-toggle'));
				$target.toggle();
				if (!$target.is(':visible')) {
					$('#addBusinessForm').data('bootstrapValidator')
							.disableSubmitButtons(false);
				}
	});
	$('#editBusinessForm').bootstrapValidator({
		message : 'This value is not valid',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		submitHandler : function(validator, form, submitButton) {
			edit();
		},
		fields : {
			bpName : {
				validators : {
					notEmpty : {
						message : '接口名称不能为空'
					},
					regexp : {
						regexp : /^.{1,128}$/,
						message : '接口名称必须小于128位'
					}
				}
			},
			notifyUrl : {
				validators : {
					regexp : {
						regexp : httpReg,
						message : '地址不合法'
					}
				}
			},
			mobileRedirectUrl : {
				validators : {
					regexp : {
						regexp : httpReg,
						message : '地址不合法'
					}
				}
			},
			mobileNotifyUrl : {
				validators : {
					regexp : {
						regexp : httpReg,
						message : '地址不合法'
					}
				}
			},
			redirectUrl : {
				validators : {
					regexp : {
						regexp : httpReg,
						message : '地址不合法'
					}
				}
			}
			
		}

	})
	$('#edit').on(
			'click',
			function() {
				var $target = $($(this).attr('data-toggle'));
				$target.toggle();
				if (!$target.is(':visible')) {
					$('#addBusinessForm').data('bootstrapValidator')
							.disableSubmitButtons(false);
				}
	});
});





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
                                <h5 class="widget-caption">业务接口管理</h5>
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
                                				<label class="titname">平台名称：</label>
                                				<input type="text" id="platformName_input" />
                               				</li>
                            				<li class="col-md-4">
                            					<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
											</li>
											<li class="col-md-4" >
												<a onclick="showAddDiv();" class="btn btn-primary" style="float:right;margin-right:20px;width:100px;" > <i class="fa fa-plus"></i>新建</a>&nbsp;&nbsp;&nbsp;&nbsp;
											</li>
                                		</ul>
                                	<!--隐藏参数-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
										<input type="hidden" id="platformName_form" name="platformName"/>
                                  	</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%; min-height:400px; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="2%" style="text-align: center;min-width:100px;">平台ID</th>
                                            <th width="3%" style="text-align: center;min-width:150px;">名称</th>
                                            <th width="2%" style="text-align: center;min-width:180px;">备注</th>
                                            <th width="2%" style="text-align: center;min-width:260px;display:none;" >Key</th>
                                            <th width="3%" style="text-align: center;min-width:160px;">最后修改时间</th>
                                            <th width="3%" style="text-align: center;min-width:180px;">操作</th>
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
										<tr class="gradeX" id="gradeX{$T.Result.id}" onclick="" style="height:35px;">
											<!--平台ID-->	
											<td align="center" id="platform_{$T.Result.id}">
												{$T.Result.id}
											</td>
											<!--名称-->
											<td align="center" id="bpName_{$T.Result.id}">
												{#if $T.Result.bpName != '[object Object]'}{$T.Result.bpName}
												{#/if}
											</td>
											<!--备注-->
											<td align="center" id="description_{$T.Result.id}" onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">
												{#if $T.Result.description!= '[object Object]'}{$T.Result.shortDescription}
				                   				{#/if}
				                   				<div class="detail_info">
					                   				{#if $T.Result.description!= '[object Object]'}{$T.Result.description}
					                   				{#/if}
				                   				</div>
											</td>
											<!--Key-->
											<td align="center" id="bpkey_{$T.Result.id}" style="display:none;">
												{#if $T.Result.bpKey!= '[object Object]'}{$T.Result.bpKey}
				                   				{#/if}
											</td>
											<!--最后修改时间-->
											<td align="center" id="lastDate_{$T.Result.id}">
												{#if $T.Result.lastDate!= '[object Object]'}{$T.Result.lastDate}
												{#/if}
											</td>
											<!--操作-->
											<td align="center" >
												<a class="btn btn-default purple btn-sm fa fa-edit" onclick="showEditDiv({$T.Result.id});"> 修改</a>
												<a class="btn btn-default purple btn-sm fa fa-cog" onclick="showCashierDesk({$T.Result.id})"> 设置收银台</a>
											</td>
											<!--同步通知地址(pc)-->
											<td align="center" id="redirectUrl_{$T.Result.id}" style="display:none">
												{#if $T.Result.redirectUrl!= '[object Object]'}{$T.Result.redirectUrl}
												{#/if}
											</td>
											<!--异步通知地址(pc)-->
											<td align="center" id="notifyUrl_{$T.Result.id}" style="display:none">
												{#if $T.Result.notifyUrl!= '[object Object]'}{$T.Result.notifyUrl}
												{#/if}
											</td>
											<!--同步通知地址(M)-->
											<td align="center" id="redirectUrl_{$T.Result.id}" style="display:none">
												{#if $T.Result.mobileRedirectUrl!= '[object Object]'}{$T.Result.mobileRedirectUrl}
												{#/if}
											</td>
											<!--异步通知地址(M)-->
											<td align="center" id="mobileNotifyUrl_{$T.Result.id}" style="display:none">
												{#if $T.Result.mobileNotifyUrl!= '[object Object]'}{$T.Result.mobileNotifyUrl}
												{#/if}
											</td>
											<!--状态-->
											<td align="center" id="status_{$T.Result.id}" style="display:none">
												{#if $T.Result.status!= '[object Object]'}{$T.Result.status}
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
<!--添加-->
<style>
.control-label{width:150px;}
.form-group{margin:5px 0;}
</style>
<div class="modal modal-darkorange" id="addDiv">
	<div class="modal-dialog" style="width: 800px;height:50%;margin: 10% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">添加</span>
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="document.getElementById('addDiv').style.display='none';" style="margin-right:10px;">×</button>
			</div>
			<form  id="addBusinessForm" method="post" class="form-inline" enctype="multipart/form-data">        
			    <div class="widget-body">
					<input type="hidden" name="userName" value="${username }"/>
					<input type="hidden" name="brandType" value="0"/>
					<input type="hidden" name="shopType" value="0"/>
					<input type="hidden" name="shopSid" value="-1"/>
					<div class="form-group" >
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">接口名称：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="bpName_add" name="bpName" placeholder="必填"/>
							</div>											
						</div>
					</div>
					<br/>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">同步通知地址(PC)：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="redirectUrl_add" name="redirectUrl" placeholder=""/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">异步通知地址(PC)：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="notifyUrl_add" name="notifyUrl" placeholder=""/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">同步通知地址(M)：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="mobileRedirectUrl_add" name="mobileRedirectUrl" placeholder=""/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">异步通知地址(M)：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="mobileNotifyUrl_add" name="mobileNotifyUrl" placeholder=""/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">是否启用：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<div class="radio" style="width:200px;">
									<label>
										<input class="basic" type="radio" checked="checked" name="status_add" value="1"/>
										<span class="text">是</span>
									</label>
									<label >
										<input class="basic" type="radio" name="status_add" value="0"/>
										<span class="text">否</span>
									</label>
								</div>
								<div class="radio" style="display: none;">
									<label> <input class="inverted" type="radio"
										name="status_add"> <span class="text"></span>
									</label>
							</div>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">备注：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<textarea style="width: 450px;height: 180px;max-width: 500px;max-height: 180px;min-width: 180px;min-height: 100px;resize: none" id="description_add" name="description" placeholder=""></textarea>
							</div>											
						</div>
					</div>
				</div>
			        
					<!--保存和取消-->
		        <div class="modal-footer" style="text-align:center;">
		        	<button class="btn btn-success" style="width: 100px;" id="save" type="submit"">保存</button>&emsp;&emsp;
		        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('addDiv').style.display='none';"/>
		        	<input class="btn btn-danger" style="display:none" id="addReset" type="reset" value="重置""/>
		        </div>
		    </form>
	    </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div> 
<!--修改-->
<div class="modal modal-darkorange" id="editDiv">
	<div class="modal-dialog" style="width: 800px;height:50%;margin: 10% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">修改</span>
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="document.getElementById('editDiv').style.display='none';" style="margin-right:10px;">×</button>
			</div>
			<form id="editBusinessForm" method="post" class="form-inline" enctype="multipart/form-data">        
			    <div class="widget-body">
					<input type="hidden" id="id_edit" value=""/>
					<div class="form-group">
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">接口名称：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="bpName_edit" name="bpName" placeholder="必填"/>
							</div>											
						</div>
					</div>
					<br/>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">同步通知地址(PC)：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="redirectUrl_edit" name="redirectUrl" placeholder=""/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">异步通知地址(PC)：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="notifyUrl_edit" name="notifyUrl" placeholder=""/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">同步通知地址(M)：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="mobileRedirectUrl_edit" name="mobileRedirectUrl" placeholder=""/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">异步通知地址(M)：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="mobileNotifyUrl_edit" name="mobileNotifyUrl" placeholder=""/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">是否启用：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<div class="radio" id="status_edit" style="width:200px;">
									<label>
										<input class="basic" type="radio"  name="status_edit" value="1"/>
										<span class="text">是</span>
									</label>
									<label>
										<input class="basic" type="radio"  name="status_edit" value="0"/>
										<span class="text">否</span>
									</label>
								</div>
								<div class="radio" style="display: none;">
									<label> <input class="inverted" type="radio"
										name="status_edit"> <span class="text"></span>
									</label>
								</div>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">备注：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<textarea style="width: 450px;height: 180px;max-width: 500px;max-height: 180px;min-width: 180px;min-height: 100px;resize: none" id="description_edit" name="description" placeholder=""></textarea>
							</div>											
						</div>
					</div>
				</div>
	        
				<!--修改保存/取消-->
		        <div class="modal-footer" style="text-align:center;">
		        	<button class="btn btn-success" style="width: 100px;" id="edit" type="submit" >保存</button>&emsp;&emsp;
		        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('editDiv').style.display='none';"/>
		        	<input class="btn btn-danger" style="display:none" id="editReset" type="reset" value="取消""/>
		        </div>
	        </form>
	    </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div> 
<!--设置收银台-->
<div class="modal modal-darkorange" id="cashierDeskDiv">
<div class="modal-dialog" style="width: 800px;height:100%;margin: 4% auto;">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeCashierDeskDiv();">×</button>
            <h4 class="modal-title" id="divTitle">设置收银台</h4>
        </div>
        <div class="page-body" id="pageBodyRight">
        	<label class="titname">业务平台：</label>
        	<input type="text" id="cashierPlatformName" readonly="readonly"/>
        	<input type="hidden" id="cashierBpId" >
        	<input type="hidden" id="payService" value="1">
        </div>
        <div class="tabbable" > <!-- Only required for left/right tabs -->
		      <ul class="nav nav-tabs">
		        <li class="active"><a href="#tab1" data-toggle="tab" onclick="selectPayChannel(1);">网银</a></li>
		        <li><a href="#tab1" data-toggle="tab" onclick="selectPayChannel(2);">第三方渠道</a></li>
		        <li><a href="#tab1" data-toggle="tab" onclick="selectPayChannel(3);">银行直连</a></li>
		        <li><a href="#tab1" data-toggle="tab" onclick="selectPayChannel(4);">IC卡</a></li>
		      </ul>
		      <div class="tab-content" style="padding:5px;">
		      	<div class="tab-pane active" id="tab1">
		      		<div style="width:100%;height:350px; overflow:scroll;">
                    <div class="widget-body" id="pro" style="margin-top：0;padding-top:0;">
                    <div class="table-toolbar" style="margin-top:0;" >
                    		<ul class="topList" >                           			
								<li style="margin-top:-5px;">
									<a onclick="showAddPayChannel();" class="btn btn-primary" style="float:right;margin-right:20px;width:100px;padding:5px;" > <i class="fa fa-plus"></i>添加</a>&nbsp;&nbsp;&nbsp;&nbsp;
								</li>
                    		</ul>
                    	<!--隐藏参数-->
               			<form id="payChannel_form" action="">
							<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
                      	</form>
                    <!--数据列表显示区域-->
                	<div style="width:100%; height:0%; overflow-Y: hidden;">
                    <table class="table-striped table-hover table-bordered" id="cashierDesk_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                        <thead>
                            <tr role="row" style='height:35px;'>
                                <th width="3%" style="text-align: center;min-width:145px;">银行</th>
                                <th width="3%" style="text-align: center;min-width:145px;">简码</th>
                                <th width="3%" style="text-align: center;min-width:145px;">终端</th>
                                <th width="3%" style="text-align: center;min-width:145px;">支付渠道</th>
                                <th width="3%" style="text-align: center;min-width:145px;">操作</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    </div>
                    <!--分页工具-->
                    <div id="cashierDeskPagination"></div>
                </div>
                <!--模板数据-->
				<!-- Templates -->
				<!--默认隐藏-->
				<p style="display:none">
					<textarea id="cashierDesk-list" rows="0" cols="0">
					{#template MAIN}
						{#foreach $T.list as Result}
							<tr class="gradeX" style="height:35px;">
								<!--银行-->	
								<td align="center" id="dicCode_{$T.Result.id}" val="{$T.Result.dic_code}">
							        {$T.Result.bankCode}
								</td>
								<!--简码-->	
								<td align="center" id="">
									{$T.Result.dic_code}
								</td>
								<!--终端-->	
								<td align="center" id="clientType_{$T.Result.id}" val="{ $T.Result.client_type}">
									{#if $T.Result.client_type== '01'}PC端
	                   				{#/if}
									{#if $T.Result.client_type== '02'}移动端
	                   				{#/if}
	                   				{#if $T.Result.client_type== '03'}PAD端
	                   				{#/if}
	                   				{#if $T.Result.client_type== '04'}POS端
	                   				{#/if}
								</td>
								<!--支付渠道-->	
								<td align="center" id="payType_{$T.Result.id}" val="{$T.Result.pay_type}">
									{$T.Result.payTypeCode}
								</td>
								<td align="center" id="payPartner_{$T.Result.id}" val="{$T.Result.pay_partner}" style="display:none;">
								</td>
								<!--操作-->	
								<td align="center" id="orderNo_{$T.Result.bpOrderId}">
									<a class="btn btn-default purple btn-sm fa fa-edit" onclick="showEditPayChannel({$T.Result.id});"> 修改</a>
									<a class="btn btn-default purple btn-sm fa fa-trash-o" onclick="showWarningDiv({$T.Result.id})"> 删除</a>
								</td>
				       		</tr>
						{#/for}
				    {#/template MAIN}	
					</textarea>
				</p>
            </div>
		      		</div>
		        </div>
		        <div class="tab-pane" id="tab2">
		         	<div style="width:100%;height:200px; overflow:scroll;">
		                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
		                    </table>
		            </div>
		        </div>
		        <div class="tab-pane" id="tab3">
	         	<div style="width:100%;height:200px; overflow:scroll;">
	                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
	                    </table>
	            </div>
	            <div class="tab-pane" id="tab4">
	         	<div style="width:100%;height:200px; overflow:scroll;">
	                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
	                    </table>
	            </div>
	        </div>
	        </div>
		      </div>
		</div>
		<!--关闭按钮-->
        <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-default" onclick="closeCashierDeskDiv();" type="button">关闭</button>
        </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div> 
<!--添加支付渠道窗口-->
<div class="modal modal-darkorange" id="addPayChannelDiv">
<div class="modal-dialog" style="width: 550px;height:50%;margin: 10% auto;">
    <div class="modal-content">
    <div class="widget-header">
		<span class="widget-caption">添加</span>
		<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="document.getElementById('addPayChannelDiv').style.display='none';" style="margin-right:10px;">×</button>
	</div>
    <div class="widget-body">
	<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
		<input type="hidden" id="payService_add" value="1"/>
		<input type="hidden" id="bpId_add"/>
		<div class="form-group">
			<div class=" ">
				<label class="col-lg-5 col-sm-5 col-xs-5 control-label">终端：</label>
				<div class="col-lg-8 col-sm-8 col-xs-8">
					<select style="width:200px;" id="clientType_add" style="padding:0 0;">
						<option value="01">PC端</option>
						<option value="02">移动端</option>
						<option value="03">PAD端</option>
						<option value="04">POS端</option>
					</select>
					<span style="color:red;" id="clientTypeError_add">*</span>
				</div>											
			</div>
		</div>
		<div class="form-group">
			<div class="">
				<label class="col-lg-5 col-sm-5 col-xs-5 control-label">渠道：</label>
				<div class="col-lg-8 col-sm-8 col-xs-8">
					<select style="width:200px;" id="payType_add" style="padding:0 0;" onchange="selectChannelAccount('add');">
						
					</select>
					<span style="color:red;" id="payTypeError_add">*</span>
				</div>	
			</div>
		</div>
		<div class="form-group">
			<div class="">
				<label class="col-lg-5 col-sm-5 col-xs-5 control-label">银行：</label>
				<div class="col-lg-8 col-sm-8 col-xs-8">
					<select style="width:200px;" id="bank_add" style="padding:0 0;">
					</select>
					<span style="color:red;" id="bankError_add">*</span>
				</div>	
			</div>
		</div>
		<div class="form-group">
			<div class="">
				<label class="col-lg-5 col-sm-5 col-xs-5 control-label">渠道签约账号：</label>
				<div class="col-lg-8 col-sm-8 col-xs-8">
					<select style="width:200px;" id="channelAccount_add" style="padding:0 0;">
					</select>
					<span style="color:red;" id="channelAccountError_add">*</span>
				</div>	
			</div>
		</div>
	</form>
</div>
        
		<!--关闭按钮-->
        <div class="modal-footer" style="text-align:center;">
        	<button class="btn btn-success" style="width: 100px;" id="save" type="submit" onclick="addPayChannel()">保存</button>&emsp;&emsp;
        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('addPayChannelDiv').style.display='none';"/>
        </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div> 
<!--修改支付渠道窗口-->
<div class="modal modal-darkorange" id="editPayChannelDiv" >
<div class="modal-dialog" style="width: 500px;height:50%;margin: 10% auto;">
    <div class="modal-content">
    <div class="widget-header">
		<span class="widget-caption">修改</span>
		<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="document.getElementById('editPayChannelDiv').style.display='none';" style="margin-right:10px;">×</button>
	</div>
    <div class="widget-body">
	<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
		<input type="hidden" id="payService_edit" value="1"/>
		<input type="hidden" id="channelId_edit"/>
		<div class="form-group">
			<div class=" ">
				<label class="col-lg-5 col-sm-5 col-xs-5 control-label">终端：</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<select style="width:200px;" id="clientType_edit" style="padding:0 0;">
						<option value="01">PC端</option>
						<option value="02">移动端</option>
						<option value="03">PAD端</option>
						<option value="04">POS端</option>
					</select>
					<span style="color:red;" id="clientTypeError_edit">*</span>
				</div>											
			</div>
		</div>
		<div class="form-group">
			<div class="">
				<label class="col-lg-5 col-sm-5 col-xs-5 control-label">渠道：</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<select style="width:200px;" id="payType_edit" style="padding:0 0;" onchange="selectChannelAccount('edit');">
						
					</select>
					<span style="color:red;" id="payTypeError_edit">*</span>
				</div>											
			</div>
		</div>
		<div class="form-group">
			<div class="">
				<label class="col-lg-5 col-sm-5 col-xs-5 control-label">银行：</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<select style="width:200px;" id="bank_edit" style="padding:0 0;">
					</select>
					<span style="color:red;" id="bankError_edit">*</span>
				</div>											
			</div>
		</div>
		<div class="form-group">
			<div class="">
				<label class="col-lg-5 col-sm-5 col-xs-5 control-label">渠道签约账号：</label>
				<div class="col-lg-6 col-sm-6 col-xs-6">
					<select style="width:200px;" id="channelAccount_edit" style="padding:0 0;">
					</select>
					<span style="color:red;" id="channelAccountError_edit">*</span>
				</div>											
			</div>
		</div>
	</form>
</div>
        
		<!--关闭按钮-->
        <div class="modal-footer" style="text-align:center;">
        	<button class="btn btn-success" style="width: 100px;" id="save" type="submit" onclick="updatePayChannel(1)">保存</button>&emsp;&emsp;
        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('editPayChannelDiv').style.display='none';"/>
        </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div> 

<div aria-hidden="true" style="display: none;" class="modal modal-message modal-warning fade" id="modal-warning-1">
<div class="modal-dialog" style="margin: 200px auto;">
	<div class="modal-content">
       <div class="modal-header">
           <i class="fa fa-warning"></i>
       </div>
       <div class="modal-body" id="model-body-warning">确定删除吗?</div>
       <div class="modal-footer">
       	   <button data-dismiss="modal" class="btn btn-warning" type="button" id="deleteButton">确定</button>
           <button data-dismiss="modal" class="btn btn-warning" type="button" onclick="document.getElementById('modal-warning-1').style.display='none';">取消</button>
       </div>
   </div> <!-- / .modal-content -->
</div> <!-- / .modal-dialog -->
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