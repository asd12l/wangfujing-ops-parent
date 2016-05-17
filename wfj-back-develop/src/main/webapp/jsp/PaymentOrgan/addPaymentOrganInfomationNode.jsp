<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("ctx", request.getContextPath());
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	$(function() {
		
		$("#name").change(function() {
			findPayCode($("#name option:selected").val());
		});

		$("#save").click(function() {
			famesave();
		});

		$("#close").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/PaymentOrgan/PaymentOrganView.jsp");
		});

		//下拉框点击显示门店名称事件
		var parentSid = $("#parentSid");
		$("#parentSid").one("click",function(){
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/organization/queryListOrganization",
				dataType : "json",
				data : "organizationType=3",
				success : function(response) {
					var result = response.list;
					parentSid.html("<option value=''>请选择门店</option>");
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.organizationCode + "'>" + ele.organizationName + "</option>");
						option.appendTo(parentSid);
					}
					return;
				},
				error : function(XMLHttpRequest, textStatus) {		      
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
		});
		

		//一级支付方式名称
		var name = $("#name");
		$("#name").one("click",function(){
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/payment/queryPaymentTypeByCode",
				dataType : "json",
				data : "parentCode=0",
				success : function(response) {
					var result = response.list;
					name.html("<option value=''>请选择支付方式</option>");
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.payCode + "'>" + ele.name + "</option>");
						option.appendTo(name);
					}
					return;
				},
				error : function(XMLHttpRequest, textStatus) {		      
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
		});
		
	});
	
	//门店添加
	function addmendian() {
		var shopSid = $("#parentSid option:selected").val();
		var storedName = $("#parentSid option:selected").text();
		if(shopSid !=""){
		//表示不存在
		var flag = true;
		$(".tr_md").each(function(i, team) {
			storeCode1 = $(this).children("th:eq(2)").text();
			if (storeCode1 == shopSid) {
				flag = false;
			}
		});
		if (flag) {
			var rowCode = $("<tr class='tr_md' height='30PX'>"
					+"<th align='left' width='30px'><div class='checkbox'><label style='padding-left:5px;text-align: center;'>"
					+"<input type='checkbox' class='"+shopSid+"' value='"+shopSid+"'/>"
					+"<span class='text'></span></label></div></th>"
					+ "<th style='text-align: center;' >"
					+ storedName + "</th>" + "<th style='display:none'>"
					+ shopSid + "</th></tr>");
			$("#rowCode").append(rowCode);
		} else {
			alert("门店已存在");
		}
		}else{
			alert("请选择门店");
		}
	}
	//支付方式添加
	function addzhifu() {
		if ($("#name2 option:selected").val() == "") {
			
			alert("请选择二级支付方式");
			return;
			/* var name = $("#name option:selected").text();
			var payCode = $("#name option:selected").val();
			if(payCode!=""){
			//表示支付方式不存在
			var falg = true;
			$(".tr_zf").each(function(j, team) {
				var payCode1 = $(this).children("th:eq(2)").text();
				if (payCode == payCode1) {
					falg = false;
				}
			});
			if (falg) {
				var rowCodes = $("<tr class='tr_zf' height='30PX'>"
						+"<th align='left'><div class='checkbox'><label>"
						+"<input type='checkbox' class='"+payCode+"' value='"+payCode+"'/>"
						+"<span class='text'></span></label></div></th>"
						+ "<th style='text-align: center;' width='10%'>"
						+ name
						+ "</th>"
						+ "<th style='display:none'>"
						+ payCode
						+ "</th>"
						+ "<th style='text-align: center;' width='30%'><input type='text' class='bank' onmouseout='deletfont();'  name='bankBIN'/></th></tr>");
				$("#rowCodes").append(rowCodes);
			} else {
				alert("一级支付方式已存在");
			}
			}else{
				alert("请选择一级支付方式");
			} */
		} else {
			var name = $("#name2 option:selected").text();
			var payCode = $("#name2 option:selected").val();
			//表示支付方式不存在
			var falg = true;
			$(".tr_zf").each(function(j, team) {
				var payCode1 = $(this).children("th:eq(2)").text();
				if (payCode == payCode1) {
					falg = false;
				}
			});
			if (falg) {
				var rowCodes = $("<tr class='tr_zf' height='30PX'>"
						+"<th align='left' style='width:30px;'><div class='checkbox'><label style='padding-left:5px;text-align: center;'>"
						+"<input type='checkbox' class='"+payCode+"' value='"+payCode+"'/>"
						+"<span class='text'></span></label></div></th>"
						+ "<th style='text-align: center;' width='300px'>"
						+ name
						+ "</th>"
						+ "<th style='display:none'>"
						+ payCode
						+ "</th>"
						+ "<th style='text-align: center;'><input type='text' class='bank' name='bankBIN'/></th></tr>");
				$("#rowCodes").append(rowCodes);
			} else {
				alert("二级支付方式已存在");
			}
		}
	}
	function findPayCode(payCode1) {
		//二级支付方式名称
		var name2 = $("#name2");
		$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/payment/queryPaymentTypeByCode",
				dataType : "json",
				data : "parentCode=" + payCode1,
				success : function(response) {
					var result = response.list;
					if (payCode1 == "" || result == "") {
						name2.html("<option value=''>请选择二级支付方式</option>");
					} else {
						name2.html("");
					}
					for ( var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.payCode + "'>"
								+ ele.name + "</option>");
						option.appendTo(name2);
					}
					return;
				},
				error : function(XMLHttpRequest, textStatus) {		      
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
	
	function famesave() {
		//表示不存在
		var falg = true;
		
		var storeCode=$(".tr_md").children("th:eq(1)").text();
		var code=$(".tr_zf").children("th:eq(1)").text();
		if(storeCode ==""){
			falg=false;
			alert("门店必选");
		}
		if(code ==""){
			falg=false;
			alert("支付必选");
		}
		$(".bank").each(function(i, team) {
			bankBIN = $(this).val();
			if (bankBIN == "") {
				falg = false;
			}
		});
		if(falg){	
			
			var url = __ctxPath + "/payment/createPaymentOrgan";
			var shopSid = '';
			var code = '';
			$(".tr_md").each(function(i, team) {
				storeCode = $(this).children("th:eq(2)").text();
				$(".tr_zf").each(function(j, team) {
					var payCode = $(this).children("th:eq(2)").text();
					var bankBIN = $(this).children("th:eq(3)").children().val();
					code = payCode + ";" + bankBIN;
					if (shopSid != '') {
						shopSid = shopSid + "," + storeCode + ";" + code;
					} else {
						shopSid = storeCode + ";" + code;
					}
				});
	
			});
		//return false;
		$.ajax({
				type : "post",
				url : url,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
							$("#loading-container").addClass("loading-inactive");
							}, 300);
				},
				data : {
					"shopSid" : shopSid
				},
				success : function(response) {
					if (response.success == "true") {
						$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功，返回列表页!</strong></div>");
						$("#modal-success").attr({"style" : "display:block;","aria-hidden" : "false","class" : "modal modal-message modal-success"});
					} else if (response.data.errorMsg != "") {
						$("#warning2Body").text(buildErrorMessage(response.data.errorCode,response.data.errorMsg));
						$("#warning2").show();
					}
					return;
				},
				error : function(XMLHttpRequest, textStatus) {		      
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
		}else{
			$(".bank").each(function(i, team) {
				bankBIN = $(this).val();
				if (bankBIN == "") {
					$(this).after("<font color='red' size='2'>*不能为空</font>");
				}
			});
		}
	}
	
	function deletfont(){
		var bankBIN=$(".bank").val();
		if(bankBIN !=""){
			$(".bank").next().remove();
		}
	}
	
	//删除门店
	function deletemd(){
		$("input[type='checkbox']:checked").each(function(i, team) {
			$(this).parent().parent().parent().parent().remove();
		});
	}
	//删除支付方式
	function deletezf(){
		$("input[type='checkbox']:checked").each(function(i, team) {
			$(this).parent().parent().parent().parent().remove();
		});
	}
	function successBtn() {
		$("#modal-success").attr({"style" : "display:none;","aria-hidden" : "true","class" : "modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath + "/jsp/PaymentOrgan/PaymentOrganView.jsp");
	}
</script>
</head>
<body>
<div class="page-body">
   <div class="widget radius-bordered">
    	<div class="widget-header ">
        	<h5 class="widget-caption">添加门店支付方式</h5>
        </div>
        <div class="form-group widget-body clearfix">
            <div style="width:40%;min-height:350px;float:left;">
            	<div class="mtb10 clearfix">
	                <label class="control-label">门店名称：</label>
	                <select class="form-control" id="parentSid" name="storeCode" data-bv-field="country" style="width:185px;">
	                     <option value="">请选择</option>
	                </select>&nbsp;&nbsp;
	                <a id="editabledatatable_new" onclick="addmendian();" class="btn btn-primary"><i class="fa fa-plus"></i> 添加</a>&nbsp;&nbsp;
	                <a onclick="deletemd();" class="btn btn-primary"><i class="fa fa-times"></i>移除</a>
                </div>
                <div>
                 <table
	                        class="table table-bordered table-striped table-condensed table-hover flip-content"
	                        id="rowCode_title">
	                    <thead class="flip-content bordered-darkorange">
	                    <tr role="row">
	                        <th width="39px"></th>
	                        <th style="text-align: center;">门店名称</th>
	                        <th style="display: none">门店编码</th>
	                    </tr>
	                    </thead>
	                </table>
	             </div>
                <div style="height:300px;overflow-y: auto;">
	                <table
	                        class="table table-bordered table-striped table-condensed table-hover flip-content"
	                        id="rowCode">
<!-- 	                    <thead class="flip-content bordered-darkorange"> -->
<!-- 	                    <tr role="row"> -->
<!-- 	                        <th width="5%"></th> -->
<!-- 	                        <th style="text-align: center;" width=45%>门店名称</th> -->
<!-- 	                        <th style="display: none">门店编码</th> -->
<!-- 	                    </tr> -->
<!-- 	                    </thead> -->
	                </table>
                </div>
            </div>
			<div style="width:1%;float:left;">&nbsp;</div>
            <div style="width:59%;min-height:350px;float:left;">
            	<div class="mtb10 clearfix">
            		<label class="control-label">支付方式：</label>
            		<select class="form-control" id="name" name="name" data-bv-field="country" style="width:185px;">
                        <option value="">请选择一级支付方式</option>
                    </select>&nbsp;&nbsp;
                    <select class="form-control" id="name2" name="name" data-bv-field="country" style="width:185px;">
                        <option value="">请选择二级支付方式</option>
                    </select>
            		<a onclick="addzhifu();" class="btn btn-primary"><i class="fa fa-plus"></i> 添加</a>
            		<a onclick="deletezf();" class="btn btn-primary"><i class="fa fa-times"></i> 移除</a>
            	</div> 
            	<div>         
	                <table
	                        class="table table-bordered table-striped table-condensed table-hover flip-content"
	                        id="rowCodes_title" >
	                    <thead class="flip-content bordered-darkorange">
	                    <tr role="rows">
	                        <th width="39px"></th>
	                        <th style="text-align: center;width:300px;">支付方式名称</th>
	                        <th style="display: none">支付方式编码</th>
	                        <th style="text-align: center;">银行标识</th>
	                    </tr>
	                    </thead>
	                </table>
                </div>  
            	<div style="height:300px;overflow-y: auto;">         
	                <table
	                        class="table table-bordered table-striped table-condensed table-hover flip-content"
	                        id="rowCodes" >
<!-- 	                    <thead class="flip-content bordered-darkorange"> -->
<!-- 	                    <tr role="rows"> -->
<!-- 	                        <th width="5%"></th> -->
<!-- 	                        <th style="text-align: center;" width=28%>支付方式名称</th> -->
<!-- 	                        <th style="display: none">支付方式编码</th> -->
<!-- 	                        <th style="text-align: center;" width=27%>银行标识</th> -->
<!-- 	                    </tr> -->
<!-- 	                    </thead> -->
	                </table>
                </div>  
            </div>

            <div class="col-lg-offset-4 col-lg-6" style="margin-top:20px">
                <input class="btn btn-success" style="width: 25%;" id="save"
                       type="button" value="保存 " />&emsp;&emsp; <input
                    class="btn btn-danger" style="width: 25%;" id="close"
                    type="button" value="取消" />
            </div>


        </div>
    </div>
</div>	
</body>
</html>