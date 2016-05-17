<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<style type="text/css">
	.trClick > td, .trClick > th {
		color: red;
	} 
	.checkbox {
	    display: block;
	    margin-bottom: 2px;
	    margin-top: 2px;
	    min-height: 20px;
	    position: relative;
	}
</style>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	var shopPagination;
	var shopPayment;
	$(function() {
		initShop();
		/*   $("#organizationName_input").change(shopQuery); */
		$("#pageSelect").change(shopQuery);
	});
	function shopQuery() {
		$("#organizationName_form").val($("#organizationName_input").val());
		var params = $("#shop_form").serialize();
		//alert("表单序列化后请求参数:"+params);
		params = decodeURI(params);
		shopPagination.onLoad(params);
	}
	function find() {
		/* $("#organizationName_input").change(shopQuery); */
		shopQuery();
	}
	function reset() {
		$("#organizationName_input").val("");
		shopQuery();
	}
	function initShop() {
		var url = $("#ctxPath").val() + "/organization/queryOrganizationZero?organizationType=3";
		shopPagination = $("#shopPagination").myPagination(
			{
				panel : {
					tipInfo_on : true,
					tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
					tipInfo_css : {
						width : '25px',
						height : "20px",
						border : "2px solid #f0f0f0",
						padding : "0 0 0 5px",
						margin : "0 5px 0 5px",
						color : "#48b9ef"
					}
				},
				debug : false,
				ajax : {
					on : true,
					url : url,
					dataType : 'json',
					ajaxStart : function() {
						$("#loading-container").attr("class","loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container").addClass("loading-inactive");
						}, 300);
					},
					callback : function(data) {
						//使用模板
						$("#shop_tab tbody").setTemplateElement("shop-list").processTemplate(data);
					}
				}
			});
	}
	//点击触发查询门店下的支付方式事件
	var organizationName_;
	var organizationCode_;
	function trClick(sid, obj) {
		$(".shopA").css("color","#428bca");
		$("#organizationName_" + sid).css("color","red");
		$("#organizationCode_" + sid).css("color","red");
		
		organizationName_ = $("#organizationName_" + sid).text().trim();
		organizationCode_ = $("#organizationCode_" + sid).text().trim();
		$(obj).addClass("trClick").siblings().removeClass("trClick");
		var url = $("#ctxPath").val() + "/payment/queryPageFirstPaymentTypeByShop";
		shopPayment = $("#shopPayment").myPagination({
			panel : {
				tipInfo_on : true,
				tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
				tipInfo_css : {
					width : '25px',
					height : "20px",
					border : "2px solid #f0f0f0",
					padding : "0 0 0 5px",
					margin : "0 5px 0 5px",
					color : "#48b9ef"
				}
			},
			debug : false,
			ajax : {
				on : true,
				url : url,
				dataType : 'json',
				param : 'organizationCode=' + organizationCode_,
				ajaxStart : function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive");
					}, 300);
				},
				callback : function(data) {
					//使用模板
					$("#payment_tab tbody").setTemplateElement("firstPayment-list").processTemplate(data);
				}
			}
		});
	}
	function addShopPayment() {
		var url = __ctxPath + "/jsp/PaymentOrgan/addPaymentOrganInfomationNode.jsp";
		$("#pageBody").load(url);
	}
	
	// 删除门店支付方式
	function delShopPayment() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var payCode = $(this).val();
			checkboxArray.push(payCode);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一行");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要删除的门店下的支付方式");
			$("#warning2").show();
			return false;
		}
		
		//var flag = confirm("您确定要删除吗？");
		var value = checkboxArray[0];
		//if (flag) {
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/payment/delShopPcmPayment",
				dataType : "json",
				data : {
					"code" : value,
					"shopSid" : organizationCode_
				},
				success : function(response) {
					if (response.success == "true") {
						$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>删除成功，返回列表页!</strong></div>");
						$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
					} else {
						$("#warning2Body").text("删除失败");
						$("#warning2").show();
					}
					return;
				}
			});
		//}
	}
	
	function spanTd(parentCode) {
		
		/* $(".trApp").remove();
		$(".classApp").attr("class",
		"expand-collapse click-expand glyphicon glyphicon-plus classApp"); */
		
		if ($("#spanTd_" + parentCode).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus classApp") {
			
			$("#spanTd_" + parentCode).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus classApp");
			var option = "<tr class='trApp' id='afterTr"+parentCode+"'><td></td><td colspan='5'>"
			+ "<div style='padding:2px'>"
			+ "<table  class='table table-bordered table-striped table-condensed table-hover flip-content' id='secondPayment_tab"+parentCode+"'><thead>"
			+ "<tr role='row'><th width='7.5%'></th><th style='text-align:center;'>二级支付方式名称</th>"
			+ "<th style='text-align:center;'>二级支付编码</th></tr></thead>"
            + "<tbody></tbody>";
            
			option += "</table></div>"
			       + "<div class='pull-left' style='margin-top: 5px;'>"
				   + "<form id='secondPayment_form' action=''>"
				   + "<div class='col-lg-12'>"
            	   + "<select id='pageSelects' name='pageSize' style='padding: 0 12px;'>"
				   + "<option>5</option></select></div>&nbsp;"  
			       + "<input type='hidden' id='organizationParentCode_from' name='parentCode' />"
		           + "</form></div>"
                   + "<div id='secondPaymentPagination"+parentCode+"'></div>"
			       + "</td></tr>";
			$("#gradeX" + parentCode).after(option);
			
			initSecondPayment(parentCode);
		} else {
			$("#spanTd_" + parentCode).attr("class","expand-collapse click-expand glyphicon glyphicon-plus classApp");
			$("#afterTr" + parentCode).remove();
			
		}
	}
	
	var secondPaymentPagination;
	function secondPaymentQuery(){
        var params = $("#secondPayment_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        secondPaymentPagination.onLoad(params);
   	}
	
	function initSecondPayment(parentCode) {
		var url = $("#ctxPath").val()+"/payment/queryPageSecondPaymentTypeByShop";
			secondPaymentPagination = $("#secondPaymentPagination" + parentCode).myPagination({
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
	             param:'parentCode='+parentCode+'&organizationCode='+organizationCode_,
	             ajaxStart: function() {
			       	 $("#loading-container").attr("class","loading-container");
			        },
		        ajaxStop: function() {
		          //隐藏加载提示
		          setTimeout(function() {
		       	        $("#loading-container").addClass("loading-inactive");
		       	 },300);
		        },

	             callback: function(data) {
	               //使用模板
	               $("#secondPayment_tab" + parentCode + " tbody").setTemplateElement("secondPayment-list").processTemplate(data);
	             }
	           }
	         });
	}
	
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({"display" : "none"});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({"display" : "block"});
			}
		}
	}
	function successBtn() {
		$("#modal-success").attr({"style" : "display:none;","aria-hidden" : "true","class" : "modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/PaymentOrgan/PaymentOrganView.jsp");
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
								<h5 class="widget-caption">门店与支付方式管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i> </a> <a href="#"
										data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro" style="height: 600px">

								<div class="table-toolbar" style="margin-left: 15px">
									<div class="clearfix">
										<a id="editabledatatable_new" onclick="addShopPayment();" class="btn btn-primary"> 
											<i class="fa fa-plus"></i>
											添加门店支付方式
										</a>&nbsp;&nbsp; 
										<!-- <a id="editabledatatable_new" onclick="modifyBrandRelation();" class="btn btn-info"> 
											<i class="fa fa-wrench"></i> 
											修改门店支付方式
										</a>&nbsp;&nbsp;  -->
										<a onclick="delShopPayment();" class="btn btn-danger" data-toggle="modal"> 
											<i class="fa fa-times"></i>
											删除门店支付方式
										</a>
									</div>
								</div>
								
								<div class="modal fade" id="delShopPayment">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
								        	<span aria-hidden="true">&times;</span>
								        </button>
								        <h4 class="modal-title">Modal title</h4>
								      </div>
								      <div class="modal-body">
								        <p>One fine body&hellip;</p>
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								        <button type="button" class="btn btn-primary">Save changes</button>
								      </div>
								    </div><!-- /.modal-content -->
								  </div><!-- /.modal-dialog -->
								</div><!-- /.modal -->

								<div class="table-toolbar"  style="margin-left: 15px">
									<div class="clearfix">
											<span>门店名称：</span>
											<input type="text" id="organizationName_input" style="width: 200px" />&nbsp;&nbsp;&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="find();">查询</a>&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="reset();">重置</a>
									</div>
								</div>
								<div class="mt15 clearfix">
									<div class="col-md-6" style="float: left;width:50%;">
										<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="shop_tab">
											<thead class="flip-content bordered-darkorange">
												<tr role="row">
													<th style="text-align: center;width: 50%">门店名称</th>
													<th style="text-align: center;width: 50%">门店编码</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
										<div class="pull-left" style="float:left;width:10%;padding-top:6px;">
											<form id="shop_form" action="">
												<div class="col-lg-12">
													<select id="pageSelect" name="pageSize"
														style="padding: 0 12px;">
														<option>5</option>
														<option selected="selected">10</option>
														<option>15</option>
														<option>20</option>
													</select>
												</div>
												&nbsp; 
												<input type="hidden" id="organizationName_form" name="organizationName"/>
											</form>
										</div>
										<div id="shopPagination"></div>
									</div>
	
									<div class="col-md-6" style="float: right;">
									<table class="table table-bordered table-striped table-condensed table-hover flip-content" id="payment_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr role="row">
                                                <th width="20%" style="text-align: center;">支付方式详情</th>
                                                <th style="text-align: center;">支付名称</th>
                                                <th style="text-align: center;">支付编码</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
									<!-- <div class="pull-left" style="margin-top: 5px;">
									<form id="shop_form" action="">
										<div class="col-lg-12">
											<select id="pageSelect" name="pageSize"
												style="padding: 0 12px;">
												<option>5</option>
												<option selected="selected">10</option>
												<option>15</option>
												<option>20</option>
											</select>
										</div>
										&nbsp; <input type="hidden" id="organizationName_form"
											name="brandName" />
									</form>
								</div> -->
									<div id="shopPayment"></div>
								</div>
								</div>
							</div>
						</div>

						<!-- Templates -->
						<p style="display: none">
							<textarea id="shop-list" rows="0" cols="0">
								<!--
								{#template MAIN}
									{#foreach $T.list as Result status}
										<tr class="gradeX" id="gradeX{$T.Result.sid}" onclick="trClick('{$T.Result.sid}',this)" style="height:35px;cursor:pointer">
											<td align="center">
												<a id="organizationName_{$T.Result.sid}" class="shopA">
													{$T.Result.organizationName}
												</a>
											</td>
											<td align="center">
												<a id="organizationCode_{$T.Result.sid}" class="shopA">
													{$T.Result.organizationCode}
												</a>
											</td>
											<td align="center" style="display:none;" id="parentSid_{$T.Result.sid}">{$T.Result.parentSid}</td>
							       		</tr>
									{#/for}
							    {#/template MAIN}	-->
							</textarea>
						</p>
						<!-- Templates -->
						<p style="display: none">
							<textarea id="firstPayment-list" rows="0" cols="0">
								<!--
								{#template MAIN}
									{#foreach $T.list as Result}
										<tr class="gradeX" id="gradeX{$T.Result.payCode}" style="height:35px;">
											<td align="center" style="vertical-align:middle;cursor:pointer">
												<span id="spanTd_{$T.Result.payCode}" onclick="spanTd('{$T.Result.payCode}');" class="expand-collapse click-expand glyphicon glyphicon-plus classApp"></span>
											</td>
											<td align="center" id="name_{$T.Result.sid}">
											{#if $T.Result.name != '[object Object]'}
												{$T.Result.name}
											{#/if}</td>
											<td align="center" id="payCode_{$T.Result.sid}">
											{#if $T.Result.payCode != '[object Object]'}
												{$T.Result.payCode}
											{#/if}</td>
											
							       		</tr>
									{#/for}
							    {#/template MAIN}	-->
							</textarea>
						</p>
						<!-- Templates -->
						<p style="display:none">
							<textarea id="secondPayment-list" rows="0" cols="0">
								<!--
								{#template MAIN}
									{#foreach $T.list as Result}
										<tr class="gradeX" id="gradeX{$T.Result.payCode}" style="height:35px;">
											<td align="left">
												<div class="checkbox">
													<label>
														<input type="checkbox" id="tdCheckbox_{$T.Result.payCode}" value="{$T.Result.payCode}" >
														<span class="text"></span>
													</label>
												</div>
											</td>
											<td align="center" id="name_{$T.Result.payCode}">
											{#if $T.Result.name != '[object Object]'}
												{$T.Result.name}
											{#/if}</td>
											<td align="center" id="payCode_{$T.Result.payCode}">
											{#if $T.Result.payCode != '[object Object]'}
												{$T.Result.payCode}
											{#/if}</td>
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
</body>
</html>