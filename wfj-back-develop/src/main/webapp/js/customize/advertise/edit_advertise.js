var inputValue = "";
var inputFlag = 0;
var editor = "";
// var flag = "";
$(function() {
	validform();
	editor = CKEDITOR.replace('attr_text_title_');

	// 查询版位
	var adspaceId = $("#adspaceId_");
	$
			.ajax({
				async : false,
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/adverties/findAdspace",
				data : {
					"_site_id_param" : siteSid
				},
				dataType : "json",
				success : function(response) {
					var result = response.list;
					adspaceId.html("<option value='-1'>全部</option>");
					for (var i = 0; i < result.length; i++) {
						var ele = result[i];
						var option = $("<option value='" + ele.id + "'>"
								+ ele.name + "</option>");
						option.appendTo(adspaceId);
					}
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

	$("#id_").val(value);
	$("#name_").val(advertiesName);
	$("#adspaceId_").val(advertiesAdspaceId);
	if (advertiesCategory == "图片") {
		$("#category_0").click();
	} else if (advertiesCategory == "视频") {
		$("#category_1").click();
	} else if (advertiesCategory == "文字") {
		$("#category_2").click();
	} else if (advertiesCategory == "代码") {
		$("#category_3").click();
	}

	// 图片上传 没用
	if (attr_image_url == undefined || attr_image_url == ""
			|| attr_image_url == "null") {
		$("#attr_image_url").val("");
	} else {
		$("#img_attr_image_url").attr('src', imgServer + attr_image_url);
		$("#attr_image_url").val(attr_image_url);
	}
	// 上层图片
	if (attr_image_uppict == undefined || attr_image_uppict == ""
			|| attr_image_uppict == "null") {
		$("#attr_image_uppict").val("");
	} else {
		$("#img_attr_image_uppict").attr('src', imgServer + attr_image_uppict);
		$("#attr_image_uppict").val(attr_image_uppict);
	}
	// 背景图片
	if (attr_image_backpict == undefined || attr_image_backpict == ""
			|| attr_image_backpict == "null") {
		$("#attr_image_backpict").val("");
	} else {
		$("#img_attr_image_backpict").attr('src',
				imgServer + attr_image_backpict);
		$("#attr_image_backpict").val(attr_image_backpict);
	}

	// 链接地址
	if (attr_image_link == undefined || attr_image_link == ""
			|| attr_image_link == "null") {
		$("#attr_image_link").val("");
	} else {
		$("#attr_image_link").val(attr_image_link);
	}
	// 描述
	if (attr_image_desc == "null") {
		$("#attr_image_desc").val("");
	} else {
		$("#attr_image_desc").val(attr_image_desc);
	}

	if (attr_image_title == "null") {
		$("#attr_image_title").val("");
	} else {
		$("#attr_image_title").val(attr_image_title);
	}
	$("#adver_seq_edit").val(seq_);

	if (attr_flash_url == undefined || attr_flash_url == ""
			|| attr_flash_url == "null") {
		$("#attr_flash_url").val("");
	} else {
		$("#flash_attr_flash_url").val(imgServer + attr_flash_url);
		$("#attr_flash_url").val(attr_flash_url);
	}
	if (attr_flash_width == "null") {
		$("#attr_flash_width_").val("");
	} else {
		$("#attr_flash_width_").val(attr_flash_width);
	}

	if (attr_text_title == "null") {
		$("#attr_text_title_").val("");
	} else {
		editor.setData(attr_text_title);
	}
	if (attr_text_link == "null") {
		$("#attr_text_link_").val("");
	} else {
		$("#attr_text_link_").val(attr_text_link);
	}
	if (attr_text_font == "null") {
		$("#attr_text_font_").val("");
	} else {
		$("#attr_text_font_").val(attr_text_font);
	}

	$("#attr_code_text").val(code);

	$("#startTime_").val(advertiesStartTime);
	$("#endTime_").val(advertiesEndTime);
	if (advertiesEnabled == "启用") {
		$("#enabled0").click();
	} else {
		$("#enabled1").click();
	}

	$("#save").click(function() {
		saveFrom();
	});
	$("#close").click(function() {
		$("#pageBody").load(__ctxPath + "/jsp/advertise/list.jsp");
	});

	// 新建频道时选定目录下的模板列表
	$(".channel_path").change(function() {
		var path = $(this).children('option:selected').val();
		initTplList(path);
	});

	$("#advertise_space_list").change(function() {
		loadAdvertiseList();
	});
	checkCart();
	// attrChange("image");
	// $("#textColor").colorPicker();

});

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

function checkCart() {
	var spaceId = $("#adspaceId_").val();
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
					// $("#category_0").click();
				}
			}
		}
	});
}

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
				if (response.success == 'true') {
					flag = response.obj;
				} else {
					alert("系统错误,请稍后重试!");
				}
			}
		});
	}
}

