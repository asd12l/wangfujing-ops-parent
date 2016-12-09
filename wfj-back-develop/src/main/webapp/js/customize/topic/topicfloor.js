
$(function(){
	// JS验证初始化
	validSaveTopicFloor();
	validTopicDivForm();
	validEditTopicFloorForm();
	validRenameDivForm();
	validEditDivForm();
	loadLogJs();
//	initStyleList();
	//树上 禁用浏览器右键菜单
	$(".tree_parent").bind('contextmenu',function(){
        return false;
    });
    $(".tree").mousedown(function(){
        return false;
    });
    
	$('#topic_floor_tree').contextmenu({
		target: '#context-menu-floor',
		before:function(e,context){
	        fNodeId = $(e.target).attr("id");
	        floorType = $(e.target).attr("data-type");
	        //区分 根节点 /楼层 /块 选取不同的右键菜单
	        if(floorType==-1){
        		$("#context-menu-floorLi1").show();
        		$("#context-menu-floorLi1_").show();
        		$("#context-menu-floorLi2").show();
        		$("#context-menu-floorLi2_").show();
        		$("#context-menu-floorLi3").hide();
        		$("#context-menu-floorLi3_").hide();
        		$("#context-menu-floorLi4").show();
        		$("#context-menu-floorLi4_").show();
        		$("#context-menu-floorLi5").show();
	        }else if(floorType==null){
	        	$("#context-menu-floorLi1").hide();
	        	$("#context-menu-floorLi1_").hide();
	        	$("#context-menu-floorLi2").hide();
	        	$("#context-menu-floorLi2_").hide();
	        	$("#context-menu-floorLi3").hide();
	        	$("#context-menu-floorLi3_").hide();
	        	$("#context-menu-floorLi4").show();
	        	$("#context-menu-floorLi4_").show();
	        	$("#context-menu-floorLi5").show();
	        }else{
	        	$("#context-menu-floorLi1").hide();
	        	$("#context-menu-floorLi1_").hide();
	        	$("#context-menu-floorLi2").hide();
	        	$("#context-menu-floorLi2_").hide();
	        	$("#context-menu-floorLi3").hide();
	        	$("#context-menu-floorLi3_").hide();
	        	$("#context-menu-floorLi4").show();
	        	$("#context-menu-floorLi4_").show();
	        	$("#context-menu-floorLi5").show();
	        }
	        $(e.target).click();
	    },
	    onItem: function (context, e) {
		    	var tabIndex = parseInt($(e.target).attr("ta bindex"));
		    	/*switch (tabIndex) {
			case 1:
				addDiv();
				break;
            case 2:
            	editDiv();
				break;
            case 3:
            	delDiv();
            	break;
            case 4:
            	//findChannel();
           	 	break;
			}*/
        }
	});
	
	//添加块.块组时显示不同的选项
	$("input").click(function(){
		//如果选块,显示三种块类型
		if($("#add_divType_0").is(':checked')){
			$("#addDiv_div_lcys").hide();
			$("#add_floorType").hide();
		}else if($("#add_divType_1").is(':checked')){
			$("#add_floorType").show();
			$("#addDiv_div_lcys").hide();
			$("#add_divType_3").attr('checked','checked');
		}
		//如果是商品块,显示样式列表
		if($(".add_divType_2").is(':checked')){
			$("#addDiv_div_lcys").show();
		}else{
			$("#addDiv_div_lcys").hide();
		}
	});
});
/**
 * 根据floorType添加不同资源
 */
function addResources(){
	if(floorType==1){
		addPro();
	}else if(floorType==2){
		addFloorBrand();
	}else if(floorType==3){
		addLink();
	}else if(floorType==4){
		addLinkProduct();
	}else if(floorType==0){
		addFloorDIV();
	}
};
/**
 * 初始化添加楼层时styleList列表
 */
function initStyleList(){
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/stylelist/queryStyleList",
		dataType : "json",
		data : {
			"_site_id_param" : siteSid,
			"type" : 1
		},
		async : false, 
		success : function(response) {
			var styleList = $(".style_list");
			var result = response.list;
			styleList.html("");
			for ( var i = 0; i < result.length; i++) {
				var ele = result[i];
				var option = $("<option value='" + ele.name + "'>"
						+ ele.desc + "</option>");
				option.appendTo(styleList);
			}
		}
	});
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/stylelist/queryStyleList",
		dataType : "json",
		data : {
			"_site_id_param":siteSid,
			"type":2
		},
		async : false, 
		success : function(response) {
			var styleList = $(".pro_style_list");
			var result = response.list;
			styleList.html("");
			for ( var i = 0; i < result.length; i++) {
				var ele = result[i];
				var option = $("<option value='" + ele.name + "'>"
						+ ele.desc + "</option>");
				option.appendTo(styleList);
			}
		}
	});
};
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
/**
 * 配置专题活动楼层数据
 * @param id
 */
