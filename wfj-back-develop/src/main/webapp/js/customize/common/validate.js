/**
 * 公共JS验证
 */
$(document).ready(function(e) {
	//站点名
	jQuery.validator.addMethod("SiteNameVal", function(value, element) {
		var flag = "";
		$.ajax({
	        type:"post",
	        dataType: "json",
	        async: false,
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/validate/validate_site_name",
	        data:{
	        	"siteName":value
	        },
	        success:function(response) {
	        	if(response.success == 'true'){
	        		flag = response.list;
	        	}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>校验失败,服务器出错！</strong></div>");
		     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
	    	}
		});
		return flag;
	}, $.validator.format("站点名重复"));
	
	//域名
	jQuery.validator.addMethod("DomainVal", function(value, element) {
		var flag = "";
		$.ajax({
	        type:"post",
	        dataType: "json",
	        async: false,
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/validate/validate_site_name",
	        data:{
	        	"domain":value
	        },
	        success:function(response) {
	        	if(response.success == 'true'){
	        		flag = response.list;
	        	}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>校验失败,服务器出错！</strong></div>");
		     	  	$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
	    	}
		});
		return flag;
	}, $.validator.format("域名重复"));
	
	//域名
	jQuery.validator.addMethod("DomainNameVal", function(value, element) {
		return this.optional(element) || /^(http(s)?:\/\/)?(www\.)?([a-zA-Z0-9]+\.)?[\w-]+\.\w{2,4}(\/)?$/.test(value);
	}, $.validator.format("请输入正确的域名"));
	
	//端口号
	jQuery.validator.addMethod("PortVal", function(value, element) {
		return this.optional(element) || /^[1-9][0-9]{0,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]{1}|6553[0-5]$/.test(value);
	}, $.validator.format("请输入正确的端口号"));
	
	//ip
	jQuery.validator.addMethod("IpVal", function(value, element) {
		return this.optional(element) || /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/.test(value);
	}, $.validator.format("请输入正确的ip"));
	
	/**
	 * path(ftp远程目录)
	 */
	jQuery.validator.addMethod("PathVal", function(value, element) {
		var flag = "";
		if(value.length > 1){
			flag=true;
		}else{
			flag=false;
		}
		if(flag){
			flag=this.optional(element) || /^\/.*$/.test(value);
		}else{
			flag=false;
		}
		return flag;
	}, $.validator.format("请输入以“/”开头的正确的路径"));
	
	/**
	 * 链接
	 */
	jQuery.validator.addMethod("LinkVal", function(value, element) {
		return this.optional(element) || /^(http(s)?:\/\/).*$/.test(value.trim());
	}, $.validator.format("请输入以“http或https”开头的正确链接名"));
	// 判断中英字符 
    jQuery.validator.addMethod("isChineseOrEnglish", function(value, element) {       
         return this.optional(element) || /^[\u0391-\uFFE5\A-Za-z]+$/.test(value);       
    }, "只能包含中文和英文字符。"); 
	// 判断中文字符 
    jQuery.validator.addMethod("isChinese", function(value, element) {       
         return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);       
    }, "只能包含中文字符。"); 
	/**
	 * 英文字母
	 */
	jQuery.validator.addMethod("english", function(value, element) {
		if(value.trim()=='') return true;
		return /^[A-Za-z\-\_\.\ ]+$/i.test(value.trim());
	}, $.validator.format("请输入英文"));
	/**
	 * 判断引导链接标题重复
	 */
	jQuery.validator.addMethod("checkLinkTitle", function(value, element) {
		var sid = "";
		$("input[type='checkbox']:checked").each(function(i, team) {
			sid = $(this).val();
		});
		var flag = true;
		var $tds = $("td[id^='linkMainTitle_']");
		var Cname = $("#linkMainTitle_"+sid).text().trim();
		//用获取到的name和循环出的name和input上的name做比较 如果都一样那么就可以添加
		for(i=0;i<$tds.length;i++){
			var name = $tds.eq(i).text();
			if(Cname==name && Cname==value.trim()){
				falg = true;
				break;
			}
			if(name==value.trim()){
				flag=false;
			}
		}
		return flag;
	}, $.validator.format("标题重复"));
	//模板路径验证
	jQuery.validator.addMethod("tplath", function(value, element) {
		if(value.trim()=='') return false;
		return true;
	}, $.validator.format(""));
	// 模板验证
	jQuery.validator.addMethod("tplContent", function(value, element) {
		if(value.trim()=='') return false;
		return true;
	}, $.validator.format(""));
	// 标题图验证
	jQuery.validator.addMethod("titleImg1", function(value, element) {
		if($("#input_img1").val().trim()=='') return false;
		return true;
	}, $.validator.format("请上传标题图"));
});