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
  <script type="text/javascript">
		__ctxPath = "${pageContext.request.contextPath}";
		image="http://images.shopin.net/images";
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net"; 
	
	
	var supplierInfoPagination;
	$(function() {    	
		var storeCode=storeCode_;
	    initSupplierInfo(storeCode);
	    $("#pageSelect").change(supplierInfoQuery);
	    $("#pageSelects").change(supplierInfoQuerys);
	    
	    $("#close").click(function(){ 
			 $("#pageBody").load(__ctxPath+"/jsp/PaymentOrgan/PaymentOrganView.jsp"); 
			
		});
	});
	function supplierInfoQuery(){
		$("#organizationName_from").val($("#organizationName_input").val());
        var params = $("#supplierInfo_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        supplierInfoPagination.onLoad(params);
   	}
	function find() {
		$("#organizationName_input").change(supplierInfoQuery);
		supplierInfoQuery();
	}
	
	function reset(){
		$("#organizationName_input").val("");
		supplierInfoQuery();
	}
 	function initSupplierInfo(storeCode) {
		var url = $("#ctxPath").val()+"/payment/queryPaymentTypeStorCode";
			supplierInfoPagination = $("#supplierInfoPagination").myPagination({
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
	             param:'parentCode=0&storeCode='+storeCode,
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
	               $("#supplierInfo_tab tbody").setTemplateElement("supplierInfo-list").processTemplate(data);
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
		$("input[type='checkbox']:checked").each(function(i, team){
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if(checkboxArray.length>1){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}else if(checkboxArray.length==0){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要删除的列!</strong></div>");
			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
			 return false;
		}
		var value=	checkboxArray[0];
		var url = __ctxPath+"/payment/delPaymentType";
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
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
					$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
				return;
			}
		});
	}
	
	function editPaymentType() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var sid = $(this).val();
			checkboxArray.push(sid);
		});
		if (checkboxArray.length > 1) {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		} else if (checkboxArray.length == 0) {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		
		var value = checkboxArray[0];
		sid_ = $("#tdCheckbox_" + value).val().trim();
		name_ = $("#name_" + value).text().trim();
		storeName_= $("#storeName_" + value).text().trim();
		remark_= $("#remark_" + value).text().trim();
		var url = __ctxPath + "/jsp/PaymentType/editPaymentTypeInfomationNode.jsp";
		$("#pageBody").load(url);
	}
	function spanTd(parentCode) {
		
		$(".trApp").remove();
		$(".classApp").attr("class",
		"expand-collapse click-expand glyphicon glyphicon-plus classApp");
		
		if ($("#spanTd_" + parentCode).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus classApp") {
			$("#spanTd_" + parentCode).attr("class",
					"expand-collapse click-collapse glyphicon glyphicon-minus classApp");
			var option = "<tr class='trApp' id='afterTr"+parentCode+"'><td></td><td colspan='5'><div style='padding:2px'>"
			+ "<table  class='table table-bordered table-striped table-condensed table-hover flip-content' id='supplier_tab'><thead><tr role='row'><th style='text-align:center;'>二级支付方式名称</th><th style='text-align:center;'>二级支付编码</th></tr></thead>"
            +"<tbody></tbody>";
			option += "</table></div>"
			+" <div class='pull-left' style='margin-top: 5px;'>"
			+"<form id='supplierInfo_form' action=''>"
			+"<div class='col-lg-12'>"
            	+"<select id='pageSelects' name='pageSize' style='padding: 0 12px;'>"
					+"<option>5</option>"
				+"</select>"
			+"</div>&nbsp;"  
			+"<input type='hidden' id='organizationParentCode_from' name='parentCode' />"
		+"</form>"
	+"</div>"
    +"<div id='supplierInfoPaginations'></div>"
			+"</td></tr>";
			$("#gradeX" + parentCode).after(option);
			
			initSupplier(parentCode);
		} else {
			$("#spanTd_" + parentCode).attr("class",
					"expand-collapse click-expand glyphicon glyphicon-plus classApp");
		
			$("#afterTr" + parentCode).remove();
			
		}
	}
	var supplierInfoPaginations;
	function supplierInfoQuerys(){
        var params = $("#supplierInfo_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        supplierInfoPaginations.onLoad(params);
   	}
	
	function initSupplier(parentCode) {
		var url = $("#ctxPath").val()+"/payment/queryPaymentTypeByParentCode";
			supplierInfoPaginations = $("#supplierInfoPaginations").myPagination({
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
	               $("#supplier_tab tbody").setTemplateElement("supplier-list").processTemplate(data);
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
                                    <span class="widget-caption"><h5>门店详情</h5></span>
                                </div>
                                <div class="widget-body" id="pro">
                                    <table class="table table-bordered table-striped table-condensed table-hover flip-content" id="supplierInfo_tab">
                                        <thead class="flip-content bordered-darkorange">
                                            <tr role="row">
                                            	<th width="7.5%"></th>
                                                <th width="10%" style="text-align: center;">支付方式详情</th>
                                                <th style="text-align: center;">门店名称</th>
                                                <th style="text-align: center;">门店编码</th>
                                                <th style="text-align: center;">一级支付名称</th>
                                                <th style="text-align: center;">一级支付编码</th>
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
											<input type="hidden" id="organizationName_from" name="name" />
										</form>
									</div>
                                    <div id="supplierInfoPagination"></div>
                                
                                <div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-danger" style="width: 25%;" id="close" type="button" value="返回" />
										</div>
									</div>
                                
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="supplierInfo-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.payCode}">
													<td align="left">
														<div class="checkbox">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" style="vertical-align:middle;">
														<span  id="spanTd_{$T.Result.payCode}" onclick="spanTd('{$T.Result.payCode}');" class="expand-collapse click-expand glyphicon glyphicon-plus classApp"></span>
													</td>
													<td align="center" id="storeName_{$T.Result.sid}">
													{#if $T.Result.storeName != '[object Object]'}
														{$T.Result.storeName}
													{#/if}</td>
													<td align="center">
													{#if $T.Result.storeCode != '[object Object]'}
														{$T.Result.storeCode}
													{#/if}</td>
													<td align="center" id="name_{$T.Result.sid}">
													{#if $T.Result.name != '[object Object]'}
														{$T.Result.name}
													{#/if}</td>
													<td align="center">
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
									<textarea id="supplier-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.payCode}">
													<td align="center" id="name_{$T.Result.sid}">
													{#if $T.Result.name != '[object Object]'}
														{$T.Result.name}
													{#/if}</td>
													<td align="center">
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
        </div>
        <!-- /Page Container -->
        <!-- Main Container -->
    </div> 
     
</body>
</html>