function set_topic(id){
	//initStyleList();
	userName = getCookieValue("username");
	LA.sysCode = '54';
	LA.log('toplist-set_topic', '配置专题活动', userName,  sessionId);
	topicId=id;
	$("#topic_list").hide();
	$("#topic_floor").show();
	initFloorTree();
};
/**
 * 加载活动楼层树
 */
function initFloorTree(){
	siteSid=$("#site_list").val();
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/topic/getTopicFloorTree",
		data:{
			"topicId" : topicId
		},
		dataType : "json",
		success : function(response) {
			if(response.list.length!=0){
				$('#topic_floor_tree').treeview({
					data : response.list,
					levels:1,
					expandIcon: 'glyphicon glyphicon-plus',
					collapseIcon: 'glyphicon glyphicon-minus',
					emptyIcon: 'glyphicon glyphicon-file',
					ShowToolTip:'false',
					nodeIcon: 'success',
					onNodeSelected : function(event, node) {
						topicFloorId = node.id;
						floorType = node.type;
						floorTitle = node.text;
						floorTitle = floorTitle.split('<')[1].split('>')[1];
						floorEnTitle = node.enTitle;
						floorSeq = node.seq;
						floorStyle = node.style;
						floorFlag = node.flag;
						if(node.type==1){
							productShow();
							$("#channel_tab tbody").empty();
							$("#brand_tab tbody").empty();
							$("#linkProduct_tab tbody").empty();
							$("#brand_list,#link_list,#linkProduct_list").hide();
							$("#product_list a").click();
							productList();
						}else if(node.type==2){
							productShow();
							$("#channel_tab tbody").empty();
							$("#floor_product_tab tbody").empty();
							$("#linkProduct_tab tbody").empty();
							$("#product_list,#link_list,#linkProduct_list").hide();
							$("#brand_list a").click();
							brandList();
						}else if(node.type==3){
							productShow();
							$("#channel_tab tbody").empty();
							$("#floor_product_tab tbody").empty();
							$("#brand_tab tbody").empty();
							$("#linkProduct_tab tbody").empty();
							$("#product_list,#brand_list,#linkProduct_list").hide();
							$("#link_list a").click();
							linkList();
						}else if(node.type==4){
							productShow();
							$("#channel_tab tbody").empty();
							$("#floor_product_tab tbody").empty();
							$("#brand_tab tbody").empty();
							$("#link_tab tbody").empty();
							$("#product_list,#brand_list,#link_list").hide();
							$("#linkProduct_list a").click();
							FloorlinkProductList();
						}else{
							divManagerShow();
							$("#divTitle a").click();
							initFloor(node.id);
						}
					}
				});
			}else{
				$('#topic_floor_tree').treeview({
					data : [{
						"id":0,
						"text":"该站点无楼层，右键新建楼层",
						"enTitle":"",
						"type":-1,
						"seq":"1",
						"style":"",
						"flag":1,
						"nodes":[]
					}],
					levels:1,
					expandIcon: 'glyphicon glyphicon-plus',
					collapseIcon: 'glyphicon glyphicon-minus',
					emptyIcon: 'glyphicon glyphicon-file',
					ShowToolTip:'false',
					nodeIcon: 'success',
					onNodeSelected : function(event, node) {
						topicFloorId = node.id;
						floorType = node.type;
						floorTitle = node.text;
						floorEnTitle = node.enTitle;
						floorSeq = node.seq;
						floorStyle = node.style;
						floorFlag = node.flag;
						if(node.type==1){
							productShow();
							$("#channel_tab tbody").empty();
							$("#brand_tab tbody").empty();
							$("#linkProduct_tab tbody").empty();
							$("#brand_list,#link_list,#linkProduct_list").hide();
							$("#product_list a").click();
							productList();
						}else if(node.type==2){
							productShow();
							$("#channel_tab tbody").empty();
							$("#floor_product_tab tbody").empty();
							$("#linkProduct_tab tbody").empty();
							$("#product_list,#link_list,#linkProduct_list").hide();
							$("#brand_list a").click();
							brandList();
						}else if(node.type==3){
							productShow();
							$("#channel_tab tbody").empty();
							$("#floor_product_tab tbody").empty();
							$("#brand_tab tbody").empty();
							$("#linkProduct_tab tbody").empty();
							$("#product_list,#brand_list,#linkProduct_list").hide();
							$("#link_list a").click();
							linkList();
						}else if(node.type==4){
							productShow();
							$("#channel_tab tbody").empty();
							$("#floor_product_tab tbody").empty();
							$("#brand_tab tbody").empty();
							$("#link_tab tbody").empty();
							$("#product_list,#brand_list,#link_list").hide();
							$("#linkProduct_list a").click();
							FloorlinkProductList();
						}else{
							divManagerShow();
							$("#divTitle a").click();
							initFloor(node.id);
						}
					}
				});
			}
		}
	});
	$(".table-clear tbody").html("");
	initStyleList();
};

