var cart_flag = true;
var editor = "";
var inputValue = "";
var inputFlag = 0;
$(function() {

	$("#save").click(function() {
		saveFrom();
	});
	$("#close").click(function() {
		$("#pageBody").load(__ctxPath + "/jsp/advertise/list.jsp");
	});

	editor = CKEDITOR.replace('text_title',
			{
				toolbar : [
						{
							name : 'document',
							items : [ 'Source', 'NewPage', 'Preview' ]
						},
						// { name: 'basicstyles', items : [
						// 'Bold','Italic','Strike','-','RemoveFormat' ] },
						{
							name : 'clipboard',
							items : [ 'Cut', 'Copy', 'Paste', 'PasteText',
									'PasteFromWord', '-', 'Undo', 'Redo' ]
						},
						{
							name : 'editing',
							items : [ 'Find', 'Replace', '-', 'SelectAll', '-',
									'Scayt' ]
						},
						// '/',
						// { name: 'styles', items : [ 'Styles','Format' ] },
						// { name: 'paragraph', items : [
						// 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote'
						// ] },
						// { name: 'insert', items :[
						// 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'
						// ,'Iframe' ] },
						{
							name : 'links',
							items : [ 'Link', 'Unlink', 'Anchor' ]
						}, {
							name : 'tools',
							items : [ 'Maximize', '-', 'About' ]
						} ]
			});

});

var attr_all = [ "image", "flash", "text", "code" ];
function attrChange(value) {
	for ( var attr in attr_all) {
		if (attr_all[attr] == value) {
			showAttr(attr_all[attr]);
		} else {
			hideAttr(attr_all[attr]);
		}
	}

}
function radioChecked() {
	var value = $("input[name=category]:checked").val();
	if (value == "image") {
		inputValue = $("#input_img1").val();
	} else if (value == "flash") {
		inputValue = $("#input_flash1").val();
	} else if (value == "text") {
		inputValue = editor.document.getBody().getText();
	} else if (value == "code") {
		inputValue = $("#attr_code_text").val();
	}
	if (inputValue == '') {
		inputFlag = 0;
		alert("上传的广告内容不能为空！");
	} else {
		inputFlag = 1;
	}
}
function hideAttr(value) {
	var name = "#attr_" + value;
	$(name).hide();
	$(name + " input," + name + " select," + name + " textarea").each(
			function() {
				$(this).attr("disabled", "disabled");
			});
}
function showAttr(value) {
	var name = "#attr_" + value;
	$("#attr_" + value).show();
	$(name + " input," + name + " select," + name + " textarea").each(
			function() {
				$(this).removeAttr("disabled");
			});
}
function checkCart() {
	var spaceId = $("#adspaceId").val();
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/adverties/checkCart",
		dataType : "json",
		data : {
			"spaceId" : spaceId
		},
		success : function(response) {
			if (response.success == 'true') {
				cart_flag = response.list;
				if (cart_flag) {
					$(".cart_flag").attr("disabled", "true");
					$("#category_3").click();
				} else {
					$(".cart_flag").removeAttr("disabled");
					$("#category_0").click();
				}
			}
		}
	});
}
// 验证
function validform() {
	return $("#theForm").validate(
			{
				onchange : function(element) {
					$(element).valid();
				},
				rules : {
					name : "required",
					adspaceId : "required",
					seq : {
						required : true,
						digits : true
					},
					startTime : {
						required : true,
					},
					endTime : {
						required : true,
						TimeVal : true
					}
				},
				highlight : function(element) { // hightlight error inputs
					$(element).closest('.form-group')
							.removeClass("has-success").addClass('has-error');
				},
				errorPlacement : function(error, element) { // render error
					// placement for
					// each input type
					var icon = $(element).parent('.input-icon').children('i');
					icon.removeClass('fa-check').addClass("fa-warning");
					icon.attr("data-original-title", error.text()).tooltip({
						'container' : 'form'
					});
				},
				success : function(label, element) {
					var icon = $(element).parent('.input-icon').children('i');
					$(element).closest('.form-group').removeClass('has-error')
							.addClass('has-success'); // set success class to
					// the control group
					icon.removeClass("fa-warning").addClass("fa-check");
				}
			});
}
// 时间对比
jQuery.validator.addMethod("TimeVal", function(value, element) {
	var startTime = $("#startTime").val();
	var endTime = $("#endTime").val();
	startTime = startTime.replace(new RegExp("-", "gm"), "/");
	var startTimeHaoMiao = (new Date(startTime)).getTime();
	endTime = endTime.replace(new RegExp("-", "gm"), "/");
	var endTimeHaoMiao = (new Date(endTime)).getTime();
	return (startTimeHaoMiao <= endTimeHaoMiao) ? true : false;
}, $.validator.format("结束时间不能小于开始时间！"));

