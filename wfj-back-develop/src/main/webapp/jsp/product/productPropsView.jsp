<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 商品属性管理
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var categoryPagination;
	/* 设置zTree参数 */
	var setting = {
		edit: {
			drag: {
				autoExpandTrigger: true
			},
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		async: {
			enable: true,
			url: __ctxPath+"/category/ajaxAsyncList",
			dataType: "json",
			autoParam:["id", "channelSid", "shopSid","categoryType"],
			otherParam:{},
			dataFilter: filter
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: zTreeOnClick,
			asyncSuccess: zTreeOnAsyncSuccess,//异步加载成功的fun
			asyncError: zTreeOnAsyncError //加载错误的fun 
		}
	};
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	function zTreeOnAsyncError(event, treeId, treeNode){
		alert("异步加载失败!");
	}
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg){
		alert("111");
	}
	/* 节点点击事件 */
	function zTreeOnClick(event, treeId, treeNode) {
		if(treeNode.isLeaf=="Y"){
			categoryQuery(treeNode.id);
		}
	};
	/* 处理拖拽 */
	var log, className = "dark", curDragNodes, autoExpandNode;
	function getTime() {
		var now= new Date(),
		h=now.getHours(),
		m=now.getMinutes(),
		s=now.getSeconds(),
		ms=now.getMilliseconds();
		return (h+":"+m+":"+s+ " " +ms);
	}

	function setTrigger() {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	}
	/* 初始化tree树 */
	$(function(){
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/category/list",
			async:false,
			traditional:true,
			data:{"categoryType":"0,3"},
			dataType: "json",
			ajaxStart: function() {
	        	 $("#loading-container").attr("class","loading-container");
	         },
	         ajaxStop: function() {
	           //隐藏加载提示
	           setTimeout(function() {
	        	        $("#loading-container").addClass("loading-inactive")
	        	 },300);
	         },
			success:function(response) {
				$.fn.zTree.init($("#treeDemo"), setting, response);
			}
		});
		initCategory();
	    $("#pageSelect").change(categoryQuery);
	});
function categoryQuery(data){
	if(data!=''){
		$("#cid").val(data);
	}
    var params = $("#category_form").serialize();
    params = decodeURI(params);
    categoryPagination.onLoad(params);
}
function reset(){
	categoryQuery();
}
//根据品类末级几点查询spu信息
function initCategory() {
	categoryPagination = $("#categoryPagination").myPagination({
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
         url: __ctxPath+"/productprops/selectSpuByIsLeaf",
         dataType: 'json',
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
           $("#category_tab tbody").setTemplateElement("category-list").processTemplate(data);
         }
       }
     });
}

var cid = "";
var productSid = "";
var cName = "";
var channelSid = "";
/* 点击编辑根据品类末级几点查询属性字典 */
function update(data) {
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
	cid = treeObj[0].id;
	cName = treeObj[0].name;
	channelSid = treeObj[0].channelSid;
	productSid = data;
	var url = __ctxPath+"/jsp/product/PropsDictView.jsp";
		$("#pageBody").load(url);
}

