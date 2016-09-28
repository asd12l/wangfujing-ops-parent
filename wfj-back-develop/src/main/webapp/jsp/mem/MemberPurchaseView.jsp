<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
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
<style type="text/css">
.trClick>td,.trClick>th{
 color:red;
}
</style>
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	var cid;
	var olvPagination;
	$(function() {
		$("#reservation").daterangepicker({
					timePicker: true,
					timePickerIncrement: 30,
					format: 'YYYY/MM/DD HH:mm:ss',
					timePicker12Hour:false,
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
	   
	  //销售单来源（PCM接口）
		$.ajax({
			type : "post",
			url : __ctxPath + "/stock/queryChannelListAddPermission",
			dataType : "json",
			async : false,
			success : function(response) {
				var result = response.list;
				var option = "";
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					option += "<option value='"+ele.channelCode+"'>"
							+ ele.channelName + "</option>";
				}
				$("#saleSource_input").append(option);
				return;
			}
		});
		//销售单状态
		$("#saleStatus_select").one("click",function(){
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/testOnlineOmsOrder/selectCodelist?typeValue=sale_status",
				dataType: "json",
				success: function(response) {
					var result = response;
					var codeValue = $("#saleStatus_select");
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
	});
	
	function productQuery(){
		$("#username_form").val($("#username_input").val().trim());
		$("#mobile_form").val($("#mobile_input").val().trim());
		$("#email_form").val($("#email_input").val().trim());
		$("#orderNo_form").val($("#orderNo_input").val().trim());
		$("#outOrderNo_form").val($("#outOrderNo_input").val().trim());
		$("#orderStatus_form").val($("#saleStatus_select").val().trim());
		$("#orderFrom_form").val($("#saleSource_input").val().trim());
		$("#saleNo_form").val($("#saleNo_input").val().trim());
		$("#pageSelectNo").val($("#pageSelect").val());
		var buytime =  $("#reservation").val();
		if (buytime!=""){
			buytime = buytime.split("-");
			$("#m_buytimeStartDate_form").val(buytime[0].replace("/","-").replace("/","-"));
			$("#m_buytimeEndDate_form").val(buytime[1].replace("/","-").replace("/","-"));
		}else{
			$("#m_buytimeStartDate_form").val("");
			$("#m_buytimeEndDate_form").val("");
		}
      	var params = $("#product_form").serialize();
        params = decodeURI(params);
        olvPagination.onLoad(params);
   	}
	// 查询
	function query() {
		$("#cache").val(0);
		productQuery();
	}
	//重置
	function reset(){
		$("#cache").val(1);
		$("#username_input").val("");
		$("#mobile_input").val("");
		$("#email_input").val("");
		$("#orderNo_input").val("");
		$("#outOrderNo_input").val("");
		$("#saleNo_input").val("");
		$("#reservation").val("");
		$("#saleStatus_select").val("");
		$("#saleSource_input").val("");
		$("#topic_form")[0].reset();
		productQuery();
	}
	//初始化包装单位列表

 	function initOlv() {
		var url = __ctxPath+"/memBasic/getMemPurchase";
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
               ajaxStart : function() {
					$("#loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					setTimeout(function() {
						$("#loading-container").addClass(
								"loading-inactive")
					}, 300);
				},
             callback: function(data) {
           		 $("#olv_tab tbody").setTemplateElement("olv-list").processTemplate(data);
           		
				}
           }
         });
		function toChar(data) {
			if(data == null) {
			data = "";
			}
			return data;
			}
		$("#pageSelect").change(productQuery);
    } 
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/mem/MemberPurchaseView.jsp");
	}

	function showMemPurchaseView(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i,team){
			var cid=$(this).val().trim();
			checkboxArray.push(cid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个用户!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要查看的用户!");
			$("#warning2").show();
			return;
		}
		cid=checkboxArray[0].trim();
		$("#pageBody").load(__ctxPath+"/jsp/mem/PurchaseDetail.jsp");
	}
