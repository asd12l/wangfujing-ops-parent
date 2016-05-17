var localPath = "";

$(function() {

	$("#save").click(function() {
		saveFrom();
	});
	$("#close").click(
			function() {
				$("#pageBody").load(
						__ctxPath + "/jsp/web/stylelist/stylelistView.jsp");
			});
});
function loadPath() {
	$.ajax({
		type : "post",
		dataType : "json",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/stylelist/queryStyleListPath",
		data : {
			"siteId" : siteSid
		},
		ajaxStart : function() {
			$("#loading-container").attr("class", "loading-container");
		},
		ajaxStop : function() {
			// 隐藏加载提示
			setTimeout(function() {
				$("#loading-container").addClass("loading-inactive")
			}, 300);
		},
		success : function(response) {
			if (response != undefined) {
				if (response.success == 'true') {
					localPath = response.path + "/" + response.siteName
							+ "/style_list";
					$("#desFile").val(localPath);
				}

			}

		}
	});
}

// 图片上传
function upLoadImg(param) {
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
					$
							.ajaxFileUpload({
								contentType : "application/x-www-form-urlencoded;charset=utf-8",
								url : __ctxPath
										+ "/stylelist/uploadImg-noMulti",
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
												+ data.url+data.path
												+ "' height='60px' width='60px' />";
										$("#input_img" + param).val(data.data);
										$("#image_url").val(data.url);
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

function initTree() {
	stylelistPagination = $("#stylelistPagination").myPagination(
			{
				panel : {
					tipInfo_on : true,
					tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
					tipInfo_css : {
						width : '25px',
						height : "20px",
						border : "2px solid #f0f0f0",
						padding : "0 0 0 5px",
						margin : "0 5px 0 5px",
						color : "#48b9ef"
					}
				},
				debug : false,
				ajax : {
					type : "post",
					on : true,
					contentType : "application/json;charset=utf-8",
					url : __ctxPath
							+ "/stylelist/queryStyleList?_site_id_param="
							+ siteSid,
					dataType : 'json',
					ajaxStart : function() {
						$(".loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						// 隐藏加载提示
						$(".loading-container").addClass("loading-inactive");
					},
					callback : function(data) {
						$("#stylelist_tab tbody").setTemplateElement(
								"stylelist-list").processTemplate(data);
					}
				}
			});
}

// 添加、上传楼层样式
function addStylelist() {
	$("#msg1 img").remove();
	$("#msg span").remove();
	loadPath();
	$("#uploadDir").show();
}

/**
 * 上传楼层样式
 * 
 * @param obj
 */
function uploadZipFile(obj) {
	var file = $(".clear_input").val();
	if (file == undefined || file == "") {
		str = "<span style='color:#F00' class='img_error'>请选择上传的楼层样式文件</span>";
		$("#msg").html(str);
		$("#msg").removeClass('hide');
		return;
	}
	if (file.substr(file.indexOf(".")) != '.html') {
		str = "<span style='color:#F00' class='img_error'>请选择后缀为.html的文件</span>";
		$("#msg").html(str);
		$("#msg").removeClass('hide');
		return;
	}
	var img = $("#image_name1").val();
	if (img == undefined || img == "") {
		str = "<span style='color:#F00' class='img_error'>请上传可预览的图片</span>";
		$("#msg1").html(str);
		$("#msg1").removeClass('hide');
		return;
	}
	if($("[name='desc']").val() == undefined || $("[name='desc']").val() == ""){
		str = "<span style='color:#F00' class='img_error'>请输入楼层样式描述</span>";
		$("#descMessage").html(str);
		$("#descMessage").removeClass('hide');
		return;
		
	}
	if (!window.FormData) {
		alert('your brower is too old');
		return;
	}
	var formData = new FormData($(".uploadZipForm")[0]);
	formData.append("time", new Date().getTime());
	$.ajax({
		type : "post",
		url : __ctxPath + "/site/getTplFtp",
		dataType : "json",
		data : {
			"_site_id_param" : siteSid
		},
		success : function(response) {
			formData.append("ip", response.ip);
			formData.append("username", response.username);
			formData.append("password", response.password);
			formData.append("path", response.path);
			formData.append("localPath", localPath);
			formData.append("siteId", siteSid);
			$.ajax({
				type : "post",
				url : __ctxPath + "/stylelist/upload",
				data : formData,
				cache : false,
				processData : false,
				contentType : false,
				ajaxStart : function() {
					$("#loading-container").attr("class", "loading-container");
				},
				ajaxStop : function() {
					// 隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive")
					}, 300);
				},
				success : function(response) {
					var dataset = $.parseJSON(response);
					if (dataset.success) {
						$("#uploadDir").hide();
						initTree();
						clearInput();
					} else {
						str = "<span style='color:#F00' class='img_error'>"
								+ dataset.message + "</span>";
						$("#msg").html(str);
						$("#msg").removeClass('hide');
					}
				}
			});
		}
	});
}

// 保存数据
function saveFrom() {
	var path = $("#select_path").val();
	var source = $("#tpl_edit").val();
	$
			.ajax({
				type : "post",
				dataType : "json",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/template/saveTpl",
				data : {
					"path" : path,
					"source" : source
				},
				success : function(response) {
					if (response.success == 'true') {
						$("#modal-body-success").html(
								"<div class='alert alert-success fade in'>"
										+ "<strong>修改成功，返回列表页!</strong></div>");
						$("#modal-success").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
					} else {
						$("#model-body-warning")
								.html(
										"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改失败！</strong></div>");
						$("#modal-warning").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-warning"
						});
					}
				}
			});
}

