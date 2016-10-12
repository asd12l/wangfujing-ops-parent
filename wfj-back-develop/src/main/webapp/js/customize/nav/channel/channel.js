var brandPagination;
var advPagination;
// 导航树上节点ID
var nodeId = "";
// 频道树上节点ID
var channelId = "";
var hasContent = "";

// 频道详情
var parentId = "";
var channelName = "";
var channelPath = "";
var tplChannel = "";
var priority = "";
var channelDisplay = "";
var indexFlag = "";
// 频道树 右键 获取节点ID
var cNodeId = "";
// 频道树上获取站点ID
var siteId = "";
// 导航树上获取节点详情
var navName = "";
var navLink = "";
var navSeq = "";
var navIsShow = "";
var navEnName = "";
// 频道树 右键 获取节点ID
var rcNodeId = "";
var zTreeChannel, rMenuChannel;
/**
 * 用于判断是否需要加载访问路径
 */
var loadLink = true;

$(function() {
	validFormAddChannel();
	validFormEditChannel();

	$("#pageSelect").change(searchQuery);

	// 树上 禁用浏览器右键菜单
//	$(".page-body").bind('contextmenu', function() {
//		return false;
//	});
	$(".tree").mousedown(function() {
		return false;
	});

	// 新建频道时选定目录下的模板列表
	$(".channel_path").change(function() {
		var path = $(this).children('option:selected').val();
		initTplList(path);
	});
});

function searchQuery() {
	var params = $("#search_form").serialize();
	params = decodeURI(params);
	searchPaginations.onLoad(params);
};
/**
 * 加载频道Tree
 */

function initTree() {
	siteSid = $("#site_list").val();
	$.fn.zTree.init($("#channelTree"), {
		async: {
			enable : true,
			url : __ctxPath + "/web/getAllLimitResources?_site_id_param=" + siteSid,
			dataType : "json",
			autoParam : ["id"],// 请求下一级参数ID
			dataFilter : filter
		},
		view: {
			showIcon: true,
			dblClickExpand: false,
			fontCss: setFontCss
		},
		callback: {
			onClick: zTreeChannelOnClick,
			onRightClick: ChannelOnRightClick
		}
	});
	zTreeChannel = $.fn.zTree.getZTreeObj("channelTree");
	rMenuChannel = $("#rMenuChannel");
};

/**
 * 点击事件
 * @param event
 * @param treeId
 * @param treeNode
 */
function zTreeChannelOnClick(event, treeId, treeNode) {
	channelId = treeNode.id;
	siteId = treeNode.siteId;
	hasContent = treeNode.hasContent;
	// 加载导航Tree
	toNav(channelId);
	toFloor();
};

/**
 * 右键事件
 * 
 * @param event
 * @param treeId
 * @param treeNode
 */
function ChannelOnRightClick(event, treeId, treeNode) {
	channelId = treeNode.id;
	siteId = treeNode.siteId;
	hasContent = treeNode.hasContent;
	// 优先创建右键菜单
	if($("#rMenuChannel").html() == undefined){
		$('body').after($("#channelTreeRightDiv").html());
		rMenuChannel = $("#rMenuChannel");
	}
	if(treeNode != null){
		if (loadLink) {
			loadDir();
			loadLink = false;
		}
		cNodeId = treeNode.id;
		if (cNodeId == 0 || cNodeId == null) {
			$(".channel_root").show();
			$(".channel_child").hide();
		} else {
			$(".channel_root").hide();
			$(".channel_child").show();
		}
		if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
			zTreeChannel.cancelSelectedNode();
			showRMenuChannel("root", event.clientX, event.clientY);
		} else if (treeNode && !treeNode.noR) {
			zTreeChannel.selectNode(treeNode);
			showRMenuChannel("node", event.clientX, event.clientY);
		}
	}
};
/**
 * 定位右键菜单
 * 
 * @param type
 * @param x
 * @param y
 */
function showRMenuChannel(type, x, y) {
	$("#rMenuChannel ul").show();
	rMenuChannel.css({"top":y+"px", "left":x+"px", "visibility":"visible"});
	$("body").bind("mousedown", onBodyMouseDownChannel);
};
function onBodyMouseDownChannel(event){
	if (!(event.target.id == "rMenuChannel" || $(event.target).parents("#rMenuChannel").length>0)) {
		rMenuChannel.css({"visibility" : "hidden"});
	}
};
/**
 * 刷新选中节点
 * @param obj =1ADD,=2EDIT
 */
