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
		});

		function productQuery(){
			$("#username_form").val($("#username_input").val().trim());
			$("#mobile_form").val($("#mobile_input").val().trim());
			$("#email_form").val($("#email_input").val().trim());
			$("#orderNo_form").val($("#orderNo_input").val().trim());
			$("#refundNo_form").val($("#refundNo_input").val().trim());
			$("#pageSelectNo").val($("#pageSelect").val());
			var returnTime = $("#reservation").val();
			if(returnTime!=""){
				returnTime = returnTime.split("-");
				$("#m_startTime").val(returnTime[0].replace("/","-").replace("/","-"));
				$("#m_endTime").val(returnTime[1].replace("/","-").replace("/","-"));
			}else{
				$("#m_startTime").val("");
				$("#m_endTime").val("");
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
			$("#refundNo_input").val("");
			$("#orderNo_input").val("");
			$("#reservation").val("");
			$("#topic_form")[0].reset();
			productQuery();
		}
		//初始化包装单位列表
		function initOlv() {
			var url = __ctxPath+"/memBasic/getMemRefund";
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

		function showMemRefundView(){
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
			$("#pageBody").load(__ctxPath+"/jsp/mem/RefundDetail.jsp");
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
						<h5 class="widget-caption">会员退货记录</h5>
							<div class="widget-buttons">
								<a href="#" data-toggle="maximize"></a> 
								<a href="#" data-toggle="collapse" onclick="tab('pro');"> 
									<i class="fa fa-minus" id="pro-i"></i>
							    </a> <a href="#" data-toggle="dispose"></a>
							</div>
						</div>
						<div class="widget-body" id="pro">
							<div class="table-toolbar">
								<ul class="topList clearfix">
									<li class="col-md-4"><label class="titname">退货时间：</label>
										<input type="text" id="reservation" /></li>
									<li class="col-md-4"><label class="titname">账号：</label>
										<input type="text" id="username_input" /></li>
									<li class="col-md-4"><label class="titname">手机号：</label>
										<input type="text" id="mobile_input" /></li>
									<li class="col-md-4"><label class="titname">邮箱：</label>
										<input type="text" id="email_input" /></li>
									<li class="col-md-4"><label class="titname">退货单号：</label>
										<input type="text" id="refundNo_input" /></li>
									<li class="col-md-4"><label class="titname">订单号：</label>
										<input type="text" id="orderNo_input" /></li>
									<li class="col-md-6">
										<a onclick="query();" class="btn btn-yellow"> <i class="fa fa-eye"></i> 查询</a>
										<a onclick="reset();"class="btn btn-primary"> <i class="fa fa-random"></i> 重置</a>
										<a onclick="showMemRefundView();"class="btn btn-primary" style="display:none"> <i class="fa fa-random"></i> 查询用户退货记录</a>
									</li>
								</ul>

								<div style="width:100%; height:300%; min-height:300px; overflow-Y:hidden;">
									<table class="table-striped table-hover table-bordered"
										   id="olv_tab" style="width: 220%;background-color: #fff;margin-bottom: 0;">

									<thead>
									<tr role="row" style='height:35px;'>
										<!-- <th style="text-align: center;" width="2%">选择</th> -->
										<th style="text-align: center;" width="8%">退货时间</th>
										<th style="text-align: center;" width="8%">购买时间</th>
										<th style="text-align: center;" width="8%">账号</th>
										<th style="text-align: center;" width="8%">昵称</th>
										<th style="text-align: center;" width="8%">真实姓名</th>
										<th style="text-align: center;" width="8%">手机号</th>
										<th style="text-align: center;" width="8%">邮箱</th>
										<!-- <th style="text-align: center;" width="8%">会员来源</th> -->
										<!-- <th style="text-align: center;" width="8%">会员等级</th> -->
										<th style="text-align: center;" width="12%">地址</th>
										<th style="text-align: center;" width="8%">退货原因</th>
										<th style="text-align: center;" width="8%">退货单号</th>
										<th style="text-align: center;" width="8%">退货金额</th>
										<th style="text-align: center;" width="8%">退货单状态</th>
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
										<input type="hidden" id="orderNo_form" name="orderNo"  />
										<input type="hidden" id="refundNo_form" name="refundNo"  />
										<input type="hidden" id="m_startTime" name="startTime"  />
										<input type="hidden" id="m_endTime" name="endTime"  />
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
																<input type="checkbox" id="tdCheckbox_{$T.Result.cid}" value="{$T.Result.cid}" >
																<span class="text"></span>
															</label>
														</div>
													</td> -->
													<td align="center" id="refundTimeStr_{$T.Result.cid}">
														{#if $T.Result.refundTimeStr == "" || $T.Result.refundTimeStr == null}--
														{#else}{$T.Result.refundTimeStr}
														{#/if}
													</td>
													<td align="center" id="saleTime_{$T.Result.cid}">
														{#if $T.Result.saleTime == "" || $T.Result.saleTime == null}--
														{#else}{$T.Result.saleTime}
														{#/if}
													</td>
													<td align="center" id="username_{$T.Result.cid}">
														{#if $T.Result.username == "" || $T.Result.username == null}--
														{#else}{$T.Result.username}
														{#/if}
													</td>
													<td align="center" id="nick_name_{$T.Result.cid}">
														{#if $T.Result.nick_name == "" || $T.Result.nick_name == null}--
														{#else}{$T.Result.nick_name}
														{#/if}
													</td>
													<td align="center" id="real_name_{$T.Result.cid}">
														{#if $T.Result.real_name == "" || $T.Result.real_name == null}--
														{#else}{$T.Result.real_name}
														{#/if}
													</td>
													<td align="center" id="mobile_{$T.Result.cid}">
														{#if $T.Result.mobile == "" || $T.Result.mobile == null}--
														{#else}{$T.Result.mobile}
														{#/if}
													</td>
													<td align="center" id="email_{$T.Result.cid}">
														{#if $T.Result.email == "" || $T.Result.email == null}--
														{#else}{$T.Result.email}
														{#/if}
													</td>

													<!-- <td align="center" id="regist_from_{$T.Result.cid}">
														{#if $T.Result.regist_from == "" || $T.Result.regist_from == null}--
														{#else}{$T.Result.regist_from}
														{#/if}
													</td> -->
													<!-- <td align="center" id="levelName_{$T.Result.cid}">
														{#if $T.Result.levelName == "" || $T.Result.levelName == null}--
														{#else}{$T.Result.levelName}
														{#/if}
													</td> -->
													<td align="center" id="receptAddress_{$T.Result.cid}">
														{#if $T.Result.receptAddress == "" || $T.Result.receptAddress == null}--
														{#else}{$T.Result.receptAddress}
														{#/if}
													</td>
													<td align="center" id="refundReason_{$T.Result.cid}">
														{#if $T.Result.refundReason == "" || $T.Result.refundReason == null}--
														{#else}{$T.Result.refundReason}
														{#/if}
													</td>
													<td align="center" id="refundNo_{$T.Result.cid}">
														{#if $T.Result.refundNo == "" || $T.Result.refundNo == null}--
														{#else}{$T.Result.refundNo}
														{#/if}
													</td>
													<td align="center" id="needRefundAmount_{$T.Result.cid}">
														{#if $T.Result.needRefundAmount == "" || $T.Result.needRefundAmount == null}--
														{#else}{$T.Result.needRefundAmount}
														{#/if}
													</td>
													<td align="center" id="refundStatusDesc_{$T.Result.cid}">
														{#if $T.Result.refundStatusDesc == "" || $T.Result.refundStatusDesc == null}--
														{#else}{$T.Result.refundStatusDesc}
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