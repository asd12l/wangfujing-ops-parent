var flag = "";

$(function(){
	validformAdd();
	loadLogJs();
	$("#save").click(function(){
		addSpaceFrom();
	});
});
//验证
function validformAdd() {
	return $("#addSpaceForm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		rules : {
			name : "required"
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
			icon.attr("data-original-title", error.text()).tooltip({'container' : 'form'});
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
function initPosition(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/advertisingSpace/queryPositionList",
			dataType : "json",
			async: false,
			data:{
				"_site_id_param":siteSid
			},
			success : function(response) {
				console.log(response);
				var position = $(".position");
				var result = response.list;
				spaceCount = result.length;
				position.html("");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.id + "'>"
							+ ele.name + "</option>");
					option.appendTo(position);
				}
			}
		});
	}

function loadLogJs(){
    $.ajax({
        type : "get",
        contentType : "application/x-www-form-urlencoded;charset=utf-8",
        url : __ctxPath + "/loadSystemParam/findValueFronSystemParamByKey",
        async : false,
        data : {
            "key" : "log_js"
        },
        dataType : "json",
        ajaxStart : function() {
            $("#loading-container").prop("class", "loading-container");
        },
        ajaxStop : function() {
            $("#loading-container").addClass("loading-inactive");
        },
        success : function(response) {
            if(response.success){
                var logjs_url = response.value;
                var _script=document.createElement('script');
                _script.setAttribute('charset','gbk');
                _script.setAttribute('type','text/javascript');
                _script.setAttribute('src',logjs_url);
                document.getElementsByTagName('head')[0].appendChild(_script);
            } else {
                $("#warning2Body").text(response.msg);
                $("#warning2").show();
            }
        }
    });
}
	function checkFlag(position,enabled){
		if(enabled=="false"){
			flag = true;
		}else{
			$.ajax({
				type: "post",
				async:false,
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				url: __ctxPath+"/advertisingSpace/checkSpaceEnabled",
				dataType: "json", 
				data:{
					"position":position,
					"enabled":enabled
				},
				success: function(response) {
					flag = response.obj;
				}
			});
		}
	}
	//保存数据
	function addSpaceFrom(){
		userName = getCookieValue("username");
    	LA.sysCode = '54';
		LA.log('adcertise-addSpaceFrom', '添加广告版位保存', userName,  sessionId);
		var position = $("#add_position").val();
		var enabled = $("#add_space_enabled input[name='enabled']:checked").val();
		if(validformAdd().form()){	
			$.ajax({
				type:"post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				dataType: "json",
				ajaxStart: function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop: function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive")
					},300);
				},
				url: __ctxPath + "/advertisingSpace/save",
				data: $("#addSpaceForm").serialize(),
				success: function(response) {
					if(response.success == 'true'){
						$("#addSpaceDIV").hide();
						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<strong>添加成功，返回列表页!</strong></div>");
						$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
						initPropsdict();
					}else{
						$("#addSpaceDIV").hide();
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败！</strong></div>");
						$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					}
				}
			});
		}
		
	}