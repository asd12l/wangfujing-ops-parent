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
<!--ztree-->
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="http://10.6.2.152:8081/log-analytics/wfj-log.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ztree/css/zTreeStyle.css" type="text/css">
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
.ztree *{
	font-size:16px;
	font-family: "Open Sans","Segoe UI";
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
} }; 
script.src= logJs; 
head.appendChild(script);  
}
function sendParameter(){
LA.sysCode = '59';
}
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
//	$("#name_form").val($("#name_input").val());
//	$("#code_form").val($("#code_input").val());
	$("#parentCode_form").val(supCode);
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

//设置参数表单数据
function setParamForm(type){
	if("edit"==type){
		$("#idParam_form").val($("#id_"+type).val());
	}
	$("#parentCodeParam_form").val(supCode);
	$("#codeParam_form").val($("#code_"+type).val());
	$("#nameParam_form").val($("#name_"+type).val());
	$("#typeCodeParam_form").val($("#typeCode_"+type).val());
	$("#invoiceFlagParam_form").val($('input[name="invoiceFlag_'+type+'"]:checked ').val());
	$("#remarkParam_form").val($("#remark_"+type).val());
}


//添加支付介质
function add(){
	sendParameter();
	LA.log('payMedium-2-addMedium', '支付介质添加二级支付介质', userName, sessionId);

	var url=__ctxPath+"/wfjpay/payMedium/addPayMedium";
	setParamForm("add");
	var param=$("#data_form").serialize();
	$.post(url,param,function(data){
		if(data.success==true){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
			$("#modal-success .btn-success").attr("onclick","closeAddDiv();successBtn();");
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+data.msg+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	},"json");
}

//修改支付介质
function edit(){
	sendParameter();
	LA.log('payMedium-2-modify', '支付介质修改二级支付介质', userName, sessionId);
	var url=__ctxPath+"/wfjpay/payMedium/updatePayMedium";
	setParamForm("edit");
	var param=$("#data_form").serialize();
	$.post(url,param,function(data){
		if(data.success==true){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
			$("#modal-success .btn-success").attr("onclick","closeEditDiv();successBtn();");
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+data.msg+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	},"json");
}

//查询支付方式类型
function findMediumType(type){
	var url=__ctxPath+"/wfjpay/payMedium/selectPayTypeList";
	$.post(url,function(data){
		var option="";
		if(data.success){
			for(var i in data.list){
				option+="<option value='"+data.list[i].typeCode+"'>"+data.list[i].typeRemark+"</option>";
			}
			$("#typeCode_"+type).html(option);
			if(type=="edit"){
				$("#typeCode_"+type).val($("#typeCode1_"+type).val());
			}
		}
	},"json");
}
//删除支付介质
function deleteMedium(code){
	var url=__ctxPath+"/wfjpay/payMedium/deleteMedium";
	var param={
			code:code
	}
	$.post(url,param,function(data){
		var option="";
		if(data.success){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
			$("#modal-success .btn-success").attr("onclick","closeDeleteDiv();successBtn();");
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+data.msg+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
	},"json");
}
//初始化函数
	function initOlv() {
		
	$("#supName_input").val(supName)
	//请求地址
	var url = __ctxPath+"/wfjpay/payMedium/findAllList";
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
        	 userName = data.userName ;
     		 logJs = data.logJs;
     		 reloadjs();
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
	$("#addForm").data('bootstrapValidator').resetForm();
	findMediumType("add");
	$("#addDiv").show();
}

//显示修改窗口
function showEditDiv(code){
	$("#editForm").data('bootstrapValidator').resetForm();
	$("#typeCode1_edit").val($("#typeCode_"+code).val());
	$("#id_edit").val(code);
	$("#code_edit").val(code);
	$("#name_edit").val($("#name_"+code).text().trim());
	$("#typeCode_edit").val($("#typeCode_"+code).val());
	if($("#invoiceFlag_"+code).attr("status")=="0"){
		$("input[name=invoiceFlag_edit]:eq(1)").get(0).checked=true;
	}else{
		$("input[name=invoiceFlag_edit]:eq(0)").get(0).checked=true;
	}
	$("#remark_edit").val($("#remark_"+code).text().trim());
	findMediumType("edit");
	$("#editDiv").show();
}
//显示设置支付介质页面
function backUpPage(){
	var url = __ctxPath + "/jsp/pay/payMedium/mediumList.jsp";
	$("#pageBody").load(url);
}
//关闭添加面板
function closeAddDiv(){
	$("#addDiv").hide();
//	$("#addForm").data('bootstrapValidator').resetForm();
	olvQuery();
}
//关闭修改面板
function closeEditDiv(){
	$("#editDiv").hide();
//	$("#editForm").data('bootstrapValidator').resetForm();
	olvQuery();
}
//显示删除提示
function showDeleteDiv(code){
	$("#deleteButton").attr("onclick","deleteMedium("+code+");");
	$("#modal-warning-1").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning","onclick":"closeWarningDiv();"});
}
//关闭删除提示
function closeDeleteDiv(){
	$("#modal-warning-1").hide();
	olvQuery();
}
var httpReg=/^((http|ftp|https):\/\/)(([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,4})*(\/[a-zA-Z0-9\&%_\.\/-~-]*)?$/;
//表单验证
$(function(){
		$('#addForm').bootstrapValidator({
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
			name : {
				validators : {
					notEmpty : {
						message : '名称不能为空'
					},
					regexp : {
						regexp : /^[\u4e00-\u9fa5|0-9|a-z|A-Z]{1,10}$/,
						message : '名称只能为中文或者字母'
					},
					remote: {
	                        message: '汉字名不能大于6位，英文不能大于12位',
	                        url: validateUrl,
	                        data: function(validator) {
	                            return {
	                                content: validator.getFieldElements('name').val(),
	                                length:12
	                            };
	                	}
					}
				}
			},
			code : {
				validators : {
					notEmpty : {
						message : '编码不能为空'
					},
					regexp : {
						regexp : /^[0-9]{1,5}$/,
						message : '编码只能为数字且长度不大于5位'
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
					$('#addForm').data('bootstrapValidator')
							.disableSubmitButtons(false);
				}
	});
	$('#editForm').bootstrapValidator({
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
			name : {
				validators : {
					notEmpty : {
						message : '名称不能为空'
					},
					regexp : {
						regexp : /^[\u4e00-\u9fa5|0-9|a-z|A-Z]{1,10}$/,
						message : '名称只能为中文或者字母'
					},
					remote: {
	                        message: '汉字名不能大于6位，英文不能大于12位',
	                        url: validateUrl,
	                        data: function(validator) {
	                            return {
	                                content: validator.getFieldElements('name').val(),
	                                length:12
	                            };
	                        }
	                }
				}
			},
			code : {
				validators : {
					notEmpty : {
						message : '编码不能为空'
					},
					regexp : {
						regexp : /^[0-9]{1,5}$/,
						message : '编码只能为数字且长度不大于5位'
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
					$('#addForm').data('bootstrapValidator').disableSubmitButtons(false);
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
                                <h5 class="widget-caption">二级支付介质管理</h5>
                                <div class="widget-buttons">
                                    <a href="#" data-toggle="maximize"></a>
                                    <a href="#" data-toggle="collapse" onclick="backUpPage();">
                                    	<i class="fa fa-mail-reply" ></i>
                                    </a>
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
		                        				<label class="titname">一级介质：</label>
		                        				<input type="text" id="supName_input"  readonly="readonly"/>
		                       				</li>
                            			<!--
                                			<li class="col-md-4">
                                				<label class="titname">一级介质码：</label>
                                				<input type="text" id="code_input" />
                               				</li>
                               				<li class="col-md-4">
	                            				<label class="titname">一级介质名称：</label>
	                            				<input type="text" id="name_input" />
                            				</li>
                            				<li class="col-md-4">
                            					<!--<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;-->
                            					<a onclick="showAddDiv();" class="btn btn-primary" style="float:right;margin-right:20px;width:100px;" > <i class="fa fa-plus"></i>新建</a>&nbsp;&nbsp;&nbsp;&nbsp;
											</li>
                                		</ul>
                                	<!--查询表单-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
										<input type="hidden" id="parentCode_form" name="parentCode"/>
									<!--	<input type="hidden" id="name_form" name="name"/>
										<input type="hidden" id="code_form" name="code"/>
									-->
                                  	</form>
                                  	<!--参数表单，添加或修改用-->
                                  	<form id="data_form" action="">
                                  		<input type="hidden" id="parentCodeParam_form" name="parentCode"/>
                                  		<input type="hidden" id="idParam_form" name="id"/>
                                  		<input type="hidden" id="codeParam_form" name="code"/>
										<input type="hidden" id="nameParam_form" name="name"/>
										<input type="hidden" id="typeCodeParam_form" name="typeCode"/>
										<input type="hidden" id="invoiceFlagParam_form" name="invoiceFlag"/>
										<input type="hidden" id="remarkParam_form" name="remark"/>
									</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%;min-height:400px; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="2%" style="text-align: center;min-width:100px;">二级介质码</th>
                                            <th width="3%" style="text-align: center;min-width:150px;">二级介质名称</th>
                                            <th width="2%" style="text-align: center;min-width:180px;">介质类型</th>
                                            <th width="3%" style="text-align: center;min-width:160px;">是否开票</th>
                                            <th width="3%" style="text-align: center;min-width:160px;">备注</th>
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
										<tr class="gradeX" id="gradeX{$T.Result.code}" onclick="" style="height:35px;">
											<!--介质码-->	
											<td align="center" id="code_{$T.Result.code}">
												{$T.Result.code}
											</td>
											<!--介质名称-->
											<td align="center" id="name_{$T.Result.code}">
												{#if $T.Result.name != '[object Object]'}{$T.Result.name}
												{#/if}
											</td>
											<!--介质类型-->
											<td align="center">
												<input type="hidden" id="typeCode_{$T.Result.code}" value="{#if $T.Result.typeCode!= '[object Object]'}{$T.Result.typeCode}{#/if}"/>
												{#if $T.Result.typeCode!= '[object Object]'}{$T.Result.typeRemark}
				                   				{#/if}
											</td>
											<!--是否开票-->
											<td align="center" id="invoiceFlag_{$T.Result.code}" status='{#if $T.Result.invoiceFlag!= "[object Object]"}{$T.Result.invoiceFlag}{#/if}'>
												{#if $T.Result.invoiceFlag!= '[object Object]'&&$T.Result.invoiceFlag=='1' }是
				                   				{#/if}
												{#if $T.Result.invoiceFlag!= '[object Object]'&&$T.Result.invoiceFlag=='0' }否
				                   				{#/if}
											</td>
											<!--备注-->
											<td align="center" id="remark_{$T.Result.code}"  >
												{#if $T.Result.remark!= '[object Object]'}{$T.Result.remark}
				                   				{#/if}
											</td>
											<!--操作-->
											<td align="center" >
												<a class="btn btn-default purple btn-sm fa fa-edit" onclick='showEditDiv("{$T.Result.code}");'> 修改</a>
												<a class="btn btn-default purple btn-sm fa fa-cog" onclick='showDeleteDiv("{$T.Result.code}")' style="display:none;"> 删除</a>
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
	<div class="modal-dialog" style="width: 500px;height:400px;margin: 10% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">添加二级介质</span>
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="document.getElementById('addDiv').style.display='none';" style="margin-right:10px;">×</button>
			</div>
			<form  id="addForm" method="post" class="form-horizontal" enctype="multipart/form-data">  
			    <div class="widget-body" >
					<div class="form-group" >
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">二级介质码：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="code_add" name="code" placeholder="必填"/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">二级介质名称：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="name_add" name="name" placeholder="必填"/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">支付方式类型：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<select class="form-control" style="width:225px;" id="typeCode_add" name="typeCode" />
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">是否开票：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<div class="radio" style="width:200px;">
									<label>
										<input class="basic" type="radio" checked="checked" name="invoiceFlag_add" value="1"/>
										<span class="text">是</span>
									</label>
									<label >
										<input class="basic" type="radio" name="invoiceFlag_add" value="0"/>
										<span class="text">否</span>
									</label>
								</div>
								<div class="radio" style="display: none;">
									<label> <input class="inverted" type="radio"
										name="invoiceFlag_add"> <span class="text"></span>
									</label>
							</div>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">备注：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="remark_add" name="remark" />
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
	<div class="modal-dialog" style="width: 500px;height:400px;margin: 10% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">修改二级介质</span>
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="document.getElementById('editDiv').style.display='none';" style="margin-right:10px;">×</button>
			</div>
			<form id="editForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
			    <div class="widget-body">
					<input type="hidden" id="id_edit" value=""/>
					<input type="hidden" id="typeCode1_edit" value=""/>
					<div class="form-group" >
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">二级介质码：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="code_edit" name="code" placeholder="必填" readonly="readonly"/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">二级介质名称：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="name_edit" name="name" placeholder="必填"/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">支付方式类型：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<select class="form-control" style="width:225px;" id="typeCode_edit" name="typeCode" />
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">是否开票：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<div class="radio" style="width:200px;">
									<label>
										<input class="basic" type="radio" checked="checked" name="invoiceFlag_edit" value="1"/>
										<span class="text">是</span>
									</label>
									<label >
										<input class="basic" type="radio" name="invoiceFlag_edit" value="0"/>
										<span class="text">否</span>
									</label>
								</div>
								<div class="radio" style="display: none;">
									<label> <input class="inverted" type="radio"
										name="invoiceFlag_edit"> <span class="text"></span>
									</label>
								</div>
							</div>											
						</div>
					</div>
					<div class="form-group">
					<div class="">
						<label class="col-lg-5 col-sm-5 col-xs-5 control-label">备注：</label>
						<div class="col-lg-6 col-sm-6 col-xs-6">
							<input type="text" class="form-control" id="remark_edit" name="remark" />
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