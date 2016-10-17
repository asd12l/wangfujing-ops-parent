/**
 * 导航JS
 */
var zTree, rMenu, nameNavEdit, isShow;
$(function(){
	validform();
	validform2();
	validform3();
	validform4();
	validform5();
});
/**
 * 通过频道ID加载导航树
 * @param sid
 */
function toNav(sid) {
	if(sid!=''){
		$("#navTree").show();
		$.fn.zTree.init($("#navTree"), {
			async: {
				enable : true,
				url : __ctxPath + "/nav/navTree?sid=" + sid,
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
				onClick: zTreeOnClick,
				onRightClick: OnRightClick
			}
		});
		zTree = $.fn.zTree.getZTreeObj("navTree");
		rMenu = $("#rMenu");
	}else{
		$("#navTree").hide();
	}
};

function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	for (var i=0, l=childNodes.length; i<l; i++) {
		childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
	}
	return childNodes;
};

/**
 * 控制节点颜色
 * @param treeId
 * @param treeNode
 * @returns
 */
function setFontCss(treeId, treeNode) {
	return treeNode.isShow == 0 ? {color:"red"} : {color:"green"};
};

/**
 * 点击事件
 * @param event
 * @param treeId
 * @param treeNode
 */
function zTreeOnClick(event, treeId, treeNode) {
	nodeId = treeNode.id;
	initHootBrand();
	initPromotion(nodeId);
	initHotwordVar(siteId, channelId, nodeId);
	initNavWord(nodeId);
};

/**
 * 右键事件
 * 
 * @param event
 * @param treeId
 * @param treeNode
 */
function OnRightClick(event, treeId, treeNode) {
	// 优先创建右键菜单
	if($("#rMenu").html() == undefined){
		$('body').after($("#navTreeRightDiv").html());
		rMenu = $("#rMenu");
	}
	if(treeNode != null){
		nodeId = rcNodeId = treeNode.id;
		if (rcNodeId == 0 || rcNodeId == null) {
			$(".nav_root").show();
			$(".nav_child").hide();
		} else {
			$(".nav_root").show();
			$(".nav_child").show();
		}
		if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
			zTree.cancelSelectedNode();
			showRMenu("root", event.clientX, event.clientY);
		} else if (treeNode && !treeNode.noR) {
			zTree.selectNode(treeNode);
			showRMenu("node", event.clientX, event.clientY);
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
function showRMenu(type, x, y) {
	$("#rMenu ul").show();
	if (type=="root") {
		$("#m_del").hide();
		$("#m_check").hide();
		$("#m_unCheck").hide();
	} else {
		$("#m_del").show();
		$("#m_check").show();
		$("#m_unCheck").show();
	}
	rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});

	$("body").bind("mousedown", onBodyMouseDown);
};
function onBodyMouseDown(event){
	if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
		rMenu.css({"visibility" : "hidden"});
	}
};

/**
 * 刷新选中节点
 * @param obj =1ADD,=2EDIT
 */
function refreshTree(obj){
	var nodes = zTree.getSelectedNodes();
	if(obj==3){// 删除节点
		zTree.removeNode(nodes[0]);
	}else{
		if(zTree.getNodes()[0].id==0){
			toNav(zTreeChannel.getSelectedNodes()[0].id);
			return;
		}
		if (nodes.length>0) {
			zTree.reAsyncChildNodes(nodes[0], "refresh");
			if(obj==2){
				// 手动修改颜色
				nodes[0].name = nameNavEdit;
				nodes[0].isShow = isShow;
				if(isShow==0){
					nodes[0].iconSkin = "x";
					$("#"+nodes[0].tId+"_a").attr('style','color:red;');
				}else{
					nodes[0].iconSkin = "success";
					$("#"+nodes[0].tId+"_a").attr('style','color:green;');
				}
				zTree.updateNode(nodes[0]);
			}
		}
	}
};

/**
 * 查询导航信息
 * @param sid
 */
