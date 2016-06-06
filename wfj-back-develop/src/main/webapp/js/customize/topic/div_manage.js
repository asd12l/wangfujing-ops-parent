$(function (){
	validform();
	validform2();
	validFloorLinkProductform();
	validEditFloorLinkProductForm();
});

function divManagerShow(){
		$("#divTitle").show();
		$("#product_list,#brand_list,#link_list").hide();
		$("#divTitle").click();
	}
	function productShow(){
		$("#divTitle").hide();
		$("#product_list,#brand_list,#link_list").show();
		$("#product_list").click();
	}
	/**
	 * 楼层信息初始化
	 * @param floorId
	 */
	function initFloor(floorId) {
		if(floorId==0||floorId==null){
			floorId=topicId;
		}
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
				url : __ctxPath + "/topic_floor/queryDivList?topicId="
						+ topicId+"&floorId="+floorId,
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
					$("#channel_tab tbody").empty();
					//使用模板
					$("#channel_tab tbody").setTemplateElement(
							"floor-list")
							.processTemplate(data);
				}
			}
		});
	}
	//修改楼层/块
	function editDiv(){
		if(floorType==-1){
			$("#editFloor").show();
			$(".floor-title").val("修改楼层");
			$("#floor_id_edit").val(topicFloorId);
			$("#floor_title_edit").val(floorTitle);
			$("#floor_en_title_edit").val(floorEnTitle);
			$("#topic_floor_seq").val(floorSeq);
			$(".topic_floor_style").show();
			$("#floor_style_edit").val(floorStyle);
			if(floorFlag==1){
				$("#edit_tfloorFlag_0").attr('checked','checked');
			}else if(floorFlag==0){
				$("#edit_tfloorFlag_1").attr("checked",'checked');
			}
		}else if(floorType==0){
			$("#editFloor").show();
			$(".floor-title").val("修改块组");
			$("#floor_id_edit").val(topicFloorId);
			$("#floor_title_edit").val(floorTitle);
			$("#floor_en_title_edit").val(floorEnTitle);
			$("#topic_floor_seq").val(floorSeq);
			$(".topic_floor_style").hide();
			if(floorFlag==1){
				$("#edit_tfloorFlag_0").attr("checked",'checked');
			}else{
				$("#edit_tfloorFlag_1").attr("checked",'checked');
			}
		}else{
			$("#editFloorDIV").show();
			$("#divSid").val(topicFloorId);
			$("#div_title").val(floorTitle);
			$("#div_en_title").val(floorEnTitle);
			$("#edit_div_style_list").val(floorStyle);
			//多选框编辑
			if(floorType==1){
				$("#divType_edit_0").attr("checked",'checked');
			}else if(floorType==2){
				$("#divType_edit_1").attr("checked",'checked');
			}else if(floorType==3){
				$("#divType_edit_2").attr("checked",'checked');
			}
			if(floorFlag==1){
				$("#edit_divFlag_0").attr("checked",'checked');
			}else if(floorFlag==0){
				$("#edit_divFlag_1").attr("checked",'checked');
			}
		}
		$('.spinner').spinner('value', floorSeq);
	}
	
	//楼层下商品列表
	function productList(){
		
		 $.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/topic_floor/productList",
			dataType : "json",
			data : {
				"floorId" : topicFloorId
			},
			success : function(data) {
				//使用模板
				$("#floor_product_tab tbody").setTemplateElement(
						"floor_product-list")
						.processTemplate(data);
			}
		}); 
	}
	//楼层块中删除商品
	function delPro(){
		var checkboxArray = [];
		var sid;
		$("input[type='checkbox'][ref='productlist']:checked").each(function(i, team) {
			var proSid = $(this).val();
			sid=proSid;
			checkboxArray.push(proSid);
		});
		if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要删除的列!");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		var value="";
		for(i=0;i<checkboxArray.length;i++){
			value+=checkboxArray[i];
			if(i<checkboxArray.length-1){
				value+=",";
			}
		}
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/topic_floor/delProduct",
					dataType : "json",
					data : {
						"sid" : value,
						"floorId" : topicFloorId
					},
					success : function(response) {
						if (response.success == "true") {
							$("#success1Body").text("删除成功!");
							$("#success1").attr("style", "z-index:9999");
							$("#success1").show();
							productList();
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
	 * 删除块下的品牌
	 * @returns {Boolean}
	 */
	function delBrand(){
		var checkboxArray = [];
		var sid;
		$("input[type='checkbox'][ref='brandlist']:checked").each(function(i, team) {
			var brandSid = $(this).val();
			sid=brandSid;
			checkboxArray.push(brandSid);
		});
		if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要删除的列!");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		var value="";
		for(i=0;i<checkboxArray.length;i++){
			value+=checkboxArray[i];
			if(i<checkboxArray.length-1){
				value+=",";
			}
		}
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/topic_floor/delBrand",
					dataType : "json",
					data : {
						"sid" : value,
						"floorId" : topicFloorId
					},
					success : function(response) {
						if (response.success == "true") {
							$("#success1Body").text("删除成功!");
							$("#success1").attr("style", "z-index:9999");
							$("#success1").show();
							brandList();
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
	 * 楼层下品牌列表
	 */
	function brandList(){
		 $.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/topic_floor/brandList",
			dataType : "json",
			data : {
				"floorId" : topicFloorId
			},
			success : function(data) {
				//使用模板
				$("#brand_tab tbody").setTemplateElement(
						"brand-list")
						.processTemplate(data);
			}
		}); 
	}
	/**
	 * 楼层下引导链接列表
	 */
	function linkList(){
		 $.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/topic_floor/linkList",
			dataType : "json",
			data : {
				"floorId" : topicFloorId
			},
			success : function(data) {
				//使用模板
				$("#link_tab tbody").setTemplateElement(
						"link-list")
						.processTemplate(data);
			}
		}); 
	};
	/**
	 * 楼层链接商品列表
	 */
	function FloorlinkProductList(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/topic_floor/linkList",
			dataType : "json",
			data : {
				"floorId" : topicFloorId
			},
			success : function(data) {
				//使用模板
				$("#linkProduct_tab tbody").setTemplateElement("linkProduct-list").processTemplate(data);
			}
		}); 
	};
	
	function validform() {	
		return $("#addLinkForm").validate({
			onfocusout: function(element){
				        $(element).valid();
				    },
			rules: {
			   mainTitle : "required",
			   link : {
					required : true,
					url : true
				},
				seq: {
					'required': true,
					'digits': true,
					'min': 0
				},
				pict : 'url'
			}
		});
	};
	/**
	 * 验证链接商品
	 * @returns
	 */
	function validFloorLinkProductform() {	
		return $("#addFloorLinkProductForm").validate({
			onfocusout: function(element){
				$(element).valid();
			},
			rules: {
				link : {
					required : true,
					url : true
				},
				seq: {
					'required': true,
					'digits': true,
					'min': 0
				},
				pict : 'url'
			}
		});
	};
	/**
	 * 修改链接商品验证
	 * @returns
	 */
	function validEditFloorLinkProductForm() {	
		return $("#editFloorLinkProductForm").validate({
			onfocusout: function(element){
				$(element).valid();
			},
			rules: {
				link : {
					required : true,
					url : true
				},
				seq: {
					'required': true,
					'digits': true,
					'min': 0
				},
				pict : 'url'
			}
		});
	};
	function validform2() {	
		return $("#editLinkForm").validate({
			onfocusout: function(element){
				        $(element).valid();
				    },
			rules: {
			   mainTitle : "required",
			   link : {
					required : true,
					url : true
				},
				seq: {
					'required': true,
					'digits': true,
					'min': 0
				},
				pict : 'url'
			}
		});
	};
	/**
	 * 添加引导链接
	 */
	function addLink(){
		$('#addLinkForm')[0].reset()
		$("#addLinkDIV").show();
		$("#topicFloor_link").val(topicFloorId);
		$('.spinner').spinner('value', 1);
		$("#msg3").addClass("hide");
	};
	/**
	 * 链接商品添加按钮
	 */
	function addLinkProduct(){
		$('#addFloorLinkProductForm')[0].reset()
		$("#addFloorLinkProductDIV").show();
		$("#topicFloor_linkProduct").val(topicFloorId);
		$("#input_img5").val();
		$("#msg5").html("");
		$("#addFLP_seq_DIV").hide();
	};
	/**
	 * 保存引导链接
	 */
	function addLinkForm(){
		if(validform().form()) {
	  		$.ajax({
		        type:"post",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        dataType: "json",
		        url: __ctxPath + "/topic_floor/addLink",
		        data: $("#addLinkForm").serialize(),
		        success: function(response) {
		        	if(response.success == 'true'){
		        		$("#addLinkDIV").hide();
		        		clearInput();
		        		$("#success1Body").text("添加成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
		     	  		linkList();
					}else{
						$("#addLinkDIV").hide();
						clearInput();
						$("#warning2Body").text("添加失败!");
						$("#warning2").attr("style", "z-index:9999");
						$("#warning2").show();
					}
		        	clearDivForm();
	        	}
			});
		}
	};
	/**
	 * 保存商品链接
	 */
	function addLinkProductForm(){
		if(validFloorLinkProductform().form()) {
			$.ajax({
				type:"post",
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				dataType: "json",
				url: __ctxPath + "/topic_floor/addLink",
				data: $("#addFloorLinkProductForm").serialize(),
				success: function(response) {
					if(response.success == 'true'){
						$("#addFloorLinkProductDIV").hide();
						clearInput();
						$("#success1Body").text("添加成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
						FloorlinkProductList();
					}else{
						$("#addFloorLinkProductDIV").hide();
						clearInput();
						$("#warning2Body").text("添加失败!");
						$("#warning2").attr("style", "z-index:9999");
						$("#warning2").show();
					}
					clearDivForm();
				}
			});
		}
	};
	
	/**
	 * 修改引导链接
	 * @returns {Boolean}
	 */
	function editLink(){
		$('#editLinkForm')[0].reset()
		var checkboxArray = [];
		$("input[type='checkbox'][ref='linklist']:checked").each(function(i, team) {
			var linkSid = $(this).val();
			checkboxArray.push(linkSid);
		});
		console.log(checkboxArray);
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
		$("#editLinkDIV").show();
		var value=checkboxArray[0];
		$("input[ref='linkSid_edit']").val(value);
		$("#linkSid_edit").val(value);
		$("#mainTitle").val($("#linkMainTitle_" + value).text().trim());
		$("#subTitle").val($("#linkSubTitle_" + value).text().trim());
		var titleImg_ = $("#linkPicUrl_" + value).text().trim();
		$("#input_img4").val($("#linkPic_" + value).text());
		if(titleImg_!=''){
			$("#msg4").removeClass("hide");
			$("#msg4").html("<img width='100' height='100' src='"+titleImg_+"' />");
		}else{
			$("#msg4").addClass("hide");
			$("#msg4").html("");
		}
		$("#link_").val($("#link_" + value).text().trim());
		$("#seq_").val($("#seq_" + value).text().trim());
		
		var flag=$("#flag_" + value).val().trim();
		if(flag==1){
			$("#edit_isShow_0").attr("checked",'checked');
		}else if(flag==0){
			$("#edit_isShow_1").attr("checked",'checked');
		}
	}
	/**
	 * 修改引导链接form提交
	 */
	function editLinkForm(){
		var divTitle=$("#divTitle").val();
		if(validform2().form()) {
			console.log($("#editLinkForm").serialize());
			$.ajax({
		        type:"post",
		        dataType: "json",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        url:__ctxPath + "/topic_floor/editLink",
		        data: $("#editLinkForm").serialize(),
		        success:function(response) {
		        	if(response.success == 'true'){
		        		$("#editLinkDIV").hide();
		        		$("#success1Body").text("修改成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
						linkList();
		        	}else{
		        		bootbox.alert({  
		    	            buttons: {  
		    	               ok: {  
		    	                    label: '确定',  
		    	                }  
		    	            },  
		    	            message: "修改失败!",  
		    	            title: "温馨提示!",  
		    	        });
					}
		    	}
			});
		}
	};
	/**
	 * 修改链接商品
	 * @returns {Boolean}
	 */
	function editLinkProduct(){
		$('#editFloorLinkProductForm')[0].reset()
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var linkSid = $(this).val();
			checkboxArray.push(linkSid);
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
		$("#editFloorLinkProductDIV").show();
		var value=checkboxArray[0];
		$("#editFLP_seq_DIV").hide();
		$("#linkSid_edit").val(value);
		$("#editFLP_mainTitle").val($("#linkMainTitle_" + value).text().trim());
		$("#editFLP_subTitle").val($("#linkSubTitle_" + value).text().trim());
		var titleImg_ = $("#linkPic_" + value).text().trim().split("com")[1];
		$("#input_img6").val(titleImg_);
		if(titleImg_!=''){
			$("#msg6").removeClass("hide");
			$("#msg6").html("<img width='100' height='100' src='"+cmsImageServer+titleImg_+"' />");
		
		}else{
			$("#msg6").addClass("hide");
			$("#msg6").html("");
		}
		$("#editFLP_link").val($("#link_" + value).text().trim());
		$("#editFLP_seq").val($("#seq_" + value).text().trim());
		
		var flag=$("#flag_" + value).text().trim();
		if(flag==0){
			$("#editFLP_isShow_0").attr("checked",'checked');
		}else{
			$("#editFLP_isShow_1").attr("checked",'checked');
		}
	}
	/**
	 * 修改链接商品form提交
	 */
	function editFloorLinkProductForm(){
		if(validEditFloorLinkProductForm().form()) {
			$.ajax({
		        type:"post",
		        dataType: "json",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        url:__ctxPath + "/topic_floor/editLink",
		        data: $("#editFloorLinkProductForm").serialize(),
		        success:function(response) {
		        	if(response.success == 'true'){
		        		$("#editFloorProductLinkDIV").hide();
		        		$("#success1Body").text("修改成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
						FloorlinkProductList();
		        	}else{
		        		bootbox.alert({  
		    	            buttons: {  
		    	               ok: {  
		    	                    label: '确定',  
		    	                }  
		    	            },  
		    	            message: "修改失败!",  
		    	            title: "温馨提示!",  
		    	        });
					}
		    	}
			});
		}
	};
	/**
	 * 删除引导链接
	 * @returns {Boolean}
	 */
	function delLink(){
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var linkSid = $(this).val();
			checkboxArray.push(linkSid);
		});
		if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要删除的列!");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
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
					url : __ctxPath + "/topic_floor/delLink",
					dataType : "json",
					data : {
						"sid" : value
					},
					success : function(response) {
						if (response.success == "true") {
							$("#success1Body").text("删除成功!");
							$("#success1").attr("style", "z-index:9999");
							$("#success1").show();
							linkList();
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
	 * 删除链接商品
	 * @returns {Boolean}
	 */
	function delLinkProduct(){
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var linkSid = $(this).val();
			checkboxArray.push(linkSid);
		});
		if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选择要删除的列!");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
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
					url : __ctxPath + "/topic_floor/delLink",
					dataType : "json",
					data : {
						"sid" : value
					},
					success : function(response) {
						if (response.success == "true") {
							$("#success1Body").text("删除成功!");
							$("#success1").attr("style", "z-index:9999");
							$("#success1").show();
							FloorlinkProductList();
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
	 * 删除块/块组
	 * @param id
	 */
	function delFloorDiv(id){
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				delId=id;
				delDiv();
			}
		});
	};