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
//初始化参数

//页面加载完成后自动执行
$(function() {
	//根据渠道账户查询渠道下的费率列表
	queryChannelFeeRateByPartner();
	bind();
});

//验证添加或修改参数
function validate(type){
	var rateType=$("#rateType_"+type).val();
	var feeCostRate=$("#feeCostRate_"+type).val();
	var flag=true;
	if(rateType==null||rateType.trim()==""){
		$("#rateTypeErrorMsg_"+type).text("*请选择一个费率类型！");
		$("#rateTypeErrorMsg_"+type).css("visibility","visible");
		flag=false;
	}
	
	var rateFormat=/^((\d{1,2}\.\d{1,2})|(\.?\d{1,2}))$/
	if(feeCostRate==null||feeCostRate.trim()==""){
		$("#feeCostRateErrorMsg_"+type).text("*请输入费率！");
		$("#feeCostRateErrorMsg_"+type).css("visibility","visible");
		flag=false;
	}else if(!rateFormat.test(feeCostRate.trim())){
		$("#feeCostRateErrorMsg_"+type).text("*请输入正确的费率，且整数位或者小数位不能大于两位！");
		$("#feeCostRateErrorMsg_"+type).css("visibility","visible");
		flag=false;
	}
	return flag;
}

//绑定事件
function bind(){
	$("#add").click(function(){
		add();
	});
	
	$("#update").click(function(){
		update();
	});
	
	$("#rateType_add").focus(function(){
		$("#rateTypeErrorMsg_add").css("visibility","hidden");
	});
	
	$("#feeCostRate_add").focus(function(){
		$("#feeCostRateErrorMsg_add").css("visibility","hidden");
	});
	
	$("#rateType_edit").focus(function(){
		$("#rateTypeErrorMsg_edit").css("visibility","hidden");
	});
	
	$("#feeCostRate_edit").focus(function(){
		$("#feeCostRateErrorMsg_edit").css("visibility","hidden");
	});
	
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
		$("#id_paramForm").val($("#id_"+type).val());
	}
	$("#rateType_paramForm").val($("#rateType_"+type).val());
	$("#feeCostRate_paramForm").val($("#feeCostRate_"+type).val());
}

//查询渠道账号下的渠道费率
function queryChannelFeeRateByPartner(){
	var url=__ctxPath+"/wfjpay/selectChannelFeeRateList";
	var param={"payPartner":"${param.payPartner}","payType":"${param.payType}"};
	$.post(url,param,function(data){
		if(data.success==true){
			var list=data.list;
			var html="";
			for(var i in list){
				html+="<tr class='gradeX' id='gradeX"+list[i].id+"' style='height:35px;'>";
				html+="<td align='center' id='rateType_"+list[i].id+"'>"+list[i].rateType+"</td>";
				html+="<td align='center' id='rateTypeName_"+list[i].id+"'>"+list[i].rateTypeName+"</td>";
				html+="<td align='center' id='feeCostRate_"+list[i].id+"'>"+list[i].feeCostRate+"</td>";
				html+="<td align='center' >";
				html+="<a class='btn btn-default purple btn-sm fa fa-edit' onclick='showEditDiv("+list[i].id+");'>修改</a>";
				html+="</td>;";
				html+="</tr>";
			}
			$("#feeRateList").html(html);
		}else{
		}
	},"json");
}


