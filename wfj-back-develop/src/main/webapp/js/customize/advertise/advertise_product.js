

function setAdvertisingProduct(advertisingId){
	userName = getCookieValue("username");
	LA.sysCode = '54';
	LA.log('adcertise-setAdvertisingProduct', '配置商品', userName,  sessionId);
	$("#advertising_list").hide();
	$("#advertise_product").show();
	$("#advertise_id_hide").val(advertisingId);
	loadAdvertisProduct(advertisingId);
}
function loadAdvertisProduct(advertisingId){
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/adverties/getProductList",
		data:{
			"advertisingId" : advertisingId
		},
		dataType : "json",
		success : function(response) {
			$("#adver_product_tab tbody").setTemplateElement(
			"adver_product-list").processTemplate(response);
		}
	});
}

function addPro(){
	$("#addProductDIV").show();
	initProduct();
}

//广告中删除商品
function delPro(){
	var checkboxArray = [];
	var sid;
	$("input[type='checkbox']:checked").each(function(i, team) {
		var proSid = $(this).val();
		sid=proSid;
		checkboxArray.push(proSid);
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
	var advertisingId = $("#advertise_id_hide").val();
	bootbox.setDefaults("locale","zh_CN");
	bootbox.confirm("确定删除吗？", function(r){
		if(r){
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/adverties/delProduct",
				dataType : "json",
				data : {
					"sid" : value,
					"advertisingId" : advertisingId
				},
				ajaxStart : function() {
//					$("#loading-container").attr("class",
//							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
//					setTimeout(function() {
//						$("#loading-container")
//								.addClass("loading-inactive")
//					}, 300);
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
						loadAdvertisProduct(advertisingId);
					} else {
						$("#model-body-warning")
								.html(
										"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
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
function back(){
	$("#advertising_list").show();
	$("#advertise_product").hide();
}
function successBtn(){
	$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
}