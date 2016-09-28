<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/validation/bootstrapValidator.js"></script>
<link
	href="${pageContext.request.contextPath}/js/bootstrap/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.js"
	charset="UTF-8"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.min.js"
	charset="UTF-8"></script>
<script
	src="${pageContext.request.contextPath}/js/bootstrap/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript"src="http://10.6.2.152:8081/log-analytics/wfj-log.js"></script>
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
//初始化参数


//页面加载完成后自动执行
$(function() {
    initOlv();
});



//设置表单数据
function setFormData(){
	$("#productName_form").val($("#productName_input").val());
	
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
	//alert("进入该方法");
	//请求地址
	var url = __ctxPath+"/wfjpay/selectMerchant";
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
         ajaxStart: function() {
           ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
         },
         //请求结束函数
         ajaxStop: function() {
           //隐藏加载提示
           setTimeout(function() {
             ZENG.msgbox.hide();
           }, 300);
         },
         //回调
         callback: function(data) {
        	 userName = data.userName ;
     		 logJs = data.logJs;
     		 reloadjs();
     		sendParameter();
    		LA.log('merchant-query', '签约商户管理查询', userName, sessionId);
    		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
         }
       }
     });
}	
	

	
//修改商户
function editMerchant(id){
	sendParameter();
	LA.log('merchant-showModifyWindow', '签约商户管理修改签约商户窗口打开', userName, sessionId);
	$("#merchant_id").val(id);
	$("#qianyue_shanghuName").val($("#shanghuName_"+ id).html().trim());
	$("#qianyueshanghu_Code").val($("#shanghuCode_" + id).html().trim());
	$("#qianyueshanghu_feeCostRate").val($("#shanghuFee_" + id).html().trim()); 
	$("#editLabelDiv").show();
	
	
	
}
//隐藏修改div
function closeMerchant(){
	$("#editLabelDiv").hide();
	$("#qianyueshanghu_Code").show();
}

//修改提交
	$('#editForm')
			.bootstrapValidator(
					{
						message : 'This value is not valid',
						feedbackIcons : {
							valid : 'glyphicon glyphicon-ok',
							invalid : 'glyphicon glyphicon-remove',
							validating : 'glyphicon glyphicon-refresh'
						},
						submitHandler : function(validator, form, submitButton) {
							sendParameter();
							LA.log('merchant-Modify', '修改签约商户', userName, sessionId);
							var url =__ctxPath+"/wfjpay/updateMerchant"
							$
									.ajax({
										type : "post",
										contentType : "application/x-www-form-urlencoded;charset=utf-8",
										url : url,
										dataType : "json",
										ajaxStart : function() {
											$("#loading-container").attr(
													"class",
													"loading-container");
										},
										ajaxStop : function() {
											//隐藏加载提示
											setTimeout(
													function() {
														$("#loading-container")
																.addClass(
																		"loading-inactive")
													}, 300);
										},
										data : $("#editForm").serialize(),
										success : function(response) {
								if (response.success == "true") {
									$("#modal-body-success")
											.html(
											"<div class='alert alert-success fade in'><strong>修改成功，返回列表页!</strong></div>");
									$("#modal-success")
											.attr(
											{
												"style" : "display:block;z-index:9999",
												"aria-hidden" : "false",
												"class" : "modal modal-message modal-success"
											});
									$("#editLabelDiv").hide();

								} else if (response.success == "false") {
									$("#model-body-warning")
											.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
											+ response.messages
											+ "</strong></div>");
									$("#modal-warning")
											.attr(
											{
												"style" : "display:block;z-index:9999",
												"aria-hidden" : "false",
												"class" : "modal modal-message modal-warning"
											});
								}
								return;
							},
							/* error : function() {
							 $("#model-body-warning")
							 .html(
							 "<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
							 $("#modal-warning")
							 .attr(
							 {
							 "style" : "display:block;z-index:9999",
							 "aria-hidden" : "false",
							 "class" : "modal modal-message modal-error"
							 });
							 } */
							error : function(XMLHttpRequest, textStatus) {
								var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
								if(sstatus != "sessionOut"){
									$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
									$("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-error"});
								}
								if(sstatus=="sessionOut"){
									$("#warning3").css('display','block');
								}
							}

						});
							

						}
					}).find('button[data-toggle]').on(
					'click',
					function() {
						var $target = $($(this).attr('data-toggle'));
						$target.toggle();
						if (!$target.is(':visible')) {
							$('#editForm').data('bootstrapValidator')
									.disableSubmitButtons(false);
						}
						
					}
					);

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
 //添加商户管理
function addMerchant(){
	sendParameter();
	LA.log('merchant-showAddMerchant', '添加签约商户页面打开', userName, sessionId);
	var url = __ctxPath+"/jsp/pay/merchant/addMerchant.jsp";
	$("#pageBody").load(url);
	 
	 
	 
 }
 


function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	//$("#pageBody").load(__ctxPath+"/jsp/pay/merchart/list.jsp");
	 initOlv();
}
function attrChange(value){
		 if(value=="1"){
			neibuMerchant();
			$("#option_merchant").show();
			 $("#input_merchant").hide();
			 $("#qianyueshanghu_Code").hide();
		 }
		 else if(value=="2"){
			 $("#qianyueshanghu_Code").hide();
			$("#option_merchant").hide();
			 $("#input_merchant").show();
			 
		 }

	 }