function loadNav(sid) {
	$.ajax({
		on : true,
		async : false,
		contentType : "application/json;charset=utf-8",
		url : __ctxPath + "/nav/load_nav?sid=" + sid,
		dataType : 'json',
		ajaxStart : function() {
			$(".loading-container").attr("class", "loading-container");
		},
		ajaxStop : function() {
			// 隐藏加载提示
			$(".loading-container").addClass("loading-inactive");
		},
		success : function(response) {
			var nav = response.list;
			navName = nav.name;
			navLink = nav.link;
			navSeq = nav.seq;
			navIsShow = nav.isShow;
			navEnName = nav.enName;
		}
	});
};

/**
 * 添加导航
 */
function addNav() {
	$(".error").html("");
	// --Fuelux Spinner--
	$('.spinner').spinner('value', 1);
	$("#addNavDIV").show();
	if (nodeId == null || nodeId == "") {
		nodeId = 0;
	}
	$("#channel_sid").val(channelId);
	$("#nav_sid").val(nodeId);
	rMenu.css({"visibility" : "hidden"});
};
/**
 * 保存导航验证
 * @returns
 */
function validform() {
	return $("#addNavForm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		rules : {
			name : "required",
			link : {
				required : true,
				LinkVal : true
			},
			seq : {
				required:true,
				digits:true
			},
			enName:"english"
		}
	});
};
/**
 * 添加保存导航
 */
function addNavForm() {
	if (validform().form()) {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			dataType : "json",
			ajaxStart : function() { $("#loading-container").addClass("loading-container"); },
			ajaxStop : function() {
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			url : __ctxPath + "/nav/save",
			data : $("#addNavForm").serialize(),
			success : function(response) {
				if (response.success == 'true') {
					$("#addNavDIV").hide();
					clearInput();
					$("#success1Body").text("添加成功!");
					$("#success1").attr("style", "z-index:9999");
					$("#success1").show();
					refreshTree(1);
				} else {
					$("#addNavDIV").hide();
					clearInput();
					$("#warning2Body").text("添加导航失败!");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
				// 重置导航添加表单
				$("#name_nav_add").val("");
				$("#link_nav_add").val("");
				$("#seq_nav_add").val("");
				$("#isShowNav_add_1").attr("checked", "checked");
			}
		});
	}
};

/**
 * 编辑导航
 */
function updateNav() {
	loadNav(rcNodeId);
	$("#editNavDIV").show();
	$("#nav_edit_sid").val(nodeId);
	$("#name_nav_edit").val(navName);
	$("#en_name_nav_edit").val(navEnName);
	$("#link_nav_edit").val(navLink);
	// --Fuelux Spinner--
	$('.spinner').spinner('value', navSeq);
	if (navIsShow == 1) {
		$("#isShowNav_edit_1").click();
	} else if (navIsShow == 0) {
		$("#isShowNav_edit_0").click();
	}
	rMenu.css({"visibility" : "hidden"});
};
/**
 * 修改导航验证
 * @returns
 */
function validform2() {
	return $("#editNavForm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		rules : {
			name : "required",
			link : {
				required : true,
				LinkVal : true
			},
			seq : {
				required:true,
				digits:true
			},
			enName:"english"
		}
	});
};
/**
 * 保存修改导航
 */
