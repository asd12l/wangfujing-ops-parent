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

//页码
var olvPagination;
var oldZtree=[];
var newZtree=[];
var addZtree=[];
var delZtree=[];
//初始化参数

//页面加载完成后自动执行
$(function() {
    initOlv();
    bind();
});

function bind(){
	$("#open1").click(function(){
		var obj=$.fn.zTree.getZTreeObj("treeDemo");
		var nodes=obj.getCheckedNodes(true);
		if($(this).hasClass("fa-plus-square-o")){
			$(this).removeClass("fa-plus-square-o");
			$(this).addClass("fa-minus-square-o");
			for(var i in nodes){
				obj.expandNode(nodes[i],true,true,false);
			}
		}else{
			$(this).removeClass("fa-minus-square-o");
			$(this).addClass("fa-plus-square-o");
			for(var i in nodes){
				obj.expandNode(nodes[i],false,true,false);
			}
		}
	})
	$("#open2").click(function(){
		var obj=$.fn.zTree.getZTreeObj("treeDemo");
		if($(this).hasClass("fa-plus-square")){
			$(this).removeClass("fa-plus-square");
			$(this).addClass("fa-minus-square");
			obj.expandAll(true);
		}else{
			$(this).removeClass("fa-minus-square");
			$(this).addClass("fa-plus-square");
			obj.expandAll(false);
		}
	})
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

//设置表单
function setFormData(){
	$("#name_form").val($("#name_input").val());
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
	if(type=="edit"){
		$("#oldCodeParam_form").val($("#oldCodeParam_"+type).val());
		$("#oldNameParam_form").val($("#oldNameParam_"+type).val());
	}
	$("#codeParam_form").val($("#codeParam_"+type).val());
	$("#nameParam_form").val($("#nameParam_"+type).val());
	$("#isEnableParam_form").val($('input[name="isEnableParam_'+type+'"]:checked ').val());
}


//添加支付系统
function add(){
	var url=__ctxPath+"/wfjpay/paySystem/addPaySystem";
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

//修改支付系统
function edit(){
	var url=__ctxPath+"/wfjpay/payMedium/updatePaySystem";
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

//保存设置支付介质
function saveSetMedium(){
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
	}
	//获取删除的
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
	}
	var bpIdDateUrl=__ctxPath+"/wfjpay/paySystem/saveSetPayMedium";
	var id=$("#numberParam_set").val();
	var param={
			id:id,
			addZtree:JSON.stringify(addZtree),
			delZtree:JSON.stringify(delZtree)
	};
	$.post(bpIdDateUrl,param,function(data){
		if(data.success){
			$("#modal-success").attr({"style" : "display:block;z-index:9999;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
			$("#modal-success .btn-success").attr("onclick","closeSetMediumDiv();successBtn();");
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+data.msg+"</strong></div>");
			$("#modal-warning").attr({"style":"display:block;z-index:9999;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}
		
	},"json");
}

//初始化函数
	function initOlv() {
	//请求地址
	var url = __ctxPath+"/wfjpay/paySystem/findAllList";
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
	$("#addDiv").show();
}

//显示修改窗口
function showEditDiv(id){
	$("#editForm").data('bootstrapValidator').resetForm();
	$("#codeParam_edit").val(id);
	$("#oldCodeParam_edit").val(id);
	$("#oldNameParam_edit").val($("#name_"+id).text().trim());
	$("#nameParam_edit").val($("#name_"+id).text().trim());
	if($("#isEnable_"+id).attr("status")=="0"){
		$("input[name=isEnableParam_edit]:eq(1)").get(0).checked=true;
	}else{
		$("input[name=isEnableParam_edit]:eq(0)").get(0).checked=true;
	}
	$("#editDiv").show();
}
function zTreeBeforeCheck(treeId, treeNode){
	for(var i in oldZtree){
		if(oldZtree[i].id==treeNode.id){
			return false;
		}
	}
	return true;
}
//显示设置支付介质页面
function showSetMediumDiv(id){
	var url=__ctxPath+"/wfjpay/paySystem/findAllMediumList";
	$("#numberParam_set").val(id);
	var param={
			id:id
	}
	$.post(url,param,function(data){
		if(data.success==true){
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
			oldZtree=[];
			for(var i in zNodes){
				if(zNodes[i].checked){
					oldZtree.push(zNodes[i]);
				}
			}
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			$("#setPayMediumDiv").show();
		}
	},"json");
	
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
//关闭设置支付介质
function closeSetMediumDiv(){
	$("#setPayMediumDiv").hide();
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
						message : '门店名称不能为空'
					},
					regexp : {
						regexp : /^.{1,10}$/,
						message : '门店名称不能大于10位'
					}
				}
			},
			code: {
				validators : {
					notEmpty : {
						message : '门店编码不能为空'
					},
					regexp : {
						regexp : /^[0-9a-zA-Z]{1,10}$/,
						message : '门店编码只能为数字和字母且不大于10位'
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
						message : '门店名称不能为空'
					},
					regexp : {
						regexp : /^.{1,128}$/,
						message : '门店名称不能大于10位'
					}
				}
			},
			code: {
				validators : {
					notEmpty : {
						message : '门店编码不能为空'
					},
					regexp : {
						regexp : /^[0-9a-zA-z]{1,10}$/,
						message : '门店编码只能为数字和字母且不大于10位'
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
					$('#addForm').data('bootstrapValidator')
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
                                <h5 class="widget-caption">门店支付介质维护</h5>
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
                                				<label class="titname">门店名称：</label>
                                				<input type="text" id="name_input" />
                               				</li>
                            				<li class="col-md-4">
                            					<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
											</li>
											<li class="col-md-4" >
												<a onclick="showAddDiv();" class="btn btn-primary" style="float:right;margin-right:20px;width:100px;" > <i class="fa fa-plus"></i>新建</a>&nbsp;&nbsp;&nbsp;&nbsp;
											</li>
                                		</ul>
                                	<!--查询表单-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
										<input type="hidden" id="name_form" name="name"/>
                                  	</form>
                                  	<!--参数表单，添加或修改用-->
                                  	<form id="data_form" action="">
                                  		<input type="hidden" id="oldNameParam_form" name="oldName"/>
                                  		<input type="hidden" id="codeParam_form" name="code"/>
                                  		<input type="hidden" id="oldCodeParam_form" name="oldCode"/>
										<input type="hidden" id="nameParam_form" name="name"/>
										<input type="hidden" id="isEnableParam_form" name="isEnable"/>
									</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%; min-height:400px; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="2%" style="text-align: center;min-width:100px;">门店编码</th>
                                            <th width="3%" style="text-align: center;min-width:150px;">门店名称</th>
                                            <th width="3%" style="text-align: center;min-width:160px;">是否启用</th>
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
											<!--门店编码-->	
											<td align="center" id="code_{$T.Result.id}">
												{$T.Result.id}
											</td>
											<!--门店名称-->
											<td align="center" id="name_{$T.Result.id}">
												{#if $T.Result.name != '[object Object]'}{$T.Result.name}
												{#/if}
											</td>
											<!--是否启用-->
											<td align="center" id="isEnable_{$T.Result.id}" status='{#if $T.Result.isEnable!= "[object Object]"}{$T.Result.isEnable}{#/if}'>
												{#if $T.Result.isEnable!= '[object Object]'&&$T.Result.isEnable=='1' }是
				                   				{#/if}
												{#if $T.Result.isEnable!= '[object Object]'&&$T.Result.isEnable=='0' }否
				                   				{#/if}
											</td>
											<!--操作-->
											<td align="center" >
												<a class="btn btn-default purple btn-sm fa fa-edit" onclick="showEditDiv('{$T.Result.id}');"> 修改</a>
												<a class="btn btn-default purple btn-sm fa fa-cog" onclick="showSetMediumDiv('{$T.Result.id}')"> 设置支付介质</a>
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
				<span class="widget-caption">添加</span>
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="document.getElementById('addDiv').style.display='none';" style="margin-right:10px;">×</button>
			</div>
			<form  id="addForm" method="post" class="form-horizontal" enctype="multipart/form-data">  
			    <div class="widget-body" >
				    <div class="form-group" >
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">门店编码：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="codeParam_add" name="code" placeholder="必填"/>
							</div>											
						</div>
					</div>
					<div class="form-group" >
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">门店名称：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="nameParam_add" name="name" placeholder="必填"/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">状态：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<div class="radio" style="width:200px;">
									<label>
										<input class="basic" type="radio" checked="checked" name="isEnableParam_add" value="1"/>
										<span class="text">启用</span>
									</label>
									<label >
										<input class="basic" type="radio" name="isEnableParam_add" value="0"/>
										<span class="text">未启用</span>
									</label>
								</div>
								<div class="radio" style="display: none;">
									<label> <input class="inverted" type="radio"
										name="isEnableParam_add"> <span class="text"></span>
									</label>
							</div>
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
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">门店编码：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="codeParam_edit" name="code" placeholder="必填" readonly="readonly"/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">门店名称：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="nameParam_edit" name="name" placeholder="必填"/>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">状态：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<div class="radio" id="status_edit" style="width:200px;">
									<label>
										<input class="basic" type="radio"  name="isEnableParam_edit" value="1"/>
										<span class="text">启用</span>
									</label>
									<label>
										<input class="basic" type="radio"  name="isEnableParam_edit" value="0"/>
										<span class="text">未启用</span>
									</label>
								</div>
								<div class="radio" style="display: none;">
									<label> <input class="inverted" type="radio"
										name="isEnableParam_edit"> <span class="text"></span>
									</label>
								</div>
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
	    </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div> 
<!--设置支付介质-->
<div class="modal modal-darkorange" id="setPayMediumDiv">
	<div class="modal-dialog" style="width: 350px;height:30%;margin: 5% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">设置支付介质</span>
				<div class="widget-buttons">
					<a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square-o" id="open1" style="font-size:20px;"></i>
	            	</a>
	            	<a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square"  style="font-size:20px;" id="open2"></i>
	            	</a>
	            	<a href="#" data-toggle="collapse" onclick="document.getElementById('setPayMediumDiv').style.display='none';" style="margin-right:10px;">
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
	        	<button class="btn btn-success" style="width: 100px;" id="saveSet" type="submit"  onclick="saveSetMedium();">保存</button>&emsp;&emsp;
	        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('setPayMediumDiv').style.display='none';"/>
	        	<input class="btn btn-danger" style="display:none" id="editReset" type="reset" value="取消""/>
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
<SCRIPT type="text/javascript">
<!--
var setting = {
	check: {
		enable: true,
		chkboxType:{ "Y" : "p", "N" : "s" }
	},
	data: {
		simpleData: {
			enable: true
		}
	}
};
var zNodes =[
];

$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
});
//-->
</SCRIPT>
</body>
</html>