function refreshTreeChannel(obj){
	var treeObj = $.fn.zTree.getZTreeObj("channelTree");
	var nodes = treeObj.getSelectedNodes();
	if(obj==3){
		treeObj.removeNode(nodes[0]);
	}else{
		if (nodes.length>0) {
			treeObj.reAsyncChildNodes(nodes[0], "refresh");
			
			if(obj==2){
				// 手动修改颜色
				var ss = $.fn.zTree.getZTreeObj("channelTree");
				var s = ss.getSelectedNodes();
				s[0].name = channelName;
				s[0].isShow = channelDisplay;
				if(channelDisplay==0){
					s[0].iconSkin = "x";
					$("#"+s[0].tId+"_a").attr('style','color:red;');
				}else{
					if(indexFlag==1){
						s[0].iconSkin = "wuxing";
					}else{
						s[0].iconSkin = "blackwuxing";
					}
					$("#"+s[0].tId+"_a").attr('style','color:green;');
				}
				ss.updateNode(s[0]);
			}
		}
	}
};

/**
 * 查看频道下楼层按钮
 */ 
function toFloor() {
	if (channelId == "") {
		channelId = 1;
	}
	initFloorTree();
};
/**
 * 新建频道时模板目录列表
 */
function loadDir() {
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/site/getFtpTplDirList",
		dataType : "json",
		async : false,
		data : {
			"_site_id_param" : siteSid
		},
		success : function(response) {
			var channelPath = $(".channel_path");
			var result = response.list;
			channelPath.html("<option value=''> 请选择访问路径 </option>");
			for (var i = 0; i < result.length; i++) {
				var ele = result[i];
				if (ele.id == "") continue;
				if(ele.id!="/category" && ele.id!="/home") continue;
				var option = $("<option value='" + ele.id + "'>" + ele.id
						+ "</option>");
				option.appendTo(channelPath);
			}
			initTplList(result[0].path);
		}
	});
};
/**
 * 目录下模板列表
 * @param path
 */
function initTplList(path) {
	$.ajax({
		type : "post",
		async : false,
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/template/queryDirList",
		dataType : "json",
		data : {
			"path" : path,
			"_site_id_param" : siteSid,
			"channelNo": 1,
			"suffix":".html"
		},
		success : function(response) {
			var channelTemplate = $(".tplChannel");
			var result = response.list;
			channelTemplate.html("");
			for (var i = 0; i < result.length; i++) {
				var ele = result[i];
				if(ele.name.indexOf(".html") != -1){
					var option = $("<option value='" + ele.name + "'>" + ele.name
							+ "</option>");
					option.appendTo(channelTemplate);
				}
			}
		}
	});
};

/**
 * 折叠面板函数
 * @param data
 */
function tab(data) {
	if (data == 'pro') { // 基本
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
};

/**
 * 添加频道
 */
function addChannel() {
	$("#addChannelForm")[0].reset();
	$(".error").html("");
	// --Fuelux Spinner--
	$('.spinner').spinner('value', 1);
	$("#addChannelDIV").show();
	if (cNodeId == 0) {
		$("#add_index_flag").show();
		$("#channel_add_flag_0").click();
	} else {
		$("#add_index_flag").hide();
	}
	$("#root").val(cNodeId);
	rMenuChannel.css({"visibility" : "hidden"});
};
/**
 * 保存频道验证规则
 */
function validFormAddChannel() {
	return $("#addChannelForm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		rules : {
			name : "required",
			tplChannel : "required",
			path : "required",
			priority : {
				required:true,
				digits:true
			}
		}
	});
};
/**
 * 保存频道
 */
function addChannelForm() {
	$("#site_sid").val(siteSid);
	var indexFlag = $("input[name='indexFlag']:checked").val();
	var channelPath = $("#channel_add_path");
	if(indexFlag==1){  
	    if(channelPath.val()!="/home"){
	    	$("#warning2Body").text("请设置首页的路径为/home!");
		    $("#warning2").attr("style", "z-index:9999");
		    $("#warning2").show();
		    return false;
	    }
	}
	if (validFormAddChannel().form()) {
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
					$("#loading-container")
							.addClass("loading-inactive")
				}, 300);
			},
			url : __ctxPath + "/pindao/save",
			data : $("#addChannelForm").serialize(),
			success : function(response) {
				if (response.success == 'true') {
					$("#addChannelDIV").hide();
					$("#success1Body").text("添加成功!");
					$("#success1").attr("style", "z-index:9999");
					$("#success1").show();
					refreshTreeChannel();
				} else if (response.msg != null) {
					$("#addChannelDIV").hide();
					$("#warning2Body").text(response.msg);
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				} else {
					$("#addChannelDIV").hide();
					$("#warning2Body").text("添加失败!");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
	
				}
				// 重置频道添加表单
				$("#channel_add_name").val("");
				$("#channel_add_path").val("");
				$("#channel_add_template").val("");
				$("#add_priority").val("");
				$("#channel_add_display_1").attr("checked", "checked");
			}
		});
	}
};
/**
 * 通过ID获取频道详情
 * @param sid
 * @param site_id
 */
