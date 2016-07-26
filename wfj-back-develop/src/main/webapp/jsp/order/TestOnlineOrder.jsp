<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<%request.setAttribute("ctx", request.getContextPath());%>
<script
	src="${ctx}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
<script
	src="${ctx}/js/pagination/msgbox/msgbox.js">  </script>
<script
	src="${ctx}/js/pagination/jTemplates/jquery-jtemplates.js">   </script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/pagination/myPagination/page.css" />
<!--Bootstrap Date Range Picker-->
<script
	src="${ctx}/assets/js/datetime/moment.js"></script>
<script
	src="${ctx}/assets/js/datetime/daterangepicker.js"></script>
<script type="text/javascript">
		__ctxPath = "${ctx}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	<% 
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 

	java.util.Date currentTime = new java.util.Date();//得到当前系统时间 

	String str_date1 = formatter.format(currentTime); //将日期时间格式化 

	%>
	
	//创建订单
	function foundSale(){
		$("#divTitle1").html("旗舰店下订单");
		$("#found_sale").html("");
		$("#found_sale1").html("");
		$("#btDiv1").show();
   	}
	/* function getSumo(obj){
		var trProduct = $(obj).parent().parent();
		var sNum = $("#saleSum1").val();
		var num = trProduct.find("[name='saleSum']").val();
		$("#saleSum1").val(sNum*1+num*1);
	} */
	function foundSale1(){
		var saleData = $("#theForm1").serialize();
		$("#found_sale").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/foundOrder";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(1);
					$("#found_sale1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg1").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg1").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//创建订单（云店）
	function creatOrder(){
		$("#divTitle33").html("云店下订单");
		$("#found_sale").html("");
		$("#found_sale1").html("");
		$("#btDiv33").show();
   	}
	function getSumyo(obj){
		var trProduct = $(obj).parent().parent();
		var sNum = $("#saleSumy1").val();
		var num = trProduct.find("[name='saleSum']").val();
		$("#saleSumy1").val(sNum*1+num*1);
	}
	function creatOrder1(){
		var saleData = $("#theForm33").serialize();
		$("#found_sale").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/createYunOrder";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(33);
					$("#found_sale1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg33").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg33").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//创建订单
	function createOrder(){
		$("#divTitle333").html("创建订单");
		$("#found_sale").html("");
		$("#found_sale1").html("");
		$("#btDiv333").show();
   	}
	function getSumso(obj){
		var trProduct = $(obj).parent().parent();
		var sNum = $("#saleSumy2").val();
		var num = trProduct.find("[name='saleSum']").val();
		$("#saleSumy2").val(sNum*1+num*1);
		
		var salesAmount = $("#salesAmounts").val();
		var salesPrice = trProduct.find("[name='salesPrice']").val();
		$("#salesAmounts").val(num*1*salesPrice*1+salesAmount*1);
	}
	function createOrder1(){
		var saleData = $("#theForm333").serialize();
		$("#found_sale").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/createSunOrder";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(333);
					$("#found_sale1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg333").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg333").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//订单支付
	function salePos(){
		$("#divTitle3").html("订单支付");
		$("#sale_pos").html("");
		$("#sale_pos1").html("");
		$("#btDiv3").show();
   	}
	function salePos1(){
		var saleData = $("#theForm3").serialize();
		$("#sale_pos").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/salePos";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(3);
					$("#sale_pos1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg3").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg3").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//订单审核
	function salePay(){
		$("#divTitle10").html("订单审核");
		$("#fundOrderInput").html("");
		$("#sale_pos").html("");
		$("#sale_pos1").html("");
		$("#btDiv10").show();
		$("#pro101").hide();
   	}
	function orderSh(){
		var saleData = $("#theForm10").serialize();
		$("#sale_pos").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/orderCheck";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(10);
					$("#sale_pos1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg10").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg10").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//订单取消
	function orderCancel(){
		$("#divTitle101").html("订单取消");
		$("#sale_pos").html("");
		$("#sale_pos1").html("");
		$("#btDiv101").show();
   	}
	function orderDis(){
		var saleData = $("#theForm101").serialize();
		$("#sale_pos").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/orderCancel";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(101);
					$("#sale_pos1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg101").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg101").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//查询订单
	function fundOrder(){
		$("#pro101").show();
		var d = $("#theForm10").serialize();
		var url = __ctxPath + "/testOnlineOmsOrder/foundByOrder";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: d,
			success: function(response) {
				if(response.success=='true'){
					$("#fundOrderInput").html(JSON.stringify(response));
				}else{
					$("#fundOrderInput").html(JSON.stringify(response));
				}
				return;
			}
		});
	}
	//查询订单支付价格
	function fundOrderMoney(){
		var d = $("#theForm3").serialize();
		var url = __ctxPath + "/testOnlineOmsOrder/foundByOrder";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: d,
			success: function(response) {
				if(response.success=='true'){
					$("#orderMoney").val(response.data.list[0].cashAmount);
				}else{
					$("#orderMoney").val("");
				}
				return;
			}
		});
	}
	//保存包裹单
	function printSale(){
		$("#divTitle2").html("保存包裹单");
		$("#print_sale").html("");
		$("#print_sale1").html("");
		$("#btDiv2").show();
   	}
	function printSale1(){
		var saleData = $("#theForm2").serialize();
		$("#print_sale").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/savePackage";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(2);
					$("#print_sale1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg2").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg2").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//包裹单状态修改
	function saveInvoice(){
		$("#divTitle18").html("包裹单状态");
		$("#print_sale").html("");
		$("#print_sale1").html("");
		$("#btDiv18").show();
   	}
	function saveInvoice1(){
		var saleData = $("#theForm18").serialize();
		$("#print_sale").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/updatePackage";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(18);
					$("#print_sale1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg18").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg18").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//物流状态修改
	function invoiceCancel(){
		$("#divTitle22").html("物流状态");
		$("#print_sale").html("");
		$("#print_sale1").html("");
		$("#btDiv22").show();
   	}
	function invoiceCancel1(){
		var saleData = $("#theForm22").serialize();
		$("#print_sale").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/updatePackageHistory";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(22);
					$("#print_sale1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg22").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg22").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//创建发票
	function createInvoice(){
		$("#divTitle38").html("创建发票");
		$("#invoice_input").html("");
		$("#invoice_input1").html("");
		$("#btDiv38").show();
   	}
	function createInvoice1(){
		var saleData = $("#theForm38").serialize();
		$("#invoice_input").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/createInvoice";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(38);
					$("#invoice_input1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg38").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg38").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//仓内打印
	function updateSaleStatus(){
		$("#divTitle28").html("仓内打印");
		$("#sale_status").html("");
		$("#sale_status1").html("");
		$("#btDiv28").show();
   	}
	function updateSaleStatus1(){
		var saleData = $("#theForm28").serialize();
		$("#sale_status").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/updateSaleStatus";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(28);
					$("#sale_status1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg28").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg28").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//仓内复核
	function updateSaleStatusd(){
		$("#divTitle281").html("仓内复核");
		$("#sale_status").html("");
		$("#sale_status1").html("");
		$("#btDiv281").show();
   	}
	function updateSaleStatusd1(){
		var saleData = $("#theForm281").serialize();
		$("#sale_status").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/updateSaleStatus";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(281);
					$("#sale_status1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg281").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg281").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//仓内打包
	function updateSaleStatuse(){
		$("#divTitle282").html("仓内打包");
		$("#sale_status").html("");
		$("#sale_status1").html("");
		$("#btDiv282").show();
   	}
	function updateSaleStatuse1(){
		var saleData = $("#theForm282").serialize();
		$("#sale_status").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/updateSaleStatus";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(282);
					$("#sale_status1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg282").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg282").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//仓内出库
	function updateSaleStatusr(){
		$("#divTitle283").html("仓内出库");
		$("#sale_status").html("");
		$("#sale_status1").html("");
		$("#btDiv283").show();
   	}
	function updateSaleStatusr1(){
		var saleData = $("#theForm283").serialize();
		$("#sale_status").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/updateSaleStatus";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(283);
					$("#sale_status1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg283").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg283").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//修改退货单状态
	function updateRefundStatus(){
		$("#divTitle29").html("修改退货单状态");
		$("#update_status").html("");
		$("#update_status1").html("");
		$("#btDiv29").show();
   	}
	function updateRefundStatus1(){
		var saleData = $("#theForm29").serialize();
		$("#update_status").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/updateRefundStatus";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(29);
					$("#update_status1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg29").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg29").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//PAD创建
	function salePadCreat(){
		$("#divTitle11").html("PAD创建");
		$("#sale_pad").html("");
		$("#sale_pad1").html("");
		$("#btDiv11").show();
   	}
	
	function salePadCreat1(){
		var saleData = $("#theForm11").serialize();
		$("#sale_pad").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/salePadCreat";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(11);
					$("#sale_pad1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg11").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg11").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//款机流水作废
	function salePadCancel(){
		$("#divTitle19").html("款机流水作废");
		$("#sale_pad").html("");
		$("#sale_pad1").html("");
		$("#btDiv19").show();
   	}
	
	function salePadCancel1(){
		var saleData = $("#theForm19").serialize();
		$("#sale_pad").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/salePadCancel";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(19);
					$("#sale_pad1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg19").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg19").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	
	//PAD添加销售单
	function salePadAdd(){
		$("#divTitle12").html("PAD添加销售单");
		$("#sale_pad").html("");
		$("#sale_pad1").html("");
		$("#btDiv12").show();
   	}
	
	function salePadAdd1(){
		var saleData = $("#theForm12").serialize();
		$("#sale_pad").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/salePadAdd";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(12);
					$("#sale_pad1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg12").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg12").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	
	//PAD取消
	function salePadCancle(){
		$("#divTitle13").html("PAD取消");
		$("#sale_pad").html("");
		$("#sale_pad1").html("");
		$("#btDiv13").show();
   	}
	
	function salePadCancle1(){
		var saleData = $("#theForm13").serialize();
		$("#sale_pad").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/salePadCancle";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(13);
					$("#sale_pad1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg13").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg13").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//PAD支付
	function salePad(){
		$("#divTitle14").html("PAD支付");
		$("#sale_pad").html("");
		$("#sale_pad1").html("");
		$("#btDiv14").show();
   	}
	
	function salePad1(){
		var saleData = $("#theForm14").serialize();
		$("#sale_pad").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/salePad";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(14);
					$("#sale_pad1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg14").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg14").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//PAD打印款机
	function printPay(){
		$("#divTitle15").html("PAD打印款机");
		$("#print_pay").html("");
		$("#print_pay1").html("");
		$("#btDiv15").show();
   	}
	
	function printPay1(){
		var saleData = $("#theForm15").serialize();
		$("#print_pay").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/printPay";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(15);
					$("#print_pay1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg15").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg15").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	
	//作废销售单
	function saleCancel(){
		$("#divTitle16").html("作废销售单");
		$("#bills_cancel").html("");
		$("#bills_cancel1").html("");
		$("#btDiv16").show();
   	}
	
	function saleCancel1(){
		var saleData = $("#theForm16").serialize();
		$("#bills_cancel").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/saleCancel";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(16);
					$("#bills_cancel1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg16").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg16").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//作废退货单
	function refundCancel(){
		$("#divTitle17").html("作废退货单");
		$("#bills_cancel").html("");
		$("#bills_cancel1").html("");
		$("#btDiv17").show();
   	}
	
	function refundCancel1(){
		var saleData = $("#theForm17").serialize();
		$("#bills_cancel").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/refundCancel";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(17);
					$("#bills_cancel1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg17").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg17").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	
	//顾客确认提货
	function takeStock(){
		$("#divTitle4").html("顾客确认提货");
		$("#take_stock").html("");
		$("#take_stock1").html("");
		$("#btDiv4").show();
   	}
	
	function takeStock1(){
		var saleData = $("#theForm4").serialize();
		$("#take_stock").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/takeStock";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(4);
					$("#take_stock1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg4").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg4").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	
	
	//创建退货申请单
	function foundRefund(){
		$("#divTitle5").html("创建退货申请单");
		$("#found_refund").html("");
		$("#found_refund1").html("");
		$("#btDiv5").show();
   	}
	function getSum(obj){
		var trProduct = $(obj).parent().parent();
		var rNum = $("#refundNum").val();
		var num = trProduct.find("[name='refundNum1']").val();
		$("#refundNum").val(rNum*1+num*1);
	}
	function foundRefund1(){
		var saleData = $("#theForm5").serialize();
		$("#found_refund").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/createRefund";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(5);
					$("#found_refund1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg5").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg5").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//客服创建退货申请单
	function createKeRefund(){
		$("#divTitle51").html("客服创建退货申请单");
		$("#found_refund").html("");
		$("#found_refund1").html("");
		$("#btDiv51").show();
   	}
	function getKeSum(obj){
		var trProduct = $(obj).parent().parent();
		var rNum = $("#refundNum5").val();
		var num = trProduct.find("[name='refundNum15']").val();
		$("#refundNum5").val(rNum*1+num*1);
	}
	function createKeRefund1(){
		var saleData = $("#theForm51").serialize();
		$("#found_refund").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/createKeRefund";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(51);
					$("#found_refund1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg51").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg51").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//缺货退货创建申请单
	function createInerimRefund(){
		$("#divTitle52").html("缺货退货创建申请单");
		$("#found_refund").html("");
		$("#found_refund1").html("");
		$("#btDiv52").show();
   	}
	function createInerimRefund1(){
		var saleData = $("#theForm52").serialize();
		$("#found_refund").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/createInerimRefund";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(52);
					$("#found_refund1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg52").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg52").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//拒收退货创建申请单
	function createRefuseRefund(){
		$("#divTitle53").html("拒收退货创建申请单");
		$("#found_refund").html("");
		$("#found_refund1").html("");
		$("#btDiv53").show();
   	}
	function createRefuseRefund1(){
		var saleData = $("#theForm53").serialize();
		$("#found_refund").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/updatePackageHistory";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(53);
					$("#found_refund1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg53").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg53").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//退货申请单审核
	function refundPay(){
		$("#divTitle111").html("退货申请单审核");
		$("#fundRefundInput").html("");
		$("#refund_pos").html("");
		$("#refund_pos1").html("");
		$("#btDiv111").show();
		$("#pro102").hide();
   	}
	function refundCheck(){
		var refundData = $("#theForm111").serialize();
		$("#refund_pos").html("输入参数："+refundData);
		var url = __ctxPath + "/testOnlineOmsOrder/refundCheck";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: refundData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(111);
					$("#refund_pos1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg111").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg111").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//订单取消
	function refundApplyCancel(){
		$("#divTitle102").html("退货申请单取消");
		$("#refund_pos").html("");
		$("#refund_pos1").html("");
		$("#btDiv102").show();
   	}
	function refundApplyDis(){
		var saleData = $("#theForm102").serialize();
		$("#refund_pos").html("输入参数："+saleData);
		var url = __ctxPath + "/testOnlineOmsOrder/refundApplyCancel";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(102);
					$("#refund_pos1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg102").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg102").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	//查询退货申请单
	function fundRefundApply(){
		$("#pro102").show();
		var d = $("#theForm111").serialize();
		var url = __ctxPath + "/testOnlineOmsOrder/foundByRefund";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: d,
			success: function(response) {
				if(response.success=='true'){
					$("#fundRefundInput").html(JSON.stringify(response));
				}else{
					$("#fundRefundInput").html(JSON.stringify(response));
				}
				return;
			}
		});
	}
	//打印退货单
	function printRefund(){
		$("#divTitle6").html("打印退货单");
		$("#print_refund").html("");
		$("#print_refund1").html("");
		$("#btDiv6").show();
   	}
	
	function printRefund1(){
		var saleData = $("#theForm6").serialize();
		$("#print_refund").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/printRefund";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(6);
					$("#print_refund1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg6").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg6").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	
	//退货单审核
	function examineRefund(){
		$("#divTitle7").html("退货单审核");
		$("#examine_refund").html("");
		$("#examine_refund1").html("");
		$("#btDiv7").show();
   	}
	
	function examineRefund1(){
		var saleData = $("#theForm7").serialize();
		$("#examine_refund").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/examineRefund";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(7);
					$("#examine_refund1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg7").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg7").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	
	//退货单退款
	function refundPos(){
		$("#divTitle8").html("退货单退款");
		$("#refundPay_pos").html("");
		$("#refundPay_pos1").html("");
		$("#btDiv8").show();
   	}
	
	function refundPos1(){
		var saleData = $("#theForm8").serialize();
		$("#refundPay_pos").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/refundPos";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(8);
					$("#refundPay_pos1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg8").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg8").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	
	
	//导购确认还库
	function returnStock(){
		$("#divTitle9").html("导购确认还库");
		$("#return_stock").html("");
		$("#return_stock1").html("");
		$("#btDiv9").show();
   	}
	
	function returnStock1(){
		var saleData = $("#theForm9").serialize();
		$("#return_stock").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/returnStock";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(9);
					$("#return_stock1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg9").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg9").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//创建换货单
	function foundExchange(){
		$("#divTitle20").html("创建换货单");
		$("#return_stock").html("");
		$("#return_stock1").html("");
		$("#btDiv20").show();
   	}
	
	function foundExchange1(){
		var saleData = $("#theForm20").serialize();
		$("#exchange").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/foundExchange";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(20);
					$("#exchange1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg20").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg20").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//修改换货单
	function updateExchange(){
		$("#divTitle21").html("修改换货单");
		$("#return_stock").html("");
		$("#return_stock1").html("");
		$("#btDiv21").show();
   	}
	
	function updateExchange1(){
		var saleData = $("#theForm21").serialize();
		$("#exchange").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/updateExchange";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(21);
					$("#exchange1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg21").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg21").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	function getExchange(obj){
		var trExchange = $(obj).parent().parent().parent();
		var exchangeNo = trExchange.find("[name='exchangeNo']").val();
		var url = __ctxPath + "/testOms/getExchange";
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			async:false,
			data: {"exchangeNo":exchangeNo},
			success: function(response) {
				if(response.success=='true'){
					var data=response.data;
					
					$("#originalSaleNo_h").val(data.originalSaleNo);
					$("#saleNo_h").val(data.saleNo);
					$("#refundNo_h").val(data.refundNo);
					$("#imbalance_h").val(data.imbalance);
					$("#employeeNo_h").val(data.employeeNo);
					
					
				}else{
					$("#model-body-warning").html("<div style='z-index:1080' class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>查不到此换货单!</strong></div>");
					$("#modal-warning").attr({"style" : "display:block;z-index:1080;","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
					return false;
				}
				return;
			},
			/* error:function(){
			
			} */
			error : function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
	}
	
	
	
	function closeBtDiv(obj){
		$("#btDiv"+obj).hide();
		document.getElementById("theForm"+obj).reset();
		$("#errorMsg"+obj).attr({"style":"display:none;","aria-hidden":"false"});
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
	function copyTr(obj){
		var currentTr = $(obj).parent();
		currentTr.clone().insertAfter(currentTr);
	}
	function getProduct(obj){
		var trProduct = $(obj).parent().parent();
		var productNo = trProduct.find("[name='supplyProductNo']").val();
		var url = __ctxPath + "/testOms/selectProduct";
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			async:false,
			data: {"supplyProductNo":productNo},
			success: function(response) {
				if(response.success=='true'){
					var data=response.data;
					trProduct.find("[name='standPrice']").val(data.standPrice);
					trProduct.find("[name='salePrice']").val(data.salePrice);
					trProduct.find("[name='brandName']").val(data.brandName);
					trProduct.find("[name='shoppeProName']").val(data.shoppeProName);
					trProduct.find("[name='skuNo']").val(data.skuNo);
					trProduct.find("[name='spuNo']").val(data.spuNo);
					trProduct.find("[name='supplyInnerProdNo']").val(data.supplyInnerProdNo);
					
					trProduct.find("[name='unit']").val(data.unit);
					trProduct.find("[name='barcode']").val(data.barcode);
					trProduct.find("[name='colorNo']").val(data.colorNo);
					trProduct.find("[name='colorName']").val(data.colorName);
					trProduct.find("[name='sizeNo']").val(data.sizeNo);
					trProduct.find("[name='sizeName']").val(data.sizeName);
					trProduct.find("[name='managerCateNo']").val(data.managerCateNo);
					
					trProduct.find("[name='brandNo']").val(data.brandNo);
					trProduct.find("[name='statisticsCateNo']").val(data.statisticsCateNo);
					trProduct.find("[name='productClass']").val(data.productClass);
					trProduct.find("[name='productType']").val(data.productType);
					trProduct.find("[name='tax']").val(data.tax);
					
					$("#shopNo_s").val(data.shopNo);
					$("#storeName_s").val(data.storeName);
					$("#supplyNo_s").val(data.supplyNo);
					$("#suppllyName_s").val(data.suppllyName);
					$("#shoppeNo_s").val(data.shoppeNo);
					$("#shoppeName_s").val(data.shoppeName);
					
					
				}else{
					$("#model-body-warning").html("<div style='z-index:1080' class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>查不到此商品!</strong></div>");
					$("#modal-warning").attr({"style" : "display:block;z-index:1080;","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
					return false;
				}
				return;
			},
			/* error:function(){
			
			} */
			error : function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
	}
	//获取退款介质
	function getPromResulet(obj){
		var trProduct = $(obj).parent().parent();
		var orderNo = trProduct.find("[name='orderNo']").val();
		var orderItemNo = trProduct.find("[name='orderItemNo']").val();
		var refundNum15 = trProduct.find("[name='refundNum15']").val();
		var url = __ctxPath + "/testOnlineOmsOrder/foundPromResult";
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			async:false,
			data: {"orderNo":orderNo,
					"refundNum15":refundNum15,
					"orderItemNo":orderItemNo},
			success: function(response) {
				if(response.success=='true'){
					var data=response.data;
					/* trProduct.find("[name='applyItemNo']").val(JSON.stringify(data.sellDetails[0].applyItemNo));
					trProduct.find("[name='applyNo']").val(JSON.stringify(data.sellDetails[0].applyNo));
//					trProduct.find("[name='orderItemNo']").val(JSON.stringify(data.sellDetails[0].orderItemNo));
//					trProduct.find("[name='orderNo']").val(JSON.stringify(data.sellDetails[0].orderNo));
					trProduct.find("[name='saleNo']").val(JSON.stringify(data.sellDetails[0].saleNo));
					trProduct.find("[name='saleItemNo']").val(JSON.stringify(data.sellDetails[0].saleItemNo));
					trProduct.find("[name='skuNo']").val(JSON.stringify(data.sellDetails[0].skuNo));
					trProduct.find("[name='spuNo']").val(JSON.stringify(data.sellDetails[0].spuNo));
					
					trProduct.find("[name='supplyProductNo']").val(JSON.stringify(data.sellDetails[0].supplyProductNo));
					trProduct.find("[name='erpProductNo']").val(JSON.stringify(data.sellDetails[0].erpProductNo));
					trProduct.find("[name='supplyProductInnerCode']").val(JSON.stringify(data.sellDetails[0].supplyProductInnerCode));
					trProduct.find("[name='unit']").val(JSON.stringify(data.sellDetails[0].unit));
					trProduct.find("[name='barCode']").val(JSON.stringify(data.sellDetails[0].barCode));
					trProduct.find("[name='shopNo']").val(JSON.stringify(data.sellDetails[0].shopNo));
					trProduct.find("[name='shopName']").val(JSON.stringify(data.sellDetails[0].shopName));
					trProduct.find("[name='supplyNo']").val(JSON.stringify(data.sellDetails[0].supplyNo));
					
					trProduct.find("[name='supplyName']").val(JSON.stringify(data.sellDetails[0].supplyName));
					trProduct.find("[name='shoppeNo']").val(JSON.stringify(data.sellDetails[0].shoppeNo));
					trProduct.find("[name='shoppeName']").val(JSON.stringify(data.sellDetails[0].shoppeName));
					trProduct.find("[name='brandNo']").val(JSON.stringify(data.sellDetails[0].brandNo));
					trProduct.find("[name='brandName']").val(JSON.stringify(data.sellDetails[0].brandName));
					trProduct.find("[name='colorNo']").val(JSON.stringify(data.sellDetails[0].colorNo));
					trProduct.find("[name='colorName']").val(JSON.stringify(data.sellDetails[0].colorName));
					trProduct.find("[name='sizeNo']").val(JSON.stringify(data.sellDetails[0].sizeNo));
					
					trProduct.find("[name='sizeName']").val(JSON.stringify(data.sellDetails[0].sizeName));
					trProduct.find("[name='refundNum']").val(JSON.stringify(data.sellDetails[0].refundNum));
					trProduct.find("[name='salePrice']").val(JSON.stringify(data.sellDetails[0].salePrice));
					trProduct.find("[name='refundAmount']").val(JSON.stringify(data.sellDetails[0].refundAmount));
					trProduct.find("[name='actualRefundAmount']").val(JSON.stringify(data.sellDetails[0].actualRefundAmount));
					trProduct.find("[name='isGift']").val(JSON.stringify(data.sellDetails[0].isGift));
					trProduct.find("[name='createTimeStr']").val(JSON.stringify(data.sellDetails[0].createTimeStr));
					trProduct.find("[name='latestUpdateMan']").val(JSON.stringify(data.sellDetails[0].latestUpdateMan));
					trProduct.find("[name='latestUpdateTimeStr']").val(JSON.stringify(data.sellDetails[0].latestUpdateTimeStr));
					trProduct.find("[name='discountCode']").val(JSON.stringify(data.sellDetails[0].discountCode));
					
					trProduct.find("[name='refundReasionNo']").val(JSON.stringify(data.sellDetails[0].refundReasionNo));
					trProduct.find("[name='refundReasionDesc']").val(JSON.stringify(data.sellDetails[0].refundReasionDesc));
					trProduct.find("[name='proPictureUrl']").val(JSON.stringify(data.sellDetails[0].proPictureUrl));
					trProduct.find("[name='refundPcitureUrl']").val(JSON.stringify(data.sellDetails[0].refundPcitureUrl));
					trProduct.find("[name='productOnlySn']").val(JSON.stringify(data.sellDetails[0].productOnlySn));
					trProduct.find("[name='rowNo']").val(JSON.stringify(data.sellDetails[0].rowNo));
					trProduct.find("[name='orderItemRowNo']").val(JSON.stringify(data.sellDetails[0].orderItemRowNo)); */
//					trProduct.find("[name='refundApplyDeductionSplitDto']").val(JSON.stringify(data.sellDetails[0].couponUses));
//					trProduct.find("[name='refundApplyGetSplitDto']").val(JSON.stringify(data.sellDetails[0].couponGains));
//					trProduct.find("[name='refundApplyPromotionSplitDto']").val(JSON.stringify(data.sellDetails[0].popDetails));
//					$("#sellPayments").val(JSON.stringify(data.sellPayments));
					trProduct.find("[name='refundApplyDeductionSplitDto']").val(JSON.stringify(data.products[0].refundApplyDeductionSplitDto));
					trProduct.find("[name='refundApplyGetSplitDto']").val(JSON.stringify(data.products[0].refundApplyGetSplitDto));
					trProduct.find("[name='refundApplyPromotionSplitDto']").val(JSON.stringify(data.products[0].refundApplyPromotionSplitDto));
					$("#sellPayments").val(JSON.stringify(data.deduction));
										
				}else{
					$("#model-body-warning").html("<div style='z-index:1080' class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>查不到退款介质!</strong></div>");
					$("#modal-warning").attr({"style" : "display:block;z-index:1080;","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
					return false;
				}
				return;
			},
			/* error:function(){
			
			} */
			error : function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
	}
	function getPrice(obj){
		var trProduct = $(obj).parent().parent();
		var supplyProductNo = trProduct.find("[name='supplyProductNo']").val();
		var skuNo = trProduct.find("[name='skuNo']").val();
		var url = __ctxPath + "/testOnlineOmsOrder/selectPrice";
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			async:false,
			data: {"supplyProductNo":supplyProductNo,
				"skuNo":skuNo},
			success: function(response) {
				if(response.success=='true'){
					var data=response.data;
					trProduct.find("[name='salesPrice']").val(data.salePrice);
				}else{
					$("#model-body-warning").html("<div style='z-index:1080' class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>查不到此商品价格!</strong></div>");
					$("#modal-warning").attr({"style" : "display:block;z-index:1080;","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
					return false;
				}
				return;
			},
			/* error:function(){
			
			} */
			error : function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
	}
	</script>
</head>
<body>
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
								<span class="widget-caption"><h5>线上销售测试</h5>
								</span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<!-- <div class="col-md-2">
										<a id="editabledatatable_new" onclick="foundSale();"
											class="btn btn-yellow" style="width: 100%;"> <i
											class="fa fa-shopping-cart"></i> 创建旗舰店订单 </a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="creatOrder();"
											class="btn label-azure" style="width: 100%;"> <i
											class="fa fa-shopping-cart"></i> 创建云店订单 </a>&nbsp;
									</div> -->
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="createOrder();"
											class="btn btn-maroon" style="width: 100%;"> <i
											class="fa fa-shopping-cart"></i> 创建订单 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="found_sale"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="found_sale1"></div>
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="salePos();"
											class="btn btn-primary" style="width: 100%;"> <i
											class="fa fa-chevron-up"></i> 订单支付 </a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="salePay();"
											class="btn label-azure" style="width: 100%;"> <i
											class="fa fa-tasks"></i> 订单审核 </a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="orderCancel();"
											class="btn btn-maroon" style="width: 100%;"> <i
											class="fa fa-calendar"></i> 取消订单 </a>&nbsp;
									</div>
									
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="sale_pos"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="sale_pos1"></div>
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="createInvoice();"
											class="btn btn-maroon" style="width: 100%;"> <i
											class="fa fa-calendar"></i> 创建发票 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="invoice_input"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="invoice_input1"></div>
										</div>
										&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="updateSaleStatus();"
											class="btn btn-maroon" style="width: 100%;"> <i
											class="fa fa-calendar"></i> 仓内打印 </a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="updateSaleStatusd();"
											class="btn btn-sky" style="width: 100%;"> <i
											class="fa fa-tasks"></i> 仓内复核 </a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="updateSaleStatuse();"
											class="btn btn-maroon" style="width: 100%;"> <i
											class="fa fa-calendar"></i> 仓内打包 </a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="updateSaleStatusr();"
											class="btn btn-sky" style="width: 100%;"> <i
											class="fa fa-tasks"></i> 仓内出库</a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="sale_status"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="sale_status1"></div>
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="printSale();"
											class="btn btn-azure" style="width: 100%;"> <i
											class="fa fa-fire"></i> 保存包裹单 </a>&nbsp;
									</div>
									<!-- <div class="col-md-2">
										<a id="editabledatatable_new" onclick="saveInvoice();"
											class="btn btn-maroon" style="width: 100%;"> <i
											class="fa fa-calendar"></i> 包裹单状态 </a>&nbsp;
									</div> -->
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="invoiceCancel();"
											class="btn btn-sky" style="width: 100%;"> <i
											class="fa fa-eye-slash"></i> 物流状态 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="print_sale"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="print_sale1"></div>
										</div>
										&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="foundRefund();"
											class="btn btn-darkorange" style="width: 100%;"> <i
											class="fa fa-random"></i> 创建退货申请单 </a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="createKeRefund();"
											class="btn label-azure" style="width: 100%;"> <i
											class="fa fa-random"></i>客服创建退货申请单</a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="createInerimRefund();"
											class="btn label-azure" style="width: 100%;"> <i
											class="fa fa-random"></i>缺货退货创建申请单</a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="createRefuseRefund();"
											class="btn label-azure" style="width: 100%;"> <i
											class="fa fa-random"></i>拒收退货创建申请单</a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="found_refund"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="found_refund1"></div>
										</div>
										&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="refundPay();"
											class="btn label-azure" style="width: 100%;"> <i
											class="fa fa-tasks"></i> 退货申请单审核 </a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="refundApplyCancel();"
											class="btn btn-maroon" style="width: 100%;"> <i
											class="fa fa-calendar"></i>取消退货申请单 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="refund1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="refund_pos"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="refund_pos1"></div>
										</div>
										&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="updateRefundStatus();"
											class="btn btn-sky" style="width: 100%;"> <i
											class="fa fa-eye-slash"></i> 修改退货单状态 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="update_status"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="update_status1"></div>
										</div>
										&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="refundPos();"
											class="btn btn-maroon" style="width: 100%;"> <i
											class="fa fa-chevron-down"></i> 退货申请单退款 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="refundPay_pos"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="refundPay_pos1"></div>
										</div>
										&nbsp;
									</div>
									<!-- <div class="col-md-2">
										<a id="editabledatatable_new" onclick="salePadCreat();"
											class="btn btn-yellow" style="width: 100%;"> <i
											class="fa fa-hand-o-right"></i> PAD创建 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="salePadCancel();"
											class="btn btn-palegreen" style="width: 100%;"> <i
											class="fa fa-warning"></i> 流水作废 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="salePadAdd();"
											class="btn btn-darkorange" style="width: 100%;"> <i
											class="fa fa-briefcase"></i> PAD添加销售单 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="salePadCancle();"
											class="btn btn-purple" style="width: 100%;"> <i
											class="fa fa-cut"></i> PAD取消 </a>
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="salePad();"
											class="btn btn-magenta" style="width: 100%;"> <i
											class="fa fa-cloud"></i> PAD支付 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="sale_pad"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="sale_pad1"></div>
										</div>
										&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="printPay();"
											class="btn label-azure" style="width: 100%;"> <i
											class="fa fa-certificate"></i> PAD打印款机 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="print_pay"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="print_pay1"></div>
										</div>
										&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="takeStock();"
											class="btn btn-palegreen" style="width: 100%;"> <i
											class="fa fa-gift"></i> 顾客确认提货 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="take_stock"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="take_stock1"></div>
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="printRefund();"
											class="btn btn-magenta" style="width: 100%;"> <i
											class="fa fa-list-ul"></i> 打印退货单 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="print_refund"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="print_refund1"></div>
										</div>
										&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="examineRefund();"
											class="btn btn-purple" style="width: 100%;"> <i
											class="fa fa-legal"></i> 退货单审核 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="examine_refund"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="examine_refund1"></div>
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="returnStock();"
											class="btn label-azure" style="width: 100%;"> <i
											class="fa fa-plane"></i> 导购确认还库 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="return_stock"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="return_stock1"></div>
										</div>
										&nbsp;
									</div>

									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="saleCancel();"
											class="btn btn-primary" style="width: 100%;"> <i
											class="fa fa-strikethrough"></i> 销售单作废 </a>&nbsp;
									</div>

									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="refundCancel();"
											class="btn btn-palegreen" style="width: 100%;"> <i
											class="fa fa-navicon"></i> 退货单作废 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="bills_cancel"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="bills_cancel1"></div>
										</div>
										&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="foundExchange();"
											class="btn btn-yellow" style="width: 100%;"> <i
											class="fa fa-retweet"></i> 创建换货单 </a>&nbsp;
									</div>
									<div class="col-md-2">
										<a id="editabledatatable_new" onclick="updateExchange();"
											class="btn btn-darkorange" style="width: 100%;"> <i
											class="fa fa-key"></i> 修改换货单 </a>&nbsp;
									</div>
									<div class="col-xs-12 col-md-12">
										<div class="widget-body" id="pro1">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="exchange"></div>
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="exchange1"></div>
										</div>
									</div> -->
									<div style="width: 100%; height: 0%; overflow-Y: hidden;">
									</div>
									<div id="olvPagination"></div>
								</div>
								<!-- Templates -->
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
	<!-- 旗舰店下订单 -->
	<div class="modal modal-darkorange" id="btDiv1">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(1);">×</button>
					<h4 class="modal-title" id="divTitle1"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm1" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">
									<input name="outOrderNo" type="hidden"/>
									<input name="delayTime" type="hidden"/>
									<input name="refundSum" type="hidden"/>
									<input name="sendSum" type="hidden"/>
									<input name="sendAmount" type="hidden"/>
									<input name="cashIncome" type="hidden"/>
									<input name="accountBalanceAmount" type="hidden"/>
									<input name="promotionAmount" type="hidden"/>
									<input name="customerComments" type="hidden"/>
									<input name="promotionAmount" type="hidden"/>
									<input name="recoveryFlag" type="hidden"/>
									<input name="promFlag" type="hidden"/>
									<input name="version" type="hidden"/>
									<h6> 订单信息 </h6>
									<hr style="margin-top: 2; border: 2;">
									<div class="col-md-4">
										<label class="col-md-5 control-label">商品销售总额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesAmount"
												name="salesAmount" value="100.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">订单应付金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="paymentAmount"
												name="paymentAmount" value="110.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">订单现金类支付金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="cashAmount"
												name="cashAmount" value="50.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">应收运费：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="needSendCost"
												name="needSendCost" value="10.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">销售数量：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="saleSum1"
												name="saleSum1" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>货到付款：</span>
										</div>
										<div class="col-lg-7">
											<select id="idCod" name="isCod"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">不是</option>
												<option value="1">是</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>订单来源：</span>
										</div>
										<div class="col-lg-7">
											<select id="orderSource" name="orderSource"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="C1" selected="selected">C1</option>
												<option value="0">全渠道</option>
												<option value="1">天猫</option>
												<option value="2">京东</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>订单类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="orderType" name="orderType" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="PT" selected="selected">普通订单</option>
												<option value="TG">团购订单</option>
												<option value="DK">代客下单</option>
												<option value="KT">快腿订单</option>
												<option value="YG">员工订单</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>配送方式：</span>
										</div>
										<div class="col-lg-7">
											<select id="deliveryMode" name="deliveryMode"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="SHIPPING" selected="selected">SHIPPING</option>
												<option value="PICKING">PICKING</option>
												<option value="THREEGLPS">THREEGLPS</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>会员类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="memberType" name="memberType"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="1" selected="selected">会员类型1</option>
												<option value="2">会员类型2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">账号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="accountNo"
												name="accountNo" value="9900000000812" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">会员编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="memberNo"
												name="memberNo" value="9900000000812" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">支付类型：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="paymentClass"
												name="paymentClass" value="12101" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>是否开发票：</span>
										</div>
										<div class="col-lg-7">
											<select id="needInvoice" name="needInvoice"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">否</option>
												<option value="1">是</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>配送方式名称：</span>
										</div>
										<div class="col-lg-7">
											<select id="deliveryModeName" name="deliveryModeName"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="配送" selected="selected">配送</option>
												<option value="自提">自提</option>
												<option value="3公里配送">3公里配送</option>
											</select>
										</div>
										&nbsp;
									</div>
									<h6> 收货信息 </h6>
									<hr style="margin-top: 2; border: 2;">
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人姓名：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptName"
												name="receptName" value="赵子龙" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人电话：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptPhone"
												name="receptPhone" value="13112344321" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人城市编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptCityNo"
												name="receptCityNo" value="000111" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人城市名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptCityName"
												name="receptCityName" value="北京" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件城市邮编：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptCityCode"
												name="receptCityCode" value="000000" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件地区省份编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptProvNo"
												name="receptProvNo" value="110011" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件地区省份名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptProvName"
												name="receptProvName" value="北京" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收货地址：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptAddress"
												name="receptAddress" value="北京市子虚区乌有镇啦啦街道123号" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>提货类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="extractFlag" name="extractFlag"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="1" selected="selected">提货类型1</option>
												<option value="2">提货类型2</option>
											</select>
										</div>
										&nbsp;
									</div>
									
									<%-- <h6> 其他信息 </h6>
									<hr style="margin-top: 2; border: 2;">
									<div class="col-md-4">
										<label class="col-md-5 control-label">外部订单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="outOrderNo"
												name="outOrderNo" />
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-4">
										<label class="col-md-5 control-label">延迟时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="delayTime"
												name="delayTime" />
											<input type="text" class="form-control" id="delayTime"
												name="delayTime" value="<%=str_date1 %>" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">退货数量：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundSum"
												name="refundSum" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">发货数量：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sendSum"
												name="sendSum" value="1" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">发货金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sendAmount"
												name="sendAmount" value="100.00" />
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-4">
										<label class="col-md-5 control-label">收银损益：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="cashIncome"
												name="cashIncome" value="0.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">使用余额总额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="accountBalanceAmount" name="accountBalanceAmount"
												value="60.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">订单优惠总额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="promotionAmount"
												name="promotionAmount" value="0.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">客户备注：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="customerComments"
												name="customerComments" value="客户说的话" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">客服备注：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="callCenterComments" name="promotionAmount" value="客服说的话" />
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>是否进入回收站：</span>
										</div>
										<div class="col-lg-7">
											<select id="recoveryFlag" name="recoveryFlag"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">否</option>
												<option value="1">是</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>是否参加促销：</span>
										</div>
										<div class="col-lg-7">
											<select id="promFlag" name="promFlag" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">否</option>
												<option value="1">是</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">版本号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="version"
												name="version" value="123456789" />
										</div>
										&nbsp;
									</div> --%>
									
									<div class="col-md-12">
										<h4>订单明细:</h4>
										<table>
											<thead>
												<tr>
													<!-- <th>操作</th> -->
													<th><font color="red">*</font>专柜商品编号</th>
													<th><font color="red">*</font>商品售价</th>
													<th><font color="red">*</font>销售数量</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<!-- <td><input type="button" onclick="getProduct(this)" value="获取商品"/></td> -->
													<td><input name="supplyProductNo" value="40000416"></input>
													</td>
													<td><input name="salesPrice" value="100"></input>
													</td>
													<td><input name="saleSum" onchange="getSumo(this)"></input>
													</td>
													<td align="center" onclick="copyTr(this)"
														style="vertical-align: middle;"><span
														class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
													</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<!-- <div class="col-md-12">
										<h4>支付介质：</h4>
										<table>
											<thead>
												<tr>
													<th>操作</th>
													<th>交易支付流水</th>
													<th>支付方式</th>
													<th>支付金额</th>
													<th>实际抵扣金额</th>
													<th>汇率（折现率)</th>
													<th>支付账号</th>
													<th>会员id</th>
													<th>支付流水号</th>
													<th>优惠券类型</th>
													<th>优惠券批次</th>
													<th>券模板名称</th>
													<th>活动号</th>
													<th>收券规则</th>
													<th>收券规则描述</th>
													<th>备注</th>
													<th>结余</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input type="button" onclick="getProduct(this)" value="获取商品"/></td>
													<td><input name="posFlowNo" value="123"></input>
													</td>
													<td><input name="paymentType" value="123"></input>
													</td>
													<td><input name="amount" value="60.00"></input>
													</td>
													<td><input name="acturalAmount" value="60.00"></input>
													</td>
													<td><input name="rate" value="0"></input>
													</td>
													<td><input name="account" value="10988765123"></input>
													</td>
													<td><input name="userId" value="2343534223123"></input>
													</td>
													<td><input name="payFlowNo" value="2325423123"></input>
													</td>
													<td><input name="couponType" value="1"></input>
													</td>
													<td><input name="couponBatch" value="12"></input>
													</td>
													<td><input name="couponName" value="模板1"></input>
													</td>
													<td><input name="activityNo" value="235234123"></input>
													</td>
													<td><input name="couponRule" value="123"></input>
													</td>
													<td><input name="couponRuleName" value="描述123"></input>
													</td>
													<td><input name="remark" value="备注描述"></input>
													</td>
													<td><input name="cashBalance" value="0"></input>
													</td>
													<td align="center" onclick="copyTr(this)"
														style="vertical-align: middle;"><span
														class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
													</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div> -->
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="foundSale1()" type="button" value="下单" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(1);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg1" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>下单失败!</strong>
										</div>
										<span id="returnMsg1"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(1);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 云店下订单 -->
	<div class="modal modal-darkorange" id="btDiv33">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(33);">×</button>
					<h4 class="modal-title" id="divTitle33"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm33" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">
									
									<input name="outOrderNo" type="hidden"/>
									<input name="delayTime" type="hidden"/>
									<input name="refundSum" type="hidden"/>
									<input name="sendSum" type="hidden"/>
									<input name="sendAmount" type="hidden"/>
									<input name="cashIncome" type="hidden"/>
									<input name="accountBalanceAmount" type="hidden"/>
									<input name="promotionAmount" type="hidden"/>
									<input name="customerComments" type="hidden"/>
									<input name="promotionAmount" type="hidden"/>
									<input name="recoveryFlag" type="hidden"/>
									<input name="promFlag" type="hidden"/>
									<input name="version" type="hidden"/>
									<h6> 订单信息 </h6>
									<hr style="margin-top: 2; border: 2;">
									<div class="col-md-4">
										<label class="col-md-5 control-label">商品销售总额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesAmount"
												name="salesAmount" value="100.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">订单应付金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="paymentAmount"
												name="paymentAmount" value="110.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">订单现金类支付金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="cashAmount"
												name="cashAmount" value="50.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">应收运费：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="needSendCost"
												name="needSendCost" value="10.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">销售数量：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="saleSumy1"
												name="saleSum1" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>货到付款：</span>
										</div>
										<div class="col-lg-7">
											<select id="idCod" name="isCod"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">不是</option>
												<option value="1">是</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>订单来源：</span>
										</div>
										<div class="col-lg-7">
											<select id="orderSource" name="orderSource"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="C1" selected="selected">C1</option>
												<option value="0">全渠道</option>
												<option value="1">天猫</option>
												<option value="2">京东</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>订单类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="orderType" name="orderType" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="PT" selected="selected">普通订单</option>
												<option value="TG">团购订单</option>
												<option value="DK">代客下单</option>
												<option value="KT">快腿订单</option>
												<option value="YG">员工订单</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>配送方式：</span>
										</div>
										<div class="col-lg-7">
											<select id="deliveryMode" name="deliveryMode"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="SHIPPING" selected="selected">SHIPPING</option>
												<option value="PICKING">PICKING</option>
												<option value="THREEGLPS">THREEGLPS</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>会员类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="memberType" name="memberType"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="1" selected="selected">会员类型1</option>
												<option value="2">会员类型2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">账号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="accountNo"
												name="accountNo" value="9900000000812" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">会员编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="memberNo"
												name="memberNo" value="9900000000812" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">支付类型：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="paymentClass"
												name="paymentClass" value="12101" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>是否开发票：</span>
										</div>
										<div class="col-lg-7">
											<select id="needInvoice" name="needInvoice"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">否</option>
												<option value="1">是</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>配送方式名称：</span>
										</div>
										<div class="col-lg-7">
											<select id="deliveryModeName" name="deliveryModeName"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="配送" selected="selected">配送</option>
												<option value="自提">自提</option>
												<option value="3公里配送">3公里配送</option>
											</select>
										</div>
										&nbsp;
									</div>
									<h6> 收货信息 </h6>
									<hr style="margin-top: 2; border: 2;">
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人姓名：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptName"
												name="receptName" value="赵子龙" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人电话：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptPhone"
												name="receptPhone" value="13112344321" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人城市编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptCityNo"
												name="receptCityNo" value="000111" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人城市名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptCityName"
												name="receptCityName" value="北京" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件城市邮编：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptCityCode"
												name="receptCityCode" value="000000" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件地区省份编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptProvNo"
												name="receptProvNo" value="110011" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件地区省份名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptProvName"
												name="receptProvName" value="北京" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收货地址：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptAddress"
												name="receptAddress" value="北京市子虚区乌有镇啦啦街道123号" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>提货类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="extractFlag" name="extractFlag"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="1" selected="selected">提货类型1</option>
												<option value="2">提货类型2</option>
											</select>
										</div>
										&nbsp;
									</div>
									
									<%-- <h6> 其他信息 </h6>
									<hr style="margin-top: 2; border: 2;">
									<div class="col-md-4">
										<label class="col-md-5 control-label">外部订单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="outOrderNo"
												name="outOrderNo" />
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-4">
										<label class="col-md-5 control-label">延迟时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="delayTime"
												name="delayTime" />
											<input type="text" class="form-control" id="delayTime"
												name="delayTime" value="<%=str_date1 %>" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">退货数量：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundSum"
												name="refundSum" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">发货数量：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sendSum"
												name="sendSum" value="1" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">发货金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sendAmount"
												name="sendAmount" value="100.00" />
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-4">
										<label class="col-md-5 control-label">收银损益：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="cashIncome"
												name="cashIncome" value="0.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">使用余额总额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="accountBalanceAmount" name="accountBalanceAmount"
												value="60.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">订单优惠总额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="promotionAmount"
												name="promotionAmount" value="0.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">客户备注：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="customerComments"
												name="customerComments" value="客户说的话" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">客服备注：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="callCenterComments" name="promotionAmount" value="客服说的话" />
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>是否进入回收站：</span>
										</div>
										<div class="col-lg-7">
											<select id="recoveryFlag" name="recoveryFlag"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">否</option>
												<option value="1">是</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>是否参加促销：</span>
										</div>
										<div class="col-lg-7">
											<select id="promFlag" name="promFlag" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">否</option>
												<option value="1">是</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">版本号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="version"
												name="version" value="123456789" />
										</div>
										&nbsp;
									</div> --%>
									<div class="col-md-12">
										<h4>订单明细:</h4>
										<table>
											<thead>
												<tr>
													<!-- <th>操作</th> -->
													<th><font color="red">*</font>SKU</th>
													<th><font color="red">*</font>商品售价</th>
													<th><font color="red">*</font>销售数量</th>
													<th><font color="red">*</font>应付金额</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<!-- <td><input type="button" onclick="getProduct(this)" value="获取商品"/></td> -->
													<td><input name="skuNo" value="2000000001158"></input>
													</td>
													<td><input name="salesPrice" value="100"></input>
													</td>
													<td><input name="saleSum" onchange="getSumyo(this)"></input>
													</td>
													<td><input name="paymentAmountm" value="100"></input>
													</td>
													<td align="center" onclick="copyTr(this)"
														style="vertical-align: middle;"><span
														class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
													</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<!-- <div class="col-md-12">
										<h4>支付介质：</h4>
										<table>
											<thead>
												<tr>
													<th>操作</th>
													<th>交易支付流水</th>
													<th>支付方式</th>
													<th>支付金额</th>
													<th>实际抵扣金额</th>
													<th>汇率（折现率)</th>
													<th>支付账号</th>
													<th>会员id</th>
													<th>支付流水号</th>
													<th>优惠券类型</th>
													<th>优惠券批次</th>
													<th>券模板名称</th>
													<th>活动号</th>
													<th>收券规则</th>
													<th>收券规则描述</th>
													<th>备注</th>
													<th>结余</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input type="button" onclick="getProduct(this)" value="获取商品"/></td>
													<td><input name="posFlowNo" value="123"></input>
													</td>
													<td><input name="paymentType" value="123"></input>
													</td>
													<td><input name="amount" value="60.00"></input>
													</td>
													<td><input name="acturalAmount" value="60.00"></input>
													</td>
													<td><input name="rate" value="0"></input>
													</td>
													<td><input name="account" value="10988765123"></input>
													</td>
													<td><input name="userId" value="2343534223123"></input>
													</td>
													<td><input name="payFlowNo" value="2325423123"></input>
													</td>
													<td><input name="couponType" value="1"></input>
													</td>
													<td><input name="couponBatch" value="12"></input>
													</td>
													<td><input name="couponName" value="模板1"></input>
													</td>
													<td><input name="activityNo" value="235234123"></input>
													</td>
													<td><input name="couponRule" value="123"></input>
													</td>
													<td><input name="couponRuleName" value="描述123"></input>
													</td>
													<td><input name="remark" value="备注描述"></input>
													</td>
													<td><input name="cashBalance" value="0"></input>
													</td>
													<td align="center" onclick="copyTr(this)"
														style="vertical-align: middle;"><span
														class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
													</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div> -->
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="creatOrder1()" type="button" value="下单" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(33);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg33" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>下单失败!</strong>
										</div>
										<span id="returnMsg33"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(33);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 创建订单 （总订单）-->
	<div class="modal modal-darkorange" id="btDiv333">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(333);">×</button>
					<h4 class="modal-title" id="divTitle333"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm333" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">
									
									<input name="outOrderNo" type="hidden"/>
									<input name="delayTime" type="hidden"/>
									<input name="refundSum" type="hidden"/>
									<input name="sendSum" type="hidden"/>
									<input name="sendAmount" type="hidden"/>
									<input name="cashIncome" type="hidden"/>
									<input name="accountBalanceAmount" type="hidden"/>
									<input name="promotionAmount" type="hidden"/>
									<input name="customerComments" type="hidden"/>
									<input name="promotionAmount" type="hidden"/>
									<input name="recoveryFlag" type="hidden"/>
									<input name="promFlag" type="hidden"/>
									<input name="version" type="hidden"/>
									<h6> 订单信息 </h6>
									<hr style="margin-top: 2; border: 2;">
									<div class="col-md-4">
										<label class="col-md-5 control-label">商品销售总额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesAmounts"
												name="salesAmount"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">订单应付金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="paymentAmounts"
												name="paymentAmount"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">订单现金类支付金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="cashAmount"
												name="cashAmount" value="50.00" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">应收运费：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sendCost"
												name="sendCost" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">销售数量：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="saleSumy2"
												name="saleSum2" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>货到付款：</span>
										</div>
										<div class="col-lg-7">
											<select id="idCod" name="isCod"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">不是</option>
												<option value="1">是</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>订单来源：</span>
										</div>
										<div class="col-lg-7">
											<select id="orderSource" name="orderSource"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="C1" selected="selected">C1</option>
												<option value="0">全渠道</option>
												<option value="1">天猫</option>
												<option value="2">京东</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>订单类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="orderType" name="orderType" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="PT" selected="selected">普通订单</option>
												<option value="TG">团购订单</option>
												<option value="DK">代客下单</option>
												<option value="KT">快腿订单</option>
												<option value="YG">员工订单</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>配送方式：</span>
										</div>
										<div class="col-lg-7">
											<select id="deliveryMode" name="deliveryMode"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="SHIPPING" selected="selected">SHIPPING</option>
												<option value="PICKING">PICKING</option>
												<option value="THREEGLPS">THREEGLPS</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>会员类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="memberType" name="memberType"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="1" selected="selected">会员类型1</option>
												<option value="2">会员类型2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">账号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="accountNo"
												name="accountNo" value="9900000000812" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">会员编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="memberNo"
												name="memberNo" value="9900000000812" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">支付类型：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="paymentClass"
												name="paymentClass" value="12101" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>是否开发票：</span>
										</div>
										<div class="col-lg-7">
											<select id="needInvoice" name="needInvoice"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">否</option>
												<option value="1">是</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>配送方式名称：</span>
										</div>
										<div class="col-lg-7">
											<select id="deliveryModeName" name="deliveryModeName"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="配送" selected="selected">配送</option>
												<option value="自提">自提</option>
												<option value="3公里配送">3公里配送</option>
											</select>
										</div>
										&nbsp;
									</div>
									<h6> 收货信息 </h6>
									<hr style="margin-top: 2; border: 2;">
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人姓名：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptName"
												name="receptName" value="赵子龙" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人电话：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptPhone"
												name="receptPhone" value="13112344321" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人区编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptDistrictNo"
												name="receptDistrictNo" value="010001000008" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人区名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptDistrictName"
												name="receptDistrictName" value="海淀区" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人城市编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptCityNo"
												name="receptCityNo" value="0100010" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件人城市名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptCityName"
												name="receptCityName" value="北京市" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件城市邮编：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptCityCode"
												name="receptCityCode" value="0000" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件地区省份编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptProvNo"
												name="receptProvNo" value="010" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收件地区省份名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptProvName"
												name="receptProvName" value="北京市" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收货地址：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="receptAddress"
												name="receptAddress" value="北京市 北京市 海淀区 海淀区知春里小区17楼605室" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>提货类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="extractFlag" name="extractFlag"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="1" selected="selected">提货类型1</option>
												<option value="2">提货类型2</option>
											</select>
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-12">
										<h4>订单明细:</h4>
										<table>
											<thead>
												<tr>
													<th>操作</th>
													<th><font color="red">*</font>专柜商品编码</th>
													<th><font color="red">*</font>SKU</th>
													<th><font color="red">*</font>商品售价</th>
													<th><font color="red">*</font>销售数量</th>
													<th><font color="red">*</font>应付金额</th>
													<th><font color="red">*</font>是否为赠品</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input type="button" onclick="getPrice(this)" value="获取商品价格"/></td>
													<td><input name="supplyProductNo" value="40000779"></input>
													</td>
													<td><input name="skuNo"></input>
													</td>
													<td><input name="salesPrice"></input>
													</td>
													<td><input name="saleSum" onchange="getSumso(this)"></input>
													</td>
													<td><input name="paymentAmountm"></input>
													</td>
													<td><input name="isGift" value="0"></input>
													</td>
													<td align="center" onclick="copyTr(this)"
														style="vertical-align: middle;"><span
														class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
													</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="createOrder1()" type="button" value="下单" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(333);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg333" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>下单失败!</strong>
										</div>
										<span id="returnMsg333"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(333);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- 保存包裹弹框 -->
	<div class="modal modal-darkorange" id="btDiv2">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(2);">×</button>
					<h4 class="modal-title" id="divTitle2"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm2" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>订单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderNo"
												name="orderNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>包裹单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="packageNo"
												name="packageNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>快递单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="deliveryNo"
												name="deliveryNo"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">快递公司：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="delComName"
												name="delComName" value="申通快递公司"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">快递公司编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="delComNo"
												name="delComNo" value="12321" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">发货时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sendTimeStr"
												name="sendTimeStr" value="<%=str_date1 %>" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">自提点编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="extPlaceNo"
												name="extPlaceNo" value="12321"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">自提点名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="extPlaceName"
												name="extPlaceName" value="百货大楼" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">包裹状态：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="packageStatus"
												name="packageStatus" value="6001"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">退货地址：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundAddress"
												name="refundAddress" value="aadfds" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">操作人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="updateMan"
												name="updateMan" value="admin"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">包裹状态描述：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="packageStatusDesc"
												name="packageStatusDesc" value="打包" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">系统来源：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="operatorSource"
												name="operatorSource" value="ERP" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">备注：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="remark"
												name="remark" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>包裹单号</th>
													<th><font color="red">*</font>快递单号</th>
													<th><font color="red">*</font>销售单号</th>
													<th><font color="red">*</font>数量</th>
													<th><font color="red">*</font>销售单明细号</th>
													
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="packageNo1"></input></td>
													<td><input name="deliveryNo1"></input></td>
													<td><input name="saleNo"></input></td>
													<td><input name="saleNum"></input></td>
													<td><input name="saleItemNo"></input></td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
													
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="printSale1()" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(2);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg2" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>保存失败!</strong>
										</div>
										<span id="returnMsg2"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(2);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 支付定单弹框 -->
	<div class="modal modal-darkorange" id="btDiv3">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(3);">×</button>
					<h4 class="modal-title" id="divTitle3"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm3" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<%-- <div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>款机流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesPaymentNo"
												name="salesPaymentNo" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>总金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="money"
												name="money" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>总应收：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="paymentAmount"
												name="paymentAmount" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>实际支付：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="actualPaymentAmount" name="actualPaymentAmount" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>机器号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="posNo"
												name="posNo" value="9999" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>门店号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="shopNo"
												name="shopNo" value="8888" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>门店名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="shopName"
												name="shopName" value="王府井店" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>支付时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payTimeStr"
												name="payTimeStr" value="<%=str_date1 %>" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">交易流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payFlowNo"
												name="payFlowNo" value="1111" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>收银员号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="casher"
												name="casher" value="1234" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>渠道标志（M）：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="channel"
												name="channel" value="1" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>会员卡号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="memberNo"
												name="memberNo" value="111" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">授权卡号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="authorizationNo"
												name="authorizationNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>线上线下标识：</span>
										</div>
										<div class="col-lg-7">
											<select id="ooFlag" name="ooFlag" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="1">线上</option>
												<option value="2" selected="selected">线下</option>
											</select>
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>水单类型:</span>
										</div>
										<div class="col-lg-7">
											<select id="isRefund" name="isRefund" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">支付</option>
												<option value="1">退款</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">总折扣：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="totalDiscountAmount" name="totalDiscountAmount"
												value="0" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">找零：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="changeAmount"
												name="changeAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">折扣额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="tempDiscountAmount" name="tempDiscountAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">折让额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="zrAmount"
												name="zrAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">会员总折扣：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="memberDiscountAmount" name="memberDiscountAmount"
												value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">优惠折扣额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="promDiscountAmount" name="promDiscountAmount" value="0" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">收银损益：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="income"
												name="income" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>班次：</span>
										</div>
										<div class="col-lg-7">
											<select id="shifts" name="shifts" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="0">早班</option>
												<option value="1" selected="selected">中班</option>
												<option value="2">晚班</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">微信卡类型：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="weixinCard"
												name="weixinCard" value="001" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">微信卡门店号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="weixinStoreNo"
												name="weixinStoreNo" value="00001" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">线上订单号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderNo"
												name="orderNo" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">人民币</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="rmb" name="rmb"
												value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">电子返券</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="elecGet"
												name="elecGet" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">电子扣款</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="elecDeducation"
												name="elecDeducation" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">银行手续费</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="bankServiceCharge" name="bankServiceCharge" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">来源</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sourceType"
												name="sourceType" />
										</div>
										&nbsp;
									</div> --%>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>线上订单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderNo"
												name="orderNo" />
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="fundMoney"
												onclick="fundOrderMoney()" type="button" value="查询" />&emsp;&emsp;
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>订单金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderMoney"
												name="orderMoney" />
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>款机流水单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesPaymentNo"
												name="salesPaymentNo"/>
										</div>
										&nbsp;
									</div>
									<!-- <div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>总金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="money"
												name="money" value="210"/>
										</div>
										&nbsp;
									</div> -->
									
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>交易流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payFlowNo"
												name="payFlowNo" value="7654321"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>线上线下标识：</span>
										</div>
										<div class="col-lg-7">
											<select id="ooFlag" name="ooFlag" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="1" selected="selected">线上</option>
												<option value="2">线下</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>支付时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payTime"
												name="payTime" value="<%=str_date1 %>" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>收银员号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="casher"
												name="casher" value="11223211"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>交易支付流水</th>
													<th><font color="red">*</font>支付方式</th>
													<th><font color="red">*</font>支付金额</th>
													<th><font color="red">*</font>实际抵扣金额</th>
													<th><font color="red">*</font>汇率（折现率）</th>
													<th><font color="red">*</font>支付账号</th>
													<th><font color="red">*</font>会员id</th>
													<th>支付流水号</th>
													<th>优惠券类型</th>
													<th>优惠券批次</th>
													<th>券模板名称</th>
													<th>活动号</th>
													<th>收券规则</th>
													<th>收券规则描述</th>
													<th>备注</th>
													<th>结余</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="posFlowNo" readonly="readonly"></input>
													</td>
													<td><input name="paymentType" value="14114"></input>
													</td>
													<td><input name="amount"></input>
													</td>
													<td><input name="acturalAmount"></input>
													</td>
													<td><input name="rate" value="0"></input>
													</td>
													<td><input name="account" value="0001"></input>
													</td>
													<td><input name="userId" value="111"></input>
													</td>
													<td><input name="payFlowNo" value="0001"></input>
													</td>
													<td><input name="couponType" value="0001"></input>
													</td>
													<td><input name="couponBatch" value="0001"></input>
													</td>
													<td><input name="couponName" value="0001"></input>
													</td>
													<td><input name="activityNo" value="200"></input>
													</td>
													<td><input name="couponRule" value="0001"></input>
													</td>
													<td><input name="couponRuleName" value="desc"></input>
													</td>
													<td><input name="remark" value="无"></input>
													</td>
													<td><input name="cashBalance" value="0"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<!-- <div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>销售单号</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="saleNo1"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th>券编码</th>
													<th>券名称</th>
													<th>返利类型</th>
													<th>返利渠道</th>
													<th>返利日期</th>
													<th>值</th>
													<th>券批次</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="code" value="2001"></input>
													</td>
													<td><input name="name" value="2001"></input>
													</td>
													<td><input name="getType" value="2010"></input>
													</td>
													<td><input name="getChannel" value="01"></input>
													</td>
													<td><input name="getTimeStr"
														value="2015-02-15 00:00:00"></input>
													</td>
													<td><input name="amount1" value="0"></input>
													</td>
													<td><input name="couponBatch1" value="001"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th>行号</th>
													<th><font color="red">*</font>销售单号</th>
													<th><font color="red">*</font>销售总价</th>
													<th><font color="red">*</font>销售单商品行id</th>
													<th><font color="red">*</font>销售数量</th>
													<th>专柜商品编码</th>
													<th>大码</th>
													<th>促销</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="rowNo"></input>
													</td>
													<td><input name="saleNo"></input>
													</td>
													<td><input name="paymentAmount1"></input>
													</td>
													<td><input name="salesItemId"></input>
													</td>
													<td><input name="saleSum"></input>
													</td>
													<td><input name="supplyProductNo"></input>
													</td>
													<td><input name="erpProductNo"></input>
													</td>
													<td><input name="promotionSplits"
														value="[{'freightAmount':5,'promotionAmount':11,'promotionCode':'3768333','promotionDesc':'满200减30','promotionName':'满额优惠','promotionRule':'2344','promotionRuleName':'待定','promotionType':'优惠','splitRate':1}]"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div> -->

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="salePos1()" type="button" value="支付" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(3);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg3" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>支付失败!</strong>
										</div>
										<span id="returnMsg3"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(3);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 顾客提货弹框 -->
	<div class="modal modal-darkorange" id="btDiv4">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(4);">×</button>
					<h4 class="modal-title" id="divTitle4"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm4" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>销售单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="saleNo"
												name="saleNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>操作人编码：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="operator"
												name="operator" value="admin" />
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="takeStock1()" type="button" value="提货" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(4);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg4" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>提货失败!</strong>
										</div>
										<span id="returnMsg4"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(4);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- 创建退货申请单弹框 -->
	<div class="modal modal-darkorange" id="btDiv5">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(5);">×</button>
					<h4 class="modal-title" id="divTitle5"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm5" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active" style="height: 400px; overflow: scroll;">
								
									<div class="col-md-4">
										<label class="col-md-5 control-label">账号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="accountNo"
												name="accountNo" value="45343542521"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">会员编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="memberNo"
												name="memberNo" value="888888888"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>订单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id=""orderNo""
												name="orderNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">问题描述：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="problemDesc"
												name="problemDesc" value="提出的问题和建议" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">客户备注：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="customerComments"
												name="customerComments" value="客户要说的话" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">退货数量：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundNum"
												name="refundNum" value="0" />
										</div>
										&nbsp;
									</div>
									
									<!-- <div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货申请单状态：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundStatus" name="refundStatus"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="5" selected="selected">退货申请单状态1</option>
												<option value="6">退货申请单状态2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">申请时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="applyTime"
												name="applyTime" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退款路径：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundTarget" name="refundTarget"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">退款路径1</option>
												<option value="HHHR">退款路径2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退款渠道：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundMoneyChannel" name="refundMoneyChannel"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">退款渠道1</option>
												<option value="HHHR">退款渠道2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货单类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundType" name="refundType"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">退货单类型1</option>
												<option value="HHHR">退货单类型2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货单类别：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundClass" name="refundClass"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">退货单类别1</option>
												<option value="HHHR">退货单类别2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>退款金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundAmount"
												name="refundAmount" value="1000" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>实退金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="needRefundAmount"
												name="needRefundAmount" value="1000" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">实退运费：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="returnShippingFee"
												name="returnShippingFee" value="10" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>订单支付类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="paymentClass" name="paymentClass"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">订单支付类型1</option>
												<option value="HHHR">订单支付类型2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>订单支付类型描述：</span>
										</div>
										<div class="col-lg-7">
											<select id="paymentClassDesc" name="paymentClassDesc"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">订单支付类型描述1</option>
												<option value="HHHR">订单支付类型描述2</option>
											</select>
										</div>
										&nbsp;
									</div>
									
									<div class="col-md-4">
										<label class="col-md-5 control-label">客服备注：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="callCenterComments"
												name="callCenterComments" value="客服要说的话" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">包装情况：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="packStatus"
												name="packStatus" value="包装精美" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">商品情况：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="productsStatus"
												name="productsStatus" value="商品12312" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货申请创建方式：</span>
										</div>
										<div class="col-lg-7">
											<select id="createMode" name="createMode"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">退货申请创建方式1</option>
												<option value="HHHR">退货申请创建方式2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">换货单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="exchangeNo"
												name="exchangeNo" value="123212334" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">原交货单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="originalDeliveryNo"
												name="originalDeliveryNo" value="123212334" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">最后更新人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="latestUpdateMan"
												name="latestUpdateMan" value="admin" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">最后更新时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="latestUpdateTime"
												name="latestUpdateTime" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">创建时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="createdTime"
												name="createdTime" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货途径：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundPath" name="refundPath"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">退货途径1</option>
												<option value="1">退货途径2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货渠道：</span>
										</div>
										<div class="col-lg-7">
											<select id="channel" name="channel"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">退货渠道1</option>
												<option value="HHHR">退货渠道2</option>
											</select>
										</div>
										&nbsp;
									</div> -->
									<!-- <div class="col-md-12">
										<h4>回扣介质:</h4>
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>退货申请单行号</th>
													<th><font color="red">*</font>付款唯一行号</th>
													<th>扣回支付行</th>
													<th>二级支付方式</th>
													<th>付款代码</th>
													<th>扣回名称</th>
													<th>扣回券种</th>
													<th>扣回账户类型</th>
													<th>扣回金额</th>
													<th>退款支付金额</th>
													<th>折现冲抵比例</th>
													<th>扣回返券号</th>
													<th>会员账号</th>
													<th>返券活动ID</th>
													<th>返券策略ID</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="refundApplyNo" value="123442"></input>
													</td>
													<td><input name="rowNo1" value="123442"></input>
													</td>
													<td><input name="flag" value="1"></input>
													</td>
													<td><input name="payType" value="1"></input>
													</td>
													<td><input name="paycode" value="123442"></input>
													</td>
													<td><input name="payname" value="啊"></input>
													</td>
													<td><input name="coptype"></input>
													</td>
													<td><input name="couponGroup"></input>
													</td>
													<td><input name="amount"></input>
													</td>
													<td><input name="money"></input>
													</td>
													<td><input name="rate"></input>
													</td>
													<td><input name="payno"></input>
													</td>
													<td><input name="consumersId"></input>
													</td>
													<td><input name="couponEventId"></input>
													</td>
													<td><input name="couponPolicyId"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div> -->
									<div class="col-md-12">
										<h4>退货申请单明细:</h4>
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>订单详情行号</th>
													<th><font color="red">*</font>退货数量</th>
													<!-- <th><font color="red">*</font>退货申请明细</th>
													<th><font color="red">*</font>退货申请单号</th>
													<th><font color="red">*</font>原订单明细号</th>
													<th><font color="red">*</font>原订单号</th>
													<th><font color="red">*</font>销售单号</th>
													<th><font color="red">*</font>销售单明细号</th>
													<th><font color="red">*</font>sku编号</th>
													<th><font color="red">*</font>spu编号</th>
													<th><font color="red">*</font>专柜商品编号</th>
													<th><font color="red">*</font>ERP编号</th>
													<th><font color="red">*</font>供应商商品内部编码</th>
													<th><font color="red">*</font>商品单位</th>
													<th><font color="red">*</font>条形码</th>
													<th><font color="red">*</font>门店编号</th>
													<th><font color="red">*</font>门店名称</th>
													<th><font color="red">*</font>供应商编号</th>
													<th><font color="red">*</font>供应商名称</th>
													<th><font color="red">*</font>专柜编号</th>
													<th><font color="red">*</font>专柜名称</th>
													<th><font color="red">*</font>品牌</th>
													<th><font color="red">*</font>品牌名称</th>
													<th><font color="red">*</font>颜色编号</th>
													<th><font color="red">*</font>颜色名称</th>
													<th><font color="red">*</font>规格编号</th>
													<th><font color="red">*</font>规格名称</th>
													<th><font color="red">*</font>销售价</th>
													<th><font color="red">*</font>应退金额</th>
													<th><font color="red">*</font>实退金额</th>
													<th><font color="red">*</font>是否为赠品</th>
													<th><font color="red">*</font>创建时间</th>
													<th><font color="red">*</font>最后更新人</th>
													<th><font color="red">*</font>最后更新时间</th>
													<th><font color="red">*</font>扣率码</th>
													<th><font color="red">*</font>退货原因编号</th>
													<th><font color="red">*</font>退货原因描述</th>
													<th><font color="red">*</font>商品图片url</th>
													<th><font color="red">*</font>退货商品图片url</th>
													<th><font color="red">*</font>出库商品唯一编号</th>
													<th><font color="red">*</font>行号</th> -->
													
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="orderItemNo" ></input></td>
													<td><input name="refundNum1" onchange="getSum(this)"></input></td>
													<!-- <td><input name="applyItemNo" ></input>
													</td>
													<td><input name="applyNo"></input>
													</td>
													<td><input name="orderItemRowNo"></input>
													</td>
													<td><input name="orderNo"></input>
													</td>
													<td><input name="saleNo" ></input>
													</td>
													<td><input name="saleItemNo"></input>
													</td>
													<td><input name="skuNo" ></input>
													</td>
													<td><input name="spuNo" ></input>
													</td>
													<td><input name="supplyProductNo"></input>
													</td>
													<td><input name="erpProductNo" ></input>
													</td>
													<td><input name="supplyProductInnerCode"></input>
													</td>
													<td><input name="unit" ></input>
													</td>
													<td><input name="barCode" ></input>
													</td>
													<td><input name="shopNo" ></input>
													</td>
													<td><input name="shopName" ></input>
													</td>
													<td><input name="supplyNo" ></input>
													</td>
													<td><input name="supplyName" ></input>
													</td>
													<td><input name="shoppeNo" ></input>
													</td>
													<td><input name="shoppeName" ></input>
													</td>
													<td><input name="brandNo" ></input>
													</td>
													<td><input name="brandName" ></input>
													</td>
													<td><input name="colorNo" ></input>
													</td>
													<td><input name="colorName" ></input>
													</td>
													<td><input name="sizeNo" ></input>
													</td>
													<td><input name="sizeName" ></input>
													</td>
													<td><input name="salePrice" ></input>
													</td>
													<td><input name="refundAmount" ></input>
													</td>
													<td><input name="actualRefundAmount" ></input>
													</td>
													<td><input name="isGift" ></input>
													</td>
													<td><input name="createTime" ></input>
													</td>
													<td><input name="latestUpdateMan" ></input>
													</td>
													<td><input name="latestUpdateTime" ></input>
													</td>
													<td><input name="discountCode" ></input>
													</td>
													<td><input name="refundReasionNo" ></input>
													</td>
													<td><input name="refundReasionDesc" ></input>
													</td>
													<td><input name="proPictureUrl" ></input>
													</td>
													<td><input name="refundPcitureUrl" ></input>
													</td>
													<td><input name="productOnlySn" ></input>
													</td>
													<td><input name="rowNo" ></input>
													</td> -->
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="foundRefund1()" type="button" value="创建" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(5);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg5" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>创建失败!</strong>
										</div>
										<span id="returnMsg5"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(5);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	<!-- 客服创建退货申请单弹框 -->
	<div class="modal modal-darkorange" id="btDiv51">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(51);">×</button>
					<h4 class="modal-title" id="divTitle51"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm51" method="post" class="form-horizontal">
					<input type="hidden" name="latestUpdateMan" value=""/>
					<script type="text/javascript">
						$("input[name='userName']").val(getCookieValue("username"));
					</script>
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active" style="height: 400px; overflow: scroll;">
								
									<div class="col-md-4">
										<label class="col-md-5 control-label">账号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="accountNo"
												name="accountNo" value="45343542521"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">会员编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="memberNo"
												name="memberNo" value="888888888"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>订单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id=""orderNo""
												name="orderNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货申请单状态：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundStatus" name="refundStatus"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="1" selected="selected">待审核</option>
												<option value="2">审核不通过</option>
												<option value="3">取消中</option>
												<option value="4">审核通过</option>
												<option value="5">取消成功</option>
												<option value="6">已完结</option>
											</select>
										</div>
										&nbsp;
									</div>
									<!-- <div class="col-md-4">
										<label class="col-md-5 control-label">申请时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="applyTime"
												name="applyTime" />
										</div>
										&nbsp;
									</div> -->
									<div class="col-md-4">
										<label class="col-md-5 control-label">退货数量：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundNum5"
												name="refundNum"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退款路径：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundTarget" name="refundTarget"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">退款路径1</option>
												<option value="HHHR">退款路径2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退款渠道：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundMoneyChannel" name="refundMoneyChannel"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">退款渠道1</option>
												<option value="HHHR">退款渠道2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货单类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundType" name="refundType"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="5103" selected="selected">退货</option>
												<option value="5104">退款</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货单类别：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundClass" name="refundClass"
												class="form-control" style="padding: 0 0; width: 100%;">
												<!-- <option value="01" selected="selected">正常退</option>
												<option value="RejectReturn">拒收退货</option>
												<option value="03">换货退货</option>
												<option value="RequestCancelReturn">发货前退货</option>
												<option value="OOSReturn">缺货退货</option> -->
												<option value="RequestReturn"  selected="selected">客户发起退货</option>
												<option value="RequestCancelReturn">客户发起取消</option>
												<option value="RejectReturn">拒收退货</option>
												<option value="OOSReturn">缺货退货</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>退款金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundAmount"
												name="refundAmount" value="1000" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>实退金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="needRefundAmount"
												name="needRefundAmount" value="1000" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">实退运费：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="returnShippingFee"
												name="returnShippingFee" value="10" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>订单支付类型：</span>
										</div>
										<div class="col-lg-7">
											<select id="paymentClass" name="paymentClass"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">订单支付类型1</option>
												<option value="HHHR">订单支付类型2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>订单支付类型描述：</span>
										</div>
										<div class="col-lg-7">
											<select id="paymentClassDesc" name="paymentClassDesc"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">订单支付类型描述1</option>
												<option value="HHHR">订单支付类型描述2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">问题描述：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="problemDesc"
												name="problemDesc" value="提出的问题和建议" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">客户备注：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="customerComments"
												name="customerComments" value="客户要说的话" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">客服备注：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="callCenterComments"
												name="callCenterComments" value="客服要说的话" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">包装情况：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="packStatus"
												name="packStatus" value="包装精美" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">商品情况：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="productsStatus"
												name="productsStatus" value="商品12312" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货申请创建方式：</span>
										</div>
										<div class="col-lg-7">
											<select id="createMode" name="createMode"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">退货申请创建方式1</option>
												<option value="HHHR">退货申请创建方式2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">换货单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="exchangeNo"
												name="exchangeNo" value="123212334" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">原交货单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="originalDeliveryNo"
												name="originalDeliveryNo" value="123212334" />
										</div>
										&nbsp;
									</div>
									<!-- <div class="col-md-4">
										<label class="col-md-5 control-label">最后更新人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="latestUpdateMan"
												name="latestUpdateMan" value="admin" />
										</div>
										&nbsp;
									</div> -->
									<!-- <div class="col-md-4">
										<label class="col-md-5 control-label">最后更新时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="latestUpdateTime"
												name="latestUpdateTime" />
										</div>
										&nbsp;
									</div> -->
									<!-- <div class="col-md-4">
										<label class="col-md-5 control-label">创建时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="createdTime"
												name="createdTime" />
										</div>
										&nbsp;
									</div> -->
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货途径：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundPath" name="refundPath"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value=1 selected="selected">退货途径1</option>
												<option value=2>退货途径2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>退货渠道：</span>
										</div>
										<div class="col-lg-7">
											<select id="channel" name="channel"
												class="form-control" style="padding: 0 0; width: 100%;">
												<option value="THD" selected="selected">退货渠道1</option>
												<option value="HHHR">退货渠道2</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">扣款：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sellPayments"
												name="sellPayments" />
										</div>
										&nbsp;
									</div>
									<!-- <div class="col-md-12">
										<h4>回扣介质:</h4>
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>退货申请单行号</th>
													<th><font color="red">*</font>付款唯一行号</th>
													<th>扣回支付行</th>
													<th>二级支付方式</th>
													<th>付款代码</th>
													<th>扣回名称</th>
													<th>扣回券种</th>
													<th>扣回账户类型</th>
													<th>扣回金额</th>
													<th>退款支付金额</th>
													<th>折现冲抵比例</th>
													<th>扣回返券号</th>
													<th>会员账号</th>
													<th>返券活动ID</th>
													<th>返券策略ID</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="refundApplyNo" value="123442"></input>
													</td>
													<td><input name="rowNo1" value="123442"></input>
													</td>
													<td><input name="flag" value="1"></input>
													</td>
													<td><input name="payType" value="1"></input>
													</td>
													<td><input name="paycode" value="123442"></input>
													</td>
													<td><input name="payname" value="啊"></input>
													</td>
													<td><input name="coptype"></input>
													</td>
													<td><input name="couponGroup"></input>
													</td>
													<td><input name="amount"></input>
													</td>
													<td><input name="money"></input>
													</td>
													<td><input name="rate"></input>
													</td>
													<td><input name="payno"></input>
													</td>
													<td><input name="consumersId"></input>
													</td>
													<td><input name="couponEventId"></input>
													</td>
													<td><input name="couponPolicyId"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div> -->
									<div class="col-md-12">
											<h4>营销信息:</h4>
													<table style="width: 50px;">
														<thead>
															<tr>
																<th>操作</th>
																<th><font color="red">*</font>订单号</th>
																<th><font color="red">*</font>订单详情号</th>
																<th><font color="red">*</font>退货数量</th>
																<!-- <th>退货申请明细号</th>
																<th>退货申单号</th>
																
																<th>销售单号</th>
																<th>销售单明细号</th>
																<th>SKU编号</th>
																<th>SPU编号</th>
																<th>专柜商品编号</th>
																<th>ERP编号</th>
																<th>供应商商品内部编码</th>
																<th>商品单位</th>
																<th>条形码</th>
																<th>门店编号</th>
																<th>门店名称</th>
																<th>供应商编号</th>
																<th>供应商名称</th>
																<th>专柜编号</th>
																<th>专柜名称</th>
																<th>品牌</th>
																<th>品牌名称</th>
																<th>颜色编号</th>
																<th>颜色名称</th>
																<th>规格编号</th>
																<th>规格名称</th>
																<th>退货数量</th>
																<th>销售价</th>
																<th>退货金额</th>
																<th>实退金额</th>
																<th>是否为赠品</th>
																<th>创建时间</th>
																<th>最后更新人</th>
																<th>最后更新时间</th>
																<th>口率码</th>
																<th>退货原因编号</th>
																<th>退货原因描述</th>
																<th>商品图片url</th>
																<th>退货商品图片url</th>
																<th>出库商品唯一编号</th>
																<th>行号</th>
																<th>订单详情行号</th> -->
																<th>扣款介质分摊</th>
																<th>返利分摊</th>
																<th>促销分摊</th>
																<!-- <th>扣款</th> -->
																<!-- <th>促销清单</th>
																<th>用券分摊</th>
																<th>返券分摊</th> -->
															</tr>
														</thead>
														<tbody>
														  <tr>
														  	<td><input type="button" onclick="getPromResulet(this)" value="获取营销信息"/></td>
														  	<td><input name="orderNo"></input></td>
															<td><input name="orderItemNo"></input></td>
															<td><input name="refundNum15" onchange="getKeSum(this)"></input></td>
															<!-- <td><input name="applyItemNo" ></input></td>
															<td><input name="applyNo" ></input></td>
															
															<td><input name="saleNo" ></input></td>
															<td><input name="saleItemNo" ></input></td>
															<td><input name="skuNo" ></input></td>
															<td><input name="spuNo" ></input></td>
															<td><input name="supplyProductNo" ></input></td>
															<td><input name="erpProductNo" ></input></td>
															<td><input name="supplyProductInnerCode" ></input></td>
															<td><input name="unit" ></input></td>
															<td><input name="barCode" ></input></td>
															<td><input name="shopNo" ></input></td>
															<td><input name="shopName" ></input></td>
															<td><input name="supplyNo" ></input></td>
															<td><input name="supplyName" ></input></td>
															<td><input name="shoppeNo" ></input></td>
															<td><input name="shoppeName" ></input></td>
															<td><input name="brandNo" ></input></td>
															<td><input name="brandName" ></input></td>
															<td><input name="colorNo" ></input></td>
															<td><input name="colorName" ></input></td>
															<td><input name="sizeNo" ></input></td>
															<td><input name="sizeName" ></input></td>
															<td><input name="refundNum" ></input></td>
															<td><input name="salePrice" ></input></td>
															<td><input name="refundAmount" ></input></td>
															<td><input name="actualRefundAmount" ></input></td>
															<td><input name="isGift" ></input></td>
															<td><input name="CreateTimeStr" ></input></td>
															<td><input name="latestUpdateMan" ></input></td>
															<td><input name="latestUpdateTimeStr" ></input></td>
															<td><input name="discountCode" ></input></td>
															<td><input name="refundReasionNo" ></input></td>
															<td><input name="refundReasionDesc" ></input></td>
															<td><input name="propictureUrl" ></input></td>
															<td><input name="refundPcitureUrl" ></input></td>
															<td><input name="productOnlySn" ></input></td>
															<td><input name="rowNo" ></input></td>
															<td><input name="orderItemRowNo" ></input></td> -->
															<td><input name="refundApplyDeductionSplitDto" ></input></td>
															<td><input name="refundApplyGetSplitDto" ></input></td>
															<td><input name="refundApplyPromotionSplitDto" ></input></td>
															<!-- <td><input name="sellPayments" ></input></td> -->
															<!-- <td><input name="popDetails" ></input></td>
															<td><input name="couponUses" ></input></td>
															<td><input name="couponGains" ></input></td> -->
															<td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
														  </tr>
														</tbody>
													</table>&nbsp;
												</div>
									<!-- <div class="col-md-12">
										<h4>退货申请单明细:</h4>
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>订单详情行号</th>
													<th><font color="red">*</font>退货数量</th>
													<th><font color="red">*</font>退货申请明细</th>
													<th><font color="red">*</font>退货申请单号</th>
													<th><font color="red">*</font>原订单明细号</th>
													<th><font color="red">*</font>原订单号</th>
													<th><font color="red">*</font>销售单号</th>
													<th><font color="red">*</font>销售单明细号</th>
													<th><font color="red">*</font>sku编号</th>
													<th><font color="red">*</font>spu编号</th>
													<th><font color="red">*</font>专柜商品编号</th>
													<th><font color="red">*</font>ERP编号</th>
													<th><font color="red">*</font>供应商商品内部编码</th>
													<th><font color="red">*</font>商品单位</th>
													<th><font color="red">*</font>条形码</th>
													<th><font color="red">*</font>门店编号</th>
													<th><font color="red">*</font>门店名称</th>
													<th><font color="red">*</font>供应商编号</th>
													<th><font color="red">*</font>供应商名称</th>
													<th><font color="red">*</font>专柜编号</th>
													<th><font color="red">*</font>专柜名称</th>
													<th><font color="red">*</font>品牌</th>
													<th><font color="red">*</font>品牌名称</th>
													<th><font color="red">*</font>颜色编号</th>
													<th><font color="red">*</font>颜色名称</th>
													<th><font color="red">*</font>规格编号</th>
													<th><font color="red">*</font>规格名称</th>
													<th><font color="red">*</font>销售价</th>
													<th><font color="red">*</font>应退金额</th>
													<th><font color="red">*</font>实退金额</th>
													<th><font color="red">*</font>是否为赠品</th>
													<th><font color="red">*</font>创建时间</th>
													<th><font color="red">*</font>最后更新人</th>
													<th><font color="red">*</font>最后更新时间</th>
													<th><font color="red">*</font>扣率码</th>
													<th><font color="red">*</font>退货原因编号</th>
													<th><font color="red">*</font>退货原因描述</th>
													<th><font color="red">*</font>商品图片url</th>
													<th><font color="red">*</font>退货商品图片url</th>
													<th><font color="red">*</font>出库商品唯一编号</th>
													<th><font color="red">*</font>行号</th>
													
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="orderItemNoq" ></input>
													</td>
													<td><input name="refundNum15" onchange="getKeSum(this)"></input>
													</td>
													<td><input name="applyItemNo" ></input>
													</td>
													<td><input name="applyNo"></input>
													</td>
													<td><input name="orderItemRowNo"></input>
													</td>
													<td><input name="orderNo"></input>
													</td>
													<td><input name="saleNo" ></input>
													</td>
													<td><input name="saleItemNo"></input>
													</td>
													<td><input name="skuNo" ></input>
													</td>
													<td><input name="spuNo" ></input>
													</td>
													<td><input name="supplyProductNo"></input>
													</td>
													<td><input name="erpProductNo" ></input>
													</td>
													<td><input name="supplyProductInnerCode"></input>
													</td>
													<td><input name="unit" ></input>
													</td>
													<td><input name="barCode" ></input>
													</td>
													<td><input name="shopNo" ></input>
													</td>
													<td><input name="shopName" ></input>
													</td>
													<td><input name="supplyNo" ></input>
													</td>
													<td><input name="supplyName" ></input>
													</td>
													<td><input name="shoppeNo" ></input>
													</td>
													<td><input name="shoppeName" ></input>
													</td>
													<td><input name="brandNo" ></input>
													</td>
													<td><input name="brandName" ></input>
													</td>
													<td><input name="colorNo" ></input>
													</td>
													<td><input name="colorName" ></input>
													</td>
													<td><input name="sizeNo" ></input>
													</td>
													<td><input name="sizeName" ></input>
													</td>
													<td><input name="salePrice" ></input>
													</td>
													<td><input name="refundAmount" ></input>
													</td>
													<td><input name="actualRefundAmount" ></input>
													</td>
													<td><input name="isGift" ></input>
													</td>
													<td><input name="createTime" ></input>
													</td>
													<td><input name="latestUpdateMan" ></input>
													</td>
													<td><input name="latestUpdateTime" ></input>
													</td>
													<td><input name="discountCode" ></input>
													</td>
													<td><input name="refundReasionNo" ></input>
													</td>
													<td><input name="refundReasionDesc" ></input>
													</td>
													<td><input name="proPictureUrl" ></input>
													</td>
													<td><input name="refundPcitureUrl" ></input>
													</td>
													<td><input name="productOnlySn" ></input>
													</td>
													<td><input name="rowNo" ></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div> -->
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="createKeRefund1()" type="button" value="创建" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(51);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg51" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>创建失败!</strong>
										</div>
										<span id="returnMsg51"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(51);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 缺货退货创建退货申请单弹框 -->
	<div class="modal modal-darkorange" id="btDiv52">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(52);">×</button>
					<h4 class="modal-title" id="divTitle52"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm52" method="post" class="form-horizontal">
					<%-- <input type="hidden" name="latestUpdateMan" value="${username }"/> --%>
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active" style="height: 400px; overflow: scroll;">
								
									<div class="col-md-4">
										<label class="col-md-5 control-label">销售单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="saleNo"
												name="saleNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">处理人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="latestUpdateMan"
												name="latestUpdateMan" value="admin"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-12">
											<h4>明细信息:</h4>
													<table style="width: 50px;">
														<thead>
															<tr>
																<th><font color="red">*</font>缺货数量</th>
																<th><font color="red">*</font>销售单详情号</th>
															</tr>
														</thead>
														<tbody>
														  <tr>
														  	<td><input name="refundNum"></input></td>
															<td><input name="salesItemNo"></input></td>
															<td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
														  </tr>
														</tbody>
													</table>&nbsp;
												</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="createInerimRefund1()" type="button" value="创建" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(52);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg52" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>创建失败!</strong>
										</div>
										<span id="returnMsg52"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(52);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 拒收退货创建退货申请单弹框 -->
	<div class="modal modal-darkorange" id="btDiv53">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(53);">×</button>
					<h4 class="modal-title" id="divTitle53"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm53" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">
									<%-- <div class="col-md-4">
										<label class="col-md-5 control-label">订单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderNo"
												name="orderNo"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">包裹单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="packageNo"
												name="packageNo"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">快递单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="deliveryNo"
												name="deliveryNo"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">快递记录：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="deliveryRecord"
												name="deliveryRecord"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">包裹状态：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="packageStatus"
												name="packageStatus"  value="6004"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">包裹状态描述：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="packageStatusDesc"
												name="packageStatusDesc"  value="拒收"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">快递时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="deliveryDateStr"
												name="deliveryDateStr"  value="<%=str_date1 %>"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">快递员：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="deliveryMan"
												name="deliveryMan" value="小强"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">快递员编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="deliveryManNo"
												name="deliveryManNo" value="007"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">快递公司：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="delComName"
												name="delComName"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">快递公司编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="delComNo"
												name="delComNo"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">操作人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="updateMan"
												name="updateMan" value="admin"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">备注：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="remark"
												name="remark"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">系统来源：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="operatorSource"
												name="operatorSource" value="ERP"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">是否签收：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="isSign"
												name="isSign" value="0"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">是否拒收：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="isRefuseSign"
												name="isRefuseSign" value="1"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">签收时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="signTimeStr"
												name="signTimeStr"  value="<%=str_date1 %>"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">签收人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="signName"
												name="signName" value="admin"/>
										</div>
										&nbsp;
									</div><div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>包裹单号</th>
													<th><font color="red">*</font>快递单号</th>
													<th><font color="red">*</font>销售单号</th>
													<th><font color="red">*</font>数量</th>
													<th><font color="red">*</font>销售单明细号</th>
													
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="packageNo1"></input></td>
													<td><input name="deliveryNo1"></input></td>
													<td><input name="saleNo"></input></td>
													<td><input name="saleNum"></input></td>
													<td><input name="saleItemNo"></input></td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
													
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div> --%>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>订单号</th>
													<th><font color="red">*</font>包裹单号</th>
													<th><font color="red">*</font>快递单号</th>
													<th><font color="red">*</font>快递记录</th>
													<th>包裹状态</th>
													<th>包裹状态描述</th>
													<th>快递时间</th>
													<th>快递员</th>
													<th>快递员编号</th>
													<th>快递公司</th>
													<th>快递公司编号</th>
													<th>操作人</th>
													<th>备注</th>
													<th>系统来源</th>
													<th>是否签收</th>
													<th>是否拒收</th>
													<th>签收时间</th>
													<th>签收人</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="orderNo"></input>
													</td>
													<td><input name="packageNo"></input>
													</td>
													<td><input name="deliveryNo"></input>
													</td>
													<td><input name="deliveryRecord"></input>
													</td>
													<td><input name="packageStatus" value="6004" readonly="readonly"></input>
													</td>
													<td><input name="packageStatusDesc" value="拒收" readonly="readonly"></input>
													</td>
													<td><input name="deliveryDateStr" value="<%=str_date1 %>"></input>
													</td>
													<td><input name="deliveryMan" value="0001"></input>
													</td>
													<td><input name="deliveryManNo" value="小强"></input>
													</td>
													<td><input name="delComName"></input>
													</td>
													<td><input name="delComNo"></input>
													</td>
													<td><input name="updateMan" value="admin"></input>
													</td>
													<td><input name="remark"></input>
													</td>
													<td><input name="operatorSource" value="ERP"></input>
													</td>
													<td><input name="isSign" value="0" readonly="readonly"></input>
													</td>
													<td><input name="isRefuseSign" value="1" readonly="readonly"></input>
													</td>
													<td><input name="signTimeStr" value="<%=str_date1 %>"></input>
													</td>
													<td><input name="signName" value="admin"></input>
													</td>

													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="createRefuseRefund1()" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(53);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg53" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>保存失败!</strong>
										</div>
										<span id="returnMsg53"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(53);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 打印退货单 -->
	<div class="modal modal-darkorange" id="btDiv6">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(6);">×</button>
					<h4 class="modal-title" id="divTitle6"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm6" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>退货单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundNo"
												name="refundNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>操作人编码：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="operator"
												name="operator" value="admin" />
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="printRefund1()" type="button" value="打印" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(6);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg6" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>打印失败!</strong>
										</div>
										<span id="returnMsg6"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(6);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 审核退货单 -->
	<div class="modal modal-darkorange" id="btDiv7">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(7);">×</button>
					<h4 class="modal-title" id="divTitle7"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm7" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>退货单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundNo"
												name="refundNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>操作人编码：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="operator"
												name="operator" value="admin" />
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="examineRefund1()" type="button" value="审核" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(7);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg7" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>审核失败!</strong>
										</div>
										<span id="returnMsg7"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(7);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- 退货单退款 -->
	<div class="modal modal-darkorange" id="btDiv8">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(8);">×</button>
					<h4 class="modal-title" id="divTitle8"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm8" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>款机流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesPaymentNo"
												name="salesPaymentNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>总金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="money"
												name="money" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>机器号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="posNo"
												name="posNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>总应收：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="paymentAmount"
												name="paymentAmount" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>实际支付：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="actualPaymentAmount" name="actualPaymentAmount" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>门店号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="shopNo"
												name="shopNo" value="8888" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>门店名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="shopName"
												name="shopName" value="王府井店" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>线上线下标识：</span>
										</div>
										<div class="col-lg-7">
											<select id="ooFlag" name="ooFlag" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="1">线上</option>
												<option value="2" selected="selected">线下</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>支付时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payTimeStr"
												name="payTimeStr" value="<%=str_date1 %>" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>收银员号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="casher"
												name="casher" value="1234" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>渠道标志：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="channel"
												name="channel" value="1" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>会员卡号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="memberNo"
												name="memberNo" value="111" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">授权卡号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="authorizationNo"
												name="authorizationNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">交易流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payFlowNo"
												name="payFlowNo" value="1111" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>水单类型:</span>
										</div>
										<div class="col-lg-7">
											<select id="isRefund" name="isRefund" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="0">支付</option>
												<option value="1" selected="selected">退款</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">总折扣：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="totalDiscountAmount" name="totalDiscountAmount"
												value="0" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">找零：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="changeAmount"
												name="changeAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">折扣额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="tempDiscountAmount" name="tempDiscountAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">折让额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="zrAmount"
												name="zrAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">会员总折扣：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="memberDiscountAmount" name="memberDiscountAmount"
												value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">优惠折扣额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="promDiscountAmount" name="promDiscountAmount" value="0" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">收银损益：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="income"
												name="income" value="0" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>班次：</span>
										</div>
										<div class="col-lg-7">
											<select id="shifts" name="shifts" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="0">早班</option>
												<option value="1" selected="selected">中班</option>
												<option value="2">晚班</option>
											</select>
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">微信卡类型：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="weixinCard"
												name="weixinCard" value="001" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">微信卡门店号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="weixinStoreNo"
												name="weixinStoreNo" value="00001" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">线上订单号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderNo"
												name="orderNo" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">人民币</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="rmb" name="rmb"
												value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">电子返券</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="elecGet"
												name="elecGet" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">电子扣款</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="elecDeducation"
												name="elecDeducation" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">银行手续费</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="bankServiceCharge" name="bankServiceCharge" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">来源</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sourceType"
												name="sourceType" />
										</div>
										&nbsp;
									</div>
									&nbsp;
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>一级支付介质</th>
													<th><font color="red">*</font>二级支付介质</th>
													<th><font color="red">*</font>支付金额</th>
													<th><font color="red">*</font>实际抵扣金额</th>
													<th><font color="red">*</font>汇率（折现率）</th>
													<th><font color="red">*</font>支付账号</th>
													<th><font color="red">*</font>会员id</th>
													<th>支付流水号</th>
													<th>优惠券类型</th>
													<th>优惠券批次</th>
													<th>券模板名称</th>
													<th>活动号</th>
													<th>收券规则</th>
													<th>收券规则描述</th>
													<th>备注</th>
													<th>结余</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="paymentClass" value="0016"></input>
													</td>
													<td><input name="paymentType" value="14114"></input>
													</td>
													<td><input name="amount"></input>
													</td>
													<td><input name="acturalAmount"></input>
													</td>
													<td><input name="rate" value="0"></input>
													</td>
													<td><input name="account" value="0001"></input>
													</td>
													<td><input name="userId" value="1111"></input>
													</td>
													<td><input name="payFlowNo" value="0001"></input>
													</td>
													<td><input name="couponType" value="0001"></input>
													</td>
													<td><input name="couponBatch" value="0001"></input>
													</td>
													<td><input name="couponName" value="0001"></input>
													</td>
													<td><input name="activityNo" value="200"></input>
													</td>
													<td><input name="couponRule" value="0001"></input>
													</td>
													<td><input name="couponRuleName" value="desc"></input>
													</td>
													<td><input name="remark" value="无"></input>
													</td>
													<td><input name="cashBalance" value="0"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>退货单号</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="refundNo1"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th>券编码</th>
													<th>券名称</th>
													<th>返利类型</th>
													<th>返利渠道</th>
													<th>返利日期</th>
													<th>值</th>
													<th>券批次</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="code" value="2001"></input>
													</td>
													<td><input name="name" value="2001"></input>
													</td>
													<td><input name="getType" value="2010"></input>
													</td>
													<td><input name="getChannel" value="01"></input>
													</td>
													<td><input name="getTimeStr"
														value="2015-02-15 00:00:00"></input>
													</td>
													<td><input name="amount2" value="0"></input>
													</td>
													<td><input name="couponBatch2" value="001"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th>一级支付方式</th>
													<th>二级支付方式</th>
													<th>扣款原因</th>
													<th>扣款类型</th>
													<th>扣款金额</th>
													<th>账号</th>
													<th>优惠券类型</th>
													<th>券批次</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="paymentClass1" value="0001"></input>
													</td>
													<td><input name="paymentType1" value="0001"></input>
													</td>
													<td><input name="deductionReason" value="0001"></input>
													</td>
													<td><input name="deductionType" value="0001"></input>
													</td>
													<td><input name="deductionAmount" value="0"></input>
													</td>
													<td><input name="account1" value="0001"></input>
													</td>
													<td><input name="couponType1" value="0001"></input>
													</td>
													<td><input name="couponBatch1" value="0001"></input>
													</td>

													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th>行号</th>
													<th><font color="red">*</font>退货单号</th>
													<th><font color="red">*</font>退货总价</th>
													<th><font color="red">*</font>退货单商品行id</th>
													<th><font color="red">*</font>退货数量</th>
													<th>专柜商品编码</th>
													<th>大码</th>
													<th>促销</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="rowNo"></input>
													</td>
													<td><input name="saleNo"></input>
													</td>
													<td><input name="paymentAmount1"></input>
													</td>
													<td><input name="salesItemId"></input>
													</td>
													<td><input name="saleSum"></input>
													</td>
													<td><input name="supplyProductNo"></input>
													</td>
													<td><input name="erpProductNo"></input>
													</td>
													<td><input name="promotionSplits"
														value="[{'freightAmount':5,'promotionAmount':11,'promotionCode':'3768333','promotionDesc':'满200减30','promotionName':'满额优惠','promotionRule':'2344','promotionRuleName':'待定','promotionType':'优惠','splitRate':1}]"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="refundPos1()" type="button" value="退款" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(8);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg8" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>退款失败!</strong>
										</div>
										<span id="returnMsg8"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(8);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- 导购还库 -->
	<div class="modal modal-darkorange" id="btDiv9">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(9);">×</button>
					<h4 class="modal-title" id="divTitle9"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm9" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>退货单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundNo"
												name="refundNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>操作人编码：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="operator"
												name="operator" value="admin" />
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="returnStock1()" type="button" value="还库" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(9);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg9" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>还库失败!</strong>
										</div>
										<span id="returnMsg9"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(9);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 订单审核 -->
	<%-- <div class="modal modal-darkorange" id="btDiv10">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(10);">×</button>
					<h4 class="modal-title" id="divTitle10"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm10" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>款机流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesPaymentNo"
												name="salesPaymentNo" />
										</div>
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>总金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="money"
												name="money" value="0" />
										</div>
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>机器号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="posNo"
												name="posNo" value="9998" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>总应收：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="paymentAmount"
												name="paymentAmount" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>实际支付：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="actualPaymentAmount" name="actualPaymentAmount" />
										</div>
										&nbsp;
									</div>


									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>线上线下标识：</span>
										</div>
										<div class="col-lg-7">
											<select id="ooFlag" name="ooFlag" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="1">线上</option>
												<option value="2" selected="selected">线下</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>支付时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payTimeStr"
												name="payTimeStr" value="<%=str_date1 %>" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>门店号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="shopNo"
												name="shopNo" value="8888" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>门店名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="shopName"
												name="shopName" value="王府井店" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>会员卡号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="memberNo"
												name="memberNo" value="111" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>收银员号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="casher"
												name="casher" value="1234" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>渠道标志：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="channel"
												name="channel" value="1" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">授权卡号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="authorizationNo"
												name="authorizationNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>水单类型:</span>
										</div>
										<div class="col-lg-7">
											<select id="isRefund" name="isRefund" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="0" selected="selected">支付</option>
												<option value="1">退款</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">交易流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payFlowNo"
												name="payFlowNo" value="1111" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">总折扣：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="totalDiscountAmount" name="totalDiscountAmount"
												value="0" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">找零：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="changeAmount"
												name="changeAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">折扣额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="tempDiscountAmount" name="tempDiscountAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">折让额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="zrAmount"
												name="zrAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">会员总折扣：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="memberDiscountAmount" name="memberDiscountAmount"
												value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">优惠折扣额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="promDiscountAmount" name="promDiscountAmount" value="0" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">收银损益：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="income"
												name="income" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>班次：</span>
										</div>
										<div class="col-lg-7">
											<select id="shifts" name="shifts" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="0">早班</option>
												<option value="1" selected="selected">中班</option>
												<option value="2">晚班</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">微信卡类型：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="weixinCard"
												name="weixinCard" value="001" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">微信卡门店号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="weixinStoreNo"
												name="weixinStoreNo" value="00001" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">线上订单号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderNo"
												name="orderNo" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">人民币</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="rmb" name="rmb"
												value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">电子返券</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="elecGet"
												name="elecGet" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">电子扣款</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="elecDeducation"
												name="elecDeducation" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">银行手续费</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="bankServiceCharge" name="bankServiceCharge" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">来源</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sourceType"
												name="sourceType" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th>一级支付介质</th>
													<th>二级支付介质</th>
													<th><font color="red">*</font>支付金额</th>
													<th><font color="red">*</font>实际抵扣金额</th>
													<th>汇率（折现率）</th>
													<th>支付账号</th>
													<th>会员id</th>
													<th>支付流水号</th>
													<th>优惠券类型</th>
													<th>优惠券批次</th>
													<th>券模板名称</th>
													<th>活动号</th>
													<th>收券规则</th>
													<th>收券规则描述</th>
													<th>备注</th>
													<th>结余</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="paymentClass" value="0016"></input>
													</td>
													<td><input name="paymentType" value="14114"></input>
													</td>
													<td><input name="amount"></input>
													</td>
													<td><input name="acturalAmount"></input>
													</td>
													<td><input name="rate" value="0"></input>
													</td>
													<td><input name="account" value="0001"></input>
													</td>
													<td><input name="userId" value="111"></input>
													</td>
													<td><input name="payFlowNo" value="0001"></input>
													</td>
													<td><input name="couponType" value="0001"></input>
													</td>
													<td><input name="couponBatch" value="0001"></input>
													</td>
													<td><input name="couponName" value="0001"></input>
													</td>
													<td><input name="activityNo" value="200"></input>
													</td>
													<td><input name="couponRule" value="0001"></input>
													</td>
													<td><input name="couponRuleName" value="desc"></input>
													</td>
													<td><input name="remark" value="无"></input>
													</td>
													<td><input name="cashBalance" value="0"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th>券编码</th>
													<th>券名称</th>
													<th>返利类型</th>
													<th>返利渠道</th>
													<th>返利日期</th>
													<th>值</th>
													<th>券批次</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="code" value="2001"></input>
													</td>
													<td><input name="name" value="2001"></input>
													</td>
													<td><input name="getType" value="2010"></input>
													</td>
													<td><input name="getChannel" value="01"></input>
													</td>
													<td><input name="getTimeStr"
														value="2015-02-15 00:00:00"></input>
													</td>
													<td><input name="amount1" value="0"></input>
													</td>
													<td><input name="couponBatch1" value="001"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th>行号</th>
													<th><font color="red">*</font>销售单号</th>
													<th><font color="red">*</font>销售总价</th>
													<th><font color="red">*</font>销售单商品行id</th>
													<th><font color="red">*</font>销售数量</th>
													<th>专柜商品编码</th>
													<th>大码</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="rowNo"></input>
													</td>
													<td><input name="saleNo"></input>
													</td>
													<td><input name="paymentAmount1"></input>
													</td>
													<td><input name="salesItemId"></input>
													</td>
													<td><input name="saleSum"></input>
													</td>
													<td><input name="supplyProductNo"></input>
													</td>
													<td><input name="erpProductNo"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="salePay1()" type="button" value="支付" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(10);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg10" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>全脱机支付失败!</strong>
										</div>
										<span id="returnMsg10"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(10);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div> --%>
	<!-- 订单审核 -->
	<div class="modal modal-darkorange" id="btDiv10">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(10);">×</button>
					<h4 class="modal-title" id="divTitle10"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm10" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>订单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderNo"
												name="orderNo"/>
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save12"
												onclick="fundOrder()" type="button" value="查询" />&emsp;&emsp;
										</div>
										&nbsp;
									</div>
									<!-- 隐藏框 -->
									<div class="col-xs-12 col-md-12" id="hid">
										<div class="widget-body" id="pro101">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="fundOrderInput"></div>
											
										</div>
										&nbsp;
									</div>
									
									<div class="form-group">
										<label class="col-lg-2 control-label">客服备注：</label>
										<div class="col-lg-7">
											<textarea style="width: 500px;height: 100px;" id="callCenterComments" name="callCenterComments" placeholder="非必填"></textarea>
										</div>
        							</div>
									
									<div class="col-md-4">
										<label class="col-md-5 control-label">审核人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="UpdateMan"
												name="UpdateMan" value="admin"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>是否通过：</span>
										</div>
										<div class="col-lg-7">
											<select id="orderStatus" name="orderStatus" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="9203" selected="selected">不通过</option>
												<option value="9202">通过</option>
											</select>
										</div>
										&nbsp;
									</div>
									<%-- <div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>款机流水单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesPaymentNo"
												name="salesPaymentNo" value="1234567"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>总金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="money"
												name="money" value="100"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>交易流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payFlowNo"
												name="payFlowNo" value="7654321"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>线上线下标识：</span>
										</div>
										<div class="col-lg-7">
											<select id="ooFlag" name="ooFlag" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="1" selected="selected">线上</option>
												<option value="2">线下</option>
											</select>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>支付时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payTime"
												name="payTime" value="<%=str_date1 %>" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>线上订单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderNo"
												name="orderNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>收银员号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="casher"
												name="casher" value="11223211"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>交易支付流水</th>
													<th><font color="red">*</font>支付方式</th>
													<th><font color="red">*</font>支付金额</th>
													<th><font color="red">*</font>实际抵扣金额</th>
													<th><font color="red">*</font>汇率（折现率）</th>
													<th><font color="red">*</font>支付账号</th>
													<th><font color="red">*</font>会员id</th>
													<th>支付流水号</th>
													<th>优惠券类型</th>
													<th>优惠券批次</th>
													<th>券模板名称</th>
													<th>活动号</th>
													<th>收券规则</th>
													<th>收券规则描述</th>
													<th>备注</th>
													<th>结余</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="posFlowNo" value="0016"></input>
													</td>
													<td><input name="paymentType" value="14114"></input>
													</td>
													<td><input name="amount"></input>
													</td>
													<td><input name="acturalAmount"></input>
													</td>
													<td><input name="rate" value="0"></input>
													</td>
													<td><input name="account" value="0001"></input>
													</td>
													<td><input name="userId" value="111"></input>
													</td>
													<td><input name="payFlowNo" value="0001"></input>
													</td>
													<td><input name="couponType" value="0001"></input>
													</td>
													<td><input name="couponBatch" value="0001"></input>
													</td>
													<td><input name="couponName" value="0001"></input>
													</td>
													<td><input name="activityNo" value="200"></input>
													</td>
													<td><input name="couponRule" value="0001"></input>
													</td>
													<td><input name="couponRuleName" value="desc"></input>
													</td>
													<td><input name="remark" value="无"></input>
													</td>
													<td><input name="cashBalance" value="0"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div> --%>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="orderSh()" type="button" value="审核" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(10);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg10" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>审核失败!</strong>
										</div>
										<span id="returnMsg10"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(10);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 订单取消 -->
	<div class="modal modal-darkorange" id="btDiv101">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(101);">×</button>
					<h4 class="modal-title" id="divTitle101"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm101" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>订单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderNo"
												name="orderNo"/>
										</div>
										&nbsp;
									</div>
									<!-- <div class="form-group">
										<div class="col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save12"
												onclick="fundOrder()" type="button" value="查询" />&emsp;&emsp;
										</div>
										&nbsp;
									</div>
									隐藏框
									<div class="col-xs-12 col-md-12" id="hid">
										<div class="widget-body" id="pro10">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="fundOrderInput"></div>
											
										</div>
										&nbsp;
									</div> -->
									<div class="col-md-4">
										<label class="col-md-5 control-label">操作人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="lastUpdateMan"
												name="lastUpdateMan" value="admin"/>
										</div>
										&nbsp;
									</div>
									<!-- <div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>是否通过：</span>
										</div>
										<div class="col-lg-7">
											<select id="orderType" name="orderType" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="9202" selected="selected">审核不通过</option>
												<option value="9203">已审核</option>
											</select>
										</div>
										&nbsp;
									</div> -->

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="orderDis()" type="button" value="确定" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(101);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg101" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>取消失败!</strong>
										</div>
										<span id="returnMsg101"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(101);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- PAD创建 -->
	<div class="modal modal-darkorange" id="btDiv11">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(11);">×</button>
					<h4 class="modal-title" id="divTitle11"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm11" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">


									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>机器号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="posNo"
												name="posNo" value="9999" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>门店号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="shopNo"
												name="shopNo" value="8888" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>门店名称：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="shopName"
												name="shopName" value="王府井店" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>线上线下标识：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="ooFlag"
												name="ooFlag" value="2" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>水单类型:</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="isRefund"
												name="isRefund" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>渠道标志：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="channel"
												name="channel" value="1" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>收银员号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="casher"
												name="casher" value="1234" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">授权卡号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="authorizationNo"
												name="authorizationNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>班次：</span>
										</div>
										<div class="col-lg-7">
											<select id="shifts" name="shifts" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="0">早班</option>
												<option value="1" selected="selected">中班</option>
												<option value="2">晚班</option>
											</select>
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">微信卡类型：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="weixinCard"
												name="weixinCard" value="001" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">微信卡门店号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="weixinStoreNo"
												name="weixinStoreNo" value="00001" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">会员卡号会员ID</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="memberNo"
												name="memberNo" value="111" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">线上订单号</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="orderNo"
												name="orderNo" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">来源</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="sourceType"
												name="sourceType" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>销售单号</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="saleNo"></input></td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="salePadCreat1()" type="button" value="创建" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(11);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg11" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>PAD创建失败!</strong>
										</div>
										<span id="returnMsg11"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(11);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- PAD添加销售单 -->
	<div class="modal modal-darkorange" id="btDiv12">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(12);">×</button>
					<h4 class="modal-title" id="divTitle12"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm12" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>款机流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesPaymentNo"
												name="salesPaymentNo" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>销售单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="saleNo"
												name="saleNo" />
										</div>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="salePadAdd1()" type="button" value="添加" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(12);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg12" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>PAD添加失败!</strong>
										</div>
										<span id="returnMsg12"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(12);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- PAD取消 -->
	<div class="modal modal-darkorange" id="btDiv13">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(13);">×</button>
					<h4 class="modal-title" id="divTitle13"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm13" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>款机流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesPaymentNo"
												name="salesPaymentNo" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>销售单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="saleNo"
												name="saleNo" />
										</div>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="salePadCancle1()" type="button" value="取消" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(13);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg13" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>PAD取消失败!</strong>
										</div>
										<span id="returnMsg13"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(13);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- PAD支付 -->
	<div class="modal modal-darkorange" id="btDiv14">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(14);">×</button>
					<h4 class="modal-title" id="divTitle14"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm14" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>款机流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesPaymentNo"
												name="salesPaymentNo" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>总金额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="money"
												name="money" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>总应收：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="paymentAmount"
												name="paymentAmount" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>实际支付：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="actualPaymentAmount" name="actualPaymentAmount" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>支付时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payTimeStr"
												name="payTimeStr" value="<%=str_date1 %>" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">交易流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="payFlowNo"
												name="payFlowNo" value="1111" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">总折扣：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="totalDiscountAmount" name="totalDiscountAmount"
												value="0" />
										</div>
										&nbsp;
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label">找零：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="changeAmount"
												name="changeAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">折扣额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="tempDiscountAmount" name="tempDiscountAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">折让额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="zrAmount"
												name="zrAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">会员总折扣：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="memberDiscountAmount" name="memberDiscountAmount"
												value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">优惠折扣额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="promDiscountAmount" name="promDiscountAmount" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">收银损益：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="income"
												name="income" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">人民币</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="rmb" name="rmb"
												value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">电子返券</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="elecGet"
												name="elecGet" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">电子扣款</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="elecDeducation"
												name="elecDeducation" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">银行手续费</label>
										<div class="col-md-7">
											<input type="text" class="form-control"
												id="bankServiceCharge" name="bankServiceCharge" value="0" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th>一级支付介质</th>
													<th>二级支付介质</th>
													<th><font color="red">*</font>支付金额</th>
													<th><font color="red">*</font>实际抵扣金额</th>
													<th>汇率（折现率）</th>
													<th>支付账号</th>
													<th>会员id</th>
													<th>支付流水号</th>
													<th>优惠券类型</th>
													<th>优惠券批次</th>
													<th>券模板名称</th>
													<th>活动号</th>
													<th>收券规则</th>
													<th>收券规则描述</th>
													<th>备注</th>
													<th>结余</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="paymentClass" value="0016"></input>
													</td>
													<td><input name="paymentType" value="14114"></input>
													</td>
													<td><input name="amount"></input>
													</td>
													<td><input name="acturalAmount"></input>
													</td>
													<td><input name="rate" value="0"></input>
													</td>
													<td><input name="account" value="0001"></input>
													</td>
													<td><input name="userId" value="111"></input>
													</td>
													<td><input name="payFlowNo" value="0001"></input>
													</td>
													<td><input name="couponType" value="0001"></input>
													</td>
													<td><input name="couponBatch" value="0001"></input>
													</td>
													<td><input name="couponName" value="0001"></input>
													</td>
													<td><input name="activityNo" value="200"></input>
													</td>
													<td><input name="couponRule" value="0001"></input>
													</td>
													<td><input name="couponRuleName" value="desc"></input>
													</td>
													<td><input name="remark" value="无"></input>
													</td>
													<td><input name="cashBalance" value="0"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th>券编码</th>
													<th>券名称</th>
													<th>返利类型</th>
													<th>返利渠道</th>
													<th>返利日期</th>
													<th>值</th>
													<th>券批次</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="code" value="2001"></input>
													</td>
													<td><input name="name" value="2001"></input>
													</td>
													<td><input name="getType" value="2010"></input>
													</td>
													<td><input name="getChannel" value="01"></input>
													</td>
													<td><input name="getTimeStr"
														value="2015-02-15 00:00:00"></input>
													</td>
													<td><input name="amount1" value="0"></input>
													</td>
													<td><input name="couponBatch1" value="001"></input>
													</td>


													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="salePad1()" type="button" value="支付" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(14);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg14" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>PAD支付失败!</strong>
										</div>
										<span id="returnMsg14"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(14);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- PAD打印款机 -->
	<div class="modal modal-darkorange" id="btDiv15">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(15);">×</button>
					<h4 class="modal-title" id="divTitle15"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm15" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>开始时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="starttime"
												name="starttime" />
										</div>
									</div>

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>截止时间：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="endtime"
												name="endtime" />
										</div>
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>机器号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="posNo"
												name="posNo" />
										</div>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="printPay1()" type="button" value="打印" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(15);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg15" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>PAD打印失败!</strong>
										</div>
										<span id="returnMsg15"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(15);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 作废退货单 -->
	<div class="modal modal-darkorange" id="btDiv17">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(17);">×</button>
					<h4 class="modal-title" id="divTitle17"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm17" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>退货单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundNo"
												name="refundNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>操作人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="latestUpdateMan"
												name="latestUpdateMan" value="admin" />
										</div>
										&nbsp;
									</div>


									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="refundCancel1()" type="button" value="作废" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(17);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg17" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>作废退货单失败!</strong>
										</div>
										<span id="returnMsg17"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(17);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 作废销售单 -->
	<div class="modal modal-darkorange" id="btDiv16">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(16);">×</button>
					<h4 class="modal-title" id="divTitle16"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm16" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>销售单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="saleNo"
												name="saleNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>操作人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="latestUpdateMan"
												name="latestUpdateMan" value="admin" />
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="saleCancel1()" type="button" value="作废" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(16);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg16" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>作废销售单失败!</strong>
										</div>
										<span id="returnMsg16"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(16);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 包裹单状态 -->
	<div class="modal modal-darkorange" id="btDiv18">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(18);">×</button>
					<h4 class="modal-title" id="divTitle18"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm18" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">
									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>订单号</th>
													<th><font color="red">*</font>包裹单号</th>
													<th><font color="red">*</font>快递单号</th>
													<th><font color="red">*</font>包裹单状态</th>
													<th><font color="red">*</font>包裹单状态描述</th>
													<th>快递公司</th>
													<th>快递公司编号</th>
													<th>发货时间</th>
													<th>自提点编号</th>
													<th>自提点名称</th>
													<th>退货地址</th>
													<th>操作人</th>
													<th>备注</th>
													<th>系统来源</th>
													<th>是否出库</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="orderNo"></input>
													</td>
													<td><input name="packageNo"></input>
													</td>
													<td><input name="deliveryNo"></input>
													</td>
													<td><input name="packageStatus" value="6002"></input>
													</td>
													<td><input name="packageStatusDesc" value="出库"></input>
													</td>
													<td><input name="delComName"></input>
													</td>
													<td><input name="delComNo"></input>
													</td>
													<td><input name="sendTimeStr"></input>
													</td>
													<td><input name="extPlaceNo"></input>
													</td>
													<td><input name="extPlaceName"></input>
													</td>
													<td><input name="refundAddress"></input>
													</td>
													<td><input name="updateMan" value="admin"></input>
													</td>
													<td><input name="remark" value="0001"></input>
													</td>
													<td><input name="operatorSource" value="ERP"></input>
													</td>
													<td><input name="isOutbound" value="1"></input>
													</td>

													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="saveInvoice1()" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(18);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg18" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>保存失败!</strong>
										</div>
										<span id="returnMsg18"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(18);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 作废流水信息 -->
	<div class="modal modal-darkorange" id="btDiv19">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(19);">×</button>
					<h4 class="modal-title" id="divTitle19"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm19" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>款机流水号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="salesPaymentNo"
												name="salesPaymentNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>操作人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="casher"
												name="casher" value="admin" />
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="salePadCancel1()" type="button" value="作废" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(19);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg19" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>作废流水信息失败!</strong>
										</div>
										<span id="returnMsg19"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(19);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 创建换货单 -->
	<div class="modal modal-darkorange" id="btDiv20">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(20);">×</button>
					<h4 class="modal-title" id="divTitle20"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm20" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>会员编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="memberNo"
												name="memberNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>原销售单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="originalSaleNo"
												name="originalSaleNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>新销售单：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="saleNo"
												name="saleNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>退货单号号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundNo"
												name="refundNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>门店编号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="shopNo"
												name="shopNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>差额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="imbalance"
												name="imbalance" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>员工号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="employeeNo"
												name="employeeNo" value="zxl" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>机器号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="casherNo"
												name="casherNo" value="110" />
										</div>
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="foundExchange1()" type="button" value="创建" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(20);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg20" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>创建换货单失败!</strong>
										</div>
										<span id="returnMsg20"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(20);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 修改换货单 -->
	<div class="modal modal-darkorange" id="btDiv21">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(21);">×</button>
					<h4 class="modal-title" id="divTitle21"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm21" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>换货单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="exchangeNo"
												name="exchangeNo" />
										</div>
									</div>
									<div class="col-md-8">
										<div class="col-md-12">
											<input type="button" class="btn btn-azure"
												style="width: 25%;" onclick="getExchange(this)"
												value="获取换货单" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>原销售单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="originalSaleNo_h"
												name="originalSaleNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>新销售单：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="saleNo_h"
												name="saleNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>退货单号号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundNo_h"
												name="refundNo" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>差额：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="imbalance_h"
												name="imbalance" />
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>员工号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="employeeNo_h"
												name="employeeNo" />
										</div>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="updateExchange1()" type="button" value="修改" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(21);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg21" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>修改换货单失败!</strong>
										</div>
										<span id="returnMsg21"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(21);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 退货申请单审核 -->
	<div class="modal modal-darkorange" id="btDiv111">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(111);">×</button>
					<h4 class="modal-title" id="divTitle111"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm111" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>退货申请单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundApplyNo"
												name="refundApplyNo"/>
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save12"
												onclick="fundRefundApply()" type="button" value="查询" />&emsp;&emsp;
										</div>
										&nbsp;
									</div>
									<!-- 隐藏框 -->
									<div class="col-xs-12 col-md-12" id="hid">
										<div class="widget-body" id="pro102">
											<div
												style="width: 100%; height: 100px; overflow-x: hidden; word-break: break-all;"
												id="fundRefundInput"></div>
											
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<label class="col-lg-2 control-label">客服备注：</label>
										<div class="col-lg-7">
											<textarea style="width: 500px;height: 100px;" id="callCenterComments" name="callCenterComments" placeholder="非必填"></textarea>
										</div>
        							</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">审核人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="UpdateMan"
												name="UpdateMan" value="admin"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<div class="col-lg-5" style="text-align: right">
											<span>是否通过：</span>
										</div>
										<div class="col-lg-7">
											<select id="refundStatus" name="refundStatus" class="form-control"
												style="padding: 0 0; width: 100%;">
												<option value="2" selected="selected">不通过</option>
												<option value="4">通过</option>
											</select>
										</div>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="refundCheck()" type="button" value="审核" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(111);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg111" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>审核失败!</strong>
										</div>
										<span id="returnMsg111"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(111);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 退货申请单取消 -->
	<div class="modal modal-darkorange" id="btDiv102">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(102);">×</button>
					<h4 class="modal-title" id="divTitle102"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm102" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">
									<div class="col-md-4">
										<label class="col-md-5 control-label"><font
											color="red">*</font>退货申请单号：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="refundApplyNo"
												name="refundApplyNo"/>
										</div>
										&nbsp;
									</div>
									<div class="col-md-4">
										<label class="col-md-5 control-label">操作人：</label>
										<div class="col-md-7">
											<input type="text" class="form-control" id="lastUpdateMan"
												name="lastUpdateMan" value="admin"/>
										</div>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="refundApplyDis()" type="button" value="确定" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(102);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg102" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>取消失败!</strong>
										</div>
										<span id="returnMsg102"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(102);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 物流状态 -->
	<div class="modal modal-darkorange" id="btDiv22">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(22);">×</button>
					<h4 class="modal-title" id="divTitle22"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm22" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>订单号</th>
													<th><font color="red">*</font>包裹单号</th>
													<th><font color="red">*</font>快递单号</th>
													<th><font color="red">*</font>快递记录</th>
													<th>包裹状态</th>
													<th>包裹状态描述</th>
													<th>快递时间</th>
													<th>快递员</th>
													<th>快递员编号</th>
													<th>快递公司</th>
													<th>快递公司编号</th>
													<th>操作人</th>
													<th>备注</th>
													<th>系统来源</th>
													<th>是否签收</th>
													<th>是否拒收</th>
													<th>签收时间</th>
													<th>签收人</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="orderNo"></input>
													</td>
													<td><input name="packageNo"></input>
													</td>
													<td><input name="deliveryNo"></input>
													</td>
													<td><input name="deliveryRecord"></input>
													</td>
													<td><input name="packageStatus" value="6003"></input>
													</td>
													<td><input name="packageStatusDesc" value="签收"></input>
													</td>
													<td><input name="deliveryDateStr" value="<%=str_date1 %>"></input>
													</td>
													<td><input name="deliveryMan" value="0001"></input>
													</td>
													<td><input name="deliveryManNo" value="小强"></input>
													</td>
													<td><input name="delComName"></input>
													</td>
													<td><input name="delComNo"></input>
													</td>
													<td><input name="updateMan" value="admin"></input>
													</td>
													<td><input name="remark"></input>
													</td>
													<td><input name="operatorSource" value="ERP"></input>
													</td>
													<td><input name="isSign" value="1"></input>
													</td>
													<td><input name="isRefuseSign" value="0"></input>
													</td>
													<td><input name="signTimeStr" value="<%=str_date1 %>"></input>
													</td>
													<td><input name="signName" value="admin"></input>
													</td>

													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="invoiceCancel1()" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(22);" type="button" value="关闭" />
										</div>
									</div>
									<div id="errorMsg22" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>保存失败!</strong>
										</div>
										<span id="returnMsg22"></span>
									</div>
								</div>
							</div>
						</div>
						<div style="display: none;">
							<input id="articleCat" name="productPropValues" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(22);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 创建发票弹出框 -->
	<div class="modal modal-darkorange" id="btDiv38">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(38);">×</button>
					<h4 class="modal-title" id="divTitle38"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm38" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>销售单</th>
													<th><font color="red">*</font>发票编号</th>
													<th><font color="red">*</font>发票金额</th>
													<th><font color="red">*</font>发票抬头</th>
													<th><font color="red">*</font>发票明细</th>
													<th><font color="red">*</font>发票状态</th>
													<th><font color="red">*</font>开票人</th>
													<th><font color="red">*</font>开票日期</th>
													<th><font color="red">*</font>最后操作人</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="saleNo"></input>
													</td>
													<td><input name="invoiceNo" value="12345678"></input>
													</td>
													<td><input name="invoiceAmount" value="100"></input>
													</td>
													<td><input name="invoiceTitle" value="0001122"></input>
													</td>
													<td><input name="invoiceDetail" value="xx开的发票"></input>
													</td>
													<td><input name="invoiceStatus" value="12"></input>
													</td>
													<td><input name="createdMan" value="admin"></input>
													</td>
													<td><input name="createdTimeStr" value="<%=str_date1 %>"></input>
													</td>
													<td><input name="latestUpdateMan" value="admin"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="createInvoice1()" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(38);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg38" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>创建失败!</strong>
										</div>
										<span id="returnMsg38"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(38);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 仓内打印弹出框 -->
	<div class="modal modal-darkorange" id="btDiv28">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(28);">×</button>
					<h4 class="modal-title" id="divTitle28"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm28" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>订单号</th>
													<th><font color="red">*</font>销售单</th>
													<th><font color="red">*</font>销售单状态编码</th>
													<th><font color="red">*</font>销售单状态描述</th>
													<th><font color="red">*</font>受理人</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="orderNo"></input>
													</td>
													<td><input name="saleNo"></input>
													</td>
													<td><input name="saleStatus" value="03" readonly="readonly"></input>
													</td>
													<td><input name="saleStatusDesc" value="已打印" readonly="readonly"></input>
													</td>
													<td><input name="latestUpdateMan" value="admin"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="updateSaleStatus1()" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(28);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg28" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>修改失败!</strong>
										</div>
										<span id="returnMsg28"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(28);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 仓内复核弹出框 -->
	<div class="modal modal-darkorange" id="btDiv281">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(281);">×</button>
					<h4 class="modal-title" id="divTitle281"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm281" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>订单号</th>
													<th><font color="red">*</font>销售单</th>
													<th><font color="red">*</font>销售单状态编码</th>
													<th><font color="red">*</font>销售单状态描述</th>
													<th><font color="red">*</font>受理人</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="orderNo"></input>
													</td>
													<td><input name="saleNo"></input>
													</td>
													<td><input name="saleStatus" value="05" readonly="readonly"></input>
													</td>
													<td><input name="saleStatusDesc" value="已复核" readonly="readonly"></input>
													</td>
													<td><input name="latestUpdateMan" value="admin"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="updateSaleStatusd1()" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(281);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg28" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>修改失败!</strong>
										</div>
										<span id="returnMsg281"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(281);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 仓内打包弹出框 -->
	<div class="modal modal-darkorange" id="btDiv282">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(282);">×</button>
					<h4 class="modal-title" id="divTitle282"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm282" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>订单号</th>
													<th><font color="red">*</font>销售单</th>
													<th><font color="red">*</font>销售单状态编码</th>
													<th><font color="red">*</font>销售单状态描述</th>
													<th><font color="red">*</font>受理人</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="orderNo"></input>
													</td>
													<td><input name="saleNo"></input>
													</td>
													<td><input name="saleStatus" value="06" readonly="readonly"></input>
													</td>
													<td><input name="saleStatusDesc" value="已打包" readonly="readonly"></input>
													</td>
													<td><input name="latestUpdateMan" value="admin"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="updateSaleStatuse1()" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(282);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg282" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>修改失败!</strong>
										</div>
										<span id="returnMsg282"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(282);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 仓内出库弹出框 -->
	<div class="modal modal-darkorange" id="btDiv283">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(283);">×</button>
					<h4 class="modal-title" id="divTitle283"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm283" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>订单号</th>
													<th><font color="red">*</font>销售单</th>
													<th><font color="red">*</font>销售单状态编码</th>
													<th><font color="red">*</font>销售单状态描述</th>
													<th><font color="red">*</font>受理人</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="orderNo"></input>
													</td>
													<td><input name="saleNo"></input>
													</td>
													<td><input name="saleStatus" value="07" readonly="readonly"></input>
													</td>
													<td><input name="saleStatusDesc" value="已出库" readonly="readonly"></input>
													</td>
													<td><input name="latestUpdateMan" value="admin"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="updateSaleStatusr1()" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(283);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg283" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>修改失败!</strong>
										</div>
										<span id="returnMsg283"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(283);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	<!-- 修改退货单状态弹出框 -->
	<div class="modal modal-darkorange" id="btDiv29">
		<div class="modal-dialog"
			style="width: 1200px; height: 500px; margin: 3% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeBtDiv(29);">×</button>
					<h4 class="modal-title" id="divTitle29"></h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<form id="theForm29" method="post" class="form-horizontal">
						<div class="tabbable">
							<div class="tab-content">
								<div id="home" class="tab-pane in active"
									style="height: 400px; overflow: scroll;">

									<div class="col-md-12">
										<table>
											<thead>
												<tr>
													<th><font color="red">*</font>退货单号</th>
													<th><font color="red">*</font>退货单状态编码</th>
													<th><font color="red">*</font>退货单状态描述</th>
													<th><font color="red">*</font>受理人</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input name="refundNo"></input>
													</td>
													<td><input name="refundStatus" value="15"></input>
													</td>
													<td><input name="refundStatusDesc" value="已完结"></input>
													</td>
													<td><input name="latestUpdateMan" value="admin"></input>
													</td>
													<td align="center" onclick="copyTr(this)" style="vertical-align:middle;">
															<span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span>
															</td>
												</tr>
											</tbody>
										</table>
										&nbsp;
									</div>

									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												onclick="updateRefundStatus1()" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close"
												onclick="closeBtDiv(29);" type="button" value="关闭" />
										</div>
										&nbsp;
									</div>
									<div id="errorMsg29" style="display: none">
										<div class='alert alert-warning fade in'>
											<i class='fa-fw fa fa-times'></i><strong>修改失败!</strong>
										</div>
										<span id="returnMsg29"></span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default"
						onclick="closeBtDiv(29);" type="button">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

</body>
</html>