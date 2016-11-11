var tree = [];
	var resourcePagination;
	var nodeId = "";
	$(function() {
		loadLogJs();
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
				url : __ctxPath + "/site/getSiteList",
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
					
					$("#site_tab tbody").setTemplateElement(
							"site-list")
							.processTemplate(data);
					var arr=data.ftpList;
					
					var ftps=new Array(arr.length);
					for(i=0;i<arr.length;i++){
						ftps[i]=arr[i].uploadFtpId+":"+arr[i].name;
					}
					$("#ftp_list").val(ftps);
				}
			}
		});
		$("#save").click(function(){
			saveFrom();
		});
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/web/site/site_list.jsp");
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
	/**
	 * 修改站点信息
	 * @returns {Boolean}
	 */
	function editSite(){
		userName = getCookieValue("username");
    	LA.sysCode = '54';
		LA.log('site-editSite', '修改站点信息', userName,  sessionId);
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
		
		id_=$("#tdCheckbox_"+value).val().trim();
		name_ = $("#name_" + value).text().trim();
		domain_ = $("#domain_" + value).text().trim();
		path_ = $("#path_" + value).text().trim();
		tpl_path_ = $("#tpl_path_" + value).val().trim();
		res_path_ = $("#resource_path_" + value).val().trim();
		dynamicSuffix_=$("#dynamicSuffix_"+value).text().trim();
		staticSuffix_ = $("#staticSuffix_" + value).text().trim();
		channelCode_=$("#channelCode_" + value).val().trim();
		channelName_=$("#channelName_" + value).text().trim();
		var url = __ctxPath+"/jsp/web/site/site_edit.jsp";
		$("#pageBody").load(url);
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
	//新建site
	function addSite(){
		userName = getCookieValue("username");
    	LA.sysCode = '54';
		LA.log('site-addSite', '添加站点信息', userName,  sessionId);
		var url = __ctxPath+"/jsp/web/site/site_add.jsp";
		$("#pageBody").load(url);
	}
	
	/**
	 * 删除站点
	 * @returns {Boolean}
	 */
	function delSite(){
		userName = getCookieValue("username");
    	LA.sysCode = '54';
		LA.log('site-addSite', '删除站点信息', userName,  sessionId);
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
					url : __ctxPath + "/site/delSite",
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
		$("#pageBody").load(__ctxPath+"/jsp/web/site/site_list.jsp");
	} 