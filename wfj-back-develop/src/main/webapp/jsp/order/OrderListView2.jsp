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
<style type="text/css">
/* .trClick>td,.trClick>th{
 color:red;
} */
</style>
  <script type="text/javascript">
		__ctxPath = "${ctx}";
		image="http://images.shopin.net/images";
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	var saleSum2;
	var salesPrice1;
	var shoppeProName1;
	var supplyProductNo1;
	var saleSum1=0;
	var olvPagination;
	$(function() {
		//订单状态
		$("#orderStatus_select").one("click",function(){
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=order_status",
				dataType: "json",
				success: function(response) {
					var result = response;
					var codeValue = $("#orderStatus_select");
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
		//退货原因
		$("#sp4").one("click",function(){
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=refundReason",
				dataType: "json",
				success: function(response) {
					var result = response;
					var codeValue = $("#sp4");
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
		$("#orderNo_form").val($("#orderNo_input").val().trim());
		$("#orderStatus_form").val($("#orderStatus_select").val());
		$("#memberNo_form").val($("#memberNo_input").val().trim());
		$("#accountNo_form").val($("#accountNo_input").val().trim());
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#orderNo_input").val("");
		$("#orderStatus_select").val("");
		$("#memberNo_input").val("");
		$("#accountNo_input").val("");
		olvQuery();
	}
	function urlClick(ur,obj){
//		$("#imageDiv").text(ur);
		$("#imageDiv").html('<img style="width:200px; heigth:200px;" align="center" src="http://10.6.100.100/'+ur+'"/>');
		$("#btDiv211").show();
	}
	function closeBtDiv211(){
		$("#btDiv211").hide();
	}
	function Ok(){
		//创建退货申请单保存
		orderNo = orderNo_;
		orderItemNo = orderItemNo_;
		saleSum3 = $("#sp3").text().trim();
		problemDesc =$("#sp4").val();
		callCenterComments =$("#sp5").val();
		var userName = getCookieValue("username");
		$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/testOnlineOmsOrder/createKeRefund2",
				async : false,
				data : {
					"refundNum15" : saleSum3,
					"orderNo" : orderNo,
					"orderItemNo" : orderItemNo,
					"problemDesc": problemDesc,
					"callCenterComments": callCenterComments,
					"latestUpdateMan":username
				},
				dataType : "json",
				
				success : function(response) {
					if(response.success=='true'){
						refundApplyNo_ = response.data.refundApplyNo;  /* 拿到refundApplyNo */
						supplyProductNo_ =response.data.products[0].supplyProductNo;
						shoppeProName_ =response.data.products[0].shoppeProName;
						salePrice_ =response.data.products[0].salePrice;
						orderNo_ = response.data.orderNo;
						saleSum2= $("#sp3").text().trim();
						
						refundReasonValue = $("#refundReasion option:selected").text().trim();
						refundReason= $("#sp4").val();
						console.log(refundReason);
						refundRemark= $("#sp5").val();
						
						var url = __ctxPath + "/jsp/order/RefundView.jsp";
						$("#pageBody").load(url);
					}else{
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><strong>"+response.data.errorMsg+"</strong></div>");
	 	     	  		$("#modal-warning").attr({"style":"display:block;z-index:2000","aria-hidden":"false","class":"modal modal-message modal-warning"});
						//没有保存成功，不跳转
					}
					return;
				}
			});
	}
	function No(){
		$("#btDiv2").hide();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/testOnlineOmsOrder/selectOrderList";
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
	//订单明细促销
 	function spanTd(obj) {
		if ($("#spanTd_"+obj).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#spanTd_"+obj).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/omsOrder/selectOrderPromotionSplit",
				async : false,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass(
								"loading-inactive");
					}, 300);
				},
				data : {"orderItemNo" : obj},
				success : function(response) {
					if(response.success=='true'){
						var result = response.list;
						var option = "<tr id='afterTr"+obj+"'><td></td><td colspan='5'><div style='padding:2px;width: 150%;'>"
								+ "<table class='table table-bordered table-striped table-condensed table-hover flip-content' ><tr role='row'>";
							option += "<th width='4%' style='text-align: center;'>商品行项目编号</th>"+
							"<th width='3%' style='text-align: center;'>促销编码</th>"+
							/* "<th width='3%' style='text-align: center;'>促销类型</th>"+ */
							"<th width='3%' style='text-align: center;'>促销名称</th>"+
							"<th width='3%' style='text-align: center;'>促销描述</th>"+
							"<th width='3%' style='text-align: center;'>促销优惠分摊金额</th>"+
							"<th width='3%' style='text-align: center;'>促销规则</th>"+
							"<th width='3%' style='text-align: center;'>促销规则值</th>"+
							"<th width='3%' style='text-align: center;'>分摊比例</th>"+
							"<th width='3%' style='text-align: center;'>运费促销分摊</th></tr>";
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							//商品行项目编号
							if(ele.orderItemNo=="[object Object]"||ele.orderItemNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.orderItemNo+"</td>";
							}
							//促销编码
							if(ele.promotionCode=="[object Object]"||ele.promotionCode==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.promotionCode+"</td>";
							}
							/* //促销类型
							if(ele.promotionType=="[object Object]"||ele.promotionType==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.promotionType+"</td>";
							} */
							//促销名称
							if(ele.promotionName=="[object Object]"||ele.promotionName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.promotionName+"</td>";
							}
							//促销描述
							if(ele.promotionDesc=="[object Object]"||ele.promotionDesc==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.promotionDesc+"</td>";
							}
							//促销优惠分摊金额
							if(ele.promotionAmount=="[object Object]"||ele.promotionAmount==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.promotionAmount+"</td>";
							}
							//促销规则
							if(ele.promotionRule=="[object Object]"||ele.promotionRule==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.promotionRule+"</td>";
							}
							//促销规则值
							if(ele.promotionRuleName=="[object Object]"||ele.promotionRuleName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.promotionRuleName+"</td>";
							}
							//分摊比例
							if(ele.splitRate=="[object Object]"||ele.splitRate==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.splitRate+"</td>";
							}
							//运费促销分摊
							if(ele.freightAmount=="[object Object]"||ele.freightAmount==undefined){
								option+="<td align='center'></td></tr>";
							}else{
								option+="<td align='center'>"+ele.freightAmount+"</td></tr>";
							}
						}
						option += "</table></div></td></tr>";
						$("#gradeY" + obj).after(option);
					}
				}
			});
		} else {
			$("#spanTd_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTr" + obj).remove();
		}
		
	}
 	
 	function spanTd1(obj) {
		if ($("#spanTd1_"+obj).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#spanTd1_"+obj).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/omsOrder/selectPackageHistoryList",
				async : false,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass(
								"loading-inactive");
					}, 300);
				},
				data : {"packageNo" : obj},
				success : function(response) {
					if(response.success=='true'){
						var result = response.list;
						var option = "<tr id='afterTr1"+obj+"'><td></td><td colspan='5'><div style='padding:2px;width: 200%;'>"
								+ "<table class='table table-bordered table-striped table-condensed table-hover flip-content' ><tr role='row'>";
							option += "<th width='3%' style='text-align: center;'>包裹单号</th>"+
							"<th width='3%' style='text-align: center;'>订单号</th>"+
							"<th width='3%' style='text-align: center;'>销售单号</th>"+
							"<th width='2%' style='text-align: center;'>包裹单状态</th>"+
							"<th width='3%' style='text-align: center;'>包裹来源</th>"+
							"<th width='3%' style='text-align: center;'>快递单号</th>"+
							"<th width='2%' style='text-align: center;'>快递记录时间</th>"+
							"<th width='2%' style='text-align: center;'>快递记录</th>"+
							"<th width='2%' style='text-align: center;'>快递员</th>"+
							"<th width='2%' style='text-align: center;'>快递员编号</th>"+
							"<th width='2%' style='text-align: center;'>更新人</th>"+
							"<th width='2%' style='text-align: center;'>系统来源</th>"+
							"<th width='2%' style='text-align: center;'>创建时间</th>"+
							"<th width='2%' style='text-align: center;'>备注</th></tr>";
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							//包裹单号
							if(ele.packageNo=="[object Object]"||ele.packageNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.packageNo+"</td>";
							}
							//订单号
							if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.orderNo+"</td>";
							}
							//销售单号
							if(ele.saleNo=="[object Object]"||ele.saleNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.saleNo+"</td>";
							}
							//包裹单状态
							if(ele.packageStatusDesc=="[object Object]"||ele.packageStatusDesc==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.packageStatusDesc+"</td>";
							}
							//包裹来源
							if(ele.packageSource=="[object Object]"||ele.packageSource==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.packageSource+"</td>";
							}
							//快递单号
							if(ele.deliveryNo=="[object Object]"||ele.deliveryNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.deliveryNo+"</td>";
							}
							//快递记录时间
							if(ele.deliveryDateStr=="[object Object]"||ele.deliveryDateStr==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.deliveryDateStr+"</td>";
							}
							//快递记录
							if(ele.deliveryRecord=="[object Object]"||ele.deliveryRecord==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.deliveryRecord+"</td>";
							}
							//快递员
							if(ele.deliveryMan=="[object Object]"||ele.deliveryMan==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.deliveryMan+"</td>";
							}
							//快递员编号
							if(ele.deliveryManNo=="[object Object]"||ele.deliveryManNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.deliveryManNo+"</td>";
							}
							//更新人
							if(ele.updateMan=="[object Object]"||ele.updateMan==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.updateMan+"</td>";
							}
							//系统来源
							if(ele.operatorSource=="[object Object]"||ele.operatorSource==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.operatorSource+"</td>";
							}
							//创建时间
							if(ele.createTimeStr=="[object Object]"||ele.createTimeStr==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.createTimeStr+"</td>";
							}
							//备注
							if(ele.remark=="[object Object]"||ele.remark==undefined){
								option+="<td align='center'></td></tr>";
							}else{
								option+="<td align='center'>"+ele.remark+"</td></tr>";
							}
						}
						option += "</table></div></td></tr>";
						$("#gradeY1" + obj).after(option);
					}
				}
			});
		} else {
			$("#spanTd1_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTr1" + obj).remove();
		}
		
	}
 	//查询订单支付介质
 	function spanTd11(obj) {
		if ($("#spanTd11_"+obj).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#spanTd11_"+obj).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/omsOrder/selectPaymentItemList",
				async : false,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass(
								"loading-inactive");
					}, 300);
				},
				data : {"salesPaymentNo" : obj},
				success : function(response) {
					if(response.success=='true'){
						var result = response.list;
						var option11 = "<tr id='afterTr11"+obj+"'><td></td><td colspan='5'><div style='padding:2px;width: 200%;'>"
								+ "<table class='table table-bordered table-striped table-condensed table-hover flip-content' ><tr role='row'>";
								option11 += "<th width='5%' style='text-align: center;'>交易支付流水</th>"+
								"<th width='3%' style='text-align: center;'>支付方式</th>"+
								"<th width='3%' style='text-align: center;'>支付金额</th>"+
								"<th width='3%' style='text-align: center;'>实际抵扣金额</th>"+
								"<th width='3%' style='text-align: center;'>汇率（折现率)</th>"+
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
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							//款机流水号
							if(ele.posFlowNo=="[object Object]"||ele.posFlowNo==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.posFlowNo+"</td>";
							}
							//支付方式
							if(ele.paymentType=="[object Object]"||ele.paymentType==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.paymentType+"</td>";
							}
							//支付金额
							if(ele.amount=="[object Object]"||ele.amount==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.amount+"</td>";
							}
							//实际抵扣金额
							if(ele.acturalAmount=="[object Object]"||ele.acturalAmount==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.acturalAmount+"</td>";
							}
							//汇率
							if(ele.rate=="[object Object]"||ele.rate==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.rate+"</td>";
							}
							//支付账号
							if(ele.account=="[object Object]"||ele.account==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.account+"</td>";
							}
							//会员id
							if(ele.userId=="[object Object]"||ele.userId==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.userId+"</td>";
							}
							//支付流水号
							if(ele.payFlowNo=="[object Object]"||ele.payFlowNo==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.payFlowNo+"</td>";
							}
							//优惠券类型
							if(ele.couponType=="[object Object]"||ele.couponType==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.couponType+"</td>";
							}
							//优惠券批次
							if(ele.couponBatch=="[object Object]"||ele.couponBatch==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.couponBatch+"</td>";
							}
							//券模板名称
							if(ele.couponName=="[object Object]"||ele.couponName==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.couponName+"</td>";
							}
							//活动号
							if(ele.activityNo=="[object Object]"||ele.activityNo==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.activityNo+"</td>";
							}
							//收券规则
							if(ele.couponRule=="[object Object]"||ele.couponRule==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.couponRule+"</td>";
							}
							//收券规则描述
							if(ele.couponRuleName=="[object Object]"||ele.couponRuleName==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.couponRuleName+"</td>";
							}
							//结余
							if(ele.cashBalance=="[object Object]"||ele.cashBalance==undefined){
								option11+="<td align='center'></td>";
							}else{
								option11+="<td align='center'>"+ele.cashBalance+"</td>";
							}
							//备注
							if(ele.remark=="[object Object]"||ele.remark==undefined){
								option11+="<td align='center'></td></tr>";
							}else{
								option11+="<td align='center'>"+ele.remark+"</td></tr>";
							}
						}
						option11 += "</table></div></td></tr>";
						$("#gradeY11" + obj).after(option11);
					}
				}
			});
		} else {
			$("#spanTd11_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTr11" + obj).remove();
		}
 	}
 	/* //查询发票信息
 	function spanTd12(obj) {
//		if ($("#spanTd12_"+obj).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#spanTd12_"+obj).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/oms/selectInvoiceList",
				async : false,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass(
								"loading-inactive");
					}, 300);
				},
				data : {"saleNo" : obj},
				success : function(response) {
					if(response.success=='true'){
						var result = response.list;
						var option3 = "<tr id='afterTr12"+obj+"'><td></td><td colspan='5'><div style='padding:2px;width: 200%;'>"
								+ "<table class='table table-bordered table-striped table-condensed table-hover flip-content' ><tr role='row'>";
								option3 += "<th width='5%' style='text-align: center;'>销售单单号</th>"+
								"<th width='5%' style='text-align: center;'>发票编号</th>"+
								"<th width='5%' style='text-align: center;'>发票金额</th>"+
								"<th width='5%' style='text-align: center;'>发票抬头</th>"+
								"<th width='5%' style='text-align: center;'>发票明细</th>"+
								"<th width='5%' style='text-align: center;'>发票状态</th></tr>";
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							//销售单单号
							if(ele.saleNo=="[object Object]"||ele.saleNo==undefined){
								option3+="<td align='center'></td>";
							}else{
								option3+="<td align='center'>"+ele.saleNo+"</td>";
							}
							//发票编号
							if(ele.invoiceNo=="[object Object]"||ele.invoiceNo==undefined){
								option3+="<td align='center'></td>";
							}else{
								option3+="<td align='center'>"+ele.invoiceNo+"</td>";
							}
							//发票金额
							if(ele.invoiceAmount=="[object Object]"||ele.invoiceAmount==undefined){
								option3+="<td align='center'></td>";
							}else{
								option3+="<td align='center'>"+ele.invoiceAmount+"</td>";
							}
							//发票抬头
							if(ele.invoiceTitle=="[object Object]"||ele.invoiceTitle==undefined){
								option3+="<td align='center'></td>";
							}else{
								option3+="<td align='center'>"+ele.invoiceTitle+"</td>";
							}
							//发票明细
							if(ele.invoiceDetail=="[object Object]"||ele.invoiceDetail==undefined){
								option3+="<td align='center'></td>";
							}else{
								option3+="<td align='center'>"+ele.invoiceDetail+"</td>";
							}
							//发票状态
							if(ele.invoiceStatus=="[object Object]"||ele.invoiceStatus==undefined){
								option3+="<td align='center'></td></tr>";
							}else if(ele.invoiceStatus=='0'){
								option3+="<td align='center'>"+'有效'+"</td></tr>";
							}else if(ele.invoiceStatus=='1'){
								option3+="<td align='center'>"+'无效'+"</td></tr>";
							}
							option3 += "</table></div></td></tr>";
							$("#gradeY12" + obj).after(option3);
						}
					}
				}
			});
		} else {
			$("#spanTd12_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTr12" + obj).remove();
		}
		
	} */
	//查询销售单明细(挂在销售单下)
 	function spanTd12(obj) {
		if ($("#spanTd12_"+obj).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#spanTd12_"+obj).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/oms/selectSaleItemList",
				async : false,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass(
								"loading-inactive");
					}, 300);
				},
				data : {"saleNo" : obj},
				success : function(response) {
					if(response.success=='true'){
						var result = response.list;
						var option = "<tr id='afterTr12"+obj+"'><td></td><td colspan='5'><div style='padding:2px;width: 200%;'>"
								+ "<table class='table table-bordered table-striped table-condensed table-hover flip-content' ><tr role='row'>";
								
								option += "<th width='3%' style='text-align: center;'>行号</th>"+
								"<th width='5%' style='text-align: center;'>销售单号</th>"+
								"<th width='3%' style='text-align: center;'>商品行项目编号</th>"+
								"<th width='3%' style='text-align: center;'>订单号</th>"+
								"<th width='3%' style='text-align: center;'>SKU编号</th>"+
								"<th width='3%' style='text-align: center;'>SPU编号</th>"+
								"<th width='3%' style='text-align: center;'>专柜商品编号</th>"+
								"<th width='3%' style='text-align: center;'>专柜商品名称</th>"+
								"<th width='3%' style='text-align: center;'>ERP商品编号</th>"+
								"<th width='5%' style='text-align: center;'>供应商内部商品编号</th>"+
								"<th width='3%' style='text-align: center;'>商品单位</th>"+
								"<th width='3%' style='text-align: center;'>品牌名称</th>"+
								"<th width='3%' style='text-align: center;'>颜色名称</th>"+
								"<th width='3%' style='text-align: center;'>规格名称</th>"+
								"<th width='3%' style='text-align: center;'>标准价</th>"+
								"<th width='3%' style='text-align: center;'>销售价</th>"+
								"<th width='3%' style='text-align: center;'>销售数量</th>"+
								"<th width='3%' style='text-align: center;'>可退数量</th>"+
								"<th width='3%' style='text-align: center;'>管理分类编码</th>"+
								"<th width='3%' style='text-align: center;'>统计分类</th>"+
								"<th width='3%' style='text-align: center;'>销售金额</th>"+
								"<th width='3%' style='text-align: center;'>是否为赠品</th>"+
								"<th width='3%' style='text-align: center;'>运费分摊</th>"+
								"<th width='3%' style='text-align: center;'>缺货数量</th>"+
								"<th width='3%' style='text-align: center;'>提货数量</th>"+
								"<th width='3%' style='text-align: center;'>大中小类</th>"+
								"<th width='3%' style='text-align: center;'>商品类别</th>"+
								"<th width='3%' style='text-align: center;'>销项税</th>"+
								"<th width='3%' style='text-align: center;'>条形码</th></tr>";
								
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							//行号
							if(ele.rowNo=="[object Object]"||ele.rowNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.rowNo+"</td>";
							}
							//销售单号
							if(ele.saleNo=="[object Object]"||ele.saleNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.saleNo+"</td>";
							}
							//商品行项目编号
							if(ele.salesItemNo=="[object Object]"||ele.salesItemNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.salesItemNo+"</td>";
							}
							//订单号
							if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.orderNo+"</td>";
							}
							//sku编号
							if(ele.skuNo=="[object Object]"||ele.skuNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.skuNo+"</td>";
							}
							//spu编号
							if(ele.spuNo=="[object Object]"||ele.spuNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.spuNo+"</td>";
							}
							//专柜商品编号
							if(ele.supplyProductNo=="[object Object]"||ele.supplyProductNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.supplyProductNo+"</td>";
							}
							//专柜商品名称
							if(ele.shoppeProName=="[object Object]"||ele.shoppeProName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.shoppeProName+"</td>";
							}
							//ERP商品编号
							if(ele.erpProductNo=="[object Object]"||ele.erpProductNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.erpProductNo+"</td>";
							}
							//供应商内部商品编号
							if(ele.supplyInnerProdNo=="[object Object]"||ele.supplyInnerProdNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.supplyInnerProdNo+"</td>";
							}
							//商品单位
							if(ele.unit=="[object Object]"||ele.unit==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.unit+"</td>";
							}
							//品牌名称
							if(ele.brandName=="[object Object]"||ele.brandName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.brandName+"</td>";
							}
							//颜色名称
							if(ele.colorName=="[object Object]"||ele.colorName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.colorName+"</td>";
							}
							//规格名称
							if(ele.sizeName=="[object Object]"||ele.sizeName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.sizeName+"</td>";
							}
							//标准价
							if(ele.standPrice=="[object Object]"||ele.standPrice==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.standPrice+"</td>";
							}
							//销售价
							if(ele.salePrice=="[object Object]"||ele.salePrice==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.salePrice+"</td>";
							}
							//销售数量
							if(ele.saleSum=="[object Object]"||ele.saleSum==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.saleSum+"</td>";
							}
							//可退数量
							if(ele.refundNum=="[object Object]"||ele.refundNum==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.refundNum+"</td>";
							}
							//管理分类编码
							if(ele.managerCateNo=="[object Object]"||ele.managerCateNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.managerCateNo+"</td>";
							}
							//统计分类编码
							if(ele.statisticsCateNo=="[object Object]"||ele.statisticsCateNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.statisticsCateNo+"</td>";
							}
							//销售金额
							if(ele.paymentAmount=="[object Object]"||ele.paymentAmount==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.paymentAmount+"</td>";
							}
							
							if(ele.isGift=="0"){
								option+="<td align='center'><span>否</span></td>";
							}else if(ele.isGift=="1"){
								option+="<td align='center'><span>是</span></td>";
							}else{
								option+="<td align='center'></td>";
							}
							//运费分摊
							if(ele.shippingFeeSplit=="[object Object]"||ele.shippingFeeSplit==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.shippingFeeSplit+"</td>";
							}
							//缺货数量
							if(ele.stockoutAmount=="[object Object]"||ele.stockoutAmount==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.stockoutAmount+"</td>";
							}
							//提货数量
							if(ele.pickSum=="[object Object]"||ele.pickSum==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.pickSum+"</td>";
							}
							//大中小类
							if(ele.productClass=="[object Object]"||ele.productClass==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.productClass+"</td>";
							}
							//商品类别
							if(ele.productType=="[object Object]"||ele.productType==undefined){
								option+="<td align='center'></td>";
							}else if(ele.productType=="1"){
								option+="<td align='center'><span>普通商品</span></td>";
							}else if(ele.productType=="2"){
								option+="<td align='center'><span>赠品</span></td>";
							}else if(ele.productType=="3"){
								option+="<td align='center'><span>礼品</span></td>";
							}else if(ele.productType=="4"){
								option+="<td align='center'><span>虚拟商品</span></td>";
							}else if(ele.productType=="5"){
								option+="<td align='center'><span>服务类商品</span></td>";
							}else if(ele.productType=="01"){
								option+="<td align='center'><span>自营单品</span></td>";
							}else if(ele.productType=="05"){
								option+="<td align='center'><span>金银首饰</span></td>";
							}else if(ele.productType=="06"){
								option+="<td align='center'><span>服务费商品</span></td>";
							}else if(ele.productType=="07"){
								option+="<td align='center'><span>租赁商品</span></td>";
							}else if(ele.productType=="08"){
								option+="<td align='center'><span>联营单品</span></td>";
							}else if(ele.productType=="09"){
								option+="<td align='center'><span>组包码</span></td>";
							}
							
							//销项税
							if(ele.tax=="[object Object]"||ele.tax==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.tax+"</td>";
							}
							//条形码
							if(ele.barcode=="[object Object]"||ele.barcode==undefined){
								option+="<td align='center'></td></tr>";
							}else{
								option+="<td align='center'>"+ele.barcode+"</td></tr>";
							}
							/* //销售单单号
							if(ele.saleNo=="[object Object]"||ele.saleNo==undefined){
								option3+="<td align='center'></td>";
							}else{
								option3+="<td align='center'>"+ele.saleNo+"</td>";
							}
							//发票编号
							if(ele.invoiceNo=="[object Object]"||ele.invoiceNo==undefined){
								optoption3"<td align='center'></td>";
							}else{
								option3+="<td align='center'>"+ele.invoiceNo+"</td>";
							}
							//发票金额
							if(ele.invoiceAmount=="[object Object]"||ele.invoiceAmount==undefined){
								option3+="<td align='center'></td>";
							}else{
								option3+="<td align='center'>"+ele.invoiceAmount+"</td>";
							}
							//发票抬头
							if(ele.invoiceTitle=="[object Object]"||ele.invoiceTitle==undefined){
								option3+="<td align='center'></td>";
							}else{
								option3+="<td align='center'>"+ele.invoiceTitle+"</td>";
							}
							//发票明细
							if(ele.invoiceDetail=="[object Object]"||ele.invoiceDetail==undefined){
								option3+="<td align='center'></td>";
							}else{
								option3+="<td align='center'>"+ele.invoiceDetail+"</td>";
							}
							//发票状态
							if(ele.invoiceStatus=="[object Object]"||ele.invoiceStatus==undefined){
								option3+="<td align='center'></td></tr>";
							}else if(ele.invoiceStatus=='0'){
								option3+="<td align='center'>"+'有效'+"</td></tr>";
							}else if(ele.invoiceStatus=='1'){
								option3+="<td align='center'>"+'无效'+"</td></tr>";
							}*/
							}
						option += "</table></div></td></tr>";
						$("#gradeY12" + obj).after(option); 
					}
				}
			});
		} else {
			$("#spanTd12_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTr12" + obj).remove();
		}
		
 	}
	//点击tr事件
	function trClick(orderNo,obj){
		if ($("#orderNo_"+orderNo).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#orderNo_"+orderNo).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
			 var newTr =  $(obj).clone(true);
			 newTr.removeAttr("onclick").removeClass("trClick");
			 $("#mainTr").html(newTr);
			$(obj).addClass("trClick").siblings().removeClass("trClick");
			
			var option = "<tr role='row' style='height:35px;'>"+
			"<th width='2%' style='text-align: center;'>行号</th>"+
			"<th width='2%' style='text-align: center;'>专柜商品编号</th>"+
			"<th width='3%' style='text-align: center;'>商品名称</th>"+
			"<th width='2%' style='text-align: center;'>标准价</th>"+
			"<th width='2%' style='text-align: center;'>销售价</th>"+
			"<th width='2%' style='text-align: center;'>销售数量</th>"+
			"<th width='2%' style='text-align: center;'>是否为赠品</th>"+
			"<th width='2%' style='text-align: center;'>发票金额</th>"+
			"<th width='2%' style='text-align: center;'>允许退货数量</th>"+
			"<th width='2%' style='text-align: center;'>缺货数量</th>"+
			"<th width='3%' style='text-align: center;'>订单单号</th>"+
			"<th width='3%' style='text-align: center;'>订单明细编号</th>"+
			"<th width='3%' style='text-align: center;'>专柜名称</th>"+
			"<th width='3%' style='text-align: center;'>门店名称</th>"+
			"<th width='3%' style='text-align: center;'>供应商名称</th>"+
			"<th width='3%' style='text-align: center;'>供应商内部商品编码</th>"+
			"<th width='2%' style='text-align: center;'>ERP商品编码</th>"+
			"<th width='2%' style='text-align: center;'>商品单位</th>"+
			"<th width='2%' style='text-align: center;'>品牌名称</th>"+
			"<th width='2%' style='text-align: center;'>spu编号</th>"+
			"<th width='2%' style='text-align: center;'>sku编号</th>"+
			"<th width='2%' style='text-align: center;'>颜色</th>"+
			"<th width='2%' style='text-align: center;'>规格</th>"+
			"<th width='2%' style='text-align: center;'>价格类型</th>"+
			"<th width='2%' style='text-align: center;'>退货数量</th>"+
			"<th width='2%' style='text-align: center;'>提货数量</th>"+
			"<th width='2%' style='text-align: center;'>商品折后总额</th>"+
			"<th width='2%' style='text-align: center;'>物流属性</th>"+
			"<th width='2%' style='text-align: center;'>商品描述</th>"+
			"<th width='2%' style='text-align: center;'>商品图片地址</th>"+
			"<th width='2%' style='text-align: center;'>经营方式</th>"+
			"<th width='2%' style='text-align: center;'>虚库类型</th>"+
			"<th width='2%' style='text-align: center;'>运费分摊金额</th>"+
			"<th width='2%' style='text-align: center;'>实际运费分摊</th>"+
			"<th width='2%' style='text-align: center;'>是否已评论</th>"+
			"<th width='2%' style='text-align: center;'>统计分类</th>"+
			"<th width='2%' style='text-align: center;'>管理分类</th>"+
			"<th width='2%' style='text-align: center;'>收银损益</th>"+
			"<th width='2%' style='text-align: center;'>出库商品编号</th>"+
			"<th width='2%' style='text-align: center;'>条形码</th>"+
			"<th width='2%' style='text-align: center;'>创建时间</th>"+
			"<th width='2%' style='text-align: center;'>操作</th></tr>";
			$.ajax({
				type:"post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url:__ctxPath + "/omsOrder/selectOrderItemList",
				async:false,
				dataType: "json",
				data:{"orderNo":orderNo},
				success:function(response) {
					if(response.success=='true'){
						var result = response.list;
						for(var i=0;i<result.length;i++){
							var ele = result[i];
							//行号
							if(ele.rowNo=="[object Object]"||ele.rowNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.rowNo+"</td>";
							}
							//专柜商品编号
							if(ele.supplyProductNo=="[object Object]"||ele.supplyProductNo==undefined){
								option+="<td id='supplyProductNo_"+ele.orderItemNo+"' align='center'></td>";
							}else{
								option+="<td id='supplyProductNo_"+ele.orderItemNo+"' align='center'>"+ele.supplyProductNo+"</td>";
							}
							//商品名称
							if(ele.shoppeProName=="[object Object]"||ele.shoppeProName==undefined){
								option+="<td id='shoppeProName_"+ele.orderItemNo+"' align='center'></td>";
							}else{
								option+="<td id='shoppeProName_"+ele.orderItemNo+"' align='center'>"+ele.shoppeProName+"</td>";
							}
							//标准价
							if(ele.standPrice=="[object Object]"||ele.standPrice==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.standPrice+"</td>";
							}
							//销售价
							if(ele.salesPrice=="[object Object]"||ele.salesPrice==undefined){
								option+="<td id='salesPrice_"+ele.orderItemNo+"' align='center'></td>";
							}else{
								option+="<td id='salesPrice_"+ele.orderItemNo+"' align='center'>"+ele.salesPrice+"</td>";
							}
							//销售数量
							if(ele.saleSum=="[object Object]"||ele.saleSum==undefined){
								option+="<td id='saleSum_"+ele.orderItemNo+"' align='center'></td>";
							}else{
								option+="<td id='saleSum_"+ele.orderItemNo+"' align='center'>"+ele.saleSum+"</td>";
							}
							//是否为赠品
							if(ele.isGift=="0"){
								option+="<td align='center'><span>否</span></td>";
							}else if(ele.isGift=="1"){
								option+="<td align='center'><span>是</span></td>";
							}else{
								option+="<td align='center'></td>";
							}
							//发票金额
							if(ele.invoiceAmount=="[object Object]"||ele.invoiceAmount==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.invoiceAmount+"</td>";
							}
							//允许退货数量
							if(ele.allowRefundNum=="[object Object]"||ele.allowRefundNum==undefined){
								option+="<td id='allowRefundNum_"+ele.orderItemNo+"' align='center'>0</td>";
							}else{
								option+="<td id='allowRefundNum_"+ele.orderItemNo+"' align='center'>"+ele.allowRefundNum+"</td>";
							}
							//缺货数量
							if(ele.stockoutAmount=="[object Object]"||ele.stockoutAmount==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.stockoutAmount+"</td>";
							}
							//订单号
							if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.orderNo+"</td>";
							}
							//订单明细号
							if(ele.orderItemNo=="[object Object]"||ele.orderItemNo==undefined){
								option+="<td id='orderItemNo' align='center'></td>";
							}else{
								option+="<td id='orderItemNo' align='center'>"+ele.orderItemNo+"</td>";
							}
							
							//专柜名称
							if(ele.shoppeName=="[object Object]"||ele.shoppeName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.shoppeName+"</td>";
							}
							//门店名称
							if(ele.storeName=="[object Object]"||ele.storeName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.storeName+"</td>";
							}
							//供应商名称
							if(ele.suppllyName=="[object Object]"||ele.suppllyName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.suppllyName+"</td>";
							}
							//供应商内部商品编号
							if(ele.supplyInnerProdNo=="[object Object]"||ele.supplyInnerProdNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.supplyInnerProdNo+"</td>";
							}
							//ERP商品编号
							if(ele.erpProductCode=="[object Object]"||ele.erpProductCode==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.erpProductCode+"</td>";
							}
							//商品单位
							if(ele.unit=="[object Object]"||ele.unit==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.unit+"</td>";
							}
							//品牌名称
							if(ele.brandName=="[object Object]"||ele.brandName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.brandName+"</td>";
							}
							//spu编号
							if(ele.spuNo=="[object Object]"||ele.spuNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.spuNo+"</td>";
							}
							//sku编号
							if(ele.skuNo=="[object Object]"||ele.skuNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.skuNo+"</td>";
							}
							//颜色
							if(ele.colorName=="[object Object]"||ele.colorName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.colorName+"</td>";
							}
							//规格
							if(ele.sizeName=="[object Object]"||ele.sizeName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.sizeName+"</td>";
							}
							//价格类型
							if(ele.priceType=="[object Object]"||ele.priceType==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.priceType+"</td>";
							}
							//退货数量
							if(ele.refundNum=="[object Object]"||ele.refundNum==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.refundNum+"</td>";
							}
							//提货数量
							if(ele.pickSum=="[object Object]"||ele.pickSum==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.pickSum+"</td>";
							}
							//商品折后总额
							if(ele.paymentAmount=="[object Object]"||ele.paymentAmount==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.paymentAmount+"</td>";
							}
							//物流属性
							if(ele.shippingAttribute=="[object Object]"||ele.shippingAttribute==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.shippingAttribute+"</td>";
							}
							//商品描述
							if(ele.productName=="[object Object]"||ele.productName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.productName+"</td>";
							}
							//商品图片地址
							if(ele.url=="[object Object]"||ele.url==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.url+"</td>";
							}
							//经营方式
							if(ele.businessMode=="[object Object]"||ele.businessMode==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.businessMode+"</td>";
							}
							//虚库类型
							if(ele.warehouseType=="[object Object]"||ele.warehouseType==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.warehouseType+"</td>";
							}
							//运费分摊金额
							if(ele.shippingFeeSplit=="[object Object]"||ele.shippingFeeSplit==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.shippingFeeSplit+"</td>";
							}
							//实际运费分摊
							if(ele.deliveryShippingFeeSplit=="[object Object]"||ele.deliveryShippingFeeSplit==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.deliveryShippingFeeSplit+"</td>";
							}
							//是否已评论
							if(ele.hasRecommanded=="0"){
								option+="<td align='center'><span class='btn btn-warning btn-xs'>否</span></td>";
							}else if(ele.hasRecommanded=="1"){
								option+="<td align='center'><span class='btn btn-success btn-xs'>是</span></td>";
							}else{
								option+="<td align='center'></td>";
							}
							//统计分类
							if(ele.statisticsCateNo=="[object Object]"||ele.statisticsCateNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.statisticsCateNo+"</td>";
							}
							//管理分类
							if(ele.mangerCateNo=="[object Object]"||ele.mangerCateNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.mangerCateNo+"</td>";
							}
							//收银损益
							if(ele.cashIncomeFlag=="0"){
								option+="<td align='center'><span class='btn btn-warning btn-xs'>在商品上</span></td>";
							}else if(ele.cashIncomeFlag=="1"){
								option+="<td align='center'><span class='btn btn-success btn-xs'>在运费上</span></td>";
							}else{
								option+="<td align='center'></td>";
							}
							//出库编号
							if(ele.productOnlySn=="[object Object]"||ele.productOnlySn==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.productOnlySn+"</td>";
							}
							//条形码
							if(ele.barcode=="[object Object]"||ele.barcode==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.barcode+"</td>";
							}
							//创建时间
							if(ele.createdTimeStr=="[object Object]"||ele.createdTimeStr==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.createdTimeStr+"</td>";
							}
							//操作
							option+="<td align='center'>"+
							'<input class="btn btn-success" style="width: 50%;height: 30px;" id="refundButten" onclick="refundButten('+"'"+ele.orderItemNo+"','"+ele.orderNo+"'"+',this)" type="button" value="退货" />'+
							"</td></tr>";
						}
					}
				}
			});
			$("#OLV1_tab").html(option);
			$("#divTitle").html("订单详情");
			$("#btDiv").show();
			orderNo_ = orderNo;
			
		}else {
			$("#orderNo_" + orderNo).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#btDiv").hide();
		}
	}
	
	function trClick2(orderNo,isCod,obj){
//		 var newTr1 = $(obj).removeAttr("onclick").removeClass("trClick");
//		 var newTr =  newTr1.parent().parent().clone(true);
		if(isCod=='0'){
			$("#ddsh").hide();
		}else{
			$("#ddsh").show();
		}
		 var newTr =  $(obj).parent().parent().clone(true);
		 newTr.children().children().removeAttr("onclick").removeClass("trClick");
		  newTr.find("td:eq(0)").hide();
		 $("#mainTr").html(newTr);
		$(obj).addClass("trClick").siblings().removeClass("trClick");
		
		var option = "<tr role='row' style='height:35px;'>"+
		"<th width='1%' style='text-align: center;'></th>"+
		"<th width='2%' style='text-align: center;'>行号</th>"+
		"<th width='3%' style='text-align: center;'>订单号</th>"+
		"<th width='3%' style='text-align: center;'>订单明细编号</th>"+
		"<th width='3%' style='text-align: center;'>商品名称</th>"+
		"<th width='3%' style='text-align: center;'>专柜名称</th>"+
		"<th width='3%' style='text-align: center;'>门店名称</th>"+
		"<th width='3%' style='text-align: center;'>供应商名称</th>"+
		"<th width='2%' style='text-align: center;'>专柜商品编号</th>"+
		"<th width='3%' style='text-align: center;'>供应商内部商品编码</th>"+
		"<th width='2%' style='text-align: center;'>ERP商品编码</th>"+
		"<th width='2%' style='text-align: center;'>商品单位</th>"+
		"<th width='2%' style='text-align: center;'>品牌名称</th>"+
		"<th width='2%' style='text-align: center;'>SPU编号</th>"+
		"<th width='2%' style='text-align: center;'>SKU编号</th>"+
		"<th width='2%' style='text-align: center;'>颜色</th>"+
		"<th width='2%' style='text-align: center;'>规格</th>"+
		"<th width='2%' style='text-align: center;'>标准价</th>"+
		"<th width='2%' style='text-align: center;'>销售价</th>"+
			"<th width='2%' style='text-align: center;'>销售数量</th>"+
		
		"<th width='3%' style='text-align: center;'>销售金额</th>"+
		"<th width='3%' style='text-align: center;'>促销优惠分摊金额</th>"+
		"<th width='3%' style='text-align: center;'>促销后销售金额</th>"+
		
		"<th width='2%' style='text-align: center;'>退货数量</th>"+
		"<th width='2%' style='text-align: center;'>允许退货数量</th>"+
		"<th width='2%' style='text-align: center;'>缺货数量</th>"+
		
		"<th width='2%' style='text-align: center;'>提货数量</th>"+
		/* "<th width='2%' style='text-align: center;'>商品折后总额</th>"+ */
		/* "<th width='2%' style='text-align: center;'>物流属性</th>"+
		"<th width='2%' style='text-align: center;'>商品描述</th>"+ */
		"<th width='2%' style='text-align: center;'>是否为赠品</th>"+
		"<th width='2%' style='text-align: center;'>商品图片地址</th>"+
		"<th width='2%' style='text-align: center;'>经营方式</th>"+
		/* "<th width='2%' style='text-align: center;'>虚库类型</th>"+ */
		"<th width='2%' style='text-align: center;'>运费分摊金额</th>"+
		/* "<th width='2%' style='text-align: center;'>实际运费分摊</th>"+
		"<th width='2%' style='text-align: center;'>发票金额</th>"+ */
		"<th width='2%' style='text-align: center;'>是否已评论</th>"+
		/* "<th width='2%' style='text-align: center;'>统计分类</th>"+
		"<th width='2%' style='text-align: center;'>管理分类</th>"+ */
		/* "<th width='2%' style='text-align: center;'>收银损益</th>"+ */
		/* "<th width='2%' style='text-align: center;'>出库商品编号</th>"+ */
		"<th width='2%' style='text-align: center;'>条形码</th>"+
		"<th width='2%' style='text-align: center;'>创建时间</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/selectOrderItemList",
			async:false,
			dataType: "json",
			data:{"orderNo":orderNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						option+="<tr id='gradeY"+ele.orderItemNo+"' style='height:35px;overflow-X:hidden;'>"+
						"<td align='center' style='vertical-align:middle;'>"+
						"<span id='spanTd_"+ele.orderItemNo+"' onclick='spanTd(\""+ele.orderItemNo+"\")' "+
						"class='expand-collapse click-expand glyphicon glyphicon-plus' style='cursor:pointer;'></span></td>";
						//行号
						if(ele.rowNo=="[object Object]"||ele.rowNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.rowNo+"</td>";
						}
						//订单号
						if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
							option+="<td align='center' id='shorderNo'></td>";
						}else{
							option+="<td align='center' id='shorderNo'>"+ele.orderNo+"</td>";
						}
						//订单明细号
						if(ele.orderItemNo=="[object Object]"||ele.orderItemNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.orderItemNo+"</td>";
						}
						//商品名称
						if(ele.shoppeProName=="[object Object]"||ele.shoppeProName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.shoppeProName+"</td>";
						}
						//专柜名称
						if(ele.shoppeName=="[object Object]"||ele.shoppeName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.shoppeName+"</td>";
						}
						//门店名称
						if(ele.storeName=="[object Object]"||ele.storeName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.storeName+"</td>";
						}
						//供应商名称
						if(ele.suppllyName=="[object Object]"||ele.suppllyName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.suppllyName+"</td>";
						}
						//专柜商品编号
						if(ele.supplyProductNo=="[object Object]"||ele.supplyProductNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.supplyProductNo+"</td>";
						}
						//供应商内部商品编号
						if(ele.supplyInnerProdNo=="[object Object]"||ele.supplyInnerProdNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.supplyInnerProdNo+"</td>";
						}
						//ERP商品编号
						if(ele.erpProductCode=="[object Object]"||ele.erpProductCode==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.erpProductCode+"</td>";
						}
						//商品单位
						if(ele.unit=="[object Object]"||ele.unit==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.unit+"</td>";
						}
						//品牌名称
						if(ele.brandName=="[object Object]"||ele.brandName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.brandName+"</td>";
						}
						//spu编号
						if(ele.spuNo=="[object Object]"||ele.spuNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.spuNo+"</td>";
						}
						//sku编号
						if(ele.skuNo=="[object Object]"||ele.skuNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.skuNo+"</td>";
						}
						//颜色
						if(ele.colorName=="[object Object]"||ele.colorName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.colorName+"</td>";
						}
						//规格
						if(ele.sizeName=="[object Object]"||ele.sizeName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.sizeName+"</td>";
						}
						//标准价
						if(ele.standPrice=="[object Object]"||ele.standPrice==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.standPrice+"</td>";
						}
						//销售价
						if(ele.salesPrice=="[object Object]"||ele.salesPrice==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.salesPrice+"</td>";
						}
						//销售数量
						if(ele.saleSum=="[object Object]"||ele.saleSum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleSum+"</td>";
						} 
						//销售金额（销售价*销售数量）
						if(ele.salesPrice=="[object Object]"||ele.salesPrice==undefined){
							option+="<td align='center'></td>";
						}else{
							var salePriceSum = ele.salesPrice*ele.saleSum;
							option+="<td align='center'>"+salePriceSum+"</td>";
						}
						//促销优惠分摊金额
						if(ele.totalDiscount=="[object Object]"||ele.totalDiscount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.totalDiscount+"</td>";
						}
						//促销后销售金额
						if(ele.paymentAmount=="[object Object]"||ele.paymentAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.paymentAmount+"</td>";
						}
						
						/* //价格类型
						if(ele.priceType=="[object Object]"||ele.priceType==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.priceType+"</td>";
						} */
						//退货数量
						if(ele.refundNum=="[object Object]"||ele.refundNum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundNum+"</td>";
						}
						//允许退货数量
						if(ele.allowRefundNum=="[object Object]"||ele.allowRefundNum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.allowRefundNum+"</td>";
						}
						//缺货数量
						if(ele.stockoutAmount=="[object Object]"||ele.stockoutAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.stockoutAmount+"</td>";
						}
						/* //销售数量
						if(ele.saleSum=="[object Object]"||ele.saleSum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleSum+"</td>";
						} */
						//提货数量
						if(ele.pickSum=="[object Object]"||ele.pickSum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.pickSum+"</td>";
						}
						/* //商品折后总额
						if(ele.paymentAmount=="[object Object]"||ele.paymentAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.paymentAmount+"</td>";
						} */
						/* //物流属性
						if(ele.shippingAttribute=="[object Object]"||ele.shippingAttribute==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.shippingAttribute+"</td>";
						}
						//商品描述
						if(ele.productName=="[object Object]"||ele.productName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.productName+"</td>";
						} */
						//是否为赠品
						if(ele.isGift=="0"){
							option+="<td align='center'><span>否</span></td>";
						}else if(ele.isGift=="1"){
							option+="<td align='center'><span>是</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						//商品图片地址
						if(ele.url=="[object Object]"||ele.url==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'><a onclick='urlClick("+'"'+ele.url+'"'+",this);' style='cursor:pointer;'> "+ele.url+"</a></td>";
						}
						//经营方式
						if(ele.businessMode=="[object Object]"||ele.businessMode==undefined){
							option+="<td align='center'></td>";
						}else if(ele.businessMode=="Z001"){
							option+="<td align='center'><span>经销</span></td>";
						}else if(ele.businessMode=="Z002"){
							option+="<td align='center'><span>代销</span></td>";
						}else if(ele.businessMode=="Z003"){
							option+="<td align='center'><span>联营</span></td>";
						}else if(ele.businessMode=="Z004"){
							option+="<td align='center'><span>平台服务</span></td>";
						}else if(ele.businessMode=="Z005"){
							option+="<td align='center'><span>租赁</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						/* //虚库类型
						if(ele.warehouseType=="[object Object]"||ele.warehouseType==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.warehouseType+"</td>";
						} */
						//运费分摊金额
						if(ele.shippingFeeSplit=="[object Object]"||ele.shippingFeeSplit==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.shippingFeeSplit+"</td>";
						}
						/* //实际运费分摊
						if(ele.deliveryShippingFeeSplit=="[object Object]"||ele.deliveryShippingFeeSplit==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.deliveryShippingFeeSplit+"</td>";
						}
						//发票金额
						if(ele.invoiceAmount=="[object Object]"||ele.invoiceAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.invoiceAmount+"</td>";
						} */
						//是否已评论
						if(ele.hasRecommanded=="0"){
							option+="<td align='center'><span>否</span></td>";
						}else if(ele.hasRecommanded=="1"){
							option+="<td align='center'><span>是</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						/* //统计分类
						if(ele.statisticsCateNo=="[object Object]"||ele.statisticsCateNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.statisticsCateNo+"</td>";
						}
						//管理分类
						if(ele.mangerCateNo=="[object Object]"||ele.mangerCateNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.mangerCateNo+"</td>";
						} */
						/* //收银损益
						if(ele.cashIncomeFlag=="0"){
							option+="<td align='center'><span class='btn btn-warning btn-xs'>在商品上</span></td>";
						}else if(ele.cashIncomeFlag=="1"){
							option+="<td align='center'><span class='btn btn-success btn-xs'>在运费上</span></td>";
						}else{
							option+="<td align='center'></td>";
						} */
						/* //出库商品编号
						if(ele.productOnlySn=="[object Object]"||ele.productOnlySn==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.productOnlySn+"</td>";
						} */
						//条形码
						if(ele.barcode=="[object Object]"||ele.barcode==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.barcode+"</td>";
						}
						//创建时间
						if(ele.createdTimeStr=="[object Object]"||ele.createdTimeStr==undefined){
							option+="<td align='center'></td></tr>";
						}else{
							option+="<td align='center'>"+ele.createdTimeStr+"</td></tr>";
						}
					}
				}
			}
		});
		var option2 = "<tr role='row' style='height:35px;'>"+
		"<th width='1%' style='text-align: center;'></th>"+
		"<th width='4%' style='text-align: center;'>订单号</th>"+
		"<th width='3%' style='text-align: center;'>包裹单号</th>"+
		"<th width='3%' style='text-align: center;'>包裹状态</th>"+
		"<th width='3%' style='text-align: center;'>快递公司</th>"+
		"<th width='3%' style='text-align: center;'>快递公司编号</th>"+
		"<th width='3%' style='text-align: center;'>快递单号</th>"+
		"<th width='4%' style='text-align: center;'>发货时间</th>"+
		"<th width='3%' style='text-align: center;'>自提点编号</th>"+
		"<th width='3%' style='text-align: center;'>自提点名称</th>"+
		"<th width='4%' style='text-align: center;'>签收时间</th>"+
		"<th width='3%' style='text-align: center;'>签收人</th>"+
		"<th width='3%' style='text-align: center;'>退货地址</th>"+
		"<th width='4%' style='text-align: center;'>创建时间</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/selectPackage",
			async:false,
			dataType: "json",
			data:{"orderNo":orderNo,
				"isRefund":"0"},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						option2+="<tr id='gradeY1"+ele.packageNo+"' style='height:35px;overflow-X:hidden;'>"+
						"<td align='center' style='vertical-align:middle;'>"+
						"<span id='spanTd1_"+ele.packageNo+"' onclick='spanTd1(\""+ele.packageNo+"\")' "+
						"class='expand-collapse click-expand glyphicon glyphicon-plus' style='cursor:pointer;'></span></td>";
						//款机流水号
						if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.orderNo+"</td>";
						}
						//包裹单号
						if(ele.packageNo=="[object Object]"||ele.packageNo==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.packageNo+"</td>";
						}
						//包裹状态
						if(ele.packageStatusDesc=="[object Object]"||ele.packageStatusDesc==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.packageStatusDesc+"</td>";
						}
						//快递公司
						if(ele.delComName=="[object Object]"||ele.delComName==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.delComName+"</td>";
						}
						//快递公司编号
						if(ele.delComNo=="[object Object]"||ele.delComNo==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.delComNo+"</td>";
						}
						//快递单号
						if(ele.deliveryNo=="[object Object]"||ele.deliveryNo==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.deliveryNo+"</td>";
						}
						//发货时间
						if(ele.sendTimeStr=="[object Object]"||ele.sendTimeStr==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.sendTimeStr+"</td>";
						}
						//自提点编号
						if(ele.extPlaceNo=="[object Object]"||ele.extPlaceNo==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.extPlaceNo+"</td>";
						}
						//自提点名称
						if(ele.extPlaceName=="[object Object]"||ele.extPlaceName==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.extPlaceName+"</td>";
						}
						//签收时间
						if(ele.signTimeStr=="[object Object]"||ele.signTimeStr==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.signTimeStr+"</td>";
						}
						//签收人
						if(ele.signName=="[object Object]"||ele.signName==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.signName+"</td>";
						}
						//退货地址
						if(ele.refundAddress=="[object Object]"||ele.refundAddress==undefined){
							option2+="<td align='center'></td>";
						}else{
							option2+="<td align='center'>"+ele.refundAddress+"</td>";
						}
						//创建时间
						if(ele.createTimeStr=="[object Object]"||ele.createTimeStr==undefined){
							option2+="<td align='center'></td></tr>";
						}else{
							option2+="<td align='center'>"+ele.createTimeStr+"</td></tr>";
						}
					}
				}
			}
		});
		//支付
		var option3 = "<tr role='row' style='height:35px;'>"+
		"<th width='1%' style='text-align: center;'></th>"+
		"<th width='4%' style='text-align: center;'>款机流水号</th>"+
		"<th width='3%' style='text-align: center;'>总金额</th>"+
		"<th width='3%' style='text-align: center;'>交易流水号</th>"+
		"<th width='3%' style='text-align: center;'>线上线下标识</th>"+
		"<th width='4%' style='text-align: center;'>支付时间</th>"+
		"<th width='3%' style='text-align: center;'>收银员号</th>"+
		"<th width='3%' style='text-align: center;'>订单号</th>"+
		"<th width='3%' style='text-align: center;'>作废标记</th></tr>";
		
		/* "<th width='3%' style='text-align: center;'>实际支付</th>"+
		"<th width='3%' style='text-align: center;'>找零</th>"+
		"<th width='3%' style='text-align: center;'>折扣额</th>"+
		"<th width='3%' style='text-align: center;'>折让额</th>"+
		"<th width='3%' style='text-align: center;'>会员总折扣</th>"+
		"<th width='3%' style='text-align: center;'>优惠折扣额</th>"+
		"<th width='3%' style='text-align: center;'>收银损益</th>"+
		"<th width='3%' style='text-align: center;'>班次</th>"+
		"<th width='3%' style='text-align: center;'>渠道标志</th>"+
		"<th width='3%' style='text-align: center;'>金卡</th>"+
		"<th width='5%' style='text-align: center;'>微信卡门店号</th>"+
		"<th width='4%' style='text-align: center;'>会员卡号</th>"+
		"<th width='4%' style='text-align: center;'>订单号</th>"+
		"<th width='3%' style='text-align: center;'>授权卡号</th>"+
		"<th width='3%' style='text-align: center;'>人民币</th>"+
		"<th width='3%' style='text-align: center;'>电子返券</th>"+
		"<th width='3%' style='text-align: center;'>电子扣回</th>"+
		"<th width='3%' style='text-align: center;'>银行手续费</th>"+
		"<th width='3%' style='text-align: center;'>来源</th>"+
		"<th width='3%' style='text-align: center;'>状态</th>"+
		"<th width='3%' style='text-align: center;'>门店号</th></tr>"; */
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/selectPaymentList",
			async:false,
			dataType: "json",
			data:{"orderNo":orderNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						option3+="<tr id='gradeY11"+ele.salesPaymentNo+"' style='height:35px;overflow-X:hidden;'>"+
						"<td align='center' style='vertical-align:middle;'>"+
						"<span id='spanTd11_"+ele.salesPaymentNo+"' onclick='spanTd11(\""+ele.salesPaymentNo+"\")' "+
						"class='expand-collapse click-expand glyphicon glyphicon-plus' style='cursor:pointer;'></span></td>";
						//款机流水号
						if(ele.salesPaymentNo=="[object Object]"||ele.salesPaymentNo==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.salesPaymentNo+"</td>";
						}
						//总金额
						if(ele.money=="[object Object]"||ele.money==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.money+"</td>";
						}
						//交易流水号
						if(ele.payFlowNo=="[object Object]"||ele.payFlowNo==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.payFlowNo+"</td>";
						}
						//线上线下标识
						if(ele.ooFlag=="1"){
							option3+="<td align='center'><span>线上</span></td>";
						}else if(ele.ooFlag=="2"){
							option3+="<td align='center'><span>线下</span></td>";
						}else{
							option3+="<td align='center'></td>";
						}
						//支付时间
						if(ele.payTimeStr=="[object Object]"||ele.payTimeStr==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.payTimeStr+"</td>";
						}
						//收银员号
						if(ele.casher=="[object Object]"||ele.casher==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.casher+"</td>";
						}
						//订单号
						if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.orderNo+"</td>";
						}
						//作废标记
						if(ele.deleteFlag=="[object Object]"||ele.deleteFlag==undefined){
							option3+="<td align='center'></td></tr>";
						}else if(ele.deleteFlag=='0'){
//							option3+="<td align='center'>"+ele.deleteFlag+"</td>";
							option3+="<td align='center'>"+'有效'+"</td></tr>";
						}else if(ele.deleteFlag=='1'){
							option3+="<td align='center'>"+'无效'+"</td></tr>";
						}
						/* //总折扣
						if(ele.totalDiscountAmount=="[object Object]"||ele.totalDiscountAmount==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.totalDiscountAmount+"</td>";
						}
						//总应收
						if(ele.paymentAmount=="[object Object]"||ele.paymentAmount==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.paymentAmount+"</td>";
						}
						//实际支付
						if(ele.actualPaymentAmount=="[object Object]"||ele.actualPaymentAmount==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.actualPaymentAmount+"</td>";
						}
						//找零
						if(ele.changeAmount=="[object Object]"||ele.changeAmount==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.changeAmount+"</td>";
						}
						//折扣额
						if(ele.tempDiscountAmount=="[object Object]"||ele.tempDiscountAmount==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.tempDiscountAmount+"</td>";
						}
						//折让额
						if(ele.zrAmount=="[object Object]"||ele.zrAmount==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.zrAmount+"</td>";
						}
						//会员总折扣
						if(ele.memberDiscountAmount=="[object Object]"||ele.memberDiscountAmount==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.memberDiscountAmount+"</td>";
						}
						//优惠折扣额
						if(ele.promDiscountAmount=="[object Object]"||ele.promDiscountAmount==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.promDiscountAmount+"</td>";
						}
						//收银损益
						if(ele.income=="[object Object]"||ele.income==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.income+"</td>";
						}
						//班次（早  中 晚  全班）
						if(ele.shifts=="[object Object]"||ele.shifts==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.shifts+"</td>";
						}
						//渠道标志（M）
						if(ele.channel=="[object Object]"||ele.channel==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.channel+"</td>";
						}
						//刷微信卡时的微信卡类型(金卡)
						if(ele.weixinCard=="[object Object]"||ele.weixinCard==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.weixinCard+"</td>";
						}
						//微信卡门店号(扫二维码时其中的5位门店号)
						if(ele.weixinStoreNo=="[object Object]"||ele.weixinStoreNo==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.weixinStoreNo+"</td>";
						}
						//会员卡号
						if(ele.memberNo=="[object Object]"||ele.memberNo==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.memberNo+"</td>";
						}
						//线上订单号
						if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.orderNo+"</td>";
						}
						//授权卡号
						if(ele.authorizationNo=="[object Object]"||ele.authorizationNo==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.authorizationNo+"</td>";
						}
						//人民币
						if(ele.rmb=="[object Object]"||ele.rmb==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.rmb+"</td>";
						}
						//电子返券
						if(ele.elecGet=="[object Object]"||ele.elecGet==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.elecGet+"</td>";
						}
						//电子扣回
						if(ele.elecDeducation=="[object Object]"||ele.elecDeducation==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.elecDeducation+"</td>";
						}
						//银行手续费
						if(ele.bankServiceCharge=="[object Object]"||ele.bankServiceCharge==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.bankServiceCharge+"</td>";
						}
						//来源
						if(ele.sourceType=="[object Object]"||ele.sourceType==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.sourceType+"</td>";
						}
						//状态
						if(ele.status=="[object Object]"||ele.status==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.status+"</td>";
						}
						//门店号
						if(ele.shopNo=="[object Object]"||ele.shopNo==undefined){
							option3+="<td align='center'></td></tr>";
						}else{
							option3+="<td align='center'>"+ele.shopNo+"</td></tr>";
						} */
						
					}
				}
			}
		});
		var option4 = "<tr role='row' style='height:35px;'>"+
		"<th width='5%' style='text-align: center;'>订单号</th>"+
		"<th width='5%' style='text-align: center;'>修改前状态</th>"+
		"<th width='5%' style='text-align: center;'>修改后状态</th>"+
		"<th width='5%' style='text-align: center;'>修改人</th>"+
		"<th width='5%' style='text-align: center;'>系统来源</th>"+
		"<th width='5%' style='text-align: center;'>修改时间</th>"+
		"<th width='5%' style='text-align: center;'>备注</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/selectOrderHistory",
			async:false,
			dataType: "json",
			data:{"orderNo":orderNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						//销售单单号
						if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
							option4+="<tr style='height:35px;overflow-X:hidden;'><td align='center'></td>";
						}else{
							option4+="<tr style='height:35px;overflow-X:hidden;'><td align='center'>"+ele.orderNo+"</td>";
						}
						//修改前状态
						if(ele.priviousStatus=="9101"){
							option4+="<td align='center'>待支付</td>";
						}else if(ele.priviousStatus=="9102"){
							option4+="<td align='center'>已支付</td>";
						}else if(ele.priviousStatus=="9103"){
							option4+="<td align='center'>备货中</td>";
						}else if(ele.priviousStatus=="9104"){
							option4+="<td align='center'>已发货</td>";
						}else if(ele.priviousStatus=="9105"){
							option4+="<td align='center'>待自提</td>";
						}else if(ele.priviousStatus=="9106"){
							option4+="<td align='center'>已提货</td>";
						}else if(ele.priviousStatus=="9107"){
							option4+="<td align='center'>已收货</td>";
						}else if(ele.priviousStatus=="9108"){
							option4+="<td align='center'>已完成</td>";
						}else if(ele.priviousStatus=="9201"){
							option4+="<td align='center'>待审核</td>";
						}else if(ele.priviousStatus=="9202"){
							option4+="<td align='center'>已审核</td>";
						}else if(ele.priviousStatus=="9203"){
							option4+="<td align='center'>审核不通过</td>";
						}else if(ele.priviousStatus=="9301"){
							option4+="<td align='center'>订单作废</td>";
						}else if(ele.priviousStatus=="9302"){
							option4+="<td align='center'>拒收</td>";
						}else if(ele.priviousStatus=="9303"){
							option4+="<td align='center'>订单取消中</td>";
						}else if(ele.priviousStatus=="9304"){
							option4+="<td align='center'>取消成功</td>";
						}else if(ele.priviousStatus=="9305"){
							option4+="<td align='center'>取消失败</td>";
						}else if(ele.priviousStatus=="2015"){
							option4+="<td align='center'>已锁定,未支付</td>";
						}else{
							option4+="<td align='center'></td>";
						}
						//修改后状态
						if(ele.currentStatusDesc=="[object Object]"||ele.currentStatusDesc==undefined){
							option4+="<td align='center'></td>";
						}else{
							option4+="<td align='center'>"+ele.currentStatusDesc+"</td>";
						}
						//修改人
						if(ele.updateMan=="[object Object]"||ele.updateMan==undefined){
							option4+="<td align='center'></td>";
						}else{
							option4+="<td align='center'>"+ele.updateMan+"</td>";
						}
						//系统来源
						if(ele.operatorSource=="[object Object]"||ele.operatorSource==undefined){
							option4+="<td align='center'></td>";
						}else{
							option4+="<td align='center'>"+ele.operatorSource+"</td>";
						}
						//修改时间
						if(ele.updateTimeStr=="[object Object]"||ele.updateTimeStr==undefined){
							option4+="<td align='center'></td>";
						}else{
							option4+="<td align='center'>"+ele.updateTimeStr+"</td>";
						}
						//备注
						if(ele.remark=="[object Object]"||ele.remark==undefined){
							option4+="<td align='center'></td></tr>";
						}else{
							option4+="<td align='center'>"+ele.remark+"</td></tr>";
						}
					}
				}
			}
		});
		//销售单信息
		var option5 = "<tr role='row' style='height:35px;'>"+
		"<th width='1%' style='text-align: center;'></th>"+
		"<th width='6%' style='text-align: center;'>销售单号</th>"+
		"<th width='6%' style='text-align: center;'>订单号</th>"+
		"<th width='6%' style='text-align: center;'>CID</th>"+
		"<th width='5%' style='text-align: center;'>会员卡号</th>"+
		"<th width='4%' style='text-align: center;'>销售单状态</th>"+
		"<th width='4%' style='text-align: center;'>销售类别</th>"+
		"<th width='4%' style='text-align: center;'>销售单来源</th>"+
		"<th width='4%' style='text-align: center;'>支付状态</th>"+
		"<th width='4%' style='text-align: center;'>门店名称</th>"+
		"<th width='6%' style='text-align: center;'>供应商名称</th>"+
		"<th width='4%' style='text-align: center;'>专柜名称</th>"+
		"<th width='4%' style='text-align: center;'>销售类型</th>"+
		"<th width='4%' style='text-align: center;'>总金额</th>"+
		"<th width='4%' style='text-align: center;'>应付金额</th>"+
		"<th width='4%' style='text-align: center;'>优惠金额</th>"+
		"<th width='4%' style='text-align: center;'>收银损益</th>"+
		"<th width='4%' style='text-align: center;'>授权卡号</th>"+
		"<th width='4%' style='text-align: center;'>二维码</th>"+
		"<th width='4%' style='text-align: center;'>导购号</th>"+
		"<th width='4%' style='text-align: center;'>机器号</th>"+
		"<th width='6%' style='text-align: center;'>销售时间</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/selectSaleByOrderNo",
			async:false,
			dataType: "json",
			data:{"orderNo":orderNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						option5+="<tr id='gradeY12"+ele.saleNo+"' style='height:35px;overflow-X:hidden;'>"+
						"<td align='center' style='vertical-align:middle;'>"+
						"<span id='spanTd12_"+ele.saleNo+"' onclick='spanTd12(\""+ele.saleNo+"\")' "+
						"class='expand-collapse click-expand glyphicon glyphicon-plus' style='cursor:pointer;'></span></td>";
						//销售单号
						if(ele.saleNo=="[object Object]"||ele.saleNo==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.saleNo+"</td>";
						}
						//订单号
						if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.orderNo+"</td>";
						}
						//CID
						if(ele.accountNo=="[object Object]"||ele.accountNo==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.accountNo+"</td>";
						}
						//会员卡号
						if(ele.memberNo=="[object Object]"||ele.memberNo==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.memberNo+"</td>";
						}
						//销售单状态
						if(ele.saleStatusDesc=="[object Object]"||ele.saleStatusDesc==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.saleStatusDesc+"</td>";
						}
						//销售类别
						if(ele.saleType=="1"){
							option5+="<td align='center'>正常销售单</td>";
						}else if(ele.saleType=="2"){
							option5+="<td align='center'><span class='btn btn-xs'>大码销售单</span></td>";
						}else{
							option5+="<td align='center'></td>";
						}
						//销售单来源
						if(ele.saleSource=="C1"){
							option5+="<td align='center'><span>线上 C1</span></td>";
						}else if(ele.saleSource=="X1"){
							option5+="<td align='center'><span>线下 X1</span></td>";
						}else if(ele.saleSource=="CB"){
							option5+="<td align='center'><span>全球购</span></td>";
						}else if(ele.saleSource=="C7"){
							option5+="<td align='center'><span>天猫</span></td>";
						}else{
							option5+="<td align='center'></td>";
						}
						//支付状态
						if(ele.payStatus=="5001"){
							option5+="<td align='center'><span>未支付</span></td>";
						}else if(ele.payStatus=="5002"){
							option5+="<td align='center'><span>部分支付</span></td>";
						}else if(ele.payStatus=="5003"){
							option5+="<td align='center'><span>超时未支付</span></td>";
						}else if(ele.payStatus=="5004"){
							option5+="<td align='center'><span>已支付</span></td>";
						}else{
							option5+="<td align='center'></td>";
						}
						//门店名称
						if(ele.storeName=="[object Object]"||ele.storeName==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.storeName+"</td>";
						}
						//供应商名称
						if(ele.suppllyName=="[object Object]"||ele.suppllyName==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.suppllyName+"</td>";
						}
						//专柜名称
						if(ele.shoppeName=="[object Object]"||ele.shoppeName==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.shoppeName+"</td>";
						}
						//销售类型
						if(ele.saleClass=="1"){
							option5+="<td align='center'>销售单</td>";
						}else if(ele.saleClass=="2"){
							option5+="<td align='center'><span class='btn btn-xs'>换货换出单</span></td>";
						}else{
							option5+="<td align='center'></td>";
						}
						//总金额
						if(ele.saleAmount=="[object Object]"||ele.saleAmount==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.saleAmount+"</td>";
						}
						//应付金额
						if(ele.paymentAmount=="[object Object]"||ele.paymentAmount==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.paymentAmount+"</td>";
						}
						//优惠金额
						if(ele.discountAmount=="[object Object]"||ele.discountAmount==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.discountAmount+"</td>";
						}
						//收银损益
						if(ele.cashIncome=="[object Object]"||ele.cashIncome==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.cashIncome+"</td>";
						}
						//授权卡号
						if(ele.authorityCard=="[object Object]"||ele.cashIncome==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.authorityCard+"</td>";
						}
						//二维码
						if(ele.qrcode=="[object Object]"||ele.qrcode==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.qrcode+"</td>";
						}
						//导购号
						if(ele.employeeNo=="[object Object]"||ele.employeeNo==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.employeeNo+"</td>";
						}
						//机器号
						if(ele.casherNo=="[object Object]"||ele.casherNo==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.casherNo+"</td>";
						}
						//销售时间
						if(ele.saleTimeStr== "[object Object]"||ele.saleTimeStr==undefined){
							option5+="<td align='center'></td></tr>";
						}else{
							option5+="<td align='center'>"+ele.saleTimeStr+"</td></tr>";
						}
					}
				}
			}
		});
		//销售单发票
		var option6 = "<tr role='row' style='height:35px;'>"+
		"<th width='5%' style='text-align: center;'>销售单单号</th>"+
		"<th width='5%' style='text-align: center;'>发票编号</th>"+
		"<th width='5%' style='text-align: center;'>发票金额</th>"+
		"<th width='5%' style='text-align: center;'>发票抬头</th>"+
		"<th width='5%' style='text-align: center;'>发票明细</th>"+
		"<th width='5%' style='text-align: center;'>发票状态</th>"+
		"<th width='5%' style='text-align: center;'>发票时间</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/testOnlineOmsOrder/selectInvoiceList",
			async:false,
			dataType: "json",
			data:{"orderNo":orderNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						//销售单单号
						if(ele.saleNo=="[object Object]"||ele.saleNo==undefined){
							option6+="<tr style='height:35px;overflow-X:hidden;'><td align='center'></td>";
						}else{
							option6+="<tr style='height:35px;overflow-X:hidden;'><td align='center'>"+ele.saleNo+"</td>";
						}
						//发票编号
						if(ele.invoiceNo=="[object Object]"||ele.invoiceNo==undefined){
							option6+="<td align='center'></td>";
						}else{
							option6+="<td align='center'>"+ele.invoiceNo+"</td>";
						}
						//发票金额
						if(ele.invoiceAmount=="[object Object]"||ele.invoiceAmount==undefined){
							option6+="<td align='center'></td>";
						}else{
							option6+="<td align='center'>"+ele.invoiceAmount+"</td>";
						}
						//发票抬头
						if(ele.invoiceTitle=="[object Object]"||ele.invoiceTitle==undefined){
							option6+="<td align='center'></td>";
						}else{
							option6+="<td align='center'>"+ele.invoiceTitle+"</td>";
						}
						//发票明细
						if(ele.invoiceDetail=="[object Object]"||ele.invoiceDetail==undefined){
							option6+="<td align='center'></td>";
						}else{
							option6+="<td align='center'>"+ele.invoiceDetail+"</td>";
						}
						//发票状态
						if(ele.invoiceStatus=="[object Object]"||ele.invoiceStatus==undefined){
							option6+="<td align='center'></td>";
						}else if(ele.invoiceStatus=='0'){
							option6+="<td align='center'>"+'有效'+"</td>";
						}else if(ele.invoiceStatus=='1'){
							option6+="<td align='center'>"+'无效'+"</td>";
						}
						//发票时间
						if(ele.createdTimeStr=="[object Object]"||ele.createdTimeStr==undefined){
							option6+="<td align='center'></td>";
						}else{
							option6+="<td align='center'>"+ele.createdTimeStr+"</td>";
						}
					}
				}
			}
		});
		$("#OLV10_tab").html(option);
		$("#OLV2_tab").html(option2);
		$("#OLV3_tab").html(option3);
		$("#OLV4_tab").html(option4);
		$("#OLV5_tab").html(option5);
		$("#OLV6_tab").html(option6);
		$("#divTitle").html("订单详情");
		$("#btDiv11").show();
	}
	function closeBtDiv11(){
		$("#btDiv11").hide();
	}
	function closeBtDiv(){
		$("#btDiv").hide();
		
		$("[id*='orderNo_']").each(function(){
		    var ids = $(this).attr("class");
//		    alert(ids);
		    if (ids == "expand-collapse click-collapse glyphicon glyphicon-minus trClick") {
		    	$(this).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			}
		});
		
	}
	function closeBtDiv2(){
		$("#btDiv2").hide();
	}
	function refundButten(orderItemNo,orderNo,obj){
		salesPrice1= $("#salesPrice_"+orderItemNo).text().trim();
		orderItemNo_ = orderItemNo;
		shoppeProName1= $("#shoppeProName_"+orderItemNo).text().trim();
		supplyProductNo1= $("#supplyProductNo_"+orderItemNo).text().trim();
		saleSum1= $("#allowRefundNum_"+orderItemNo).text().trim();
		$("#sp1").text(shoppeProName1);
		$("#sp2").text(supplyProductNo1);
		$("#sp3").text(saleSum1);
		$("#btDiv2").show();
		$("#divTitle2").html("创建退货申请单");
		
		//查询订单明细
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/testOnlineOmsOrder/getOrderDetail",
			async : false,
			data : {
				"orderNo" : orderNo
			},
			dataType : "json",
			
			success : function(response) {
				if(response.success=='true'){
					//允许退货数量
					orderData = response.data[0].allowRefundNum;
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+"查询订单失败"+"</strong></div>");
 	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	}
	function trClickAdd(){
		saleSum2 = $("#sp3").text();
		if(saleSum1 > saleSum2){
			saleSum2++;
	//		saleSum2=parseInt(saleSum2)+1;
		}
		$("#sp3").text(saleSum2);
	}
	function trClickBdd(){
		var saleSum2 = $("#sp3").text()-1;
		if(saleSum2 > 0){
			$("#sp3").text(saleSum2);
		}else{
			$("#sp3").text("0");
		}
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
                                    <h5 class="widget-caption">已签收退货信息管理</h5>
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
                                    			<!-- <li class="col-md-4">
                                    				<label class="titname">销售时间：</label>
                                    				<input type="text" id="reservation" />
                                   				</li> -->
                                   				<li class="col-md-4">
                                    				<label class="titname">订单号：</label>
                                    				<input type="text" id="orderNo_input"/>
                                   				</li>
                                   				<li class="col-md-4">
                                   					<label class="titname">会员卡号：</label>
                                   					<input type="text" id="memberNo_input"/>
                                   				</li>
                                   				<li class="col-md-4">
                                   					<label class="titname">CID：</label>
                                   					<input type="text" id="accountNo_input"/>
                                   				</li>
                                    			<li class="col-md-4">
                                    					<label class="titname">订单状态：</label>
	                                    				<select id="orderStatus_select" style="padding:0 0;">
				                                			<option value="" selected="selected">所有</option>
				                                			<!-- <option value="9101">待支付</option>
				                                			<option value="9102">已支付</option>
				                                			<option value="9103">拣货中</option>
				                                			<option value="9104">已发货</option>
				                                			<option value="9105">待自提</option>
				                                			<option value="9106">已提货</option>
				                                			<option value="9107">已收货</option>
				                                			<option value="9108">已完成</option>
				                                			<option value="9201">待审核</option>
				                                			<option value="9202">已审核</option>
				                                			<option value="9203">审核不通过</option>
				                                			<option value="9301">订单作废</option>
				                                			<option value="9302">拒收</option>
				                                			<option value="9303">订单取消中</option>
				                                			<option value="9304">取消成功</option>
				                                			<option value="9305">取消失败</option> -->
				                                		</select>
                                    				</li>
                                    				<li class="col-md-4">
                                    					<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
														<a class="btn btn-default shiny" onclick="reset();">重置</a>
                                    					<!-- <a id="editabledatatable_new" onclick="olvQuery();" class="btn btn-yellow" style="width: 37%;">
	                                    		<i class="fa fa-eye"></i>
												查询
	                                        </a>
	                                        <a id="editabledatatable_new" onclick="reset();" class="btn btn-primary" style="width: 37%;">
	                                        	<i class="fa fa-random"></i>
												重置
	                                        </a> -->
                                    			</li>
                                    		</ul>
                                    	
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="10"/>
											<input type="hidden" id="orderNo_form" name="orderNo"/>
											<input type="hidden" id="orderStatus_form" name="orderStatus"/>
											<input type="hidden" id="memberNo_form" name="memberNo"/>
											<input type="hidden" id="accountNo_form" name="accountNo"/>
                                      	</form>
                                	<div style="width:100%; height:0%; min-height:300px; overflow-Y: hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 150%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                <th width="1%" style="text-align: center;">操作</th>
                                                <th width="2%" style="text-align: center;">订单号</th>
                                                <th width="2%" style="text-align: center;">CID</th>
                                                <th width="2%" style="text-align: center;">会员卡号</th>
                                                <th width="1%" style="text-align: center;">订单状态</th>
                                                <th width="1%" style="text-align: center;">商品销售总额 </th>
                                                <th width="1%" style="text-align: center;">应收运费 </th>
                                                <th width="2%" style="text-align: center;">销售时间</th>
                                                <th width="1%" style="text-align: center;">收件人姓名</th>
                                                <th width="2%" style="text-align: center;">收件人电话</th>
                                                <th width="5%" style="text-align: center;">收货地址</th>
                                                
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
												<tr class="gradeX" id="gradeX{$T.Result.sid}" style="height:35px;">
													<td align="center">
														<span id="orderNo_{$T.Result.orderNo}" class='expand-collapse click-expand glyphicon glyphicon-plus' style='cursor:pointer;' onclick="trClick('{$T.Result.orderNo}',this)"></span>
													</td>
													<td align="center" id="orderNo_{$T.Result.sid}">
						                   				<a onclick="trClick2('{$T.Result.orderNo}','{$T.Result.isCod}',this);" style="cursor:pointer;">
															{#if $T.Result.orderNo != '[object Object]'}{$T.Result.orderNo}
						                   					{#/if}
														</a>
													</td>
													<td align="center" id="accountNo_{$T.Result.sid}">
														{#if $T.Result.accountNo != '[object Object]'}{$T.Result.accountNo}
						                   				{#/if}
													</td>
													<td align="center" id="memberNo_{$T.Result.sid}">
														{#if $T.Result.memberNo != '[object Object]'}{$T.Result.memberNo}
						                   				{#/if}
													</td>
													<td align="center" id="orderStatusDesc_{$T.Result.sid}">
														{#if $T.Result.orderStatusDesc != '[object Object]'}{$T.Result.orderStatusDesc}
						                   				{#/if}
													</td>
													<td align="center" id="salesAmount_{$T.Result.sid}">
														{#if $T.Result.salesAmount != '[object Object]'}{$T.Result.salesAmount}
						                   				{#/if}
													</td>
													<td align="center" id="needSendCost_{$T.Result.sid}">
														{#if $T.Result.needSendCost != '[object Object]'}{$T.Result.needSendCost}
						                   				{#/if}
													</td>
													<td align="center" id="saleTimeStr_{$T.Result.sid}">
														{#if $T.Result.saleTimeStr != '[object Object]'}{$T.Result.saleTimeStr}
						                   				{#/if}
													</td>
													<td align="center" id="receptName_{$T.Result.sid}">
														{#if $T.Result.receptName != '[object Object]'}{$T.Result.receptName}
						                   				{#/if}
													</td>
													<td align="center" id="receptPhone_{$T.Result.sid}">
														{#if $T.Result.receptPhone != '[object Object]'}{$T.Result.receptPhone}
						                   				{#/if}
													</td>
													<td align="center" id="receptAddress_{$T.Result.sid}">
														{#if $T.Result.receptAddress != '[object Object]'}{$T.Result.receptAddress}
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
        <div class="modal-dialog" style="width: 800px;height:90%;margin: 14% 25% auto;">
            <div class="modal-content">
                <!-- <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv();">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div> -->
                    <div class="tabbable"> <!-- Only required for left/right tabs -->
					     <!--  <ul class="nav nav-tabs">
					        <li class="active"><a href="#tab1" data-toggle="tab">订单明细</a></li>
					       
					      </ul> -->
					      <div class="tab-content">
					        <div class="tab-pane active" id="tab1">
					            <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV1_tab" style="width: 750%;background-color: #fff;margin-bottom: 0;">
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
    <div class="modal modal-darkorange" id="btDiv11">
        <div class="modal-dialog" style="width: 800px;height:80%;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv11();">×</button>
                    <h4 class="modal-title" id="divTitle"></h4>
                </div>
               <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div  class="col-xs-12 col-md-12" style="overflow-Y: hidden;">
			               <table class="table-striped table-hover table-bordered" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                
                                                <th width="2%" style="text-align: center;">订单号</th>
                                                <th width="2%" style="text-align: center;">CID</th>
                                                <th width="2%" style="text-align: center;">会员卡号</th>
                                                <th width="2%" style="text-align: center;">订单状态</th>
                                                <th width="2%" style="text-align: center;">商品销售总额 </th>
                                                <th width="2%" style="text-align: center;">应收运费 </th>
                                                <th width="2%" style="text-align: center;">销售时间</th>
                                                <th width="2%" style="text-align: center;">收件人姓名</th>
                                                <th width="2%" style="text-align: center;">收件人电话</th>
                                                <th width="2%" style="text-align: center;">收货地址</th>
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
					        <li class="active"><a href="#tab10" data-toggle="tab">订单明细</a></li>
					        <li><a href="#tab3" data-toggle="tab">支付信息</a></li>
					        <li><a href="#tab2" data-toggle="tab">包裹信息</a></li>
							<li><a href="#tab4" data-toggle="tab">历史信息</a></li>
							<li><a href="#tab5" data-toggle="tab">销售单信息</a></li>
							<li><a href="#tab6" data-toggle="tab">发票信息</a></li>
					      </ul>
					      <div class="tab-content">
					        <div class="tab-pane active" id="tab10">
					            <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV10_tab" style="width: 750%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					              </div>
					        </div>
					        <div class="tab-pane" id="tab3">
					          <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV3_tab" style="width: 250%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					        </div>
					        <div class="tab-pane" id="tab2">
					          <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 250%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					        </div>
					         <div class="tab-pane" id="tab4">
					         	<div style="width:100%;height:200px;overflow:scroll; ">
					                    <table class="table-striped table-hover table-bordered" id="OLV4_tab" style="width: 150%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					         </div>
					          <div class="tab-pane" id="tab5">
					          	<div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV5_tab" style="width: 450%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					             </div>
					        </div>
					          <div class="tab-pane" id="tab6">
					          	<div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV6_tab" style="width: 150%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					             </div>
					        </div>
					        &nbsp;
					        <div align="center" id="ddsh">
					             <input class="btn btn-danger" style="width: 20%;" id="shtg" type="button" value="审核通过" />
								 <input class="btn btn-success" style="width: 20%;" id="shbtg" type="button" value="审核不通过" /> 
					     	</div>
					      </div>
					    </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv11();" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    <div class="modal modal-darkorange" id="btDiv2">
        <div class="modal-dialog" style="width: 500px;height:100%;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv2();">×</button>
                    <h4 class="modal-title" id="divTitle2"></h4>
                </div>
                    <div class="tabbable"> <!-- Only required for left/right tabs -->
					      <div class="tab-content">
					        <div class="tab-pane active" id="tab1">
					            <div style="width:100%;height:350px; overflow:hidden;">
					                    <!-- <table class="table-striped table-hover table-bordered" id="OLV1_tab" style="width: 750%;background-color: #fff;margin-bottom: 0;">
					                    </table> -->
					                    <div>
					                    	<label id="lable1">退货商品名称：</label>
					                    	<span id="sp1"></span>
					                    </div>
					                    &nbsp;
					                    <div>
					                    	<label id="lable2">退货商品编码：</label>
					                    	<span id="sp2">**编码</span>
					                    </div>
					                     &nbsp;
					                    <div>
					                    	<label id="lable3">可退数量：</label>
					                    	<span id="orderNo_{$T.Result.orderNo}" class='expand-collapse click-collapse glyphicon glyphicon-minus' style='cursor:pointer;' onclick="trClickBdd()"></span>
					                    	&nbsp;<span style="font-size:16px;" id ="sp3"></span>&nbsp
					                    	<span id="orderNo_{$T.Result.orderNo}" class='expand-collapse click-expand glyphicon glyphicon-plus' style='cursor:pointer;' onclick="trClickAdd()"></span>
					                    </div>&nbsp;
					                    <div>
					                    	<label id="lable4">退货原因：</label>
					                    	<select id="sp4">
					                    		<option value="">请选择退货申请原因</option>
												<!-- <option value="包装/商品破损/污渍">包装/商品破损/污渍</option>
												<option value="少件/漏发">少件/漏发</option>
												<option value="卖家发错货">卖家发错货</option>
												<option value="7天无理由退换货">7天无理由退换货</option>
												<option value="假冒品牌">假冒品牌</option>
												<option value="做工问题">做工问题</option>
												<option value="缩水/褪色">缩水/褪色</option>
												<option value="发票问题">发票问题</option>
												<option value="未按约定时间发货">未按约定时间发货</option>
												<option value="材质面料与商品描述不符">材质面料与商品描述不符</option>
												<option value="颜色/图案/款式与商品描述不符">颜色/图案/款式与商品描述不符</option>
												<option value="大小/尺寸与商品描述不符">大小/尺寸与商品描述不符</option> -->
					                    	</select>&nbsp;
					                    </div>&nbsp;
					                    <div>
					                    	<label id="lable5" class="col-lg-2 col-sm-3 col-xs-3 control-label">备注：</label>
					                    	<textarea id="sp5" style="width: 500px;height: 10px;max-width: 300px;max-height: 100px;min-width: 200px;min-height: 100px;resize: none" id="comments" name="comments" placeholder="非必填"></textarea>
					                    </div>
					                     &nbsp; &nbsp; &nbsp;
					                     <div align="center">
					                    	<a class="btn btn-default shiny" onclick="Ok();">提交</a>&nbsp;&nbsp; &nbsp; &nbsp;
											<a class="btn btn-default shiny" onclick="No();">取消</a>
					              		</div>
					              </div>
					        </div>
					      </div>
					    </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
     <div class="modal modal-darkorange" id="btDiv211">
        <div class="modal-dialog" style="width:200px; height:500%; margin: 15% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv211();">×</button>
                    <h6 class="modal-title" id="divTitle">图片</h6>
                </div>
                    <div id="imageDiv">
                    	
                    </div>
               <!--  <div class="page-body" id="pageBodyRight">
                </div> -->
               
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