function editColor(){
	var checkboxArray=[];
	$("input[type='checkbox']:checked").each(function(i, team){
		var productSid = $(this).val();
		checkboxArray.push(productSid);
	});
	if(checkboxArray.length>1){
		$("#warning2Body").text(buildErrorMessage("","只能选择一列！"));
        $("#warning2").show();
		 return false;
	}else if(checkboxArray.length==0){
		$("#warning2Body").text(buildErrorMessage("","请选取要修改的列！"));
        $("#warning2").show();
		 return false;
	}
	var value=	checkboxArray[0];
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
function spanTd(propsSid,categorySid,channelSid){
	if($("#spanTd_"+propsSid).attr("class")=="expand-collapse click-expand glyphicon glyphicon-plus"){
		$("#spanTd_"+propsSid).attr("class","expand-collapse click-collapse glyphicon glyphicon-minus");
		$.ajax({
			type:"post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url:__ctxPath + "/values/list",
			async:false,
			dataType: "json",
			ajaxStart: function() {
	        	 $("#loading-container").attr("class","loading-container");
	         },
	         ajaxStop: function() {
	           //隐藏加载提示
	           setTimeout(function() {
	        	        $("#loading-container").addClass("loading-inactive")
	        	 },300);
	         },
			data:{
				"propsSid":propsSid,"categorySid":categorySid,"channelSid":channelSid
			},
			success:function(response) {
				var result = response.rows;
				var option = "<tr id='afterTr"+propsSid+"'><td></td><td colspan='4'><div style='padding:2px'>"+
				"<table class='table table-bordered'><tr role='row'><th>属性值编号</th><th>属性值名称</th><th>属性名称</th><th>品类名称</th></tr>";
				for(var i=0;i<result.length;i++){
					var ele = result[i];
					option+="<tr><td>"+ele.valuesSid+"</td><td>"+ele.valuesName+"</td><td>"+ele.propsName+"</td><td>"+ele.categoryName+"</td>";
				}
				option+="</tr></table></div></td></tr>";
				$("#gradeX"+propsSid).after(option);
			}
		});
	}else{
		$("#spanTd_"+propsSid).attr("class","expand-collapse click-expand glyphicon glyphicon-plus");
		$("#afterTr"+propsSid).remove();
	}
}
/* 添加根部节点 */
function appGBFL(){
	$("#appGBFLDivName").val("");
	$("input[name='appGBFLDivNameStatus']").attr("checked","false");
	$("input[name='appGBFLDivNameStatusIsDisplay']").attr("checked","false");
	$("#appGBFLDivId").val(0);
	$("#appGBFLDivIsParent").val(1);
	$("#appGBFLDivSid").val("");
	$("#appGBFLDiv").show();
}
/* 保存根部节点 */
function appGBFLDivSave(){
	/* 如果是工业分类和统计分类只能是全渠道 */
	var appGBFLDivType = $("#appGBFLDivType").val();
	var appGBFLDivChannel = $("#appGBFLDivChannel").val();
	if(appGBFLDivType==0||appGBFLDivType==2){
		if(appGBFLDivChannel==0){
			appGBFLDivSaveTo();
		}else{
			alert("工业分类和统计分类只能为全渠道!");
		}
	}else{
		appGBFLDivSaveTo();
	}
}
//根部节点提交使用方法
function appGBFLDivSaveTo(){
	$.ajax({
        type:"post",
        url:__ctxPath + "/category/add",
        dataType: "json",
        ajaxStart: function() {
       	 $("#loading-container").attr("class","loading-container");
        },
        ajaxStop: function() {
          //隐藏加载提示
          setTimeout(function() {
       	        $("#loading-container").addClass("loading-inactive")
       	 },300);
        },
        data: $("#appGBFLDivForm").serialize(),
        success:function(response) {
        	if(response.obj == '添加成功'){
        		$("#categoryDIV").hide();
				$("#CategoryViewSuccess").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"，返回列表页!</strong></div>");
	  			$("#CategoryViewOneSuccess").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	  			$("#name").val("");
			}else if(response.obj == '修改成功'){
				$("#categoryDIV").hide();
				$("#CategoryViewSuccess").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"，返回列表页!</strong></div>");
	  			$("#CategoryViewOneSuccess").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	  			$("#name").val("");
			}else{
				$("#categoryDIV").hide();
				$("#CategoryViewSuccess").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"，返回列表页!</strong></div>");
	  			$("#CategoryViewOneSuccess").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	  			$("#name").val("");
			}
    	}
	});
}
//添加品类
function append(){
	/* 获取 zTree对象 */
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	/* 获取 zTree 的全部节点数据 */
	var nodes = treeObj.getNodes();
	/* 获取 zTree 当前被选中的节点数据集合 */
	var selectNodes = treeObj.getSelectedNodes();
	/* 渠道Sid */
	$("#divChannelSid").val(nodes[0].channelSid);
	/* 分类类别 */
	$("#divTypeSid").val(nodes[0].categoryType);
	if(selectNodes!=''){
		$("#name").val("");
		$("input[name='status']").attr("checked","false");
		$("input[name='isDisplay']").attr("checked","false");
		$("#divId").val(selectNodes[0].id);
		$("#divSid").val("");
		$("#categoryDIV").show();
	}else{
		$("#warning2Body").text(buildErrorMessage("","未选中节点！"));
        $("#warning2").show();
	}
}
//修改品类
function edit(){  
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
	if(treeObj!=''){
		$("#divId").val("");
		$.ajax({
	        type:"post",
	        url:__ctxPath + "/category/edit?id="+treeObj[0].id,
	        dataType: "json",
	        ajaxStart: function() {
	        	 $("#loading-container").attr("class","loading-container");
	         },
	         ajaxStop: function() {
	           //隐藏加载提示
	           setTimeout(function() {
	        	        $("#loading-container").addClass("loading-inactive")
	        	 },300);
	         },
	        success:function(response) {
	        	$("#name").val(response.name);
	        	if(response.status=="Y"){
	        		$("#status1").attr("checked","checked");
	        	}else{
	        		$("#status0").attr("checked","checked");
	        	}
	        	if(response.isDisplay == 1){
	        		$("#isDisplay1").attr("checked","checked");
	        	}else{
	        		$("#isDisplay0").attr("checked","checked");
	        	}
	    	}
		});
		$("#divSid").val(treeObj[0].id);
		$("#categoryDIV").show();
	}else{
		$("#warning2Body").text(buildErrorMessage("","未选中节点！"));
        $("#warning2").show();
	}
}
// 停用
function categoryDisable(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
	if(treeObj!=''){
		$.ajax({
	        type:"post",
	        url:__ctxPath + "/category/updateStatus",
	       	data:{
	       		"id":treeObj[0].id
	       	},
	        dataType: "json",
	        ajaxStart: function() {
	        	 $("#loading-container").attr("class","loading-container");
	         },
	         ajaxStop: function() {
	           //隐藏加载提示
	           setTimeout(function() {
	        	        $("#loading-container").addClass("loading-inactive")
	        	 },300);
	         },
	        success:function(response) {
	        	if(response.status == "success"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>操作成功，返回列表页!</strong></div>");
		  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#warning2Body").text(buildErrorMessage("",response.message));
			        $("#warning2").show();
				}
	    	}
		});
	}
}
// 删除
function categoryDel(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
	if(treeObj!=''){
		$.ajax({
	        type:"post",
	        url:__ctxPath + "/category/del?id="+treeObj[0].id,
	        dataType: "json",
	        ajaxStart: function() {
	        	 $("#loading-container").attr("class","loading-container");
	         },
	         ajaxStop: function() {
	           //隐藏加载提示
	           setTimeout(function() {
	        	        $("#loading-container").addClass("loading-inactive")
	        	 },300);
	         },
	        success:function(response) {
	        	if(response.status == "success"){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<i class='fa-fw fa fa-times'></i><strong>操作成功，返回列表页!</strong></div>");
		  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#warning2Body").text(buildErrorMessage("",response.message));
			        $("#warning2").show();
				}
	    	}
		});
	}
}