</script>
<!-- 加载样式 -->
<script type="text/javascript">
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({
					"display" : "none"
				});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({
					"display" : "block"
				});
			}
		}
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
                                <h5 class="widget-caption">购买记录</h5>
                                   <div class="widget-buttons">
										<a href="#" data-toggle="maximize"></a> <a href="#"
											data-toggle="collapse" onclick="tab('pro');"> <i
											class="fa fa-minus" id="pro-i"></i>
										</a> <a href="#" data-toggle="dispose"></a>
									</div>
                                </div>
                                <div class="widget-body" id="pro">
                                    <div class="table-toolbar">
										<ul class="topList clearfix">
											<li class="col-md-4"><label class="titname">购买时间：</label>
												<input type="text" id="reservation" /></li>
											<li class="col-md-4"><label class="titname">账号：</label>
												<input type="text" id="username_input" /></li>
											<li class="col-md-4"><label class="titname">手机号：</label>
												<input type="text" id="mobile_input" /></li>
											<li class="col-md-4"><label class="titname">邮箱：</label>
												<input type="text" id="email_input" /></li>
											<li class="col-md-4"><label class="titname">订单号：</label>
												<input type="text" id="orderNo_input" /></li>
											<li class="col-md-4"><label class="titname" >外部订单号：</label>
												<input type="text" id="outOrderNo_input" /></li>
											<li class="col-md-4"><label class="titname">销售单状态：</label>
												<select class="form-control orderStatusSpace" id="saleStatus_select" data-bv-field="country" style="width:60%;">
												<option value="">请选择</option>
												</select></li>
											<li class="col-md-4"><label class="titname">销售单号：</label>
												<input type="text" id="saleNo_input" /></li>
											<li class="col-md-4 " ><label class="titname">销售单来源：</label>
												<select class="form-control orderFromSpace" id="saleSource_input" data-bv-field="country" style="width:60%;">
												<option value="">请选择</option>
												</select></li>
											<li class="col-md-6">
												<a onclick="query();" class="btn btn-yellow"> <i class="fa fa-eye"></i> 查询</a>
												<a onclick="reset();"class="btn btn-primary"> <i class="fa fa-random"></i> 重置</a>
												<a onclick="showMemPurchaseView();"class="btn btn-primary"  style="display:none"> <i class="fa fa-random"></i> 查询用户购买记录</a>
											</li>
										</ul>

                                   <!--  <table class="table table-bordered table-striped table-condensed table-hover flip-content"
									id="olv_tab" style="width: 200%;background-color: #fff;margin-bottom: 0;">-->
									<div style="width:100%; height:0%; min-height:300px; overflow-Y:hidden;">
									<table class="table-striped table-hover table-bordered"
										   id="olv_tab" style="width: 220%;background-color: #fff;margin-bottom: 0;">
										<thead>
                                            <tr role="row" style='height:35px;'>
												<!-- <th style="text-align: center;" width="2%">选择</th> -->
												<th style="text-align: center;" width="7%">购买时间</th>
												<th style="text-align: center;" width="7%">账号</th>
												<th style="text-align: center;" width="7%">昵称</th>
												<th style="text-align: center;" width="7%">真实姓名</th>
												<th style="text-align: center;" width="7%">手机号</th>
												<th style="text-align: center;" width="7%">邮箱</th>
												<th style="text-align: center;" width="7%">所属门店</th>
												<!-- <th style="text-align: center;" width="7%">会员等级</th> -->
												<th style="text-align: center;" width="16%">地址</th>
												<th style="text-align: center;" width="7%">订单号</th>
												<th style="text-align: center;" width="7%">销售单号</th>
												<th style="text-align: center;" width="7%">订单总额</th>
												<th style="text-align: center;" width="7%">支付方式</th>
												<th style="text-align: center;" width="7%">销售单状态</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>                          
                                  <div class="pull-left" style="padding: 10px 0;">
									<form id="product_form" action="">
											<input type="hidden" id="username_form" name="username" />
											<input type="hidden" id="mobile_form" name="mobile" /> 
											<input type="hidden" id="email_form" name="email" />
											<input type="hidden" id="orderNo_form" name="orderNo" />
											<input type="hidden" id="orderStatus_form" name="orderStatus" />
											<input type="hidden" id="outOrderNo_form" name="outOrderNo" />
											<input type="hidden" id="orderFrom_form" name="orderFrom" />
											<input type="hidden" id="saleNo_form" name="saleNo" />
											<input type="hidden" id="m_buytimeStartDate_form" name="m_buytimeStartDate" />
											<input type="hidden" id="m_buytimeEndDate_form" name="m_buytimeEndDate" />
											<input type="hidden" id="pageSelectNo" name="pageSize" />
											<input type="hidden" id="cache" name="cache" value="1" />
									</form>
								</div>
                                </div>
                                <div class="pull-left" style="margin-top: 5px;">
									<form id="topic_form" action="">
										<div class="col-lg-12">
											<select id="pageSelect" name="pageSize">
												<option>5</option>
												<option selected="selected">10</option>
												<option>15</option>
												<option>20</option>
											</select>
										</div>
									</form>
								</div>
                                    <div id="olvPagination"></div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="olv-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" style="height:35px;">
													<!-- <td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.memberNo}" value="{$T.Result.memberNo}" >
																<span class="text"></span>
															</label>
														</div>
													</td> -->
													<td align="center" id="createdTime_{$T.Result.memberNo}">
														{#if $T.Result.createdTimeStr == "" || $T.Result.createdTimeStr == null}--
														{#else}{$T.Result.createdTimeStr}
														{#/if}
													</td>
													<td align="center" id="username_{$T.Result.memberNo}">
														{#if $T.Result.username == "" || $T.Result.username == null}--
														{#else}{$T.Result.username}
														{#/if}
													</td>
													<td align="center" id="nickname_{$T.Result.memberNo}">
														{#if $T.Result.nick_name == "" || $T.Result.nick_name == null}--
														{#else}{$T.Result.nick_name}
														{#/if}
													</td>
													<td align="center" id="realname_{$T.Result.memberNo}">
														{#if $T.Result.real_name == "" || $T.Result.real_name == null}--
														{#else}{$T.Result.real_name}
														{#/if}
													</td>
													<td align="center" id="mobile_{$T.Result.memberNo}">
														{#if $T.Result.mobile == "" || $T.Result.mobile == null}--
														{#else}{$T.Result.mobile}
														{#/if}
													</td>
													<td align="center" id="email_{$T.Result.memberNo}">
														{#if $T.Result.email == "" || $T.Result.email == null}--
														{#else}{$T.Result.email}
														{#/if}
													</td>

													<td align="center" id="storeName_{$T.Result.memberNo}">
														{#if $T.Result.storeName == "" || $T.Result.storeName == null}--
														{#else}{$T.Result.storeName}
														{#/if}
													</td>
													<!-- <td align="center" id="levelName_{$T.Result.memberNo}">
														{#if $T.Result.levelName == "" || $T.Result.levelName == null}--
														{#else}{$T.Result.levelName}
														{#/if}
													</td> -->
													<td align="center" id="receptAddress_{$T.Result.memberNo}">
														{#if $T.Result.receptAddress == "" || $T.Result.receptAddress == null}--
														{#else}{$T.Result.receptAddress}
														{#/if}
													</td>
													<td align="center" id="orderNo_{$T.Result.memberNo}">
														{#if $T.Result.orderNo == "" || $T.Result.orderNo == null}--
														{#else}{$T.Result.orderNo}
														{#/if}
													</td>
													<td align="center" id="saleNo_{$T.Result.memberNo}">
														{#if $T.Result.saleNo == "" || $T.Result.saleNo == null}--
														{#else}{$T.Result.saleNo}
														{#/if}
													</td>
													<td align="center" id="paymentAmount_{$T.Result.memberNo}">
														{#if $T.Result.paymentAmount == "" || $T.Result.paymentAmount == null}--
														{#else}{$T.Result.paymentAmount}
														{#/if}
													</td>
													<td align="center" id="paymentName_{$T.Result.memberNo}">
														{#if $T.Result.paymentName == "" || $T.Result.paymentName == null}--
														{#else}{$T.Result.paymentName}
														{#/if}
														
													</td>
													<td align="center" id="saleStatusDesc_{$T.Result.memberNo}">
														{#if $T.Result.saleStatusDesc == "" || $T.Result.saleStatusDesc == null}--
														{#else}{$T.Result.saleStatusDesc}
														{#/if}
													</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}
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