<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var url = __ctxPath+ "/member/getByMemberAndInfo";
	var sessionId = "<%=request.getSession().getId() %>";
  	$(function(){
  		loadLogJs();
  		$("#sid").val(sid_);
  		$("#username").val(username_);
  		$("#mobile").val(mobile_);
  		$("#email").val(email_);
  		$("#password").val(password_);
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/mem/MemberAndInfoView.jsp");
  		});
	});
  	
  	function loadLogJs(){
        $.ajax({
            type : "get",
            contentType : "application/x-www-form-urlencoded;charset=utf-8",
            url : __ctxPath + "/loadSystemParam/findValueFronSystemParamByKey",
            async : false,
            data : {
                "key" : "log_js"
            },
            dataType : "json",
            ajaxStart : function() {
                $("#loading-container").prop("class", "loading-container");
            },
            ajaxStop : function() {
                $("#loading-container").addClass("loading-inactive");
            },
            success : function(response) {
                if(response.success){
                    var logjs_url = response.value;
                    var _script=document.createElement('script');
                    _script.setAttribute('charset','gbk');
                    _script.setAttribute('type','text/javascript');
                    _script.setAttribute('src',logjs_url);
                    document.getElementsByTagName('head')[0].appendChild(_script);
                } else {
                    $("#warning2Body").text(response.msg);
                    $("#warning2").show();
                }
            }
        });
    }
		//重置密码发送邮箱
		var second = 60;
	    function sendEmail() {
	    	userName = getCookieValue("username");
	    	LA.sysCode = '64';
			LA.log('editEmailPassWord-sendEmail', '重置密码发送邮箱', userName,  sessionId);
	    	var email = $("#email").val();
			$('#showMsg').html("");
			var sid=$("#sid").val();
	        //在这邮件发重置密
	        $.ajax({
				type: "post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath + "/memberAndInfo/editEmailPassword",
				 //返回数据的格式
				dataType:"json",
	            //提交的数据
	            data: {
	                'email': email,
	                'sid':sid
	            },
	            success: function (data) {
	                if (data.code == 1) {
	                	//成功,显示发送成功
	                	alert("密码重置成功");
	                	$("#pageBody").load(__ctxPath+"/jsp/mem/MemberAndInfoView.jsp");
	                }
	            },
	            //调用出错执行的函数
	            error: function () {
	                //请求出错处理
	            	alert("密码重置失败");
                	$("#pageBody").load(__ctxPath+"/jsp/mem/MemberAndInfoView.jsp");
	            }
	        }); 
	        $('#sendCodeEmail').removeClass("br fr btn");
	        $('#sendCodeEmail').addClass("btn");
	        $('#sendCodeEmail').attr("disabled", true);
	        second = 10;
	        emailTimer();
	    }
	    function emailTimer() {
	        second = second - 1;
	        if (second < 1) {
	            $('#sendCodeEmail').text("重新发送");
	            $('#sendCodeEmail').removeClass("btn_h");
	            $('#sendCodeEmail').addClass("btn");
	            $('#sendCodeEmail').removeAttr("disabled");
	            return;
	        }
	        $('#sendCodeEmail').text("(" + second + "秒)重新发送");
	        setTimeout(emailTimer, 1000);
	    }
  
  	function successBtn(){
  		$("#model-warning").attr({"style":"display:block;z-index:9999","aria-hidden":"false","class":"modal modal-message modal-warning"});
		$("#pageBody").load(__ctxPath+"/jsp/mem/MemberAndInfoView.jsp");
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
								<span class="widget-caption">用户根据邮箱重置密码</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal">
									<input type="hidden"   id="sid" name="sid" />
									<div class="form-group">
										<label class="col-lg-3 control-label">用户名:</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled"  id="username" name="username" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">邮箱:</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" disabled="disabled"  id="email" name="email" />
										</div>
									</div>
                        	<div class="code clearfix">
	                            <input type="text" style="display: none" name="code" id="eCode" placeholder="输入邮箱验证码" class="br fl loginput">
	                          
                        	</div>
         							<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<!-- <input class="btn btn-success" style="width: 25%;" id="save" type="button" value="发送默认密码并保存" /> -->
											 <input id="sendCodeEmail"  type="button" class="btn btn-success" onClick="sendEmail()" value="发送默认密码并保存" >&emsp;&emsp;
											<input class="btn btn-success" style="width: 25%;" id="close" type="button" value="取消" />
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
 <!-- /Page Body -->
	<script>
    </script>
</body>
</html>