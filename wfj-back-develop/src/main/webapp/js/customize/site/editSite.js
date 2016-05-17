var domain="";
var resPath="";
$(function(){
	$("#resource_path_").change(function(){
		resPath=$("#resource_path_").val();
	});
	validform();
	$("#site_path_").val($("#domain_").val());
		$.ajax({
			async: false,
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/ftp/getftpList",
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container")
							.addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				for(i=0;i<response.tplList.length;i++){
					var opt=$('<option id='+response.tplList[i].path+' value='+response.tplList[i].id+'>'+response.tplList[i].name+'</option>');
					$("#tpl_path_").append(opt);
				}
				
				for(i=0;i<response.resList.length;i++){
					var opt=$('<option id='+response.resList[i].path+' value='+response.resList[i].id+'>'+response.resList[i].name+'</option>');
					$("#resource_path_").append(opt);
				}
			}
		});
		//获取渠道code
		$.ajax({
			async: false,
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/site/getChannelCode",
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container")
							.addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				for(i=0;i<response.data.length;i++){
					var opt=$('<option id='+response.data[i].channelCode+' value='+response.data[i].channelCode+'>'+response.data[i].channelName+'</option>');
					$("#channelCode_").append(opt);
				}
			}
		});
		
		$("#id_").val(id_);
		$("#name_").val(name_);
		$("#domain_").val(domain_);
		$("#site_path_").val(path_);
		$("#resource_path_").val(res_path_);
		$("#tpl_path_").val(tpl_path_);
		$("#dynamicSuffix_").val(dynamicSuffix_);
		$("#staticSuffix_").val(staticSuffix_);
		$("#channelCode_").val(channelCode_);
		$("#channelName_").val(channelName_);
		domain = $("#domain_").val();
		$("#site_path_").val($("#domain_").val());
		var resPath=$('#resource_path_ option:selected').attr("id");
		$("#resDomain").val(resPath+"/"+domain);
		var tplPath=$('#tpl_path_ option:selected').attr("id");
		$("#tplDomain").val(tplPath+"/"+domain);
		
		$("#save").click(function(){
			saveFrom();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/web/site/site_list.jsp");
		});
	});

//获取域名
function getDomain(){
	domain = $("#domain_").val();
}
$("#domain_").keyup(function(){
	$("#site_path_").val($("#domain_").val());
});
//获取ftp资源路径
function getResPath(){
	var resPath=$('#resource_path_ option:selected').attr("id");
	$("#resDomain").val(resPath+"/"+domain);
}
//获取ftp模板路径
function getTplPath(){
	var tplPath=$('#tpl_path_ option:selected').attr("id");
	$("#tplDomain").val(tplPath+"/"+domain);
}

	/**
	 * 修改站点
	 */
	 function saveFrom(){
		 $("#channelName_").val($("#channelCode_").find("option:selected").text());
		 if(validform().form()) {
			$.ajax({
		        type:"post",
		        dataType: "json",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        url:__ctxPath + "/site/modifySite",
		        data: $("#theForm").serialize(),
		        success:function(response) {
		        	if(response.success == 'true'){
						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
							"<strong>修改成功，返回列表页!</strong></div>");
			  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
		        	}else{
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
			     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					}
		    	}
			});
		}
	}
	//弹出框的确定按钮
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/web/site/site_list.jsp");
	} 