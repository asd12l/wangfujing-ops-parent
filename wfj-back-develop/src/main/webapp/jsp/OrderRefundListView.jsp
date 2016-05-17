<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type='text/css'>
.x-tree-node-leaf .x-tree-node-icon{   
	      background-image:url(../js/ext3.4/resources/images/default/tree/drop-yes.gif);   
	  } 
</style>
<%-- 
<script type="text/javascript" src="${ctx}/order/OrderListView.js"></script>
<script type="text/javascript" src="${ctx}/order/OrderRefundListView.js"></script>
<script type="text/javascript" src="${ctx}/sysjs/SysConstant.js"></script>
<script type="text/javascript" src="${ctx}/js/ext3.4/ux/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/ext3.4/ux/RowExpander.js"></script> --%>

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
		/* $.ajax({url:__ctxPath + "/DataDictionary/getItemType?dictTypeCode="+51,dataType:"json",async:false,success:function(response){
    		var result = response.list;
           	 var option = "<option value=''>所有</option>";
           	 for(var i=0;i<result.length;i++){
           		 var ele = result[i];
           		 option+="<option value='"+ele.dictItemCode+"'>"+ele.dictItemName+"</option>";
           	 }
           	 $("#shopName_select").append(option);
 		}});
		$('#reservation').daterangepicker(); */
	    initOlv();
	});
	function olvQuery(){
		$("#refundNo_form").val($("#refundNo_input").val());
		$("#refundStatus_form").val($("#refundStatus_select").val());
		$("#orderSid_form").val($("#orderSid_input").val());
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#refundNo_input").val("");
		$("#refundStatus_select").val("");
		$("#orderSid_input").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/order/selectOrderRefundListByParamBack";
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
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
    }
	
	
 	function trClick(refundSid){
		$("#OLV2_tab").html("<tr role='row'>"+
				"<th width='5%' style='text-align: center;'>退货单SID</th>"+
				"<th width='5%' style='text-align: center;'>退货单号</th>"+
				"<th width='12%' style='text-align: center;'>商品明细SID</th>"+
				"<th width='10%' style='text-align: center;'>商品名称</th>"+
				"<th width='6%' style='text-align: center;'>包装单位</th>"+
				"<th width='6%' style='text-align: center;'>计量单位</th>"+
				"<th width='6%' style='text-align: center;'>退货价格</th>"+
				"<th width='4%' style='text-align: center;'>销售总数</th>"+
				"<th width='4%' style='text-align: center;'>退货总数</th>"+
				"<th width='4%' style='text-align: center;'>品牌SID</th>"+
				"<th width='5%' style='text-align: center;'>品牌名称</th>"+
				"<th width='5%' style='text-align: center;'>退货原因</th>");
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/order/selectOrderDetailRefundListByOrderSid",
			async:false,
			dataType: "json",
			data:{"refundSid":refundSid},
			success:function(response) {
				if(response.success='true'){
					var result = response.list;
					var option = "";
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						option +="<tr><td align='center'>"+ele.sid+"</td>";
						if(ele.refundSid==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundSid+"</td>";
						}
						if(ele.proDetailSid==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.proDetailSid+"</td>";
						}
						if(ele.productName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.productName+"</td>";
						}
						if(ele.proColor==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.proColor+"</td>";
						}
						if(ele.proSize==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.proSize+"</td>";
						}
						if(ele.refundPrice==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundPrice+"</td>";
						}
						if(ele.saleSum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleSum+"</td>";
						}
						if(ele.refundNum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundNum+"</td>";
						}
						if(ele.brandSid==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.brandSid+"</td>";
						}
						if(ele.brandName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.brandName+"</td>";
						}
						if(ele.refundReasonDesc==undefined){
							option+="<td align='center'></td></tr>";
						}else{
							option+="<td align='center'>"+ele.refundReasonDesc+"</td></tr>";
						}
					}
					$("#OLV2_tab").append(option);
				}
			}
		});
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
  
  
 <!--  <script type="text/javascript">
 	__ctxPath = "${pageContext.request.contextPath}";  
    Ext.onReady(function(){
    	new OrderRefundListView();
    });
  
  </script> -->

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
                                    <span class="widget-caption"><h5>退货单管理</h5></span>
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
                                    			<span>退货单编号：</span>
                                    		</div>
                                    		<div class="col-lg-7">
                                    			<input type="text" id="refundNo_input" style="width: 100%;"/>
                                    		</div>
                                    	</div>
                                    	<div class="col-md-4">
                                    		<div class="col-lg-4">
	                                			<span>退货状态：</span>
	                                		</div>
	                                		<div class="col-lg-8">
		                                		<select id="refundStatus_select" style="padding:0 0;width: 100%;">
		                                			<option value="">所有</option>
		                                			<option value="-2">审核未通过</option>
		                                			<option value="-1">已作废</option>
		                                			<option value="0">草稿</option>
		                                			<option value="1">已打印退货单</option>
		                                			<option value="2">退货入收银</option>
		                                			<option value="3">导购确认无货</option>
		                                		</select>&nbsp;
		                                	</div>
                                		</div>
                                		<div class="col-md-4">
                                    		<div class="col-lg-4">
                                    			<span>订单SID：</span>
                                    		</div>
                                    		<div class="col-lg-8">
                                				<input type="text" id="orderSid_input" style="width: 100%;"/>&nbsp;
                                			</div>
                                    	</div>
                                    	<div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="olvQuery();" class="btn btn-yellow" style="width: 100%;">
	                                    		<i class="fa fa-eye"></i>
												查询
	                                        </a>
                                        </div>
                                        <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="reset();" class="btn btn-primary" style="width: 100%;">
	                                        	<i class="fa fa-random"></i>
												重置
	                                        </a>&nbsp;
	                                    </div>
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="15"/>
											<input type="hidden" id="refundNo_form" name="refundNo"/>
											<input type="hidden" id="refundStatus_form" name="refundStatus"/>
											<input type="hidden" id="orderSid_form" name="orderSid"/>
                                      	</form>
                                	<div style="width:100%; height:225px; overflow:scroll;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row">
                                                <th width="5%" style="text-align: center;">订单SID</th>
                                                <th width="5%" style="text-align: center;">退货单编号</th>
                                                <th width="4%" style="text-align: center;">库存类别</th>
                                                <th width="4%" style="text-align: center;">退货原因</th>
                                                <th width="4%" style="text-align: center;">退货时间</th>
                                                <th width="4%" style="text-align: center;">退货单状态</th>
                                                <th width="4%" style="text-align: center;">退货类型</th>
                                                <th width="4%" style="text-align: center;">退货总数量</th>
                                                <th width="5%" style="text-align: center;">销售单SID</th>
                                                <th width="4%" style="text-align: center;">门店号</th>
                                                <th width="4%" style="text-align: center;">退货总金额</th>
                                                <th width="4%" style="text-align: center;">收银流水号</th>
                                                <th width="5%" style="text-align: center;">供应商SID</th>
                                                <th width="5%" style="text-align: center;">审核状态</th>
                                                <th width="5%" style="text-align: center;">卡号</th>
                                                <th width="5%" style="text-align: center;">会员号</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    </div>
                                    <div id="olvPagination"></div>
                                    <div style="width:100%; height:95px; overflow:scroll;">
                                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 180%;background-color: #fff;margin-bottom: 0;">
                                        <tr role='row'>
											<th width='5%' style='text-align: center;'>退货单SID</th>
											<th width='5%' style='text-align: center;'>退货单号</th>
											<th width='12%' style='text-align: center;'>商品明细SID</th>
											<th width='10%' style='text-align: center;'>商品名称</th>
											<th width='6%' style='text-align: center;'>包装单位</th>
											<th width='6%' style='text-align: center;'>计量单位</th>
											<th width='6%' style='text-align: center;'>退货价格</th>
											<th width='4%' style='text-align: center;'>销售总数</th>
											<th width='4%' style='text-align: center;'>退货总数</th>
											<th width='4%' style='text-align: center;'>品牌SID</th>
											<th width='5%' style='text-align: center;'>品牌名称</th>
											<th width='5%' style='text-align: center;'>退货原因</th>
										</tr>
                                    </table>
                                    </div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.sid}" onclick="trClick({$T.Result.sid})">
													<td align="center" id="orderSid_{$T.Result.sid}">{$T.Result.orderSid}</td>
													<td align="center" id="refundNo_{$T.Result.sid}">{$T.Result.refundNo}</td>
													<td align="center" id="stockTypeSid_{$T.Result.sid}">
														{#if $T.Result.refundTotalBit == '0'}没有库存类型
														{#elseif $T.Result.refundTotalBit == '1'}销售库
														{#elseif $T.Result.refundTotalBit == '2'}测试库
														{#/if}
													</td>
													<td align="center" id="refundDesc_{$T.Result.sid}">{$T.Result.refundDesc}</td>
													<td align="center" id="refundTime_{$T.Result.sid}">{$T.Result.refundTime}</td>
													<td align="center" id="refundStatus_{$T.Result.sid}">
														{#if $T.Result.refundStatus == '-2'}审核未通过
						                      			{#elseif $T.Result.refundStatus == '-1'}已作废
						                      			{#elseif $T.Result.refundStatus == '0'}草稿
						                      			{#elseif $T.Result.refundStatus == '1'}已打印退货单
						                      			{#elseif $T.Result.refundStatus == '2'}退货入收银
						                      			{#elseif $T.Result.refundStatus == '3'}导购确认无货
						                   				{#/if}
													</td>
													<td align="center" id="refundTotalBit_{$T.Result.sid}">
														{#if $T.Result.refundTotalBit == '0'}没有退货
														{#elseif $T.Result.refundTotalBit == '1'}部分退货
														{#elseif $T.Result.refundTotalBit == '2'}整单退货
														{#/if}
													</td>
													<td align="center" id="refundNum_{$T.Result.sid}">{$T.Result.refundNum}</td>
													<td align="center" id="saleNo_{$T.Result.sid}">{$T.Result.saleNo}</td>
													<td align="center" id="shopSid_{$T.Result.sid}">{$T.Result.shopSid}</td>
													<td align="center" id="refundMoneySum_{$T.Result.sid}">{$T.Result.refundMoneySum}</td>
													<td align="center" id="cashierNumber_{$T.Result.sid}">{$T.Result.cashierNumber}</td>
													<td align="center" id="supplyInfoSid_{$T.Result.sid}">{$T.Result.supplyInfoSid}</td>
													<td align="center" id="checkStatus_{$T.Result.sid}">
														{#if $T.Result.checkStatus == '-1'}拒绝
														{#elseif $T.Result.checkStatus == '0'}未审核
														{#elseif $T.Result.checkStatus == '1'}审核通过
														{#/if}
													</td>
													<td align="center" id="cardId_{$T.Result.sid}">{$T.Result.cardId}</td>
													<td align="center" id="vipNo_{$T.Result.sid}">{$T.Result.vipNo}</td>
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