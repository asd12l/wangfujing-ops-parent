	var tree = [];
	var resourcePagination;
	var nodeId = "";
	var rcNodeId = "";
	var siteSid = "";
	var siteName = "";
	
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
	
	//初始化
	$(function() {
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

	//初始化资源服务器目录
	function initTree(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/resource/resourceTree",
			dataType : "json",
			data:{"siteId":siteSid},
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

						if(node.type==1){
							initDirList(node.id);
						}else if(node.type==0){
							var ei = $("#large");
        					ei.hide();
        					
        					ei.css({top:"60px",left:"60px"}).html('<img style="border:1px solid gray;" src="' + 'http://img2.wfjimg.com/brand/5000059/banner_5000059.jpg' + '" />').show();
						}
						$("#select_path").val(node.id);
						$("#desFile1").val(node.id);
					}
				});

			}
		});
	}
	
	//加载目录详细列表
	function initDirList(path){
		var siteId = $("#site_list").val();
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
				url : __ctxPath + "/resource/queryDirList?path="
						+ path+"&_site_id_param="+siteId,
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
					$("#file_tab tbody").setTemplateElement(
							"dir-list")
							.processTemplate(data);
				}
			}
		});
	}
	
	//弹出上传文件框
	function toUploadFile(){
		var dpath = $("#desFile1").val();
		if(dpath==""){
			$("#warning2Body").text("请选择左侧资源目录上传!");
			$("#warning2").show();
			return false;
		}		
		$("#uploadFile").show();	
	}
	
	//上传单个文件
	function uploadFile(){
		var formData = new FormData($(".uploadForm")[0]);
		formData.append("time",new Date().getTime());
		formData.append("siteId",siteSid);
		$.ajax({
			type : "post",
			url : __ctxPath + "/resource/uploadfile",
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
	}
	
	//打开资源目录上传窗口
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
	
	//上传压缩文件
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
/*		 if(fileStName!=siteName){
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
		 }
	    if(!window.FormData){
		       alert('your brower is too old');
		       return false;
		}
	    var formData = new FormData($( ".uploadZipForm" )[0]);  
		formData.append("time",new Date().getTime());
		$.ajax({
			type : "post",
			url : __ctxPath + "/resource/uploadZip",
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
	
	//新建目录
	function addDir(){
		$("#createDirDIV").show();
	}
	
	//创建新目录
	function createDir(){
		var dirName=$("#dirName").val();
		var path=rcNodeId;
		$.ajax({
			type : "post",
			url : __ctxPath + "/template/createdir?dirName="+dirName+"&path="+path,
			dataType : "json",
			success : function(response) {
				if(response.success=="true"){
					$("#createDirDIV").hide();
					$("#pageBody").load(__ctxPath+"/jsp/web/resource/resource_list.jsp");
				}
				
			}
		}); 
	}
	
	//重命名
	function rename(obj){
		var name=$(obj).attr("data");
		var opath=$("#path_" + escapeJquery(name)).val();
		$("#renameDIV").show();
		$("#path").val(opath);
		$("#oldName").val(name);
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
	function renameForm(){
		
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
				$("#pageBody").load(__ctxPath+"/jsp/web/resource/resource_list.jsp");
		        	}else{
						$("#renameDIV").hide();
						$("#model-body-warning").html("<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>修改失败！</strong></div>");
			     	  		$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-warning"});
					}
		    	}
			});
	}
	
	//批量删除
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
											"<div class='alert alert-success fade in'>"
													+ "<strong>删除成功，返回列表页!</strong></div>");
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
											"<div class='alert alert-success fade in'>"
													+ "<strong>删除成功，返回列表页!</strong></div>");
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
			url : __ctxPath + "/resource/loadresource",
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
					$("#pageBody").load(__ctxPath+"/jsp/web/resource/resource_list.jsp");
				}
			}
		}); 
	}
	//FTP设置
	function setting(){
		$("#pageBody").load(__ctxPath+"/jsp/web/template/ftp_setting.jsp");
	}
	//创建新目录
	function createDir2(){
		var dirName=$("#dirName2").val();
		var path=$("#select_path").val();
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/template/createdir?dirName="+dirName+"&path="+path,
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
					$("#pageBody").load(__ctxPath+"/jsp/web/resource/resource_list.jsp");
				}
			}
		});  
	}
	

	  //弹出框的确定按钮
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		initTree();
	} 