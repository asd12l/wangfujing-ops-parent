
// 图片上传
function uploadlinkImg(fileElementId) {
	var fileElement = fileElementId.substring(3);
	var sid = $("#site_list").val();
	uploadImg(__ctxPath, sid, fileElementId);
	return;
}

function uploadImg(__ctxPath, siteId, fileElementId){
	$.ajaxFileUpload({
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/cms/file/uploadImg-noMulti",
		type : "post",
		async: false,
		data : {
			"siteId" : siteId,
			"sizeNo": ""
		},
		secureuri : false,
		fileElementId : fileElementId,
		dataType : "json",
		success : function(data) {
			if (data.success == "true") {
				$("#msg_" + fileElementId.substring(3)).removeClass('hide');
				$("#img_" + fileElementId.substring(3)).attr('src', data.url); 
				$("#hidden_" + fileElementId.substring(3)).val(data.path);
			}
		},
		error : function(data, status, e){
			console.log(data);
		}
	});
	
}