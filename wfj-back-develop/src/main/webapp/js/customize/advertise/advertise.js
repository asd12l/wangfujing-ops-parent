image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	var advertisingPagination;
	$(function() {
		$("#pageSelect").change(advertisingQuery);
		//新建频道时选定目录下的模板列表
		$(".channel_path").change(function(){
			var path=$(this).children('option:selected').val(); 
			initTplList(path);
		});
		
		$("#advertise_space_list").change(function(){
			loadAdvertiseList();
		});
	});
	
	//测试购物车栏广告
	function showCart(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/adverties/showCart",
			dataType : "json",
			data:{
				"_site_id_param":siteSid
			},
			success : function(response) {
				$(".testCart").html(response.list);
			}
		});
	}
	
  //新建广告时模板目录列表
	function loadDir(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/template/queryDirList",
			dataType : "json",
			data:{
				"_site_id_param":siteSid
			},
			success : function(response) {
				var channelPath = $(".channel_path");
				var result = response.list;
				channelPath.html("");
				//channelPath.html("<option value='-1'>请选择</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.id + "'>"
							+ ele.id + "</option>");
					option.appendTo(channelPath);
				}
				//initTplList(result[0].id);
			}
		});
	}
	//目录下模板列表
	function initTplList(path){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/template/queryDirList",
			dataType : "json",
			data:{
				"path":path,
				"_site_id_param":siteSid
			},
			success : function(response) {
				var channelTemplate = $(".tplChannel");
				var result = response.list;
				channelTemplate.html("");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.name + "'>"
							+ ele.name + "</option>");
					option.appendTo(channelTemplate);
				}
			}
		});
	}
	function initTree(){
		initPropsdict();
		//loadDir();
	}
	//初始化广告版位
	function initPropsdict() {
		//查询版位
  		var adspaceId = $(".adspace");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/adverties/findAdspace",
			dataType: "json",
			data:{
				"_site_id_param":siteSid
			},
			async: false,
			success: function(response) {
				var result = response.list;
				adspaceId.html("");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.id + "'>"
							+ ele.name + "</option>");
					option.appendTo(adspaceId);
				}
				return;
			},
			error: function() {
				$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong>");
  	  			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
			}
		});

		loadAdvertiseList();
	}
	function addPropsdict() {
		//获取列表上的广告版位
		var _spaceId = $("#advertise_space_list").val();
		$("#pageBody").load(__ctxPath + "/jsp/advertise/addAdvertise.jsp?_site_id_param="+siteSid+"&&site_name="+siteName+"&&_spaceId="+_spaceId);
	}
	
	function editPropsdict() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
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
		
		advertiesName = $("#advertiesName" + value).text().trim();
//		advertiesAdspace = $("#advertiesAdspace" + value).text().trim();
		advertiesAdspaceId = $("#advertiesAdspaceId" + value).text().trim();
		advertiesCategory = $("#advertiesCategory" + value).text().trim();
		attr_image_url = $("#attr_image_url" + value).text().trim();
		attr_image_name = $("#attr_image_name" + value).text().trim();
		attr_image_width = $("#attr_image_width" + value).text().trim();
		attr_image_link = $("#attr_image_link" + value).text().trim();
		attr_image_backpict = $("#attr_image_backpict"+value).text().trim();
		attr_image_uppict = $("#attr_image_uppict"+value).text().trim();
		attr_image_desc = $("#attr_image_desc" + value).text().trim();
		attr_image_title = $("#attr_image_title" + value).text().trim();
		flashPath1 = $("#flashPath1" + value).text().trim();
		flashFile = $("#flashFile" + value).text().trim();
		attr_flash_url = $("#flash_url" + value).text().trim();
		attr_flash_width = $("#attr_flash_width" + value).text().trim();
		attr_text_title = $("#attr_text_title" + value).text().trim();
		attr_text_link = $("#attr_text_link" + value).text().trim();
		attr_text_font = $("#attr_text_font" + value).text().trim();
		seq_ = $("#seq" + value).text().trim();
		code = $("#code" + value).text().trim();
		
		advertiesTplName = $("#advertiesTplName" + value).text().trim();
		advertiesPath = $("#advertiesPath" + value).text().trim();
		initTplList(advertiesPath);
		//advertiesDisplayCount = $("#advertiesDisplayCount" + value).text().trim();
		advertiesEnabled = $("#advertiesEnabled" + value).text().trim();
		advertiesStartTime = $("#advertiesStartTime" + value).text().trim();
		advertiesEndTime = $("#advertiesEndTime" + value).text().trim();
		//add by awen get imgSers list begin on 2016-3-17
		imgServer = "";
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/cms/file/getImageServer",
			dataType: "json",
			data:{
			},
			async: true,
			success: function(response) {
				if(response.success == true){
					imgServer = response.imgServer;
				}
			},
			error: function() {
			}
		});
		//add by awen end
		$("#pageBody").load(__ctxPath + "/jsp/advertise/editAdvertise.jsp");
	}
	
	function delPropsdict() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		/*if (checkboxArray.length > 1) {
			$("#model-body-warning")
					.html(
							"<strong>只能选择一列!</strong>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		} else*/ 
			
		if (checkboxArray.length == 0) {
			$("#model-body-warning")
					.html(
							"<strong>请选取要补充的列!</strong>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		//var value = checkboxArray[0];
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
					url : __ctxPath + "/adverties/del",
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
						"id" : value
					},
					success : function(response) {
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "<strong>删除成功，返回列表页!</strong>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							loadAdvertiseList();
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
	
	function queryAdspace(){
		$("#pageBody").load(__ctxPath + "/jsp/advertise_space/list.jsp");
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
	function advertisingQuery() {
		var params = $("#advertising_form").serialize();
		params = decodeURI(params);
		advertisingPagination.onLoad(params);
	}
	//加载该广告版位里的广告
	function loadAdvertiseList(){
		var spaceId = $("#advertise_space_list").val();
		var url = __ctxPath + "/advertisingSpace/loadAdvertise?spaceId="+spaceId+"&&_site_id_param="+siteSid;
		advertisingPagination = $("#advertisingPagination").myPagination(
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
					url : url,
					dataType : 'json',
					/*data:{
						"_site_id_param":siteSid,
						"spaceId" : spaceId,
					},*/
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						setTimeout(function() {
							$("#loading-container").addClass(
									"loading-inactive")
						}, 300);
					},
					callback : function(data) {
						//使用模板
						$("#propsdict_tab tbody").setTemplateElement(
								"propsdict-list").processTemplate(data);
					}
				}
			});
	}
	//成功后确认
	
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
	}