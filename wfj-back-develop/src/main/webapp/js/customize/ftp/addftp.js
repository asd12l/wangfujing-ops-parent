$(function(){
	validform();
	$("#save").click(function(){
		saveFrom();
	});
	$("#close").click(function(){
		$("#pageBody").load(__ctxPath+"/jsp/web/ftp/ftp_list.jsp");
	});	
});

/**
 * 测试FTP
 */
var  success ;
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
	        	}
	        	if(response.success == 'false'){
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
	/**
	 * 保存FTP
	 */
	 function saveFrom(){
		 var isTure = testFtp();
		 if(isTure){
     		if(validform().form()) {
    			$.ajax({
    		        type:"post",
    		        dataType: "json",
    		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
    		        url:__ctxPath + "/ftp/saveFtp",
    		        data: $("#theForm").serialize(),
    		        success:function(response) {
    		        	if(response.success == 'true'){
    						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
    							"<strong>添加成功，返回列表页!</strong></div>");
    			  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
    		        	}else{
    						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
    			     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
    					}
    		    	}
    			});
    		}
     		return;
		 }
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

			        	}else{
							$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong></strong></div>");
				     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
						}
			    	}
				});
			}		 
	}
	//弹出框的确定按钮
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/web/ftp/ftp_list.jsp");
	} 
	