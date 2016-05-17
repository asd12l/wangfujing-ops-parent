<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var stockPagination;
	var url = __ctxPath + "/category/getAllCategory";
  	$(function(){
  		
		$("#channelName").val(channelName_);
		$("#channelSid").val(channelSid_);
		$("#productCodeSid").val(productCode_);
		$("#productCode").val(productCode_);
  		$("#stockName_").val(stockName_);
		
		$("#channelName1").val(channelName_);
		$("#channelSid1").val(channelSid_);
		$("#productCodeSid1").val(productCode_);
		$("#productCode1").val(productCode_);
  		$("#stockName1_").val(stockName_);
		
		$("#saleStock").val(saleStock_);
		$("#edefectiveStock").val(edefectiveStock_);
		$("#returnStock").val(returnStock_);
		$("#lockedStock").val(lockedStock_);
		
  		$("#stockSid").val(stockSid);
  		$("#productSku_").val(productSku_);
  		$("#proColorName_").val(proColorName_);
  		$("#proStanName_").val(proStanName_);
  		$("#proSum_").val(proSum_);
  		$("#brandName_").val(brandName_);
  		$("#supplyName_").val(supplyName_);
  		$("#shopName_").val(shopName_);
  		$("#productDetailSid_").val(productDetailSid_);
  		
  	//渠道
		$.ajax({
			type : "post",
			url : __ctxPath + "/stockWei/queryChannelListByShoppeProCode",
			dataType : "json",
			async:false,
			data : {
				"shoppeProCode" : $("#productCode1").val()
			},
			success : function(response) {
				var result = response.list;
				if(result == null) return;
				var option = "<option value='-1'>请选择</option>";
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.channelCode+"'>" + ele.channelName
							+ "</option>";
				}
				$("#channel_select1").append(option);
				return;
			}
		});
  		
  		initStock();

  		$("#stockName").change(stockQuery);
  		function stockQuery() {
// 			$("#stockName_from").val($("#shoppeName").val());
			$.ajax({
			type : "post",
			url : __ctxPath + "/stockWei/selectStockWei",
			dataType : "json",
			data : {
				"channelSid":$("#channelSid").val(),
				"supplyProductId":$("#productCode").val()
			},
			async:false,
			success : function(response) {
				var result = response.data;
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					if(ele.stockTypeSid == $("#stockName").val()){
						$("#proSum").val(ele.proSum);
					}
				}
				
				return;
			}
			});
			//数量
  			$("#proSum").val();
			//穿衣库位变动
  			$("#stock_select").empty();
  			var option = "<option value='-1'>请选择</option>";
			if($("#stockName").val()=='1001'){
					option += "<option value='1002'>残次品库</option>";
				}else if($("#stockName").val()=='1002'){
					option += "<option value='1001'>可售库</option>";
				}else if($("#stockName").val()=='1003'){
					option += "<option value='1001'>可售库</option>";
					option += "<option value='1002'>残次品库</option>";
				}
			
			$("#stock_select").append(option);
  		}
  		$("#save").click(function(){
  			if($("#stockName").val()==""){
				$("#warning2Body").text(buildErrorMessage("","请选择原库位！"));
				$("#warning2").show();
				return false;
  			}else{
	  			saveFrom();
  			}
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/stock/StockView.jsp");
  		});
  		
  	//2
  		$("#stockName1").change(stockQuery1);
  		function stockQuery1() {
// 			$("#stockName_from").val($("#shoppeName").val());
			$.ajax({
			type : "post",
			url : __ctxPath + "/stockWei/selectStockWei",
			dataType : "json",
			data : {
				"channelSid":$("#channelSid1").val(),
				"supplyProductId":$("#productCode1").val()
			},
			async:false,
			success : function(response) {
				var result = response.data;
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					if(ele.stockTypeSid == $("#stockName1").val()){
						$("#proSum1").val(ele.proSum);
					}
				}
				return;
			}
			});
			//数量
  			$("#proSum1").val();
  		}
  		$("#save1").click(function(){
  			if($("#stockName1").val()==""){
  				$("#warning2Body").text(buildErrorMessage("","请选择原库位！"));
				$("#warning2").show();
				return false;
  			}else{
	  			saveFrom1();
  			}
  		});
  		$("#close1").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/stock/StockView.jsp");
  		});
	});
  	
  	//add追加
  	var count=100;
	// 追加新的SKU
	function addSku(){
		var proStockName= $("#stock_select").val();// 库位id
		var proStockNameText = "";
		if(proStockName != -1){
			proStockNameText = $("#stock_select").find("option:selected").text();// 库位文本
		}
		var option = "";
		if(proStockName==-1){
			$("#warning2Body").text("转移库位必选!");
			$("#warning2").show();
			return;
		}
		if($("#stockNumber").val().trim()==""){
			$("#warning2Body").text("转移数量必填!");
			$("#warning2").show();
			return;
		}
		if($("#stockNumber").val().trim()==0){
			$("#warning2Body").text("转移数量不能为0!");
			$("#warning2").show();
			return;
		}
		option = "<tr id='baseTableTr_"+proStockName+"'><td style='text-align: center;'>"+
					"<div class='checkbox'>"+
						"<label style='padding-left: 5px;'>"+
							"<input type='checkbox' id='baseTableTd_proStockName_"+proStockName+"' value='"+proStockName+"'  name='baseTableTd_proColorSid'>"+
							"<span class='text'></span>"+
						"</label>"+
					"</div></td>"+
			"<td style='text-align: center;'>"+proStockNameText+"</td>"+
			"<td style='text-align: center;' name='baseTableTd_stockNumber'>"+$("#stockNumber").val().trim()+"</td></tr>";
		$("#baseTable tbody").append(option);
		$("#baseDivTable").show();
		$("#stock_select").val("");
		$("#stockNumber").val("");
		return;
	}
	// 删除选中的SKU
	function deleteSku(){
		$("input[type='checkbox']:checked").each(function(){
			$("#baseTableTr_"+$(this).val()).remove();
		});
		return;
	}
	function addSku1(){
		var proStockName1= $("#stock_select1").val();// 库位id
		var proStockNameText1 = "";
		if(proStockName1 != -1){
			proStockNameText1 = $("#stock_select1").find("option:selected").text();// 库位文本
		}
		var proChannleName1= $("#channel_select1").val();// 库位id
		var proChannleNameText1 = "";
		if(proChannleName1 != -1){
			proChannleNameText1 = $("#channel_select1").find("option:selected").text();// 库位文本
		}
		var option = "";
		if(proStockName1==-1){
			$("#warning2Body").text("转移库位必选!");
			$("#warning2").show();
			return;
		}
		if(proChannleName1==-1){
			$("#warning2Body").text("转移渠道必选!");
			$("#warning2").show();
			return;
		}
		if($("#stockNumber1").val().trim()==""){
			$("#warning2Body").text("转移数量必填!");
			$("#warning2").show();
			return;
		}
		if($("#stockNumber1").val().trim()==0){
			$("#warning2Body").text("转移数量不能为0!");
			$("#warning2").show();
			return;
		}
		option = "<tr id='baseTable1Tr_"+proStockName1+"'><td style='text-align: center;'>"+
					"<div class='checkbox'>"+
						"<label style='padding-left: 5px;'>"+
							"<input type='checkbox' id='baseTable1Td_proStockName1_"+proStockName1+"' value='"+proStockName1+"'  name='baseTable1Td_proColorSid1'>"+
							"<span class='text'></span>"+
						"</label>"+
					"</div></td>"+
			"<td style='text-align: center;'>"+proStockNameText1+"</td>"+
			"<td style='text-align: center;'>"+proChannleNameText1+"</td>"+
			"<td style='display: none;' name='baseTable1Td_channel_select1'>"+$("#channel_select1").val().trim()+"</td>"+
			"<td style='text-align: center;' name='baseTable1Td_stockNumber1'>"+$("#stockNumber1").val().trim()+"</td></tr>";
		$("#baseTable1 tbody").append(option);
		$("#baseDivTable1").show();
		$("#stock_select1").val("");
		$("#channel_select1").val("");
		$("#stockNumber1").val("");
		return;
	}
	// 删除选中的SKU
	function deleteSku1(){
		$("input[type='checkbox']:checked").each(function(){
			$("#baseTable1Tr_"+$(this).val()).remove();
		});
		return;
	}
  	function initStock() {
  		var a = $("#channelSid").val();
  		var b = $("#productCode").val();
		var url =  __ctxPath + "/stockWei/selectStockWei";
		stockPagination = $("#stockPagination").myPagination(
			{
				ajax : {
					on : true,
					url : url,
					dataType : 'json',
					param:'channelSid='+a+'&supplyProductId='+b,
					ajaxStart : function() {
						ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							ZENG.msgbox.hide();
						}, 300);
					},
					callback : function(response) {
						var result = response.data;
//						$("#stockName").val("");
						var option = "<option value=''>请选择</option>";
						for ( var i = 0; i < result.length; i++) {
							var ele = result[i];
							option += "<option value='"+ele.stockTypeSid+"'>" + ele.stockName
									+ "</option>";
							
						}
						$("#stockName").append(option);
						return;
					}
				}
			});
		//2
		var c = $("#channelSid1").val();
  		var d = $("#productCode1").val();
		var url =  __ctxPath + "/stockWei/selectStockWei";
		stockPagination = $("#stockPagination").myPagination(
			{
				ajax : {
					on : true,
					url : url,
					dataType : 'json',
					param:'channelSid='+c+'&supplyProductId='+d,
					ajaxStart : function() {
						ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							ZENG.msgbox.hide();
						}, 300);
					}/* ,
					callback : function(response) {
						var result = response.data;
//						$("#stockName").val("");
						var option = "<option value=''>请选择</option>";
						for ( var i = 0; i < result.length; i++) {
							var ele = result[i];
							option += "<option value='"+ele.stockTypeSid+"'>" + ele.stockName
									+ "</option>";
							
						}
						$("#stockName1").append(option);
						return;
					} */
				}
			});
	}
 	// 库位json
	function skuJson(){
		var stocks = new Array();// 色系
		var numbs = new Array();// 色码
			$("input[name='baseTableTd_proColorSid']").each(function(){
				stocks.push($(this).val());
			});
			$("td[name='baseTableTd_stockNumber']").each(function(){
				numbs.push($(this).html().trim());
			});
			var json = new Array();
			for(var i=0;i<stocks.length;i++){
				json.push({
					'stockTypeSid' : stocks[i],
					'proSum' : numbs[i]
				});
			}
			var inT = JSON.stringify(json);
			inT = inT.replace(/\%/g, "%25");
			inT = inT.replace(/\#/g, "%23");
			return inT;
 	}
 	// 库位json
	function skuJson1(){
		var stocks1 = new Array();
		var channel1 = new Array();
		var numbs1 = new Array();
			$("input[name='baseTable1Td_proColorSid1']").each(function(){
				stocks1.push($(this).val());
			});
			$("td[name='baseTable1Td_channel_select1']").each(function(){
				channel1.push($(this).html().trim());
			});
			$("td[name='baseTable1Td_stockNumber1']").each(function(){
				numbs1.push($(this).html().trim());
			});
			var json = new Array();
			for(var i=0;i<stocks1.length;i++){
				json.push({
					'stockTypeSid' : stocks1[i],
					'channelSid' : channel1[i],
					'proSum' : numbs1[i]
				});
			}
			var inT1 = JSON.stringify(json);
			inT1 = inT1.replace(/\%/g, "%25");
			inT1 = inT1.replace(/\&/g, "%26");
			inT1 = inT1.replace(/\#/g, "%23");
			return inT1;
 	}
  	function saveFrom(){
		var inT = skuJson();
		if(inT=='[]'){
		    $("#warning2Body").text("未添加库位！");
		    $("#warning2").show();
		    return;
		}
		$("#stockInfo").html(inT);
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/stockWei/saveStockWei",
			dataType:"json",
			data: $("#theForm").serialize(),
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>保存成功，返回列表页!</strong></div>");
 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#warning2Body").text(response.data.errorMsg);
					$("#warning2").show();
				}
				return;
			},
			error: function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
 	  				$("#warning2Body").text(buildErrorMessage("","系统出错！"));
 					$("#warning2").show();
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
  	}
  	function saveFrom1(){
		var inT1 = skuJson1();
		if(inT1=='[]'){
		    $("#warning2Body").text("未添加库位！！");
		    $("#warning2").show();
		    return;
		}
		$("#stockInfo1").html(inT1);
  		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath + "/stockWei/saveStockWei1",
			dataType:"json",
			data: $("#theForm1").serialize(),
			success: function(response) {
				if(response.success=="true"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>保存成功，返回列表页!</strong></div>");
 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
				    $("#warning2Body").text(response.data.errorMsg);
				    $("#warning2").show();
				}
				return;
			},
			error: function(XMLHttpRequest, textStatus) {		      
				var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
				if(sstatus != "sessionOut"){
					$("#warning2Body").text(buildErrorMessage("","系统出错！"));
					$("#warning2").show();
				}
				if(sstatus=="sessionOut"){     
	            	 $("#warning3").css('display','block');     
	             }
			}
		});
  	}
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/stock/StockView.jsp");
	}
	</script> 
