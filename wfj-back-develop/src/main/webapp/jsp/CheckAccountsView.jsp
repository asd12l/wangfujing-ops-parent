<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var olvPagination;
	$(function() {
		$.ajax({url:__ctxPath + "/DataDictionary/getItemType?dictTypeCode="+51,dataType:"json",async:false,success:function(response){
    		var result = response.list;
           	 var option = "<option value=''>所有</option>";
           	 for(var i=0;i<result.length;i++){
           		 var ele = result[i];
           		 option+="<option value='"+ele.dictItemCode+"'>"+ele.dictItemName+"</option>";
           	 }
           	 $("#shopSid_select").append(option);
 		}});
		$('#reservation').daterangepicker();
	    initOlv();
	});
	function olvQuery(){
		$("#shopSid_form").val($("#shopSid_select").val());
		$("#orderType_form").val($("#orderType_select").val());
		$("#cashierNumber_form").val($("#cashierNumber_input").val());
		$("#checkStatus_form").val($("#checkStatus_select").val());
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startTime_form").val(
					$.trim(strTime[0].replace("/", "-").replace("/", "-")));
			$("#endTime_form").val(
					$.trim(strTime[1].replace("/", "-").replace("/", "-")));
		}else{
			$("#startTime_form").val("");
			$("#endTime_form").val("");
		}
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#shopSid_select").val("");
		$("#orderType_select").val("");
		$("#cashierNumber_input").val("");
		$("#checkStatus_select").val("");
		$("#reservation").val("");
		olvQuery();
	}

 	function initOlv() {
		var url = __ctxPath+"/query/queryCheckAccountsBack";
		olvPagination = $("#olvPagination").myPagination({
           panel: {
             tipInfo_on: true,
             tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
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
           ajax: {
             on: true,
             url: url,
             dataType: 'json',
             ajaxStart: function() {
               ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
             },
             ajaxStop: function() {
               //隐藏加载提示
               setTimeout(function() {
                 ZENG.msgbox.hide();
               }, 300);
             },
             callback: function(data) {
            	 //console.log(data.list);
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
    }
	
 	
 	//导出excel
	function exportExcel(){
 		
 		var sid = $("#olv-list").val().sid;
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var brandSid = $(this).val();
			checkboxArray.push(sid);
		});
 		
		var shopSid= $("#shopSid_select").val();
		var orderType=$("#orderType_select").val();
		var checkStatus = $("#checkStatus_select").val();						
		var cashierNumber = $("#cashierNumber_input").val();
		var strTime = $("#reservation").val();
		if (strTime != "") {
			strTime = strTime.split("-");
			var startTime = strTime[0].replace("/", "-").replace("/", "-");
			var	endTime= strTime[1].replace("/", "-").replace("/", "-");
		} else {
			var startTime = "";
			var	endTime= "";
		}
		endTime=$.trim(endTime);
		var title = "CheckAccounts";
		var count =  $("#olv_tab tbody tr").length;
		if($("#olv_tab tbody tr").val()!=null && count>0){
			
			if(count<=3000&&startTime!=""&&endTime!=""){
		 		window.open(__ctxPath+"/query/queryCheckAccountsForExcel?startTime="+startTime+"&&endTime="+endTime+"&&checkStatus="+checkStatus+
			 	"&&cashierNumber="+cashierNumber+
			 	"&&shopSid="+shopSid+"&&orderType="+orderType+
			 	"&&title="+title);
			}else{
				$("#model-body-warning").html("<div class='alert alert-warning fade in'>"
						+ "<i class='fa-fw fa fa-times'></i><strong>您生成的EXCEL内容较大请不要超过3000条数据!</strong></div>");
				$("#modal-warning").attr({
										"style" : "display:block;",
										"aria-hidden" : "false",
										"class" : "modal modal-message modal-warning"
									});
			}
		}else{
			$("#model-body-warning").html("<div class='alert alert-warning fade in'>"
					+ "<i class='fa-fw fa fa-times'></i><strong>不能生成空的Excel!</strong></div>");
			$("#modal-warning").attr({
									"style" : "display:block;",
									"aria-hidden" : "false",
									"class" : "modal modal-message modal-warning"
								});
		}
	}

 	
	//折叠页面
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
			}
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
        <!-- Page Container -->
        <div class="page-container">
                <!-- Page Body -->
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header ">
                                    <span class="widget-caption"><h5>对账管理</h5></span>
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
                                    	<div class="col-md-4">
                                			<div class="col-lg-5">
	                                			<span>门&nbsp;&nbsp;  店：</span>
	                                		</div>
	                                		<div class="col-lg-7">
	                                			<select id="shopSid_select" style="padding:0 0;width: 100%;"></select>&nbsp;
	                                		</div>
	                                	</div>
                                		<div class="col-md-4">
                                    		<div class="col-lg-5">
                                    			<span>订单类型：</span>
                                    		</div>
                                    		<div class="col-lg-7">
                                    		<select id="orderType_select" style="padding:0 0;width: 100%;">
		                                			<option value="">所有</option>
		                                			<option value="0">实体</option>
		                                			<option value="1">网络</option>
		                                			<option value="2">微信</option>
		                                		</select>&nbsp;
                                			</div>
                                    	</div>
                                    	<div class="col-md-4">
                                    		<div class="col-lg-5">
                                    			<span>收银流水号：</span>
                                    		</div>
                                    		<div class="col-lg-7">
                                    			<input type="text" id="cashierNumber_input" style="width: 100%;"/>
                                    		</div>&nbsp;
                                    	</div>
                                    	<div class="col-md-4">
	                                		<div class="col-lg-5">时&nbsp;&nbsp;间：</div>
	                                		<div class="col-lg-7">
                                   				<input type="text" id="reservation"  style="width: 100%;"/>
                                   			</div>
                                		</div>
                                    	<div class="col-md-4">
                                    		<div class="col-lg-5">
	                                			<span>是否平账：</span>
	                                		</div>
	                                		<div class="col-lg-7">
		                                		<select id="checkStatus_select" style="padding:0 0;width: 100%;">
		                                			<option value="">所有</option>
		                                			<option value="-1">三个平台不平账</option>
		                                			<option value="0">三个平台平账</option>
		                                			<option value="1">OMS与富基平账,与SAP不平账</option>
		                                			<option value="2">OMS与SAP平账,与富基不平账</option>
		                                			<option value="3">富基与SAP平账,与OMS不平账</option>
		                                			<option value="4">富基与SAP、OMS都不平账</option>
		                                			<option value="5">SAP与OMS平账,富基销售记录为空</option>
		                                			<option value="6">SAP与OMS不平账,富基销售记录为空</option>
		                                			<option value="7">富基与OMS平账,SAP记录为空</option>
		                                			<option value="8">富基与OMS不平账,SAP记录为空</option>
		                                			<option value="9">富基和SAP记录为空</option>
		                                			<option value="10">OMS和SAP记录为空</option>
		                                		</select>&nbsp;
		                                	</div>
                                		</div>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-12">
	                                			<a class="btn btn-yellow" onclick="olvQuery();"><i class="fa fa-eye"></i>查询</a>
	                                			<a class="btn btn-primary" onclick="reset();"><i class="fa fa-random"></i>重置</a>
	                                			<a class="btn btn-darkorange" onclick="exportExcel();"><i class="fa fa-share-alt"></i>导出EXCEL</a>
	                                		</div>&nbsp;
                                		</div>
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="15"/>
											<input type="hidden" id="shopSid_form" name="shopSid"/>
											<input type="hidden" id="orderType_form" name="orderType"/>
											<input type="hidden" id="cashierNumber_form" name="cashierNumber"/>
											<input type="hidden" id="checkStatus_form" name="checkStatus"/>
											<input type="hidden" id="startTime_form" name="startTime"/>
											<input type="hidden" id="endTime_form" name="endTime"/>
                                      	</form>
                                	<div style="width:100%; height:225px; overflow:scroll;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row">
                                            	<th width="1%" ></th>
                                                <th width="5%" style="text-align: center;">平台对账结果</th>
                                                <th width="5%" style="text-align: center;">收银流水号</th>
                                                <th width="4%" style="text-align: center;">oms销售金额</th>
                                                <th width="4%" style="text-align: center;">富基销售金额</th>
                                                <th width="4%" style="text-align: center;">sap销售金额</th>
                                                <th width="4%" style="text-align: center;">销售类型</th>
                                                <th width="4%" style="text-align: center;">订单类型</th>
                                                <th width="4%" style="text-align: center;">销售单号</th>
                                                <th width="5%" style="text-align: center;">订单号</th>
                                                <th width="4%" style="text-align: center;">门店名称</th>
                                                <th width="4%" style="text-align: center;">供应商sid</th>
                                                <th width="4%" style="text-align: center;">收银时间</th>
                                                <th width="5%" style="text-align: center;">oms销售数量</th>
                                                <th width="5%" style="text-align: center;">oms支付方式</th>
                                                <th width="5%" style="text-align: center;">富基销售数量</th>
                                                <th width="5%" style="text-align: center;">富基支付方式</th>
                                                <th width="5%" style="text-align: center;">sap销售数量</th>
                                                <th width="4%" style="text-align: center;">sap支付方式</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" ">
													
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													
													<td align="center" id="checkStatusDesc_{$T.Result.sid}">{$T.Result.checkStatusDesc}</td>
													<td align="center" id="cashierNumber_{$T.Result.sid}">{$T.Result.cashierNumber}</td>
													<td align="center" id="omsMoneySum_{$T.Result.sid}">{$T.Result.omsMoneySum}</td>
													<td align="center" id="futureMoneySum_{$T.Result.sid}">{$T.Result.futureMoneySum}</td>
													<td align="center" id="sapMoneySum_{$T.Result.sid}">{$T.Result.sapMoneySum}</td>
													<td align="center" id="saleType_{$T.Result.sid}">
														{#if $T.Result.saleType == '1'}实体
														{#elseif $T.Result.saleType == '4'}网络
														{#/if}
													</td>
													<td align="center" id="orderType_{$T.Result.sid}">
														{#if $T.Result.orderType == '0'}实体
														{#elseif $T.Result.orderType == '1'}网络
														{#elseif $T.Result.orderType == '2'}微信
														{#/if}
													</td>
													<td align="center" id="saleNo_{$T.Result.sid}">{$T.Result.saleNo}</td>
													<td align="center" id="orderNo_{$T.Result.sid}">{$T.Result.orderNo}</td>
													<td align="center" id="shopName_{$T.Result.sid}">{$T.Result.shopName}</td>
													<td align="center" id=supplyInfoSid_{$T.Result.sid}">{$T.Result.supplyInfoSid}</td>
													<td align="center" id="cashTime_{$T.Result.sid}">{$T.Result.cashTime}</td>
													<td align="center" id="omsSaleSum_{$T.Result.sid}">{$T.Result.omsSaleSum}</td>
													<td align="center" id="omsPaymentMode_{$T.Result.sid}">{$T.Result.omsPaymentMode}</td>
													<td align="center" id="futureSaleSum_{$T.Result.sid}">{$T.Result.futureSaleSum}</td>
													<td align="center" id="futurePaymentMode_{$T.Result.sid}">{$T.Result.futurePaymentMode}</td>
													<td align="center" id="sapSaleSum_{$T.Result.sid}">{$T.Result.sapSaleSum}</td>
													<td align="center" id="sapPaymentMode_{$T.Result.sid}">{$T.Result.sapPaymentMode}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
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
</body>

</html>