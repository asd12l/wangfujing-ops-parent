	var productPagination;
	$(function() {
		// initProduct(); 禁用: 防止频道页打开就加载
		$("#proType_select").change(productQuery);
		$("#pro_pageSelect").change(productQuery);
	});
	
	function getShoppeCode(){
		var shopCode=$('#shopCode_select option:selected').attr("id");
		//获取门店下所有专柜
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/web/getShoppeCode",
			dataType : "json",
			data : {"shopCode":shopCode},
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
				var productShoppeCode=$(".shoppeCode_select");
				productShoppeCode.html("");
				var option1 = $("<option value=''>全部</option>");
				option1.appendTo(productShoppeCode);
				for(i=0;i<response.data.length;i++){
					var opt=$('<option id='+response.data[i].shoppeCode+' value='+response.data[i].shoppeCode+'>'+response.data[i].shoppeName+'</option>');
					$("#shoppeCode_select").append(opt);
				}
			}
		});
	};
	
	function productQuery() {
		$("#skuCode_from").val($("#skuCode_input").val());
		$("#skuName_from").val($("#skuName_input").val());
		$("#proType_from").val($("#proType_select").val());
		$("#shopCode_from").val($("#shopCode_select").val());
		$("#shoppeCode_from").val($("#shoppeCode_select").val());
		$("#cateZSCode_from").val($("#cateZSCode_input").val());
		$("#cateZSName_from").val($("#cateZSName_input").val());
		var proSids = new Array();
		if($("td[name=proSid]").length !=0){
			$("td[name=proSid]").each(function(i, team){
				proSids.push($(this).text().trim());
			});
		}else{
			proSids.push(0);
		}
		$("#proSids_from").val(proSids);
		var params = $("#floor_product_form").serialize();
		params = decodeURI(params);
		productPagination.onLoad(params);
	}
	// 查询
	function queryPro() {
		productQuery();
	}
	// 重置
	function resetProduct(){
		$("#skuCode_input").val("");
		$("#skuName_input").val("");
		$("#proType_select").val("");
		$("#shopCode_from").val("");
		$("#shoppeCode_from").val("");
		$("#categorySid_from").val("");
		$("#proSids_from").val("");
		productQuery();
	}
	//初始化商品列表
	function initProduct() {
		var proSids = new Array();
		if($("td[name=proSid]").length !=0){
			$("td[name=proSid]").each(function(i, team){
				proSids.push($(this).text().trim());
			});
		}else{
			proSids.push(0);
		}
		var url = __ctxPath + "/web/selectAllProduct";
		productPagination = $("#productPagination").myPagination(
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
						param: "proSids="+proSids.toString(),
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
							$("#product_tab tbody").setTemplateElement(
									"product-list").processTemplate(data);
						}
					}
				});
	}
//<!-- 按钮事件-添加商品 -->
	function addProduct() {
				var checkboxArray=[];
				$("input[type='checkbox']:checked").each(function(i, team){
					var productSid = $(this).val();
					checkboxArray.push(productSid);
					
				});
				if (checkboxArray.length==0){
					bootbox.alert({  
			            buttons: {  
			               ok: {  
			                    label: '确定',  
			                }  
			            },  
			            message: "请至少选择一个商品!",  
			            title: "温馨提示!",  
			        });
					 return false;
				}
				bootbox.setDefaults("locale","zh_CN");		
		bootbox.confirm("确定添加商品吗？", function(r){
			if(r){
				var value="";
				var name = "";
				var price = "";
				var pict = "";
				var brandName = "";
				for(i=0;i<checkboxArray.length;i++){
					value+=$("#proSkuCode_"+checkboxArray[i]).text()+",";
					name+=$("#name_"+checkboxArray[i]).text()+",";
					price+=$("#salePrice_"+checkboxArray[i]).text()+",";
					if($("#primaryImgUrl_"+checkboxArray[i]).text()==""){
						pict+=" ,";
						
					}else{
						pict+=$("#primaryImgUrl_"+checkboxArray[i]).text()+",";
					}
					if($("#brandGroupName_"+checkboxArray[i]).text()==""){
						brandName+=" ,";
						
					}else{
						brandName+=$("#brandGroupName_"+checkboxArray[i]).text()+",";
					}
				}
				var pageLayoutSid=$("#pageLayoutSid_").val().trim();
				$.ajax({
			        type:"post",
			        url: __ctxPath+"/web/addProduct",
			        contentType: "application/x-www-form-urlencoded;charset=utf-8",
			        dataType: "json",
			        data:{
			        	"ids":value,
			        	"pageLayoutSid":pageLayoutSid,
			        	"name":name,
			        	"prices":price,
			        	"picts":pict,
			        	"brandNames" : brandName
			        },
			        ajaxStart: function() {
				       	 $("#loading-container").attr("class","loading-container");
				        },
			        ajaxStop: function() {
			          //隐藏加载提示
			          setTimeout(function() {
			       	        $("#loading-container").addClass("loading-inactive")
			       	 },300);
			        },
			        success: function(response) {
			        	if(response.success == 'true'){
			        		$("input[type='checkbox']:checked").each(function(i, team){
								$(this).removeAttr("checked");
							});
			        		$("#addProductDIV").hide();
			        		$("#skuCode_input").val("");
			        		$("#skuName_input").val("");
			        		$("#proType_select").val("");
			        		$("#shopCode_from").val("");
			        		$("#shoppeCode_from").val("");
			        		$("#categorySid_from").val("");
			        		
							$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
								"<strong>添加成功，返回列表页!</strong></div>");
		  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
		  	  				productList();
			        	}else{
			        		bootbox.alert({  
					            buttons: {  
					               ok: {  
					                    label: '确定',  
					                }  
					            },  
					            message: "添加失败!",  
					            title: "温馨提示!",  
					        });
//							$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败！</strong></div>");
//		 	     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
						}
		        	}
				});
			}
		});
	}
//<!-- 按钮事件-查询商品详情 -->
	function getProduct() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一列!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要查看的列!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		var url = __ctxPath + "/product/getProductDetail/" + value;
		$("#pageBody").load(url);
	}

	var productChangePropId = "";
	var category_Sid = "";
	var category_Name = "";
	var spuSid = "";
//<!-- 操作 -->
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
	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
	}
//<!-- 点击编码或者名称查询详情 -->
	function getView(data) {
		var url = __ctxPath + "/product/getProductDetail/" + data;
		$("#pageBody").load(url);
	}