function editNavForm() {
	if (validform2().form()) {
		$.ajax({
			type : "post",
			dataType : "json",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/nav/edit",
			data : $("#editNavForm").serialize(),
			success : function(response) {
				var split_ = decodeURI($("#editNavForm").serialize()).split("&");
				nameNavEdit = $("#name_nav_edit").val();
				isShow = split_[split_.length-1].split("=")[1];
				if (response.success == 'true') {
					$("#editNavDIV").hide();
					$("#success1Body").text("修改导航成功!");
					$("#success1").attr("style", "z-index:9999");
					$("#success1").show();
					toNav(zTreeChannel.getSelectedNodes()[0].id);
				} else {
					$("#warning2Body").text("修改导航失败!");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
			}
		});
	}
};

/**
 * 删除导航
 */ 
function deleteNav() {
	bootbox.confirm("确定删除吗？",function(r) {
		if (r) {
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/nav/del",
				dataType : "json",
				data : {
					"sid" : rcNodeId
				},
				success : function(response) {
					if (response.success == "true") {
						$("#success1Body").text("删除导航成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
						refreshTree(3);
					} else {
						$("#warning2Body").text("删除导航失败!");
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
 * 查看导航链接
 */
function checkNav() {
	loadNav(rcNodeId);
	$("#loadNavDIV").show();

	$("#name_nav_load").val(navName);
	$("#link_nav_load").val(navLink);
	$("#seq_nav_load").val(navSeq);
	if (navIsShow == "1") {
		$("#isShowNav_load_1").attr("checked", 'checked');
		$("#a").show();
		$("#b").hide();
	} else if (navIsShow == "0") {
		$("#isShowNav_load_0").attr("checked", 'checked');
		$("#a").hide();
		$("#b").show();
	}
	$("#rMenu").remove();
};
/**
 * 添加导航关键词
 */ 
function addNavWord() {
	if(zTreeChannel.getSelectedNodes().length == 0){
		$("#warning2Body").text("请选择导航!");
		$("#warning2").show();
		return false;
	}
	if(zTree.getSelectedNodes().length==0){
		$("#warning2Body").text("请选择导航!2");
		$("#warning2").show();
		return false;
	}
	$(".spinner").spinner('value', 1);
	$("#addNavWordDIV").show();
	$("#sid_nav").val(nodeId);
	$("#username").val(username);
};
/**
 * 保存导航关键字验证
 * @returns
 */
function validform5() {
	return $("#addNavWordForm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		rules : {
			name : "required",
			link : {
				required : true,
				LinkVal : true
			}
		}
	});
};
/**
 * 添加导航关键词保存方法
 */
function addNavWordForm() {
	if (validform5().form()) {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
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
			url : __ctxPath + "/navword/saveNav",
			data : $("#addNavWordForm").serialize(),
			success : function(response) {
				if (response.success == 'true') {
					$("#addNavWordDIV").hide();
					clearInput();
					$("#success1Body").text("添加成功!");
					$("#success1").attr("style", "z-index:9999");
					$("#success1").show();
					initNavWord(nodeId);
				} else {
					$("#addNavWordDIV").hide();
					clearInput();
					$("#warning2Body").text("添加失败!");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
				// 重置促销活动添加表单
				$("#nav_add_name").val("");
				$("#nav_add_link").val("");
				$("#nav_add_seq").val("");
				$("#nav_isShow_1").attr("checked", checked);
			}
		});
	}
};
/**
 * 添加促销活动
 */
function addPromotion() {
	if(zTreeChannel.getSelectedNodes().length == 0){
		$("#warning2Body").text("请选择导航!");
		$("#warning2").show();
		return false;
	}
	if(zTree.getSelectedNodes().length==0){
		$("#warning2Body").text("请选择导航!");
		$("#warning2").show();
		return false;
	}
	$("#addPromotionForm")[0].reset();
	$("#msg_proAddPict").addClass("hide");
	$("#hidden_proAddPict").val("");
	$(".spinner").spinner("value",1);
	$("#addPromotionDIV").show();
	$("#sid_pro").val(nodeId);
};
/**
 * 保存促销活动验证
 * @returns
 */
function validform3() {
	return $("#addPromotionForm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		rules : {
			name : "required",
			link : {
				required : true,
				LinkVal : true
			},
			pict : "LinkVal"
		}
	});
};
/**
 * 添加促销活动提交事件
 */
function addPromotionForm() {
	if (validform3().form()) {
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
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
			url : __ctxPath + "/promotion/savePro",
			data : $("#addPromotionForm").serialize(),
			success : function(response) {
				if (response.success == 'true') {
					$("#addPromotionDIV").hide();
					clearInput();
					$("#success1Body").text("添加成功!");
					$("#success1").attr("style", "z-index:9999");
					$("#success1").show();
					initPromotion(nodeId);
				} else {
					$("#addPromotionDIV").hide();
					clearInput();
					$("#warning2Body").text("添加失败!");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
				// 重置促销活动添加表单
				$("#pro_add_name").val("");
				$("#pro_add_link").val("");
				$("#pro_add_seq").val("");
				$("#pro_isShow_1").attr("checked", "checked");
				$("#pro_flag_1").attr("checked", "checked");
			}
		});
	}
};
/**
 * 编辑促销活动
 * @returns {Boolean}
 */
function updatePromotion() {
	$("#editPromotionForm")[0].reset();
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var productSid = $(this).val();
		checkboxArray.push(productSid);
	});
	if (checkboxArray.length > 1) {
		$("#warning2Body").text("只能选择一列!");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
		return false;
	} else if (checkboxArray.length == 0) {
		$("#warning2Body").text("请选择要修改的列!");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
		return false;
	}
	value = checkboxArray[0];
	$("#editPromotionDIV").show();
	proName_ = $("#proName_" + value).text().trim();
	proLink_ = $("#proLink_" + value).text().trim();
	proSeq_ = $("#proSeq_" + value).text().trim();
	proIsShow_ = $("#proIsShow_" + value).text().trim();
//	proFlag_ = $("#proFlag_" + value).text().trim();
	proPict_ = $("#proPict_" + value).text().trim();
	hidden_pictPath_ =$("#pictPath_" + value).text().trim();
	$("#sid_promo").val(value);
	$("#hidden_proEditPict").val(hidden_pictPath_);
	$("#img_proEditPict").attr('src',proPict_);// 图片预览
	$("#name_promo").val(proName_);
	$("#link_promo").val(proLink_);
	$("#editPromoNodeId").val(nodeId);
	$(".spinner").spinner("value",proSeq_);
	if (proIsShow_ == 1) {
		$("#isShowPro_1").attr("checked", "checked");
		$("#isShowPro_0").removeAttr("checked");
	} else {
		$("#isShowPro_0").attr("checked", "checked");
		$("#isShowPro_1").removeAttr("checked");
	}
//	if (proFlag_ == 1) {
//		$("#isPro_1").attr("checked", "checked");
//	} else {
//		$("#isPro_0").attr("checked", "checked");
//	}
};
/**
 * 编辑促销活动验证
 * @returns
 */
