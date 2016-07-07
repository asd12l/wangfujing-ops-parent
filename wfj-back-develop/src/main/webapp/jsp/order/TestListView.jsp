<!DOCTYPE html>
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
	
	//创建销售单
	function foundSale(){
		$("#divTitle1").html("销售下单");
		$("#found_sale").html("");
		$("#found_sale1").html("");
		$("#btDiv1").show();
   	}
	
	
	function foundSale1(){
		var saleData = $("#theForm1").serialize();
		$("#found_sale").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/foundSale";
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
	
	//打印销售单
	function printSale(){
		$("#divTitle2").html("打印销售单");
		$("#print_sale").html("");
		$("#print_sale1").html("");
		$("#btDiv2").show();
   	}
	
	function printSale1(){
		var saleData = $("#theForm2").serialize();
		$("#print_sale").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/printSale";
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
	
	
	//销售单支付
	function salePos(){
		$("#divTitle3").html("销售单支付");
		$("#sale_pos").html("");
		$("#sale_pos1").html("");
		$("#btDiv3").show();
   	}
	function changeAmoun(obj){
		var paymentAmountp = $("#paymentAmountp").val();
		var actualPaymentAmountp = $(obj).val();
		$("#changeAmountp").val(actualPaymentAmountp-paymentAmountp);
	}
	function salePos1(){
		var saleData = $("#theForm3").serialize();
		$("#sale_pos").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/salePos";
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
	
	//销售单全脱机支付
	function salePay(){
		$("#divTitle10").html("销售单全脱机支付");
		$("#sale_pos").html("");
		$("#sale_pos1").html("");
		$("#btDiv10").show();
   	}
	function changeAmoun2(obj){
		var paymentAmountp2 = $("#paymentAmountp2").val();
		var actualPaymentAmountp2 = $(obj).val();
		$("#changeAmountp2").val(actualPaymentAmountp2-paymentAmountp2);
	}
	function salePay1(){
		var saleData = $("#theForm10").serialize();
		$("#sale_pos").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/salePay";
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
	
	//创建发票
	function saveInvoice(){
		$("#divTitle18").html("创建发票");
		$("#sale_pos").html("");
		$("#sale_pos1").html("");
		$("#btDiv18").show();
   	}
	
	function saveInvoice1(){
		var saleData = $("#theForm18").serialize();
		$("#sale_pos").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/saveInvoice";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(18);
					$("#sale_pos1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg18").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg18").attr({"style":"display:block;","aria-hidden":"false"});
				}
				return;
			}
		});
	}
	
	//发票作废
	function invoiceCancel(){
		$("#divTitle22").html("发票作废");
		$("#sale_pos").html("");
		$("#sale_pos1").html("");
		$("#btDiv22").show();
   	}
	
	function invoiceCancel1(){
		var saleData = $("#theForm22").serialize();
		$("#sale_pos").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/invoiceCancel";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(22);
					$("#sale_pos1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg22").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg22").attr({"style":"display:block;","aria-hidden":"false"});
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
	
	
	
	//创建退货单
	function foundRefund(){
		$("#divTitle5").html("创建退货单");
		$("#found_refund").html("");
		$("#found_refund1").html("");
		$("#btDiv5").show();
   	}
	
	function foundRefund1(){
		var saleData = $("#theForm5").serialize();
		$("#found_refund").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/foundRefund";
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
		$("#refund_pos").html("");
		$("#refund_pos1").html("");
		$("#btDiv8").show();
   	}
	function changeAmoun3(obj){
		var paymentAmountp3 = $("#paymentAmountp3").val();
		var actualPaymentAmountp3 = $(obj).val();
		$("#changeAmountp3").val(actualPaymentAmountp3-paymentAmountp3);
	}
	function refundPos1(){
		var saleData = $("#theForm8").serialize();
		$("#refund_pos").html("输入参数："+saleData);
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
					$("#refund_pos1").html("输出参数："+JSON.stringify(response));
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
	
	//移库
	function foundYiku(){
		$("#divTitle33").html("移库");
		$("#yiku_stock").html("");
		$("#yiku_stock1").html("");
		$("#btDiv33").show();
   	}
	
	function foundYiku1(){
		var saleData = $("#theForm33").serialize();
		$("#yiku").html("输入参数："+saleData);
		var url = __ctxPath + "/testOms/saveStockWei";
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			data: saleData,
			success: function(response) {
				if(response.success=='true'){
					closeBtDiv(33);
					$("#yiku1").html("输出参数："+JSON.stringify(response));
				}else{
					$("#returnMsg33").html("输出参数："+JSON.stringify(response));
 	     	  		$("#errorMsg33").attr({"style":"display:block;","aria-hidden":"false"});
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
	function getSum(obj){
		var trProduct = $(obj).parent().parent();
		var salePrice = trProduct.find("[name='salePrice']").val();
		var saleSum = trProduct.find("[name='saleSum']").val();
		var saleAmount = $("#saleAmount").val();
		$("#saleAmount").val(saleAmount*1+salePrice*saleSum);
	}
	function getProduct(obj){
		var trProduct = $(obj).parent().parent();
		var productNo = trProduct.find("[name='supplyProductNo']").val();
		var erpProductNo = trProduct.find("[name='erpProductNo']").val();
		var url = __ctxPath + "/testOms/selectProduct";
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			dataType:"json",
			url: url,
			async:false,
			data: {"supplyProductNo":productNo,
				"erpProductNo":erpProductNo},
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
                                    <h5 class="widget-caption">测试</h5>
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
                                    	<div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="foundSale();" class="btn btn-yellow" style="width: 100%;">
	                                    		<i class="fa fa-shopping-cart"></i>
												创建销售单
	                                        </a>&nbsp;
                                        </div>
                      					<div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="found_sale">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="found_sale1">
			                					</div>
		                					</div>&nbsp;
              							</div>
                                        <div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="printSale();" class="btn btn-azure" style="width: 100%;">
	                                    		<i class="fa fa-fire"></i>
												打印销售单
	                                        </a>&nbsp;
                                        </div>
                                        <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="print_sale">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="print_sale1">
			                					</div>
		                					</div>&nbsp;
              							</div>
                                        <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="salePos();" class="btn btn-primary" style="width: 100%;">
	                                        	<i class="fa fa-chevron-up"></i>
												销售单支付
	                                        </a>
	                                    </div>
	                                    <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="salePay();" class="btn label-azure" style="width: 100%;">
	                                        	<i class="fa fa-tasks"></i>
												销售单全脱机支付
	                                        </a>&nbsp;
	                                    </div>
	                                     <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="saveInvoice();" class="btn btn-maroon" style="width: 100%;">
	                                        	<i class="fa fa-calendar"></i>
												创建发票
	                                        </a>&nbsp;
	                                    </div>
	                                    <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="invoiceCancel();" class="btn btn-sky" style="width: 100%;">
	                                        	<i class="fa fa-eye-slash"></i>
												发票作废
	                                        </a>&nbsp;
	                                    </div>
	                                    <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="sale_pos">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="sale_pos1">
			                					</div>
		                					</div>&nbsp;
              							</div>
              							<div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="salePadCreat();" class="btn btn-yellow" style="width: 100%;">
	                                        	<i class="fa fa-hand-o-right"></i>
												PAD创建
	                                        </a>
	                                    </div>
	                                    <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="salePadCancel();" class="btn btn-palegreen" style="width: 100%;">
	                                        	<i class="fa fa-warning"></i>
												流水作废
	                                        </a>
	                                    </div>
	                                    <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="salePadAdd();" class="btn btn-darkorange" style="width: 100%;">
	                                        	<i class="fa fa-briefcase"></i>
												PAD添加销售单
	                                        </a>
	                                    </div>
	                                    <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="salePadCancle();" class="btn btn-purple" style="width: 100%;">
	                                        	<i class="fa fa-cut"></i>
												PAD取消
	                                        </a>
	                                    </div>
	                                    <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="salePad();" class="btn btn-magenta" style="width: 100%;">
	                                        	<i class="fa fa-cloud"></i>
												PAD支付
	                                        </a>&nbsp;
	                                    </div>
	                                    <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="sale_pad">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="sale_pad1">
			                					</div>
		                					</div>&nbsp;
              							</div>
              							<div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="printPay();" class="btn label-azure" style="width: 100%;">
	                                        	<i class="fa fa-certificate"></i>
												PAD打印款机
	                                        </a>&nbsp;
	                                    </div>
	                                    <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="print_pay"></div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="print_pay1"></div>
		                					</div>&nbsp;
              							</div>
                                        <div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="takeStock();" class="btn btn-palegreen" style="width: 100%;">
	                                    		<i class="fa fa-gift"></i>
												顾客确认提货
	                                        </a>&nbsp;
                                        </div>
                                        <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="take_stock">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="take_stock1">
			                					</div>
		                					</div>&nbsp;
              							</div>
                                        <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="foundRefund();" class="btn btn-darkorange" style="width: 100%;">
	                                        	<i class="fa fa-random"></i>
												创建退货单
	                                        </a>&nbsp;
	                                    </div>
	                                    <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="found_refund">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="found_refund1">
			                					</div>
		                					</div>&nbsp;
              							</div>
	                                    <div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="printRefund();" class="btn btn-magenta" style="width: 100%;">
	                                    		<i class="fa fa-list-ul"></i>
												打印退货单
	                                        </a>&nbsp;
                                        </div>
                                        <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="print_refund">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="print_refund1">
			                					</div>
		                					</div>&nbsp;
              							</div>
                                        <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="examineRefund();" class="btn btn-purple" style="width: 100%;">
	                                        	<i class="fa fa-legal"></i>
												退货单审核
	                                        </a>&nbsp;
	                                    </div>
	                                    <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="examine_refund">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="examine_refund1">
			                					</div>
		                					</div>&nbsp;
              							</div>
                                        <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="refundPos();" class="btn btn-maroon" style="width: 100%;">
	                                        	<i class="fa fa-chevron-down"></i>
												退货单退款
	                                        </a>&nbsp;
	                                    </div>
	                                    <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="refund_pos">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="refund_pos1">
			                					</div>
		                					</div>&nbsp;
              							</div>
                                         <div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="returnStock();" class="btn label-azure" style="width: 100%;">
	                                    		<i class="fa fa-plane"></i>
												导购确认还库
	                                        </a>&nbsp;
                                        </div>
                                        <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="return_stock">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="return_stock1">
			                					</div>
		                					</div>&nbsp;
              							</div>
              							
              							<div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="saleCancel();" class="btn btn-primary" style="width: 100%;">
	                                    		<i class="fa fa-strikethrough"></i>
												销售单作废
	                                        </a>&nbsp;
                                        </div>
                                        
                                        <div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="refundCancel();" class="btn btn-palegreen" style="width: 100%;">
	                                    		<i class="fa fa-navicon"></i>
												退货单作废
	                                        </a>&nbsp;
                                        </div>
                                        <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="bills_cancel">
			                					</div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="bills_cancel1">
			                					</div>
		                					</div>&nbsp;
              							</div>
              							<div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="foundExchange();" class="btn btn-yellow" style="width: 100%;">
	                                    		<i class="fa fa-retweet"></i>
												创建换货单
	                                        </a>&nbsp;
                                        </div>
                                        <div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="updateExchange();" class="btn btn-darkorange" style="width: 100%;">
	                                    		<i class="fa fa-key"></i>
												修改换货单
	                                        </a>&nbsp;
                                        </div>
                                        <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="exchange"></div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="exchange1"></div>
		                					</div>&nbsp;
              							</div>
              							<div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="foundYiku();" class="btn btn-yellow" style="width: 100%;">
	                                    		<i class="fa fa-retweet"></i>
												移库
	                                        </a>&nbsp;
                                        </div>
                                        <div class="col-xs-12 col-md-12">
		                					<div class="widget-body" id="pro1">
			               						<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="yiku"></div>
			                					<div style="width:100%;height:100px;overflow-x: hidden;word-break:break-all;" id="yiku1"></div>
		                					</div>&nbsp;
              							</div>
                                	<div style="width:100%; height:0%; overflow-Y:hidden;">
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
    <div class="modal modal-darkorange" id="btDiv1">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(1);">×</button>
                    <h4 class="modal-title" id="divTitle1"></h4>
                </div>
                <div class="" id="pageBodyRight">
                 	<form id="theForm1" method="post" class="form-horizontal" >
									<div class="mtb10 tabbable">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
		                                		<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>开单机器号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="casherNo" name="casherNo"  />
													</div>&nbsp;
												</div>
												<div class="col-md-4">
													<label class="col-md-5 control-label">门店名称：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="storeName_s" name="storeName" readonly="readonly"/>
													</div>&nbsp;
												</div>
												<div class="col-md-4">
			                                		<label class="col-md-5 control-label">销售单类型：</label>
		                                			<div class="col-lg-7">
				                                		<select id="saleType" name="saleType" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="1" selected="selected">正常销售单</option>
				                                			<option value="2" >大码销售单</option>
				                                		</select>
			                                		</div>&nbsp;
                                				</div>
												
												
												<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label">门店号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="shopNo_s" name="shopNo" readonly="readonly" />
													</div>&nbsp;
												</div>
												
												<div class="col-md-4">
													<label class="col-md-5 control-label">专柜编号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="shoppeNo_s" name="shoppeNo" readonly="readonly"/>
													</div>&nbsp;
												</div>
												<div class="col-md-4">
													<label class="col-md-5 control-label">专柜名称：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="shoppeName_s" name="shoppeName" readonly="readonly"/>
													</div>&nbsp;
												</div>
                                            	<div class="col-md-4">
													<label class="col-md-5 control-label">账号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="accountNo" name="accountNo" value="1767368" />
													</div>&nbsp;
												</div>
		                                		<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label">导购号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="employeeNo" name="employeeNo" value="101101" />
													</div>&nbsp;
												</div>
												<div class="col-md-4">
													<label class="col-md-5 control-label">供应商编号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="supplyNo_s" name="supplyNo" readonly="readonly"/>
													</div>&nbsp;
												</div>
		                                		<div class="col-md-4" >
													<label class="col-md-5 control-label">供应商名称：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="suppllyName_s" name="suppllyName" readonly="readonly"/>
													</div>&nbsp;
												</div>
												<div class="col-md-4">
													<label class="col-md-5 control-label">会员号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="memberNo" name="memberNo" value="9900000000812" />
													</div>&nbsp;
												</div>
		                                		<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label">发票金额：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="invoiceAmount" name="invoiceAmount" />
													</div>&nbsp;
												</div>
												
												<div class="col-md-4">
			                                		<label class="col-md-5 control-label">是否使用授权卡：</label>
		                                			<div class="col-lg-7">
				                                		<select id="authorized" name="authorized" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="0" >否</option>
				                                			<option value="1" selected="selected">是</option>
				                                		</select>
			                                		</div>&nbsp;
                                				</div>
		                                		<div class="col-md-4">
													<label class="col-md-5 control-label">授权卡号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="authorityCard" name="authorityCard" value="87656838" />
													</div>&nbsp;
												</div>
												<div class="col-md-4" style="display:none;">
			                                		<label class="col-md-5 control-label">收银损益标志：</label>
		                                			<div class="col-lg-7">
				                                		<select id="cashIncomeFlag" name="cashIncomeFlag" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="0" >损益在运费</option>
				                                			<option value="1" selected="selected">损益在商品</option>
				                                		</select>
			                                		</div>&nbsp;
                                				</div>
												<div class="col-md-4" style="display:none;">
			                                		<label class="col-md-5 control-label">是否开发票：</label>
		                                			<div class="col-lg-7">
				                                		<select id="needInvoice" name="needInvoice" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="0" selected="selected">否</option>
				                                			<option value="1">是</option>
				                                		</select>
			                                		</div>&nbsp;
                                				</div>
		                                		<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label">发票抬头：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="invoiceTitle" name="invoiceTitle" />
													</div>&nbsp;
												</div>
		                                		
		                                		
		                                		
												<div class="col-md-4">
													<label class="col-md-5 control-label">销售单金额：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="saleAmount" name="saleAmount" value="0" />
													</div>&nbsp;
												</div>
												<div class="col-md-4" style="display:none;">
			                                		<label class="col-md-5 control-label">销售单类别：</label>
		                                			<div class="col-lg-7">
				                                		<select id="saleClass" name="saleClass" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="1" selected="selected">销售单</option>
				                                			<option value="2">换货换出单</option>
				                                		</select>
			                                		</div>&nbsp;
                                				</div>
		                                		<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label">二维码：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="qrcode" name="qrcode" value="s3d4f5g6" />
													</div>&nbsp;
												</div>
												<div class="col-md-12">
													<table style="width: 50px;">
														<thead>
															<tr>
																<th>操作</th>
																<th><font color="red">*</font>专柜商品编号</th>
																<th><font color="red">*</font>ERP商品编号</th>
																<th><font color="red">*</font>销售数量</th>
																<th><font color="red">*</font>应付金额</th>
																<th>商品名称</th>
																<th>标准价</th>
																<th>销售价</th>
																<th style="display:none;">sku编号</th>
																<th style="display:none;">spu编号</th>
																<th style="display:none;">供应商内部商品编码</th>
																<th>商品单位</th>
																<th>品牌名称</th>
																<th style="display:none;">条形码</th>
																<th style="display:none;">颜色编号</th>
																<th style="display:none;">颜色名称</th>
																<th style="display:none;">规格编号</th>
																<th style="display:none;">规格名称</th>
																<th style="display:none;">管理分类编号</th>
																<th style="display:none;">品牌编码</th>
																<th style="display:none;">统计分类</th>
																<th style="display:none;">是否为赠品</th>
																<th style="display:none;">收银损益标志</th>
																<th style="display:none;">大中小类</th>
																<th style="display:none;">商品类别</th>
																<th style="display:none;">收银损益</th>
																<th style="display:none;">销项税</th>
															</tr>
														</thead>
														<tbody>
														  <tr>
														  	<td><input type="button" onclick="getProduct(this)" value="获取商品"/></td>
														  	<td><input name="supplyProductNo"></input></td>
															<td><input name="erpProductNo"></input></td>
															<td><input name="saleSum" onchange="getSum(this)"></input></td>
															<td><input name="paymentAmount" ></input></td>
															<td><input name="shoppeProName" readonly="readonly"></input></td>
														  	<td><input name="standPrice" ></input></td>
															<td><input name="salePrice" ></input></td>
															<td style="display:none;"><input name="skuNo" readonly="readonly"></input></td>
															<td style="display:none;"><input name="spuNo" readonly="readonly"></input></td>
															<td style="display:none;"><input name="supplyInnerProdNo" readonly="readonly"></input></td>
															<td><input name="unit" readonly="readonly"></input></td>
															<td><input name="brandName" readonly="readonly"></input></td>
															<td style="display:none;"><input name="barcode" readonly="readonly"></input></td>
															<td style="display:none;"><input name="colorNo" readonly="readonly"></input></td>
															<td style="display:none;"><input name="colorName" readonly="readonly"></input></td>
															<td style="display:none;"><input name="sizeNo" readonly="readonly"></input></td>
															<td style="display:none;"><input name="sizeName" readonly="readonly"></input></td>
															<td style="display:none;"><input name="managerCateNo" readonly="readonly"></input></td>
															<td style="display:none;"><input name="brandNo" readonly="readonly"></input></td>
															<td style="display:none;"><input name="statisticsCateNo" readonly="readonly"></input></td>
															<td style="display:none;"><input name="isGift" value="0"></input></td>
															<td style="display:none;"><input name="cashIncomeFlag1" value="1"></input></td>
															<td style="display:none;"><input name="productClass" readonly="readonly"></input></td>
															<td style="display:none;"><input name="productType" readonly="readonly"></input></td>
															<td style="display:none;"><input name="incomeAmount" value="0.00"></input></td>
															<td style="display:none;"><input name="tax" readonly="readonly"></input></td>
															<td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
														  </tr>
														</tbody>
													</table>&nbsp;
												</div>
												<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>销售单应付金额：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="paymentAmount1" name="paymentAmount1" />
													</div>&nbsp;
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="foundSale1()" type="button" value="下单" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(1);" type="button" value="关闭" />
													</div>&nbsp;
												</div>
												<div id="errorMsg1" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>下单失败!</strong></div>
													<span id="returnMsg1"></span>
												</div>
                                            </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(1);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
    
    <!-- 打印销售单弹框 -->
     <div class="modal modal-darkorange" id="btDiv2">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(2);">×</button>
                    <h4 class="modal-title" id="divTitle2"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm2" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>销售单号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="saleNo" name="saleNo"  />
													</div>&nbsp;
												</div>
		                                		<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>操作人编码：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="operator" name="operator" value="admin" />
													</div>&nbsp;
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="printSale1()" type="button" value="打印" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(2);" type="button" value="关闭" />
													</div>&nbsp;
												</div>
												<div id="errorMsg2" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>打印失败!</strong></div>
													<span id="returnMsg2"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(2);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
    <!-- 支付销售单弹框 -->
     <div class="modal modal-darkorange" id="btDiv3">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(3);">×</button>
                    <h4 class="modal-title" id="divTitle3"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm3" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	 <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>款机流水号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="salesPaymentNo" name="salesPaymentNo" />
							                        </div>
							                        &nbsp; </div>
							                       
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>总金额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="money" name="money"   />
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>总应收：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="paymentAmountp" name="paymentAmount" />
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>实际支付：</label>
							                        <div class="col-md-7">
							                          <input class="form-control" onchange="changeAmoun(this)" id="actualPaymentAmountp" name="actualPaymentAmount"  />
							                        </div>
							                        &nbsp; </div>
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>机器号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="posNo" name="posNo"  value="9999"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>门店号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="shopNo" name="shopNo"   value="8888"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>门店名称：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="shopName" name="shopName"  value="王府井店"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>支付时间：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="payTimeStr" name="payTimeStr"  value="<%=str_date1 %>" />
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">交易流水号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="payFlowNo" name="payFlowNo"  value="1111"/>
							                        </div>
							                        &nbsp; </div>
							                       	<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>收银员号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="casher" name="casher"  value="1234"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>渠道标志（M）：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="channel" name="channel"  value="1"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>会员卡号</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="memberNo" name="memberNo"  value="111"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">授权卡号</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="authorizationNo" name="authorizationNo"  />
							                        </div>
							                        &nbsp; </div>
							                       	<div class="col-md-4">
		                                    		<div class="col-lg-5" style="text-align: right">
			                                			<span>线上线下标识：</span>
			                                		</div>
		                                			<div class="col-lg-7">
				                                		<select id="ooFlag" name="ooFlag" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="1" >线上</option>
				                                			<option value="2" selected="selected">线下</option>
				                                		</select>
			                                		</div>&nbsp;
                                					</div>
							                      
							                        <div class="col-md-4">
		                                    		<div class="col-lg-5" style="text-align: right">
			                                			<span>水单类型:</span>
			                                		</div>
		                                			<div class="col-lg-7">
				                                		<select id="isRefund" name="isRefund" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="0" selected="selected">支付</option>
				                                			<option value="1" >退款</option>
				                                		</select>
			                                		</div>&nbsp;
                                					</div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">总折扣：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="totalDiscountAmount" name="totalDiscountAmount"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">找零：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="changeAmountp" name="changeAmount"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">折扣额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="tempDiscountAmount" name="tempDiscountAmount"   value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">折让额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="zrAmount" name="zrAmount"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">会员总折扣：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="memberDiscountAmount" name="memberDiscountAmount"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">优惠折扣额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="promDiscountAmount" name="promDiscountAmount"   value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">收银损益：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="income" name="income"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
		                                    		<div class="col-lg-5" style="text-align: right">
			                                			<span>班次：</span>
			                                		</div>
		                                			<div class="col-lg-7">
				                                		<select id="shifts" name="shifts" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="0" >早班</option>
				                                			<option value="1" selected="selected">中班</option>
				                                			<option value="2" >晚班</option>
				                                		</select>
			                                		</div>&nbsp;
                                					</div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">微信卡类型：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="weixinCard" name="weixinCard"  value="001"/>
							                        </div>
							                         &nbsp; </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">微信卡门店号</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="weixinStoreNo" name="weixinStoreNo"  value="00001"/>
							                        </div>
							                        &nbsp; </div>
							                         
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label">线上订单号</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="orderNo" name="orderNo"  />
							                        </div>
							                        &nbsp; </div>
							                        
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">人民币</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="rmb" name="rmb"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">电子返券</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="elecGet" name="elecGet"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">电子扣款</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="elecDeducation" name="elecDeducation"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">银行手续费</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="bankServiceCharge" name="bankServiceCharge"  value="0"/>
							                        </div>
							                        &nbsp; </div>  <div class="col-md-4">
							                        <label class="col-md-5 control-label">来源</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="sourceType" name="sourceType"  />
							                        </div>
							                        &nbsp; </div>
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
							                            <td><input name="paymentClass"  value="0016"></input></td>
							                               <td><input name="paymentType"  value="000161"></input></td>
							                               <td><input name="amount" ></input></td>
							                               <td><input name="acturalAmount" ></input></td>
							                               <td><input name="rate" value="0"></input></td>
							                               <td><input name="account" value="0001"></input></td>
							                               <td><input name="userId" value="111"></input></td>
							                               <td><input name="payFlowNo" value="0001"></input></td>
							                               <td><input name="couponType" value="0001"></input></td>
							                               <td><input name="couponBatch" value="0001"></input></td>
							                               <td><input name="couponName" value="0001"></input></td>
							                               <td><input name="activityNo" value="200"></input></td>
							                               <td><input name="couponRule" value="0001"></input></td>
							                               <td><input name="couponRuleName" value="desc"></input></td>
							                               <td><input name="remark" value="无"></input></td>
							                               <td><input name="cashBalance" value="0"></input></td>
							                              
							                           
							                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
							                          </tr>
							                        </tbody>
							                      </table>&nbsp;
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
							                            <td><input name="saleNo1" ></input></td>                          
							                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
							                          </tr>
							                        </tbody>
							                      </table>&nbsp;
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
					                            <td><input name="code"  value="2001"></input></td>
					                               <td><input name="name" value="2001"></input></td>
					                               <td><input name="getType" value="2010"></input></td>
					                               <td><input name="getChannel" value="01"></input></td>
					                               <td><input name="getTimeStr" value="2015-02-15 00:00:00"></input></td>
					                               <td><input name="amount1" value="0"></input></td>
					                               <td><input name="couponBatch1" value="001"></input></td>
                             
                             
						                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
						                          </tr>
						                        </tbody>
						                      </table>&nbsp;
												</div>
												<div class="col-md-12">
													<table>
							                        <thead>
							                          <tr>
							                            <th>行号</th>
							                            <th><font color="red">*</font>销售单号</th>
							                            <th><font color="red">*</font>销售总价</th>
							                            <th><font color="red">*</font>商品行项目编号</th>
							                             <th><font color="red">*</font>销售数量</th>
							                            <th>专柜商品编码</th>
							                            <th>大码</th>
							                             <th>促销</th>
							                          </tr>
							                        </thead>
							                        <tbody>
							                          <tr>
							                            <td><input name="rowNo"></input></td>
							                                <td><input name="saleNo"></input></td>
							                               <td><input name="paymentAmount1" ></input></td>
							                               <td><input name="salesItemId"></input></td>
							                               <td><input name="saleSum" ></input></td>
							                               <td><input name="supplyProductNo"></input></td>
							                               <td><input name="erpProductNo" ></input></td>
							                              <td><input name="promotionSplits" value="[{'freightAmount':5,'promotionAmount':11,'promotionCode':'3768333','promotionDesc':'满200减30','promotionName':'满额优惠','promotionRule':'2344','promotionRuleName':'待定','promotionType':'优惠','splitRate':1}]"></input></td>
							                          
							                             
							                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
							                          </tr>
							                        </tbody>
							                      </table>&nbsp;
												</div>
												
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="salePos1()" type="button" value="支付" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(3);" type="button" value="关闭" />
													</div>&nbsp;
												</div>
												<div id="errorMsg3" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>支付失败!</strong></div>
													<span id="returnMsg3"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(3);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
    <!-- 顾客提货弹框 -->
     <div class="modal modal-darkorange" id="btDiv4">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(4);">×</button>
                    <h4 class="modal-title" id="divTitle4"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm4" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>销售单号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="saleNo" name="saleNo"  />
													</div>&nbsp;
												</div>
		                                		<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>操作人编码：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="operator" name="operator" value="admin" />
													</div>&nbsp;
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="takeStock1()" type="button" value="提货" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(4);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg4" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>提货失败!</strong></div>
													<span id="returnMsg4"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(4);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
    
    <!-- 创建退货单弹框 -->
     <div class="modal modal-darkorange" id="btDiv5">
        <div class="modal-dialog" style="width: 1200px;height:80%;margin: 160px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(5);">×</button>
                    <h4 class="modal-title" id="divTitle5"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm5" method="post" class="form-horizontal">
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active">
                                            	
                                            	<div class="col-md-4">
													<label class="col-md-4 control-label"><font color="red">*</font>原销售单号：</label>
													<div class="col-md-8">
														<input type="text" class="form-control" id="originalSalesNo" name="originalSalesNo"  />
													</div>&nbsp;
												</div>
												<div class="col-md-4">
													<label class="col-md-4 control-label"><font color="red">*</font>受理门店号：</label>
													<div class="col-md-8">
														<input type="text" class="form-control" id="operatorStore" name="operatorStore" />
													</div>&nbsp;
												</div>
												<div class="col-md-4">
													<label class="col-md-4 control-label"><font color="red">*</font>机器号：</label>
													<div class="col-md-8">
														<input type="text" class="form-control" id="casherNo" name="casherNo" />
													</div>&nbsp;
												</div>
												<div class="col-md-4">
													<label class="col-md-4 control-label"><font color="red">*</font>退货总数：</label>
													<div class="col-md-8">
														<input type="text" class="form-control" id="refundNum1" name="refundNum1"/>
													</div>&nbsp;
												</div>
												<div class="col-md-4">
		                                    		<div class="col-lg-4" style="text-align: right">
			                                			<span>退货类别：</span>
			                                		</div>
		                                			<div class="col-lg-8">
				                                		<select id="refundClass" name="refundClass" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="THD" selected="selected">退货单</option>
				                                			<option value="HHHR">换货换入单</option>
				                                		</select>
			                                		</div>&nbsp;
                                				</div>
												<div class="col-md-4">
													<label class="col-md-4 control-label"><font color="red">*</font>导购号：</label>
													<div class="col-md-8">
														<input type="text" class="form-control" id="employeeNo" name="employeeNo" value="110"/>
													</div>&nbsp;
												</div>
												
												<div class="col-md-12">
													<table>
														<thead>
															<tr>
																<th><font color="red">*</font>退货数量</th>
																<th><font color="red">*</font>销售单详情号</th>
																<th>操作</th>
															</tr>
														</thead>
														<tbody>
														  <tr>
															<td><input name="refundNum"></input></td>
															<td><input name="saleItemNo"></input></td>
															<td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
														  </tr>
														</tbody>
													</table>&nbsp;
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="foundRefund1()" type="button" value="创建" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(5);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg5" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>创建失败!</strong></div>
													<span id="returnMsg5"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(5);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
    
    <!-- 打印退货单 -->
     <div class="modal modal-darkorange" id="btDiv6">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(6);">×</button>
                    <h4 class="modal-title" id="divTitle6"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm6" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>退货单号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="refundNo" name="refundNo" />
													</div>&nbsp;
												</div>
		                                		<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>操作人编码：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="operator" name="operator" value="admin" />
													</div>&nbsp;
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="printRefund1()" type="button" value="打印" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(6);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg6" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>打印失败!</strong></div>
													<span id="returnMsg6"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(6);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
     <!-- 审核退货单 -->
     <div class="modal modal-darkorange" id="btDiv7">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(7);">×</button>
                    <h4 class="modal-title" id="divTitle7"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm7" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>退货单号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="refundNo" name="refundNo" />
													</div>&nbsp;
												</div>
		                                		<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>操作人编码：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="operator" name="operator" value="admin" />
													</div>&nbsp;
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="examineRefund1()" type="button" value="审核" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(7);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg7" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>审核失败!</strong></div>
													<span id="returnMsg7"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(7);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
    
     <!-- 退货单退款 -->
     <div class="modal modal-darkorange" id="btDiv8">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(8);">×</button>
                    <h4 class="modal-title" id="divTitle8"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm8" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	 <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>款机流水号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="salesPaymentNo" name="salesPaymentNo" />
							                        </div>&nbsp;
							                         </div>							                       
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>总金额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="money" name="money"   />
							                        </div>&nbsp;
							                      </div>							                        
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>机器号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="posNo" name="posNo"  />
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>总应收：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="paymentAmountp3" name="paymentAmount"  />
							                        </div>&nbsp;
							                        </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>实际支付：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control"  onchange="changeAmoun3(this)" id="actualPaymentAmountp3" name="actualPaymentAmount"  />
							                        </div>&nbsp;
							                        </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>门店号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="shopNo" name="shopNo"   value="8888" />
							                        </div>&nbsp;
							                         </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>门店名称：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="shopName" name="shopName"  value="王府井店"/>
							                        </div>&nbsp;
							                        </div>
							                        <div class="col-md-4">
		                                    		<div class="col-lg-5" style="text-align: right">
			                                			<span>线上线下标识：</span>
			                                		</div>
		                                			<div class="col-lg-7">
				                                		<select id="ooFlag" name="ooFlag" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="1" >线上</option>
				                                			<option value="2" selected="selected">线下</option>
				                                		</select>
			                                		</div>&nbsp;
                                					</div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>支付时间：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="payTimeStr" name="payTimeStr"  value="<%=str_date1 %>" />
							                        </div>&nbsp;
							                        </div>
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>收银员号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="casher" name="casher"  value="1234"/>
							                        </div>&nbsp;
							                        </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>渠道标志：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="channel" name="channel"  value="1"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>会员卡号</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="memberNo" name="memberNo"  value="111"/>
							                        </div>
							                        &nbsp; </div> 
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">授权卡号</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="authorizationNo" name="authorizationNo"  />
							                        </div>&nbsp;
							                         </div>
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label">交易流水号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="payFlowNo" name="payFlowNo"  value="1111"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <div class="col-lg-5" style="text-align: right">
			                                			<span>水单类型:</span>
			                                		</div>
		                                			<div class="col-lg-7">
				                                		<select id="isRefund" name="isRefund" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="0" >支付</option>
				                                			<option value="1" selected="selected">退款</option>
				                                		</select>
			                                		</div>&nbsp;
                                					</div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">总折扣：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="totalDiscountAmount" name="totalDiscountAmount"  value="0"/>
							                        </div>&nbsp;
							                        </div>
							                        
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">找零：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="changeAmountp3" name="changeAmount"  value="0"/>
							                        </div>&nbsp;
							                         </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">折扣额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="tempDiscountAmount" name="tempDiscountAmount"   value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">折让额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="zrAmount" name="zrAmount"  value="0"/>
							                        </div>&nbsp;
							                       </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">会员总折扣：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="memberDiscountAmount" name="memberDiscountAmount"  value="0"/>
							                        </div>&nbsp;
							                        </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">优惠折扣额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="promDiscountAmount" name="promDiscountAmount"   value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">收银损益：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="income" name="income"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                       
							                        <div class="col-md-4">
		                                    		<div class="col-lg-5" style="text-align: right">
			                                			<span>班次：</span>
			                                		</div>
		                                			<div class="col-lg-7">
				                                		<select id="shifts" name="shifts" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="0" >早班</option>
				                                			<option value="1" selected="selected">中班</option>
				                                			<option value="2" >晚班</option>
				                                		</select>
			                                		</div>&nbsp;
                                					</div>
							                        
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">微信卡类型：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="weixinCard" name="weixinCard"  value="001"/>
							                        </div>&nbsp;
							                          </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">微信卡门店号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="weixinStoreNo" name="weixinStoreNo"  value="00001"/>
							                        </div>&nbsp;
							                         </div>
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label">线上订单号</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="orderNo" name="orderNo"  />
							                        </div>&nbsp;
							                         </div>
							                        
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">人民币</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="rmb" name="rmb"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">电子返券</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="elecGet" name="elecGet"  value="0"/>
							                        </div>&nbsp;
							                        </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">电子扣款</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="elecDeducation" name="elecDeducation"  value="0"/>
							                        </div>&nbsp;
							                         </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">银行手续费</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="bankServiceCharge" name="bankServiceCharge"  value="0"/>
							                        </div>
							                        &nbsp; </div>  <div class="col-md-4">
							                        <label class="col-md-5 control-label">来源</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="sourceType" name="sourceType"  />
							                        </div>
							                        &nbsp; </div>&nbsp;
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
							                            <td><input name="paymentClass"  value="0016"></input></td>
							                               <td><input name="paymentType"  value="000161"></input></td>
							                               <td><input name="amount" ></input></td>
							                               <td><input name="acturalAmount" ></input></td>
							                               <td><input name="rate" value="0"></input></td>
							                               <td><input name="account" value="0001"></input></td>
							                               <td><input name="userId" value="1111"></input></td>
							                               <td><input name="payFlowNo" value="0001"></input></td>
							                               <td><input name="couponType" value="0001"></input></td>
							                               <td><input name="couponBatch" value="0001"></input></td>
							                               <td><input name="couponName" value="0001"></input></td>
							                               <td><input name="activityNo" value="200"></input></td>
							                               <td><input name="couponRule" value="0001"></input></td>
							                               <td><input name="couponRuleName" value="desc"></input></td>
							                               <td><input name="remark" value="无"></input></td>
							                               <td><input name="cashBalance" value="0"></input></td>
							                              
							                           
							                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
							                          </tr>
							                        </tbody>
							                      </table>&nbsp;
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
							                            <td><input name="refundNo1"  ></input></td>                          
							                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
							                          </tr>
							                        </tbody>
							                      </table>&nbsp;
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
					                            <td><input name="code"  value="2001"></input></td>
					                               <td><input name="name" value="2001"></input></td>
					                               <td><input name="getType" value="2010"></input></td>
					                               <td><input name="getChannel" value="01"></input></td>
					                               <td><input name="getTimeStr" value="2015-02-15 00:00:00"></input></td>
					                               <td><input name="amount2" value="0"></input></td>
					                               <td><input name="couponBatch2" value="001"></input></td>
                             
                             
						                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
						                          </tr>
						                        </tbody>
						                      </table>&nbsp;
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
														<td><input name="paymentClass1" value="0001"></input></td>
						                              	<td><input name="paymentType1" value="0001"></input></td>
						                              	<td><input name="deductionReason" value="0001"></input></td>
						                              	<td><input name="deductionType" value="0001"></input></td>
						                              	<td><input name="deductionAmount" value="0"></input></td>
						                              	<td><input name="account1" value="0001"></input></td>
						                              	<td><input name="couponType1" value="0001"></input></td>
						                              	<td><input name="couponBatch1" value="0001"></input></td>
							                             
							                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
							                          </tr>
							                        </tbody>
							                      </table>&nbsp;
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
							                            <td><input name="rowNo"></input></td>
							                            <td><input name="saleNo" ></input></td>
							                            <td><input name="paymentAmount1" ></input></td>
							                            <td><input name="salesItemId" ></input></td>
							                            <td><input name="saleSum" ></input></td>
							                            <td><input name="supplyProductNo" ></input></td>
							                            <td><input name="erpProductNo" ></input></td>
							                            <td><input name="promotionSplits" value="[{'freightAmount':5,'promotionAmount':11,'promotionCode':'3768333','promotionDesc':'满200减30','promotionName':'满额优惠','promotionRule':'2344','promotionRuleName':'待定','promotionType':'优惠','splitRate':1}]"></input></td>
							                          
							                             
							                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
							                          </tr>
							                        </tbody>
							                      </table>&nbsp;
												</div>
												
												
												
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="refundPos1()" type="button" value="退款" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(8);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg8" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>退款失败!</strong></div>
													<span id="returnMsg8"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(8);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
    
     <!-- 导购还库 -->
     <div class="modal modal-darkorange" id="btDiv9">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(9);">×</button>
                    <h4 class="modal-title" id="divTitle9"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm9" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>退货单号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="refundNo" name="refundNo" />
													</div>&nbsp;
												</div>
		                                		<div class="col-md-4">
													<label class="col-md-5 control-label"><font color="red">*</font>操作人编码：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="operator" name="operator" value="admin" />
													</div>&nbsp;
												</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="returnStock1()" type="button" value="还库" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(9);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg9" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>还库失败!</strong></div>
													<span id="returnMsg9"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(9);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
     <!-- 全脱机支付 -->
     <div class="modal modal-darkorange" id="btDiv10">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(10);">×</button>
                    <h4 class="modal-title" id="divTitle10"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm10" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>款机流水号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="salesPaymentNo" name="salesPaymentNo" />
							                        </div>
							                        </div>							                       
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>总金额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="money" name="money"  value="0" />
							                        </div>
							                         </div>
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>机器号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="posNo" name="posNo"  value="9998"/>
							                        </div>
							                        &nbsp; </div>
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>总应收：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="paymentAmountp2" name="paymentAmount" />
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>实际支付：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" onchange="changeAmoun2(this)" id="actualPaymentAmountp2" name="actualPaymentAmount" />
							                        </div>
							                        &nbsp; </div>
							                        
							                        
							                       <div class="col-md-4">
		                                    		<div class="col-lg-5" style="text-align: right">
			                                			<span>线上线下标识：</span>
			                                		</div>
		                                			<div class="col-lg-7">
				                                		<select id="ooFlag" name="ooFlag" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="1" >线上</option>
				                                			<option value="2" selected="selected">线下</option>
				                                		</select>
			                                		</div>&nbsp;
                                					</div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>支付时间：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="payTimeStr" name="payTimeStr"  value="<%=str_date1 %>" />
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>门店号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="shopNo" name="shopNo"   value="8888"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>门店名称：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="shopName" name="shopName"  value="王府井店"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>会员卡号</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="memberNo" name="memberNo"  value="111"/>
							                        </div>
							                        &nbsp; </div>
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>收银员号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="casher" name="casher"  value="1234"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>渠道标志：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="channel" name="channel"  value="1"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">授权卡号</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="authorizationNo" name="authorizationNo"  />
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
		                                    		<div class="col-lg-5" style="text-align: right">
			                                			<span>水单类型:</span>
			                                		</div>
		                                			<div class="col-lg-7">
				                                		<select id="isRefund" name="isRefund" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="0" selected="selected">支付</option>
				                                			<option value="1" >退款</option>
				                                		</select>
			                                		</div>&nbsp;
                                					</div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">交易流水号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="payFlowNo" name="payFlowNo"  value="1111"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">总折扣：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="totalDiscountAmount" name="totalDiscountAmount"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                       
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">找零：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="changeAmountp2" name="changeAmount"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">折扣额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="tempDiscountAmount" name="tempDiscountAmount"   value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">折让额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="zrAmount" name="zrAmount"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">会员总折扣：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="memberDiscountAmount" name="memberDiscountAmount"   value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">优惠折扣额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="promDiscountAmount" name="promDiscountAmount"   value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">收银损益：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="income" name="income"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                      <div class="col-md-4">
		                                    		<div class="col-lg-5" style="text-align: right">
			                                			<span>班次：</span>
			                                		</div>
		                                			<div class="col-lg-7">
				                                		<select id="shifts" name="shifts" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="0" >早班</option>
				                                			<option value="1" selected="selected">中班</option>
				                                			<option value="2" >晚班</option>
				                                		</select>
			                                		</div>&nbsp;
                                					</div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">微信卡类型：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="weixinCard" name="weixinCard"  value="001"/>
							                        </div>
							                         &nbsp; </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">微信卡门店号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="weixinStoreNo" name="weixinStoreNo"  value="00001"/>
							                        </div>
							                        &nbsp; </div>
							                         
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label">线上订单号</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="orderNo" name="orderNo"  />
							                        </div>
							                        &nbsp; </div>
							                        
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">人民币</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="rmb" name="rmb"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">电子返券</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="elecGet" name="elecGet"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">电子扣款</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="elecDeducation" name="elecDeducation"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4">
							                        <label class="col-md-5 control-label">银行手续费</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="bankServiceCharge" name="bankServiceCharge"  value="0"/>
							                        </div>
							                        &nbsp; </div>  <div class="col-md-4">
							                        <label class="col-md-5 control-label">来源</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="sourceType" name="sourceType"  />
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
							                            <td><input name="paymentClass"  value="0016"></input></td>
							                               <td><input name="paymentType"  value="000161"></input></td>
							                               <td><input name="amount" ></input></td>
							                               <td><input name="acturalAmount" ></input></td>
							                               <td><input name="rate" value="0"></input></td>
							                               <td><input name="account" value="0001"></input></td>
							                               <td><input name="userId" value="111"></input></td>
							                               <td><input name="payFlowNo" value="0001"></input></td>
							                               <td><input name="couponType" value="0001"></input></td>
							                               <td><input name="couponBatch" value="0001"></input></td>
							                               <td><input name="couponName" value="0001"></input></td>
							                               <td><input name="activityNo" value="200"></input></td>
							                               <td><input name="couponRule" value="0001"></input></td>
							                               <td><input name="couponRuleName" value="desc"></input></td>
							                               <td><input name="remark" value="无"></input></td>
							                               <td><input name="cashBalance" value="0"></input></td>
							                              
							                           
							                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
							                          </tr>
							                        </tbody>
							                      </table>&nbsp;
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
					                            <td><input name="code"  value="2001"></input></td>
					                               <td><input name="name" value="2001"></input></td>
					                               <td><input name="getType" value="2010"></input></td>
					                               <td><input name="getChannel" value="01"></input></td>
					                               <td><input name="getTimeStr" value="2015-02-15 00:00:00"></input></td>
					                               <td><input name="amount1" value="0"></input></td>
					                               <td><input name="couponBatch1" value="001"></input></td>
                             
                             
						                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
						                          </tr>
						                        </tbody>
						                      </table>&nbsp;
												</div>
												<div class="col-md-12">
													<table>
							                        <thead>
							                          <tr>
							                            <th>行号</th>
							                            <!-- <th><font color="red">*</font>销售单号</th> -->
							                            <th><font color="red">*</font>销售总价</th>
							                            <!-- <th><font color="red">*</font>商品行项目编号</th> -->
							                            <th><font color="red">*</font>销售数量</th>
							                            <th>专柜商品编码</th>
							                            <th>大码</th>
							                          </tr>
							                        </thead>
							                        <tbody>
							                          <tr>
							                            <td><input name="rowNo"></input></td>
							                                <!-- <td><input name="saleNo" ></input></td> -->
							                               <td><input name="paymentAmount1"></input></td>
							                               <!-- <td><input name="salesItemId" ></input></td> -->
							                               <td><input name="saleSum" ></input></td>
							                               <td><input name="supplyProductNo" ></input></td>
							                               <td><input name="erpProductNo"></input></td>
							                          
							                             
							                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
							                          </tr>
							                        </tbody>
							                      </table>&nbsp;
												</div>
							                        
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="salePay1()" type="button" value="支付" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(10);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg10" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>全脱机支付失败!</strong></div>
													<span id="returnMsg10"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(10);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
    <!-- PAD创建 -->
     <div class="modal modal-darkorange" id="btDiv11">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(11);">×</button>
                    <h4 class="modal-title" id="divTitle11"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm11" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">


												<div class="col-md-6">
													<label class="col-md-5 control-label"><font color="red">*</font>机器号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="posNo"
															name="posNo" value="9999" />
													</div>&nbsp;
												</div>
												<div class="col-md-6">
													<label class="col-md-5 control-label">会员卡号</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="memberNo"
															name="memberNo" value="111" />
													</div>&nbsp;
												</div>
												<div class="col-md-6">
													<label class="col-md-5 control-label"><font color="red">*</font>门店号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="shopNo"
															name="shopNo" value="8888" />
													</div>&nbsp;
												</div>
												<div class="col-md-6">
													<label class="col-md-5 control-label"><font color="red">*</font>门店名称：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="shopName"
															name="shopName" value="王府井店" />
													</div>&nbsp;
												</div>
												<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label"><font color="red">*</font>线上线下标识：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="ooFlag"
															name="ooFlag" value="2" />
													</div>&nbsp;
												</div>
												<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label"><font color="red">*</font>水单类型:</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="isRefund"
															name="isRefund" value="0" />
													</div>&nbsp;
												</div>
												<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label"><font color="red">*</font>渠道标志：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="channel"
															name="channel" value="1" />
													</div>&nbsp;
												</div>
												<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label"><font color="red">*</font>收银员号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="casher"
															name="casher" value="110" />
													</div>&nbsp;
												</div>
												<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label">授权卡号</label>
													<div class="col-md-7">
														<input type="text" class="form-control"
															id="authorizationNo" name="authorizationNo" />
													</div>&nbsp;
												</div>
												<div class="col-md-4" style="display:none;">
		                                    		<div class="col-lg-5" style="text-align: right">
			                                			<span>班次：</span>
			                                		</div>
		                                			<div class="col-lg-7">
				                                		<select id="shifts" name="shifts" class="form-control" style="padding:0 0;width: 100%;">
				                                			<option value="0" >早班</option>
				                                			<option value="1" selected="selected">中班</option>
				                                			<option value="2" >晚班</option>
				                                		</select>
			                                		</div>&nbsp;
                                					</div>
												
												<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label">微信卡类型：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="weixinCard"
															name="weixinCard" value="001" />
													</div>&nbsp;
												</div>
												<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label">微信卡门店号：</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="weixinStoreNo"
															name="weixinStoreNo" value="00001" />
													</div>&nbsp;
												</div>
												<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label">线上订单号</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="orderNo"
															name="orderNo" />
													</div>&nbsp;
												</div>
												
												<div class="col-md-4" style="display:none;">
													<label class="col-md-5 control-label">来源</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="sourceType"
															name="sourceType" />
													</div>&nbsp;
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
															<td><input name="saleNo"></input>
															</td>
															<td onclick="copyTr(this)">+</td>
														</tr>
													</tbody>
												</table>
												&nbsp;
											</div>

											<div class="form-group">
												<div class="col-lg-offset-4 col-lg-6">
													<input class="btn btn-success" style="width: 25%;" id="save" onclick="salePadCreat1()" type="button" value="创建" />&emsp;&emsp; 
													<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(11);" type="button" value="关闭" />
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
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(11);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
    
     <!-- PAD添加销售单 -->
     <div class="modal modal-darkorange" id="btDiv12">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(12);">×</button>
                    <h4 class="modal-title" id="divTitle12"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm12" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>款机流水号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="salesPaymentNo" name="salesPaymentNo" />
							                        </div>
							                        &nbsp; </div>
							                       
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>销售单号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="saleNo" name="saleNo"  />
							                        </div>
							                        &nbsp; </div>
							                        
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="salePadAdd1()" type="button" value="添加" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(12);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg12" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>PAD添加失败!</strong></div>
													<span id="returnMsg12"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(12);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
    
     <!-- PAD取消 -->
     <div class="modal modal-darkorange" id="btDiv13">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(13);">×</button>
                    <h4 class="modal-title" id="divTitle13"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm13" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>款机流水号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="salesPaymentNo" name="salesPaymentNo" />
							                        </div>
							                        &nbsp; </div>
							                       
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>销售单号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="saleNo" name="saleNo"  />
							                        </div>
							                        &nbsp; </div>
							                        
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="salePadCancle1()" type="button" value="取消" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(13);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg13" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>PAD取消失败!</strong></div>
													<span id="returnMsg13"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(13);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
    
    <!-- PAD支付 -->
     <div class="modal modal-darkorange" id="btDiv14">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(14);">×</button>
                    <h4 class="modal-title" id="divTitle14"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm14" method="post" class="form-horizontal" >
									<div class="tabbable">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
                                            	
                                            	<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>款机流水号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="salesPaymentNo" name="salesPaymentNo" />
							                        </div>
							                        &nbsp; </div>
							                       
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>总金额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="money" name="money"  />
							                        </div>
							                        &nbsp; </div>
							                         <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>总应收：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="paymentAmount" name="paymentAmount" />
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>实际支付：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="actualPaymentAmount" name="actualPaymentAmount"  />
							                        </div>
							                        &nbsp; </div>
							                        
							                        <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label"><font color="red">*</font>支付时间：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="payTimeStr" name="payTimeStr"  value="<%=str_date1 %>" />
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label">交易流水号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="payFlowNo" name="payFlowNo"  value="1111"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">总折扣：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="totalDiscountAmount" name="totalDiscountAmount"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                       
							                        <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">找零：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="changeAmount" name="changeAmount"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">折扣额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="tempDiscountAmount" name="tempDiscountAmount"   value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">折让额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="zrAmount" name="zrAmount"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">会员总折扣：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="memberDiscountAmount" name="memberDiscountAmount"  value="0" />
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">优惠折扣额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="promDiscountAmount" name="promDiscountAmount"   value="0"/>
							                        </div>
							                        &nbsp; </div>
							                        <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">收银损益：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="income" name="income"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">人民币</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="rmb" name="rmb"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">电子返券</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="elecGet" name="elecGet"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">电子扣款</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="elecDeducation" name="elecDeducation"  value="0"/>
							                        </div>
							                        &nbsp; </div>
							                          <div class="col-md-4" style="display:none;">
							                        <label class="col-md-5 control-label">银行手续费</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="bankServiceCharge" name="bankServiceCharge"  value="0"/>
							                        </div>
							                        &nbsp; </div>  
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
							                            <td><input name="paymentClass"  value="0016"></input></td>
							                               <td><input name="paymentType"  value="000161"></input></td>
							                               <td><input name="amount" ></input></td>
							                               <td><input name="acturalAmount" ></input></td>
							                               <td><input name="rate" value="0"></input></td>
							                               <td><input name="account" value="0001"></input></td>
							                               <td><input name="userId" value="111"></input></td>
							                               <td><input name="payFlowNo" value="0001"></input></td>
							                               <td><input name="couponType" value="0001"></input></td>
							                               <td><input name="couponBatch" value="0001"></input></td>
							                               <td><input name="couponName" value="0001"></input></td>
							                               <td><input name="activityNo" value="200"></input></td>
							                               <td><input name="couponRule" value="0001"></input></td>
							                               <td><input name="couponRuleName" value="desc"></input></td>
							                               <td><input name="remark" value="无"></input></td>
							                               <td><input name="cashBalance" value="0"></input></td>
							                              
							                           
							                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
							                          </tr>
							                        </tbody>
							                      </table>&nbsp;
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
					                            <td><input name="code"  value="2001"></input></td>
					                               <td><input name="name" value="2001"></input></td>
					                               <td><input name="getType" value="2010"></input></td>
					                               <td><input name="getChannel" value="01"></input></td>
					                               <td><input name="getTimeStr" value="2015-02-15 00:00:00"></input></td>
					                               <td><input name="amount1" value="0"></input></td>
					                               <td><input name="couponBatch1" value="001"></input></td>
                             
                             
						                            <td align="center" onclick="copyTr(this)" style="vertical-align:middle;"><span class="expand-collapse click-expand glyphicon glyphicon-plus" style='cursor:pointer;'></span></td>
						                          </tr>
						                        </tbody>
						                      </table>&nbsp;
												</div>
							                        
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="salePad1()" type="button" value="支付" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(14);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg14" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>PAD支付失败!</strong></div>
													<span id="returnMsg14"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(14);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    
    
    <!-- PAD打印款机 -->
     <div class="modal modal-darkorange" id="btDiv15">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(15);">×</button>
                    <h4 class="modal-title" id="divTitle15"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm15" method="post" class="form-horizontal" >
						<div class="tabbable">
                                <div class="tab-content">
					                 <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
					
													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>开始时间：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="starttime"
																name="starttime" />
														</div>
													</div>
				
													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>截止时间：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="endtime"
																name="endtime" />
														</div>
													</div>
													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>机器号：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="posNo"
																name="posNo" />
														</div>
														&nbsp;
													</div>
					
														<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="printPay1()" type="button" value="打印" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(15);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg15" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>PAD打印失败!</strong></div>
													<span id="returnMsg15"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(15);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
    <!-- 作废退货单 -->
     <div class="modal modal-darkorange" id="btDiv17">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(17);">×</button>
                    <h4 class="modal-title" id="divTitle17"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm17" method="post" class="form-horizontal" >
						<div class="tabbable">
                                <div class="tab-content">
					                 <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">

													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>退货单号：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="refundNo"
																name="refundNo"  />
														</div>
														&nbsp;
													</div>
													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>操作人：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="latestUpdateMan"
																name="latestUpdateMan" value="admin"/>
														</div>
														&nbsp;
													</div>
				
				
													<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="refundCancel1()" type="button" value="作废" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(17);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg17" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>作废退货单失败!</strong></div>
													<span id="returnMsg17"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(17);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
    <!-- 作废销售单 -->
     <div class="modal modal-darkorange" id="btDiv16">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(16);">×</button>
                    <h4 class="modal-title" id="divTitle16"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm16" method="post" class="form-horizontal" >
						<div class="tabbable">
                                <div class="tab-content">
					                 <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">

													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>销售单号：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="saleNo" name="saleNo"  />
														</div>
														&nbsp;
													</div>
													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>操作人：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="latestUpdateMan"
																name="latestUpdateMan" value="admin" />
														</div>
														&nbsp;
													</div>
													<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="saleCancel1()" type="button" value="作废" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(16);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg16" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>作废销售单失败!</strong></div>
													<span id="returnMsg16"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(16);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
     <!-- 创建发票 -->
     <div class="modal modal-darkorange" id="btDiv18">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(18);">×</button>
                    <h4 class="modal-title" id="divTitle18"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm18" method="post" class="form-horizontal" >
						<div class="tabbable">
                                <div class="tab-content">
					                 <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">

													<div class="col-md-6">
								                        <label class="col-md-3 control-label"><font color="red">*</font>销售单号：</label>
								                        <div class="col-md-9">
								                          <input type="text" class="form-control" id="saleNo" name="saleNo" />
								                        </div>&nbsp; 
							                        </div>
							                        <div class="col-md-6">
								                        <label class="col-md-3 control-label"><font color="red">*</font>发票编号：</label>
								                        <div class="col-md-9">
								                          <input type="text" class="form-control" id="invoiceNo" name="invoiceNo"  />
								                        </div>&nbsp; 
							                        </div>
							                        <div class="col-md-6">
								                        <label class="col-md-3 control-label"><font color="red">*</font>发票金额：</label>
								                        <div class="col-md-9">
								                          <input type="text" class="form-control" id="invoiceAmount" name="invoiceAmount"  />
								                        </div>&nbsp; 
							                        </div>
							                        <div class="col-md-6">
								                        <label class="col-md-3 control-label"><font color="red">*</font>发票抬头：</label>
								                        <div class="col-md-9">
								                          <input type="text" class="form-control" id="invoiceTitle" name="invoiceTitle"  />
								                        </div>&nbsp; 
							                        </div>
							                        <div class="col-md-6">
								                        <label class="col-md-3 control-label">发票明细：</label>
								                        <div class="col-md-9">
								                          <input type="text" class="form-control" id="invoiceDetail" name="invoiceDetail" />
								                        </div>&nbsp; 
							                        </div>
							                        <div class="col-md-6">
								                        <label class="col-md-3 control-label">开票日期：</label>
								                        <div class="col-md-9">
								                          <input type="text" class="form-control" id="createdTimeStr" name="createdTimeStr"  value="<%=str_date1 %>"/>
								                        </div>&nbsp; 
							                        </div>
							                        <div class="col-md-6">
								                        <label class="col-md-3 control-label">开票人：</label>
								                        <div class="col-md-9">
								                          <input type="text" class="form-control" id="createdMan" name="createdMan"  value="admin"/>
								                        </div>&nbsp; 
							                        </div>
													<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="saveInvoice1()" type="button" value="创建" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(18);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg18" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>创建发票失败!</strong></div>
													<span id="returnMsg18"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(18);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
     <!-- 作废流水信息 -->
     <div class="modal modal-darkorange" id="btDiv19">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(19);">×</button>
                    <h4 class="modal-title" id="divTitle19"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm19" method="post" class="form-horizontal" >
						<div class="tabbable">
                                <div class="tab-content">
					                 <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">

													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>款机流水号：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="salesPaymentNo" name="salesPaymentNo"  />
														</div>
														&nbsp;
													</div>
													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>操作人：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="casher" name="casher" value="admin" />
														</div>
														&nbsp;
													</div>
													<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="salePadCancel1()" type="button" value="作废" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(19);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg19" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>作废流水信息失败!</strong></div>
													<span id="returnMsg19"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(19);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
    <!-- 创建换货单 -->
     <div class="modal modal-darkorange" id="btDiv20">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(20);">×</button>
                    <h4 class="modal-title" id="divTitle20"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm20" method="post" class="form-horizontal" >
						<div class="tabbable">
                                <div class="tab-content">
					                 <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">

												<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>会员编号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="memberNo" name="memberNo" />
							                        </div>
							                        &nbsp;
							                    </div>
												<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>原销售单号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="originalSaleNo" name="originalSaleNo" />
							                        </div>
							                        &nbsp;
							                    </div>
												<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>新销售单：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="saleNo" name="saleNo" />
							                        </div>
							                        &nbsp;
							                    </div>
												<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>退货单号号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="refundNo" name="refundNo" />
							                        </div>
							                        &nbsp;
							                     </div>
												<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>门店编号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="shopNo" name="shopNo" />
							                        </div>
							                        &nbsp;
							                    </div>
												<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>差额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="imbalance" name="imbalance" />
							                        </div>
							                        &nbsp;
							                     </div>
							                     <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>员工号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="employeeNo" name="employeeNo" value="zxl" />
							                        </div>
							                        &nbsp;
							                     </div>
							                     <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>机器号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="casherNo" name="casherNo" value="110" />
							                        </div>
							                     </div>
													
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="foundExchange1()" type="button" value="创建" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(20);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg20" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>创建换货单失败!</strong></div>
													<span id="returnMsg20"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(20);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
    <!-- 修改换货单 -->
     <div class="modal modal-darkorange" id="btDiv21">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(21);">×</button>
                    <h4 class="modal-title" id="divTitle21"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm21" method="post" class="form-horizontal" >
						<div class="tabbable">
                                <div class="tab-content">
					                 <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
													<div class="col-md-4">
								                        <label class="col-md-5 control-label"><font color="red">*</font>换货单号：</label>
								                        <div class="col-md-7">
								                          <input type="text" class="form-control" id="exchangeNo" name="exchangeNo" />
								                        </div>
							                        </div>
							                        <div class="col-md-8">
							                        	<div class="col-md-12">
				                                    	<input type="button" class="btn btn-azure" style="width: 25%;" onclick="getExchange(this)" value="获取换货单"/>
				                                    	</div>
                                        			&nbsp;
                                        			</div>
													<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>原销售单号：</label>
								                        <div class="col-md-7">
								                          <input type="text" class="form-control" id="originalSaleNo_h" name="originalSaleNo" />
								                        </div>
							                        &nbsp;
							                        </div>
													<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>新销售单：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="saleNo_h" name="saleNo" />
							                        </div>
							                        &nbsp;</div>
													<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>退货单号号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="refundNo_h" name="refundNo" />
							                        </div>
							                        &nbsp;</div>
													<div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>差额：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="imbalance_h" name="imbalance" />
							                        </div>
							                        &nbsp;</div>
							                        <div class="col-md-4">
							                        <label class="col-md-5 control-label"><font color="red">*</font>员工号：</label>
							                        <div class="col-md-7">
							                          <input type="text" class="form-control" id="employeeNo_h" name="employeeNo" />
							                        </div>&nbsp;
													</div>
													
													<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="updateExchange1()" type="button" value="修改" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(21);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg21" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改换货单失败!</strong></div>
													<span id="returnMsg21"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(21);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
    <!-- 移库 -->
     <div class="modal modal-darkorange" id="btDiv33">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(33);">×</button>
                    <h4 class="modal-title" id="divTitle33"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm33" method="post" class="form-horizontal" >
						<div class="tabbable">
                                <div class="tab-content">
					                 <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">
										<div>
										<div class="col-md-6">
											<label class="col-md-5 control-label">渠道：</label>
											<div class="col-md-6">
												<input type="text" class="form-control" id="channelSid" name="channelSid" value="0" />
											</div>
											&nbsp;
										</div>
										<div class="col-md-6">
											<label class="col-md-5 control-label">专柜商品编码：</label>
											<div class="col-md-6">
												<input type="text" class="form-control" id="shoppeProSid" name="shoppeProSid"  />
											</div>
											&nbsp;
										</div>&nbsp;
										</div>
										<div>
										<div class="col-md-6">
											<label class="col-md-5 control-label">原库位：</label>
											<div class="col-md-6">
												<input type="hidden" class="form-control" id="stockTypeSid" name="stockTypeSid" value="1003" />
												<input type="text" class="form-control" value="退货库" />
											</div>
											&nbsp;
										</div>
										<div class="col-md-6">
											<label class="col-md-5 control-label">数量：</label>
											<div class="col-md-6">
												<input type="text" class="form-control" id="proSum1" name="proSum1"  />
											</div>
											&nbsp;
										</div>&nbsp;
										</div>
										<div>
										<div class="col-md-6">
											<label class="col-md-5 control-label">转移库位：</label>
											<div class="col-md-6">
												<input type="hidden" class="form-control" id="newStockType" name="newStockType" value="1001" />
												<input type="text" class="form-control" value="可售库" />
											</div>
											&nbsp;
										</div>
										<div class="col-md-6">
											<label class="col-md-5 control-label">转移数量：</label>
											<div class="col-md-6">
												<input type="text" class="form-control" id="proSum" name="proSum"  />
											</div>
											&nbsp;
										</div>&nbsp;
										</div>
												<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="foundYiku1()" type="button" value="移库" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(33);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg33" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>移库失败!</strong></div>
													<span id="returnMsg33"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(33);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
     <!-- 作废发票信息 -->
     <div class="modal modal-darkorange" id="btDiv22">
        <div class="modal-dialog" style="width: 1200px;height:500px;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv(22);">×</button>
                    <h4 class="modal-title" id="divTitle22"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                 	<form id="theForm22" method="post" class="form-horizontal" >
						<div class="tabbable">
                                <div class="tab-content">
					                 <div id="home" class="tab-pane in active" style="height:400px;overflow:scroll;">

													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>发票编号：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="invoiceNo" name="invoiceNo"  />
														</div>
														&nbsp;
													</div>
													<div class="col-md-4">
														<label class="col-md-5 control-label"><font color="red">*</font>操作人：</label>
														<div class="col-md-7">
															<input type="text" class="form-control" id="casher" name="casher" value="admin" />
														</div>
														&nbsp;
													</div>
													<div class="form-group">
													<div class="col-lg-offset-4 col-lg-6">
														<input class="btn btn-success" style="width: 25%;" id="save" onclick="invoiceCancel1()" type="button" value="作废" />&emsp;&emsp;
														<input class="btn btn-danger" style="width: 25%;" id="close" onclick="closeBtDiv(22);" type="button" value="关闭" />
													</div>
												</div>
												<div id="errorMsg22" style="display:none">
													<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>作废发票信息失败!</strong></div>
													<span id="returnMsg22"></span>
												</div>
                                            </div>
                                        </div>
                                    </div>
								</form>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv(22);" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    
</body>
</html>