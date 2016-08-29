<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%-- <script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script>
	<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script>
	<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
	<!--Bootstrap Date Range Picker-->
	<script src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/datetime/Pageload.js"></script>
	<script type="text/javascript" src="js/member/comment/MemberAndInfoView.js"></script> --%>
	<style type="text/css">
		.trClick>td,.trClick>th{
			color:red;
		}
		#pay_content{
			text-align:center;
		}
		#login_content{
			text-align:center;
		}
	</style>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image="http://images.shopin.net/images";
	saleMsgImage="http://images.shopin.net/images";
	ctx="http://www.shopin.net";
	 
	var olvPagination;
	
	</script>
</head>
<body>
	<!--重置登录密码 -->
<div class="modal modal-darkorange"
	 id="resetLoginPwdDiv">
	<div class="modal-dialog"
		 style="width: 800px; height: auto; margin: 4% auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closeLogin();">×</button>
				<h4 class="modal-title">重置登录密码</h4>
			</div>
			<div class="page-body">
				<div class="row" id="login_content">
					 
					<form method="post" class="form-horizontal">
						<div class="col-xs-12 col-md-12">
							<input type="hidden" name="login_cid" id="login_cid">
							<input type="hidden" name="loginCode" id="loginCode">
							<input type="hidden" name="loginStatus" id="loginStatus">
						</div>
						<p style="text-align:left; padding:15px">用户验证:</p>
						<div class="mtb10"> 
						 
						<div class="col-md-12" style="padding: 10px 100px; display: block;"  ">								   
 								 <div class="col-md-6">
   								 <select id="login_me" onclick="access()" class=" col-md-5" style="line-height: 20px; width:55px; float:none; height:33px; ">
										<option checked="checked" value="手机"> 手 机 </option>
										<option value="邮箱">邮箱</option>
								</select> 
						 
								<input type="text" class="form-control" id="login_mobile" name="login_mobile" style=" width:30px; float:right;">
   							 <span style="color:red;float:right;" id="mobileCode_msg"></span>
   							 
   							 <input type="text" class="form-control" name="login_email"
										   id="login_email" style=" width:30px;  float:right; "/>
   							 <span id="emailCode_msg" style="color:red;float: right;"></span>
							</div>																	 																			 								
								<a class="btn btn-info" onclick="sendLoginCodeToPhone();"id="sendcodePhone">发送验证码</a>
								<a onclick="sendLoginCodeToEmail();" class="btn btn-info"id="sendcodeEmail">发送验证码</a>&nbsp;<br>&nbsp;								
						</div>
							</div>
								 <!-- <div class="col-md-12"   style="padding: 10px 100px;">
								<div class="col-md-6">
								 <select id="login_me1" onclick="access1()" class=" col-md-5" style="line-height: 20px; width:55px; float:none; height:33px; ">
										<option value="邮箱">邮箱</option>
										<option  value="手机"> 手 机 </option>
								</select>  
									<input type="text" class="form-control" name="login_email"
										   id="login_email" style=" width:30px;  float:right; "/>
									<span id="emailCode_msg" style="color:red;float: right;"></span>
								</div>
								 	<div>
										<a onclick="sendLoginCodeToEmail();" class="btn btn-info">发送验证码</a>&nbsp;<br>&nbsp; 
									</div>
							     </div> -->
							     
							<div class="col-md-12"  style="padding: 10px 100px;">
								<div class="col-md-6" >
									 <label class="col-md-5 control-label" style="line-height: 15px; float:left;width:105px;">输入验证码</label>
									<input type="text" class="form-control" name="login_code"  
									 id="login_code" style=" width:30px; float:right;"/>
									<span id="login_msg" style="color:red"></span>
								</div>
								
							</div>
							<p style="text-align:left; padding:15px">重置密码:</p>
							<div class="col-md-12"  style="padding: 10px 100px;">
							<div class="col-md-6" id="login_mobile2">
								<label class=" control-label col-md-5" style="line-height: 20px; width:85px; float:none;">手机号：</label>  
								<input type="text" class="form-control" name="login_mobile1" id="login_mobile1" style=" width:30px; float:right;">
							</div>
								<div class="col-md-6" id="login_email2">
									<input type="text" class="form-control" name="login_email1"
										   id="login_email1" style=" width:30px;  "/>
									<label class="col-md-5 control-label"
									   style="line-height: 20px; float:left; width:105px;">邮箱：</label>
								</div>
							<a onclick="sendLoginPwd();" id="login_password" class="btn btn-info"   >发送新密码</a>&nbsp;
							<a onclick="closeLogin();" class="btn btn-primary">取消</a>&nbsp;&nbsp;
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

<!--重置支付密码 -->
<div class="modal modal-darkorange"
	 id="resetPayPwdDiv">
	<div class="modal-dialog"
		 style="width: 800px; height: auto; margin: 4% auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button" onclick="closePay();">×</button>
				<h4 class="modal-title" id="divTitle">重置支付密码</h4>
			</div>
			
			<div class="page-body">
			
				<div class="row" id="pay_content">
					<form method="post" class="form-horizontal" id="editForm">
					<p style="text-align:left; padding:15px">用户验证:</p>
						<div class="col-xs-12 col-md-12">
							<input type="hidden" name="pay_cid" id="pay_cid">
							<input type="hidden" name="payCode" id="payCode">
							
							<div class="col-md-12"  style="padding: 10px 100px;">
								<div class="col-md-6">
									<label class="col-md-5 control-label"
									   style="line-height: 20px;   width:85px;">手机号：</label>  
									<input type="text" class="form-control" name="pay_mobile"
										   id="pay_mobile" style=" width:30px; float:right;"/>  
									<span id="payCode_msg" style="color:red;float:right;"></span>
								</div>
								<div>
								<a onclick="sendPayCodeToPhone();" class="btn btn-info">发送验证码</a>
								</div>
							</div>
							<div class="col-md-12"  style="padding: 10px 100px;">
								<div class="col-md-6">
									<label style="line-height: 20px; width:85px;" class="col-md-5 control-label" >输入验证码</label>
									<input type="text" class="form-control" name="pay_code"  
										   id="pay_code"  style=" width:30px; float:right;" />
									<span id="payPwd_msg" style="color:red"></span>
								</div>
								<br>&nbsp;
							</div>
						</div>
						<br>&nbsp;
						
						<div class="mtb10">
						<p style="text-align:left; padding:15px">重置密码:</p>
						<div class="col-md-12"  style="padding: 10px 100px;">
							<div class="col-md-6">
								<label class=" control-label col-md-5" style="line-height: 20px; width:85px; float:none;">手机号：</label>  
								<input type="text" class="form-control" name="pay_mobile1" id="pay_mobile1" style=" width:30px; float:right;">
							</div>
               				<a class="btn btn-info" id="pay_password" onclick="sendPayPwdToPhone();">发送新密码</a>&nbsp;&nbsp; 
						   	<a class="btn btn-primary" onclick="closePay();">取消</a>&nbsp;&nbsp;
  			
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
</body>
</html>