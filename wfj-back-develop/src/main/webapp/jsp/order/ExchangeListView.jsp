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
	
	
	var olvPagination;
	$(function() {
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
		$("#exchangeNo_form").val($("#exchangeNo_input").val());
		$("#saleNo_form").val($("#saleNo_input").val());
		$("#originalSaleNo_form").val($("#originalSaleNo_input").val());
		$("#shopNo_form").val($("#shopNo_input").val());
		$("#refundNo_form").val($("#refundNo_input").val());
		$("#memberNo_form").val($("#memberNo_input").val());
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
		$("#exchangeNo_input").val("");
		$("#saleNo_input").val("");
		$("#originalSaleNo_input").val("");
		$("#shopNo_input").val("");
		$("#refundNo_input").val("");
		$("#memberNo_input").val("");
		$("#reservation").val("");
		olvQuery();
	}
	//初始化包装单位列表
 	function initOlv() {
		var url = __ctxPath+"/oms/exchangeList";
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
                                    <h5 class="widget-caption">换货单查询</h5>
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
                                    	<ul class="topList">
										    <li class="col-md-4">
										            <label class="titname">换货单时间：</label>
													<input type="text" id="reservation"  />
										        </li>
										        <li class="col-md-4">
										            <label class="titname">换货单号：</label>
													<input type="text" id="exchangeNo_input" />
										        </li>
										        <li class="col-md-4">
										            <label class="titname">新销售单号：</label>
													<input type="text" id="saleNo_input" />
										        </li>
										        <li class="col-md-4">
										            <label class="titname">原销售单号：</label>
													<input type="text" id="originalSaleNo_input" />
										        </li>
										        <li class="col-md-4">
										            <label class="titname">会员卡号：</label>
													<input type="text" id="memberNo_input" />
										        </li>
										        <li class="col-md-4">
										            <label class="titname">门店编号：</label>
													<input type="text" id="shopNo_input" />
										        </li>
										        <li class="col-md-4">
										            <label class="titname">退货单号：</label>
													<input type="text" id="refundNo_input" />
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
                                            </a>		 -->								
										        </li>
										</ul>
                                    
                               			<form id="olv_form" action="">
											<input type="hidden" id="pageSelect" name="pageSize" value="10"/>
											<input type="hidden" id="exchangeNo_form" name="exchangeNo"/>
											<input type="hidden" id="saleNo_form" name="saleNo"/>
											<input type="hidden" id="originalSaleNo_form" name="originalSaleNo"/>
											<input type="hidden" id="shopNo_form" name="shopNo"/>
											<input type="hidden" id="refundNo_form" name="refundNo"/>
											<input type="hidden" id="memberNo_form" name="memberNo"/>
											<input type="hidden" id="startSaleTime_form" name="startTime"/>
											<input type="hidden" id="endSaleTime_form" name="endTime"/>
                                      	</form>
                                	<div style="width:100%; height:0%; min-height:300px; overflow-Y: hidden;">
                                    <table class="table-striped table-hover table-bordered" id="olv_tab" style="width: 150%;background-color: #fff;margin-bottom: 0;">
                                        <thead>
                                            <tr role="row" style='height:35px;'>
                                                <th width="5%" style="text-align: center;">换货单号</th>
                                                <th width="5%" style="text-align: center;">新销售单号</th>
                                                <th width="5%" style="text-align: center;">原销售单号</th>
                                                <th width="5%" style="text-align: center;">退货单号</th>
                                                <th width="5%" style="text-align: center;">会员卡号</th>
                                                <th width="4%" style="text-align: center;">门店编号</th>
                                                <th width="4%" style="text-align: center;">差额</th>
                                                <th width="4%" style="text-align: center;">机器号</th>
                                                <th width="4%" style="text-align: center;">员工号</th>
                                                <th width="5%" style="text-align: center;">换货单时间</th>
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
													<td align="center" id="exchangeNo_{$T.Result.sid}">
														{#if $T.Result.exchangeNo != '[object Object]'}{$T.Result.exchangeNo}
						                   				{#/if}
													</td>
													<td align="center" id="saleNo_{$T.Result.sid}">
														{#if $T.Result.saleNo != '[object Object]'}{$T.Result.saleNo}
						                   				{#/if}
													</td>
													<td align="center" id="originalSaleNo_{$T.Result.sid}">
														{#if $T.Result.originalSaleNo != '[object Object]'}{$T.Result.originalSaleNo}
						                   				{#/if}
													</td>
													<td align="center" id="refundNo_{$T.Result.sid}">
														{#if $T.Result.refundNo != '[object Object]'}{$T.Result.refundNo}
						                   				{#/if}
													</td>
													<td align="center" id="memberNo_{$T.Result.sid}">
														{#if $T.Result.memberNo != '[object Object]'}{$T.Result.memberNo}
						                   				{#/if}
													</td>
													<td align="center" id="shopNo_{$T.Result.sid}">
														{#if $T.Result.shopNo != '[object Object]'}{$T.Result.shopNo}
						                   				{#/if}
													</td>
													<td align="center" id="imbalance_{$T.Result.sid}">
														{#if $T.Result.imbalance != '[object Object]'}{$T.Result.imbalance}
						                   				{#/if}
													</td>
													<td align="center" id="employeeNo_{$T.Result.sid}">
														{#if $T.Result.employeeNo != '[object Object]'}{$T.Result.employeeNo}
						                   				{#/if}
													</td>
													<td align="center" id="casherNo_{$T.Result.sid}">
														{#if $T.Result.casherNo != '[object Object]'}{$T.Result.casherNo}
						                   				{#/if}
													</td>
													<td align="center" id="exchangeDateStr_{$T.Result.sid}">
														{#if $T.Result.exchangeDateStr != '[object Object]'}{$T.Result.exchangeDateStr}
						                   				{#/if}
													</td>
													<td align="center" id="lastUpdateMan_{$T.Result.sid}">
														{#if $T.Result.lastUpdateMan != '[object Object]'}{$T.Result.lastUpdateMan}
						                   				{#/if}
													</td>
													<td align="center" id="lastUpdateTimeStr_{$T.Result.sid}">
														{#if $T.Result.lastUpdateTimeStr != '[object Object]'}{$T.Result.lastUpdateTimeStr}
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

</body>
</html>