// 图片上传
function upLoadImg(fileElementId) {
	var fileElement = fileElementId.substring(3);
	uploadImg(__ctxPath, siteSid, fileElementId);

	return;
	$
			.ajax({
				type : "post",
				url : __ctxPath + "/site/getResourceFtp",
				dataType : "json",
				data : {
					"_site_id_param" : siteSid
				},
				success : function(response) {
					var ip = response.ip;
					var username = response.username;
					var password = response.password;
					var port = response.port;
					var path = response.path;

					uploadImg(__ctxPath, ip, username, password, port, path,
							siteName, fileElementId);
					return;
					$
							.ajaxFileUpload({
								contentType : "application/x-www-form-urlencoded;charset=utf-8",
								url : __ctxPath
										+ "/adverties/uploadImg-noMulti",
								type : "post",
								data : {
									"ip" : ip,
									"username" : username,
									"password" : password,
									"port" : port,
									"path" : path,
									"siteName" : siteName
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
								},
								error : function(data, status, e)// 服务器响应失败处理函数
								{
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
function upLoadFlash(param) {
	$("#msgf" + param).addClass('hide');
	$("#msgf" + param).html("");
	$("#input_flash" + param).val("");
	$.ajax({
		type : "post",
		url : __ctxPath + "/site/getResourceFtp",
		dataType : "json",
		data : {
			"_site_id_param" : siteSid
		},
		success : function(response) {
			var ip = response.ip;
			var username = response.username;
			var password = response.password;
			var port = response.port;
			var path = response.path;
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
					"siteName" : siteName
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
				},
				error : function(data, status, e)// 服务器响应失败处理函数
				{
					$("#msgf" + param).html(
							"<span class='img_error'>系统错误，上传失败</span>");
					$("#msgf" + param).removeClass('hide');
					$("#input_flash" + param).val("");
				}
			});
		}
	});
}

// 保存数据
function saveFrom() {
	radioChecked();
	if (inputFlag == 1) {
		var spaceId = $("#adspaceId_").val();
		var enabled = $("input[name='enabled']:checked").val();
		// checkFlag(spaceId,enabled);
		// if(flag){
		var title = $("#attr_text_title_").val(); /* 不能用.text()或.html() */
		var val = editor.getData();
		var content = editor.document.getBody().getText();
		$("#attr_text_title_edit").val(content);

		if (validform().form()) {
			$
					.ajax({
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
						url : __ctxPath + "/adverties/edit",
						data : $("#theForm").serialize(),
						success : function(response) {
							if (response.success == 'true') {
								$("#modal-body-success")
										.html(
												"<div class='alert alert-success fade in'>"
														+ "<strong>修改成功，返回列表页!</strong></div>");
								$("#modal-success")
										.attr(
												{
													"style" : "display:block;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-success"
												});
								loadAdvertiseList();
							} else {
								$("#model-body-warning")
										.html(
												"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"
														+ response.message
														+ "</strong></div>");
								$("#modal-warning")
										.attr(
												{
													"style" : "display:block;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-warning"
												});
							}
						}
					});
		}
		// }else{
		// $("#model-body-warning").html("<div class='alert alert-warning fade
		// in'><i class='fa-fw fa
		// fa-times'></i><strong>该版位有广告启用,请检查后再试！</strong></div>");
		// $("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal
		// modal-message modal-warning"});
		//			
		// }
	}
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