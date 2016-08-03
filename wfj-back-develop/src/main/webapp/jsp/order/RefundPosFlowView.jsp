<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--Page Related Scripts-->
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<script src="${ctx}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${ctx}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${ctx}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${ctx}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/js/pagination/myPagination/page.css"/>
<!--Bootstrap Date Range Picker-->
<script src="${ctx}/assets/js/datetime/moment.js"></script>
<script src="${ctx}/assets/js/datetime/daterangepicker.js"></script>
<!-- <style type="text/css">
.trClick>td,.trClick>th{
 color:red;
}
</style> -->
  <script type="text/javascript">
		__ctxPath = "${ctx}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var olvPagination;
	var hiddenParam;
	$(function() {
		/* $.ajax({url:__ctxPath + "/DataDictionary/getItemType?dictTypeCode="+51,dataType:"json",async:false,success:function(response){
    		var result = response.list;
           	 var option = "<option value=''>所有</option>";
           	 for(var i=0;i<result.length;i++){
           		 var ele = result[i];
           		 option+="<option value='"+ele.dictItemCode+"'>"+ele.dictItemName+"</option>";
           	 }
           	 $("#shopName_select").append(option);
 		}}); */
 		//退款状态
		$("#flowStatus_select").one("click",function(){
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=refundpay_status",
				dataType: "json",
				success: function(response) {
					var result = response;
					var codeValue = $("#flowStatus_select");
					for ( var i = 0; i < result.list.length; i++) {
						var ele = result.list[i];
						var option;
						option = $("<option value='" + ele.codeValue + "'>"
								+ ele.codeName + "</option>");
						option.appendTo(codeValue);
					}
					return;
				}
			});
		}); 
 		$('#reservation').daterangepicker({
 			timePicker: true,
 			timePicker12Hour:false,
			timePickerIncrement: 1,
			format: 'YYYY/MM/DD HH:mm:ss',
            locale : {
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        });
	    initOlv();
	});
	function olvQuery(){
		$("#orderNo_form").val($("#orderNo_input").val());
		$("#saleNo_form").val($("#saleNo_input").val());
		$("#salesPaymentNo_form").val($("#salesPaymentNo_input").val());
		$("#flowStatus_form").val($("#flowStatus_select").val());
		$("#shopNo_form").val($("#shopNo_input").val());
		$("#payStatus_form").val($("#payStatus_select").val());
		$("#memberNo_form").val($("#memberNo_input").val());
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startFlowTime_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endFlowTime_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startFlowTime_form").val("");
			$("#endFlowTime_form").val("");
		}
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#orderNo_input").val("");
		$("#saleNo_input").val("");
		$("#salesPaymentNo_input").val("");
		$("#flowStatus_select").val("");
		$("#shopNo_input").val("");
		$("#payStatus_select").val("");
		$("#memberNo_input").val("");
		$("#reservation").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/oms/selectPosFlowPage";
		var params = $("#olv_form").serialize();
        params = decodeURI(params);
        hiddenParam = params;
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
             param:hiddenParam,
             dataType: 'json',
             /* ajaxStart: function() {
               ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
             },
             ajaxStop: function() {
               //隐藏加载提示
               setTimeout(function() {
                 ZENG.msgbox.hide();
               }, 300);
             }, */
             ajaxStart : function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive");
					}, 300);
				},
             callback: function(data) {
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
    }
	
	//点击tr事件
	function trClick(salesPaymentNo,obj){
		/* var newTr =  $(obj).clone(true);
		newTr.removeAttr("onclick").removeClass("trClick");
		$("#mainTr").html(newTr);
		$(obj).addClass("trClick").siblings().removeClass("trClick"); */
		var newTr =  $(obj).parent().parent().clone(true);
		 newTr.children().children().removeAttr("onclick").removeClass("trClick");
		 $("#mainTr").html(newTr);
		$(obj).addClass("trClick").siblings().removeClass("trClick");
		var option = "<tr role='row' style='height:35px;'>"+
		"<th width='5%' style='text-align: center;'>收银流水号</th>"+
		"<th width='5%' style='text-align: center;'>退货单号</th>"+
        "<th width='5%' style='text-align: center;'>退单申请号</th>"+
        "<th width='5%' style='text-align: center;'>原销售单号</th>"+
        "<th width='5%' style='text-align: center;'>会员卡号</th>"+
        "<th width='5%' style='text-align: center;'>账号</th>"+
        "<th width='4%' style='text-align: center;'>退货单状态</th>"+
        "<th width='3%' style='text-align: center;'>退货类型</th>"+
        "<th width='4%' style='text-align: center;'>退货类别</th>"+
        "<th width='3%' style='text-align: center;'>退款状态</th>"+
        "<th width='4%' style='text-align: center;'>退款路径</th>"+
        "<th width='4%' style='text-align: center;'>第三方退货单号</th>"+
        "<th width='4%' style='text-align: center;'>订单号</th>"+
        "<th width='4%' style='text-align: center;'>应退金额</th>"+
        "<th width='4%' style='text-align: center;'>实退金额</th>"+
        "<th width='4%' style='text-align: center;'>退货总数</th>"+
        "<th width='4%' style='text-align: center;'>门店名称</th>"+
        "<th width='4%' style='text-align: center;'>供应商名称</th>"+
        "<th width='4%' style='text-align: center;'>专柜名称</th>"+
        "<th width='4%' style='text-align: center;'>机器号</th>"+
        "<th width='4%' style='text-align: center;'>受理人</th>"+
        "<th width='4%' style='text-align: center;'>受理门店</th>"+
        "<th width='5%' style='text-align: center;'>退货时间</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/oms/selectRefundInfoList",
			async:false,
			dataType: "json",
			data:{"salesPaymentNo":salesPaymentNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						//收银流水号
						if(ele.salesPaymentNo=="[object Object]"||ele.salesPaymentNo==undefined){
							option+="<tr style='height:35px;'><td align='center'></td>";
						}else{
							option+="<tr style='height:35px;'><td align='center'>"+ele.salesPaymentNo+"</td>";
						}
						//退货单号
						if(ele.refundNo=="[object Object]"||ele.refundNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundNo+"</td>";
						}
						//退单申请号
						if(ele.refundApplyNo=="[object Object]"||ele.refundApplyNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundApplyNo+"</td>";
						}
						//原销售单号
						if(ele.originalSalesNo=="[object Object]"||ele.originalSalesNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.originalSalesNo+"</td>";
						}
						//会员卡号
						if(ele.memberNo=="[object Object]"||ele.memberNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.memberNo+"</td>";
						}
						//账号
						if(ele.accountNo=="[object Object]"||ele.accountNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.accountNo+"</td>";
						}
						//退货单状态
						if(ele.refundStatusDesc=="[object Object]"||ele.refundStatusDesc==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundStatusDesc+"</td>";
						}
						/* if(ele.refundStatus=="3001"){
							option+="<td align='center'>草稿</td>";
						}else if(ele.refundStatus=="3002"){
							option+="<td align='center'>已打印退货单</td>";
						}else if(ele.refundStatus=="3003"){
							option+="<td align='center'>导购专柜收货</td>";
						}else if(ele.refundStatus=="3004"){
							option+="<td align='center'>取消</td>";
						}else if(ele.refundStatus=="3005"){
							option+="<td align='center'>主管已审核</td>";
						}else{
							option+="<td align='center'></td>";
						} */
						//退货类型
						if(ele.refundType=="1"){
							option+="<td align='center'><span>线上</span></td>";
						}else if(ele.refundType=="2"){
							option+="<td align='center'><span>线下</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						//退货类别
						if(ele.refundClass=="1"){
							option+="<td align='center'>退货单</td>";
						}else if(ele.refundClass=="2"){
							option+="<td align='center'><span class='btn btn-xs'>换货换入</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						//退款状态
						if(ele.rebateStatus=="0"){
							option+="<td align='center'><span>未退款</span></td>";
						}else if(ele.rebateStatus=="1"){
							option+="<td align='center'><span>已退款</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						//退款路径
						if(ele.refundTarget=="1"){
							option+="<td align='center'>原路退</td>";
						}else if(ele.refundTarget=="2"){
							option+="<td align='center'>站内余额</td>";
						}else{
							option+="<td align='center'></td>";
						}
						//第三方退货单号
						if(ele.externalRefundNo=="[object Object]"||ele.externalRefundNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.externalRefundNo+"</td>";
						}
						//订单号
						if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.orderNo+"</td>";
						}
						//应退金额
						if(ele.refundAmount=="[object Object]"||ele.refundAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundAmount+"</td>";
						}
						//实退金额
						if(ele.needRefundAmount=="[object Object]"||ele.needRefundAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.needRefundAmount+"</td>";
						}
						//退货总数
						if(ele.refundNum=="[object Object]"||ele.refundNum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundNum+"</td>";
						}
						//门店名称
						if(ele.shopName=="[object Object]"||ele.shopName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.shopName+"</td>";
						}
						//供应商名称
						if(ele.supplyName=="[object Object]"||ele.supplyName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.supplyName+"</td>";
						}
						//专柜名称
						if(ele.shoppeName=="[object Object]"||ele.shoppeName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.shoppeName+"</td>";
						}
						//机器号
						if(ele.casherNo=="[object Object]"||ele.casherNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.casherNo+"</td>";
						}
						//受理人
						if(ele.operator=="[object Object]"||ele.operator==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.operator+"</td>";
						}
						//受理门店
						if(ele.operatorStore=="[object Object]"||ele.operatorStore==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.operatorStore+"</td>";
						}
						//退货时间
						if(ele.refundTimeStr=="[object Object]"||ele.refundTimeStr==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundTimeStr+"</td>";
						}
					}
				}
			}
		});
		var option2 = "<tr role='row' style='height:35px;'>"+
		"<th width='5%' style='text-align: center;'>款机流水号</th>"+
		"<th width='5%' style='text-align: center;'>流水明细号</th>"+
		"<th width='3%' style='text-align: center;'>行号</th>"+
		"<th width='5%' style='text-align: center;'>退货单号</th>"+
		"<th width='3%' style='text-align: center;'>总应收</th>"+
		"<th width='4%' style='text-align: center;'>专柜商品编号</th>"+
		"<th width='5%' style='text-align: center;'>退货明细号</th>"+
		"<th width='3%' style='text-align: center;'>退货数量</th>"+
		"<th width='3%' style='text-align: center;'>ERP商品编号</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/oms/selectFlowItemList",
			async:false,
			dataType: "json",
			data:{"salesPaymentNo":salesPaymentNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						//款机流水号
						if(ele.salesPaymentNo=="[object Object]"||ele.salesPaymentNo==undefined){
							option2+="<tr style='height:35px;overflow-X:hidden;'><td align='center'></td>";
						}else{
							option2+="<tr style='height:35px;overflow-X:hidden;'><td align='center'>"+ele.salesPaymentNo+"</td>";
						}
						//流水明细号
						if(ele.flowItemNo=="[object Object]"||ele.flowItemNo==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.flowItemNo+"</td>";
						}
						//行号
						if(ele.rowNo=="[object Object]"||ele.rowNo==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.rowNo+"</td>";
						}
						//退货单号
						if(ele.saleNo=="[object Object]"||ele.saleNo==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.saleNo+"</td>";
						}
						//总应收
						if(ele.paymentAmount=="[object Object]"||ele.paymentAmount==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.paymentAmount+"</td>";
						}
						//专柜商品编号
						if(ele.supplyProductNo=="[object Object]"||ele.supplyProductNo==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.supplyProductNo+"</td>";
						}
						//退货明细号
						if(ele.salesItemId=="[object Object]"||ele.salesItemId==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.salesItemId+"</td>";
						}
						//退货数量
						if(ele.saleSum=="[object Object]"||ele.saleSum==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.saleSum+"</td>";
						}
						//ERP商品编号
						if(ele.erpProductNo=="[object Object]"||ele.erpProductNo==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.erpProductNo+"</td>";
						}
						
					}
				}
			}
		});
		var option3 = "<tr role='row' style='height:35px;'>"+
		"<th width='5%' style='text-align: center;'>款机流水号</th>"+
		"<th width='3%' style='text-align: center;'>一级支付介质</th>"+
		"<th width='3%' style='text-align: center;'>二级支付介质</th>"+
		"<th width='3%' style='text-align: center;'>支付金额</th>"+
		"<th width='3%' style='text-align: center;'>实际抵扣金额</th>"+
		"<th width='3%' style='text-align: center;'>汇率</th>"+
		"<th width='3%' style='text-align: center;'>支付账号</th>"+
		"<th width='3%' style='text-align: center;'>会员id</th>"+
		"<th width='3%' style='text-align: center;'>支付流水号</th>"+
		"<th width='3%' style='text-align: center;'>优惠券类型</th>"+
		"<th width='3%' style='text-align: center;'>优惠券批次</th>"+
		"<th width='3%' style='text-align: center;'>券模板名称</th>"+
		"<th width='3%' style='text-align: center;'>活动号</th>"+
		"<th width='3%' style='text-align: center;'>收券规则</th>"+
		"<th width='5%' style='text-align: center;'>收券规则描述</th>"+
		"<th width='3%' style='text-align: center;'>结余</th>"+
		"<th width='3%' style='text-align: center;'>备注</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/oms/selectPayments",
			async:false,
			dataType: "json",
			data:{"salesPaymentNo":salesPaymentNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						//款机流水号
						if(ele.posFlowNo=="[object Object]"||ele.posFlowNo==undefined){
							option3+="<tr style='height:35px;overflow-X:hidden;'><td align='center'></td>";
						}else{
							option3+="<tr style='height:35px;overflow-X:hidden;'><td align='center'>"+ele.posFlowNo+"</td>";
						}
						//一级支付介质
						if(ele.paymentClass=="[object Object]"||ele.paymentClass==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.paymentClass+"</td>";
						}
						//二级支付介质
						if(ele.paymentType=="[object Object]"||ele.paymentType==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.paymentType+"</td>";
						}
						//支付金额
						if(ele.amount=="[object Object]"||ele.amount==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.amount+"</td>";
						}
						//实际抵扣金额
						if(ele.acturalAmount=="[object Object]"||ele.acturalAmount==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.acturalAmount+"</td>";
						}
						//汇率
						if(ele.rate=="[object Object]"||ele.rate==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.rate+"</td>";
						}
						//支付账号
						if(ele.account=="[object Object]"||ele.account==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.account+"</td>";
						}
						//会员id
						if(ele.userId=="[object Object]"||ele.userId==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.userId+"</td>";
						}
						//支付流水号
						if(ele.payFlowNo=="[object Object]"||ele.payFlowNo==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.payFlowNo+"</td>";
						}
						//优惠券类型
						if(ele.couponType=="[object Object]"||ele.couponType==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.couponType+"</td>";
						}
						//优惠券批次
						if(ele.couponBatch=="[object Object]"||ele.couponBatch==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.couponBatch+"</td>";
						}
						//券模板名称
						if(ele.couponName=="[object Object]"||ele.couponName==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.couponName+"</td>";
						}
						//活动号
						if(ele.activityNo=="[object Object]"||ele.activityNo==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.activityNo+"</td>";
						}
						//收券规则
						if(ele.couponRule=="[object Object]"||ele.couponRule==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.couponRule+"</td>";
						}
						//收券规则描述
						if(ele.couponRuleName=="[object Object]"||ele.couponRuleName==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.couponRuleName+"</td>";
						}
						//结余
						if(ele.cashBalance=="[object Object]"||ele.cashBalance==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.cashBalance+"</td>";
						}
						//备注
						if(ele.remark=="[object Object]"||ele.remark==undefined){
							option3+="<td align='center'></td></tr>";
						}else{
							option3+="<td align='center'>"+ele.remark+"</td></tr>";
						}
						
					}
				}
			}
		});
		$("#OLV1_tab").html(option);
		$("#OLV2_tab").html(option2);
		$("#OLV3_tab").html(option3);
		$("#divTitle").html("退款信息详情");
		$("#btDiv").show();
	}
	function closeBtDiv(){
		$("#btDiv").hide();
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
		$("#pageBody").load(__ctxPath+"/jsp/OrderListView.jsp");
	}
	</script> 