$(function() {
	validform();
	$("#adspaceId").change(function() {
		checkCart();
	});
	// 查询版位
	var adspaceId = $("#adspaceId");
	$
			.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/adverties/findAdspace",
				dataType : "json",
				data : {
					"_site_id_param" : _site_id_param
				},
				success : function(response) {
					var result = response.list;
					adspaceId.html("");
					for (var i = 0; i < result.length; i++) {
						var ele = result[i];
						if (_spaceId == ele.id) {
							var option = $("<option type='" + ele.source
									+ "' value='" + ele.id
									+ "' selected='selected'>" + ele.name
									+ "</option>");
							option.appendTo(adspaceId);
						} else {
							var option = $("<option type='" + ele.source
									+ "' value='" + ele.id + "'>" + ele.name
									+ "</option>");
							option.appendTo(adspaceId);
						}
					}
					checkCart();
					return;
				},
				error : function() {
					$("#model-body-warning")
							.html(
									"<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
					$("#modal-warning").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-error"
					});
				}
			});

});
function CKupdate() {
	for (instance in CKEDITOR.instances)
		CKEDITOR.instances[instance].updateElement();
}

function checkFlag(spaceId, enabled) {
	if (enabled == "false") {
		flag = true;
	} else {
		$.ajax({
			type : "post",
			async : false,
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/adverties/checkEnabled",
			dataType : "json",
			data : {
				"spaceId" : spaceId,
				"enabled" : enabled
			},
			success : function(response) {
				flag = response.obj;
			}
		});
	}
}

// 保存数据
function saveFrom() {
	radioChecked();
	if (inputFlag == 1) {
		var spaceId = $("#adspaceId").val();
		var enabled = $("input[name='enabled']:checked").val();
		//checkFlag(spaceId, enabled);
		/*if (flag) {*/
			if (validform().form()) {
				var title = $("#text_title").val(); /* 不能用.text()或.html() */
				var val = editor.getData();
				var content = editor.document.getBody().getText();
				$("#attr_text_title").val(content);
				if ($("#adver_name").val() == "") {
					$("#warning2Body").text("导航必填项缺失!");
				    $("#warning2").attr("style", "z-index:9999");
				    $("#warning2").show();
				} else {
					$.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						dataType : "json",
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							// 隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						url : __ctxPath + "/adverties/save",
						data : $("#theForm").serialize(),
						success : function(response) {
							if (response.success == 'true') {
								$("#addAdvertiseDIV").hide();
								$("#modal-body-success").html(
										"<div class='alert alert-success fade in'>"
												+ "<strong>添加成功，返回列表页!</strong></div>");
								$("#modal-success").attr({
									"style" : "display:block;",
									"aria-hidden" : "false",
									"class" : "modal modal-message modal-success"
								});
							} else {
								$("#warning2Body").text(response.message);
							    $("#warning2").attr("style", "z-index:9999");
							    $("#warning2").show();
							}
						}
					});
				}
			}
/*		} else {
			$("#warning2Body").text("该版位有广告启用,请检查后再试！");
		    $("#warning2").attr("style", "z-index:9999");
		    $("#warning2").show();
		}*/
	}
}

