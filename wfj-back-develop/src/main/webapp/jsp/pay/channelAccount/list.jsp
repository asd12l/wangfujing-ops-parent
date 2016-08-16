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
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/js/jquery.ztree.excheck-3.5.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ztree/css/zTreeStyle.css" type="text/css">
<script type="text/javascript">

//上下文路径
__ctxPath = "${pageContext.request.contextPath}";

//页码
var olvPagination;
//初始化参数
var treeObj;
var payCode;
var treeObjCre;
var payCodeCre;
//页面加载完成后自动执行
$(function() {
	initOlv();  
	 bind();//建立ztree
	 channelType();
});

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

//设置表单数据
function setFormData(){
	$("#channelPayType_form").val($("#channelPayType_input").val());
	
	}
//设置下拉框为只读




//查询数据
function olvQuery(){
	//alert("jinrufiafangfa");
	//设置表单数据
/* 	setFormData();
	//生成表单请求参数
    var params = $("#olv_form").serialize();
    params = decodeURI(params);
    //根据参数读取数据
    olvPagination.onLoad(params); */
    initOlv();
	}

//初始化函数
	function initOlv() {
	//请求地址
	var url = __ctxPath+"/wfjpay/selectPayPartnerAccount";
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
        
        	 for(var i in data.list){
        		 
    			 data.list[i ].createDate=formatDate(data.list[i].createDate);
    			 
    			 var pay_TypeText=data.list[i].payType;
    			 switch(pay_TypeText){
    				 case "ALIPAY" :
    				 	data.list[i].payType="支付宝";
    				 	data.list[i].payTypeCode="ALIPAY";
    					 break;
    				 case "TENPAY":
    				 	data.list[i].payType="财付通";
    				 	data.list[i].payTypeCode="TENPAY";
    					 break;
    				 case "NETPAY":
    				 	data.list[i].payType="银联";
    				 	data.list[i].payTypeCode="NETPAY";
    				 	 break;
    				 case "ICBCPAY":
        				 data.list[i].payType="工商银行";
        				 data.list[i].payTypeCode="ICBCPAY";
        				 break;
    				 case "CMBPAY":
        				 data.list[i].payType="招商银行";
        				 data.list[i].payTypeCode="CMBPAY";
        				 break;
    				 case "CGBPAY":
        				 data.list[i].payType="广发银行";
        				 data.list[i].payTypeCode="CGBPAY";
        				 break;
    				 case "WECHATPAY":
        				 data.list[i].payType="微信";
        				 data.list[i].payTypeCode="WECHATPAY";
        				 break;
    				 case "WECHATPAY_OFFLINE":
        				 data.list[i].payType="微信线下支付";
        				 data.list[i].payTypeCode="WECHATPAY_OFFLINE";
        				 break;	 
    				 case "WECHATPAY_SHB":
        				 data.list[i].payType="微信扫货邦";
        				 data.list[i].payTypeCode="WECHATPAY_SHB";
        				 break;
    				 case "ALIPAY_OFFLINE":
        				 data.list[i].payType="支付宝线下支付";
        				 data.list[i].payTypeCode="ALIPAY_OFFLINE";
        				 break;
    				 case "NETPAY_MOBILE":
    					 data.list[i].payType="银联手机支付";
        				 data.list[i].payTypeCode="NETPAY_MOBILE";
        				 break;
    				 case "TENPAY_MOBILE":
    					 data.list[i].payType="财付通手机支付";
        				 data.list[i].payTypeCode="TENPAY_MOBILE";
        				 break;
    				 case "WECHATPAY_MOBILE":
    					 data.list[i].payType="微信手机支付";
        				 data.list[i].payTypeCode="WECHATPAY_MOBILE";
        				 break;
    				 case "ALIPAY_MOBILE":
    					 data.list[i].payType="支付宝手机支付";
        				 data.list[i].payTypeCode="ALIPAY_MOBILE";
        				 break;
        				 
        				 
    				
    			};
    			
    		 }
    		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
         }
       }
     });
}	
	

	
//修改商户
function editChannelAccount(id){
	if($("#channelAccount_id").val(id)==null){
		alert("请选择要修改的商户");
	}
	$("#channelAccount_id").val(id);
	$("#payType_"+ id).html().trim();
	//$("#channelAccount_payType").val($("#payType_"+ id).html().trim());
	var tdVal=$("#payTypeval_input_"+ id).val().trim();
	var tdVAlue;
	 switch(tdVal){
	 case "支付宝":
		 tdVAlue="ALIPAY";
		 break;
	 case "财付通":
		 tdVAlue="TENPAY";
		 break;
	 case "银联":
		 tdVAlue="NETPAY";
	 	 break;
	 case "工商银行":
		 tdVAlue="ICBCPAY";
		 break;
	 case "招商银行":
		 tdVAlue="CMBPAY";
		 break;
	 case "广发银行":
		 tdVAlue="CGBPAY";
		 break;
	 case "微信":
		 tdVAlue="WECHATPAY";
		 break;	
	 case "微信扫货邦":
		 tdVAlue="WECHATPAY_SHB";
		 break;	
	 case "支付宝线下":
		 tdVAlue="ALIPAY_OFFLINE";
		 break;	
	 case "支付宝WAP":
		 tdVAlue="ALIPAY_MOBILE";
		 break;	
	 case "微信WAP":
		 tdVAlue="WECHATPAY_MOBILE";
		 break;	
				 
		
}
	
	$("#channelAccount_payType").val(tdVAlue);
	$("#channelPayTypeform_input").val($("#payType_"+ id).text().trim());
	$("#qudao_Code").val($("#partner_"+ id).html().trim());
	$("#paydium_Code").val($("#paymedium_"+ id).html().trim());
	$("#qundao_feeCostRate").val($("#qudaoFee_"+ id).html().trim());
	$("#miyao_key").val($("#miyaoinput_key_"+id).val().trim());
	$("#miyao_path").val($("#miyaoinput_path_"+id).val().trim());
	$("#salser_email").val($("#salser_input_"+id).val().trim());
	$("#branchId_Code").val($("#branchid_input_"+id).val().trim());
	$("#payMediumCode_Cre").val($("#paymediumcodecre_input_"+id).val().trim());
	$("#app_Id").val($("#appid_input_"+id).val().trim());
     //$("#qianyueshanghu_feeCostRate").val($("#shanghuFee_" + id).html().trim()); 
	$("#public_key").val($("#publicKey_"+id).text().trim());
	$("#private_key").val($("#privateKey_"+id).text().trim());
	$("#editLabelDiv").show();
	
	
	
}
//隐藏修改div
function closeMerchant(){
	$("#editLabelDiv").hide();
}

