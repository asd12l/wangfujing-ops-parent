    var tree = [];
	var resourcePagination;
	var nodeId = "";
	var nodeType = "";
	var nodeName = "";
	var rcNodeId = "";
	var siteId="";
	
	//ajax全局设置
	$(document).ajaxStart(function(){
		$("#loading-container").attr("class","loading-container");
    })
    $(document).ajaxStop(function(){
    	//隐藏加载提示
		setTimeout(function() {
			$("#loading-container").addClass("loading-inactive")
		},300);
    })
    
	//关闭弹窗
	function closeDiv(obj) {
	    clearInput();
	    $(".modal-darkorange").hide();
	}
	
	// 弹出框弹出前清空
	function clearDivForm() {
	    $("form input[text]").val("");
	}
	function clearInput() {
	    $(".clear_input").val("");
	}

	
	$(function() {
		$("#close").click(function(){
			$("#pageBody").load(__ctxPath+"/jsp/web/template/templateList.jsp");
		});
		initSiteSelect();
	});	
	
	
	//初始化站点选择列表
	function initSiteSelect() {
		var url = __ctxPath + "/site/getSiteList";
		propsdictPagination = $("#propsdictPagination").myPagination(
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
						async:false,  
						dataType : 'json',
						callback : function(data) {
							$("#site_list").html("");
							for(i=0;i<data.list.length;i++){
								if(_site_id_param==''){
									var opt=$('<option code='+data.list[i].channelCode+' data='+data.list[i].domain+' value='+data.list[i].id+'>'+data.list[i].name+'</option>');
									$("#site_list").append(opt);
								}else{
									if(_site_id_param==data.list[i].id){
										var opt=$('<option selected="selected" code='+data.list[i].channelCode+' data='+data.list[i].domain+' value='+data.list[i].id+'>'+data.list[i].name+'</option>');
										$("#site_list").append(opt);
									}else{
										var opt=$('<option code='+data.list[i].channelCode+' data='+data.list[i].domain+' value='+data.list[i].id+'>'+data.list[i].name+'</option>');
										$("#site_list").append(opt);
									}
								}
							}
							if(_site_id_param==''){
								siteSid=$("#site_list").val();
							}else{
								siteSid = _site_id_param;
							}
							_site_id_param = "";
							siteName=$('#site_list  option:selected').attr("data");
							channelCode=$('#site_list  option:selected').attr("code");
							$("#channelCode_from").val(channelCode);
							initTree();
						}
					}
				});
	}
	
	//更改站点
	$("#site_list").change(function(){
		siteSid=$("#site_list").val();
		siteName=$('#site_list  option:selected').attr("data");
		//初始化目录树
		initTree();
		//初始化目录列表
		initDirList("");
		//充值上传目录
		$("#desFile1").val("");
		
	});

	
	//初始化文件目录
	function initTree(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/template/getTemplateTree",
			dataType : "json",	
			data:{
				"_site_id_param":siteSid
			},
			ajaxStart : function() {
				$(".loading-container").attr("class",
						"loading-container");
			},
			success : function(response) {
				//隐藏加载提示
				$(".loading-container").addClass(
						"loading-inactive");
				$('#tree').treeview({
					levels:1,
					expandIcon: 'glyphicon glyphicon-plus',
					collapseIcon: 'glyphicon glyphicon-minus',
					emptyIcon: 'glyphicon glyphicon-file',
					nodeIcon: 'success',
					data : response.list,
					onNodeSelected : function(event, node) {
						initDirList(node.id);
						nodeId = node.id;
						nodeType = node.type;
						nodeName = node.text;
						$("#select_path").val(node.id);
						$("#desFile1").val(node.id);
					}
				});
				
			}
		});
	}
	
	//加载目录列表
	function initDirList(path){
	var	siteId = $("#site_list").val();
		templatePagination = $("#templatePagination").myPagination(
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
				url : __ctxPath + "/template/queryDirList?path="
						+ path+"&_site_id_param=" + siteId,
				dataType : 'json',
/*				ajaxStart : function() {
					$(".loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					$(".loading-container").addClass(
							"loading-inactive");
				},*/
				callback : function(data) {
					//使用模板
					$("#file_tab tbody").setTemplateElement(
							"dir-list")
							.processTemplate(data);
					
				}
			}
		});
	}
	
	//弹出上传文件框
	function toUploadFile(){
		$("#msg1 img").remove();			
		var dpath = $("#desFile1").val();
		if(dpath==""){
			$("#warning2Body").text("请选择左侧模板目录上传!");
			$("#warning2").show();
			return false;
		}		
		$("#uploadFile").show();	
	}
	
	//模板图片上传
  	function upLoadImg(param){
  		imgPath=$("#desFile1").val();
  		$("#msg"+param).addClass('hide');
  		$("#msg"+param).html("");
  		$("#input_img"+param).val("");
  		$.ajaxFileUpload({
 			 contentType: "application/x-www-form-urlencoded;charset=utf-8",
 	         url:__ctxPath+"/template/uploadImg-noMulti",
 	         type: "post",
 	         data :{
 	        	 "siteId":siteSid,
 	        	 "imgPath":imgPath
 	        	 },
 	         secureuri: false, 
 	         fileElementId: 'image_name'+param,
 	         dataType: "json",
 	         success: function (data) {
 	        	 var str = "";
 	             if(data.success=="true"){
 	            	 str = "<img id='imgsrc' src='"+data.url+"' height='60px' width='60px' />";
 	            	 $("#uploadImgPath1").val(data.url);
 	            	 $("#input_img"+param).val(data.data);
 	             }else{
 	            	 str = "<span class='img_error'>"+data.data+"</span>";
 	            	$("#input_img"+param).val("");
 	           	 }
 	             $("#msg"+param).html(str);
 	             $("#msg"+param).removeClass('hide');
 	         },
	  		error: function (data, status, e)//服务器响应失败处理函数
	        {
	  			 $("#msg"+param).html("<span class='img_error'>"+data.msg+"</span>");
	  			 $("#msg"+param).removeClass('hide');
	  			$("#input_img"+param).val("");
	        }  
 	     });
  	}	
	
	
	//上传文件
	function uploadFile(){
		var formData = new FormData($(".uploadForm")[0]);
		formData.append("time",new Date().getTime());
		formData.append("siteId",siteSid);		
		$.ajax({
			type : "post",
			url : __ctxPath + "/template/uploadfile",
			data:formData,
			cache: false,  
            processData: false,  
            contentType: false,
            dataType:"json",
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
				$("#uploadFile").hide();
				if(response.success){
					$("#success1Body").text("上传成功!");
					$("#success1").show();
				}else{					
					$("#warning2Body").text(response.msg);
					$("#warning2").show();					
				}
				initDirList($("#desFile1").val());
				clearInput();
			}
		}); 
	};
	
	
	//打开上传站点目录弹出框
	function openZipPage(){
		siteId = $("#site_list").val();
		if(siteId==""){
			$("#warning2Body").text("请选择站点!");
			$("#warning2").show();
			return false;
		}	
		$("#desFile").val(siteId);
		$("#uploadDir").show();
	}
	
	
	/**
	 * 上传模板压缩文件
	 * @param obj
	 */
	function uploadZipFile(obj){
		 var $sFile = $(".sourceFile");
		 var $dFile = $(".desFile");
		 if(!$sFile.val()){
			 alert("请选择源文件");
		     return; 
		 }
		 if(!$sFile.val()){
			 alert("请选择站点");	 
			 return;
		 }
		 var fileName = $sFile.val();
		 var fileStName = fileName.substring(0,fileName.lastIndexOf("."));
/*		 if(siteName!=fileStName){
			 alert("请将压缩包名改为当前域名");
		     return;
		 }*/
		 if(fileName.length > 1 && fileName ) {  
			 var ldot = fileName.lastIndexOf(".");
			 var type = fileName.substring(ldot + 1);
			 if(type!="zip" && type!="ZIP"){
			     alert("请选择ZIP,zip格式文件");
			     return;
			 }  
		    if(!window.FormData){
			       alert('your brower is too old');
			       return;
			}
			var formData = new FormData($( ".uploadZipForm" )[0]);  
			formData.append("time",new Date().getTime());
			
			$.ajax({
				type : "post",
				url : __ctxPath + "/template/uploadZip",
				data:formData,
				cache: false,  
	            processData: false,  
	            contentType: false,
	            dataType:"json",
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
					$("#uploadDir").hide();
					if(response.success){
						$("#success1Body").text("上传成功!");
						$("#success1").show();
					}else{
						$("#warning2Body").text(response.msg);
						$("#warning2").show();					
					}
					clearInput();
					//刷新站点目录
					initTree();
					//初始化目录列表
					initDirList("");
					//重置上传目录
					$("#desFile1").val("");
				}
			}); 
	     }
	}
	
	
	
	//创建模板
	function creatTpl(){
		$("#addTemplateDIV").show();
		
	}
	//保存模板
	function saveTemplate(){
		var path=rcNodeId+"/";
		var fileName=$("#file_name").val();
		var text=$("#template_edit").val();
		$.ajax({
	        type:"post",
	        dataType: "json",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/template/createFile",
	        data: {
	        	"path":path,
	        	"source":text,
	        	"fileName":fileName
	        },
	        success:function(response) {
	        	if(response.success == 'true'){
	        		$("#addTemplateDIV").hide();
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<strong>创建成功，返回列表页!</strong></div>");
		  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	        	}else{
	        		$("#addTemplateDIV").hide();
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>创建失败！</strong></div>");
		     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
	    	}
		});
	}
	  //弹出框的确定按钮
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});	
		initTree();
	}
	
	//保存数据
	function saveFrom(){
		var path=$("#select_path").val();
		var source=$("#tpl_edit").val();
		$.ajax({
	        type:"post",
	        dataType: "json",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/template/saveTpl",
	        data: {
	        	"path":path,
	        	"source":source
	        },
	        success:function(response) {
	        	if(response.success == 'true'){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<strong>修改成功，返回列表页!</strong></div>");
		  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	        	}else{
					$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改失败！</strong></div>");
		     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
				}
	    	}
		});
	}
	
	function resourceQuery(data) {
		if (data != '') {
			$("#cid").val(data);
		} else {
			$("#cid").val(0);
		}
		var params = $("#category_form").serialize();
		params = decodeURI(params);
		resourcePagination.onLoad(params);
	}
	
	//折叠面板函数
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
	
	//特殊字符转换
	function escapeJquery(srcString)
	{
	    // 转义之后的结果
	    var escapseResult = srcString;
	 
	    // javascript正则表达式中的特殊字符
	    var jsSpecialChars = ["\\", "^", "$", "*", "?", ".", "+", "(", ")", "[",
	            "]", "|", "{", "}"];
	 
	    // jquery中的特殊字符,不是正则表达式中的特殊字符
	    var jquerySpecialChars = ["~", "`", "@", "#", "%", "&", "=", "'", "\"",
	            ":", ";", "<", ">", ",", "/"];
	 
	    for (var i = 0; i < jsSpecialChars.length; i++) {
	        escapseResult = escapseResult.replace(new RegExp("\\"
	                                + jsSpecialChars[i], "g"), "\\"
	                        + jsSpecialChars[i]);
	    }
	 
	    for (var i = 0; i < jquerySpecialChars.length; i++) {
	        escapseResult = escapseResult.replace(new RegExp(jquerySpecialChars[i],
	                        "g"), "\\" + jquerySpecialChars[i]);
	    }
	 
	    return escapseResult;
	}	
	//重命名
	function rename(obj){
		var name=$(obj).attr("data");
		var opath=$("#path_" + escapeJquery(name)).val();
		$("#renameDIV").show();
		$("#path").val(opath);
		$("#oldName").val(name);
	} 
	
	function renameForm(){
		if($("#newName").val() == ""){
			$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>必填缺失!</strong></div>");
		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
		}else{
			$.ajax({
		        type:"post",
		        dataType: "json",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        url:__ctxPath + "/template/modifyFileName",
		        data: $("#renameForm").serialize(),
		        success:function(response) {
		        	if(response.success == "true"){
		        		$("#renameDIV").hide();
		        		$('#tree ul li:eq(0)').click();
		        		$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>修改成功!</strong></div>");
					$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				$("#pageBody").load(__ctxPath+"/jsp/web/template/templateList.jsp");
					}else{
						$("#renameDIV").hide();
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改失败！</strong></div>");
			     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					}
		    	}
			});
		}
	}
	//批量删除文件
	function delFiles(){
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var divSid = $(this).val();
			checkboxArray.push(divSid);
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
		var root=$("#select_path").val()+"/";
		for(i=0;i<checkboxArray.length;i++){
			value+=root+checkboxArray[i]+",";
			var type=$("#type_"+checkboxArray[i]).val();
			var hasContent=$("#hasContent_"+checkboxArray[i]).val();
			if(type=="true"&&hasContent=="true"){
				$("#model-body-warning")
				.html(
						"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>该文件夹不为空,不能删除!</strong></div>");
				$("#modal-warning").attr({
					"style" : "display:block;",
					"aria-hidden" : "false",
					"class" : "modal modal-message modal-warning"
				});
				return false;
			}
		}
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/template/delFile",
					dataType : "json",
					data : {
						"path" : value
					},
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
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"+ "<strong>删除成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
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
	
	//删除文件
	function delFile(obj){
		var filename=$(obj).attr("data");
		var filepath=$(obj).attr("id");
		var type=$("#type_"+name).val();
		var hasContent=$("#hasContent_"+name).val();
		if(type=="true"&&hasContent=="true"){
			$("#model-body-warning")
			.html(
					"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>该文件夹不为空,不能删除!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/template/delFile",
					dataType : "json",
					data : {
						"path" : filepath,
						"name" : filename
					},
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
						if (response.success == "true") {
							$("#modal-body-success")
									.html(
											"<div class='alert alert-success fade in'>"+ "<strong>删除成功，返回列表页!</strong></div>");
							$("#modal-success").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
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
	
	//同步FTP
	function loadFtp(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/template/loadftp",
			dataType : "json",
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
				if(response.success=="true"){
					$("#pageBody").load(__ctxPath+"/jsp/web/template/templateList.jsp");
				}
			}
		}); 
	}
	//FTP设置
	function setting(){
		$("#pageBody").load(__ctxPath+"/jsp/web/template/ftp_setting.jsp");
	}
	
	//创建目录
	function addDir(){
		$("#createDirDIV").show();
	}
	
	//创建新目录
	function createDir(){
		var dirName=$("#dirName").val();
		if(!dirName) alert("请输入目录");
		var path=rcNodeId;
		$.ajax({
			type : "post",
			url : __ctxPath + "/template/createdir?dirName="+dirName+"&path="+path,
			dataType : "json",
			success : function(response) {
				$("#createDirDIV").hide();
				$("#pageBody").load(__ctxPath+"/jsp/web/template/templateList.jsp");
				
			},
			error:function(response){
				console.log("error");
			}
		}); 
	}
	
	