$(document).ajaxStart(function(){
	$("#loading-container").attr("class","loading-container");
});
$(document).ajaxStop(function(){
	setTimeout(function() {
		$("#loading-container").addClass(
				"loading-inactive")
	}, 300);
});
__ctxPath = $("#ctxPath").val();
var tree = [];
var topicPagination;
/**
 * 专题图服务
 */
var cmsImageServer;

var topicId="";
var delId="";

var topicFloorId="";
var floorType="";
var floorTitle="";
var floorSeq="";
var floorStyle="";
var floorFlag="";
var floorEnTitle="";

var ip = "";
var port = "";
var domain = "";

$(function() {
	topicValidform();
	editValidform();
//	$(".tpl_path").change(function(){
//		var path=$(this).val();
//		initTplList(path);
//	});
	$("#pageSelect").change(topicQuery);
});

//对Date的扩展，将 Date 转化为指定格式的String
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
 var o = {
     "M+": this.getMonth() + 1, //月份 
     "d+": this.getDate(), //日 
     "h+": this.getHours(), //小时 
     "m+": this.getMinutes(), //分 
     "s+": this.getSeconds(), //秒 
     "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
     "S": this.getMilliseconds() //毫秒 
 };
 if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
 for (var k in o)
 if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
 return fmt;
}

	//专题活动主图上传
	function upLoadImg(param){
		$("#msg"+param).addClass('hide');
		$("#msg"+param).html("");
		$("#input_img"+param).val("");
		$("#loading-container").attr('class','loading-container');
		$.ajaxFileUpload({
			 contentType: "application/x-www-form-urlencoded;charset=utf-8",
	         url:__ctxPath+"/topic/uploadImg-noMulti",
	         type: "post",
	         data :{
	        	 "siteId":$("#site_list").val(),
	        	 },
	         secureuri: false, 
	         fileElementId: 'image_name'+param,
	         dataType: "json",
	         success: function (data) {
	        	 var str = "";
	             if(data.success=="true"){
	            	 str = "<img id='imgsrc' src='"+data.url+"' height='100px' width='100px' />";
	            	 $("#uploadImgPath1").val(data.url);
	            	 $("#input_img"+param).val(data.data);
	             }else{
	            	 str = "<span class='img_error'>"+data.data+"</span>";
	            	$("#input_img"+param).val("");
	           	 }
	             $("#msg"+param).html(str);
	             $("#msg"+param).removeClass('hide');
	             $("#loading-container").attr('class','loading-container loading-inactive');
	         },
  		error: function (data, status, e)//服务器响应失败处理函数
        {
  			$("#loading-container").attr('class','loading-container loading-inactive');
  			$("#msg"+param).html("<span class='img_error'>"+data.msg+"</span>");
  			 $("#msg"+param).removeClass('hide');
  			$("#input_img"+param).val("");
        }  
	     });
	};
	
	/**
	 * 楼层引导链接上传图片
	 * @param param
	 */
	function upLoadImgLink(param){
		$("#msg"+param).addClass('hide');
		$("#msg"+param).html("");
		$("#input_img"+param).val("");
		$("#loading-container").attr('class','loading-container');
		$.ajaxFileUpload({
			 contentType: "application/x-www-form-urlencoded;charset=utf-8",
	         url:__ctxPath+"/topic_floor/uploadImg-noMulti",
	         type: "post",
	         data :{
	        	 "siteId":$("#site_list").val(),
	         },
	         secureuri: false, 
	         fileElementId: 'image_name'+param,
	         dataType: "json",
	         success: function (data) {
	        	 var str = "";
	             if(data.success=="true"){
	            	 str = "<img id='imgsrc' src='"+data.url+"' height='100px' width='100px' />";
	            	 $("#uploadImgPath1").val(data.url);
	            	 $("#input_img"+param).val(data.data);
	             }else{
	            	 str = "<span class='img_error'>"+data.data+"</span>";
	            	$("#input_img"+param).val("");
	           	 }
	             $("#msg"+param).html(str);
	             $("#msg"+param).removeClass('hide');
	             $("#loading-container").attr('class','loading-container loading-inactive');
	         },
  		error: function (data, status, e)//服务器响应失败处理函数
        {
  			$("#loading-container").attr('class','loading-container loading-inactive');
  			$("#msg"+param).html("<span class='img_error'>"+data.msg+"</span>");
  			 $("#msg"+param).removeClass('hide');
  			 $("#input_img"+param).val("");
        }  
	     });
	};