function resourceQuery(data) {
	if (data != '') {
		$("#cid").val(data);
	} else {
		$("#cid").val(0);
	}
	var params = $("#category_form").serialize();
	params = decodeURI(params);
	resourcePagination.onLoad(params);
}

// 加载模板文件
function initFileEdit(path, name) {
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/template/loadTpl",
		dataType : "json",
		data : {
			"path" : path,
			"name" : name
		},
		ajaxStart : function() {
			$("#loading-container").attr("class", "loading-container");
		},
		ajaxStop : function() {
			// 隐藏加载提示
			setTimeout(function() {
				$("#loading-container").addClass("loading-inactive")
			}, 300);
		},
		success : function(response) {
			if (response.success == "true") {
				$("#tpl_edit").text(response.source);
			}
		}
	});
}

// 特殊字符转换
function escapeJquery(srcString) {
	// 转义之后的结果
	var escapseResult = srcString;

	// javascript正则表达式中的特殊字符
	var jsSpecialChars = [ "\\", "^", "$", "*", "?", ".", "+", "(", ")", "[",
			"]", "|", "{", "}" ];

	// jquery中的特殊字符,不是正则表达式中的特殊字符
	var jquerySpecialChars = [ "~", "`", "@", "#", "%", "&", "=", "'", "\"",
			":", ";", "<", ">", ",", "/" ];

	for ( var i = 0; i < jsSpecialChars.length; i++) {
		escapseResult = escapseResult.replace(new RegExp("\\"
				+ jsSpecialChars[i], "g"), "\\" + jsSpecialChars[i]);
	}

	for ( var i = 0; i < jquerySpecialChars.length; i++) {
		escapseResult = escapseResult.replace(new RegExp(jquerySpecialChars[i],
				"g"), "\\" + jquerySpecialChars[i]);
	}

	return escapseResult;
}
// 重命名
function rename(obj) {
	var name = $(obj).attr("data");
	var opath = $("#path_" + escapeJquery(name)).val();
	$("#renameDIV").show();
	$("#path").val(opath);
	$("#oldName").val(name);
}

