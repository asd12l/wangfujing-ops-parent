<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script src="${ctx}/js/ajaxfileupload.js"></script>
<title>客服余额提现申请</title>
<style type="text/css">
.hide{display: none;}
.img_error{color: #e46f61; font-size: 85%;}
.but_code{float: left}
</style>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	
	function sendCode(){
		var re = /^[1-9]\d{10}$/;
		var phone = $("#accounts").val();
		if(phone == "" || phone ==null){
			$("#errPhone").html("<span style=\"color:red\">不能为空！</span>");
			return false;
		}
		if(!re.test(phone)){
			$("#errPhone").html("<span style=\"color:red\">请输入正确号码！</span>");
			return false;
		}
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/memDrawback/sendPhoneCode",
			dataType:"json",
			data: {
				"phone":phone
			},
			ajaxStart: function() {$("#loading-container").attr("class","loading-container");},
			ajaxStop: function() {
				setTimeout(function() {$("#loading-container").addClass("loading-inactive");},300);
			},
			success: function(response) {
				if(response.code == "1"){
					$("#balance1").val(response.object.balance);
					$("#balance").html("<span style=\"color:red;\">"+response.object.balance+"￥</span>");
					$("#memberSid").val(response.object.memberSid);
					$("#errPhone").html("<span style=\"color:red\">发送成功！</span>");
				}else{
					$("#errPhone").html("<span style=\"color:red\">"+ response.desc +"</span>");
					return false;
			}
				return true;
			}
		});
	} 
	//查看用户信息
	function look(){
		var re = /^[1-9]\d{10}$/;
		var phone = $("#accounts").val();
		if(phone == "" || phone ==null){
			$("#errPhone").html("<span style=\"color:red\">不能为空！</span>");
			return false;
		}
		if(!re.test(phone)){
			$("#errPhone").html("<span style=\"color:red\">请输入正确号码！</span>");
			return false;
		}
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/memDrawback/getMemberInfoByMobile",
			dataType:"json",
			data: {
				"mobile":phone
			},
			ajaxStart: function() {$("#loading-container").attr("class","loading-container");},
			ajaxStop: function() {
				setTimeout(function() {$("#loading-container").addClass("loading-inactive");},300);
			},
			success: function(response) {
				if(response.code == "1"){
					var member1 = response.object;
					var member = JSON.parse(member1);
					var cmname = member.cmname;
					var cmnickname = member.cmnickname;
					var cmidtype = member.cmidtype;
					var cmidno = member.cmidno;
					if(cmidtype != null){
						if(cmidtype == "1"){
							$("#cmidtype").html("身份证");
						}else if(cmidtype == "2"){
							$("#cmidtype").html("护照");
						}else if(cmidtype == "3"){
							$("#cmidtype").html("驾驶证");
						}else if(cmidtype == "4"){
							$("#cmidtype").html("警官证");
						}else if(cmidtype == "5"){
							$("#cmidtype").html("军官证");
						}else if(cmidtype == "6"){
							$("#cmidtype").html("其他");
						}
					}
					$("#cmname").html(cmname);
					$("#cmnickname").html(cmnickname);
					
					$("#cmidno").html(cmidno);
					$("#editDiv1").show();
				}else{
					
					return false;
			}
				return true;
			}
		});
	} 
	 
	function closeMerchant22(){
		$("#editDiv1").hide();
	}
	 
	function verifyCode(){
		var phone = $("#accounts").val();
		var code = $("#code").val();
		if(phone=="" || phone==null){
			$("#errPhone").html("<span style=\"color:red\">不能为空！</span>");
			return false;
		}
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/memDrawback/checkPhoneCode",
			dataType:"json",
			data: {
				"phone":phone,
				"code":code
			},
			ajaxStart: function() {$("#loading-container").attr("class","loading-container");},
			ajaxStop: function() {
				setTimeout(function() {$("#loading-container").addClass("loading-inactive");},300);
			},
			success: function(response) {
				if(response.code == "1"){
					$("#errCode").html("<span style=\"color:red\">验证通过！</span>");
					return true;
				}else{
					$("#errCode").html("<span style=\"color:red\">验证失败！</span>");
					return false;
				}
				
			}
		});
	}
	
	function verifyName(){
		var name = $("#name").val();
		if(name == "" || name == null){
			$("#errName").html("<span style=\"color:red\">不能为空！</span>");
			return false;
		}else{
			$("#errName").html("");
			return true;
		}
	}
	
	function verifyBank(){
		var bank = $("#bank").val();
		if(bank == "" || bank == null){
			$("#errBank").html("<span style=\"color:red\">不能为空！</span>");
			return false;
		}else{
			$("#errBank").html("");
			return true;
		}
	}
	
	function verifyErrWithdrowMoney(){
		var withdrowMoney = $("#withdrowMoney").val();
		var re = /^[+]?[\d]+(([\.]{1}[\d]+)|([\d]*))$/;
		var balance = $("#balance1").val();
		if(!re.test(withdrowMoney)){
			$("#errWithdrowMoney").html("<span style=\"color:red\">输入正数！</span>");
			return false;
		}else{
			$("#errWithdrowMoney").html("");
			return true;
		}
		if(withdrowMoney > balance){
			$("#errWithdrowMoney").html("<span style=\"color:red\">您输入的金额大于实际金额！</span>");
			return false;
		}else{
			$("#errWithdrowMoney").html("");
			return true;
		}
	}
	function verifyBankCardNo(){
		var re1 = /^\d{16}$/g;
		var re2 = /^\d{19}$/g;
		var bankCardNo = $("#bankCardNo").val();
		var bankCardNo2 = $("#bankCardNo2").val();
		if(!re1.test(bankCardNo) && !re2.test(bankCardNo)){
			$("#errBankCardNo").html("<span style=\"color:red\">银行卡号是16位或19位正整数！</span>");
			return false;
		}else{
			$("#errBankCardNo").html("");
			return true;
		}
	}
	function verifyBankCardNo2(){
		var re1 = /^\d{16}$/g;
		var re2 = /^\d{19}$/g;
		var bankCardNo = $("#bankCardNo").val();
		var bankCardNo2 = $("#bankCardNo2").val();
		if(!re1.test(bankCardNo2) && !re2.test(bankCardNo2)){
			$("#errBankCardNo2").html("<span style=\"color:red\">银行卡号是16位或19位正整数！</span>");
			return false;
		}
		if(bankCardNo != bankCardNo2){
			$("#errBankCardNo2").html("<span style=\"color:red\">前后输入不一致！</span>");
			return false;
		}else{
			$("#errBankCardNo2").html("");
			return true;
		}
	}
	
	function submit1(){
		var phone = $("#accounts").val();
		var code = $("#code").val();
		var memberSid = $("#memberSid").val();
		var balance1 = $("#balance1").val();
		var withdrowMoney = $("#withdrowMoney").val();
		var name = $("#name").val();
		var bank = $("#bank").val();
		var bankCardNo = $("#bankCardNo").val();
		var bankCardNo2 = $("#bankCardNo2").val();
		var withdrowReason = $("#withdrowReason").val();
		var withdrowMedium = $("#withdrowMedium").val();
		var withdrowType = $("#withdrowType").val();
		verifyCode();
		if(!verifyErrWithdrowMoney()|| !verifyName() || !verifyBank() || !verifyBankCardNo() || !verifyBankCardNo2()){
			return;
		}
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/memDrawback/applyWithdrawals",
			dataType:"json",
			data: {
				"phone":phone,
				"code":code,
				"memberSid":memberSid,
				"balance1":balance1,
				"withdrowMoney":withdrowMoney,
				"name":name,
				"bank":bank,
				"bankCardNo":bankCardNo,
				"withdrowReason":withdrowReason,
				"withdrowType": withdrowType,
				"withdrowMedium":withdrowMedium
			},
			ajaxStart: function() {$("#loading-container").attr("class","loading-container");},
			ajaxStop: function() {
				setTimeout(function() {$("#loading-container").addClass("loading-inactive");},300);
			},
			success: function(response) {
				if(response.code == "1"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>添加成功!</strong></div>");
 	     	  		$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.desc+"</strong></div>");
	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					
				}
				return;
			}
		});
	}
	
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
		$("#pageBody").load(__ctxPath+"/jsp/mem/MemberMoneyWithdraw.jsp");
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
								<span class="widget-caption">用户验证：</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">  
									 
									<div class="form-group">
										<label class="col-lg-3 control-label">登录帐号：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="accounts" name="accounts" placeholder="手机"/>
										</div>
										<div class="col-lg-1" style="padding:3px 0px 0px 0px;width:50px;">
											<button type="button" class="but_code" onclick="look();">查看</button>
										</div>
										<div class="col-lg-1" style="padding:3px 0px 0px 0px;width:90px;">
											<button type="button" class="but_code" onclick="sendCode();">发送验证码</button>
										</div>
										<div class="col-lg-1" id="errPhone" style="padding:5px 0px 0px 0px;">
											
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">验证码</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="code" name="code" onblur="verifyCode()" placeholder="输入验证码"/>
										</div>
										<div class="col-lg-1" id="errCode" style="padding:5px 0px 0px 0px;">
											
										</div>
									</div>
								</form>
							</div>
							<div class="widget-header">
								<span class="widget-caption">提现信息：</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal" enctype="multipart/form-data">  
									 
									<div class="form-group">
										<label class="col-lg-3 control-label">用户余额：</label>
										<div class="col-lg-3" id="balance"  style="padding:5px 0px 0px 12px;">
											
										</div>
										<input type="hidden" id="memberSid"/>
										<input type="hidden" id="balance1"/>
									</div>
						
									<div class="form-group">
										<label class="col-lg-3 control-label">*提现金额：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="withdrowMoney" name="withdrowMoney" onblur="verifyErrWithdrowMoney()" placeholder=""/>
										</div>
										<div class="col-lg-1" id="errWithdrowMoney" style="padding:5px 0px 0px 0px;">
											
										</div>
									</div>
        							
        							<div class="form-group">
										<label class="col-lg-3 control-label">*开户名：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="name" name="name" onblur="verifyName()" placeholder=""/>
										</div>
										<div class="col-lg-1" id="errName" style="padding:5px 0px 0px 0px;">
											
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">*开户银行：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="bank" name="bank" onblur="verifyBank()" placeholder=""/>
										</div>
										<div class="col-lg-1" id="errBank" style="padding:5px 0px 0px 0px;">
											
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">*银行卡号：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="bankCardNo" name="bankCardNo" onblur="verifyBankCardNo()" placeholder=""/>
										</div>
										<div class="col-lg-1" id="errBankCardNo" style="padding:5px 0px 0px 0px;">
											
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">*确认卡号：</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="bankCardNo2" name="bankCardNo2" onblur="verifyBankCardNo2()" placeholder=""/>
										</div>
										<div class="col-lg-1" id="errBankCardNo2" style="padding:5px 0px 0px 0px;">
											
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">申请理由：</label>
										<div class="col-lg-3">
											<textarea name="withdrowReason" id="withdrowReason" style="width:385px;height:80px;"></textarea>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">退款介质：</label>
										<div class="col-lg-3">
											<select  id="withdrowMedium" style="padding: 0 0;width: 200px">
												<option value="">请选择</option>
												<option value="支付宝">支付宝</option>
											</select>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-lg-3 control-label">退款类型：</label>
										<div class="col-lg-3">
											<select  id="withdrowType" style="padding: 0 0;width: 200px">
												<option value="">请选择</option>
												<option value="支付宝批量付">支付宝批量付</option>
											</select>
										</div>
									</div>
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<button class="btn btn-success" style="width: 25%;" type="button" onclick="submit1();">提交</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal modal-darkorange" style="background: 0.5, 0.5, 0.5;" 
		id="editDiv1">
		<div class="modal-dialog"
			style="width: 800px; height: auto; margin: 4% auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeMerchant22();">×</button>
					<h4 class="modal-title" id="divTitle">查看提现申请</h4>
				</div>
				<div class="page-body" id="pageBodyRight">
					<div class="row">
						<form method="post" class="form-horizontal" id="editForm">
							<div class="col-xs-12 col-md-12">
									<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">姓名：</label>
									<div class="col-md-6" id="cmname">
										
									</div>
									<br>&nbsp;
									</div>
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">昵称：</label>
										<div class="col-md-6" id="cmnickname">
										
									</div>
									<br>&nbsp;
								</div>
								
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">证件类型：</label>
										<div class="col-md-6" id="cmidtype">
										
									</div>
									<br>&nbsp;
								</div>
									
								<div class="col-md-12" id="" style="padding: 10px 100px;">
									<label class="col-md-5 control-label"
										style="line-height: 20px; text-align: right;">证件号：</label>
										<div class="col-md-6" id="cmidno">
										
									</div>
									<br>&nbsp;
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
 <!-- /Page Body -->
	<script>
    </script>
</body>
</html>