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
		$.ajax({url:__ctxPath + "/order/getShop.json",dataType:"json",async:false,success:function(response){
			var result = response.result;
          	 var option = "<option value=''>所有</option>";
          	 for(var i=0;i<result.length;i++){
          		 var ele = result[i];
          		 option+="<option value='"+ele.sid+"'>"+ele.shopName+"</option>";
          	 }
          	 $("#shopSid_select").append(option);
 		}});
		$('#reservation').daterangepicker();
	    initOlv();
	});
	function olvStat(){
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
		$("#shopSid_form").val($("#shopSid_select").val());
        var params = $("#olv_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	function reset(){
		$("#reservation").val("");
		$("#shopName_select").val("");
		olvStat();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/order/selectReturnForFinListByParam";
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
            	//支付类型
            	 $.ajax({url:__ctxPath + "/DataDictionary/getItemType?dictTypeCode=1",dataType:"json",async:false,success:function(response){
             		var result = response.list;
             		for(var j=0;j<result.length;j++){
	             		for(var i=0;i<data.list.length;i++){
	             			var ele = data.list[i];
	           				if(ele.paymentTypeSid==result[j].dictItemCode){
	           					data.list[i].paymentTypeSid=result[j].dictItemName;
	           				}
	               	 	}
             		}
				 }});
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
             }
           }
         });
    }
	
 	//导出excel
 	function exportExcel(){
 		var shopSid = $("#shopSid_select").val();
		var strTime = $("#reservation").val();
		if (strTime != "") {
			strTime = strTime.split("-");
			var startReturnTime = strTime[0].replace("/", "-").replace("/", "-");
			var	endReturnTime= strTime[1].replace("/", "-").replace("/", "-");
		} else {
			var startReturnTime = "";
			var	endReturnTime= "";
		}
		endReturnTime=$.trim(endReturnTime);
		var count =  $("#olv_tab tbody tr").length;
		if(count>0){
			window.open(__ctxPath+"/cod/exportReturnExcel?startReturnTime="+startReturnTime+"&&endReturnTime="+endReturnTime
					+"&&shopSid="+shopSid+"&&count="+count +"&&title=RefundExcelFOrDay");
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
 	
 	
 	function clearNoNum(event,obj){
		//响应鼠标事件，允许左右方向键移动
		event = window.event||event;
		if(event.keyCode == 37 | event.keyCode == 39){
			return;
		}
		//先把非数字的都替换掉，除了数字和.-
		obj.value = obj.value.replace(/[^\d.]/g,"");
		//把不是在第一个的所有的-都删除
		var index = obj.value.indexOf("-");
		if(index!=0){
			obj.value = obj.value.replace(/-/g,"");
		}
		//必须保证第一个为数或-字而不是.
		obj.value = obj.value.replace(/^\./g,"");        
		//保证只有出现一个.而没有多个.
		obj.value = obj.value.replace(/\.-{2,}/g,".");
		//保证.只出现一次，而不能出现两次以上
		obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		obj.value = obj.value.replace("-","$#$").replace(/\-/g,"").replace("$#$","-");
		var index = obj.value.indexOf(".");
		if(index!=-1){
			var flag = index+3;
			if(obj.value.length>flag){
				obj.value =obj.value.substring(0,flag);
			}
		}
    }
	function checkNum(obj){
		//为了去除最后一个.
		obj.value = obj.value.replace(/\.$/g,"");
		obj.value =formatFloat(obj.value,2);
		//alert(formatFloat(obj.value,2));
	}
	function formatFloat(src, pos){
	     return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
	} 
	function checkCount(obj){
		obj.value = obj.value.match(/^[1-9]\d*|0$/);
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
                                    <span class="widget-caption"><h5>退货单统计列表管理</h5></span>
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
	                                		<div class="col-lg-5">时&nbsp;&nbsp;间：</div>
	                                		<div class="col-lg-7">
                                   				<input type="text" id="reservation"  style="width: 100%;"/>
                                   			</div>
                                		</div>
                                		
                                		<div class="col-md-4">
                                			<div class="col-lg-4">
	                                			<span>门&nbsp;&nbsp;  店：</span>
	                                		</div>
	                                		<div class="col-lg-8">
	                                			<select id="shopSid_select" style="padding:0 0;width: 100%;"></select>
	                                		</div>
	                                	</div>
                                		
                                		<div class="col-md-2">
	                                    	<a id="editabledatatable_new" onclick="olvStat();" class="btn btn-yellow" style="width: 100%;">
	                                    		<i class="fa fa-eye"></i>
												统计
	                                        </a>
	                                    </div>
	                                    <div class="col-md-2">
	                                        <a id="editabledatatable_new" onclick="reset();" class="btn btn-primary" style="width: 100%;">
	                                        	<i class="fa fa-random"></i>
												重置
	                                        </a>&nbsp;
	                                    </div>
                                		<div class="col-md-4">
                                    		<div class="col-lg-5">
                                    			<span>退款总金额：</span>
                                    		</div>
                                    		<div class="col-lg-7">
                                    			<input type="text" id="refundTotalMoney_input" style="width: 100%;" placeholder="0.00" />
                                    		</div>&nbsp;
                                    	</div>
                                		<div class="col-md-4">
                                			<div class="col-lg-6">
	                                        <a id="editabledatatable_new" onclick="exportExcel();" class="btn btn-darkorange" style="width: 100%;">
	                                        	<i class="fa fa-share-alt"></i>
												导出EXCEL
	                                        </a>&nbsp;
	                                        </div>
	                                    </div>
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="15"/>
											<input type="hidden" id="startSaleTime_form" name="startReturnTime"/>
											<input type="hidden" id="endSaleTime_form" name="endReturnTime"/>
											<input type="hidden" id="shopSid_form" name="shopSid"/>
                                      	</form>
                                	<div style="width:100%; height:225px; overflow:scroll;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row">
                                                <th width="5%" style="text-align: center;">调入POS时间</th>
                                                <th width="5%" style="text-align: center;">退货门店</th>
                                                <th width="4%" style="text-align: center;">销售编码</th>
                                                <th width="4%" style="text-align: center;">订单号</th>
                                                <th width="4%" style="text-align: center;">父订单号</th>
                                                <th width="4%" style="text-align: center;">退货单号 </th>
                                                <th width="4%" style="text-align: center;">原销售单号</th>
                                                <th width="4%" style="text-align: center;">流水号</th>
                                                <th width="5%" style="text-align: center;">退货数量</th>
                                                <th width="4%" style="text-align: center;">退货金额</th>
                                                <th width="4%" style="text-align: center;">退货原因</th>
                                                <th width="4%" style="text-align: center;">购买时间</th>
                                                <th width="5%" style="text-align: center;">支付方式</th>
												<th width="5%" style="text-align: center;">备注</th>
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
												<tr class="gradeX" id="gradeX{$T.Result.sid}" )">
													<td align="center" id="cashReturnedTime_{$T.Result.sid}">{$T.Result.cashReturnedTime}</td>
													<td align="center" id="shopName_{$T.Result.sid}">{$T.Result.shopName}</td>
													<td align="center" id="saleCode_{$T.Result.sid}">{$T.Result.saleCode}</td>
													<td align="center" id="orderNo_{$T.Result.sid}">{$T.Result.orderNo}</td>
													<td align="center" id="parentOrderNo_{$T.Result.sid}">{$T.Result.parentOrderNo}</td>
													<td align="center" id="refundNo_{$T.Result.sid}">{$T.Result.refundNo}</td>
													<td align="center" id="saleNo_{$T.Result.sid}">{$T.Result.saleNo}</td>
													<td align="center" id="cashierNumber_{$T.Result.sid}">{$T.Result.cashierNumber}</td>
													<td align="center" id="refundNum_{$T.Result.sid}">{$T.Result.refundNum}</td>
													<td align="center" id="refundMoneySum_{$T.Result.sid}">{$T.Result.refundMoneySum}</td>
													<td align="center" id="refundDesc_{$T.Result.sid}">{$T.Result.refundDesc}</td>
													<td align="center" id="saleTime_{$T.Result.sid}">{$T.Result.saleTime}</td>
													<td align="center" id="paymentTypeSid_{$T.Result.sid}">{$T.Result.paymentTypeSid}</td>
													<td align="center" id="memo_{$T.Result.sid}">{$T.Result.memo}</td>
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