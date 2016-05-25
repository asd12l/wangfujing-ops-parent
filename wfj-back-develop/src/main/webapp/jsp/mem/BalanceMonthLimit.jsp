<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<html>
<head>
	<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
	<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script>
	<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
	<style type='text/css'>
		/*#product_tab{width:70%;margin-left:130px;}*/
		#sid0{width:30px;}
		td,th{text-align:center;}
	</style>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
	<script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		var productPagination;
		$(function() {
			initUserRole();
			$("#pageSelect").change(userRoleQuery);
		});
		function userRoleQuery(){
			var params = $("#product_form").serialize();
			//alert("表单序列化后请求参数:"+params);
			params = decodeURI(params);
			productPagination.onLoad(params);
		}

		//新增
		function add(){
			var url = __ctxPath+"/jsp/mem/BalanceMonthLimitAdd.jsp";
			$("#pageBody").load(url);
		}

		//初始化
		function initUserRole() {
			var url = __ctxPath+"/balanceMonthLimit/getList";
			productPagination = $("#productPagination").myPagination({
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
						//使用模板
						$("#product_tab tbody").setTemplateElement("balance-list").processTemplate(data);
					}
				}
			});
		}


		//修改
		function edit(){
			var checkboxArray=[];
			$("input[type='checkbox']:checked").each(function(i, team){
				var appSid = $(this).val();
				checkboxArray.push(appSid);
			});
			if(checkboxArray.length>1){
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				return false;
			}else if(checkboxArray.length==0){
				$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
				$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				return false;
			}
			var value=	checkboxArray[0];
			var year_ = $("#year_"+value).text().trim();
			var setupComplaintBal_ = $("#setupComplaintBal_"+value).text().trim();
			var setupCarriageBal_ = $("#setupCarriageBal_"+value).attr("value");

			var url = __ctxPath+"/jsp/mem/BalanceYearLimitEdit.jsp"+"?sid="+value+"&year="+year_
					+"&setupComplaintBal="+setupComplaintBal_+"&setupCarriageBal="+setupCarriageBal_;
			$("#pageBody").load(url);
		}
		function successBtn(){
			$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
			$("#pageBody").load(__ctxPath+"/jsp/search/Interval/IntervalMessage.jsp");
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
							<span class="widget-caption"><h5>余额年设置列表</h5></span>
							<div class="widget-buttons">
								<a href="#" data-toggle="maximize"></a>
								<a href="#" data-toggle="collapse" onclick="tab('pro');">
									<i class="fa fa-minus" id="pro-i"></i>
								</a>
								<a href="#" data-toggle="dispose"></a>
							</div>
						</div>
						<div class="widget-body" id="pro">
							<form id="product_form" action="">
								<div class="table-toolbar">
									<a id="add" onclick="add();" class="btn btn-primary glyphicon glyphicon-plus">
										新增
									</a>&nbsp;&nbsp;
									<a id="edit" onclick="edit();" class="btn btn-info glyphicon glyphicon-wrench">
										修改
									</a>&nbsp;&nbsp;
									<div class="mtb10">
										<span>年份：</span>
										<input type="text" id="year" />&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="find();">查询</a>
									</div>

								</div>
							</form>
							<table class="table table-striped table-hover table-bordered" id="product_tab">
								<thead class="flip-content bordered-darkorange">
								<tr role="row">
									<th id="sid0"></th>
									<th>年月份</th>
									<th>投诉补偿额度</th>
									<th>当月可用投诉余额</th>
									<th>当月已用投诉额度</th>
									<th>运费补偿额度</th>
									<th>当月可用运费余额</th>
									<th>当月已用运费额度</th>
								</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<div id="productPagination"></div>
						</div>
						<!-- Templates -->
						<p style="display:none">
									<textarea id="balance-list" rows="0" cols="0">
										{#template MAIN}
											{#foreach $T.object as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td id="yearMonth_{$T.Result.sid}" value="{$T.Result.yearMonth}">{$T.Result.yearMonth}</td>
													<td id="setupComplaintBal_{$T.Result.sid}" value="{$T.Result.setupComplaintBal}">{$T.Result.setupComplaintBal}</td>
													<td id="usableMonthcptBal_{$T.Result.sid}" value="{$T.Result.usableMonthcptBal}">{$T.Result.usableMonthcptBal}</td>
													<td id="usedMonthcptBal_{$T.Result.sid}" value="{$T.Result.usedMonthcptBal}">{$T.Result.usedMonthcptBal}</td>
													<td id="setupCarriageBal_{$T.Result.sid}" value="{$T.Result.setupCarriageBal}">{$T.Result.setupCarriageBal}</td>
													<td id="usableMonthcrgBal_{$T.Result.sid}" value="{$T.Result.usableMonthcrgBal}">{$T.Result.usableMonthcrgBal}</td>
													<td id="usedMonthcrgBal_{$T.Result.sid}" value="{$T.Result.usedMonthcrgBal}">{$T.Result.usedMonthcrgBal}</td>
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
</body>
</html>