function  neibuMerchant(){
		$.ajax({
        type:"post",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        url:__ctxPath + "/wfjpay/paySystem/findAllListNoParam",
        dataType: "json",
        success:function(response) {
        	if(response.success == 'true'){
        		  var html=" ";
    		        var arr=response.list;
    		        for(var i=0;i<arr.length;i++){
  					html+="<option value='"+arr[i].id+"'>"+arr[i].id+"</option>";	
  				}
  				$("#bpId_input").html(html);
    		        
			}else{
				alert("请求失败");
			
			}
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
                                <h5 class="widget-caption">签约商户管理</h5>
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
                                			<li class="col-md-8">
                                				<label class="titname">商户名称：</label>
                                				<input type="text" id="productName_input"/>
                                				&nbsp;&nbsp;&nbsp;&nbsp;
                                				<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
                                			</li>
                               				
                            				
												<li class="col-md-4">
                            					<a class="btn btn-default shiny" onclick="addMerchant();">添加签约商户</a>&nbsp;&nbsp;
												<!-- <a class="btn btn-yellow" onclick="excelOrder();">导出Excel</a> -->
											</li>
                                		</ul>
                                	<!--隐藏参数-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
										<input type="hidden" id="productName_form" name="name"/>
                                  	</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%; height:0%; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="3%" style="text-align: center;">商户ID</th>
                                            <th width="3%" style="text-align: center;">商户名称</th>
                                            <th width="3%" style="text-align: center;">商户编码</th>
                                            <th width="3%" style="text-align: center;">商户费率（%）</th>
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
							<!--默认隐藏-->
							<p style="display:none">
								<textarea id="olv-list" rows="0" cols="0">
								{#template MAIN}
									{#foreach $T.list as Result}
									<tr class="gradeX" id="merchant_tr" onclick="" style="height:35px;"  value="{$T.Result.id}">
										    <td align="center" id="shuanghuId_{$T.Result.id}">
												{$T.Result.id}
											</td>
											<td align="center" id="shanghuName_{$T.Result.id}">
												{#if $T.Result.name != '[object Object]'}{$T.Result.name}
				                   				{#/if}
											</td>
											<td align="center" id="shanghuCode_{$T.Result.id}">
												{#if $T.Result.merCode!= '[object Object]'}{$T.Result.merCode}
				                   				{#/if}
											</td>
											<td align="center" id="shanghuFee_{$T.Result.id}">
												{#if $T.Result.feeCostRate!= '[object Object]'}{$T.Result.feeCostRate}
				                   				{#/if}
											</td>
											<td align="center" id=" ">
											   <input type="hidden"  id="eidtMerchant_input"  value="{$T.Result.id}">
											   <a href="javascript:editMerchant({$T.Result.id});">
														    <span class="btn btn-blue"><i class="fa fa-edit"></i>修改</span>
														</a>
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
 
	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;" 
		id="editLabelDiv">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeMerchant();">×</button>
					<h4 class="modal-title" id="divTitle">修改签约商户</h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<div class="row">
						<form method="post" class="form-horizontal" id="editForm">
							<div class="col-xs-12 col-md-12">
								<input type="hidden" name="id" id="merchant_id">
									<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">签约商户名称：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" name="name"
											id="qianyue_shanghuName" />
									</div>
									<br>&nbsp;
									</div>
									
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">签约商户费率：</label>
										<div class="col-md-6">
										<input type="text" class="form-control" name="feeCostRate"
											id="qianyueshanghu_feeCostRate" />
									</div>
									<br>&nbsp;
								</div>
								
								<div class="col-md-12" id="" style="padding: 10px 100px;" id="old_input">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">签约商户编码：</label>
									<div class="col-md-6">
										<input type="text" class="form-control" 
											id="qianyueshanghu_Code" readonly="readonly"/>
									</div>
									<br>&nbsp;
								   </div>
								   
							 <div class="col-md-12"  style="padding: 10px 100px;">
							<label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">请选择商户编码修改方式：</label>
							<div class="radio">
								<label> <input class="basic divtype cart_flag" type="radio"
									id="merchantType_0" name="merchantType" value="1" onclick="attrChange(this.value)"> <span
									class="text">内部修改</span>
								</label> 
								<label> <input class="basic divtype cart_flag" type="radio"
									id="merchantType_1" name="merchantType" value="2" onclick="attrChange(this.value)"> <span
									class="text">外部修改</span>
								</label> 		
							</div>
							</div>
							
							<div class="col-md-12"  style="display:none"  id="option_merchant">
								
																
									  <label class="col-md-5 control-label"  style="line-height: 20px; text-align: right;">内部请选择</label>
									  <div class="col-lg-6">
									  <ul class="topList clearfix">
									  <li class="col-md-2">
											<select id="bpId_input" style="padding: 0 0;" name="merCode">										
										</select>
									  </li>
								</ul>
								</div>
							</div>
							
															
							<div class="col-md-12"  style="display:none"  id="input_merchant">
							   <label class="col-md-5 control-label" style="line-height: 20px; text-align: right;">外部请填写</label>
							   <div class="col-lg-6">
								<input type="text" class="form-control" id="text_merchant" name="merCode" placeholder="必填"/>
								</div>
								
							</div>
							<div class="radio" style="display: none;">
								<label> <input class="inverted" type="radio"
									name="merchantType"> <span class="text"></span>
								</label>
							</div>
						
								   
							</div>
							<br>&nbsp;
							<div class="form-group">
								<div class="col-lg-offset-4 col-lg-6">
									<button class="btn btn-success" style="width: 25%;" id="edit"
										type="submit">保存</button>
									&emsp;&emsp; <input class="btn btn-danger"
										onclick="closeMerchant();" style="width: 25%;" id="close"
										type="button" value="取消" />								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
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