// 图片上传
function upLoadImg(fileElementId) {
	var fileElement = fileElementId.substring(3);
	uploadImg(__ctxPath, _site_id_param, fileElementId);
	
	return;
	$.ajax({
		type : "post",
		url : __ctxPath + "/site/getResourceFtp",
		dataType : "json",
		data : {
			"_site_id_param" : _site_id_param
		},
		success : function(response) {
			var ip = response.ip;
			var username = response.username;
			var password = response.password;
			var port = response.port;
			var path = response.path;
			$("#loading-container").attr('class','loading-container');
			$.ajaxFileUpload({
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/adverties/uploadImg-noMulti",
				type : "post",
				data : {
					"ip" : ip,
					"username" : username,
					"password" : password,
					"port" : port,
					"path" : path,
					"siteName" : site_name
				},
				secureuri : false,
				fileElementId : 'image_name' + param,
				dataType : "json",
				success : function(data) {
					var str = "";
					if (data.success == "true") {
						str = "<img src='"
								+ data.url
								+ "' height='60px' width='60px' />";
						$("#uploadImgPath1").val(data.url);
						$("#input_img" + param).val(data.data);
					} else {
						str = "<span class='img_error'>"
								+ data.data + "</span>";
						$("#input_img" + param).val("");
					}
					$("#msg" + param).html(str);
					$("#msg" + param).removeClass('hide');
					$("#loading-container").attr('class','loading-container loading-inactive');
				},
				error : function(data, status, e)// 服务器响应失败处理函数
				{
					$("#loading-container").attr('class','loading-container loading-inactive');
					$("#msg" + param)
							.html(
									"<span class='img_error'>系统错误，上传失败</span>");
					$("#msg" + param).removeClass('hide');
					$("#input_img" + param).val("");
				}
			});
		}
	});
}

// 视频上传
function upLoadFlash(fileElementId) {

	var fileElement = fileElementId.substring(3);
	uploadFlash(__ctxPath, _site_id_param, fileElementId);
	
	return;
	$.ajax({
		type : "post",
		url : __ctxPath + "/site/getResourceFtp",
		dataType : "json",
		data : {
			"_site_id_param" : _site_id_param
		},
		success : function(response) {
			var ip = response.ip;
			var username = response.username;
			var password = response.password;
			var port = response.port;
			var path = response.path;
			$("#loading-container").attr('class','loading-container');
			$.ajaxFileUpload({
				url : __ctxPath + "/adverties/uploadFlash-noMulti",
				type : "POST",
				secureuri : true,
				fileElementId : 'flashFile' + param,
				dataType : "json",
				data : {
					"ip" : ip,
					"username" : username,
					"password" : password,
					"port" : port,
					"path" : path,
					"siteName" : site_name
				},
				success : function(data) {
					var str = "";
					if (data.success == "true") {
						str = "<span>" + data.msg + "</span>";
						$("#flashPath1").val(data.url);
						$("#input_flash" + param).val(data.data);
					} else {
						str = "<span class='flash_error'>" + data.data
								+ "</span>";
						$("#input_flash" + param).val("");
					}
					$("#msgf" + param).html(str);
					$("#msgf" + param).removeClass('hide');
					$("#loading-container").attr('class','loading-container loading-inactive');
				},
				error : function(data, status, e)// 服务器响应失败处理函数
				{
					$("#loading-container").attr('class','loading-container loading-inactive');
					$("#msgf" + param).html(
							"<span class='img_error'>系统错误，上传失败</span>");
					$("#msgf" + param).removeClass('hide');
					$("#input_flash" + param).val("");
				}
			});
		}
	});
}

// 弹出框的确定按钮
function successBtn() {
	$("#modal-success").attr({
		"style" : "display:none;",
		"aria-hidden" : "true",
		"class" : "modal modal-message modal-success fade"
	});
	$("#pageBody").load(__ctxPath + "/jsp/advertise/list.jsp");
}