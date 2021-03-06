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
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var olvPagination;
	$(function() {
		$.ajax({url:__ctxPath + "/DataDictionary/getItemType?dictTypeCode="+11,dataType:"json",async:false,success:function(response){
    		var result = response.list;
           	 var option = "<option value=''>所有</option>";
           	 for(var i=0;i<result.length;i++){
           		 var ele = result[i];
           		 option+="<option value='"+ele.dictItemCode+"'>"+ele.dictItemName+"</option>";
           	 }
           	 $("#orderSourceSid_select").append(option);
 		}});
		$('#reservation').daterangepicker();
	    initOlv();
	});
	function olvQuery(){
		$("#orderNo_form").val($("#orderNo_input").val());
		$("#sendType_form").val($("#sendType_select").val());
		$("#state_form").val($("#state_select").val());
		$("#orderSourceSid_form").val($("#orderSourceSid_select").val());
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startSaleTime_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endSaleTime_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startSaleTime_form").val("");
			$("#endSaleTime_form").val("");
		}
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#orderNo_input").val("");
		$("#sendType_select").val("");
		$("#state_select").val("");
		$("#orderSourceSid_select").val("");
		$("#reservation").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/order/selectOrderListByParamBack";
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
	
	//第一个表格点击加号
	function spanTd(sid,orderNo){
		if($("#spanTd_"+sid).attr("class")=="expand-collapse click-expand glyphicon glyphicon-plus"){
			$("#spanTd_"+sid).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
			$.ajax({
				type:"post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url:__ctxPath + "/order/selectSaleListByParam",
				async:false,
				dataType: "json",
				data:{
					"orderNo":orderNo
				},
				success:function(response) {
					var result = response.list;
					var option = "<tr id='afterTr"+sid+"'><td></td><td colspan='10'><div style='padding:3px;'><table style='width: 100%;'><tr role='row'><th style='text-align: center;'>销售单号</th><th style='text-align: center;'>收银流水号</th><th style='text-align: center;'>入POS</th><th style='text-align: center;'>开始调拨</th><th style='text-align: center;'>已付款已提货</th><th style='text-align: center;'>调出物流室</th><th style='text-align: center;'>调入物流中心</th><th style='text-align: center;'>是否退货</th><th style='text-align: center;'>门店</th><th style='text-align: center;'>金额</th></tr>";
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						option+="<tr><td align='center'>"+ele.saleNo+"</td><td align='center'>"+ele.cashierNumber+"</td>";
						if(ele.cashierNumber!=""&&ele.cashierNumber!=null){
							option+="<td align='center'><span style='color:green;font-weight:bold;'>成功►►►</span></td>";
						}else{
							option+="<td align='center'><span style='color:red;font-weight:bold;'>失败</span></td>";
						}
						if(ele.printTimes>0){
							option+="<td align='center'><span style='color:green;font-weight:bold;'>执行►►►</span></td>";
						}else{
							option+="<td align='center'><span style='color:red;font-weight:bold;'>未执行</span></td>";
						}
						if(ele.saleStatus==5){
							option+="<td align='center'><span style='color:green;font-weight:bold;'>执行►►►</span></td>";
						}else{
							option+="<td align='center'><span style='color:red;font-weight:bold;'>未执行</span></td>";
						}
						if(ele.allotStatus == 2||ele.allotStatus == 3){
							option+="<td align='center'><span style='color:green;font-weight:bold;'>执行►►►</span></td>";
						}else{
							option+="<td align='center'><span style='color:red;font-weight:bold;'>未执行</span></td>";
						}
						if(ele.allotStatus == 3){
							option+="<td align='center'><span style='color:green;font-weight:bold;'>执行►►►</span></td>";
						}else{
							option+="<td align='center'><span style='color:red;font-weight:bold;'>未执行</span></td>";
						}
						if(ele.refundTotalBit == 0){
							option+="<td align='center'><span style='color:green;font-weight:bold;'>否</span></td>";
						}else if(ele.refundTotalBit = 1){
							option+="<td align='center'><span style='color:red;font-weight:bold;'>部分退货</span></td>";
						}else{
							option+="<td align='center'><span style='color:red;font-weight:bold;'>整单退货</span></td>";
						}
						option+="<td align='center'><span style='color:orange;font-weight:bold;'>"+ele.shopName+"</span></td>"+
							"<td align='center'><span style='color:orange;font-weight:bold;'>￥"+ele.saleMoneySum+"</span></td></tr>";
					}
					option+="</table></div></td></tr>";
					$("#gradeX"+sid).after(option);
				}
			});
		}else{
			$("#spanTd_"+sid).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTr"+sid).remove();
		}
	}
	
	//点击tr事件
	function trClick(orderSid){
		$("#OLV2_tab").html("<tr role='row'><th width='5%' style='text-align: center;'>订单明细SID</th><th width='5%' style='text-align: center;'>商品明细SID</th><th width='12%' style='text-align: center;'>商品名</th><th width='4%' style='text-align: center;'>品牌SID</th><th width='10%' style='text-align: center;'>品牌名称</th><th width='6%' style='text-align: center;'>商品SKU</th><th width='6%' style='text-align: center;'>包装单位</th><th width='6%' style='text-align: center;'>计量单位</th><th width='4%' style='text-align: center;'>原价</th><th width='4%' style='text-align: center;'>促销价</th><th width='4%' style='text-align: center;'>销售价</th><th width='5%' style='text-align: center;'>销售总数</th><th width='5%' style='text-align: center;'>退货总数</th></tr>");
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/order/selectOrderDetailListByOrderSid",
			async:false,
			dataType: "json",
			data:{"orderSid":orderSid},
			success:function(response) {
				if(response.success='true'){
					var result = response.list;
					var option = "";
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						option +="<tr><td align='center'>"+ele.sid+"</td><td align='center'>"+ele.proDetailSid+"</td><td align='center'>"+ele.productName+"</td><td align='center'>"+ele.brandSid+"</td>"+
						"<td align='center'>"+ele.brandName+"</td><td align='center'>"+ele.proSku+"</td><td align='center'>"+ele.proColor+"</td><td align='center'>"+ele.proSize+"</td>"+
						"<td align='center'>"+ele.originalPrice+"</td><td align='center'>"+ele.promotionPrice+"</td><td align='center'>"+ele.salePrice+"</td><td align='center'>"+ele.saleSum+"</td><td align='center'>"+ele.refundNum+"</td></tr>";
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
                                    <span class="widget-caption"><h5>订单管理</h5></span>
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
                                    		<div class="col-lg-5"><span>订单号：</span></div>
                                    		<div class="col-lg-7">
                                				<input type="text" id="orderNo_input" style="width: 100%;"/>
                                			</div>
                                    	</div>
                                    	<div class="col-md-4">
	                                		<div class="col-lg-5"><span>配送方式：</span></div>
	                                		<div class="col-lg-7">
		                                		<select id="sendType_select" style="padding:0 0;width: 100%">
		                                			<option value="">所有</option>
		                                			<option value="1">快递</option>
		                                			<option value="2">EMS</option>
		                                			<option value="4">货到付款</option>
		                                			<option value="5">淘宝商城0运费</option>
		                                			<option value="6">淘宝商城快递</option>
		                                		</select>
		                                	</div>
                                		</div>
                                		<div class="col-md-4">
	                                		<div class="col-lg-5"><span>订单状态：</span></div>
	                                		<div class="col-lg-7">
		                                		<select id="state_select" style="padding:0 0;width: 100%">
		                                			<option value="">所有</option>
		                                			<option value="-1">已作废</option>
		                                			<option value="0">超时支付</option>
		                                			<option value="1">草稿</option>
		                                			<option value="2">已支付</option>
		                                			<option value="3">已发货</option>
		                                			<option value="4">确认收货</option>
		                                			<option value="5">拒签</option>
		                                			<option value="6">财务确认收款</option>
		                                			<option value="-3">已拆分</option>
		                                		</select>&nbsp;
		                                	</div>
	                                	</div>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-3">时间</div>
	                                		<div class="col-lg-9">
                                           		<input type="text" id="reservation" style="width: 100%"/>
                                           	</div>
                                		</div>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-5"><span>订单来源：</span></div>
	                                		<div class="col-lg-7">
	                                			<select id="orderSourceSid_select" style="padding:0 0;width: 100%;"></select>
	                                		</div>
	                                	</div>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-12">
	                                			<a class="btn btn-default" onclick="olvQuery();">查询</a>
	                                			<a class="btn btn-default" onclick="reset();">重置</a>
	                                		</div>&nbsp;
                                		</div>
                                		<div class="col-md-4">
	                               			<form id="olv_form" action="">
												<input type="hidden" id="pageSelect" name="pageSize" value="15"/>
												<input type="hidden" id="orderNo_form" name="orderNo"/>
												<input type="hidden" id="sendType_form" name="sendType"/>
												<input type="hidden" id="state_form" name="state"/>
												<input type="hidden" id="orderSourceSid_form" name="orderSourceSid"/>
												<input type="hidden" id="startSaleTime_form" name="startSaleTime"/>
												<input type="hidden" id="endSaleTime_form" name="endSaleTime"/>
	                                      	</form>
	                                    </div>
                                    </div>
                                	<div style="width:100%; height:225px; overflow:scroll;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row">
                                            	<th width="1%"></th>
                                                <th width="7%" style="text-align: center;">订单号</th>
                                                <th width="7%" style="text-align: center;">父订单号</th>
                                                <th width="4%" style="text-align: center;">订单状态</th>
                                                <th width="4%" style="text-align: center;">物流状态</th>
                                                <th width="4%" style="text-align: center;">商品总数量</th>
                                                <th width="4%" style="text-align: center;">商品总金额</th>
                                                <th width="4%" style="text-align: center;">顾客运费</th>
                                                <th width="4%" style="text-align: center;">优惠券</th>
                                                <th width="5%" style="text-align: center;">实际应付金额</th>
                                                <th width="4%" style="text-align: center;">配送类型</th>
                                                <th width="4%" style="text-align: center;">购买时间</th>
                                                <th width="4%" style="text-align: center;">发货时间</th>
                                                <th width="5%" style="text-align: center;">订单来源</th>
                                                <th width="5%" style="text-align: center;">货架号</th>
                                                <th width="5%" style="text-align: center;">支付类型</th>
                                                <th width="5%" style="text-align: center;">收货人姓名</th>
                                                <th width="5%" style="text-align: center;">收货人电话</th>
                                                <th width="5%" style="text-align: center;">会员EMAIL</th>
                                                <th width="5%" style="text-align: center;">外部订单号</th>
                                                <th width="5%" style="text-align: center;">快递单号</th>
                                                <th width="5%" style="text-align: center;">快递公司</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    </div>
                                    <div id="olvPagination"></div>
                                    <div style="width:100%; height:95px; overflow:scroll;">
                                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 130%;background-color: #fff;margin-bottom: 0;">
                                        <tr role="row">
                                            <th width="5%" style="text-align: center;">订单明细SID</th>
                                            <th width="5%" style="text-align: center;">商品明细SID</th>
                                            <th width="12%" style="text-align: center;">商品名</th>
                                            <th width="4%" style="text-align: center;">品牌SID</th>
                                            <th width="10%" style="text-align: center;">品牌名称</th>
                                            <th width="6%" style="text-align: center;">商品SKU</th>
                                            <th width="6%" style="text-align: center;">包装单位</th>
                                            <th width="6%" style="text-align: center;">计量单位</th>
                                            <th width="4%" style="text-align: center;">原价</th>
                                            <th width="4%" style="text-align: center;">促销价</th>
                                            <th width="4%" style="text-align: center;">销售价</th>
                                            <th width="4%" style="text-align: center;">销售总数</th>
                                            <th width="5%" style="text-align: center;">退货总数</th>
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
													<td align="center">
														<span id="spanTd_{$T.Result.sid}" onclick="spanTd({$T.Result.sid},{$T.Result.orderNo});" class="expand-collapse click-expand glyphicon glyphicon-plus"></span>
													</td>
													<td align="center" id="orderNo_{$T.Result.sid}">{$T.Result.orderNo}</td>
													<td align="center" id="parentOrderNo_{$T.Result.sid}">{$T.Result.parentOrderNo}</td>
													<td align="center" id="orderStatus_{$T.Result.sid}">
														{#if $T.Result.orderStatus == '-1'}
						           							<span style='color:red;font-weight:bold;'>作废</span>
						                      			{#elseif $T.Result.orderStatus == '0'}超时
						           						{#elseif $T.Result.orderStatus == '1'}草稿
						           						{#elseif $T.Result.orderStatus == '-2'}审核未通过
						           						{#elseif $T.Result.orderStatus == '2'}
						           							{#if $T.Result.paymentTypeSid == '4'}
						           								<span style='color:green;font-weight:bold;'>审核通过</span>
						           							{#else}
						           								<span style='color:green;font-weight:bold;'>已支付</span>
						           							{#/if}
						           						{#elseif $T.Result.orderStatus == '3'}已发货
						           						{#elseif $T.Result.orderStatus == '4'}
						           							<span style='color:green;font-weight:bold;'>确认收货</span>
						           						{#elseif $T.Result.orderStatus == '5'}
						           							<span style='color:green;font-weight:bold;'>拒签</span>
						           						{#elseif $T.Result.orderStatus == '6'}
						           							<span style='color:green;font-weight:bold;'>确认收款</span>
						           						{#elseif $T.Result.orderStatus == '-3'}已拆分
						                   				{#/if}
													</td>
													<td align="center" id="logisticsStatusDesc_{$T.Result.sid}">{$T.Result.logisticsStatusDesc}</td>
													<td align="center" id="saleAllSum_{$T.Result.sid}">{$T.Result.saleAllSum}</td>
													<td align="center" id="saleMoneySum_{$T.Result.sid}">{$T.Result.saleMoneySum}</td>
													<td align="center" id="sendCost_{$T.Result.sid}">{$T.Result.sendCost}</td>
													<td align="center" id="ticketSnUsePrice_{$T.Result.sid}">{$T.Result.ticketSnUsePrice}</td>
													<td align="center" id="needSaleMoneySum_{$T.Result.sid}"><span style='font-weight:bold;color:red;'>{$T.Result.needSaleMoneySum}</span></td>
													<td align="center" id="sendType_{$T.Result.sid}">
														{#if $T.Result.sendType == '1'}快递
														{#elseif $T.Result.sendType == '2'}EMS
														{#elseif $T.Result.sendType == '4'}货到付款
														{#elseif $T.Result.sendType == '5'}淘宝商城0运费
														{#elseif $T.Result.sendType == '6'}淘宝商城快递
														{#/if}
													</td>
													<td align="center" id="saleTime_{$T.Result.sid}">{$T.Result.saleTime}</td>
													<td align="center" id="deliveryTime_{$T.Result.sid}">{$T.Result.deliveryTime}</td>
													<td align="center" id="orderSource_{$T.Result.sid}">{$T.Result.orderSource}</td>
													<td align="center" id="storageNo_{$T.Result.sid}">{$T.Result.storageNo}</td>
													<td align="center" id="parentOrderNo_{$T.Result.sid}">{$T.Result.parentOrderNo}</td>
													<td align="center" id="receptName_{$T.Result.sid}">{$T.Result.receptName}</td>
													<td align="center" id="receptPhone_{$T.Result.sid}">{$T.Result.receptPhone}</td>
													<td align="center" id="memberEmail_{$T.Result.sid}">{$T.Result.memberEmail}</td>
													<td align="center" id="outerOrderNo_{$T.Result.sid}">{$T.Result.outerOrderNo}</td>
													<td align="center" id="courierNo_{$T.Result.sid}">{$T.Result.courierNo}</td>
													<td align="center" id="deliveryComName_{$T.Result.sid}">{$T.Result.deliveryComName}</td>
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