function uploadImg1(__ctxPath, ip, username, password, port, path, site_name, fileElementId){
	$.ajaxFileUpload({
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		//url : __ctxPath + "/adverties/uploadImg-noMulti",

		url : __ctxPath + "cms/file/uploadImg",
		type : "post",
		async: false,
		data : {
			"ip" : ip,
			"username" : username,
			"password" : password,
			"port" : port,
			"path" : path,
			"siteName" : site_name
		},
		secureuri : false,
		fileElementId : fileElementId,
		dataType : "json",
		success : function(data) {
			if (data.success == "true") {
				$("#img_" + fileElementId.substring(3)).attr('src', data.url); 

				$("input[name='" + fileElementId.substring(3) + "']").val(data.url);
			}
		},
		error : function(data, status, e){
			console.log(data);
		}
	});
	
}

function uploadImg(__ctxPath, siteId, fileElementId){
	var adspaceIdFun = $("#adspaceId").val();
	var sizeNo="";
	
	if(adspaceIdFun==67) sizeNo = "800_420";// 通栏广告位
	if(adspaceIdFun==68) sizeNo = "190_355";// 通栏右广告位
	if(adspaceIdFun==69) sizeNo = "390_168";// 通栏下广告位
	if(adspaceIdFun==70){ // 首页热卖商品广告位
		var FunSeq = $("#adver_seq").val();
		//if(FunSeq==1) sizeNo = "380_450";
		if(FunSeq==1) sizeNo = null;
		if(FunSeq==2) sizeNo = "300_210";
		if(FunSeq==3) sizeNo = "300_210";
		if(FunSeq==4) sizeNo = "190_100";
		if(FunSeq==5) sizeNo = "190_100";
		if(FunSeq==6) sizeNo = "608_230";
		if(FunSeq==7) sizeNo = "190_230";
	}
	if(adspaceIdFun==71) sizeNo = "180_180";// 热销商品排行
	if(adspaceIdFun==80) sizeNo = "180_180";// 你可能喜欢的商品
	if(adspaceIdFun==82) sizeNo = "110_73";// toolbar广告位
	if(adspaceIdFun==85) sizeNo = "120_120";// 个人中心底部广告位
	if(adspaceIdFun==87) sizeNo = "220_220";// 买了还买了广告位
	if(adspaceIdFun==88) sizeNo = "220_220";// 看了还看了广告位
	if(adspaceIdFun==89) sizeNo = "220_220";// 同品牌推荐
	$.ajaxFileUpload({
		
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/cms/file/uploadImg-noMulti",
		type : "post",
		async: false,
		data : {
			"siteId" : siteId,
			"sizeNo": sizeNo
		},
		secureuri : false,
		fileElementId : fileElementId,
		dataType : "json",
		success : function(data) {
			if (data.success == "true") {
				$("#img_" + fileElementId.substring(3)).attr('src', data.url); 

				$("input[name='" + fileElementId.substring(3) + "']").val(data.path);
			}else{
				$("#warning2Body").text(data.message+"尺寸为:"+sizeNo.replace("_", "*"));
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		},
		error : function(data, status, e){
			console.log(data);
		}
	});
}

function uploadFlash(__ctxPath, siteId, fileElementId){
	alert(fileElementId);
	$.ajaxFileUpload({
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/cms/file/uploadFlash-noMulti",
		type : "post",
		async: false,
		data : {
			"siteId" : siteId
		},
		secureuri : false,
		fileElementId : fileElementId,
		dataType : "json",
		success : function(data) {
			if (data.success == "true") {
				$("#flash_" + fileElementId.substring(3)).val(data.url); 

				$("input[name='" + fileElementId.substring(3) + "']").val(data.path);
			}
		},
		error : function(data, status, e){
			console.log(data);
		}
	});
	
}