//添加渠道费率
function add(){
	if(!validate("add")){
		return;
	}
	var url=__ctxPath+"/wfjpay/addChannelFeeRate";
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

//修改渠道费率
function update(){
	if(!validate("edit")){
		return;
	}
	var url=__ctxPath+"/wfjpay/updateChannelFeeRate";
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

//查询渠道费率类型
function selectChannelFeeRateType(type){
	var url=__ctxPath+"/wfjpay/selectChannelFeeRateType";
	var param={"payType":"${param.payType}"};
	$.post(url,param,function(data){
		var option="";
		if(data.success){
			for(var i in data.list){
				option+="<option value='"+data.list[i].rateType+"'>"+data.list[i].rateTypeName+"</option>";
			}
			$("#rateType_"+type).html(option);
			if(type=="edit"){
				$("#rateType_edit").val($("#rateTypeOld_edit").val());
			}
		}
	},"json");
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
	resetInputForm("add");
	selectChannelFeeRateType('add');
	$("#addDiv").show();
}

//显示修改窗口
function showEditDiv(id){
	resetInputForm("edit");
	selectChannelFeeRateType("edit");
	$("#feeCostRate_edit").val($("#feeCostRate_"+id).text().trim());
	$("#id_edit").val(id);
	$("#rateTypeOld_edit").val($("#rateType_"+id).text().trim());
	$("#editDiv").show();
}

//返回
function backUpPage(){
	var url = __ctxPath + "/jsp/pay/channelAccount/list.jsp";
	$("#pageBody").load(url);
}

//关闭添加面板
function closeAddDiv(){
	$("#addDiv").hide();
	queryChannelFeeRateByPartner();
}

//关闭修改面板
function closeEditDiv(){
	$("#editDiv").hide();
	queryChannelFeeRateByPartner();
}

//重置添加或修改表单
function resetInputForm(type){
	$("#feeCostRate_"+type).val("");
	$("#feeCostRateErrorMsg_"+type).css("visibility","hidden");
	$("#rateTypeErrorMsg_"+type).css("visibility","hidden");
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
                                <h5 class="widget-caption">渠道费率设置</h5>
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
	                                		<li class="col-md-4" style="display:none;">
		                        				<label class="titname">payType：</label>
		                        				<input type="text" id="payType_input" readonly="readonly" value="${param.payType}"/>
		                       				</li>
	                                		<li class="col-md-4">
		                        				<label class="titname">类型：</label>
		                        				<input type="text" id="payTypeName_input" readonly="readonly" value="${param.payTypeName}"/>
		                       				</li>
                                			<li class="col-md-4">
                                				<label class="titname">商户ID：</label>
                                				<input type="text" id="partnerId_input" readonly="readonly" value="${param.partnerId}"/>
                               				</li>
                            				<li class="col-md-4">
                            					<a onclick="showAddDiv();" id="addButton" class="btn btn-primary" style="float:right;margin-right:20px;width:100px;" > <i class="fa fa-plus"></i>新建</a>&nbsp;&nbsp;&nbsp;&nbsp;
											</li>
                                		</ul>
                                  	<!--参数表单，添加或修改用-->
                                  	<form id="data_form" action="">
                                  		<input type="hidden" id="id_paramForm" name="id"/>
                                  		<input type="hidden" id="rateType_paramForm" name="rateType"/>
										<input type="hidden" id="feeCostRate_paramForm" name="feeCostRate"/>
										<input type="hidden" id="payPartner_paramForm" name="payPartner" value="${param.payPartner}"/>
									</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%;min-height:400px; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="2%" style="text-align: center;min-width:100px;">费率类型</th>
                                            <th width="3%" style="text-align: center;min-width:150px;">费率类别名称</th>
                                            <th width="2%" style="text-align: center;min-width:180px;">费率</th>
                                            <th width="3%" style="text-align: center;min-width:160px;">操作</th>
                                        </tr>
                                    </thead>
                                    <tbody id="feeRateList">
                                    	<!--费率列表在此显示-->
                                    </tbody>
                                </table>
                                </div>
                            </div>
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
				<span class="widget-caption">添加渠道费率</span>
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="document.getElementById('addDiv').style.display='none';" style="margin-right:10px;">×</button>
			</div>
			<form  id="addForm" method="post" class="form-horizontal" enctype="multipart/form-data">  
			    <div class="widget-body" style="" >
					<div class="form-group" >
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">费率类别：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<select  class="form-control" id="rateType_add" name="rateType" placeholder="必填"/>
								<span id="rateTypeErrorMsg_add" style="visibility:hidden;color:red;">*请选择一个费率类别！</span>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">费率：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="feeCostRate_add" name="feeCostRate" placeholder="必填"/>
								<span id="feeCostRateErrorMsg_add" style="visibility:hidden;color:red;">*请输入费率！</span>
							</div>											
						</div>
					</div>
				</div><!--widget-bodyEnd-->
					<!--保存和取消-->
		        <div class="modal-footer" style="text-align:center;">
		        	<button class="btn btn-success" style="width: 100px;" id="add" type="button">保存</button>&emsp;&emsp;
		        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('addDiv').style.display='none';"/>
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
				<span class="widget-caption">修改渠道费率</span>
				<button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="document.getElementById('editDiv').style.display='none';" style="margin-right:10px;">×</button>
			</div>
			<form id="editForm" method="post" class="form-horizontal" enctype="multipart/form-data">        
			    <div class="widget-body">
					<input type="hidden" id="id_edit" value=""/>
					<input type="hidden" id="rateTypeOld_edit" value=""/>
					<div class="form-group" >
						<div class=" ">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">费率类别：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<select class="form-control" id="rateType_edit" name="rateType" placeholder="必填" />
								<span id="rateTypeErrorMsg_edit" style="visibility:hidden;color:red;">*请选择一个费率类别！</span>
							</div>											
						</div>
					</div>
					<div class="form-group">
						<div class="">
							<label class="col-lg-5 col-sm-5 col-xs-5 control-label">费率：</label>
							<div class="col-lg-6 col-sm-6 col-xs-6">
								<input type="text" class="form-control" id="feeCostRate_edit" name="feeCostRate" placeholder="必填"/>
								<span id="feeCostRateErrorMsg_edit" style="visibility:hidden;color:red;">*请输入费率！</span>
							</div>											
						</div>
					</div>
				</div><!--widget-bodyEnd-->
				<!--修改保存/取消-->
		        <div class="modal-footer" style="text-align:center;">
		        	<button class="btn btn-success" style="width: 100px;" id="update" type="button">保存</button>&emsp;&emsp;
		        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('editDiv').style.display='none';"/>
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