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
		$.ajax({url:__ctxPath + "/DataDictionary/getItemType?dictTypeCode="+5,dataType:"json",async:false,success:function(response){
    		var result = response.list;
           	 var option = "<option value=''>所有</option>";
           	 for(var i=0;i<result.length;i++){
           		 var ele = result[i];
           		 option+="<option value='"+ele.dictItemCode+"'>"+ele.dictItemName+"</option>";
           	 }
           	 /* $("#shopName_select").append(option); */
 		}});
		$('#reservation').daterangepicker(); 
	    initOlv();
	});
	function olvQuery(){
		$("#refundApplyNo_form").val($("#refundApplyNo_input").val());
		$("#orderNo_form").val($("#orderNo_input").val());
		$("#refundStatus_form").val($("#refundStatus_select").val());
		$("#refundGoodType_form").val($("#refundGoodType_select").val());
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startSaleTime_form").val(
					$.trim(strTime[0].replace("/", "-").replace("/", "-")));
			$("#endSaleTime_form").val(
					$.trim(strTime[1].replace("/", "-").replace("/", "-")));
		}else{
			$("#startSaleTime_form").val("");
			$("#endSaleTime_form").val("");
		}
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#refundApplyNo_input").val("");
		$("#orderNo_input").val("");
		$("#refundStatus_select").val("");
		$("#refundGoodType_select").val("");
		$("#reservation").val("");
		olvQuery();
	}

 	function initOlv() {
		var url = __ctxPath+"/order/selectRefundApplyByParamBack";
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
	
	
 	function trClick(refundApplyNo){
		$("#OLV2_tab").html("<tr role='row'>"+
				"<th width='5%' style='text-align: center;'>退货申请单号</th>"+
				"<th width='5%' style='text-align: center;'>商品明细SID</th>"+
				"<th width='5%' style='text-align: center;'>商品名称</th>"+
				"<th width='6%' style='text-align: center;'>包装单位</th>"+
				"<th width='6%' style='text-align: center;'>计量单位</th>"+
				"<th width='6%' style='text-align: center;'>收银流水号</th>"+
				"<th width='4%' style='text-align: center;'>调拨状态描述</th>"+
				"<th width='4%' style='text-align: center;'>门店名称</th>"+
				"<th width='4%' style='text-align: center;'>原价</th>"+
				"<th width='5%' style='text-align: center;'>销售总数</th>"+
				"<th width='5%' style='text-align: center;'>退货总数</th>"+
				"<th width='5%' style='text-align: center;'>品牌名称</th>"+
				"<th width='5%' style='text-align: center;'>库存类别</th>"+
				"<th width='5%' style='text-align: center;'>退货原因</th>"+
				"<th width='5%' style='text-align: center;'>导购确定收货状态</th>");
		
		var data = new Array();
		data.push({"shopSid":"0","shopName":"物流中心"},
				{"shopSid":"57","shopName":"王府井"},
				{"shopSid":"58","shopName":"亚运村"},
				{"shopSid":"59","shopName":"首体"},
				{"shopSid":"60","shopName":"五棵松"},
				{"shopSid":"61","shopName":"中关村"},
				{"shopSid":"62","shopName":"朝阳门"},
				{"shopSid":"63","shopName":"三里河"},
				{"shopSid":"66","shopName":"来广营"},
				{"shopSid":"68","shopName":"仓储店"},
				{"shopSid":"69","shopName":"宋家庄"},
				{"shopSid":"70","shopName":"回龙观"},
				{"shopSid":"71","shopName":"草桥"},
				{"shopSid":"1001","shopName":"王府井"},
				{"shopSid":"1002","shopName":"亚运村"},
				{"shopSid":"1003","shopName":"首体"},
				{"shopSid":"1004","shopName":"五棵松"},
				{"shopSid":"1005","shopName":"中关村"},
				{"shopSid":"1006","shopName":"朝阳门"},
				{"shopSid":"1007","shopName":"三里河"},
				{"shopSid":"1008","shopName":"来广营"},
				{"shopSid":"5000","shopName":"仓储店"},
				{"shopSid":"1010","shopName":"回龙观"},
				{"shopSid":"1011","shopName":"草桥"});
		
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/order/selectRefundApplyDetailByParam",
			async:false,
			dataType: "json",
			data:{"refundApplyNo":refundApplyNo},
			success:function(response) {
				if(response.success='true'){
					var result = response.list;
					
					for(var j=0;j<data.length;j++){
 	             		for(var i=0;i<result.length;i++){
 	             			//console.log(result[i].shopSid==data[j].shopSid);
 	           				if(result[i].shopSid==data[j].shopSid){
 	           					response.list[i].shopSid=data[j].shopName;
 	           				}
 	               	 	}
              		}
					
					var option = "";
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						//退货申请单号
						if(ele.refundApplyNo==undefined){
							option+="<tr><td align='center'></td>";
						}else{
							option+="<tr><td align='center'>"+ele.refundApplyNo+"</td>";
						}
						//商品明细SID
						if(ele.proDetailSid==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.proDetailSid+"</td>";
						}
						//商品名称
						if(ele.productName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.productName+"</td>";
						}
						//包装单位
						if(ele.proColor==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.proColor+"</td>";
						}
						//计量单位
						if(ele.proSize==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.proSize+"</td>";
						}
						//收银流水号
						if(ele.cashierNumber==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.cashierNumber+"</td>";
						}
						//调拨状态描述
						if(ele.allotStatusDesc==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.allotStatusDesc+"</td>";
						}
						//门店名称
						if(ele.shopSid==undefined){
							option+="<td align='center'></td>";
						}else if(ele.shopSid/1>0){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.shopSid+"</td>";
						}
						//原价
						if(ele.refundPrice==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundPrice+"</td>";
						}
						//销售总数
						if(ele.saleSum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleSum+"</td>";
						}
						//退货总数
						if(ele.refundNum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundNum+"</td>";
						}
						//品牌名称
						if(ele.brandName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.brandName+"</td>";
						}
						//库存类别
						if(ele.stockTypeSid=="0"){
							option+="<td align='center'>正品库</td>";
						}else if(ele.stockTypeSid=="1"){
							option+="<td align='center'>次品库</td>";
						}else{
							option+="<td align='center'></td>";
						}
						//退货原因
						if(ele.refundReasonDesc==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundReasonDesc+"</td>";
						}
						//导购确定收货状态
						if(ele.confirmStatus=="0"){
							option+="<td align='center'>未确认收货</td></tr>";
						}else if(ele.confirmStatus=="1"){
							option+="<td align='center'>确认收货</td></tr>";
						}else{
							option+="<td align='center'></td></tr>";
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
                                    <span class="widget-caption"><h5>退货申请单管理</h5></span>
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
                                    			<span>退货申请单号：</span>
                                    		</div>
                                    		<div class="col-lg-7">
                                    			<input type="text" id="refundApplyNo_input" style="width: 100%;"/>
                                    		</div>
                                    	</div>
                                    	<div class="col-md-4">
                                    		<div class="col-lg-5">
                                    			<span>订单号：</span>
                                    		</div>
                                    		<div class="col-lg-7">
                                    			<input type="text" id="orderNo_input" style="width: 100%;"/>
                                    		</div>
                                    	</div>
                                    	<div class="col-md-4">
                                    		<div class="col-lg-5">
	                                			<span>退货申请状态：</span>
	                                		</div>
	                                		<div class="col-lg-7">
		                                		<select id="refundStatus_select" style="padding:0 0;width: 100%;">
		                                			<option value="">所有</option>
		                                			<option value="-2">审核未通过</option>
		                                			<option value="-1">已作废</option>
		                                			<option value="0">草稿</option>
		                                			<option value="1">审核通过</option>
		                                			<option value="2">确认收货</option>
		                                			<option value="3">财务退款</option>
		                                			<option value="4">延时退款</option>
		                                		</select>&nbsp;
		                                	</div>
                                		</div>
                                    	<div class="col-md-4">
	                                		<div class="col-lg-5">时间：</div>
	                                		<div class="col-lg-7">
                                   				<input type="text" id="reservation"  style="width: 100%;"/>
                                   			</div>
                                		</div>
                                		<div class="col-md-4">
                                    		<div class="col-lg-5">
                                    			<span>退货类型：</span>
                                    		</div>
                                    		<div class="col-lg-7">
                                    		<select id="refundGoodType_select" style="padding:0 0;width: 100%;">
		                                			<option value="">所有</option>
		                                		</select>
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
											<input type="hidden" id="refundApplyNo_form" name="refundApplyNo"/>
											<input type="hidden" id="orderNo_form" name="orderNo"/>
											<input type="hidden" id="refundStatus_form" name="refundStatus"/>
											<input type="hidden" id="refundGoodType_form" name="refundGoodType"/>
											<input type="hidden" id="startSaleTime_form" name="startSaleTime"/>
											<input type="hidden" id="endSaleTime_form" name="endSaleTime"/>
                                      	</form>
                                	<div style="width:100%; height:225px; overflow:scroll;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row">
                                                <th width="5%" style="text-align: center;">退货申请单号</th>
                                                <th width="3%" style="text-align: center;">订单号</th>
                                                <th width="6%" style="text-align: center;">退货申请单状态</th>
                                                <th width="4%" style="text-align: center;">退货方式</th>
                                                <th width="4%" style="text-align: center;">退货类型</th>
                                                <th width="5%" style="text-align: center;">退货申请时间</th>
                                                <th width="4%" style="text-align: center;">退款总金额</th>
                                                <th width="5%" style="text-align: center;">顾客应付运费</th>
                                                <th width="5%" style="text-align: center;">公司应付运费</th>
                                                <th width="4%" style="text-align: center;">退券金额</th>
                                                <th width="6%" style="text-align: center;">实际退款总金额</th>
                                                <th width="5%" style="text-align: center;">退款确认姓名</th>
                                                <th width="6%" style="text-align: center;">物流确认收货时间</th>
                                                <th width="5%" style="text-align: center;">顾客备注</th>
                                                <th width="5%" style="text-align: center;">财务备注</th>
                                                <th width="5%" style="text-align: center;">银行名称</th>
                                                <th width="5%" style="text-align: center;">快递单号</th>
                                                <th width="4%" style="text-align: center;">快递公司</th>
                                                <th width="3%" style="text-align: center;">会员SID</th>
                                                <th width="4%" style="text-align: center;">消息来源</th>
                                                <th width="4%" style="text-align: center;">审核人SID</th>
                                                <th width="4%" style="text-align: center;">审核时间</th>
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
											<th width='5%' style='text-align: center;'>退货申请单号</th>
											<th width='6%' style='text-align: center;'>商品明细SID</th>
											<th width='6%' style='text-align: center;'>商品名称</th>
											<th width='6%' style='text-align: center;'>包装单位</th>
											<th width='6%' style='text-align: center;'>计量单位</th>
											<th width='6%' style='text-align: center;'>收银流水号</th>
											<th width='4%' style='text-align: center;'>调拨状态描述</th>
											<th width='4%' style='text-align: center;'>门店名称</th>
											<th width='4%' style='text-align: center;'>原价</th>
											<th width='5%' style='text-align: center;'>销售总数</th>
											<th width='5%' style='text-align: center;'>退货总数</th>
											<th width='5%' style='text-align: center;'>品牌名称</th>
											<th width='5%' style='text-align: center;'>库存类别</th>
											<th width='5%' style='text-align: center;'>退货原因</th>
											<th width='6%' style='text-align: center;'>导购确认收货状态</th>
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
												<tr class="gradeX" id="gradeX{$T.Result.sid}" onclick="trClick({$T.Result.refundApplyNo})">
													<td align="center" id="refundApplyNo_{$T.Result.sid}">{$T.Result.refundApplyNo}</td>
													<td align="center" id="orderNo_{$T.Result.sid}">{$T.Result.orderNo}</td>
													<td align="center" id="refundStatusDesc_{$T.Result.sid}">{$T.Result.refundStatusDesc}</td>
													<td align="center" id="refundmentType_{$T.Result.sid}">
														{#if $T.Result.refundmentType == '1'}退回原帐号
														{#elseif $T.Result.refundmentType == '2'}顾客提供帐号
														{#/if}
													</td>
													<td align="center" id=refundGoodDesc_{$T.Result.sid}">{$T.Result.refundGoodDesc}</td>
													<td align="center" id="applyTime_{$T.Result.sid}">{$T.Result.applyTime}</td>
													<td align="center" id="refundMoneySum_{$T.Result.sid}">{$T.Result.refundMoneySum}</td>
													<td align="center" id="customerPostage_{$T.Result.sid}">{$T.Result.customerPostage}</td>
													<td align="center" id="companyPostage_{$T.Result.sid}">{$T.Result.companyPostage}</td>
													<td align="center" id="refundTicketSnPrice_{$T.Result.sid}">{$T.Result.refundTicketSnPrice}</td>
													<td align="center" id="needRefundMoney_{$T.Result.sid}">{$T.Result.needRefundMoney}</td>
													<td align="center" id="paymentRealName_{$T.Result.sid}">{$T.Result.paymentRealName}</td>
													<td align="center" id="logisticsConfirmTime_{$T.Result.sid}">{$T.Result.logisticsConfirmTime}</td>
													<td align="center" id="customerMemo_{$T.Result.sid}">{$T.Result.customerMemo}</td>
													<td align="center" id="financeMemo_{$T.Result.sid}">{$T.Result.financeMemo}</td>
													<td align="center" id="bankName_{$T.Result.sid}">{$T.Result.bankName}</td>
													<td align="center" id="deliveryNo_{$T.Result.sid}">{$T.Result.deliveryNo}</td>
													<td align="center" id="deliveryCompany_{$T.Result.sid}">{$T.Result.deliveryCompany}</td>
													<td align="center" id="memberSid_{$T.Result.sid}">{$T.Result.memberSid}</td>
													<td align="center" id="fromSystem_{$T.Result.sid}">{$T.Result.fromSystem}</td>
													<td align="center" id="checkUserSid_{$T.Result.sid}">{$T.Result.checkUserSid}</td>
													<td align="center" id="checkTime_{$T.Result.sid}">{$T.Result.checkTime}</td>
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