function loadChannelDetail(sid, site_id) {
	$.ajax({
		type : "post",
		async : false,
		dataType : "json",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/pindao/edit",
		data : {
			"id" : cNodeId,
			"root" : site_id
		},
		success : function(response) {
			var data = response.list;
			parentId = data.channel.parentId;
			channelName = data.channel.channelName;
			channelPath = data.channel.path;
			tplChannel = data.channel.tplChannel;
			priority = data.channel.priority;
			channelDisplay = data.channel.display;
			indexFlag = data.channel.indexFlag;
		}
	});
};
/**
 * 修改频道
 */
function editChannel() {
	$("#editChannelDIV").show();
	loadChannelDetail(cNodeId, siteSid);
	initTplList(channelPath);
	$("#channel_id").val(cNodeId);
	$("#parent_id").val(parentId);
	$("#channel_edit_name").val(channelName);
	$("#channel_edit_path").val(channelPath);
	$("#channel_tplChannel").val(tplChannel);
	// --Fuelux Spinner--
	$('.spinner').spinner('value', priority);
	if (channelDisplay) {
		$("#display_1").click();
	} else {
		$("#display_0").click();
	}
	if (parentId == null || parentId == "") {
		$("#edit_index_flag").show();
		if (indexFlag) {
			$("#channel_edit_flag_1").click();
		} else {
			$("#channel_edit_flag_0").click();
		}
	} else {
		$("#edit_index_flag").hide();
	}
	rMenuChannel.css({"visibility" : "hidden"});
};
/**
 * 修改频道验证规则
 * @returns
 */
function validFormEditChannel() {
	return $("#editChannelForm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		rules : {
			name : "required",
			tplChannel : "required",
			path : "required",
			priority : {
				required:true,
				digits:true
			}
		}
	});
};
/**
 * 修改频道保存方法
 */
function editChannelForm() {
	if (validFormEditChannel().form()) {
		$.ajax({
			type : "post",
			dataType : "json",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/pindao/update",
			data : $("#editChannelForm").serialize(),
			success : function(response) {
				if (response.success == "true") {
					var split_ = decodeURI($("#editChannelForm").serialize()).split("&");
					channelName = $("#channel_edit_name").val();
					channelDisplay = split_[split_.length-1].split("=")[1];
					indexFlag = split_[split_.length-2].split("=")[1];
					$("#editChannelDIV").hide();
					$("#success1Body").text("修改成功!");
					$("#success1").attr("style", "z-index:9999");
					$("#success1").show();
					refreshTreeChannel(2);
				} else if (response.msg != null) {
					$("#editChannelDIV").hide();
					$("#warning2Body").text(response.msg);
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				} else {
					$("#addChannelDIV").hide();
					$("#warning2Body").text("修改失败!");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();

				}
			}
		});
	}
};
/**
 * 删除频道
 */
function delChannel() {
	bootbox.setDefaults("locale", "zh_CN");
	if (hasContent == 1) {
		bootbox.confirm("该频道下不为空,确定删除吗？", function(r) {
			if (r) {
				delChannelAjax();
			}
		});
	} else {
		bootbox.confirm("确定删除吗？", function(r) {
			if (r) {
				delChannelAjax();
			}
		});
	}
};
/**
 * 删除频道事件
 */
function delChannelAjax() {
	$.ajax({
		type : "post",
		dataType : "json",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/pindao/del",
		data : {
			"id" : channelId
		},
		success : function(response) {
			if (response.success) {
				$("#success1Body").text("删除成功!");
				$("#success1").attr("style", "z-index:9999");
				$("#success1").show();
				initTree();
				$("#navTree").empty();
				$("#floorTree").empty();
			} else {
				$("#warning2Body").text("删除失败!");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		}
	});
};
/**
 * 右键预览频道
 */
function findChannel() {
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/webserver/get_front_server",
		dataType : "json",
		data : {
			"_site_id_param" : siteSid
		},
		success : function(response) {
			var data = response.list;
			if (data.length > 0) {
				var ip = data[0].path;
				var port = data[0].port;
				var domain = data[0].path;
				window.open("http://" + ip + "/chnnl/" + channelId + ".html");
			} else {
				$("#warning2Body").text("没有找到对应的server显示!");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		}
	});
};