// 保存分类和修改分类
function saveDivFrom(){
	/* 获取 zTree对象 */
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	/* 获取 zTree 当前被选中的节点数据集合 */
	var selectNodes = treeObj.getSelectedNodes();
	$("#divChannelSid").val(selectNodes[0].channelSid);
	if($("#divSid").val()!=''){
		$("#divLevel").val(selectNodes[0].clevel);
	}else{
		$("#divLevel").val(selectNodes[0].clevel+1);
	}
	$.ajax({
        type:"post",
        url:__ctxPath + "/category/add",
        dataType: "json",
        ajaxStart: function() {
       	 $("#loading-container").attr("class","loading-container");
        },
        ajaxStop: function() {
          //隐藏加载提示
          setTimeout(function() {
       	        $("#loading-container").addClass("loading-inactive")
       	 },300);
        },
        data: $("#divForm").serialize(),
        success:function(response) {
        	if(response.obj == '添加成功'){
        		$("#categoryDIV").hide();
				$("#CategoryViewSuccess").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"，返回列表页!</strong></div>");
	  			$("#CategoryViewOneSuccess").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	  			$("#name").val("");
			}else if(response.obj == '修改成功'){
				$("#categoryDIV").hide();
				$("#CategoryViewSuccess").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"，返回列表页!</strong></div>");
	  			$("#CategoryViewOneSuccess").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	  			$("#name").val("");
			}else{
				$("#categoryDIV").hide();
				$("#CategoryViewSuccess").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>"+response.obj+"，返回列表页!</strong></div>");
	  			$("#CategoryViewOneSuccess").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
	  			$("#name").val("");
			}
    	}
	});
}
// 编辑保存分类和属性
function saveDivFrom2(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
	$.ajax({
        type:"post",
        url:__ctxPath + "/provalues/add",
        dataType: "json",
        ajaxStart: function() {
       	 $("#loading-container").attr("class","loading-container");
        },
        ajaxStop: function() {
          //隐藏加载提示
          setTimeout(function() {
       	        $("#loading-container").addClass("loading-inactive")
       	 },300);
        },
        data: {
        	'cid':treeObj[0].id,
        	'propsid':$("#Div2PropsSid").val(),
        	'name':$("#name2").val()
        },
        success:function(response) {
        	if(response.status == 'success'){
				$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>"+response.message+"，返回列表页!</strong></div>");
	  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			}else{
				$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
					"<i class='fa-fw fa fa-times'></i><strong>"+response.message+"，返回列表页!</strong></div>");
	  			$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
			}
        	$("#categoryDIV2").hide();
        	$("#pdict").val("");
			$("#div2Table").append("");
    	}
	});
}
/* 维护按钮 */
function updateRole(){
	/* 获取 zTree对象 */
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	/* 获取 zTree 的全部节点数据 */
	var nodes = treeObj.getNodes();
	/* 获取 zTree 当前被选中的节点数据集合 */
	var selectNodes = treeObj.getSelectedNodes();
	if(selectNodes!=''){
		$.ajax({
			url:__ctxPath+"/propvals/edit?id="+selectNodes[0].id,
			dataType:"json",
			ajaxStart: function() {
				$("#loading-container").attr("class","loading-container");
			},
			ajaxStop: function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				},300);
			},async:false,
			success:function(response){
				if(response.status=="Y"){
					$("#name2").val(response.name);
					$("#Div2PropsSid").val(response.propsid);
					propsid = response.propsid;
					$("#div2Table").html("<tr><td width='10%'></td><td width='30%'>属性</td><td width='40%'>属性描述</td></tr>");
					$.ajax({url:__ctxPath+"/propscombox/list?id="+selectNodes[0].id,dataType:"json",
							ajaxStart: function() {
								$("#loading-container").attr("class","loading-container");
							},
							ajaxStop: function() {
								//隐藏加载提示
								setTimeout(function() {
									$("#loading-container").addClass("loading-inactive")
								},300);
							},async:false,
							success:function(response){
								var result = response;
								var option = "";
								//循环正常属性列表与已经选中的做比较
								for(var i=0;i<result.length;i++){
									var ele = result[i];
									option += "<tr onchange='div2TrChange()'>"+
									"<td style='vertical-align: text-top;padding: 0px;'>"+
										"<div class='checkbox'><label>"+
											"<input type='checkbox' propsid='"+ele.propsSid+"' value="+ele.propsName+" >"+
											"<span class='text'></span></label>"+
										"</div>"+
									"</td>"+
									"<td style='vertical-align: text-top;padding: 0px;'>"+ele.propsName+"</td>"+
									"<td style='vertical-align: text-top;padding: 0px;'>"+ele.propsDesc+"</td></tr>";
								}
								$("#div2Table").append(option);
								$("#div2Table input[type='checkbox']").each(function(i){
									for(var j=0;j<propsid.length;j++){
										// 已经关联的和列表ID一样打勾
										if(propsid[j]==$(this).attr("propsid")){
											$(this).attr("checked","checked");
										}
										// 删除父类关联的行
									}
								});
								
							}
						});
					$("#categoryDIV2").show();
				}else{
					$("#warning2Body").text(buildErrorMessage("","无效分类,无法维护！"));
			        $("#warning2").show();
				}
			}
		});
	}else{
		$("#warning2Body").text(buildErrorMessage("","未选中分类节点！"));
        $("#warning2").show();
	}
}
/* 属性列表中的tr内容被选中触发 */
function div2TrChange(){
	var propsid = new Array();
	var names = "";
	var length = $("#div2Table input[type='checkbox']:checked").length;
	$("#div2Table input[type='checkbox']:checked").each(function(i){
		//封装propsid
		propsid.push($(this).attr('propsid'));
		if(i==length-1){
			names += $(this).val();
		}else{
			names += $(this).val()+",";
		}
	});
	$("#Div2PropsSid").val(propsid);
	$("#pdict").val(names);
}
/* 属性列表搜索按钮 */
function divTabApp_Search(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
	var propsName = $("#pdict").val();
	$("#div2Table").html("<tr><td width='10%'></td><td width='30%'>属性</td><td width='40%'>属性描述</td></tr>");
	$.ajax({
		type:"post",
		url:__ctxPath+"/propscombox/list",
		data:{"id":treeObj[0].id,"propsName":propsName},
		dataType:"json",
		ajaxStart: function() {
			$("#loading-container").attr("class","loading-container");
		},
		ajaxStop: function() {
			//隐藏加载提示
			setTimeout(function() {
				$("#loading-container").addClass("loading-inactive")
			},300);
		},async:false,success:function(response){
			var result = response;
			var option = "";
			//循环正常属性列表与已经选中的做比较
			for(var i=0;i<result.length;i++){
				var ele = result[i];
				option += "<tr onchange='div2TrChange()'><td style='vertical-align: text-top;padding: 0px;'><div class='checkbox'><label>"+
				"<input type='checkbox' propsid='"+ele.propsSid+"' value="+ele.propsName+" >"+
				"<span class='text'></span></label></div>"+
				"</td><td style='vertical-align: text-top;padding: 0px;'>"+ele.propsName+"</td><td style='vertical-align: text-top;padding: 0px;'>"+ele.propsDesc+"</td></tr>";
			}
			$("#div2Table").append(option);
			$("#div2Table input[type='checkbox']").each(function(i){
				for(var j=0;j<propsid.length;j++){
					if(propsid[j]==$(this).attr("propsid")){
						$(this).attr("checked","checked");
					}
				}
			});
		}
	});
}
/* 成功确定按钮 */
function successBtn(){
	$("#categoryDIV").hide();
	$("#categoryDIV2").hide();
	$("#appGBFLDiv").hide();
	$("#modal-success").hide();
	$("#CategoryViewOneSuccess").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
	refuseZtree();
}
/* 成功确定按钮使用异步刷新ztree和右侧列表 */
function refuseZtree(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
	categoryQuery(treeObj[0].id);
	$.ajax({
		type:"post",
		contentType: "application/x-www-form-urlencoded;charset=utf-8",
		url:__ctxPath + "/category/list",
		async:false,
		dataType: "json",
		ajaxStart: function() {
       	 $("#loading-container").attr("class","loading-container");
        },
        ajaxStop: function() {
          //隐藏加载提示
          setTimeout(function() {
       	        $("#loading-container").addClass("loading-inactive")
       	 },300);
        },
		success:function(response) {
			/* zTree使用 */
			$.fn.zTree.init($("#treeDemo"), setting, response);
			/* $("#callbackTrigger").bind("change", {}, setTrigger); */
		}
	});
}
function closeCategoryDiv(){
	$("#categoryDIV").hide();
	$("#categoryDIV2").hide();
	$("#appGBFLDiv").hide();
	$("#name").val("");
}


  </script>