function qureyShowViewUrl(){
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/webserver/get_front_server",
		dataType : "json",
		data:{
			"_site_id_param":siteSid
		},
		success : function(response) {
			var data = response.list;
			if(data.length>0){
				ip = data[0].ip;
				port = data[0].port;
				domain = data[0].path;
			}else{
				$("#warning2Body").text("没找到对应的server显示!");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
			}
		}
	});
};

//选择楼层样式时预览
function view(obj){
	
	if(obj==0){
		var filename = $("#style_list").val();
	}else{
		var filename = $("#floor_style_edit").val();
	}
	
	$.ajax({
        type:"post",
        dataType: "json",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        url:__ctxPath + "/template/previewImg",
        data:{
			"name":filename,
			"_site_id_param":siteSid
		},
		success:function(response) {
			if(response.success=="true"){
				$("#showTplViewDIV").show();
				str = "<img src='"+response.src+"' height='' width='900px;' />";
				$(".show_body_1").html(str);
			}else{
				bootbox.alert({  
		            buttons: {  
		               ok: {  
		                    label: '确定',  
		                }  
		            },  
		            message: "无对应资源!",  
		            title: "温馨提示!",  
		        });
			}
    	}
	});
};


function showTopicProductimg(obj){
		var filename = $("#div_style_list").val();
	$.ajax({
        type:"post",
        dataType: "json",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        url:__ctxPath + "/template/previewImg",
        data:{
			"name":filename,
			"_site_id_param":siteSid
		},
		success:function(response) {
			if(response.success=="true"){
				$("#showTplViewDIV").show();
				str = "<img src='"+response.src+"' height='' width='900px;' />";
				$(".show_body_1").html(str);
			}else{
				bootbox.alert({  
		            buttons: {  
		               ok: {  
		                    label: '确定',  
		                }  
		            },  
		            message: "无对应资源!",  
		            title: "温馨提示!",  
		        });
			}
    	}
	});
};



//选择模板时预览
function showTplView(obj){
	$("#showTplViewDIV").show();
	if(obj==0){
		var tplName = $("#tplContent").val();
		var path = $("#add_tpl_path").val();
	}else{
		var tplName = $("#edit_tplContent").val();
		var path = $("#edit_tpl_path").val();
	}
	$.ajax({
        type:"post",
        dataType: "json",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        url: __ctxPath + "/template/showTplView",
        data : {
			"path" : path,
			"tplName" : tplName,
			"_site_id_param":siteSid
		},
        success:function(response) {
        	if (response.success == "true") {
        		str = "<img src='"+response.src+"' height='' width='900px;' />";
        		$(".show_body_1").html(str);
			} else {
				bootbox.alert({  
		            buttons: {  
		               ok: {  
		                    label: '确定',  
		                }  
		            },  
		            message: "无对应资源!",  
		            title: "温馨提示!",  
		        });
			}
    	}
	});
};
//验证
function topicValidform() {
	return $("#addTopicForm").validate({
		rules: {
		   name : "required",
		   priority : {
				required : true,
				digits : true
			},
			path: "tplath",
			image_name1: "titleImg1",
			tplContent: "tplContent",
			startTime : "required",
			endTime : "required"
		},
		messages: {
			name:"请输入活动名称",
			priority:{
				required:"请输入排列顺序",
				digits:"只能输入整数"
			},
			startTime:"请输入开始时间",
			endTime:"请输入结束时间"
		}
	});
};
//验证
function editValidform() {
	return $("#editTopicForm").validate({
		onfocusout: function(element){
			        $(element).valid();
			    },
		rules: {
			name : "required",
			priority : {
				required : true,
				digits : true
			},
			path: "tplath",
			tplContent: "tplContent",
			startTime : "required",
			endTime : "required"
		},
		messages: {
			name:"请输入活动名称",	
			priority:{
				required:"请输入排列顺序",
				digits:"只能输入整数"
			},
			startTime:"请输入开始时间",
			endTime:"请输入结束时间"
		}
	});
};
/**
 * 目录下文件列表
 * @param path
 */