/**
 * 热门品牌信息初始化
 */
function initHootBrand() {
	brandPagination = $("#brandPagination").myPagination(
	{
		panel : {
			tipInfo_on : true,
			tipInfo : '  跳{input}/{sumPage}页',
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
			url : __ctxPath + "/hootBrand/brandList?sid=" + nodeId,
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
				// 使用模板
				$("#hootBrand_tab tbody").setTemplateElement(
						"hootBrand-list").processTemplate(data);

			}
		}
	});
};

/**
 * 删除热门品牌
 * @returns {Boolean}
 */
function deleteBrand() {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var productSid = $(this).val();
		checkboxArray.push(productSid);
	});
	if (checkboxArray.length == 0) {
		$("#warning2Body").text("你好，请选取要删除的列!");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
		return false;
	}
	bootbox.setDefaults("locale", "zh_CN");
	bootbox.confirm("确定删除此品牌吗？",function(r) {
		if (r) {
			var value = "";
			for (i = 0; i < checkboxArray.length; i++) {
				value += checkboxArray[i] + ",";
			}
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/hootBrand/delBrand",
				dataType : "json",
				data : {
					"sid" : value,
					"nodeId": nodeId
				},
				success : function(response) {
					if (response.success == "true") {
						$("#success1Body").text("添加成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
						initHootBrand();
					} else {
						$("#warning2Body").text("添加失败!");
						$("#warning2").attr("style", "z-index:9999");
						$("#warning2").show();
					}
					return;
				}
			});
		}
	});
};

/**
 * 促销活动信息初始化
 * @param sid
 */
function initPromotion(sid) {
	promotionPagination = $("#promotionPagination").myPagination(
	{
		debug : false,
		ajax : {
			on : true,
			contentType : "application/json;charset=utf-8",
			url : __ctxPath + "/promotion/promotionList?sid=" + sid,
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
				// 使用模板
				$("#promotion_tab tbody").setTemplateElement(
						"promotion-list").processTemplate(data);

			}
		}
	});
};

/**
 * 导航关键字信息初始化
 * @param sid
 */
function initNavWord(sid) {
	promotionPagination = $("#promotionPagination").myPagination(
	{
		panel : {
			tipInfo_on : true,
			tipInfo : '  跳{input}/{sumPage}页',
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
			url : __ctxPath + "/navword/navwordList?sid=" + sid,
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
				// 使用模板
				$("#navword_tab tbody").setTemplateElement(
						"navword-list").processTemplate(data);
			}
		}
	});
};
/**
 * 选择频道模板时预览
 * 
 * @param obj
 * @param num
 * @returns {Boolean}
 */
function showTplView(obj, num) {
	var tplName = $("#channel_add_template").val();
	var path = "";
	if (num == 1) {
		path = $("#channel_add_path").val();
	} else {
		path = $("#channel_edit_path").val();
	}
	if (tplName.indexOf(".") <= 0) {
		$("#warning2Body").text("'" + tplName + "': 无法预览!");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
		return false;
	}
	$.ajax({
		type : "post",
		dataType : "json",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/template/showTplView",
		data : {
			"path" : path,
			"tplName" : tplName,
			"_site_id_param" : siteSid
		},
		success : function(response) {
			if (response.success == "true") {
				$("#showTplViewDIV").show();
				str = "<img src='" + response.src + "' height='' width='900px;' />";
				$(".show_body_1").html(str);
			} else {
				bootbox.alert({
					buttons : {
						ok : {
							label : '确定',
						}
					},
					message : "无对应资源!",
					title : "温馨提示!",
				});
			}
		}
	});
};
/**
 * 选择楼层样式时预览
 * 
 * @param obj
 */
function view(obj) {
	$("#showTplViewDIV").show();
	var filename = $(obj).prev().val();
	$.ajax({
		type : "post",
		dataType : "json",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/template/previewImg",
		data : {
			"name" : filename,
			"_site_id_param" : siteSid
		},
		success : function(response) {
			str = "<img src='" + response.src + "' height='' width='900px;' />";
			$(".show_body_1").html(str);
		}
	});
};

function successBtn() {
	$("#modal-success").attr({
		"style" : "display:none;",
		"aria-hidden" : "true",
		"class" : "modal modal-message modal-success fade"
	});
	$("#modal-warning").attr({
		"style" : "display:none;",
		"aria-hidden" : "true",
		"class" : "modal modal-message modal-warning"
	});
};