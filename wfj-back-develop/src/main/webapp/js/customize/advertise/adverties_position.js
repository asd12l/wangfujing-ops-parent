	
	$(function(){
		__ctxPath = $("#ctxPath").val();
		validformPositionAdd();
		validformEditPosition();
		loadLogJs();
		$("#save").click(function(){
			addPositionFrom();
		});
		$("#edit_position_btn").click(function(){
			submitEditPositionForm();
		});
		
	});
	function initTree(){
		
		$("#site_id_add,#site_id_edit").val(siteSid);
		initPropsdict();
	}
	
	//验证
	function validformPositionAdd() {
		return $("#addPositionForm").validate({
			onfocusout : function(element) {
				$(element).valid();
			},
			rules : {
				name : "required",
				position : "required"
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
	function initPropsdict() {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/advertisingSpace/queryPosition",
			dataType : "json",
			ajaxStart: function() {
				$("#loading-container").attr("class","loading-container");
			},
			ajaxStop: function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				},300);
			},
			data : {
				"_site_id_param" : siteSid
			},
			success : function(response) {
				$("#propsdict_tab tbody").setTemplateElement(
				"propsdict-list").processTemplate(response);
			}
		});
		
	}
	function addPosition(){
		userName = getCookieValue("username");
    	LA.sysCode = '54';
		LA.log('adcertise-addPosition', '添加广告位置', userName,  sessionId);
		clearInput();
		$(".has-error").removeClass("has-error");
		$(".fa-warning").removeClass("fa-warning");
		$(".has-success").removeClass("has-success");
		$(".fa-check").removeClass("fa-check");
		$("#addPositionDIV").show();
	}
	function addPositionFrom() {
		if(validformPositionAdd().form()){
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/advertisingSpace/addPosition",
				dataType : "json",
				ajaxStart: function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop: function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive")
					},300);
				},
				data: $("#addPositionForm").serialize(),
				success : function(response) {
					if(response.success == 'true'){
						$("#addPositionDIV").hide();
						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<strong>添加成功，返回列表页!</strong></div>");
						$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
						initPropsdict();
					}else{
						$("#addPositionDIV").hide();
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败！</strong></div>");
						$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					}
				}
			});
		}
	}
	function editPosition() {
		userName = getCookieValue("username");
    	LA.sysCode = '54';
		LA.log('adcertise-editPosition', '修改广告位置', userName,  sessionId);
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var id = $(this).val();
			checkboxArray.push(id);
		});
		if (checkboxArray.length > 1) {
			$("#model-body-warning")
					.html(
							"<strong>只能选择一列!</strong>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		} else if (checkboxArray.length == 0) {
			$("#model-body-warning")
					.html(
							"<strong>请选取要修改的列!</strong>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		value = checkboxArray[0];
		position_name = $("#position_name" + value).text().trim();
		position=$("#position"+value).text().trim();
		source = $("#source" + value).text().trim();
		//重置格式
		$(".has-error").removeClass("has-error");
		$(".fa-warning").removeClass("fa-warning");
		$(".has-success").removeClass("has-success");
		$(".fa-check").removeClass("fa-check");
		$("#editPositionDIV").show();
		$("#position_id").val(value);
		$("#edit_name").val(position_name);
		$("#edit_position").val(position);
		$("#edit_source").val(source);
		
	}
	
	//验证
	function validformEditPosition() {
		return $("#editPositionForm").validate({
			onfocusout : function(element) {
				$(element).valid();
			},
			rules : {
				name : "required",
				position : "required"
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
		//保存数据
		function submitEditPositionForm(){
			if(validformEditPosition().form()){
	  			$.ajax({
	  				type:"post",
	  				dataType: "json",
	  				contentType: "application/x-www-form-urlencoded;charset=utf-8",
	  				url:__ctxPath + "/advertisingSpace/editPosition",
	  				data: $("#editPositionForm").serialize(),
	  				success:function(response) {
	  					if(response.success == 'true'){
	  						$("#editPositionDIV").hide();
	  						$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
	  						"<strong>修改成功，返回列表页!</strong></div>");
	  						$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	  						initPropsdict();
	  					}else{
	  						$("#editPositionDIV").hide();
	  						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改失败！</strong></div>");
	  						$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
	  					}
	  				}
	  			});
	  		}
	}
	
	function delPosition() {
		userName = getCookieValue("username");
    	LA.sysCode = '54';
		LA.log('adcertise-delPosition', '删除广告位置', userName,  sessionId);
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length == 0) {
			$("#model-body-warning")
					.html(
							"<strong>请至少选取一列!</strong>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		var value = "";
		for(i=0;i<checkboxArray.length;i++){
			value+=checkboxArray[i]+",";
		}
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
		
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/advertisingSpace/delPosition",
					dataType : "json",
					ajaxStart: function() {
						$("#loading-container").attr("class","loading-container");
					},
					ajaxStop: function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container").addClass("loading-inactive")
						},300);
					},
					data : {
						"ids" : value
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							initPropsdict();
						} else {
							$("#model-body-warning")
									.html(
											"<strong>删除失败!</strong>");
							$("#modal-warning").attr({
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
	
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({
					"display" : "none"
				});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({
					"display" : "block"
				});
			}
		}
	}
	
	//成功后确认
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
		//$("#pageBody").load(__ctxPath + "/jsp/advertise_space/list.jsp");
	}