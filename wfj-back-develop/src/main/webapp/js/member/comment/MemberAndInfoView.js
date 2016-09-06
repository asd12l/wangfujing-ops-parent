

$(function() {
		$("#registrationTime_input").daterangepicker();
		initOlv();
	});



function productQuery(){
		
		$("#cid_from").val($("#cid_input").val().trim());
		$("#belongStore_from").val($("#belongStore_input").val().trim())
		$("#mobile_from").val($("#mobile_input").val().trim());
		$("#identityNo_from").val($("#identityNo_input").val().trim());
		$("#email_from").val($("#email_input").val().trim());
		$("#idType_from").val($("#idType_input").val().trim());
		 //会员等级
		$("#memberLevel_from").val($("#memberLevel_input").val().trim());
		//注册时间
		var strTime = $("#registrationTime_input").val().trim();
		if(strTime!=""){
			strTime = strTime.split("- ");
			$("#timeStartDate_form").val(strTime[0].replace("/","-").replace("/","-"));
			$("#timeEndDate_form").val(strTime[1].replace("/","-").replace("/","-"));
		}else{
			$("#timeStartDate_form").val("");
			$("#timeEndDate_form").val("");
		}
		
		
		var params = $("#product_from").serialize();
		params = decodeURI(params);
		
		olvPagination.onLoad(params);
	}
	
	
	