</head>
<body>
<!-- Main Container -->
<div class="main-container container-fluid">
	<!-- Page Container -->
	<div class="page-container">
		<div class="page-body">
			<div class="row">
				<div class="col-lg-12 col-sm-12 col-xs-12">
					<div class="col-md-4" style="margin-top: 2.5px;">
						<div class="col-md-12 well" style="padding: 10px;">
							<div class="col-md-12">
								<ul id="treeDemo" class="ztree"></ul>
							</div>&nbsp;
						</div>
					</div>
					<div class="col-md-8" style="float: left;height: 550px;">
						<div class="col-xs-12 col-md-12" style="padding-left: 0px;">
							<div class="widget">
								<div class="widget-header ">
									<span class="widget-caption"><h5>产品与属性管理</h5></span>
									<div class="widget-buttons">
										<a href="#" data-toggle="maximize"></a>
										<a href="#" data-toggle="collapse" onclick="tab('pro');">
											<i class="fa fa-minus" id="pro-i"></i>
										</a>
										<a href="#" data-toggle="dispose"></a>
									</div>
								</div>
								<form id="category_form" action=""><input type="hidden" id="cid" name="cid" /></form>
								<div class="widget-body" id="pro">
									
                                    <table class="table table-hover table-bordered" id="category_tab">
                                        <thead>
                                            <tr role="row">
                                            	<th>产品名称</th>
                                                <th>商品SKU(款号)</th>
                                                <th>是否启用</th>
                                                <th>是否上架</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <div id="categoryPagination"></div>
                                </div>
								<!-- Templates -->
								<p style="display:none">
									<textarea id="category-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.propsSid}">
													<td id="sid_{$T.Result.sid}" style="vertical-align:middle;">
														{$T.Result.productName}
													</td>
													<td id="roleName_{$T.Result.sid}" style="vertical-align:middle;">{$T.Result.productSku}</td>
											
													<td id="roleCode_{$T.Result.sid}" style="vertical-align:middle;">
													{#if $T.Result.proActiveBit == 0}
						           							<span class="btn btn-danger btn-xs">未启用</span>
						                      			{#elseif $T.Result.proActiveBit == 1}
						           							<span class="btn btn-success btn-xs">已启用</span>
						                   				{#/if}
													</td>
													<td id="roleCode_{$T.Result.sid}" style="vertical-align:middle;">
													{#if $T.Result.proSelling == 0}
						           							<span class="btn btn-danger btn-xs">未上架</span>
						                      			{#elseif $T.Result.proSelling == 1}
						           							<span class="btn btn-success btn-xs">已上架</span>
						                   				{#/if}
						                   			</td>
						                   			<td>
						                   			<span class="btn btn-danger btn-xs" onclick="update({$T.Result.sid})">编辑</span>
						                   			</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
								</p>
                            </div>
                        </div>
                    </div>
				</div>
			</div>
	<!-- Add DIV root classification used -->
	<div class="modal modal-darkorange" style="margin:40px auto;" id="appGBFLDiv">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeCategoryDiv();">×</button>
                    <h4 class="modal-title">根部分类信息</h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-lg-12 col-sm-12 col-xs-12">
				            	<form id="appGBFLDivForm" method="post" class="form-horizontal" enctype="multipart/form-data">
				            		<input type="hidden" id="appGBFLDivId" name="id"/>
				            		<input type="hidden" id="appGBFLDivSid" name="sid"/>
				            		<input type="hidden" id="appGBFLDivIsParent" name="isParent"/>
				            			<div class="col-md-12">
				            				<div class="col-lg-3">
					 							根部分类名称:
					 						</div>
					 						<div class="col-lg-9">
					 							<input type="text" placeholder="必填" id="appGBFLDivName" name="name" style="width: 99.9%"/>
					 						</div>&nbsp;
					 					</div>
				 						<div class="col-md-6">
				 							<div class="col-lg-12">
												分类类别:
												<select name="categoryType" id="appGBFLDivType" style="width: 99.9%">
													<option value="0" selected="selected">工业分类</option>
													<option value="1">管理分类</option>
													<option value="2">统计分类</option>
													<option value="3">展示分类</option>
												</select>
											</div>
										</div>
				 						<div class="col-md-6">
				 							<div class="col-lg-12">
												渠道:
												<select name="channelSid" id="appGBFLDivChannel" style="width: 99.9%">
													<option value="0">全渠道</option>
												</select>
											</div>&nbsp;
										</div>
				 						<div class="col-lg-6">
					 						<div class="col-md-12">
												<div class="radio">
													状态:
													<label>
														<input class="basic" type="radio" name="status" value="Y">
														<span class="text">有效</span>
													</label>
													<label>
														<input class="basic" type="radio" name="status" value="N">
														<span class="text">无效</span>
													</label>
												</div>
												<div class="radio" style="display: none;">
													<label>
														<input class="inverted" type="radio" name="status">
														<span class="text"></span>
													</label>
												</div>
											</div>
										</div>
										<div class="col-lg-6">
											<div class="col-md-12">
												<div class="radio">
													显示:
													<label>
														<input class="basic" type="radio" name="isDisplay" value="1">
														<span class="text">显示</span>
													</label>
													<label>
														<input class="basic" type="radio" name="isDisplay" value="0">
														<span class="text">不显示</span>
													</label>
												</div>
												<div class="radio" style="display: none;">
													<label>
														<input class="inverted" type="radio" name="isDisplay">
														<span class="text"></span>
													</label>
												</div>
											</div>
										</div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeCategoryDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="appGBFLDivSave();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    <!-- Add DIV root classification used ||| End -->
    <!-- Add DIV classification used -->
	<div class="modal modal-darkorange" id="categoryDIV">
        <div class="modal-dialog" style="width: 400px;margin: 100px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeCategoryDiv();">×</button>
                    <h4 class="modal-title">分类信息</h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-md-12">
				            	<form id="divForm" method="post" class="form-horizontal" enctype="multipart/form-data">
				            		<input type="hidden" id="divId" name="id"/>
				            		<input type="hidden" id="divSid" name="sid"/>
				            		<!-- 父级sids -->
				            		<input type="hidden" id="divChannelSid" name="channelSid"/>
				            		<input type="hidden" id="divTypeSid" name="categoryType"/>
				            		<input type="hidden" id="divLevel" name="level"/>
				            		<input type="hidden" id="divIsParent" name="isParent" value="0"/>
					                <div class="form-group">
					 					分类名称：
					 					<input type="text" placeholder="必填" class="form-control" id="name" name="name">
					                </div>
					                <div class="form-group">
										状态
										<div class="radio">
											<label>
												<input class="basic" type="radio" id="status1" name="status" value="Y">
												<span class="text">有效</span>
											</label>
											<label>
												<input class="basic" type="radio" id="status0" name="status" value="N">
												<span class="text">无效</span>
											</label>
										</div>
										<div class="radio" style="display: none;">
											<label>
												<input class="inverted" type="radio" name="status">
												<span class="text"></span>
											</label>
										</div>
					                </div>
					                <div class="form-group">
					 					显示状态
										<div class="radio">
											<label>
												<input class="basic" type="radio" id="isDisplay1" name="isDisplay" value="1">
												<span class="text">显示</span>
											</label>
											<label>
												<input class="basic" type="radio" id="isDisplay0" name="isDisplay" value="0">
												<span class="text">不显示</span>
											</label>
										</div>
										<div class="radio" style="display: none;">
											<label>
												<input class="inverted" type="radio" name="isDisplay">
												<span class="text"></span>
											</label>
										</div>
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeCategoryDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivFrom();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    <!-- Add DIV classification used ||| End-->
    <div class="modal modal-darkorange" id="categoryDIV2">
        <div class="modal-dialog" style="margin: 60px auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button" onclick="closeCategoryDiv();">×</button>
                    <h4 class="modal-title">属性信息</h4>
                </div>
                <div class="modal-body">
                	<div class="bootbox-body">
				        <div class="row" style="padding: 10px;">
				            <div class="col-lg-12 col-sm-12 col-xs-12">
				            	<form id="div2Form" method="post" class="form-horizontal" enctype="multipart/form-data">
					                <div class="col-md-12">
					                	<div class="col-lg-12">分类名称：</div>
					                	<div class="col-lg-12">
					                		<span class="input-icon icon-right">
                                                <input type="text" placeholder="Name" readonly="readonly" id="name2" name="name" class="form-control">
                                                <i class="glyphicon glyphicon-user danger"></i>
                                            </span>
						 					<input type="hidden" id="Div2PropsSid"/>
						 				</div>
					                </div>
					                <div class="col-md-12">
										<div class="col-lg-12">属性名称：</div>
										<div class="col-lg-12">
											<span class="input-icon">
                                                <input type="text" id="pdict" name="propsid" class="form-control input-sm">
                                                <i class="glyphicon glyphicon-search danger" onclick="divTabApp_Search()" style="left: 93.5%;cursor: pointer;"></i>
                                            </span>&ensp;&ensp;
											<!-- 自定义滚动条 -->
											<div  style="overflow:auto;height: 220px;">
												<table class="table table-bordered" id="div2Table">
													<tr><td width="20%"></td><td width='30%'>属性</td><td width='40%'>属性描述</td></tr>
												</table>
											</div>
										</div>
					                </div>
				                </form>
				            </div>
				        </div>
			    	</div>
			   </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" onclick="closeCategoryDiv();" type="button">取消</button>
                    <button class="btn btn-default" type="button" onclick="saveDivFrom2();">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
</div>
</div>
</div>
<div aria-hidden="true" style="display: none;" class="modal modal-message modal-success fade" id="CategoryViewOneSuccess">
    <div class="modal-dialog" style="margin: 150px auto;">
        <div class="modal-content">
            <div class="modal-header">
                <i class="glyphicon glyphicon-check"></i>
            </div>
            <div class="modal-body" id="CategoryViewSuccess">You have done great!</div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-success" type="button" onclick="successBtn()">确定</button>
            </div>
        </div> <!-- / .modal-content -->
    </div> <!-- / .modal-dialog -->
</div>
</body>
</html>