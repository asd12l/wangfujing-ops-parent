var brandPagination;
$(function() {
	$("#brand_pageSelect").change(olvQuery);
});
function resetBrand() {
	$("#brandName_input").val("");
	$("#orderNo_input").val("");
	olvQuery();
}
function olvQuery() {
	$("#brandName_from").val($("#brandName_input").val());
	$("#brandNo_from").val($("#orderNo_input").val());
	var brandSids = new Array();
	if($("td[name=brandSid]").length!=0){
		$("td[name=brandSid]").each(function(i, team){
			brandSids.push($(this).text().trim());
		});
	}else{
		brandSids.push(0);
	}
	$("#brandSids_form").val(brandSids);
	var params = $("#brand_form").serialize();
	params = decodeURI(params);
	brandPagination.onLoad(params);
}
// 初始化品牌列表
function initBrand() {
	var brandSids = new Array();
	if($("td[name=brandSid]").length!=0){
		$("td[name=brandSid]").each(function(i, team){
			brandSids.push($(this).text().trim());
		});
	}else{
		brandSids.push(0);
	}
	var brandName = "";
	var url = __ctxPath + "/web/addBrandList";
	brandPagination = $("#brandPagination").myPagination(
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
			param : 'brandSids='+brandSids,
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
			callback : function(data) {
				// 使用模板
				$("#floor_brand_tab tbody").setTemplateElement(
						"floor_brand-list").processTemplate(data);
			}
		}
	});
};
// 按钮事件-添加品牌
function addDivBrand() {
	var checkboxArray = [];
	$("input[type='checkbox']:checked").each(function(i, team) {
		var brandSid = $(this).val();
		checkboxArray.push(brandSid);
	});
	if (checkboxArray.length == 0) {
		bootbox.alert({  
            buttons: {  
               ok: {  
                    label: '确定',  
                }  
            },  
            message: "请选取要添加的列!",  
            title: "温馨提示!",  
        });
		return false;
	}
	bootbox.confirm(
		"确定添加此品牌吗？",
		function(r) {
			if (r) {
				var value = "";
			var names = "";
			var brandLinks = "";
			var picts = "";
			for (i = 0; i < checkboxArray.length; i++) {
				value += checkboxArray[i] + ",";
				names += $("#brandName_"+checkboxArray[i]).text()+",";
				brandLinks+=$("#brandUrl_"+checkboxArray[i]).val()+",";
				
				if($("#brandPict_"+checkboxArray[i]).val()==""){
					picts+=" ,";
				}else{
					picts+=$("#brandPict_"+checkboxArray[i]).val()+",";
				}
			}
			$.ajax({
				type : "post",
				url : __ctxPath
						+ "/topic_floor/addBrand",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				dataType : "json",
				data : {
					"ids" : value,
					"floorId" : topicFloorId,
					"names" : names,
					"brandLinks" : brandLinks,
		        	"picts" : picts
				},
				success : function(response) {
					if (response.success == 'true') {
						$("input[type='checkbox']:checked").each(function(i,team) {
							$(this).removeAttr("checked");
						});
						$("#addBrandDIV").hide();
						$("#success1Body").text("添加成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
						brandList();
					} else {
						bootbox.alert({  
				            buttons: {  
				               ok: {  
				                    label: '确定',  
				                }  
				            },  
				            message: "添加失败!",  
				            title: "温馨提示!",  
				        });
					}
				}
			});
		}
	});
}
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

function tab(data) {
	if (data == 'pro') {// 基本
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