/* 		$('#registrationTime_input').daterangepicker({
		timePicker: true,
		timePickerIncrement: 30,
		format: 'YYYY-MM-DD ',
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
    }); */
	
	// 查询
	function query() {
    	
		$("#cache").val(0);
		productQuery();
		
	}
	//重置
	function reset(){
		$("#cache").val(1);
		$("#cid_input").val("");
		$("#belongStore_input").val("");
		$("#mobile_input").val("");
		$("#identityNo_input").val("");
		$("#email_input").val("");
		$("#idType_input").val("1");
		$("#registrationTime_input").val("");
		$("#memberLevel_input").val("");
		productQuery();
	}
	//初始化包装单位列表
	function initOlv() {
		var url = __ctxPath+"/memBasic/getMemBasicInfo";
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
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/mem/MemberAndInfoView.jsp");
	}
	//重置支付密码
	function showResetPayPwd(){
	
		//清空表单内容
		$("#payCode_msg").html("");
		$("#payPwd_msg").html("");
		$("#pay_cid").val("");
		$("#pay_mobile").val("");
		$("#pay_code").val("");
		$("#payCode").val("");
		
		$("#pay_password").attr("disabled",true);
		$("#pay_code").attr("disabled",true);
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i,team){
			var cid=$(this).val().trim();
			checkboxArray.push(cid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个用户重置支付密码!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要重置支付密码的用户!");
			$("#warning2").show();
			return;
		}
		var cid=checkboxArray[0];
		$("#pay_cid").val(cid);
		var mobile=$("#phone5_"+cid).val().trim();
		if(mobile==""){
			$("#warning2Body").text("该用户未绑定手机号!");
			$("#warning2").show();
			return;
		}else{
			
			$("#pay_mobile").val(mobile);
			$("#pay_mobile1").val(mobile);
		}
		$("#resetPayPwdDiv").show();
	}
	function closePay(){
		$("#resetPayPwdDiv").hide();
		//$("#payPhone").attr("disabled",false);
		 payPhone=0;
		 
	}
	
	//支付密码 倒计时发送验证吗至手机
    function payPhoneTimer() {
    	payPhone = payPhone - 1;
    	if(payPhone==0){
    		$("#payPhone").html("发送验证码");
	        $("#payPhone").attr("disabled",false);
    	}
    	
	    if (payPhone < 1) {
	        $("#payPhone").html("发送验证码");
	        $("#payPhone").attr("disabled",false);
	      //  $('#sendcodePhone').removeAttr("disabled");
	        return;
	    }
	    $("#payPhone").html("(" + payPhone + "秒)后重新发送");
	    setTimeout(payPhoneTimer, 1000);
	}
	
	//发送验证码至手机 支付重置
	function sendPayCodeToPhone(){
		
		$("#pay_code").attr("disabled",false);
		var pay_mobile=$("#pay_mobile").val().trim();
		$("#payCode_msg").html("");
		
		if(!(/^1[3|4|5|7|8]\d{9}$/.test(pay_mobile))){
			$("#payCode_msg").html("手机号码格式不正确，请重新输入！");
		}else{
		var url = __ctxPath+"/memBasic/sendPayCodeToPhone";
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : url,
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr(
						"class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(
						function() {
							$("#loading-container")
									.addClass(
									"loading-inactive")
						}, 300);
			},
			data :{"pay_mobile":pay_mobile},
			success : function(response) {
				if (response.code == "1") {
					$("#payCode_msg").html("验证码已发送");
					$("#payCode").val(response.object);
					
					//倒计时
					$("#payPhone").attr("disabled", true);
					payPhone = 90;
					payPhoneTimer();
					
				}else{
					$("#payCode_msg").html("验证码发送失败");
				}
			},
			error : function() {
				$("#payCode_msg").html("验证码发送失败");
			}

		});
		}
	}
	//支付密码光标单击验证
	$("#pay_code").blur(
	function (){
		var verCode_input=$("#pay_code").val().trim();
		var verCode=$("#payCode").val().trim();
		$("#payPwd_msg").html("");
		if(verCode!=verCode_input){
			$("#payPwd_msg").html("验证失败");
			return;
		}else{
			$("#payPwd_msg").html("验证成功");
			$("#pay_password").attr("disabled",false);
			return;
		}
	})
	
	
	function sendPayPwdToPhone(){	
		
			var cid=$("#pay_cid").val().trim();
			var pay_mobile=$("#pay_mobile").val().trim();
			$("#payPwd_msg").html("");
			var url = __ctxPath+"/memBasic/sendPayPwdToPhone?data="+new Date();
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : url,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr(
							"class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(
							function() {
								$("#loading-container")
										.addClass(
										"loading-inactive")
							}, 300);
				},
				data :{"cid":cid,"pay_mobile":pay_mobile},
				success : function(response) {
					if (response.code == "1") {
						$("#payPwd_msg").html("新密码已发送");
					}else{
						$("#payPwd_msg").html("新密码发送失败");
					}
				},
				error : function() {
					$("#payPwd_msg").html("新密码发送失败");
				}

			});
		
	}
	
	
	
	//重置登录密码
	function showResetLoginPwd(){
		 
		//清空表单内容
		$("#mobileCode_msg").html("");
		$("#emailCode_msg").html("");
		$("#login_msg").html("");
		$("#loginStatus").val("");
		$("#login_cid").val("");
		$("#loginCode").val("");
		$("#login_mobile").val("");
		$("#login_email").val("");
		$("#login_code").val("");
		$("#login_me").val("");
		 
		$("#login_password").attr("disabled",true);
		$("#login_code").attr("disabled",true);
		$("#sendcodeEmail").hide();
		 
		$("#login_mobile2").show();
		 
		$("#login_email2").hide();
		
		$("#sendcodePhone").show();
		$("#login_mobile").show();
		$("#sendcodeEmail").hide();
		$("#login_email").hide();
		
		
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i,team){
			var cid=$(this).val().trim();
			checkboxArray.push(cid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一个用户重置登录密码!");
			$("#warning2").show();
			return;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要重置登录密码的用户!");
			$("#warning2").show();
			return;
		}
		var cid=checkboxArray[0];
		$("#login_cid").val(cid);
		var mobile=$("#phone5_"+cid).val().trim();
		var email=$("#email1_"+cid).val().trim();
		if(mobile==""&&email==""){
		
			$("#warning2Body").text("该用户未绑定手机号和邮箱!");
			$("#warning2").show();
			return;
		}else{
			$("#login_mobile").val(mobile);
			$("#login_email").val(email);
			$("#login_mobile1").val(mobile);
			$("#login_email1").val(email);

		}
		$("#resetLoginPwdDiv").show();
		
	}
	//下拉选获取手机邮箱事件
	function access(){
		var login_me=$("#login_me").val();
		if(login_me=="邮箱"){
			$("#login_password").attr("disabled",true);
			$("#mobileCode_msg").html("");
			$("#login_msg").html("");
			$("#login_code").val("");
			
			$("#sendcodePhone").hide();
			$("#login_mobile").hide();
			$("#sendcodeEmail").show();
			$("#login_email").show();
			$("#login_email2").show();
			$("#login_mobile2").hide();
		} 
		if(login_me=="手机"){
			$("#login_msg").html("");
			$("#login_code").val("");
			$("#login_mobile").hide();
			$("#emailCode_msg").html("");
			 
			$("#sendcodePhone").show();
			$("#login_mobile").show();
			$("#sendcodeEmail").hide();
			$("#login_email").hide();
			$("#login_email2").hide();
			$("#login_mobile2").show();
		}
	}
	
	//取消
	function closeLogin(){
		$("#resetLoginPwdDiv").hide();
		//$("#sendcodePhone").attr("disabled",false);
			emailSecond=0;
			 
		    phoneSecond=0;
		    
	}
	
	 
	//倒计时发送验证吗至手机
    function phoneTimer() {
	    phoneSecond = phoneSecond - 1;
	    if(phoneSecond==0){
	    	 $("#sendcodePhone").html("发送验证码");
		        $("#sendcodePhone").attr("disabled",false);
		        return;
	    }
	    
	    if (phoneSecond < 1) {
	        $("#sendcodePhone").html("发送验证码");
	        $("#sendcodePhone").attr("disabled",false);
	      //  $('#sendcodePhone').removeAttr("disabled");
	        return;
	    }
	    $("#sendcodePhone").html("(" + phoneSecond + "秒)后重新发送");
	    setTimeout(phoneTimer, 1000);
	}
	
	
	//发送重置登录密码的验证码至手机
    var phoneSecond = 0;
	function sendLoginCodeToPhone(){
		$("#login_code").attr("disabled",false);
		
		$("#mobileCode_msg").html("");
		$("#emailCode_msg").html("");
		$("#login_msg").html("");
		var mobile=$("#login_mobile").val().trim();
		
		if(!(/^1[3|4|5|7|8]\d{9}$/.test(mobile))){
			$("#mobileCode_msg").html("手机号码有误，请重填");
	} else{		  
		if(mobile==""||mobile=="--"){
			$("#mobileCode_msg").html("未绑定手机号，无法发送验证码");
			return;
		}
		var url = __ctxPath+"/memBasic/sendPayCodeToPhone";
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : url,
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr(
						"class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(
						function() {
							$("#loading-container")
									.addClass(
									"loading-inactive")
						}, 300);
			},
			data :{"pay_mobile":mobile},
			success : function(response) {
				if (response.code == "1") {
					$("#mobileCode_msg").html("验证码已发送");
					$("#loginCode").val(response.object);
					$("#loginStatus").val("1");
					
					//倒计时
					
					$("#sendcodePhone").attr("disabled", true);
					phoneSecond = 90;
			        phoneTimer();
					
				}else{
					$("#mobileCode_msg").html("验证码发送失败");
				}
			},
			error : function() {
				$("#mobileCode_msg").html("验证码发送失败");
			}

		});
			}
	}
	
	
	//倒计时发送验证吗至邮箱
    function  emailTimer() {
    	emailSecond = emailSecond - 1;
    	if(emailSecond==0){
    		 $("#sendcodeEmail").html("发送验证码");
 	        $("#sendcodeEmail").attr("disabled",false);
 	        return;
    	}
    	
	    if (emailSecond < 1) {
	        $("#sendcodeEmail").html("发送验证码");
	        $("#sendcodeEmail").attr("disabled",false);
	      //  $('#sendcodePhone').removeAttr("disabled");
	        return;
	    }
	    $("#sendcodeEmail").html("(" + emailSecond + "秒)后重新发送");
	    setTimeout(emailTimer, 1000);
	}
	//发送登录密码的验证码至邮箱
    var emailSecond = 0;
	function sendLoginCodeToEmail(){
		$("#login_code").attr("disabled",false);
		$("#mobileCode_msg").html("");
		$("#emailCode_msg").html("");
		$("#login_msg").html("");
		var email=$("#login_email").val().trim();
		
		if((/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email))){
			
			
		 
		if(email==""||email=="--"){
			$("#emailCode_msg").html("未绑定邮箱，无法发送验证码");
			return;
		}
		var url = __ctxPath+"/memBasic/sendCodeToEmail";
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : url,
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr(
						"class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(
						function() {
							$("#loading-container")
									.addClass(
									"loading-inactive")
						}, 300);
			},
			data :{"email":email},
			success : function(response) {
				if (response.code == "1") {
					$("#emailCode_msg").html("验证码已发送");
					$("#loginCode").val(response.object);
					$("#loginStatus").val("2");
					//倒计时
					$("#sendcodeEmail").attr("disabled", true);
					emailSecond = 90;
					emailTimer();
					
				}else{
					$("#emailCode_msg").html("验证码发送失败");
				}
			},
			error : function() {
				$("#emailCode_msg").html("验证码发送失败");
			}

		});
		}else{
			$("#emailCode_msg").html("邮箱号码有误，请重填");
		}
	}
	//登录密码光标移除时验证
	$("#login_code").blur(
	function (){
		var verCode=$("#loginCode").val().trim();
		var verCode_input=$("#login_code").val().trim();
		if(verCode!=verCode_input||verCode==""){
			$("#login_msg").html("验证失败");
			return;
		}else{
			$("#login_msg").html("验证成功");
			$("#login_password").attr("disabled",false);//禁用按钮
			return;
		}
	})
	
	function sendLoginPwd(){
		var loginStatus=$("#loginStatus").val().trim();
		 
		if(loginStatus!="1"&&loginStatus!="2"){
			$("#login_msg").html("未发送验证码");
			return;
		}
			
			var cid=$("#login_cid").val().trim();
			var mobile=$("#login_mobile").val().trim();
			var email=$("#login_email").val().trim();
			var url = __ctxPath+"/memBasic/sendLoginPwd";
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : url,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr(
							"class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(
							function() {
								$("#loading-container")
										.addClass(
										"loading-inactive")
							}, 300);
				},
				data :{"cid":cid,"mobile":mobile,"email":email,"loginStatus":loginStatus},
				success : function(response) {
					if (response.code == "1") {
						$("#login_msg").html("新密码已发送");
					}else{
						$("#login_msg").html("新密码发送失败");
					}
				},
				error : function() {
					$("#login_msg").html("新密码发送失败");
				}

			});
		
	}		
	 
	//<!-- 加载样式 -->
	 
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