//提交
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
							var url =__ctxPath+"/wfjpay/updatechannelPartnerAccount"
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
function addChannelAccount(){
	var url = __ctxPath+"/jsp/pay/channelAccount/addChannelAccount.jsp";
	$("#pageBody").load(url);
	 
	 
	 
 }
 


function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	//$("#pageBody").load(__ctxPath+"/jsp/pay/merchart/list.jsp");
	 initOlv();
}
function  bind(){
	/*  $("#open1").click(function(){
		 //初始化树插件
		 var obj=$.fn.zTree.getZTreeObj("treeDemo");
		 //获取所有被选中的节点
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
	 }) */
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
		
		 $("#open3").click(function(){
			var obj=$.fn.zTree.getZTreeObj("treeDemoCre");
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

//设置支付介质
function showSetMediumDiv(){
		var url=__ctxPath+"/wfjpay/findAllMediumListNoParam";
		$.post(url,function(data){
			if(data.success==true){
				var setting = {
						check: {
							enable: true,
							chkStyle: "radio",
							chkboxType:{ "Y" : "p", "N" : "s" }
						},
						data: {
							simpleData: {
								enable: true
							}
						}
						/* callback: {
							beforeCheck: zTreeBeforeCheck
						} */
					};
				var zNodes=data.list;
				/* oldZtree=[];
				for(var i in zNodes){
					if(zNodes[i].checked){
						oldZtree.push(zNodes[i]);
					}
				} */
				treeObj=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				$("#setPayMediumDiv").show();
			}
		},"json");
		
	}
	
	
//设置支付介质
function showSetMediumDivCre(){
		var url=__ctxPath+"/wfjpay/findAllMediumListNoParam";
		$.post(url,function(data){
			if(data.success==true){
				var setting = {
						check: {
							enable: true,
							chkStyle: "radio",
							chkboxType:{ "Y" : "p", "N" : "s" }
						},
						data: {
							simpleData: {
								enable: true
							}
						}
						/* callback: {
							beforeCheck: zTreeBeforeCheck
						} */
					};
				var zNodes=data.list;
				/* oldZtree=[];
				for(var i in zNodes){
					if(zNodes[i].checked){
						oldZtree.push(zNodes[i]);
					}
				} */
				treeObjCre=$.fn.zTree.init($("#treeDemoCre"), setting, zNodes);
				$("#setPayMediumCreDiv").show();
			}
		},"json");
		
	}
	
function saveSetMedium(){
  	
		var nodes=treeObj.getNodes();
		var arr=treeObj.transformToArray(nodes);
		for(var i=0;i<arr.length;i++){
			if(arr[i].checked){
		
			payCode=arr[i].id;
			}
			
		} 
		$("#paydium_Code").val(payCode);
		closeSetMediumDiv();
}

function saveSetMediumCre(){
  	
	var nodes=treeObjCre.getNodes();
	var arr=treeObjCre.transformToArray(nodes);
	for(var i=0;i<arr.length;i++){
		if(arr[i].checked){
	
			payCodeCre=arr[i].id;
		}
		
	} 
	$("#payMediumCode_Cre").val(payCodeCre);
	closeSetMediumCreDiv();
}
	
//关闭设置支付介质
	function closeSetMediumDiv(){
		$("#setPayMediumDiv").hide();
	}
	
	//关闭设置支付介质
	function closeSetMediumCreDiv(){
		$("#setPayMediumCreDiv").hide();
	}
	//设置费率
	function setFeeRate(id){
		//商户ID
		var partnerId=$("#partner_"+id).text().trim();
		var payTypeName=$("#payType_"+id).text().trim();
		var payType=$("#payTypeCode_"+id).text().trim();
		var url = __ctxPath + "/jsp/pay/channelAccount/setFeeRate.jsp";
		$("#pageBody").load(url,{"partnerId":partnerId,"payTypeName":payTypeName,"payPartner":id,"payType":payType});
	}
	
	function channelType(){
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
					$("#channelPayType_input").html("<option value=''>全部渠道</option>"+option);
				}
			},
			error:function(){
				alert("获取渠道类型失败！");
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
                                <h5 class="widget-caption">支付渠道账号</h5>
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
                                				<label class="titname">渠道类型：</label>
                                			<select id="channelPayType_input" style="padding: 0 0;">
												<option value=" ">全部渠道</option>
												
										    </select>
                                				&nbsp;&nbsp;&nbsp;&nbsp;
                                				<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
                                			</li>
                               				
                            				
												<li class="col-md-4">
                            					<a class="btn btn-default shiny" onclick="addChannelAccount();">新建渠道号</a>&nbsp;&nbsp;
												<!-- <a class="btn btn-yellow" onclick="excelOrder();">导出Excel</a> -->
											   </li>
                                		</ul>
                                	<!--隐藏参数-->
                           			<form id="olv_form" action="">
										<input type="hidden" id="pageSize_form" name="pageSize" value="10"/>
										<input type="hidden" id="channelPayType_form" name="payType"/>
                                  	</form>
                                <!--数据列表显示区域-->
                            	<div style="width:100%; height:0%; overflow-Y: hidden;">
                                <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 100%;background-color: #fff;margin-bottom: 0;">
                                    <thead>
                                        <tr role="row" style='height:35px;'>
                                            <th width="3%" style="text-align: center;">类型</th>
                                            <th width="3%" style="text-align: center;">商户ID</th>
                                            <th width="3%" style="text-align: center;">支付介质</th>
                                            <th width="3%" style="text-align: center;display:none;">费率（%）</th>
                                            <th width="3%" style="text-align: center;">最后修改时间</th>
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
										   <td align="center" id="payType_{$T.Result.id}">
												{#if $T.Result.payType != '[object Object]'}{$T.Result.payType}
				                   				{#/if}
											</td>
										   
										    <td align="center" id="partner_{$T.Result.id}">
												{#if $T.Result.partner != '[object Object]'}{$T.Result.partner}
				                   				{#/if}
											</td>
											
											<td align="center" id="paymedium_{$T.Result.id}">
												{#if $T.Result.payMediumCode!= '[object Object]'}{$T.Result.payMediumCode}
				                   				{#/if}
											</td>
											<td align="center" id="qudaoFee_{$T.Result.id}" style="display:none;">
												{#if $T.Result.feeCostRate!= '[object Object]'}{$T.Result.feeCostRate}
				                   				{#/if}
											</td>
											<td align="center" id="createDate_{$T.Result.id}">
												{#if $T.Result.createDate!= '[object Object]'}{$T.Result.createDate}
				                   				{#/if}
											</td>
											<td align="center" id="publicKey_{$T.Result.id}" style="display:none;">
												{#if $T.Result.publicKey!= '[object Object]'}{$T.Result.publicKey}
				                   				{#/if}
											</td>
											<td align="center" id="privateKey_{$T.Result.id}" style="display:none;">
												{#if $T.Result.privateKey!= '[object Object]'}{$T.Result.privateKey}
				                   				{#/if}
											</td>
											<td align="center" id=" ">
											   <input type="hidden"  id="eidtMerchant_input_{$T.Result.id}"  value="{$T.Result.id}">
											   <input type="hidden"  id="payTypeval_input_{$T.Result.id}"  value="{#if $T.Result.payType!= '[object Object]'}{$T.Result.payType}
				                   				{#/if}">
											   <input type="hidden"  id="miyaoinput_key_{$T.Result.id}"   value="{#if $T.Result.encryptKey!= '[object Object]'}{$T.Result.encryptKey}
				                   				{#/if}">
											   <input type="hidden" id="miyaoinput_path_{$T.Result.id}"   value="{#if $T.Result.keyPath!= '[object Object]'}{$T.Result.keyPath}
				                   				{#/if}">
											   <input type="hidden" id="salser_input_{$T.Result.id}"   value="{#if $T.Result.sellerEmail!= '[object Object]'}{$T.Result.sellerEmail}
				                   				{#/if}">
											   <input type="hidden" id="branchid_input_{$T.Result.id}"   value="{#if $T.Result.branchId!= '[object Object]'}{$T.Result.branchId}
				                   				{#/if}">
											   <input type="hidden" id="paymediumcodecre_input_{$T.Result.id}"   value="{#if $T.Result.payMediumCodeCredit!= '[object Object]'}{$T.Result.payMediumCodeCredit}
				                   				{#/if}">
											   <input type="hidden" id="appid_input_{$T.Result.id}"   value=" {#if $T.Result.appid!= '[object Object]'}{$T.Result.appid}
				                   				{#/if}">
											   <a href="javascript:editChannelAccount({$T.Result.id});">
											   		<span class="btn btn-blue"><i class="fa fa-edit"></i>修改</span>
											   </a>
											   <a onclick="setFeeRate({$T.Result.id});" class="btn btn-default purple btn-sm fa fa-cog"> 设置费率</a>
											</td>
											<td align="center" id="payTypeCode_{$T.Result.id}" style="display:none;">
												{#if $T.Result.payTypeCode!= '[object Object]'}{$T.Result.payTypeCode}
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
 
	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;" 
		id="editLabelDiv">
		<div class="modal-dialog"
			style="width: 1200px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeMerchant();">×</button>
					<h4 class="modal-title" id="divTitle">修改渠道号</h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<div class="row">
						<form method="post" class="form-horizontal" id="editForm">
							<div class="col-xs-12 col-md-12" style="overflow-y:scroll;height:350px;">
								<input type="hidden" name="id" id="channelAccount_id">
								<input type="hidden" name="payType" id="channelAccount_payType">
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">商户类型：</label>
									<div class="col-md-3">
										<input type="text" class="form-control" 
											id="channelPayTypeform_input"   readonly= "true"/>			
									</div>
									
										<label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">商户ID：</label>
									<div class="col-md-3">
										<input type="text" class="form-control" name="partner"
											id="qudao_Code" />
											
									</div>
									<br>&nbsp;
								</div>

								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">卖家邮箱：</label>
										<div class="col-md-3">
										<input type="text" class="form-control" name="sellerEmail"
											id="salser_email" />
									</div>
									<label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">密钥文件路径：</label>
										<div class="col-md-3">
										<input type="text" class="form-control" name="keyPath"
											id="miyao_path" />
									</div>
									
								</div>
								
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">支付介质编码：</label>
										<div class="col-md-3">
										<input type="text" class="form-control" name="payMediumCode"
											id="paydium_Code"  readonly="readonly" />
											</div>
										<div class="col-md-3" style="float:right">
										 <a class="btn btn-default purple btn-sm fa fa-cog" onclick="showSetMediumDiv()"> 设置支付介质</a>	
									</div>
									
									
								</div>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">信用卡支付介质：</label>
										<div class="col-md-3">
										<input type="text" class="form-control" name="payMediumCodeCre"
											id="payMediumCode_Cre" readonly="readonly"/>
									</div>
									<div class="col-md-3" style="float:right">
										 <a class="btn btn-default purple btn-sm fa fa-cog" onclick="showSetMediumDivCre()"> 设置支付介质</a>	
									</div>
									
									
								</div>
								
								<div class="col-md-12" id="" style="padding: 10px 100px;">
								    <label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">微信支付公众号码：</label>
										<div class="col-md-3">
										<input type="text" class="form-control" name="appid"
											id="app_Id" />
										</div>
									<label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">商户开户分行号：</label>
										<div class="col-md-3">
										<input type="text" class="form-control" name="branchId"
											id="branchId_Code" />
										</div>
								</div>
								
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">密钥：</label>
									<div class="col-md-3">
									<input type="text" class="form-control" name="encryptKey"
										id="miyao_key" />
									</div>
								</div>
								
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">支付宝公钥：</label>
									<div class="col-md-9">
										<textarea class="form-control" maxlength="1024" name="publicKey" id="public_key" style="resize:none;height:100px;"/>
										</textarea>
									</div>
								</div>
								
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-3 control-label"
										style="line-height: 20px; text-align: right;">支付宝私钥：</label>
									<div class="col-md-9">
										<textarea class="form-control" maxlength="2048" name="privateKey" id="private_key" style="resize:none;height:100px;"/>
										</textarea>
									</div>
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
	
	<div class="modal modal-darkorange" id="setPayMediumDiv">
	<div class="modal-dialog" style="width: 450px;height:30%;margin: 5% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">设置支付介质</span>
				<div class="widget-buttons">
					<!-- <a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square-o" id="open1" style="font-size:20px;"></i>
	            	</a> -->
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
	        	<input class="btn btn-danger" style="display:none" id="editReset" type="reset" value="取消"/>
	        </div>
	    </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>

<div class="modal modal-darkorange" id="setPayMediumCreDiv">
	<div class="modal-dialog" style="width: 450px;height:30%;margin: 5% auto;">
	    <div class="modal-content">
		    <div class="widget-header">
				<span class="widget-caption">设置支付介质</span>
				<div class="widget-buttons">
					<!-- <a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square-o" id="open1" style="font-size:20px;"></i>
	            	</a> -->
	            	<a href="#" data-toggle="collapse" >
	            		<i class="fa fa-plus-square"  style="font-size:20px;" id="open3"></i>
	            	</a>
	            	<a href="#" data-toggle="collapse" onclick="document.getElementById('setPayMediumCreDiv').style.display='none';" style="margin-right:10px;">
            			<i class="fa fa-times"  style="font-size:20px;" id="pro-i"></i>
            		</a>
				</div>
			</div>
			<div class="widget-body" style="">
				<form id="setPayMediumCreDiv">
					<input type="hidden" name="id" id="numberParam_set">
				</form>
				<div class="zTreeDemoBackground left" style="padding-left:20px;">
					<ul id="treeDemoCre" class="ztree" style="overflow-y:scroll;height:400px;" ></ul>
				</div>
			
			
			
			</div>
			<!--修改保存/取消-->
	        <div class="modal-footer" style="text-align:center;">
	        	<button class="btn btn-success" style="width: 100px;" id="saveSet" type="submit"  onclick="saveSetMediumCre();">保存</button>&emsp;&emsp;
	        	<input class="btn btn-danger" style="width: 100px;" id="close" type="button" value="取消" onclick="document.getElementById('setPayMediumCreDiv').style.display='none';"/>
	        	<input class="btn btn-danger" style="display:none" id="editReset" type="reset" value="取消"/>
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