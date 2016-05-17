<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--Page Related Scripts-->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" ></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	
	var firstPaymentPagination;
	$(function() {    	
	    initFirstPayment();
	    $("#pageSelect").change(supplierInfoQuery);
	    $("#pageSelects").change(supplierInfoQuerys);
	});
	function supplierInfoQuery(){
		$("#name_form").val($("#name_input").val());
		$("#payCode_form").val($("#payCode_input").val());
        var params = $("#supplierInfo_form").serialize();
        params = decodeURI(params);
        firstPaymentPagination.onLoad(params);
   	}
	function find() {
		/* $("#name_input").change(supplierInfoQuery); */
		supplierInfoQuery();
	}
	
	function reset(){
		$("#name_input").val("");
		$("#payCode_input").val("");
		supplierInfoQuery();
	}
 	function initFirstPayment() {
		var url = $("#ctxPath").val()+"/payment/queryPaymentType?parentCode=0";
			firstPaymentPagination = $("#firstPaymentPagination").myPagination({
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
			       	 $("#loading-container").attr("class","loading-container");
			        },
		        ajaxStop: function() {
		          //隐藏加载提示
		          setTimeout(function() {
		       	        $("#loading-container").addClass("loading-inactive")
		       	 },300);
		        },

	             callback: function(data) {
	               //使用模板
	               $("#firstPayment_tab tbody").setTemplateElement("firstPayment-list").processTemplate(data);
	             }
	           }
	         });
	    }
	function addSupplierInfo(){
		var url = __ctxPath+"/jsp/PaymentType/addPaymentTypeInfomationNode.jsp";
		$("#pageBody").load(url);
	}
	function delPaymentTypeInfo(){
		var checkboxArray=[];
		
		$(".second_payment:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		
		var flag = false;
		$(".first_payment:checked").each(function(i, team){
			flag = true;
		});
		if (flag) {
		    $("#warning2Body",parent.document).text("不能删除一级支付方式");
			$("#warning2",parent.document).attr("style","z-index:9999");
			$("#warning2",parent.document).show();
			return;
		}
		
		if(checkboxArray.length>1){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一行!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else if(checkboxArray.length==0){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要删除的行!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var flag = confirm("您确定要删除吗？");
		var value=	checkboxArray[0];
		var url = __ctxPath+"/payment/delPaymentType";
		if(flag){
			$.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: url,
				dataType: "json",
		        ajaxStop: function() {
		          //隐藏加载提示
		          setTimeout(function() {
		       	        $("#loading-container").addClass("loading-inactive")
		       	 },300);
		        },
				data: {
					"sid":value
				},
				success: function(response) {
					if(response.success=="true"){
						$("#modal-body-success").html("<div class='alert alert-success fade in'><i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong></div>");
	  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
					}else{
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
						$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					}
					return;
				}
			});
		}
	}
	
	function editPaymentType() {
		var checkboxArray = [];
		$(".first_payment:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		
		$(".second_payment:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		
		if (checkboxArray.length > 1) {
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一行!</strong></div>");
			$("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
			return false;
		} else if (checkboxArray.length == 0) {
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的行!</strong></div>");
			$("#modal-warning").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-warning"});
			return false;
		}
		
		var value = checkboxArray[0];
		sid_ = $("#tdCheckbox_" + value).val().trim();
		name_ = $("#name_" + value).text().trim();
		payCode_ = $("#payCode_" + value).text().trim();
		bankBIN_ = $("#bankBIN_" + value).text().trim();
		remark_ = $("#remark_" + value).text().trim();
		isAllowInvoice_ = $("#isAllowInvoice_" + value).attr("isAllowInvoice");
		var url = __ctxPath + "/jsp/PaymentType/editPaymentTypeInfomationNode.jsp";
		$("#pageBody").load(url);
	}
	function spanTd(parentCode) {
		
		/* $(".trApp").remove();
		$(".classApp").attr("class",
		"expand-collapse click-expand glyphicon glyphicon-plus classApp"); */
		
		if ($("#spanTd_" + parentCode).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus classApp") {
			$("#spanTd_" + parentCode).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus classApp");
			var option = "<tr class='trApp' id='afterTr"+parentCode+"'><td></td><td colspan='5'>"
			+ "<div style='padding:2px'>"
			+ "<table class='table table-bordered table-striped table-condensed table-hover flip-content' id='secondPayment_tab"+parentCode+"'>"
			+ "<thead><tr role='row'><th width='7.5%'></th>"
			+ "<th style='text-align:center;'>二级支付方式名称</th>"
			+ "<th style='text-align:center;'>二级支付编码</th>"
			+ "<th style='text-align:center;'>银行标识</th>"
			+ "<th style='text-align: center;'>能否开发票</th></tr></thead>"
            + "<tbody></tbody>";
            
			option += "</table></div>"
			+ "<div class='pull-left' style='margin-top: 5px;'>"
			+ "<form id='supplierInfo_form' action=''>"
			+ "<div class='col-lg-12'>"
			+ "</div>&nbsp;"  
			+ "<input type='hidden' id='organizationParentCode_from' name='parentCode' />"
			+ "</form>"
			+ "</div>"
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
	function supplierInfoQuerys(){
        var params = $("#supplierInfo_form").serialize();
        params = decodeURI(params);
        secondPaymentPagination.onLoad(params);
   	}
	
	function initSecondPayment(parentCode) {
		var url = $("#ctxPath").val()+"/payment/queryPaymentTypeByParentCode";
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
             param:'parentCode='+parentCode,
             ajaxStart: function() {
		       	 $("#loading-container").attr("class","loading-container");
		        },
	        ajaxStop: function() {
	          //隐藏加载提示
	          setTimeout(function() {
	       	        $("#loading-container").addClass("loading-inactive")
	       	 },300);
	        },

             callback: function(data) {
               //使用模板
               $("#secondPayment_tab"+parentCode+" tbody").setTemplateElement("secondPayment-list").processTemplate(data);
             }
           }
         });
	}
	
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/PaymentType/PaymentTypeView.jsp");
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
                                    <h5 class="widget-caption">支付方式管理</h5>
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
                                    	<div class="clearfix">
                                    	<a id="editabledatatable_new" onclick="addSupplierInfo();" class="btn btn-primary">
                                        	<i class="fa fa-plus"></i>
											添加支付方式
                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a id="editabledatatable_new" onclick="editPaymentType();" class="btn btn-info">
                                        	<i class="fa fa-wrench"></i>
                                        	 修改支付方式 
                                        </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                    	<a id="editabledatatable_new" onclick="delPaymentTypeInfo();" class="btn btn-danger">
                                    		<i class="fa fa-times"></i>
											删除支付方式
                                        </a>
                                        </div>
                                    </div>
                                    <div class="table-toolbar">
                                    	<span>支付名称：</span>
                                    	<input type="text" id="name_input"/>&nbsp;&nbsp;
                                    	<span>支付编码：</span>
                                    	<input type="text" id="payCode_input"/>&nbsp;&nbsp;
                                    	<a class="btn btn-default shiny" onclick="find();"
										style="height: 32px; margin-top: -4px;">查询</a>&nbsp;&nbsp;
									<a class="btn btn-default shiny" onclick="reset();"
										style="height: 32px; margin-top: -4px;">重置</a>
                                    </div>
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="firstPayment_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr role="row">
                                            	<th width="7.5%" style="text-align: center;">选择</th>
                                                <th width="10%" style="text-align: center;">支付方式详情</th>
                                                <th style="text-align: center;">支付名称</th>
                                                <th style="text-align: center;">支付编码</th>
                                                <th style='text-align:center;'>银行标识</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <div class="pull-left" style="margin-top: 5px;">
										<form id="supplierInfo_form" action="">
											<div class="col-lg-12">
	                                        	<select id="pageSelect" name="pageSize" style="padding: 0 12px;">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>&nbsp;  
											<input type="hidden" id="name_form" name="name" />
											<input type="hidden" id="payCode_form" name="payCode" />
										</form>
									</div>
                                    <div id="firstPaymentPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="firstPayment-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.payCode}">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" class="first_payment" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" style="vertical-align:middle;cursor:pointer">
														<span  id="spanTd_{$T.Result.payCode}" onclick="spanTd('{$T.Result.payCode}');" class="expand-collapse click-expand glyphicon glyphicon-plus classApp"></span>
													</td>
													<td align="center" id="name_{$T.Result.sid}">
														{#if $T.Result.name != '[object Object]'}
															{$T.Result.name}
														{#/if}
													</td>
													<td align="center" id="payCode_{$T.Result.sid}">
														{#if $T.Result.payCode != '[object Object]'}
															{$T.Result.payCode}
														{#/if}
													</td>
													<td align="center" id="bankBIN_{$T.Result.sid}">
														{#if $T.Result.bankBIN != '[object Object]'}
															{$T.Result.bankBIN}
														{#/if}
													</td>
													<td align="center" id="remark_{$T.Result.sid}" style="display:none">
														{#if $T.Result.remark != '[object Object]'}
															{$T.Result.remark}
														{#/if}
													</td>
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
												<tr class="gradeX" id="gradeX{$T.Result.payCode}">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" class="second_payment" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="name_{$T.Result.sid}">
														{#if $T.Result.name != '[object Object]'}
															{$T.Result.name}
														{#/if}
													</td>
													<td align="center" id="payCode_{$T.Result.sid}">
														{#if $T.Result.payCode != '[object Object]'}
															{$T.Result.payCode}
														{#/if}
													</td>
													<td align="center" id="bankBIN_{$T.Result.sid}">
														{#if $T.Result.bankBIN != '[object Object]'}
															{$T.Result.bankBIN}
														{#/if}
													</td>
													<td align="center" id="isAllowInvoice_{$T.Result.sid}" isAllowInvoice="{$T.Result.isAllowInvoice}">
														{#if $T.Result.isAllowInvoice == 'Y'}
															<span class="label label-success graded">是</span>
														{#elseif $T.Result.isAllowInvoice == 'N'}
															<span class="label label-darkorange graded">否</span>
														{#/if}
													</td>
													<td align="center" id="remark_{$T.Result.sid}" style="display:none">
														{#if $T.Result.remark != '[object Object]'}
															{$T.Result.remark}
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
            <div aria-hidden="true" style="display: none;" class="modal modal-message modal-warning fade" id="proWarning">
				<div class="modal-dialog" style="margin: 150px auto;">
					<div class="modal-content">
			           <div class="modal-header">
			               <i class="fa fa-warning"></i>
			           </div>
			           <div class="modal-body" id="model-body-proWarning">不能删除一级支付方式</div>
			           <div class="modal-footer">
			               <button data-dismiss="modal" class="btn btn-warning" type="button" onclick="proWarningBtn()">确定</button>
			           </div>
			       </div>
			   </div>
            <!-- /Page Content -->
        </div>
        <!-- /Page Container -->
        <!-- Main Container -->
     
</body>
</html>