function renameForm() {
	if ($("#newName").val() == "") {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>必填缺失!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
	} else {
		$
				.ajax({
					type : "post",
					dataType : "json",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/template/modifyFileName",
					data : $("#renameForm").serialize(),
					success : function(response) {
						if (response.success == "true") {
							$("#renameDIV").hide();
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<i class='fa-fw fa fa-times'></i><strong>修改成功!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							$("#pageBody")
									.load(
											__ctxPath
													+ "/jsp/web/stylelist/stylelistView.jsp");
						} else {
							$("#renameDIV").hide();
							$("#model-body-warning")
									.html(
											"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改失败！</strong></div>");
							$("#modal-warning").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-warning"
							});
						}
					}
				});
	}
}
// 图片预览
function view(obj) {

	$("#showTplViewDIV").show();
	var url = $(obj).attr("data");
	// $.ajax({
	// type:"post",
	// dataType: "json",
	// contentType: "application/x-www-form-urlencoded;charset=utf-8",
	// url:__ctxPath + "/template/previewImg",
	// data:{
	// "name":filename,
	// "_site_id_param":siteSid
	// },
	// success:function(response) {
	// str = "<img src='"+response.src+"' height='' width='' />";
	// $(".show_body_1").html(str);
	// // window.open(response.src);
	// }
	// });
	str = "<img src='" + url + "' height='' width='900px' />";
	$(".show_body_1").html(str);
}

// 批量删除文件
function delFiles() {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var divSid = $(this).val();
		checkboxArray.push(divSid);
	});
	if (checkboxArray.length == 0) {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要删除的列!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
		return false;
	}
	for (i = 0; i < checkboxArray.length; i++) {
		names += checkboxArray[i];
		paths += $("#path_" + checkboxArray[i]).val();
		var type = $("#type_" + checkboxArray[i]).val();
		var hasContent = $("#hasContent_" + checkboxArray[i]).val();
		if (type == "true" && hasContent == "true") {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>该文件夹不为空,不能删除!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
	}
	bootbox.setDefaults("locale", "zh_CN");
	bootbox
			.confirm(
					"确定删除吗？",
					function(r) {
						if (r) {
							$
									.ajax({
										type : "post",
										contentType : "application/x-www-form-urlencoded;charset=utf-8",
										url : __ctxPath + "/template/delFiles",
										dataType : "json",
										data : {
											"path" : names,
											"name" : paths
										},
										ajaxStart : function() {
											$("#loading-container").attr(
													"class",
													"loading-container");
										},
										ajaxStop : function() {
											// 隐藏加载提示
											setTimeout(
													function() {
														$("#loading-container")
																.addClass(
																		"loading-inactive")
													}, 300);
										},
										success : function(response) {
											if (response.success == "true") {
												$("#modal-body-success")
														.html(
																"<div class='alert alert-success fade in'>"
																		+ "<strong>删除成功，返回列表页!</strong></div>");
												$("#modal-success")
														.attr(
																{
																	"style" : "display:block;",
																	"aria-hidden" : "false",
																	"class" : "modal modal-message modal-success"
																});
											} else {
												$("#model-body-warning")
														.html(
																"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
												$("#modal-warning")
														.attr(
																{
																	"style" : "display:block;",
																	"aria-hidden" : "false",
																	"class" : "modal modal-message modal-warning"
																});
											}
											return;
										}
									});
						}
					});
}

// 删除文件
function delFile(obj) {
	var filename = $(obj).attr("data");
	var filepath = $(obj).attr("id");
	var type = $("#type_" + name).val();
	var hasContent = $("#hasContent_" + name).val();
	if (type == "true" && hasContent == "true") {
		$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>该文件夹不为空,不能删除!</strong></div>");
		$("#modal-warning").attr({
			"style" : "display:block;",
			"aria-hidden" : "false",
			"class" : "modal modal-message modal-warning"
		});
		return false;
	}
	bootbox.setDefaults("locale", "zh_CN");
	bootbox
			.confirm(
					"确定删除吗？",
					function(r) {
						if (r) {
							$
									.ajax({
										type : "post",
										contentType : "application/x-www-form-urlencoded;charset=utf-8",
										url : __ctxPath + "/template/delFile",
										dataType : "json",
										data : {
											"path" : filepath,
											"name" : filename
										},
										ajaxStart : function() {
											$("#loading-container").attr(
													"class",
													"loading-container");
										},
										ajaxStop : function() {
											// 隐藏加载提示
											setTimeout(
													function() {
														$("#loading-container")
																.addClass(
																		"loading-inactive")
													}, 300);
										},
										success : function(response) {
											if (response.success == "true") {
												$("#modal-body-success")
														.html(
																"<div class='alert alert-success fade in'>"
																		+ "<strong>删除成功，返回列表页!</strong></div>");
												$("#modal-success")
														.attr(
																{
																	"style" : "display:block;",
																	"aria-hidden" : "false",
																	"class" : "modal modal-message modal-success"
																});
											} else {
												$("#model-body-warning")
														.html(
																"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
												$("#modal-warning")
														.attr(
																{
																	"style" : "display:block;",
																	"aria-hidden" : "false",
																	"class" : "modal modal-message modal-warning"
																});
											}
											return;
										}
									});
						}
					});
}

// 同步FTP
function loadFtp() {
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/template/loadftp",
		dataType : "json",
		ajaxStart : function() {
			$("#loading-container").attr("class", "loading-container");
		},
		ajaxStop : function() {
			// 隐藏加载提示
			setTimeout(function() {
				$("#loading-container").addClass("loading-inactive")
			}, 300);
		},
		success : function(response) {
			if (response.success == "true") {
				$("#pageBody").load(
						__ctxPath + "/jsp/web/template/templateList.jsp");
			}
		}
	});
}
// FTP设置
function setting() {
	$("#pageBody").load(__ctxPath + "/jsp/web/template/ftp_setting.jsp");
}

