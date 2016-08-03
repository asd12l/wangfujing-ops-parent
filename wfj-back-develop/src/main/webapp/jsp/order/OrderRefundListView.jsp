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
.trClick>td,.trClick>th{
 color:red;
}
</style>
  <script type="text/javascript">
		__ctxPath = "${ctx}";
		image="http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	var qudaos='';
	var mendians='' ;
	var qudaos1='';
	var mendians1='' ;
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
 		}}); */
 		
 		//权限
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/rolePermission/getPermissionByTypes?types=1,0",//渠道1,门店0
			dataType: "json",
			success: function(response) {
				var result = response;
//				if(result.success=='true'){
					for( var i=0; i<result.data.length; i++){
						var ele = result.data[i];
						if(ele.permissionType=='1'){
							var qudao = ele.permission;
							qudaos += (qudao+'\',\'');
						}else if(ele.permissionType=='0'){
							var mendian = ele.permission;
							mendians += (mendian+'\',\'');
//						}else if(ele.permissionType=='2'){
//							var fenlei = ele.permission;
//							fenleis += (fenlei+'\',\'');
						}
					}
//				} 
					qudaos1 = qudaos.substring(0,qudaos.length-3);
					mendians1 = mendians.substring(0,mendians.length-3);
					//$("#op1").val(qudaos1);
					$("#op2").val(mendians1);
//					var fenleis1 = fenleis.substring(0,fenleis.length-3);
				return;
			}
		});
 		
 		//退货单状态
		$("#refundStatus_select").one("click",function(){
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=refund_status",
				dataType: "json",
				success: function(response) {
					var result = response;
					var codeValue = $("#refundStatus_select");
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
 		//退款状态
		$("#rebateStatus_select").one("click",function(){
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=refundpay_status",
				dataType: "json",
				success: function(response) {
					var result = response;
					var codeValue = $("#rebateStatus_select");
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
		//门店号（PCM接口）
		$.ajax({
			type : "post",
			url : __ctxPath + "/shoppe/queryShopListAddPermission",
			dataType : "json",
			data : "organizationType=3",
			async : false,
			success : function(response) {
				var result = response.list;
				var option = "";
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.organizationCode+"'>"
							+ ele.organizationName + "</option>";
				}
				$("#shopNo_input").append(option);
				return;
			}
		});
		//退货类别
		$("#refundClass_select").one("click",function(){
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=refund_class",
				dataType: "json",
				success: function(response) {
					var result = response;
					var codeValue = $("#refundClass_select");
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
		$("#refundApplyNo_form").val($("#refundApplyNo_input").val().trim());
		$("#refundNo_form").val($("#refundNo_input").val().trim());
		$("#orderNo_form").val($("#orderNo_input").val().trim());
		$("#originalSalesNo_form").val($("#originalSalesNo_input").val().trim());
		$("#memberNo_form").val($("#memberNo_input").val().trim());
		$("#salesPaymentNo_form").val($("#salesPaymentNo_input").val().trim());
		$("#refundStatus_form").val($("#refundStatus_select").val());
		$("#shopNo_form").val($("#shopNo_input").val());
		$("#rebateStatus_form").val($("#rebateStatus_select").val());
		$("#refundType_form").val($("#refundType_select").val());
		$("#refundClass_form").val($("#refundClass_select").val());
		var strTime = $("#reservation").val();
		if(strTime!=""){
			strTime = strTime.split("-");
			$("#startRefundTime_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#endRefundTime_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#startRefundTime_form").val("");
			$("#endRefundTime_form").val("");
		}
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#refundApplyNo_input").val("");
		$("#refundNo_input").val("");
		$("#orderNo_input").val("");
		$("#originalSalesNo_input").val("");
		$("#memberNo_input").val("");
		$("#salesPaymentNo_input").val("");
		$("#refundStatus_select").val("");
		$("#shopNo_input").val("");
		$("#rebateStatus_select").val("");
		$("#refundType_select").val("");
		$("#reservation").val("");
		$("#refundClass_select").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/oms/selectRefundList";
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
             param : "&shopNo=" + $("#shopNo_input").val(),
             /*  ajaxStart: function() {
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
	
 	function urlClick(ur,obj){
//		$("#imageDiv").text(ur);
		$("#imageDiv").html('<img style="width:200px; heigth:200px;" align="center" src="http://10.6.100.100/'+ur+'"/>');
		$("#btDiv2").show();
	}
 	//订单明细促销
 	function spanTdOrder(obj) {
		if ($("#spanTdOrder_"+obj).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#spanTdOrder_"+obj).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
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
				var option = "<tr id='afterTrOrder"+obj+"'><td></td><td colspan='5'><div style='padding:2px;width: 150%;'>"
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
					if(response.success=='true'){
						var result = response.list;
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
					}
					option += "</table></div></td></tr>";
					$("#gradeYOrder" + obj).after(option);
				}
			});
		} else {
			$("#spanTdOrder_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTrOrder" + obj).remove();
		}
		
	}
 	//退货申请单明细促销
 	function spanTdApply(obj) {
		if ($("#spanTdApply_"+obj).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#spanTdApply_"+obj).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/omsOrder/selectRefundApplyPromotionSplit",
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
								"loading-inactive")
					}, 300);
				},
				data : {"applyItemNo" : obj},
				success : function(response) {
				var option = "<tr id='afterTrApply"+obj+"'><td></td><td colspan='5'><div style='padding:2px;width: 250%;'>"
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
					if(response.success=='true'){
						var result = response.list;
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							//商品行项目编号
							if(ele.applyItemNo=="[object Object]"||ele.applyItemNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.applyItemNo+"</td>";
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
					}
					option += "</table></div></td></tr>";
					$("#gradeYApply" + obj).after(option);
				}
			});
		} else {
			$("#spanTdApply_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTrApply" + obj).remove();
		}
		
	}
	//退货单明细促销
 	function spanTd(obj) {
		if ($("#spanTd_"+obj).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#spanTd_"+obj).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/oms/selectRefundPromotionSplit",
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
								"loading-inactive")
					}, 300);
				},
				data : {"refundItemNo" : obj},
				success : function(response) {
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
					if(response.success=='true'){
						var result = response.list;
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							//商品行项目编号
							if(ele.refundItemNo=="[object Object]"||ele.refundItemNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.refundItemNo+"</td>";
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
					}
					option += "</table></div></td></tr>";
					$("#gradeY" + obj).after(option);
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
				url : __ctxPath + "/oms/selectPayments",
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
								"loading-inactive")
					}, 300);
				},
				data : {"salesPaymentNo" : obj},
				success : function(response) {
				var option = "<tr id='afterTr1"+obj+"'><td></td><td colspan='5'><div style='padding:2px;width: 250%;'>"
						+ "<table class='table table-bordered table-striped table-condensed table-hover flip-content' ><tr role='row'>";
					option += "<th width='5%' style='text-align: center;'>款机流水号</th>"+
					"<th width='3%' style='text-align: center;'>一级支付介质</th>"+
					"<th width='3%' style='text-align: center;'>二级支付介质</th>"+
					"<th width='3%' style='text-align: center;'>支付金额</th>"+
					"<th width='3%' style='text-align: center;'>实际抵扣金额</th>"+
					"<th width='3%' style='text-align: center;'>汇率</th>"+
					"<th width='3%' style='text-align: center;'>支付CID</th>"+
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
					if(response.success=='true'){
						var result = response.list;
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							//款机流水号
							if(ele.posFlowNo=="[object Object]"||ele.posFlowNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.posFlowNo+"</td>";
							}
							//一级支付介质
							if(ele.paymentClass=="[object Object]"||ele.paymentClass==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.paymentClass+"</td>";
							}
							//二级支付介质
							if(ele.paymentType=="[object Object]"||ele.paymentType==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.paymentType+"</td>";
							}
							//支付金额
							if(ele.amount=="[object Object]"||ele.amount==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.amount+"</td>";
							}
							//实际抵扣金额
							if(ele.acturalAmount=="[object Object]"||ele.acturalAmount==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.acturalAmount+"</td>";
							}
							//汇率
							if(ele.rate=="[object Object]"||ele.rate==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.rate+"</td>";
							}
							//支付CID
							if(ele.account=="[object Object]"||ele.account==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.account+"</td>";
							}
							//会员id
							if(ele.userId=="[object Object]"||ele.userId==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.userId+"</td>";
							}
							//支付流水号
							if(ele.payFlowNo=="[object Object]"||ele.payFlowNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.payFlowNo+"</td>";
							}
							//优惠券类型
							if(ele.couponType=="[object Object]"||ele.couponType==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.couponType+"</td>";
							}
							//优惠券批次
							if(ele.couponBatch=="[object Object]"||ele.couponBatch==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.couponBatch+"</td>";
							}
							//券模板名称
							if(ele.couponName=="[object Object]"||ele.couponName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.couponName+"</td>";
							}
							//活动号
							if(ele.activityNo=="[object Object]"||ele.activityNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.activityNo+"</td>";
							}
							//收券规则
							if(ele.couponRule=="[object Object]"||ele.couponRule==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.couponRule+"</td>";
							}
							//收券规则描述
							if(ele.couponRuleName=="[object Object]"||ele.couponRuleName==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.couponRuleName+"</td>";
							}
							//结余
							if(ele.cashBalance=="[object Object]"||ele.cashBalance==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.cashBalance+"</td>";
							}
							//备注
							if(ele.remark=="[object Object]"||ele.remark==undefined){
								option+="<td align='center'></td></tr>";
							}else{
								option+="<td align='center'>"+ele.remark+"</td></tr>";
							}
						}
					}
					option += "</table></div></td></tr>";
					$("#gradeY1" + obj).after(option);
				}
			});
		} else {
			$("#spanTd1_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTr1" + obj).remove();
		}
		
	}
 	//包裹单明细
 	function spanTd321(obj) {
		if ($("#spanTd321_"+obj).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#spanTd321_"+obj).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/omsOrder/selectPackageItemList",
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
				var option = "<tr id='afterTr321"+obj+"'><td></td><td colspan='5'><div style='padding:2px;width: 200%;'>"
						+ "<table class='table table-bordered table-striped table-condensed table-hover flip-content' ><tr role='row'>";
					option += "<th width='3%' style='text-align: center;'>包裹单号</th>"+
					"<th width='2%' style='text-align: center;'>物流单号</th>"+
					"<th width='3%' style='text-align: center;'>销售单号</th>"+
					"<th width='3%' style='text-align: center;'>销售单明细号</th>"+
					"<th width='2%' style='text-align: center;'>销售数量</th></tr>";
					if(response.success=='true'){
						var result = response.list;
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							//包裹单号
							if(ele.packageNo=="[object Object]"||ele.packageNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.packageNo+"</td>";
							}
							//物流单号
							if(ele.deliveryNo=="[object Object]"||ele.deliveryNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.deliveryNo+"</td>";
							}
							//销售单号
							if(ele.saleNo=="[object Object]"||ele.saleNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.saleNo+"</td>";
							}
							//销售单明细号
							if(ele.saleItemNo=="[object Object]"||ele.saleItemNo==undefined){
								option+="<td align='center'></td>";
							}else{
								option+="<td align='center'>"+ele.saleItemNo+"</td>";
							}
							//销售数量
							if(ele.saleNum=="[object Object]"||ele.saleNum==undefined){
								option+="<td align='center'></td></tr>";
							}else{
								option+="<td align='center'>"+ele.saleNum+"</td></tr>";
							}
						}
					}
					option += "</table></div></td></tr>";
					$("#gradeY321" + obj).after(option);
				}
			});
		} else {
			$("#spanTd321_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTr321" + obj).remove();
		}
		
	}
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
						
					if(response.success=='true'){
						var result = response.list;
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
					}
					option += "</table></div></td></tr>";
					$("#gradeY12" + obj).after(option); 
				}
			});
		} else {
			$("#spanTd12_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTr12" + obj).remove();
		}
		
 	}
 	
 	//点击tr事件 退货申请单明细
	function trClick3(refundNo,orderNo,refundApplyNo,obj){
//		 var newTr1 = $(obj).removeAttr("onclick").removeClass("trClick");
//		 var newTr =  newTr1.parent().parent().clone(true);
		 var newTr =  $(obj).parent().parent().clone(true);
		 newTr.children().children().removeAttr("onclick").removeClass("trClick");
		 newTr.children().find("#"+refundApplyNo+"_").replaceWith(refundApplyNo);
		 newTr.children().find("#"+orderNo+"_").replaceWith(orderNo);
		 newTr.children().find("#"+refundNo+"").replaceWith(refundNo);
		$("#mainTr3").html(newTr);
		$(obj).addClass("trClick").siblings().removeClass("trClick");
		var option = "<tr role='row' style='height:35px;'>"+
		"<th width='1%' style='text-align: center;'></th>"+
		"<th width='3%' style='text-align: center;'>退货申请单号</th>"+
		"<th width='3%' style='text-align: center;'>退货申请单明细行号</th>"+
		"<th width='3%' style='text-align: center;'>订单号</th>"+
		"<th width='3%' style='text-align: center;'>订单明细行号</th>"+
		"<th width='3%' style='text-align: center;'>销售单号</th>"+
		"<th width='3%' style='text-align: center;'>销售单明细行号</th>"+
		"<th width='2%' style='text-align: center;'>sku编号</th>"+
		"<th width='2%' style='text-align: center;'>spu编号</th>"+
		"<th width='2%' style='text-align: center;'>专柜商品编号</th>"+
		"<th width='2%' style='text-align: center;'>ERP商品编号</th>"+
		"<th width='3%' style='text-align: center;'>供应商内部商品编码</th>"+
		"<th width='2%' style='text-align: center;'>商品单位</th>"+
		"<th width='2%' style='text-align: center;'>条形码</th>"+
		"<th width='3%' style='text-align: center;'>门店名称</th>"+
		"<th width='3%' style='text-align: center;'>供应商编码</th>"+
		"<th width='3%' style='text-align: center;'>供应商名称</th>"+
		"<th width='3%' style='text-align: center;'>专柜名称</th>"+
		"<th width='2%' style='text-align: center;'>品牌</th>"+
		"<th width='2%' style='text-align: center;'>颜色</th>"+
		"<th width='2%' style='text-align: center;'>规格</th>"+
		"<th width='2%' style='text-align: center;'>退货数量</th>"+
		"<th width='2%' style='text-align: center;'>销售价</th>"+
		"<th width='2%' style='text-align: center;'>应退金额</th>"+
		"<th width='2%' style='text-align: center;'>实退金额</th>"+
		"<th width='2%' style='text-align: center;'>是否为赠品</th>"+
		"<th width='2%' style='text-align: center;'>扣率码</th>"+
		"<th width='2%' style='text-align: center;'>退货原因</th>"+
		"<th width='2%' style='text-align: center;'>商品图片url</th>"+
		"<th width='2%' style='text-align: center;'>退货商品图片url</th>"+
		"<th width='2%' style='text-align: center;'>出库商品编号</th>"+
		"<th width='2%' style='text-align: center;'>行号</th>"+
		"<th width='2%' style='text-align: center;'>订单详情行号</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/selectRefundApplyItemList",
			async:false,
			dataType: "json",
			data:{"refundApplyNo":refundApplyNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						option+="<tr id='gradeYApply"+ele.applyItemNo+"' style='height:35px;overflow-X:hidden;'>"+
						"<td align='center' style='vertical-align:middle;'>"+
						"<span id='spanTdApply_"+ele.applyItemNo+"' onclick='spanTdApply(\""+ele.applyItemNo+"\")' "+
						"class='expand-collapse click-expand glyphicon glyphicon-plus' style='cursor:pointer;'></span></td>";
						//退货单号
						if(ele.applyNo=="[object Object]"||ele.applyNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.applyNo+"</td>";
						}
						//退货申请单明细行号
						if(ele.applyItemNo=="[object Object]"||ele.applyItemNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.applyItemNo+"</td>";
						}
						//订单号
						if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.orderNo+"</td>";
						}
						//定单明细行号
						if(ele.orderItemNo=="[object Object]"||ele.orderItemNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.orderItemNo+"</td>";
						}
						//销售单号
						if(ele.saleNo=="[object Object]"||ele.saleNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleNo+"</td>";
						}
						//销售单明细行号
						if(ele.saleItemNo=="[object Object]"||ele.saleItemNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleItemNo+"</td>";
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
						//ERP商品编号
						if(ele.erpProductNo=="[object Object]"||ele.erpProductNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.erpProductNo+"</td>";
						}
						//供应商内部商品编号
						if(ele.supplyProductInnerCode=="[object Object]"||ele.supplyProductInnerCode==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.supplyProductInnerCode+"</td>";
						}
						//商品单位
						if(ele.unit=="[object Object]"||ele.unit==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.unit+"</td>";
						}
						//条形码
						if(ele.barCode=="[object Object]"||ele.barCode==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.barCode+"</td>";
						}
						//门店名称
						if(ele.shopName=="[object Object]"||ele.shopName==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.shopName+"</td>";
						}
						//供应商编码
						if(ele.supplyNo=="[object Object]"||ele.supplyNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.supplyNo+"</td>";
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
						//退货数量
						if(ele.refundNum=="[object Object]"||ele.refundNum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundNum+"</td>";
						}
						//销售价
						if(ele.salePrice=="[object Object]"||ele.salePrice==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.salePrice+"</td>";
						}
						//应退金额
						if(ele.refundAmount=="[object Object]"||ele.refundAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundAmount+"</td>";
						}
						//实退金额
						if(ele.actualRefundAmount=="[object Object]"||ele.actualRefundAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.actualRefundAmount+"</td>";
						}
						//是否为赠品
						if(ele.isGift=="[object Object]"||ele.isGift==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.isGift+"</td>";
						}
						//扣率码
						if(ele.discountCode=="[object Object]"||ele.discountCode==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.discountCode+"</td>";
						}
						//退货原因
						if(ele.refundReasionDesc=="[object Object]"||ele.refundReasionDesc==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundReasionDesc+"</td>";
						}
						//商品图片url
						if(ele.proPictureUrl=="[object Object]"||ele.proPictureUrl==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'><a onclick='urlClick("+'"'+ele.proPictureUrl+'"'+",this);' style='cursor:pointer;'> "+ele.proPictureUrl+"</a></td>";
						}
						//退货商品图片url
						if(ele.refundPcitureUrl=="[object Object]"||ele.refundPcitureUrl==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundPcitureUrl+"</td>";
						}
						//出库商品唯一编号
						if(ele.productOnlySn=="[object Object]"||ele.productOnlySn==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.productOnlySn+"</td>";
						}
						//行号
						if(ele.rowNo=="[object Object]"||ele.rowNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.rowNo+"</td>";
						}
						//订单详情行号
						if(ele.orderItemRowNo=="[object Object]"||ele.orderItemRowNo==undefined){
							option+="<td align='center'></td></tr>";
						}else{
							option+="<td align='center'>"+ele.orderItemRowNo+"</td></tr>";
						}
						
					}
				}
			}
		});
		var option3 = "<tr role='row' style='height:35px;'>"+
		"<th width='5%' style='text-align: center;'>退货申请单号</th>"+
		"<th width='5%' style='text-align: center;'>修改前状态</th>"+
		"<th width='5%' style='text-align: center;'>修改后状态</th>"+
		"<th width='5%' style='text-align: center;'>修改人</th>"+
		"<th width='5%' style='text-align: center;'>系统来源</th>"+
		"<th width='5%' style='text-align: center;'>修改时间</th>"+
		"<th width='5%' style='text-align: center;'>备注</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/omsOrder/selectRefundApplyHistory",
			async:false,
			dataType: "json",
			data:{"refundApplyNo":refundApplyNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						//退货单单号
						if(ele.refundApplyNo=="[object Object]"||ele.refundApplyNo==undefined){
							option3+="<tr style='height:35px;overflow-X:hidden;'><td align='center'></td>";
						}else{
							option3+="<tr style='height:35px;overflow-X:hidden;'><td align='center'>"+ele.refundApplyNo+"</td>";
						}
						//修改前状态
						if(ele.priviousStatus=="1"){
							option3+="<td align='center'>待审核</td>";
						}else if(ele.priviousStatus=="2"){
							option3+="<td align='center'>审核不通过</td>";
						}else if(ele.priviousStatus=="3"){
							option3+="<td align='center'>取消中</td>";
						}else if(ele.priviousStatus=="4"){
							option3+="<td align='center'>审核通过</td>";
						}else if(ele.priviousStatus=="5"){
							option3+="<td align='center'>取消成功</td>";
						}else if(ele.priviousStatus=="6"){
							option3+="<td align='center'>已完结</td>";
						}else if(ele.priviousStatus=="7"){
							option3+="<td align='center'>确认收货</td>";
						}else{
							option3+="<td align='center'></td>";
						}
						//修改后状态
						if(ele.currentStatusDesc=="[object Object]"||ele.currentStatusDesc==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.currentStatusDesc+"</td>";
						}
						//修改人
						if(ele.updateMan=="[object Object]"||ele.updateMan==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.updateMan+"</td>";
						}
						//系统来源
						if(ele.operatorSource=="[object Object]"||ele.operatorSource==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.operatorSource+"</td>";
						}
						//修改时间
						if(ele.updateTimeStr=="[object Object]"||ele.updateTimeStr==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.updateTimeStr+"</td>";
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
		$("#OLV31_tab").html(option);
		$("#OLV33_tab").html(option3);
		$("#divTitle31").html("退货申请单详情");
		$("#btDiv31").show();
	}
	function closeBtDiv31(){
		$("#btDiv31").hide();
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
				var option11 = "<tr id='afterTr11"+obj+"'><td></td><td colspan='5'><div style='padding:2px;width: 200%;'>"
						+ "<table class='table table-bordered table-striped table-condensed table-hover flip-content' ><tr role='row'>";
						option11 += "<th width='5%' style='text-align: center;'>款机流水号</th>"+
						"<th width='3%' style='text-align: center;'>支付方式</th>"+
						"<th width='3%' style='text-align: center;'>支付金额</th>"+
						"<th width='3%' style='text-align: center;'>实际抵扣金额</th>"+
						"<th width='3%' style='text-align: center;'>汇率（折现率)</th>"+
						"<th width='3%' style='text-align: center;'>支付账号</th>"+
						"<th width='3%' style='text-align: center;'>会员面卡号</th>"+
						"<th width='3%' style='text-align: center;'>支付流水号</th>"+
						"<th width='3%' style='text-align: center;'>优惠券类型</th>"+
						"<th width='3%' style='text-align: center;'>优惠券批次</th>"+
						"<th width='3%' style='text-align: center;'>券模板名称</th>"+
						"<th width='3%' style='text-align: center;'>活动号</th>"+
						"<th width='3%' style='text-align: center;'>收券规则</th>"+
						"<th width='5%' style='text-align: center;'>收券规则描述</th>"+
						"<th width='3%' style='text-align: center;'>结余</th>"+
						"<th width='3%' style='text-align: center;'>备注</th></tr>";
					if(response.success=='true'){
						var result = response.list;
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
							//会员面卡号
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
					}
					option11 += "</table></div></td></tr>";
					$("#gradeY11" + obj).after(option11);
				}
			});
		} else {
			$("#spanTd11_" + obj).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
			$("#afterTr11" + obj).remove();
		}
 	}
 	//点击tr事件 订单详情
	function trClick2(refundNo,orderNo,refundApplyNo,obj){
		 var newTr =  $(obj).parent().parent().clone(true);
		 newTr.children().children().removeAttr("onclick").removeClass("trClick");
		 newTr.children().find("#"+refundApplyNo+"_").replaceWith(refundApplyNo);
		 newTr.children().find("#"+orderNo+"_").replaceWith(orderNo);
		 newTr.children().find("#"+refundNo+"").replaceWith(refundNo);
		 $("#mainTr2").html(newTr);
		$(obj).addClass("trClick").siblings().removeClass("trClick");
		
		var option = "<tr role='row' style='height:35px;'>"+
		"<th width='1%' style='text-align: center;'></th>"+
		"<th width='2%' style='text-align: center;'>行号</th>"+
		"<th width='3%' style='text-align: center;'>订单号</th>"+
		"<th width='3%' style='text-align: center;'>订单明细编号</th>"+
		"<th width='3%' style='text-align: center;'>商品名称</th>"+
		"<th width='3%' style='text-align: center;'>专柜名称</th>"+
		"<th width='3%' style='text-align: center;'>门店名称</th>"+
		"<th width='3%' style='text-align: center;'>供应商编码</th>"+
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
		
		"<th width='2%' style='text-align: center;'>销售金额</th>"+
		"<th width='2%' style='text-align: center;'>促销优惠分摊金额</th>"+
		"<th width='2%' style='text-align: center;'>促销后销售金额</th>"+
		
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
						option+="<tr id='gradeYOrder"+ele.orderItemNo+"' style='height:35px;overflow-X:hidden;'>"+
						"<td align='center' style='vertical-align:middle;'>"+
						"<span id='spanTdOrder_"+ele.orderItemNo+"' onclick='spanTdOrder(\""+ele.orderItemNo+"\")' "+
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
						//供应商编码
						if(ele.supplyCode=="[object Object]"||ele.supplyCode==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.supplyCode+"</td>";
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
						option2+="<tr id='gradeY321"+ele.packageNo+"' style='height:35px;overflow-X:hidden;'>"+
						"<td align='center' style='vertical-align:middle;'>"+
						"<span id='spanTd321_"+ele.packageNo+"' onclick='spanTd321(\""+ele.packageNo+"\")' "+
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
							option4+="<td align='center'>已签收</td>";
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
							option4+="<td align='center'>已拒收</td>";
						}else if(ele.priviousStatus=="9307"){
							option4+="<td align='center'>已取消</td>";
						}else if(ele.priviousStatus=="9304"){
							option4+="<td align='center'>订单关闭</td>";
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
		"<th width='6%' style='text-align: center;'>供应商编码</th>"+
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
						//供应商编码
						if(ele.supplyNo=="[object Object]"||ele.supplyNo==undefined){
							option5+="<td align='center'></td>";
						}else{
							option5+="<td align='center'>"+ele.supplyNo+"</td>";
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
		$("#OLV21_tab").html(option);
		$("#OLV22_tab").html(option2);
		$("#OLV23_tab").html(option3);
		$("#OLV24_tab").html(option4);
		$("#OLV25_tab").html(option5);
		$("#OLV26_tab").html(option6);
		$("#divTitle21").html("订单详情");
		$("#btDiv21").show();
	}
	function closeBtDiv21(){
		$("#btDiv21").hide();
	}
	
	//点击tr事件
	function trClick(refundNo,orderNo,refundApplyNo,refundType,obj){
//		 var newTr1 = $(obj).removeAttr("onclick").removeClass("trClick");
//		 var newTr =  newTr1.parent().parent().clone(true);
		 var newTr =  $(obj).parent().parent().clone(true);
		 newTr.children().children().removeAttr("onclick").removeClass("trClick");
		 newTr.children().find("#"+refundApplyNo+"_").replaceWith(refundApplyNo);
		 newTr.children().find("#"+orderNo+"_").replaceWith(orderNo);
		 newTr.children().find("#"+refundNo+"").replaceWith(refundNo);
		$("#mainTr").html(newTr);
		$(obj).addClass("trClick").siblings().removeClass("trClick");
		var option = "<tr role='row' style='height:35px;'>"+
		"<th width='1%' style='text-align: center;'></th>"+
		"<th width='5%' style='text-align: center;'>退货单号</th>"+
		"<th width='5%' style='text-align: center;'>退货单商品行号</th>"+
		"<th width='3%' style='text-align: center;'>sku编号</th>"+
		"<th width='3%' style='text-align: center;'>spu编号</th>"+
		"<th width='3%' style='text-align: center;'>专柜商品编号</th>"+
		"<th width='3%' style='text-align: center;'>专柜商品名称</th>"+
		"<th width='3%' style='text-align: center;'>ERP商品编号</th>"+
		"<th width='5%' style='text-align: center;'>供应商内部商品编号</th>"+
		"<th width='3%' style='text-align: center;'>商品单位</th>"+
		"<th width='3%' style='text-align: center;'>品牌名称</th>"+
		"<th width='3%' style='text-align: center;'>颜色名称</th>"+
		"<th width='3%' style='text-align: center;'>规格名称</th>"+
		"<th width='3%' style='text-align: center;'>退货数量</th>"+
		"<th width='3%' style='text-align: center;'>销售价</th>"+
		"<th width='3%' style='text-align: center;'>应退金额</th>"+
		"<th width='3%' style='text-align: center;'>实退金额</th>"+
		"<th width='3%' style='text-align: center;'>是否为赠品</th>"+
		"<th width='3%' style='text-align: center;'>先销后采标识</th>"+
		"<th width='3%' style='text-align: center;'>管理分类编码</th>"+
		"<th width='3%' style='text-align: center;'>统计分类</th>"+
		"<th width='5%' style='text-align: center;'>销售单明细号</th>"+
		"<th width='3%' style='text-align: center;'>销售单行号</th>"+
		"<th width='3%' style='text-align: center;'>大中小类</th>"+
		"<th width='3%' style='text-align: center;'>商品类别</th>"+
		"<th width='3%' style='text-align: center;'>收银损益</th>"+
		"<th width='3%' style='text-align: center;'>销项税</th>"+
		"<th width='4%' style='text-align: center;'>条形码</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/oms/selectRefundItemList",
			async:false,
			dataType: "json",
			data:{"refundNo":refundNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						option+="<tr id='gradeY"+ele.refundItemNo+"' style='height:35px;overflow-X:hidden;'>"+
						"<td align='center' style='vertical-align:middle;'>"+
						"<span id='spanTd_"+ele.refundItemNo+"' onclick='spanTd(\""+ele.refundItemNo+"\")' "+
						"class='expand-collapse click-expand glyphicon glyphicon-plus' style='cursor:pointer;'></span></td>";
						//退货单号
						if(ele.refundNo=="[object Object]"||ele.refundNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundNo+"</td>";
						}
						//退货单商品行号
						if(ele.refundItemNo=="[object Object]"||ele.refundItemNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundItemNo+"</td>";
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
						if(ele.supplyProductInnerCode=="[object Object]"||ele.supplyProductInnerCode==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.supplyProductInnerCode+"</td>";
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
						//退货数量
						if(ele.refundNum=="[object Object]"||ele.refundNum==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundNum+"</td>";
						}
						//销售价
						if(ele.salePrice=="[object Object]"||ele.salePrice==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.salePrice+"</td>";
						}
						//应退金额
						if(ele.refundAmount=="[object Object]"||ele.refundAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.refundAmount+"</td>";
						}
						//实退金额
						if(ele.actualRefundAmount=="[object Object]"||ele.actualRefundAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.actualRefundAmount+"</td>";
						}
						//是否为赠品
						/* if(ele.isGift=="[object Object]"||ele.isGift==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.isGift+"</td>";
						} */
						if(ele.isGift=="0"){
							option+="<td align='center'><span>否</span></td>";
						}else if(ele.isGift=="1"){
							option+="<td align='center'><span>是</span></td>";
						}else{
							option+="<td align='center'></td>";
						}
						//先销后采标识
						if(ele.xxhc=="[object Object]"||ele.xxhc==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.xxhc+"</td>";
						}
						//管理分类编码
						if(ele.managerCateNo=="[object Object]"||ele.managerCateNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.managerCateNo+"</td>";
						}
						//统计分类
						if(ele.staticsCateNo=="[object Object]"||ele.staticsCateNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.staticsCateNo+"</td>";
						}
						//销售单明细号
						if(ele.saleItemNo=="[object Object]"||ele.saleItemNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleItemNo+"</td>";
						}
						//销售单行号
						if(ele.saleItemRowNo=="[object Object]"||ele.saleItemRowNo==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.saleItemRowNo+"</td>";
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
						}else{
							option+="<td align='center'>"+ele.productType+"</td>";
						}
						//收银损益
						if(ele.incomeAmount=="[object Object]"||ele.incomeAmount==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.incomeAmount+"</td>";
						}
						//销项税
						if(ele.tax=="[object Object]"||ele.tax==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.tax+"</td>";
						}
						//条形码
						if(ele.barCode=="[object Object]"||ele.barCode==undefined){
							option+="<td align='center'></td>";
						}else{
							option+="<td align='center'>"+ele.barCode+"</td>";
						}
						
					}
				}
			}
		});
		if(refundType=="2"){
			
			var option2 = "<tr role='row' style='height:35px;'>"+
			"<th width='1%' style='text-align: center;'></th>"+
			"<th width='5%' style='text-align: center;'>款机流水号</th>"+
			"<th width='3%' style='text-align: center;'>总金额</th>"+
			"<th width='3%' style='text-align: center;'>交易流水号</th>"+
			"<th width='3%' style='text-align: center;'>机器号</th>"+
			"<th width='3%' style='text-align: center;'>线上线下标识</th>"+
			"<th width='4%' style='text-align: center;'>支付时间</th>"+
			"<th width='3%' style='text-align: center;'>水单类型</th>"+
			"<th width='3%' style='text-align: center;'>总折扣</th>"+
			"<th width='3%' style='text-align: center;'>总应收</th>"+
			"<th width='3%' style='text-align: center;'>实际支付</th>"+
			"<th width='3%' style='text-align: center;'>找零</th>"+
			"<th width='3%' style='text-align: center;'>折扣额</th>"+
			"<th width='3%' style='text-align: center;'>折让额</th>"+
			"<th width='3%' style='text-align: center;'>会员总折扣</th>"+
			"<th width='3%' style='text-align: center;'>优惠折扣额</th>"+
			"<th width='3%' style='text-align: center;'>收银损益</th>"+
			"<th width='3%' style='text-align: center;'>收银员号</th>"+
			"<th width='3%' style='text-align: center;'>班次</th>"+
			"<th width='3%' style='text-align: center;'>渠道标志</th>"+
			"<th width='5%' style='text-align: center;'>金卡</th>"+
			"<th width='3%' style='text-align: center;'>微信卡门店号</th>"+
			"<th width='4%' style='text-align: center;'>会员卡号</th>"+
			"<th width='4%' style='text-align: center;'>订单号</th>"+
			"<th width='3%' style='text-align: center;'>授权卡号</th>"+
			"<th width='3%' style='text-align: center;'>人民币</th>"+
			"<th width='3%' style='text-align: center;'>电子返券</th>"+
			"<th width='3%' style='text-align: center;'>电子扣回</th>"+
			"<th width='3%' style='text-align: center;'>银行手续费</th>"+
			"<th width='3%' style='text-align: center;'>来源</th>"+
			"<th width='3%' style='text-align: center;'>状态</th>"+
			"<th width='3%' style='text-align: center;'>门店号</th></tr>";
			$.ajax({
				type:"post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url:__ctxPath + "/oms/selectPosFlowList",
				async:false,
				dataType: "json",
				data:{"refundNo":refundNo,
					"isRefund":"1"},
				success:function(response) {
					if(response.success=='true'){
						var result = response.list;
						for(var i=0;i<result.length;i++){
							var ele = result[i];
							option2+="<tr id='gradeY1"+ele.salesPaymentNo+"' style='height:35px;overflow-X:hidden;'>"+
							"<td align='center' style='vertical-align:middle;'>"+
							"<span id='spanTd1_"+ele.salesPaymentNo+"' onclick='spanTd1(\""+ele.salesPaymentNo+"\")' "+
							"class='expand-collapse click-expand glyphicon glyphicon-plus' style='cursor:pointer;'></span></td>";
							//款机流水号
							if(ele.salesPaymentNo=="[object Object]"||ele.salesPaymentNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.salesPaymentNo+"</td>";
							}
							//总金额
							if(ele.money=="[object Object]"||ele.money==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.money+"</td>";
							}
							//交易流水号
							if(ele.payFlowNo=="[object Object]"||ele.payFlowNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.payFlowNo+"</td>";
							}
							//机器号
							if(ele.posNo=="[object Object]"||ele.posNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.posNo+"</td>";
							}
							//线上线下标识
							if(ele.ooFlag=="1"){
								option2+="<td align='center'><span>线上</span></td>";
							}else if(ele.ooFlag=="2"){
								option2+="<td align='center'><span>线下</span></td>";
							}else{
								option2+="<td align='center'></td>";
							}
							//支付时间
							if(ele.payTimeStr=="[object Object]"||ele.payTimeStr==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.payTimeStr+"</td>";
							}
							//水单类型
							if(ele.isRefund=="[object Object]"||ele.isRefund==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.isRefund+"</td>";
							}
							//总折扣
							if(ele.totalDiscountAmount=="[object Object]"||ele.totalDiscountAmount==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.totalDiscountAmount+"</td>";
							}
							//总应收
							if(ele.paymentAmount=="[object Object]"||ele.paymentAmount==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.paymentAmount+"</td>";
							}
							//实际支付
							if(ele.actualPaymentAmount=="[object Object]"||ele.actualPaymentAmount==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.actualPaymentAmount+"</td>";
							}
							//找零
							if(ele.changeAmount=="[object Object]"||ele.changeAmount==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.changeAmount+"</td>";
							}
							//折扣额
							if(ele.tempDiscountAmount=="[object Object]"||ele.tempDiscountAmount==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.tempDiscountAmount+"</td>";
							}
							//折让额
							if(ele.zrAmount=="[object Object]"||ele.zrAmount==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.zrAmount+"</td>";
							}
							//会员总折扣
							if(ele.memberDiscountAmount=="[object Object]"||ele.memberDiscountAmount==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.memberDiscountAmount+"</td>";
							}
							//优惠折扣额
							if(ele.promDiscountAmount=="[object Object]"||ele.promDiscountAmount==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.promDiscountAmount+"</td>";
							}
							//收银损益
							if(ele.income=="[object Object]"||ele.income==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.income+"</td>";
							}
							//收银员号
							if(ele.casher=="[object Object]"||ele.casher==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.casher+"</td>";
							}
							//班次（早  中 晚  全班）
							if(ele.shifts=="[object Object]"||ele.shifts==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.shifts+"</td>";
							}
							//渠道标志（M）
							if(ele.channel=="[object Object]"||ele.channel==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.channel+"</td>";
							}
							//刷微信卡时的微信卡类型(金卡)
							if(ele.weixinCard=="[object Object]"||ele.weixinCard==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.weixinCard+"</td>";
							}
							//微信卡门店号(扫二维码时其中的5位门店号)
							if(ele.weixinStoreNo=="[object Object]"||ele.weixinStoreNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.weixinStoreNo+"</td>";
							}
							//会员卡号
							if(ele.memberNo=="[object Object]"||ele.memberNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.memberNo+"</td>";
							}
							//线上订单号
							if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.orderNo+"</td>";
							}
							//授权卡号
							if(ele.authorizationNo=="[object Object]"||ele.authorizationNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.authorizationNo+"</td>";
							}
							//人民币
							if(ele.rmb=="[object Object]"||ele.rmb==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.rmb+"</td>";
							}
							//电子返券
							if(ele.elecGet=="[object Object]"||ele.elecGet==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.elecGet+"</td>";
							}
							//电子扣回
							if(ele.elecDeducation=="[object Object]"||ele.elecDeducation==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.elecDeducation+"</td>";
							}
							//银行手续费
							if(ele.bankServiceCharge=="[object Object]"||ele.bankServiceCharge==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.bankServiceCharge+"</td>";
							}
							//来源
							if(ele.sourceType=="[object Object]"||ele.sourceType==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.sourceType+"</td>";
							}
							//状态
							if(ele.status=="[object Object]"||ele.status==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.status+"</td>";
							}
							//门店号
							if(ele.shopNo=="[object Object]"||ele.shopNo==undefined){
								option2+="<td align='center'></td></tr>";
							}else{
								option2+="<td align='center'>"+ele.shopNo+"</td></tr>";
							}
						}
					}
				}
			});
		}else{
			var option2 = "<tr role='row' style='height:35px;'>"+
		/* 	"<th width='1%' style='text-align: center;'></th>"+ */
			"<th width='3%' style='text-align: center;'>退款单号</th>"+
			"<th width='3%' style='text-align: center;'>原订单号</th>"+
			"<th width='3%' style='text-align: center;'>退货单号</th>"+
			"<th width='3%' style='text-align: center;'>销售渠道</th>"+
			"<th width='3%' style='text-align: center;'>渠道订单号</th>"+
			"<th width='3%' style='text-align: center;'>客户登录帐号</th>"+
			"<th width='3%' style='text-align: center;'>客户编号</th>"+
			"<th width='3%' style='text-align: center;'>退款状态</th>"+
			"<th width='3%' style='text-align: center;'>退款金额</th>"+
			"<th width='3%' style='text-align: center;'>退款介质</th>"+
			"<th width='3%' style='text-align: center;'>开户行</th>"+
			"<th width='3%' style='text-align: center;'>开户人</th>"+
			"<th width='3%' style='text-align: center;'>卡号</th>"+
			"<th width='3%' style='text-align: center;'>创建时间</th></tr>";
			$.ajax({
				type:"post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url:__ctxPath + "/omsOrder/selectRefundMonList",
				async:false,
				dataType: "json",
				data:{"refundNo":refundNo,"page":1,"pageSize":10},
				success:function(response) {
					if(response.success=='true'){
						var result = response.list;
						for(var i=0;i<result.length;i++){
							var ele = result[i];
							option2+="<tr id='gradeY1"+ele.salesPaymentNo+"' style='height:35px;overflow-X:hidden;'>"/* +
							"<td align='center' style='vertical-align:middle;'>"+
							"<span id='spanTd1_"+ele.salesPaymentNo+"' onclick='spanTd1(\""+ele.salesPaymentNo+"\")' "+
							"class='expand-collapse click-expand glyphicon glyphicon-plus' style='cursor:pointer;'></span></td>"; */
							//退款单号
							if(ele.refundMonNo=="[object Object]"||ele.refundMonNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.refundMonNo+"</td>";
							}
							//原订单号
							if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.orderNo+"</td>";
							}
							//退货单号
							if(ele.refundNo=="[object Object]"||ele.refundNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.refundNo+"</td>";
							}
							//销售渠道
							if(ele.saleSource=="C1"){
								option2+="<td align='center'><span>线上 C1</span></td>";
							}else if(ele.saleSource=="X1"){
								option2+="<td align='center'><span>线下 X1</span></td>";
							}else if(ele.saleSource=="CB"){
								option2+="<td align='center'><span>全球购</span></td>";
							}else if(ele.saleSource=="C7"){
								option2+="<td align='center'><span>天猫</span></td>";
							}else{
								option2+="<td align='center'></td>";
							}
							//渠道订单号
							if(ele.orderNo=="[object Object]"||ele.orderNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.orderNo+"</td>";
							}
							//客户登录帐号
							if(ele.accountNo=="[object Object]"||ele.accountNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.accountNo+"</td>";
							}
							//客户编号
							if(ele.memberNo=="[object Object]"||ele.memberNo==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.memberNo+"</td>";
							}
							//退款状态
							if(ele.reMonStatus=="1"){
								option2+="<td align='center'><span>已退款</span></td>";
							}else if(ele.reMonStatus=="0"){
								option2+="<td align='center'><span>未退款</span></td>";
							}else{
								option2+="<td align='center'></td>";
							}
							//退款金额
							if(ele.needRefundMon=="[object Object]"||ele.needRefundMon==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.needRefundMon+"</td>";
							}
							//退款介质
							if(ele.reMonStatus=="14101"){
								option2+="<td align='center'><span>支付宝</span></td>";
							}else if(ele.reMonStatus=="14102"){
								option2+="<td align='center'><span>财务通</span></td>";
							}else if(ele.reMonStatus=="14103"){
								option2+="<td align='center'><span>银联</span></td>";
							}else if(ele.reMonStatus=="14104"){
								option2+="<td align='center'><span>工行</span></td>";
							}else if(ele.reMonStatus=="14109"){
								option2+="<td align='center'><span>微信支付</span></td>";
							}else if(ele.reMonStatus=="14105"){
								option2+="<td align='center'><span>移动支付宝</span></td>";
							}else if(ele.reMonStatus=="14106"){
								option2+="<td align='center'><span>余额退款</span></td>";
							}else{
								option2+="<td align='center'></td>";
							}
							//开户行
							if(ele.bankName=="[object Object]"||ele.bankName==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.bankName+"</td>";
							}
							//开户人
							if(ele.bankUse=="[object Object]"||ele.bankUse==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.bankUse+"</td>";
							}
							//卡号
							if(ele.bankType=="[object Object]"||ele.bankType==undefined){
								option2+="<td align='center'></td>";
							}else{
								option2+="<td align='center'>"+ele.bankType+"</td>";
							}
							//创建时间
							if(ele.allRefTimeStr=="[object Object]"||ele.allRefTimeStr==undefined){
								option2+="<td align='center'></td></tr>";
							}else{
								option2+="<td align='center'>"+ele.allRefTimeStr+"</td></tr>";
							}
						}
					}
				}
			});
		}
		var option3 = "<tr role='row' style='height:35px;'>"+
		"<th width='5%' style='text-align: center;'>退货单号</th>"+
		"<th width='5%' style='text-align: center;'>修改前状态</th>"+
		"<th width='5%' style='text-align: center;'>修改后状态</th>"+
		"<th width='5%' style='text-align: center;'>修改人</th>"+
		"<th width='5%' style='text-align: center;'>系统来源</th>"+
		"<th width='5%' style='text-align: center;'>修改时间</th>"+
		"<th width='5%' style='text-align: center;'>备注</th></tr>";
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/oms/selectRefundHistory",
			async:false,
			dataType: "json",
			data:{"refundNo":refundNo},
			success:function(response) {
				if(response.success=='true'){
					var result = response.list;
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						//退货单号
						if(ele.refundNo=="[object Object]"||ele.refundNo==undefined){
							option3+="<tr style='height:35px;overflow-X:hidden;'><td align='center'></td>";
						}else{
							option3+="<tr style='height:35px;overflow-X:hidden;'><td align='center'>"+ele.refundNo+"</td>";
						}
						//修改前状态
						if(ele.priviousStatus=="3001"){
							option3+="<td align='center'>草稿</td>";
						}else if(ele.priviousStatus=="3002"){
							option3+="<td align='center'>已打印退货单</td>";
						}else if(ele.priviousStatus=="3003"){
							option3+="<td align='center'>导购专柜收货</td>";
						}else if(ele.priviousStatus=="3004"){
							option3+="<td align='center'>取消</td>";
						}else if(ele.priviousStatus=="3005"){
							option3+="<td align='center'>主管已审核</td>";
						}else if(ele.priviousStatus=="21"){
							option3+="<td align='center'>待寄回</td>";
						}else if(ele.priviousStatus=="22"){
							option3+="<td align='center'>入集货</td>";
						}else if(ele.priviousStatus=="23"){
							option3+="<td align='center'>分拣复合</td>";
						}else if(ele.priviousStatus=="01"){
							option3+="<td align='center'>等待退回</td>";
						}else if(ele.priviousStatus=="02"){
							option3+="<td align='center'>检验异常</td>";
						}else if(ele.priviousStatus=="03"){
							option3+="<td align='center'>已入库</td>";
						}else if(ele.priviousStatus=="04"){
							option3+="<td align='center'>已返厂</td>";
						}else if(ele.priviousStatus=="99"){
							option3+="<td align='center'>已取消</td>";
						}else if(ele.priviousStatus=="24"){
							option3+="<td align='center'>出集货</td>";
						}else if(ele.priviousStatus=="5"){
							option3+="<td align='center'>入门店</td>";
						}else if(ele.priviousStatus=="6"){
							option3+="<td align='center'>门店复检</td>";
						}else if(ele.priviousStatus=="7"){
							option3+="<td align='center'>入专柜</td>";
						}else if(ele.priviousStatus=="8"){
							option3+="<td align='center'>入电商</td>";
						}else if(ele.priviousStatus=="9"){
							option3+="<td align='center'>入仓库</td>";
						}else if(ele.priviousStatus=="10"){
							option3+="<td align='center'>质检中</td>";
						/* }else if(ele.priviousStatus=="11"){
							option3+="<td align='center'>已入库</td>"; */
						}else if(ele.priviousStatus=="12"){
							option3+="<td align='center'>待退款</td>";
						}else if(ele.priviousStatus=="13"){
							option3+="<td align='center'>退款中</td>";
						}else if(ele.priviousStatus=="14"){
							option3+="<td align='center'>退款成功</td>";
						}else if(ele.priviousStatus=="15"){
							option3+="<td align='center'>已完结</td>";
						}else if(ele.priviousStatus=="16"){
							option3+="<td align='center'>质检异常</td>";
						}else if(ele.priviousStatus=="17"){
							option3+="<td align='center'>取消中</td>";
						}else if(ele.priviousStatus=="18"){
							option3+="<td align='center'>取消成功</td>";
						}else if(ele.priviousStatus=="19"){
							option3+="<td align='center'>待确认</td>";
						}else if(ele.priviousStatus=="20"){
							option3+="<td align='center'>无法取消</td>";
						}else{
							option3+="<td align='center'></td>";
						}
						//修改后状态
						if(ele.currentStatusDesc=="[object Object]"||ele.currentStatusDesc==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.currentStatusDesc+"</td>";
						}
						//修改人
						if(ele.updateMan=="[object Object]"||ele.updateMan==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.updateMan+"</td>";
						}
						//系统来源
						if(ele.operatorSource=="[object Object]"||ele.operatorSource==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.operatorSource+"</td>";
						}
						//修改时间
						if(ele.updateTimeStr=="[object Object]"||ele.updateTimeStr==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.updateTimeStr+"</td>";
						}
						//备注
						if(ele.remark=="[object Object]"||ele.remark==undefined){
							option3+="<td align='center'></td>";
						}else{
							option3+="<td align='center'>"+ele.remark+"</td>";
						}
					}
				}
			}
		});
		$("#OLV1_tab").html(option);
		$("#OLV2_tab").html(option2);
		$("#OLV3_tab").html(option3);
		$("#divTitle").html("退货单详情");
		$("#btDiv").show();
	}
	function closeBtDiv(){
		$("#btDiv").hide();
	}
	function closeBtDiv2(){
		$("#btDiv2").hide();
	}
	//导出excel
	function exportExecel() {
		var orderNo =  $("#orderNo_input").val();
		var refundApplyNo = $("#refundApplyNo_input").val();
		var refundNo = $("#refundNo_input").val();
		var originalSalesNo = $("#originalSalesNo_input").val();
		var memberNo = $("#memberNo_input").val();
		var salesPaymentNo = $("#salesPaymentNo_input").val();
		var refundStatus = $("#refundStatus_select").val();
		var shopNo = $("#shopNo_input").val();
		var rebateStatus = $("#rebateStatus_select").val();
		var refundType = $("#refundType_select").val();
		var refundClass = $("#refundClass_select").val();
		
		var strTime = $("#reservation").val();
		var endRefundTime;
		var startRefundTime;
		if(strTime!=""){
			strTime = strTime.split("-");
			startRefundTime = strTime[0].replace("/","-").replace("/","-");
			endRefundTime = strTime[1].replace("/","-").replace("/","-");
		}else{
			startRefundTime = $("#startRefundTime_form").val();
			endRefundTime = $("#endRefundTime_form").val();
		}
		var title = "refund";
		var count = $("#olv_tab tbody tr").length;
		if (count > 0
				/* && (orderNo != "" || refundApplyNo != "" || refundNo != "" || originalSalesNo != "" || memberNo != "" || salesPaymentNo != "" || startRefundTime != "" || endRefundTime != ""
						|| refundStatus != "" || shopNo != "" || rebateStatus != "" || refundType != "") */) {
			window.open(__ctxPath + "/omsOrder/getRefundToExcel?refundApplyNo="
					+ refundApplyNo + "&&orderNo=" + orderNo + "&&refundNo=" + refundNo + "&&originalSalesNo=" + originalSalesNo + "&&memberNo=" + memberNo
					+ "&&salesPaymentNo=" + salesPaymentNo + "&&endRefundTime=" + endRefundTime + "&&startRefundTime=" + startRefundTime + "&&refundStatus="
					+ refundStatus + "&&shopNo=" + shopNo + "&&rebateStatus=" + rebateStatus + "&&refundType=" + refundType + "&&refundClass=" + refundClass + "&&title="
					+ title +"&&pageSize=" + 1000 +"&&page=" + 1);
		} else {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><strong>出现异常无法正常导出Excel!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
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
                                    <h5 class="widget-caption">退货单查询</h5>
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
										            <label class="titname">退货时间：</label>
													<input type="text" id="reservation"/>
										        </li>
										        <li class="col-md-4">
										            <label class="titname">退货申请单号：</label>
													<input type="text" id="refundApplyNo_input"/>
										        </li>
										        <li class="col-md-4">
										            <label class="titname">退货单号：</label>
													<input type="text" id="refundNo_input"/>
											    </li>
										        <li class="col-md-4">
										            <label class="titname">订单号：</label>
													<input type="text" id="orderNo_input"/>
											    </li>
											    <li class="col-md-4">
										            <label class="titname">原销售单号：</label>
													<input type="text" id="originalSalesNo_input"/>
										        </li>
										        <li class="col-md-4">
										            <label class="titname">小票号：</label>
													<input type="text" id="salesPaymentNo_input"/>
										        </li>
										        <!-- <li class="col-md-4">
										            <label class="titname">门店号：</label>
													<input type="text" id="shopNo_input"/>
											    </li> -->
											    <li class="col-md-4">
                                   					<label class="titname">门&nbsp;&nbsp;&nbsp;店：</label>
                                   					<select id="shopNo_input" style="padding:0 0;">
			                                			<option id="op2" value="">所有</option>
			                                		</select>
                                   				</li>
											    <li class="col-md-4">
										            <label class="titname">退货单状态：</label>
													<select id="refundStatus_select" style="padding:0 0;">
                                                        <option value="">所有</option>
                                                        <!-- <option value="3001">草稿</option>
                                                        <option value="3002">已打印退货单</option>
                                                        <option value="3003">导购专柜收货</option>
                                                        <option value="3004">取消</option>
                                                        <option value="3005">主管已审核</option>
                                                        <option value="21">待寄回</option>
                                                        <option value="22">入集货</option>
                                                        <option value="23">分拣复合</option>
                                                        <option value="01">等待退回</option>
                                                        <option value="02">检验异常</option>
                                                        <option value="03">已入库</option>
                                                        <option value="04">已返厂</option>
                                                        <option value="99">已取消</option>
                                                        <option value="24">出集货</option>
                                                        <option value="5">入门店</option>
                                                        <option value="6">门店复检</option>
                                                        <option value="7">入专柜</option>
                                                        <option value="8">入电商</option>
                                                        <option value="9">入仓库</option>
                                                        <option value="10">质检中</option>
                                                               		<option value="11">已入库</option> 
                                                        <option value="12">待退款</option>
                                                        <option value="13">退款中</option>
                                                        <option value="14">退款成功</option>
                                                        <option value="15">已完结核</option>
                                                        <option value="16">质检异常</option>
                                                        <option value="17">取消中</option>
                                                        <option value="18">取消成功</option>
                                                        <option value="19">待确认</option>
                                                        <option value="20">无法取消</option> -->
                                                    </select>
										        </li>
										        <li class="col-md-4">
										            <label class="titname">退款状态：</label>
													<select id="rebateStatus_select" style="padding:0 0;">
                                                        <option value="">所有</option>
                                                        <!-- <option value="0">未退款</option>
                                                        <option value="1">已退款</option> -->
                                                    </select>
										        </li>
										        <li class="col-md-4">
										            <label class="titname">退货类型：</label>
													<select id="refundType_select" style="padding:0 0;">
                                                        <option value="">所有</option>
                                                        <option value="1">线上</option>
                                                        <option value="2">线下</option>
                                                    </select>
										        </li>
										        <li class="col-md-4">
										            <label class="titname">退货类别：</label>
													<select id="refundClass_select" style="padding:0 0;">
                                                        <option value="">所有</option>
                                                    </select>
										        </li>
										        <li class="col-md-4">
										            <label class="titname">会员卡号：</label>
													<input type="text" id="memberNo_input"/>
											    </li>
											    <li class="col-md-4">
										           	<a class="btn btn-default shiny" onclick="olvQuery();">查询</a>&nbsp;&nbsp;
													<a class="btn btn-default shiny" onclick="reset();">重置</a>&nbsp;&nbsp;
													<a class="btn btn-default shiny" onclick="exportExecel();">导出</a>
										            <!-- <a id="editabledatatable_new" onclick="olvQuery();"
                                                       class="btn btn-yellow" style="width: 37%;">
                                                        <i class="fa fa-eye"></i>查询
                                                    </a>
	                                        <a id="editabledatatable_new" onclick="reset();" class="btn btn-primary" style="width: 37%;">
                                                <i class="fa fa-random"></i>重置
                                            </a> -->
										    </li>
										</ul>
                                    
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="10"/>
											<input type="hidden" id="refundApplyNo_form" name="refundApplyNo"/>
											<input type="hidden" id="refundNo_form" name="refundNo"/>
											<input type="hidden" id="orderNo_form" name="orderNo"/>
											<input type="hidden" id="originalSalesNo_form" name="originalSalesNo"/>
											<input type="hidden" id="memberNo_form" name="memberNo"/>
											<input type="hidden" id="salesPaymentNo_form" name="salesPaymentNo"/>
											<input type="hidden" id="refundStatus_form" name="refundStatus"/>
											<input type="hidden" id="shopNo_form" name="shopNo"/>
											<input type="hidden" id="rebateStatus_form" name="rebateStatus"/>
											<input type="hidden" id="refundType_form" name="refundType"/>
											<input type="hidden" id="refundClass_form" name="refundClass"/>
											<input type="hidden" id="startRefundTime_form" name="startRefundTime"/>
											<input type="hidden" id="endRefundTime_form" name="endRefundTime"/>
                                      	</form>
                                	<div style="width:100%; height:0%; min-height:300px; overflow-Y:hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 350%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                <th width="4%" style="text-align: center;">退货单号</th>
                                                <th width="4%" style="text-align: center;">订单号</th>
                                                <th width="4%" style="text-align: center;">退货申请单号</th>
                                                <th width="4%" style="text-align: center;">原销售单号</th>
                                                <th width="3%" style="text-align: center;">退货单状态</th>
                                                <th width="3%" style="text-align: center;">退款状态</th>
                                                <th width="4%" style="text-align: center;">会员卡号</th>
                                                <th width="5%" style="text-align: center;">CID</th>
                                                <th width="3%" style="text-align: center;">退货类型</th>
                                                <th width="3%" style="text-align: center;">退货类别</th>
                                                <th width="4%" style="text-align: center;">退款路径</th>
                                                <th width="4%" style="text-align: center;">第三方退货单号</th>
                                                <th width="3%" style="text-align: center;">应退金额</th>
                                                <th width="3%" style="text-align: center;">实退金额</th>
                                                <th width="3%" style="text-align: center;">退货总数</th>
                                                <th width="4%" style="text-align: center;">门店名称</th>
                                                <th width="4%" style="text-align: center;">供应商编码</th>
                                                <th width="4%" style="text-align: center;">供应商名称</th>
                                                <th width="4%" style="text-align: center;">专柜名称</th>
                                                <th width="4%" style="text-align: center;">收银流水号</th>
                                                <th width="4%" style="text-align: center;">机器号</th>
                                                <th width="4%" style="text-align: center;">受理人</th>
                                                <th width="4%" style="text-align: center;">受理门店</th>
                                                <th width="4%" style="text-align: center;">退货时间</th>
                                                <th width="3%" style="text-align: center;">最后修改人</th>
                                                <th width="4%" style="text-align: center;">最后修改时间</th>
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
														<a id="{$T.Result.refundNo}" onclick="trClick('{$T.Result.refundNo}','{$T.Result.orderNo}','{$T.Result.refundApplyNo}','{$T.Result.refundType}',this);" style="cursor:pointer;">
															{#if $T.Result.refundNo != '[object Object]'}{$T.Result.refundNo}
						                   					{#/if}
														</a>
													</td>
													<td align="center" id="orderNo_{$T.Result.sid}">
														
						                   				<a id="{$T.Result.orderNo}_" onclick="trClick2('{$T.Result.refundNo}','{$T.Result.orderNo}','{$T.Result.refundApplyNo}',this);" style="cursor:pointer;">
															{#if $T.Result.orderNo != '[object Object]'}{$T.Result.orderNo}
						                   					{#/if}
														</a>
													</td>
													<td align="center" id="refundApplyNo_{$T.Result.sid}">
														
						                   				<a id="{$T.Result.refundApplyNo}_" onclick="trClick3('{$T.Result.refundNo}','{$T.Result.orderNo}','{$T.Result.refundApplyNo}',this);" style="cursor:pointer;">
															{#if $T.Result.refundApplyNo != '[object Object]'}{$T.Result.refundApplyNo}
							                   				{#/if}
														</a>
													</td>
													<td align="center" id="originalSalesNo_{$T.Result.sid}">
														{#if $T.Result.originalSalesNo != '[object Object]'}{$T.Result.originalSalesNo}
						                   				{#/if}
													</td>
													<td align="center" id="refundStatusDesc_{$T.Result.sid}">
														{#if $T.Result.refundStatusDesc != '[object Object]'}{$T.Result.refundStatusDesc}
						                   				{#/if}
													</td>
													<td align="center" id="rebateStatus_{$T.Result.sid}">
														{#if $T.Result.rebateStatus == '0'}
															<span>未退款</span>
						                      			{#elseif $T.Result.rebateStatus == '1'}
						                      				<span>已退款</span>
						                   				{#/if}
													</td>
													<td align="center" id="memberNo_{$T.Result.sid}">
														{#if $T.Result.memberNo != '[object Object]'}{$T.Result.memberNo}
						                   				{#/if}
													</td>
													<td align="center" id="accountNo_{$T.Result.sid}">
														{#if $T.Result.accountNo != '[object Object]'}{$T.Result.accountNo}
															<span>——</span>
						                   				{#/if}
													</td>
													<td align="center" id="refundType_{$T.Result.sid}">
														{#if $T.Result.refundType == '1'}
															<span>线上</span>
						                      			{#elseif $T.Result.refundType == '2'}
						                      				<span>线下</span>
						                   				{#/if}
													</td>
													<td align="center" id="refundClass_{$T.Result.sid}">
														{#if $T.Result.refundClass == 'RequestReturn'}正常退
						                      			{#elseif $T.Result.refundClass == 'RejectReturn'}
						                      				<span>拒收退</span>
						                      			{#elseif $T.Result.refundClass == '03'}
						                      				<span>退货退款</span>
						                      			{#elseif $T.Result.refundClass == 'RequestCancelReturn'}
						                      				<span>发货前退货</span>
						                      			{#elseif $T.Result.refundClass == 'OOSReturn'}
						                      				<span>缺货退货</span>
						                      			{#elseif $T.Result.refundClass == 'THD'}
						                      				<span>退货单</span>
						                   				{#/if}
													</td>
													<td align="center" id="refundTarget_{$T.Result.sid}">
														{#if $T.Result.refundTarget == '1'}原路退
						                      			{#elseif $T.Result.refundTarget == '2'}站内余额
						                   				{#/if}
													</td>
													<td align="center" id="externalRefundNo_{$T.Result.sid}">
														{#if $T.Result.externalRefundNo != '[object Object]'}{$T.Result.externalRefundNo}
						                   				{#/if}
													</td>
													<td align="center" id="refundAmount_{$T.Result.sid}">
														{#if $T.Result.refundAmount != '[object Object]'}{$T.Result.refundAmount}
						                   				{#/if}
													</td>
													<td align="center" id="needRefundAmount_{$T.Result.sid}">
														{#if $T.Result.needRefundAmount != '[object Object]'}{$T.Result.needRefundAmount}
						                   				{#/if}
													</td>
													<td align="center" id="refundNum_{$T.Result.sid}">
														{#if $T.Result.refundNum != '[object Object]'}{$T.Result.refundNum}
						                   				{#/if}
													</td>
													<td align="center" id="shopName_{$T.Result.sid}">
														{#if $T.Result.shopName != '[object Object]'}{$T.Result.shopName}
						                   				{#/if}
													</td>
													<td align="center" id="supplyNo_{$T.Result.sid}">
														{#if $T.Result.supplyNo != '[object Object]'}{$T.Result.supplyNo}
						                   				{#/if}
													</td>
													<td align="center" id="supplyName_{$T.Result.sid}">
														{#if $T.Result.supplyName != '[object Object]'}{$T.Result.supplyName}
						                   				{#/if}
													</td>
													<td align="center" id="shoppeName_{$T.Result.sid}">
														{#if $T.Result.shoppeName != '[object Object]'}{$T.Result.shoppeName}
						                   				{#/if}
													</td>
													<td align="center" id="salesPaymentNo_{$T.Result.sid}">
														{#if $T.Result.salesPaymentNo != '[object Object]'}{$T.Result.salesPaymentNo}
						                   				{#/if}
													</td>
													<td align="center" id="casherNo_{$T.Result.sid}">
														{#if $T.Result.casherNo != '[object Object]'}{$T.Result.casherNo}
						                   				{#/if}
													</td>
													<td align="center" id="operator_{$T.Result.sid}">
														{#if $T.Result.operator != '[object Object]'}{$T.Result.operator}
						                   				{#/if}
													</td>
													<td align="center" id="operatorStore_{$T.Result.sid}">
														{#if $T.Result.operatorStore != '[object Object]'}{$T.Result.operatorStore}
						                   				{#/if}
													</td>
													<td align="center" id="refundTimeStr_{$T.Result.sid}">
														{#if $T.Result.refundTimeStr != '[object Object]'}{$T.Result.refundTimeStr}
						                   				{#/if}
													</td>
													<td align="center" id="latestUpdateMan_{$T.Result.sid}">
														{#if $T.Result.latestUpdateMan != '[object Object]'}{$T.Result.latestUpdateMan}
						                   				{#/if}
													</td>
													<td align="center" id="latestUpdateTimeStr_{$T.Result.sid}">
														{#if $T.Result.latestUpdateTimeStr != '[object Object]'}{$T.Result.latestUpdateTimeStr}
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
			                
			                 <table class="table-striped table-hover table-bordered" style="width: 450%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                               	<th width="4%" style="text-align: center;">退货单号</th>
                                                <th width="4%" style="text-align: center;">订单号</th>
                                                <th width="4%" style="text-align: center;">退货申请单号</th>
                                                <th width="4%" style="text-align: center;">原销售单号</th>
                                                <th width="3%" style="text-align: center;">退货单状态</th>
                                                <th width="3%" style="text-align: center;">退款状态</th>
                                                <th width="4%" style="text-align: center;">会员卡号</th>
                                                <th width="4%" style="text-align: center;">CID</th>
                                                <th width="3%" style="text-align: center;">退货类型</th>
                                                <th width="3%" style="text-align: center;">退货类别</th>
                                                <th width="4%" style="text-align: center;">退款路径</th>
                                                <th width="4%" style="text-align: center;">第三方退货单号</th>
                                                <th width="3%" style="text-align: center;">应退金额</th>
                                                <th width="3%" style="text-align: center;">实退金额</th>
                                                <th width="3%" style="text-align: center;">退货总数</th>
                                                <th width="4%" style="text-align: center;">门店名称</th>
                                                <th width="4%" style="text-align: center;">供应商编码</th>
                                                <th width="4%" style="text-align: center;">供应商名称</th>
                                                <th width="4%" style="text-align: center;">专柜名称</th>
                                                <th width="4%" style="text-align: center;">收银流水号</th>
                                                <th width="4%" style="text-align: center;">机器号</th>
                                                <th width="4%" style="text-align: center;">受理人</th>
                                                <th width="4%" style="text-align: center;">受理门店</th>
                                                <th width="4%" style="text-align: center;">退货时间</th>
                                                <th width="3%" style="text-align: center;">最后修改人</th>
                                                <th width="4%" style="text-align: center;">最后修改时间</th>
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
					        <li class="active"><a href="#tab1" data-toggle="tab">退货单商品明细</a></li>
					        <li><a href="#tab2" data-toggle="tab">退款信息</a></li>
							<li><a href="#tab3" data-toggle="tab">历史信息</a></li>
					      </ul>
					      <div class="tab-content">
					        <div class="tab-pane active" id="tab1">
					                <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV1_tab" style="width: 700%;height:35px;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					        </div>
					        <div class="tab-pane" id="tab2">
					          <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 400%;height:35px;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					        </div>
					         <div class="tab-pane" id="tab3">
					         	<div style="width:100%;height:200px;overflow:scroll; ">
					                    <table class="table-striped table-hover table-bordered" id="OLV3_tab" style="width: 150%;background-color: #fff;margin-bottom: 0;">
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
     <!-- 订单 -->
    <div class="modal modal-darkorange" id="btDiv21">
        <div class="modal-dialog" style="width: 800px;height:80%;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv21();">×</button>
                    <h4 class="modal-title" id="divTitle21"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div  class="col-xs-12 col-md-12" style="overflow-Y: hidden;">
			               <table class="table-striped table-hover table-bordered" style="width: 500%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                 <th width="4%" style="text-align: center;">退货单号</th>
                                                <th width="4%" style="text-align: center;">订单号</th>
                                                <th width="4%" style="text-align: center;">退货申请单号</th>
                                                <th width="4%" style="text-align: center;">原销售单号</th>
                                                <th width="3%" style="text-align: center;">退货单状态</th>
                                                <th width="3%" style="text-align: center;">退款状态</th>
                                                <th width="4%" style="text-align: center;">会员卡号</th>
                                                <th width="4%" style="text-align: center;">CID</th>
                                                <th width="3%" style="text-align: center;">退货类型</th>
                                                <th width="3%" style="text-align: center;">退货类别</th>
                                                <th width="4%" style="text-align: center;">退款路径</th>
                                                <th width="4%" style="text-align: center;">第三方退货单号</th>
                                                <th width="3%" style="text-align: center;">应退金额</th>
                                                <th width="3%" style="text-align: center;">实退金额</th>
                                                <th width="3%" style="text-align: center;">退货总数</th>
                                                <th width="4%" style="text-align: center;">门店名称</th>
                                                <th width="4%" style="text-align: center;">供应商编码</th>
                                                <th width="4%" style="text-align: center;">供应商名称</th>
                                                <th width="4%" style="text-align: center;">专柜名称</th>
                                                <th width="4%" style="text-align: center;">收银流水号</th>
                                                <th width="4%" style="text-align: center;">机器号</th>
                                                <th width="4%" style="text-align: center;">受理人</th>
                                                <th width="4%" style="text-align: center;">受理门店</th>
                                                <th width="4%" style="text-align: center;">退货时间</th>
                                                <th width="3%" style="text-align: center;">最后修改人</th>
                                                <th width="4%" style="text-align: center;">最后修改时间</th>
                                            </tr>
                                        </thead>
                                        <tbody id="mainTr2">
                                        </tbody>
                                    </table>
                		</div>
                	</div>
                </div>
                    <div class="tabbable"> <!-- Only required for left/right tabs -->
					      <ul class="nav nav-tabs">
					        <li class="active"><a href="#tab21" data-toggle="tab">订单明细</a></li>
					        <li><a href="#tab23" data-toggle="tab">支付信息</a></li>
					        <li><a href="#tab22" data-toggle="tab">包裹信息</a></li>
							<li><a href="#tab24" data-toggle="tab">历史信息</a></li>
							<li><a href="#tab25" data-toggle="tab">销售单信息</a></li>
							<li><a href="#tab26" data-toggle="tab">发票信息</a></li>
					      </ul>
					      <div class="tab-content">
					        <div class="tab-pane active" id="tab21">
					            <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV21_tab" style="width: 750%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					              </div>
					        </div>
					        <div class="tab-pane" id="tab23">
					          <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV23_tab" style="width: 250%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					        </div>
					        <div class="tab-pane" id="tab22">
					          <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV22_tab" style="width: 250%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					        </div>
					         <div class="tab-pane" id="tab24">
					         	<div style="width:100%;height:200px;overflow:scroll; ">
					                    <table class="table-striped table-hover table-bordered" id="OLV24_tab" style="width: 150%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					         </div>
					          <div class="tab-pane" id="tab25">
					          	<div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV25_tab" style="width: 450%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					             </div>
					        </div>
					          <div class="tab-pane" id="tab26">
					          	<div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV26_tab" style="width: 150%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					             </div>
					        </div>
					       
					      </div>
					    </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv21();" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>  
    <!-- 退货申请单明细 -->
     <div class="modal modal-darkorange" id="btDiv31">
        <div class="modal-dialog" style="width: 800px;height:80%;margin: 3% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv31();">×</button>
                    <h4 class="modal-title" id="divTitle31"></h4>
                </div>
                <div class="page-body" id="pageBodyRight">
                    <div class="row">
                        <div class="col-xs-12 col-md-12" style="overflow-Y: hidden;">
			                
			                 <table class="table-striped table-hover table-bordered" style="width: 450%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                 <th width="4%" style="text-align: center;">退货单号</th>
                                                <th width="4%" style="text-align: center;">订单号</th>
                                                <th width="4%" style="text-align: center;">退货申请单号</th>
                                                <th width="4%" style="text-align: center;">原销售单号</th>
                                                <th width="3%" style="text-align: center;">退货单状态</th>
                                                <th width="3%" style="text-align: center;">退款状态</th>
                                                <th width="5%" style="text-align: center;">会员卡号</th>
                                                <th width="5%" style="text-align: center;">CID</th>
                                                <th width="3%" style="text-align: center;">退货类型</th>
                                                <th width="3%" style="text-align: center;">退货类别</th>
                                                <th width="4%" style="text-align: center;">退款路径</th>
                                                <th width="4%" style="text-align: center;">第三方退货单号</th>
                                                <th width="3%" style="text-align: center;">应退金额</th>
                                                <th width="3%" style="text-align: center;">实退金额</th>
                                                <th width="3%" style="text-align: center;">退货总数</th>
                                                <th width="4%" style="text-align: center;">门店名称</th>
                                                <th width="4%" style="text-align: center;">供应商编码</th>
                                                <th width="4%" style="text-align: center;">供应商名称</th>
                                                <th width="4%" style="text-align: center;">专柜名称</th>
                                                <th width="4%" style="text-align: center;">收银流水号</th>
                                                <th width="4%" style="text-align: center;">机器号</th>
                                                <th width="4%" style="text-align: center;">受理人</th>
                                                <th width="4%" style="text-align: center;">受理门店</th>
                                                <th width="4%" style="text-align: center;">退货时间</th>
                                                <th width="3%" style="text-align: center;">最后修改人</th>
                                                <th width="4%" style="text-align: center;">最后修改时间</th>
                                            </tr>
                                        </thead>
                                        <tbody id="mainTr3">
                                        </tbody>
                                    </table>
			                
                		</div>
                	</div>
                </div>
                
                
                
                <div class="tabbable"> <!-- Only required for left/right tabs -->
					      <ul class="nav nav-tabs">
					        <li class="active"><a href="#tab31" data-toggle="tab">退货申请单明细</a></li>
							<li><a href="#tab33" data-toggle="tab">历史信息</a></li>
					      </ul>
					      <div class="tab-content">
					        <div class="tab-pane active" id="tab31">
					                <div style="width:100%;height:200px; overflow:scroll;">
					                    <table class="table-striped table-hover table-bordered" id="OLV31_tab" style="width: 650%;height:35px;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					        </div>
					         <div class="tab-pane" id="tab33">
					         	<div style="width:100%;height:200px;overflow:scroll; ">
					                    <table class="table-striped table-hover table-bordered" id="OLV33_tab" style="width: 150%;background-color: #fff;margin-bottom: 0;">
					                    </table>
					                </div>
					         </div>
					      </div>
					    </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeBtDiv31();" type="button">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div> 
    <div class="modal modal-darkorange" id="btDiv2">
        <div class="modal-dialog" style="width:200px; height:500%; margin: 15% auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeBtDiv2();">×</button>
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