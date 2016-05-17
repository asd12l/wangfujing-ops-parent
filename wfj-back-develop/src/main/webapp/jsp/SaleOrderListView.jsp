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
		$.ajax({url:__ctxPath + "/DataDictionary/getItemType?dictTypeCode="+51,dataType:"json",async:false,success:function(response){
    		var result = response.list;
           	 var option = "<option value=''>所有</option>";
           	 for(var i=0;i<result.length;i++){
           		 var ele = result[i];
           		 option+="<option value='"+ele.dictItemCode+"'>"+ele.dictItemName+"</option>";
           	 }
           	 $("#shopName_select").append(option);
 		}});
		$('#reservation').daterangepicker();
	    initOlv();
	});
	function olvQuery(){
		$("#orderNo_form").val($("#orderNo_input").val());
		$("#saleSid_form").val($("#saleSid_select").val());
		$("#saleStatus_form").val($("#saleStatus_select").val());
		$("#shopName_form").val($("#shopName_select").val());
		$("#saleType_form").val($("#saleType_select").val());
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
		$("#saleSid_select").val("");
		$("#saleStatus_select").val("");
		$("#shopName_select").val("");
		$("#saleType_select").val("");
		$("#state_select").val("");
		$("#orderSourceSid_select").val("");
		$("#reservation").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/order/selectPageSaleListByParamBack";
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
	
	//点击tr事件
	function trClick(saleSid){
		$("#OLV2_tab").html("<tr role='row'>"+
				"<th width='5%' style='text-align: center;'>销售单SID</th>"+
				"<th width='5%' style='text-align: center;'>商品明细SID</th>"+
				"<th width='12%' style='text-align: center;'>商品名称</th>"+
				"<th width='10%' style='text-align: center;'>品牌名称</th>"+
				"<th width='6%' style='text-align: center;'>商品SKU</th>"+
				"<th width='6%' style='text-align: center;'>包装单位</th>"+
				"<th width='6%' style='text-align: center;'>计量单位</th>"+
				"<th width='4%' style='text-align: center;'>厂家原始价格</th>"+
				"<th width='4%' style='text-align: center;'>现价</th>"+
				"<th width='4%' style='text-align: center;'>促销价</th>"+
				"<th width='5%' style='text-align: center;'>销售价</th>"+
				"<th width='5%' style='text-align: center;'>销售数量</th>"+
				"<th width='5%' style='text-align: center;'>已退数量</th>"+
				"<th width='5%' style='text-align: center;'>库存类别</th></tr>");
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/order/selectSaleDetailListByOrderSid",
			async:false,
			dataType: "json",
			data:{"saleSid":saleSid},
			success:function(response) {
				if(response.success='true'){
					var result = response.list;
					var option = "";
					for(var i=0;i<result.length;i++){
						var ele = result[i];
						option +="<tr><td align='center'>"+ele.saleSid+"</td>"+
							"<td align='center'>"+ele.proDetailSid+"</td>"+
							"<td align='center'>"+ele.productName+"</td>"+
							"<td align='center'>"+ele.brandName+"</td>"+
							"<td align='center'>"+ele.proSku+"</td>"+
							"<td align='center'>"+ele.proColor+"</td>"+
							"<td align='center'>"+ele.proSize+"</td>"+
							"<td align='center'>"+ele.originalPrice+"</td>"+
							"<td align='center'>"+ele.currentPrice+"</td>"+
							"<td align='center'>"+ele.promotionPrice+"</td>"+
							"<td align='center'>"+ele.salePrice+"</td>"+
							"<td align='center'>"+ele.saleSum+"</td>"+
							"<td align='center'>"+ele.refundNum+"</td>";
						if(ele.stockTypeSid=="0"){
							option+="<td align='center'>正品库</td></tr>";
						}else if(ele.stockTypeSid=="1"){
							option+="<td align='center'>次品库</td></tr>";
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
                                    <span class="widget-caption"><h5>销售单管理</h5></span>
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
                                    			<span>订单号：</span>
                                    		</div>
                                    		<div class="col-lg-7">
                                    			<input type="text" id="orderNo_input" style="width: 100%;"/>
                                    		</div>
                                    	</div>
                                    	<div class="col-md-4">
                                    		<div class="col-lg-4">
                                    			<span>销售单号：</span>
                                    		</div>
                                    		<div class="col-lg-8">
                                				<input type="text" id="saleNo_input" style="width: 100%;"/>
                                			</div>
                                    	</div>
                                    	<div class="col-md-4">
                                    		<div class="col-lg-4">
                                    			<span>小票号：</span>
                                    		</div>
                                    		<div class="col-lg-8">
                                				<input type="text" id="saleSid_input" style="width: 100%;"/>&nbsp;
                                			</div>
                                    	</div>
                                    	<div class="col-md-4">
                                    		<div class="col-lg-5">
	                                			<span>销售单状态：</span>
	                                		</div>
	                                		<div class="col-lg-7">
		                                		<select id="saleStatus_select" style="padding:0 0;width: 100%;">
		                                			<option value="">所有</option>
		                                			<option value="-1">作废</option>
		                                			<option value="0">草稿</option>
		                                			<option value="1">等待导购确认是否有货</option>
		                                			<option value="2">导购确认有货</option>
		                                			<option value="3">已打印未付款</option>
		                                			<option value="4">已付款未提货</option>
		                                			<option value="5">已付款已提货</option>
		                                			<option value="6">导购确认无货</option>
		                                		</select>
		                                	</div>
                                		</div>
                                		<div class="col-md-4">
                                			<div class="col-lg-4">
	                                			<span>门&nbsp;&nbsp;  店：</span>
	                                		</div>
	                                		<div class="col-lg-8">
	                                			<select id="shopName_select" style="padding:0 0;width: 100%;"></select>
	                                		</div>
	                                	</div>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-4">
	                                			<span>销售类别：</span>
	                                		</div>
	                                		<div class="col-lg-8">
		                                		<select id="saleType_select" style="padding:0 0;width: 100%;">
		                                			<option value="">所有</option>
		                                			<option value="1">网络</option>
		                                			<option value="0">实体</option>
		                                		</select>&nbsp;
		                                	</div>
	                                	</div>
	                                	<div class="col-md-4">
	                                		<div class="col-lg-3">时间：</div>
	                                		<div class="col-lg-9">
                                   				<input type="text" id="reservation"  style="width: 100%;"/>
                                   			</div>
                                		</div>
	                                	<div class="col-md-8">
	                                		<div class="col-lg-5">
	                                			<a class="btn btn-default" onclick="olvQuery();">查询</a>
	                                			<a class="btn btn-default" onclick="reset();">重置</a>
	                                		</div>&nbsp;
                                		</div>
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="15"/>
											<input type="hidden" id="orderNo_form" name="orderNo"/>
											<input type="hidden" id="saleSid_form" name="saleSid"/>
											<input type="hidden" id="saleStatus_form" name="saleStatus"/>
											<input type="hidden" id="shopName_form" name="shopName"/>
											<input type="hidden" id="saleType_form" name="saleType"/>
											<input type="hidden" id="startSaleTime_form" name="startSaleTime"/>
											<input type="hidden" id="endSaleTime_form" name="endSaleTime"/>
                                      	</form>
                                	<div style="width:1070px; height:225px; overflow:scroll;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row">
                                                <th width="7%" style="text-align: center;">销售单号</th>
                                                <th width="7%" style="text-align: center;">订单号</th>
                                                <th width="4%" style="text-align: center;">销售类别</th>
                                                <th width="4%" style="text-align: center;">销售单状态</th>
                                                <th width="4%" style="text-align: center;">退货状态</th>
                                                <th width="4%" style="text-align: center;">门店名称</th>
                                                <th width="4%" style="text-align: center;">销售数量</th>
                                                <th width="4%" style="text-align: center;">销售单金额</th>
                                                <th width="5%" style="text-align: center;">销售时间</th>
                                                <th width="4%" style="text-align: center;">收银时间</th>
                                                <th width="4%" style="text-align: center;">收银流水号</th>
                                                <th width="4%" style="text-align: center;">退货方式</th>
                                                <th width="5%" style="text-align: center;">销售编码</th>
                                                <th width="5%" style="text-align: center;">会员卡号</th>
                                                <th width="5%" style="text-align: center;">发票状态</th>
                                                <th width="5%" style="text-align: center;">打印次数</th>
                                                <th width="5%" style="text-align: center;">二维码状态</th>
                                                <th width="5%" style="text-align: center;">备注</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    </div>
                                    <div id="olvPagination"></div>
                                    <div style="width:1070px; height:95px; overflow:scroll;">
                                    <table class="table-striped table-hover table-bordered" id="OLV2_tab" style="width: 180%;background-color: #fff;margin-bottom: 0;">
                                        <tr role='row'>
											<th width='5%' style='text-align: center;'>销售单SID</th>
											<th width='5%' style='text-align: center;'>商品明细SID</th>
											<th width='12%' style='text-align: center;'>商品名称</th>
											<th width='10%' style='text-align: center;'>品牌名称</th>
											<th width='6%' style='text-align: center;'>商品SKU</th>
											<th width='6%' style='text-align: center;'>包装单位</th>
											<th width='6%' style='text-align: center;'>计量单位</th>
											<th width='4%' style='text-align: center;'>厂家原始价格</th>
											<th width='4%' style='text-align: center;'>现价</th>
											<th width='4%' style='text-align: center;'>促销价</th>
											<th width='5%' style='text-align: center;'>销售价</th>
											<th width='5%' style='text-align: center;'>销售数量</th>
											<th width='5%' style='text-align: center;'>已退数量</th>
											<th width='5%' style='text-align: center;'>库存类别</th>
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
													<td align="center" id="saleNo_{$T.Result.sid}">{$T.Result.saleNo}</td>
													<td align="center" id="orderNo_{$T.Result.sid}">{$T.Result.orderNo}</td>
													<td align="center" id="saleType_{$T.Result.sid}">
														{#if $T.Result.saleType == '0'}实体
						                      			{#elseif $T.Result.saleType == '1'}网络
						                   				{#/if}
													</td>
													<td align="center" id="saleStatus_{$T.Result.sid}">
														{#if $T.Result.saleStatus == '-1'}作废
						                      			{#elseif $T.Result.saleStatus == '0'}草稿
						                      			{#elseif $T.Result.saleStatus == '1'}等待导购确认是否有货
						                      			{#elseif $T.Result.saleStatus == '2'}导购确认有货
						                      			{#elseif $T.Result.saleStatus == '3'}已打印未付款
						                      			{#elseif $T.Result.saleStatus == '4'}已付款未提货
						                      			{#elseif $T.Result.saleStatus == '5'}已付款已提货
						                      			{#elseif $T.Result.saleStatus == '6'}导购确认无货
						                   				{#/if}
													</td>
													<td align="center" id="refundStatus_{$T.Result.sid}">
														{#if $T.Result.refundStatus == '-1'}作废
						                      			{#elseif $T.Result.refundStatus == '0'}草稿
						                      			{#elseif $T.Result.refundStatus == '1'}等待导购确认是否有货
						                      			{#elseif $T.Result.refundStatus == '2'}导购确认有货
						                      			{#elseif $T.Result.refundStatus == '3'}已打印未付款
						                      			{#elseif $T.Result.refundStatus == '4'}已付款未提货
						                      			{#elseif $T.Result.refundStatus == '5'}已付款已提货
						                      			{#elseif $T.Result.refundStatus == '6'}导购确认无货
						                   				{#/if}
													</td>
													<td align="center" id="shopName_{$T.Result.sid}">{$T.Result.shopName}</td>
													<td align="center" id="saleNumSum_{$T.Result.sid}">{$T.Result.saleNumSum}</td>
													<td align="center" id="saleMoneySum_{$T.Result.sid}">{$T.Result.saleMoneySum}</td>
													<td align="center" id="draftTime_{$T.Result.sid}">{$T.Result.draftTime}</td>
													<td align="center" id="cashTakeTime_{$T.Result.sid}">{$T.Result.cashTakeTime}</td>
													<td align="center" id="cashierNumber_{$T.Result.sid}">{$T.Result.cashierNumber}</td>
													<td align="center" id="refundTotalBit_{$T.Result.sid}">
														{#if $T.Result.refundTotalBit == '0'}没有退货
														{#elseif $T.Result.refundTotalBit == '1'}部分退货
														{#elseif $T.Result.refundTotalBit == '2'}整单退货
														{#/if}
													</td>
													<td align="center" id="saleCode_{$T.Result.sid}">{$T.Result.saleCode}</td>
													<td align="center" id="cardId_{$T.Result.sid}">{$T.Result.cardId}</td>
													<td align="center" id="invoiceStatus_{$T.Result.sid}">
														{#if $T.Result.invoiceStatus == '-1'}已收回
														{#elseif $T.Result.invoiceStatus == '0'}未开启
														{#elseif $T.Result.invoiceStatus == '1'}已开取
														{#/if}
													</td>
													<td align="center" id="printTimes_{$T.Result.sid}">{$T.Result.printTimes}</td>
													<td align="center" id="qrcodeStatus_{$T.Result.sid}">
														{#if $T.Result.invoiceStatus == '-1'}作废
														{#elseif $T.Result.invoiceStatus == '0'}初始
														{#elseif $T.Result.invoiceStatus == '1'}等待
														{#elseif $T.Result.invoiceStatus == '1'}成功
														{#/if}
													</td>
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