// 创建目录
function addDir() {
	$("#createDirDIV").show();
}

// 创建新目录
function createDir() {
	var dirName = $("#dirName").val();
	if (!dirName)
		alert("请输入目录");
	var path = rcNodeId;
	$.ajax({
		type : "post",
		url : __ctxPath + "/template/createdir?dirName=" + dirName + "&path="
				+ path,
		dataType : "json",
		success : function(response) {
			$("#createDirDIV").hide();
			$("#pageBody").load(
					__ctxPath + "/jsp/web/template/templateList.jsp");

		},
		error : function(response) {
			console.log("error");
		}
	});
}

// 上传文件
function uploadFile() {
	var formData = new FormData();
	formData.append("userfile", $("#uploadify"));
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/template/uploadify",
		dataType : "json",
		ajaxStart : function() {
			$("#loading-container").attr("class", "loading-container");
		},
		ajaxStop : function() {
			// 隐藏加载提示
			setTimeout(function() {
				$("#loading-container").addClass("loading-inactive")
			}, 300);
		},
		success : function(response) {
			if (response.success == "true") {
				$("#pageBody").load(
						__ctxPath + "/jsp/web/template/templateList.jsp");
			}
		}
	});
}
// 创建模板
function creatTpl() {
	$("#addTemplateDIV").show();

}
// 保存模板
function saveTemplate() {
	var path = rcNodeId + "/";
	var fileName = $("#file_name").val();
	var text = $("#template_edit").val();
	$
			.ajax({
				type : "post",
				dataType : "json",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/template/createFile",
				data : {
					"path" : path,
					"source" : text,
					"fileName" : fileName
				},
				success : function(response) {
					if (response.success == 'true') {
						$("#addTemplateDIV").hide();
						$("#modal-body-success").html(
								"<div class='alert alert-success fade in'>"
										+ "<strong>创建成功，返回列表页!</strong></div>");
						$("#modal-success").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
					} else {
						$("#addTemplateDIV").hide();
						$("#model-body-warning")
								.html(
										"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>创建失败！</strong></div>");
						$("#modal-warning").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-warning"
						});
					}
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
	$("#pageBody").load(__ctxPath + "/jsp/web/stylelist/stylelistView.jsp");
}