</head>
<body>
	<input type="hidden" id="ctxPath" value="${ctx}" />
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
                                    <h5 class="widget-caption">退款信息管理</h5>
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
										        <label class="titname">支付时间：</label>
										        <input type="text" id="reservation"  />
										    </li>
										    <li class="col-md-4">
										        <label class="titname">小票号：</label>
										        <input type="text" id="salesPaymentNo_input" />
										    </li>
										    <li class="col-md-4">
										        <label class="titname">会员卡号：</label>
										        <input type="text" id="memberNo_input" />
										    </li>
										    <li class="col-md-4">
										        <label class="titname">门店号：</label>
										        <input type="text" id="shopNo_input" />
										    </li>
										    <li class="col-md-4">
	                                 			<label class="titname">退款状态：</label>
	                                 			<select id="flowStatus_select" style="padding:0 0;">
		                                			<option value="">所有</option>
		                                			<!-- <option value="1">已退款</option>
		                                			<option value="0">未退款</option> -->
		                                		</select>
	                                 		</li>
										    <li class="col-md-4">
										    	<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
												<a class="btn btn-default shiny" onclick="reset();">重置</a>
										       <!--  <a id="editabledatatable_new" onclick="olvQuery();" class="btn btn-yellow" style="width: 37%;">
										            <i class="fa fa-eye"></i>
										            查询
										        </a>&nbsp;&nbsp;
										        <a id="editabledatatable_new" onclick="reset();" class="btn btn-primary" style="width: 37%;">
										            <i class="fa fa-random"></i>
										            重置
										        </a> -->
										    </li>
										</ul>
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="10"/>
											<input type="hidden" id="isRefund" name="isRefund" value="1"/>
											<!-- <input type="hidden" id="flowStatus" name="flowStatus" value="1"/> -->
											<input type="hidden" id="salesPaymentNo_form" name="salesPaymentNo"/>
											<input type="hidden" id="shopNo_form" name="shopNo"/>
											<input type="hidden" id="flowStatus_form" name="flowStatus"/>
											<input type="hidden" id="memberNo_form" name="memberNo"/>
											<input type="hidden" id="startFlowTime_form" name="startFlowTime"/>
											<input type="hidden" id="endFlowTime_form" name="endFlowTime"/>
                                      	</form>
                                	<div style="width:100%; min-height:300px; height:0%; overflow-Y: hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 400%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                <th width="4%" style="text-align: center;">款机流水号</th>
                                                <th width="3%" style="text-align: center;">总金额</th>
                                                <th width="3%" style="text-align: center;">交易流水号</th>
                                                <th width="3%" style="text-align: center;">机器号</th>
                                                <th width="3%" style="text-align: center;">线上线下标识</th>
                                                <th width="3%" style="text-align: center;">支付时间</th>
                                                <th width="3%" style="text-align: center;">总折扣</th>
                                                <th width="3%" style="text-align: center;">总应收</th>
                                                <th width="3%" style="text-align: center;">实际支付</th>
                                                <th width="3%" style="text-align: center;">找零</th>
                                                <th width="3%" style="text-align: center;">折扣额</th>
                                                <th width="3%" style="text-align: center;">折让额</th>
                                                <th width="3%" style="text-align: center;">会员总折扣</th>
												<th width="3%" style="text-align: center;">优惠折扣额</th>
												<th width="3%" style="text-align: center;">收银损益</th>
												<th width="3%" style="text-align: center;">收银员号</th>
												<th width="3%" style="text-align: center;">班次</th>
												<th width="3%" style="text-align: center;">渠道标志</th>
												<th width="3%" style="text-align: center;">金卡</th>
												<th width="3%" style="text-align: center;">微信卡门店号</th>
												<th width="3%" style="text-align: center;">会员卡号</th>
												<th width="3%" style="text-align: center;">订单号</th>
												<th width="3%" style="text-align: center;">授权卡号</th>
												<th width="3%" style="text-align: center;">人民币</th>
												<th width="3%" style="text-align: center;">电子返券</th>
												<th width="3%" style="text-align: center;">电子扣回</th>
												<th width="3%" style="text-align: center;">银行手续费</th>
												<th width="3%" style="text-align: center;">来源</th>
												<th width="3%" style="text-align: center;">门店号</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    </div>
                                    <div id="olvPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.salesPaymentNo}" style="height:35px;">
													<td align="center" id="salesPaymentNo_{$T.Result.salesPaymentNo}">
														
						                   				<a onclick="trClick('{$T.Result.salesPaymentNo}',this);" style="cursor:pointer;">
															{#if $T.Result.salesPaymentNo != '[object Object]'}{$T.Result.salesPaymentNo}
						                   					{#/if}
														</a>
													</td>
													<td align="center" id="money_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.money}
						                   				{#/if}
													</td>
													<td align="center" id="ooFlag_{$T.Result.salesPaymentNo}">
														{#if $T.Result.ooFlag == '0'}线下
						                      			{#elseif $T.Result.ooFlag == '1'}线上
						                   				{#/if}
													</td>
													<td align="center" id="payFlowNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.payFlowNo}
						                   				{#/if}
													</td>
													<td align="center" id="posNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.posNo == '1'}
															<span>线上</span>
						                      			{#elseif $T.Result.posNo == '2'}
						                      				<span>线下</span>
						                   				{#/if}
													</td>
													<td align="center" id="payTimeStr_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.payTimeStr}
						                   				{#/if}
													</td>
													<td align="center" id="totalDiscountAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.totalDiscountAmount}%
						                   				{#/if}
													</td>
													<td align="center" id="paymentAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.paymentAmount}
						                   				{#/if}
													</td>
													<td align="center" id="actualPaymentAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.actualPaymentAmount}
						                   				{#/if}
													</td>
													<td align="center" id="changeAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.changeAmount}
						                   				{#/if}
													</td>
													<td align="center" id="tempDiscountAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.tempDiscountAmount}
						                   				{#/if}
													</td>
													<td align="center" id="zrAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.zrAmount}
						                   				{#/if}
													</td>
													<td align="center" id="memberDiscountAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.memberDiscountAmount != '[object Object]'}{$T.Result.memberDiscountAmount}
						                   				{#/if}
													</td>
													<td align="center" id="promDiscountAmount_{$T.Result.salesPaymentNo}">
														{#if $T.Result.promDiscountAmount != '[object Object]'}{$T.Result.promDiscountAmount}
						                   				{#/if}
													</td>
													<td align="center" id="income_{$T.Result.salesPaymentNo}">
														{#if $T.Result.income != '[object Object]'}{$T.Result.income}
						                   				{#/if}
													</td>
													<td align="center" id="casher_{$T.Result.salesPaymentNo}">
														{#if $T.Result.casher != '[object Object]'}{$T.Result.casher}
						                   				{#/if}
													</td>
													<td align="center" id="shifts_{$T.Result.salesPaymentNo}">
														{#if $T.Result.shifts != '[object Object]'}{$T.Result.shifts}
						                   				{#/if}
													</td>
													<td align="center" id="channel_{$T.Result.salesPaymentNo}">
														{#if $T.Result.channel != '[object Object]'}{$T.Result.channel}
						                   				{#/if}
													</td>
													<td align="center" id="weixinCard_{$T.Result.salesPaymentNo}">
														{#if $T.Result.weixinCard != '[object Object]'}{$T.Result.weixinCard}
						                   				{#/if}
													</td>
													<td align="center" id="weixinStoreNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.weixinStoreNo != '[object Object]'}{$T.Result.weixinStoreNo}
						                   				{#/if}
													</td>
													<td align="center" id="memberNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.memberNo != '[object Object]'}{$T.Result.memberNo}
						                   				{#/if}
													</td>
													<td align="center" id="orderNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.orderNo != '[object Object]'}{$T.Result.orderNo}
						                   				{#/if}
													</td>
													<td align="center" id="authorizationNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.authorizationNo != '[object Object]'}{$T.Result.authorizationNo}
						                   				{#/if}
													</td>
													<td align="center" id="rmb_{$T.Result.salesPaymentNo}">
														{#if $T.Result.rmb != '[object Object]'}{$T.Result.rmb}
						                   				{#/if}
													</td>
													<td align="center" id="elecGet_{$T.Result.salesPaymentNo}">
														{#if $T.Result.elecGet != '[object Object]'}{$T.Result.elecGet}
						                   				{#/if}
													</td>
													<td align="center" id="elecDeducation_{$T.Result.salesPaymentNo}">
														{#if $T.Result.elecDeducation != '[object Object]'}{$T.Result.elecDeducation}
						                   				{#/if}
													</td>
													<td align="center" id="bankServiceCharge_{$T.Result.salesPaymentNo}">
														{#if $T.Result.bankServiceCharge != '[object Object]'}{$T.Result.bankServiceCharge}
						                   				{#/if}
													</td>
													<td align="center" id="sourceType_{$T.Result.salesPaymentNo}">
														{#if $T.Result.sourceType != '[object Object]'}{$T.Result.sourceType}
						                   				{#/if}
													</td>
													<td align="center" id="shopNo_{$T.Result.salesPaymentNo}">
														{#if $T.Result.elecGet != '[object Object]'}{$T.Result.shopNo}
						                   				{#/if}
													</td>
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
    <div class="modal modal-darkorange" id="btDiv">
        <div class="modal-dialog" style="width: 800px;height:80%;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv();">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12" style="overflow-Y: hidden;">
			                
			                <table class="table-striped table-hover table-bordered" style="width: 500%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                <th width="4%" style="text-align: center;">款机流水号</th>
                                                <th width="3%" style="text-align: center;">总金额</th>
                                                <th width="3%" style="text-align: center;">交易流水号</th>
                                                <th width="3%" style="text-align: center;">机器号</th>
                                                <th width="3%" style="text-align: center;">线上线下标识</th>
                                                <th width="4%" style="text-align: center;">支付时间</th>
                                                <th width="3%" style="text-align: center;">总折扣</th>
                                                <th width="3%" style="text-align: center;">总应收</th>
                                                <th width="3%" style="text-align: center;">实际支付</th>
                                                <th width="3%" style="text-align: center;">找零</th>
                                                <th width="3%" style="text-align: center;">折扣额</th>
                                                <th width="3%" style="text-align: center;">折让额</th>
                                                <th width="3%" style="text-align: center;">会员总折扣</th>
												<th width="3%" style="text-align: center;">优惠折扣额</th>
												<th width="3%" style="text-align: center;">收银损益</th>
												<th width="3%" style="text-align: center;">收银员号</th>
												<th width="3%" style="text-align: center;">班次</th>
												<th width="3%" style="text-align: center;">渠道标志</th>
												<th width="4%" style="text-align: center;">金卡</th>
												<th width="3%" style="text-align: center;">微信卡门店号</th>
												<th width="3%" style="text-align: center;">会员卡号</th>
												<th width="3%" style="text-align: center;">订单号</th>
												<th width="3%" style="text-align: center;">授权卡号</th>
												<th width="3%" style="text-align: center;">人民币</th>
												<th width="3%" style="text-align: center;">电子返券</th>
												<th width="3%" style="text-align: center;">电子扣回</th>
												<th width="3%" style="text-align: center;">银行手续费</th>
												<th width="3%" style="text-align: center;">来源</th>
												<th width="3%" style="text-align: center;">门店号</th>
                                            </tr>
                                        </thead>
                                        <tbody id="mainTr">
                                        </tbody>
                                    </table>
			                
                		</div>
                	</div>
                </div>
                
                <div class="tabbable"> <!-- Only required for left/right tabs -->
					      <ul class="nav nav-tabs">
					        <li class="active"><a href="#tab1" data-toggle="tab">退货单信息</a></li>
					        <li><a href="#tab2" data-toggle="tab">流水明细信息</a></li>
					        <li><a href="#tab3" data-toggle="tab">退款介质信息</a></li>
					      </ul>
					      <div class="tab-content">
					        <div class="tab-pane active" id="tab1">
					                <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV1_tab" style="width: 400%;background-color: #fff;margin-bottom: 0;">
					                    </table>
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
					                    <table class="table-striped table-hover table-bordered" id="OLV3_tab" style="width: 250%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					        </div>
					      </div>
					    </div>
                
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv();" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    <script>
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