function initTplList(path){
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/template/queryDirList",
		async: false,
		dataType : "json",
		data:{
			"path":path,
			"_site_id_param":siteSid,
			"channelNo": 1,
			"suffix": ".html"
		},
		success : function(response) {
			var channelTemplate = $(".tpl_name");
			var result = response.list;
			channelTemplate.html("");
			for ( var i = 0; i < result.length; i++) {
				var ele = result[i];
				if(ele.name=="") continue;
				if(ele.name.indexOf(".html") != -1){
					var option = $("<option value='" + ele.name + "'>"
							+ ele.name + "</option>");
					option.appendTo(channelTemplate);
				}
			}
		}
	});
}
	function topicQuery() {
		var params = $("#topic_form").serialize();
		params = decodeURI(params);
		topicPagination.onLoad(params);
	}
	function initTree(){
		//加载添加修改时的模板路径
		loadFileList();
		
		var url = __ctxPath + "/topic/getTopicList?_site_id_param="+siteSid;
		topicPagination = $("#topicPagination").myPagination(
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
					url : url,
					dataType : 'json',
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
						//使用模板
						$("#topic_tab tbody").html("");
						$("#topic_tab tbody").setTemplateElement(
								"topic-list").processTemplate(data);
						cmsImageServer = data.cmsImageServer;
					}
				}
			});
		back();
	};
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
	};
	/**
	 * 修改活动代码
	 * @returns {Boolean}
	 */
	function editDir(){
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var id = $(this).val();
			checkboxArray.push(id);
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
		
		var value=checkboxArray[0];
		edit_topic(value);
	}
	//确认修改
	function editTopic(){
		 if(editValidform().form()){
			$.ajax({
		        type:"post",
		        dataType: "json",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        url:__ctxPath + "/topic/modifyTopic",
		        data: $("#editTopicForm").serialize(),
		        success:function(response) {
		        	if(response.success == 'true'){
		        		$("#editTopicDIV").hide();
		        		$("#success1Body").text("修改成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
			  			initTree();
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
	
	//打开添加活动窗口
	function addDir(){
		var time2 = new Date().Format("yyyy-MM-dd hh:mm:ss");
		$("#msg1").addClass("hide");
		$("#startTime").val(time2);
		$(".error").html("");
		$("#image_name1").removeClass("error");
		$("#addTopicDIV").show();
		$("#add_site_sid").val(siteSid);
		initTplList($("#add_tpl_path").val());
	};
	function addTopic(){
		 if(topicValidform().form()){
			$.ajax({
		        type:"post",
		        dataType: "json",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        url:__ctxPath + "/topic/addTopic",
		        data: $("#addTopicForm").serialize(),
		        success:function(response) {
		        	if(response.success == 'true'){
		        		$("#addTopicDIV").hide();
		        		clearInput();
		        		$("#success1Body").text("添加成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
			  			initTree();
		        	}else{
		        		bootbox.alert({  
				            buttons: {  
				               ok: {  
				                    label: '确定',  
				                }  
				            },  
				            message: "保存失败!",  
				            title: "温馨提示!",  
				        });
					}
		        	clearDivForm();
		    	}
			});
		}
	};
	
	/**
	 * 加载添加修改时的模板路径
	 */
	function loadFileList(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/site/getFtpTplDirList",
			dataType : "json",
			data:{
				"_site_id_param":siteSid
			},
			success : function(response) {
				var channelPath = $(".tpl_path");
				var result = response.list;
				channelPath.html("");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					if(ele.id=="") continue;
					if(ele.id!="/topic") continue;
					var option = $("<option value='" + ele.id + "'>"
							+ ele.id + "</option>");
					option.appendTo(channelPath);
				}
			}
		});
	};
	/**
	 * 删除活动
	 * @param id
	 */
	function del_topic(id){
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				deleteTopic(id);
			}
		}); 
	};
	/**
	 * 批量删除活动
	 * @returns {Boolean}
	 */
	function delDir(){
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var id = $(this).val();
			checkboxArray.push(id);
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
				deleteTopic(value);
			}
		}); 
	};
	function deleteTopic(value){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/topic/delTopic",
			dataType : "json",
			data : {
				"id" : value
			},
			success : function(response) {
				if (response.success == "true") {
					$("#success1Body").text("删除成功!");
					$("#success1").attr("style", "z-index:9999");
					$("#success1").show();
					initTree();
				} else {
					$("#warning2Body").text("删除失败!");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
				return;
			}
		});
	};
	/**
	 * 预览专题活动模板
	 * @param id
	 */
	function view_topic(id){
		window.open("http://"+siteName+"/topic/"+id+".html");
	}
	function edit_topic(value){
		$("#editTopicDIV").show();
		id_=$("#id_"+value).text().trim();
		name_ = $("#name_" + value).text().trim();
		keyWords_ = $("#keyWords_" + value).val();
		priority_ = $("#priority_" + value).text().trim();
		shortName_=$("#shortName_"+value).val().trim();
		description_ = $("#description_" + value).val();
		path_ = $("#path_" + value).val().trim();
		//titleImg_=$("#titleImg_"+value).val().trim();
		titleImg_=$("#titleImg_"+value).val().trim().split("com")[1];
		
		tplContent_ = $("#tplContent_" + value).val().trim();
		recommend_ = $("#recommend_" + value).val();
		startTime_ = $("#startTime_" + value).text();
		endTime_ = $("#endTime_" + value).text();
		initTplList(path_);
		$("#edit_topic_id").val(value);
		$("#edit_topic_name").val(name_);
		$("#edit_description").val(description_);
		$("#edit_shortName").val(shortName_);
		$("#edit_keyWords").val(keyWords_);
		$("#edit_priority").val(priority_);
		$("#edit_tpl_path").val(path_);
		$("#edit_tplContent").val(tplContent_);
		
		$("#edit_startTime").val(startTime_);
		$("#edit_endTime").val(endTime_);
		
		$("#input_img2").val($("#titleImg_"+value).val().trim());
		if(titleImg_!=''){
			$("#msg2").removeClass("hide");
			$("#msg2").html("<img width='100' height='100' src='"+cmsImageServer+titleImg_+"' />");
		}else{
			$("#msg2").addClass("hide");
			$("#msg2").html("");
		}
		
		if(recommend_){
			$("#edit_recommend_0").attr("checked",'checked');
		}else{
			$("#edit_recommend_1").attr("checked",'checked');
		}
	}
	/**
	 * 静态化专题活动页面
	 * @param id
	 */
	function static_topic(id){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/statics/topic",
			dataType : "json",
			data:{
				"topicId":id,
				"_site_id_param":siteSid
			},
			success : function(response) {
				if (response.respStatus==1) {
					$("#success1Body").text("操作成功!");
					$("#success1").attr("style", "z-index:9999");
					$("#success1").show();
				} else {
					$("#warning2Body").text("生成失败!");
					$("#warning2").attr("style", "z-index:9999");
					$("#warning2").show();
				}
				return;
			}
		});
	};
	/**
	 * 弹出框的确定按钮
	 */
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	};