function validform4() {
	return $("#editPromotionForm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		rules : {
			name : "required",
			link : {
				required : true,
				LinkVal : true
			},
			pict : "LinkVal"
		}
	});
};
/**
 * 修改促销活动保存方法
 */
function editPromotionForm() {
	if (validform4().form()) {
		$.ajax({
			type : "post",
			dataType : "json",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/promotion/edit",
			data : $("#editPromotionForm").serialize(),
			success : function(response) {
				if (response.success == 'true') {
					$("#editPromotionDIV").hide();
					$("#success1Body").text("修改成功!");
					$("#success1").attr("style", "z-index:9999");
					$("#success1").show();
					initPromotion(nodeId);
				} else {
					$("#editPromotionDIV").hide();
					$("#warning2Body").text("修改失败!");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
			}
		});
	}
};
/**
 * 删除促销活动
 * @returns {Boolean}
 */
function deletePromotion() {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var productSid = $(this).val();
		checkboxArray.push(productSid);
	});
	if (checkboxArray.length == 0) {
		$("#warning2Body").text("请选择要修改的列!");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
		return false;
	}
	bootbox.setDefaults("locale", "zh_CN");
	bootbox.confirm("确定删除此活动吗？",function(r) {
		if (r) {
			var value = "";
			for (i = 0; i < checkboxArray.length; i++) {
				value += checkboxArray[i] + ",";
			}
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/promotion/delPro",
				dataType : "json",
				data : {
					"sid" : value,
					"nodeId": nodeId
				},
				success : function(response) {
					if (response.success == "true") {
						$("#success1Body").text("删除成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
						initPromotion(nodeId);
					} else {
						$("#warning2Body").text("删除失败!");
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
 * 删除活动
 * @returns {Boolean}
 */
function deleteNavWord() {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var productSid = $(this).val();
		checkboxArray.push(productSid);
	});
	if (checkboxArray.length == 0) {
		$("#warning2Body").text("请选择要删除的列!");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
		return false;
	}
	bootbox.setDefaults("locale", "zh_CN");
	bootbox.confirm("确定删除此项吗？",function(r) {
		if (r) {
			var value = "";
			for (i = 0; i < checkboxArray.length; i++) {
				value += checkboxArray[i] + ",";
			}
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/navword/delNav",
				dataType : "json",
				data : {
					"sid" : value
				},
				success : function(response) {
					if (response.success == "true") {
						$("#success1Body").text("删除成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
						initNavWord(nodeId);
					} else {
						$("#warning2Body").text("删除失败!");
						$("#warning2").attr("style", "z-index:9999");
						$("#warning2").show();
					}
					return;
				}
			});
		}
	});
};