function view_topicfloor(){
	view_topic(topicId);
};
/**
 * 添加楼层按钮
 */
function addFloor(){
	$("#addTopicFloorDIV").show();
	$(".add_topicId").val(topicId);
	$('.spinner').spinner('value', 1);
};
/**
 * 添加楼层验证条件
 */
function validSaveTopicFloor(){
	return $("#addTopicFloorForm").validate({
        onfocusout: function (element) {
            $(element).valid();
        },
        rules: {
        	title: {
        		"required": true,
        		isChineseOrEnglish: true
        	},
        	seq: {
				'required': true,
				'digits': true,
				'min': 0
			},
        	enTitle: "english"
        }
    });
};
/**
 * 保存添加的楼层
 */
function saveTopicFloor(){
	if(!validSaveTopicFloor().form()) return false;// 验证失败
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/topic_floor/addFloor",
		data: $("#addTopicFloorForm").serialize(),
		dataType : "json",
		success : function(response) {
			if(response.success == 'true'){
        		$("#addTopicFloorDIV").hide();
        		clearInput();
        		$("#success1Body").text("添加成功!");
				$("#success1").attr("style", "z-index:9999");
				$("#success1").show();
  				initFloorTree();
        	}else if(response.success == 'false'){
        		$("#addTopicFloorDIV").hide();
        		clearInput();
        		$("#warning2Body").text("添加失败!");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		}
	});
};
/**
 * 添加楼层块/块组
 */
function addFloorDIV(){
	$('#topicDivForm')[0].reset(); 
	$("#addtopicfloorDIV").show();
	$("#topic_floor_id").val(topicFloorId);
	$("#add_floorType").hide();
	$("input[name=divtype][value=0]").attr('checked',true);
	$('#addDiv_div_lcys').hide();
	$('.spinner').spinner('value', 1);
};
/**
 * 块/块组验证规则
 * @returns
 */
function validTopicDivForm(){
	return $("#topicDivForm").validate({
		onfocusout: function (element) {
			$(element).valid();
		},
		rules: {
			title: {
				"required": true,
				isChineseOrEnglish: true
			},
			seq: {
				'required': true,
				'digits': true,
				'min': 0
			}
		}
	});
};
/**
 * 保存块/块组
 */
function saveDivFrom(){
	if(!validTopicDivForm().form()) return false;
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/topic_floor/addFloor",
		data: $("#topicDivForm").serialize(),
		dataType : "json",
		success : function(response) {
			if(response.success == 'true'){
        		$("#addtopicfloorDIV").hide();
        		clearInput();
        		$("#success1Body").text("添加成功!");
				$("#success1").attr("style", "z-index:9999");
				$("#success1").show();
  				initFloorTree();
        	}else if(response.success == 'false'){
        		$("#addtopicfloorDIV").hide();
        		clearInput();
        		$("#warning2Body").text("添加失败!");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		}
	});
};
/**
 * 块组修改按钮
 * @param id
 * @param seq
 * @param flag
 */
function editFloorDiv(id,seq,flag){
	$("#renameFloorDIV").show();
	$("#renameSid").val(id);
	$("#rename_title").val($("#divTitle_"+id).text());
	$("#div_seq_rename").val(seq);
	$('.spinner').spinner('value', seq);
	if(flag==1){
		$("#edit_rename_0").attr("checked",'checked');
	}else if(flag==0){
		$("#edit_rename_1").attr("checked",'checked');
	}
};
/**
 * 修改块组验证规则
 * @returns
 */
