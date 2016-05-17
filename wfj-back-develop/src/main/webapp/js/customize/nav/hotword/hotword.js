var hotwordPagination;

function initHotwordVar(siteId, chanelId, nodeId) {
	$("#siteId").val(siteId);
	$("#channelId").val(chanelId);
	$("#navId").val(nodeId);
	initHotwordDB();
}

$(function() {
	$("#pageSelect1").change(hotwordQuery);
});

// 查询
function query() {
	var hotword = $("#hotword_input").val();
	initHotword(hotword);
}

// 初始化外部热门搜索分页列表
function initHotword(hotword) {
	var siteid = $("#siteId").val();
	var chanelId = $("#channelId").val();
	var url = __ctxPath + "/hotword/getWordsPageList?siteId=" + siteid
			+ "&channelId=" + chanelId + "&hotword=" + hotword;
	hotwordPagination = $("#hotwordPagination").myPagination(
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
					url : url,
					dataType : 'json',
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive");
						}, 300);
					},
					callback : function(data) {
						$("#hotword_tab tbody").setTemplateElement(
								"hotword-list-s").processTemplate(data);
					}
				}
			});
}

// 初始化数据库热门搜索列表
function initHotwordDB() {
	var siteid = $("#siteId").val();
	var nodeid = $("#navId").val();
	var url = __ctxPath + "/hotword/getHotwordListFromDB?siteId=" + siteid
			+ "&navid=" + nodeid;
	hotwordPagination = $("#hotwordPagination1").myPagination(
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
					url : url,
					dataType : 'json',
					data : {
						"pageSize" : "10"
					},
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive");
						}, 300);
					},
					callback : function(data) {
						$("#hotword_tab_db tbody").setTemplateElement(
								"hotword-list-db").processTemplate(data);
					}
				}
			});
}

// <!-- 按钮事件-添加热门搜索 -->
function addHotword(siteid, channelid, navid) {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var hotwords = $(this).val();
		checkboxArray.push(hotwords);

	});
	if (checkboxArray.length==0){
		bootbox.alert({  
            buttons: {  
               ok: {  
                    label: '确定',  
                }  
            },  
            message: "请至少选择一个关键词!",  
            title: "温馨提示!",  
        });
		 return false;
	}

	var value = "";
	for (i = 0; i < checkboxArray.length; i++) {
		value += checkboxArray[i] + ",";
	}

	
	$.ajax({
		type : "post",
		url : __ctxPath + "/hotword/addHotword",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		dataType : "json",
		data : {
			"siteId" : siteId,
			"channelId" : channelId,
			"navid" : nodeId,
			"hotwords" : value,
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
			if (response.success == 'true') {
				$("input[type='checkbox']:checked").each(
						function(i, team) {
							$(this).removeAttr("checked");
						});
				$("#addHotwordDIV").hide();

				$("#success1Body").text("添加成功!");
				$("#success1").attr("style", "z-index:9999");
				$("#success1").show();

				initHotwordDB();
			} else {
				$("#warning2Body").text("添加失败!");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		}
	});
};

function hotwordQuery() {
	var params = $("#product_form1").serialize();
	params = decodeURI(params);
	hotwordPagination.onLoad(params);
}

// 删除热门搜索
function deleteHotWord() {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var sids = $(this).val();
		checkboxArray.push(sids);

	});
	if (checkboxArray.length == 0) {
		$("#warning2Body").text("请选择要删除的列!");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
		return false;
	}
	bootbox.setDefaults("locale","zh_CN");
	bootbox.confirm("确定删除吗？", function(r){
		if(r){
			var value = "";
			for (i = 0; i < checkboxArray.length; i++) {
				value += checkboxArray[i] + ",";
			}
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/hotword/delHotword",
				dataType : "json",
				data : {
					"sid" : value
				},
				ajaxStart : function() {
					$("#loading-container").attr("class", "loading-container");
				},
				ajaxStop : function() {
					// 隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive");
					}, 300);
				},
				success : function(response) {
					if (response.success == "true") {
						$("#success1Body").text("删除成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
						initHotwordDB();
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
	
}

/**
 * 显示热门搜索添加列表页面
 */ 
function addHotwordDiv() {
	$("#addHotwordDIV").show();
	$("input[type='checkbox']:checked").each(function(i, team) {
		$(this).click();
	});
	initHotword('');
}