</head>
<body>
	<div class="page-body">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">库存信息</span>
							</div>
							<div class="widget-body">
							
							<div class="tabbable">
									<ul class="nav nav-tabs" id="myTab">
										<li class="active" id="li_base"><a data-toggle="tab" href="#base">
												<span>同渠道库存转移</span>
										</a></li>

										<li class="tab-red" id="li_pro"><a data-toggle="tab" href="#pro">
												<span>渠道划库存</span>
										</a></li>
									</ul>
									<!-- BaseMessage start -->
									<div class="tab-content">
										<div id="base" class="tab-pane in active">
							
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden" id="productCodeSid" name="sid" />
									<input type="hidden" id="channelSid" name="channelSid" />
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">渠道</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" disabled="disabled" id="channelName" name="channelName" placeholder="必填"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">专柜商品编码</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" disabled="disabled" id="productCode" name="productCode" placeholder="必填"/>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">原库位</label>
											<div class="col-lg-6">
												<select class="form-control" id="stockName" name="stockName"></select>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">数量</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="proSum" name="proSum" readonly="readonly" />
											</div>
										</div>
									</div>
        							
									<div class="form-group">
											<!-- <form id="baseForm" method="post" class="form-horizontal"> -->
											<div class="col-md-12">
												<h5><strong>库存转移</strong></h5>
												<hr class="wide" style="margin-top: 0;">
												<div class="col-md-4">
													<label class="col-md-4 control-label">转移库位</label>
													<div class="col-md-8">
														<select class="form-control" id="stock_select" name="stock_select">
															<option value="-1">请选择</option>
															<option value="1001">可售库</option>
															<option value="1003">退货库</option>
															<option value="1002">残次品库</option>
														</select>
													</div>
												</div>
												<div class="col-md-4" id="colorCodeDiv">
													<label class="col-md-4 control-label">转移数量</label>
													<div class="col-md-8">
														<input type="text" class="form-control"
														       onkeyup="value=value.replace(/[^0-9- ]/g,'');"
															   oninput="value=value.replace(/[^0-9- ]/g,'');"
															   maxLength=20
														       id="stockNumber" name="stockNumber" />
													</div>
												</div>
												<div class="col-md-4">
													<div class="col-md-12 buttons-preview">
														<a class="btn btn-default" id="addSku" onclick="addSku();">添加</a>&nbsp;
														<a class="btn btn-danger" id="deleteSku" onclick="deleteSku();">删除</a>
													</div>&nbsp;
												</div>
											</div>
											<div class="col-md-12">
												<div class="col-md-12" id="baseDivTable">
													<table id="baseTable" class="table table-bordered table-striped table-condensed table-hover flip-content">
				                                        <thead class="flip-content bordered-darkorange">
				                                            <tr>
				                                            	<th width="50px;"></th>
				                                                <th style="text-align: center;" id="baseTableTh_1">转移库位</th>
				                                                <th style="text-align: center;" id="baseTableTh_2">转移数量</th>
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        </tbody>
				                                    </table>
				                            	</div>&nbsp;
											</div>
											<!-- </form> -->
										</div>
									<div style="display: none;">
										<textarea id="stockInfo" name="stockInfo"></textarea>
									</div>
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="取消" />
										</div>
									</div>
								</form>
							</div>
							<!-- ProMessage start -->
								 		<div id="pro" class="tab-pane">
				                            <form id="theForm1" method="post" class="form-horizontal">
									<input type="hidden" id="productCodeSid1" name="sid1" />
									<input type="hidden" id="channelSid1" name="channelSid1" />
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">渠道</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" disabled="disabled" id="channelName1" name="channelName1" placeholder="必填"/>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">专柜商品编码</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" disabled="disabled" id="productCode1" name="productCode1" placeholder="必填"/>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-6">
											<label class="col-lg-3 control-label">原库位</label>
											<div class="col-lg-6">
												<select class="form-control" id="stockName1" name="stockName1">
													<option value="-1">请选择</option>
													<option value="1001">可售库</option>
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-lg-3 control-label">数量</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" 
												        onkeyup="value=value.replace(/[^0-9- ]/g,'');"
													    oninput="value=value.replace(/[^0-9- ]/g,'');"
														maxLength=20
														id="proSum1" name="proSum1" readonly="readonly" />
											</div>
										</div>
									</div>
        							
									<div class="form-group">
											<form id="baseForm1" method="post" class="form-horizontal">
											<div class="col-md-12">
												<h5><strong>库存转移</strong></h5>
												<hr class="wide" style="margin-top: 0;">
												<div class="col-md-3" style="width:280px;float:left;margin:5px 0">
													<label class="col-md-5 control-label" style="width:35%;padding-left:0;">转移渠道</label>
													<div class="col-md-7" style="width:65%;margin:0;padding:0">
														<select class="form-control" id="channel_select1" name="channel_select1" >
														</select>
													</div>
												</div>
												<div class="col-md-3"style="width:280px;float:left;margin:5px 0">
													<label class="col-md-5 control-label"style="width:35%;padding-left:0;">转移库位</label>
													<div class="col-md-7" style="width:65%;margin:0;padding:0">
														<select class="form-control" id="stock_select1" name="stock_select1" >
															<option value="-1">请选择</option>
															<option value="1001">可售库</option>
															<!-- <option value="1003">退货库</option>
															<option value="1002">残次品库</option> -->
														</select>
													</div>
												</div>
												<div class="col-md-3" id="colorCodeDiv1"style="width:280px;float:left;margin:5px 0">
													<label class="col-md-5 control-label"style="width:35%;padding-left:0;">转移数量</label>
													<div class="col-md-7">
														<input type="text" class="form-control" id="stockNumber1" name="stockNumber1" />
													</div>
												</div>
												<div class="col-md-3" style="width:180px;float:left;white-space: nowrap;margin:5px 0">
													<div class="col-md-12 buttons-preview">
														<a class="btn btn-default" id="addSku1" onclick="addSku1();">添加</a>&nbsp;
														<a class="btn btn-danger" id="deleteSku1" onclick="deleteSku1();">删除</a>
													</div>&nbsp;
												</div>
											</div>
											<div class="col-md-12">
												<div class="col-md-12" id="baseDivTable1">
													<table id="baseTable1" class="table table-bordered table-striped table-condensed table-hover flip-content">
				                                        <thead class="flip-content bordered-darkorange">
				                                            <tr>
				                                            	<th width="50px;"></th>
				                                                <th style="text-align: center;" id="baseTableTh_11">转移库位</th>
				                                                <th style="text-align: center;" id="baseTableTh_31">转移渠道</th>
				                                                <th style="text-align: center;" id="baseTableTh_21">转移数量</th>
				                                            </tr>
				                                        </thead>
				                                        <tbody>
				                                        </tbody>
				                                    </table>
				                            	</div>&nbsp;
											</div>
										</div>
									<div style="display: none;">
										<textarea id="stockInfo1" name="stockInfo1"></textarea>
									</div>
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save1" type="button" value="保存" />&emsp;&emsp;
											<input class="btn btn-danger" style="width: 25%;" id="close1" type="button" value="取消" />
										</div>
									</div>
								</form>
										</div>
										<!-- ProMessage end -->
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
 <!-- /Page Body -->
	<script>
    </script>
</body>
</html>