function validRenameDivForm(){
	return $("#renameDivForm").validate({
		onfocusout: function (element) {
			$(element).valid();
		},
		rules: {
			title: {
				"required": true,
				isChineseOrEnglish: true
			},
			seq: {
				'required': true,
				'digits': true,
				'min': 0
			},
			enTitle: "english"
		}
	});
};
/**
 * 修改块组保存事件
 */
function renameTopicDiv(){
	if(!validRenameDivForm().form()) return false;
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/topic_floor/editFloor",
		data: $("#renameDivForm").serialize(),
		dataType : "json",
		success : function(response) {
			if(response.success == 'true'){
        		$("#renameFloorDIV").hide();
        		$("#success1Body").text("修改成功!");
				$("#success1").attr("style", "z-index:9999");
				$("#success1").show();
  				initFloor(topicFloorId);
        	}else if(response.success == 'false'){
        		$("#editFloor").hide();
        		$("#warning2Body").text("修改失败!");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		}
	});
};
/**
 * 修改块验证
 * @returns
 */
function validEditDivForm(){
	return $("#editDivForm").validate({
		onfocusout: function (element) {
			$(element).valid();
		},
		rules: {
			title: "required",
			seq: {
				'required': true,
				'digits': true,
				'min': 0
			},
			enTitle: "english"
		}
	});
};
/**
 * 修改块提交事件
 */
function editTopicDiv(){
	if(!validEditDivForm().form()) return false;
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/topic_floor/editFloor",
		data: $("#editDivForm").serialize(),
		dataType : "json",
		success : function(response) {
			if(response.success == 'true'){
        		$("#editFloorDIV").hide();
        		$("#success1Body").text("修改成功!");
				$("#success1").attr("style", "z-index:9999");
				$("#success1").show();
  				initFloorTree();
        	}else if(response.success == 'false'){
        		$("#editFloor").hide();
        		$("#warning2Body").text("修改失败!");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		}
	});
};
/**
 * 修改楼层验证
 * @returns
 */
function validEditTopicFloorForm(){
	return $("#editTopicFloorForm").validate({
		onfocusout: function (element) {
			$(element).valid();
		},
		rules: {
			title: {
				"required" : true,
				isChineseOrEnglish: true
			},
			seq: {
				'required': true,
				'digits': true,
				'min': 0
			},
			enTitle: "english"
		}
	});
};
/**
 * 修改楼层
 */
function editFloor(){
	if(!validEditTopicFloorForm().form()) return false;
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/topic_floor/editFloor",
		data: $("#editTopicFloorForm").serialize(),
		dataType : "json",
		success : function(response) {
			if(response.success == 'true'){
        		$("#editFloor").hide();
        		$("#success1Body").text("修改成功!");
				$("#success1").attr("style", "z-index:9999");
				$("#success1").show();
  				initFloorTree();
        	}else if(response.success == 'false'){
        		$("#editFloor").hide();
        		$("#warning2Body").text("修改失败!");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		}
	});
};
function delTreeNode(){
	bootbox.setDefaults("locale","zh_CN");
	bootbox.confirm("确定删除吗？", function(r){
		if(r){
			delId = topicFloorId;
			delDiv();
		}
	});
};
/**
 * 删除块/块组
 */
function delDiv(){
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/topic_floor/delDiv",
		data: {
			"floorId" : delId
		},
		dataType : "json",
		success : function(response) {
			if(response.success == 'true'){
				$("#success1Body").text("删除成功!");
				$("#success1").attr("style", "z-index:9999");
				$("#success1").show();
  				initFloorTree();
  				//加载块列表
  				initFloor(topicFloorId);
        	}else if(response.success == 'false'){
        		$("#addtopicfloorDIV").hide();
        		$("#warning2Body").text("删除失败!");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		}
	});
};
/**
 * 转到商品列表页面
 */
function addPro(){
	$("#addProductDIV").show();
	$("input[type='checkbox']:checked").each(function(i, team){
		$(this).click();
	});
	initProduct();
};
/**
 * 转到品牌列表页面
 */
function addFloorBrand(){
	$("#addBrandDIV").show();
	initBrand();
	$("input[type='checkbox']:checked").each(function(i, team){
		$(this).click();
	});
};
/**
 * 返回专题列表
 */
function back(){
	$("#topic_list").show();
	$("#topic_floor").hide();
};
function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
};
