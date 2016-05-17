var tree = [];
	var resourcePagination;
	var nodeId = "";
	$(function() {
		channelPagination = $("#channelPagination").myPagination(
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
						on : true,
						contentType : "application/json;charset=utf-8",
						url : __ctxPath + "/ftp/getList",
						dataType : 'json',
						ajaxStart : function() {
							$(".loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							$(".loading-container").addClass(
									"loading-inactive");
						},
						callback : function(data) {
							
							$("#ftp_tab tbody").setTemplateElement(
									"ftp-list")
									.processTemplate(data);
						}
					}
				});
		$("#save").click(function(){
			saveFrom();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/web/ftp/ftp_list.jsp");
		});
	});
	
	//折叠面板函数
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
	//修改ftp
	function editDir(){
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var id = $(this).val();
			checkboxArray.push(id);
		});
		if (checkboxArray.length > 1) {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		} else if (checkboxArray.length == 0) {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		var value=checkboxArray[0];
		id_=$("#id_"+value).text().trim();
		name_ = $("#name_" + value).text().trim();
		encoding_ = $("#encoding_" + value).val().trim();
		ip_ = $("#ip_" + value).text().trim();
		password_=$("#password_"+value).val().trim();
		path_ = $("#path_" + value).text().trim();
		port_ = $("#port_" + value).text().trim();
		timeout_ = $("#timeout_" + value).val().trim();
		url_=$("#url_"+value).text().trim();
		username_ = $("#username_" + value).val().trim();
		type_ = $("#type_" + value).val().trim();
		
		var url = __ctxPath+"/jsp/web/ftp/edit_ftp.jsp";
		$("#pageBody").load(url);
	}
	
	//新建ftp
	function addDir(){
		var url = __ctxPath+"/jsp/web/ftp/add_ftp.jsp";
		$("#pageBody").load(url);
	}
	
	//删除ftp
	function delDir(){
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var id = $(this).val();
			checkboxArray.push(id);
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
		var value="";
		for(i=0;i<checkboxArray.length;i++){
			value+=checkboxArray[i]+",";
		}
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/ftp/delFtp",
					dataType : "json",
					data : {
						"id" : value
					},
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
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>删除成功，返回列表页!</strong></div>");
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
						return;
					}
				});
			}
		}); 
	}
	
	  //弹出框的确定按钮
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/web/ftp/ftp_list.jsp");
	}