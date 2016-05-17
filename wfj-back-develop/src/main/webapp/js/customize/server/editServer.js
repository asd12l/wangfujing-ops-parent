$(function() {
	validform();
	getSites();
	$("#server_id").val(id_);
	$("#name").val(name_);
	$("#siteId").val(siteId_);
	$("#encoding").val(encoding_);
	$("#ip").val(ip_);
	$("#port").val(port_);
	$("#url").val(url_);
	if (type_ == 0) {
		$("#isErpProp_0").attr("checked", 'checked');
		$("#password").val(password_);
		$("#username").val(username_);
		$("#path").val(path_);
		$("label[ref='label_path']").text("远程目录");
	} else if (type_ == 1) {
		$("#isErpProp_1").attr("checked", 'checked');
		$("div[ref='serveruser']").hide();
		$("div[ref='serverpwd']").hide();
		$("#username").rules("remove");
		$("#password").rules("remove");
		$("label[ref='label_path']").text("ContextPath");
	} else {
		$("#isErpProp_2").attr("checked", 'checked');
	}
	$("#save").click(function() {
		saveFrom();
	});
	$("#close").click(function() {
		$("#pageBody").load(__ctxPath + "/jsp/web/server/server_list.jsp");
	});

});

function set() {
	var val_type = $('#webType input[name="type"]:checked ').val();
	$("input").closest('.form-group').removeClass('has-error');
	$('i').removeClass('fa-warning');
	if (val_type == 1) {
	/*	$("#path").val("/");*/
		$("div[ref='serveruser']").hide();
		$("div[ref='serverpwd']").hide();
		$("#username").rules("remove");
		$("#password").rules("remove");
		$("label[ref='label_path']").text("ContextPath");

	} else {
		$(".path").show();
		$("div[ref='serveruser']").show();
		$("div[ref='serverpwd']").show();
		$("#username").rules("add", {
			required : true
		});
		$("#password").rules("add", {
			required : true
		});
		$("label[ref='label_path']").text("远程目录");
	}
}

function validform() {
	return $("#theForm").validate(
			{
				onfocusout : function(element) {
					$(element).valid();
				},
				rules : {
					name : "required",
					ip : {
						required : true,
						IpVal : true
					},
					port : {
						required : true,
						PortVal : true
					},
					username : "required",
					password : "required",
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
function getSites() {
	$.ajax({
		type : "post",
		async : false,
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/site/getSiteList",
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
			var sitePath = $("#siteId");
			var result = response.list;
			for (var i = 0; i < result.length; i++) {
				var ele = result[i];
				var option = $("<option value='" + ele.id + "'>" + ele.name
						+ "</option>");
				option.appendTo(sitePath);
			}
		}
	});
}

/***
 * 修改
 */
function saveFrom() {

	if (validform().form()) {
		$.ajax({
			type : "post",
			dataType : "json",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/webserver/modifyWebServer",
			data : $("#theForm").serialize(),
			success : function(response) {
				if (response.success == 'true') {
					$("#modal-body-success")
							.html(
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
									"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>"+response.message+"</strong></div>");
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
// 弹出框的确定按钮
function successBtn() {
	$("#modal-success").attr({
		"style" : "display:none;",
		"aria-hidden" : "true",
		"class" : "modal modal-message modal-success fade"
	});
	$("#pageBody").load(__ctxPath + "/jsp/web/server/server_list.jsp");
}