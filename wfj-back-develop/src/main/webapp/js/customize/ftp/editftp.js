$(function(){
	    validform();
		$("#ftp_id").val(id_);
		$("#name").val(name_);
		$("#encoding").val(encoding_);
		$("#ip").val(ip_);
		$("#password").val(password_);
		$("#path").val(path_);
		$("#port").val(port_);
		$("#timeout").val(timeout_);
		$("#url").val(url_);
		$("#username").val(username_);
		if(type_==1){
			$("#isErpProp_1").attr("checked",'checked');
		}else if(type_==2){
			$("#isErpProp_2").attr("checked",'checked');
		}		
		$("#save").click(function(){
			saveFrom();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/web/ftp/ftp_list.jsp");
		});
	});

var success;
function testFtp(){
	validform2();
	var ip=$("#ip").val();
	var username=$("#username").val();
	var port=$("#port").val();
	var password=$("#password").val();
	 if(validform2().form()){
		$.ajax({
	        type:"post",
	        dataType: "json",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/ftp/testFtp",
	        data: {
	        	"ip" : ip,
	        	"username" : username,
	        	"password" : password,
	        	"port" : port
	        },
	        success:function(response) {
	        	if(response.success == 'true'){
	        		alert("测试连接成功!");
	        		success = true;
	        	}if(response.success == 'false'){
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
		     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		     			success = false;
	        	}
	    	}
		});
		if(success){
			return true;
		}else{
			return false;
		}
	}
}
	//修改FTP
	 function saveFrom(){
		 validform();
		 var isTure = testFtp();
		 if(isTure){
     		if(validform().form()) {
    			$.ajax({
    		        type:"post",
    		        dataType: "json",
    		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
    		        url:__ctxPath + "/ftp/modifyFtp",
    		        data: $("#theForm").serialize(),
    		        success:function(response) {
    		        	if(response.success == 'true'){
    						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
    							"<strong>修改成功，返回列表页!</strong></div>");
    			  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
    		        	}if(response.success=='false'){
    						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
    			     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
    					}
    		    	}
    			});
    		}
		 }
	}
	//弹出框的确定按钮
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/web/ftp/ftp_list.jsp");
	} 