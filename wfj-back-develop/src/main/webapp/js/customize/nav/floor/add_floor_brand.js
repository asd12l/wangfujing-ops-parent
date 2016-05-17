var brandPagination;
	 $(function() {
		 $("#brand_pageSelect").change(brandQuery);
	   // initBrand();
	});
	function brandQuery(){
		var params = $("#brand_form").serialize();
		params = decodeURI(params);
		brandPagination.onLoad(params);
	}
	function olvQuery(){
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
	function resetBrand() {
		$("#brandName_input").val("");
		$("#orderNo_input").val("");
		olvQuery();
	}
	//初始化品牌列表
 	function initBrand() {
 		var brandSids = new Array();
 		if($("td[name=brandSid]").length!=0){
 			$("td[name=brandSid]").each(function(i, team){
 				brandSids.push($(this).text().trim());
 			});
 		}else{
 			brandSids.push(0);
 		}
		var brandName="";
		var url = __ctxPath+"/web/addBrandList";
		brandPagination = $("#brandPagination").myPagination({
           panel: {
             tipInfo_on: true,
             tipInfo: '&nbsp;&nbsp;跳{input}/{sumPage}页',
             tipInfo_css: {
               width: '25px',
               height: "20px",
               border: "2px solid #f0f0f0",
               padding: "0 0 0 5px",
               margin: "0 5px 0 5px",
               color: "#48b9ef"
             }
           },
           debug: false,
           ajax: {
             on: true,
             url: url,
             dataType: 'json',
             param: 'brandSids='+brandSids,
             ajaxStart: function() {
					$("#loading-container").attr("class","loading-container");
				},
				ajaxStop: function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive")
					},300);
				},
             callback: function(data) {
               //使用模板
               $("#floor_brand_tab tbody").setTemplateElement("floor_brand-list").processTemplate(data);
             }
           }
         });
    }
	//按钮事件-添加品牌
	function addDivBrand(){
		var checkboxArray=[];
		$("input[type='checkbox']:checked").each(function(i, team){
			var brandSid = $(this).val();
			checkboxArray.push(brandSid);
		});
		if (checkboxArray.length==0){
			bootbox.alert({  
	            buttons: {  
	               ok: {  
	                    label: '确定',  
	                }  
	            },  
	            message: "请选取要查看的列!",  
	            title: "温馨提示!",  
	        });
			 return false;
		}
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定添加此品牌吗？", function(r){
			if(r){
				var value="";
				var brandNames="";
				var brandLinks="";
				var picts="";
				for(i=0;i<checkboxArray.length;i++){
					value += checkboxArray[i]+",";
					brandNames+=$("#brandName_"+checkboxArray[i]).text()+",";
					brandLinks+=$("#brandUrl_"+checkboxArray[i]).val()+",";
					if($("#brandPict_"+checkboxArray[i]).val()==""){
						picts+=" ,";
						
					}else{
						picts+=$("#brandPict_"+checkboxArray[i]).val()+",";
					}
				}

				if(pageLayoutSid!=""){
					$.ajax({
				        type:"post",
				        url: __ctxPath+"/web/addBrand",
				        contentType: "application/x-www-form-urlencoded;charset=utf-8",
				        dataType: "json",
				        data:{
				        	"ids" : value,
				        	"pageLayoutSid" : pageLayoutSid,
				        	"names" : brandNames,
				        	"brandLinks" : brandLinks,
				        	"picts" : picts
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
				        		$("#addBrandDIV").hide();
				        		$("#brandName_input").val("");
				        		$("#orderNo_input").val("");
								$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
									"<strong>添加成功，返回列表页!</strong></div>");
			  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			  	  				brandList();
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
							}
			        	}
					});
				}
				if(nodeId!=""){
					$.ajax({
				        type:"post",
				        url: __ctxPath+"/hootBrand/saveBrand",
				        contentType: "application/x-www-form-urlencoded;charset=utf-8",
				        dataType: "json",
				        data:{
				        	"ids" : value,
				        	"navSid" : nodeId,
				        	"names" : brandNames,
				        	"brandLink" : brandLinks,
				        	"picts" : picts
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
				        		$("#addBrandDIV").hide();
				        		$("#brandName_input").val("");
				        		$("#orderNo_input").val("");
								$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
									"<strong>添加成功，返回列表页!</strong></div>");
			  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			  	  			    initHootBrand();
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
							}
			        	}
					});
				}
				
			}
		});
	}
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
		//$("#pageBody").load( __ctxPath+"/jsp/nav/GetChannelTree.jsp");
	}
	
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
			}
		}
	}
