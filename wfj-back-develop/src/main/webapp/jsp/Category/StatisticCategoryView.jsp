<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 分类管理
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">
	
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">
	
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js">
	
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/js/zTree_v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/zTree_v3/js/jquery.ztree.exedit-3.5.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
.notbtn {
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 2px;
	color: #444;
	font-size: 12px;
	line-height: 1.39;
	padding: 4px 9px;
	text-align: center;
	text-decoration: none;
}

.notbtn:hover {
	text-decoration: none;
}
</style>

<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var sessionId = "<%=request.getSession().getId() %>";
	var categoryPagination;
	var isAutoOpen = false, list_1, index_1=0;
	/* 设置zTree参数 */
	var setting = {
		edit : {
			drag : {
				autoExpandTrigger : true,
				prev : dropPrev,
				inner : dropInner,
				next : dropNext
			},
			enable : true,
			showRemoveBtn : false,
			showRenameBtn : false
		},
		view: {
			fontCss: setFontCss
		},
		async : {
			enable : true,
			url : __ctxPath + "/category/ajaxAsyncList",
			dataType : "json",
			autoParam : [ "id", "channelSid", "shopSid", "categoryType" ],
			otherParam : {"cache":"1"},
			dataFilter : filter
		},
		data : {
			simpleData : {
				enable : true
			},
			key : {
				name : "rename"
			},
			cache:"1"
		},
		callback : {
			beforeDrag : beforeDrag,
			beforeDrop : beforeDrop,
			beforeDragOpen : beforeDragOpen,
			onDrag : onDrag,
			onDrop : onDrop,
			onExpand : onExpand,
			onClick : zTreeOnClick,
			onAsyncSuccess : zTreeOnAsyncSuccess,//异步加载成功的fun
			onAsyncError : zTreeOnAsyncError
		//加载错误的fun 
		}
	};
	function setFontCss(treeId, treeNode) {
		
		return treeNode.status =='N' ? {color:"red"} : {};
	};
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes)
			return null;
		for (var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	function zTreeOnAsyncError(event, treeId, treeNode) {
		$("#warning2Body").text("异步加载失败!");
		$("#warning2").attr("style", "z-index:9999");
		$("#warning2").show();
	}
	/* var zTreeManagerCate = new Array();
	var zTreeShowCate = new Array(); */
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		if(isAutoOpen){
			index_1--;
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			var node = treeObj.getNodeByParam("id", list_1[index_1].sid);
			if(index_1 == 0){
				treeObj.selectNode(node);
				isAutoOpen = false;
			} else {
				treeObj.expandNode(node, true, true, true);
			}
		}
		/* if(treeNode.id == "managerCate"){
			msg = zTreeManagerCate;
		}
		if(treeNode.id == "showCate"){
			msg = zTreeShowCate;
		}alert(treeNode.id+"--"+msg); */
	}
	/* 节点点击事件 */
	function zTreeOnClick(event, treeId, treeNode) {
		if(treeNode.id=="managerCate"||treeNode.id=="showCate"){
			return;
		}
		if (treeNode.categoryType == 0) {
			$("#widget").text("工业分类与属性管理");
		}
		if (treeNode.categoryType == 1) {
			$("#widget").text("");
			$("#widget").append("管理分类与属性管理");
		}
		if (treeNode.categoryType == 2) {
			$("#widget").text("");
			$("#widget").append("统计分类与属性管理");
		}
		if (treeNode.categoryType == 3) {
			$("#widget").text("");
			$("#widget").append("展示分类与属性管理");
		}
		categoryQuery(treeNode.id);
	};
	
	
	
	function dropPrev(treeId, nodes, targetNode) {
		var pNode = targetNode.getParentNode();
		if (pNode && pNode.dropInner === false) {
			return false;
		} else {
			for (var i = 0, l = curDragNodes.length; i < l; i++) {
				var curPNode = curDragNodes[i].getParentNode();
				if (curPNode && curPNode !== targetNode.getParentNode()
						&& curPNode.childOuter === false) {
					return false;
				}
			}
		}
		return true;
	}
	/* 不能成为父节点 */
	function dropInner(treeId, nodes, targetNode) {
		if (targetNode && targetNode.dropInner === false) {
			return false;
		} else {
			for (var i = 0, l = curDragNodes.length; i < l; i++) {
				if (!targetNode && curDragNodes[i].dropRoot === false) {
					return false;
				} else if (curDragNodes[i].parentTId
						&& curDragNodes[i].getParentNode() !== targetNode
						&& curDragNodes[i].getParentNode().childOuter === false) {
					return false;
				}
			}
		}
		return true;
	}
	function dropNext(treeId, nodes, targetNode) {
		var pNode = targetNode.getParentNode();
		if (pNode && pNode.dropInner === false) {
			return false;
		} else {
			for (var i = 0, l = curDragNodes.length; i < l; i++) {
				var curPNode = curDragNodes[i].getParentNode();
				if (curPNode && curPNode !== targetNode.getParentNode()
						&& curPNode.childOuter === false) {
					return false;
				}
			}
		}
		return true;
	}
	/* 处理拖拽 */
	var log, className = "dark", curDragNodes, autoExpandNode;
	/* 拖拽前pId */
	var dragId;
	/* 拖拽前执行 */
	function beforeDrag(treeId, treeNodes) {
		if(treeNodes[0].categoryType=="0"){
			var dragFlag=$("#prodCateButton").val();
			if(dragFlag==2){
				$("#warning2Body").text("无法获取工业分类拖拽开关");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}else if(dragFlag==1){
				$("#warning2Body").text("无法拖拽工业分类");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return false;
			}
		}else if(treeNodes[0].categoryType=="2"){
			$("#warning2Body").text("无法拖拽统计分类");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}else if(treeNodes[0].categoryType=="1"){
			$("#warning2Body").text("无法拖拽管理分类");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		
		className = (className === "dark" ? "" : "dark");
		//alert("[ "+getTime()+" beforeDrag ]&nbsp;&nbsp;&nbsp;&nbsp; drag: " + treeNodes.length + " nodes." );
		for (var i = 0, l = treeNodes.length; i < l; i++) {
			dragId = treeNodes[i].pId;
			if (treeNodes[i].drag === false) {
				curDragNodes = null;
				return false;
			} else if (treeNodes[i].parentTId
					&& treeNodes[i].getParentNode().childDrag === false) {
				curDragNodes = null;
				return false;
			}
		}
		curDragNodes = treeNodes;
		return true;
	}
	function beforeDragOpen(treeId, treeNode) {
		autoExpandNode = treeNode;
		return true;
	}
	

	//autoParam : [ "id", "channelSid", "shopSid", "categoryType" ];
	function ajaxload(id,channelSid,shopSid,categoryType){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/ajaxAsyncList",
			async : false,
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass(
							"loading-inactive")
				}, 300);
			},
			data : {
				"id" : id,
				"channelSid":channelSid,
				"shopSid":shopSid,
				"categoryType":categoryType,
				"cache":"1"
			},
			success : function(response) {
				}
	});
	}
	
	/* 拖拽释放之后执行 */
	/* treeNodes拖拽节点,targetNode目标节点 */
	function beforeDrop(treeId, treeNodes, targetNode, moveType, isCopy) {
		var sortOrderIn = "";
		if(targetNode.id=="showCate"){
			$("#warning2Body").text("无法拖拽到该节点");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return false;
		}
		if(moveType!="inner"&&targetNode.level==0&&treeNodes[0].isLeaf=="Y"){
				$("#CategoryViewSuccess").html(
						"<div class='alert alert-success fade in'>"
								+ "<strong>操作失败!无法将叶子拖成根节点.</strong></div>");
				$("#CategoryViewOneSuccess").attr({
					"style" : "display:block;",
					"aria-hidden" : "false",
					"class" : "modal modal-message modal-success"
				});
			return false;
		}
		// 如果是向上拖动
			if (moveType == 'prev') {
				sortOrderIn = targetNode.sortOrder - 1;
			} else {
				sortOrderIn = targetNode.sortOrder;
			}
		
		/* 非叶子节点间严禁拖拽 */
		/* if(treeNodes[0].isLeaf!=targetNode.isLeaf){
			 $("#CategoryViewSuccess").html(
					"<div class='alert alert-success fade in'>"
							+ "<strong>操作失败，非叶子节点间不能拖拽!</strong></div>");
			$("#CategoryViewOneSuccess").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-success"
			});  

			var id=targetNode.id;
			ajaxload(id,targetNode.channelSid,targetNode.shopSid,targetNode.categoryType);
			   return;
			
	    }  */
		/* 不同分类之间严禁拖拽 */
		if(treeNodes[0].categoryType!=targetNode.categoryType){
			 $("#CategoryViewSuccess").html(
						"<div class='alert alert-success fade in'>"
								+ "<strong>操作失败，非同一类别的品类树之间不能拖拽!</strong></div>");
				$("#CategoryViewOneSuccess").attr({
					"style" : "display:block;",
					"aria-hidden" : "false",
					"class" : "modal modal-message modal-success"
				});  
				 var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				   var treenode=treeNodes[0].getParentNode();
				var tarnode = targetNode
			    treeObj.reAsyncChildNodes(tarnode, "refresh"); 
			    treeObj.expandNode(tarnode, true, true, true);
			    treeObj.expandNode(treenode, true, true, true);
				ajaxload(treenode.id,treenode.channelSid,treenode.shopSid,treenode.categoryType);
		    return false;
			
		}
	    var rootSid=null;
	    if(targetNode.rootSid!=treeNodes[0].rootSid){
			rootSid=targetNode.rootSid;
	    }
		/*  if (targetNode.pId == dragId) {  */
			var data = {
				sid : treeNodes[0].id,
				isLeaf:treeNodes[0].isLeaf,
				name:treeNodes[0].name,
				categoryType:treeNodes[0].categoryType,
				pId : treeNodes[0].pId,
				sortOrder : sortOrderIn,
				moveType : moveType,
				targetSid:targetNode.id,
				targetPid:targetNode.pId,
				isParent:targetNode.isParent,
				rootSid : rootSid
			};
	
			var confirmVal = false;
			$.ajax({
				async : false,
				type : "post",
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr("class", "loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive")
					}, 300);
				},
				data : data,
				url : __ctxPath + "/category/categoryBeforeDrop",
				success : function(response) {
					if (response.data == 2) {
						$("#CategoryViewSuccess").html(
								"<div class='alert alert-success fade in'>"
										+ "<strong>操作失败!</strong></div>");
						$("#CategoryViewOneSuccess").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
						categoryQuery();
					}else if (response.data == 3||response.data == 4) {
						
						$("#CategoryViewSuccess").html(
								"<div class='alert alert-success fade in'>"
										+ "<strong>亲!操作失败,该品类名已存在!</strong></div>");
						$("#CategoryViewOneSuccess").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
						var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
						var tarnode = targetNode.getParentNode();
// 					    treeObj.reAsyncChildNodes(tarnode, "refresh");
					}else if (response.data == 5) {
						$("#warning2Body").text("无法拖拽到叶子节点下");
						$("#warning2").attr("style", "z-index:9999");
						$("#warning2").show();
						var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
						var tarnode = targetNode;
// 					    treeObj.reAsyncChildNodes(tarnode, "refresh");
					}else if (response.data == 6) {
						$("#warning2Body").text("目标节点获取错误");
						$("#warning2").attr("style", "z-index:9999");
						$("#warning2").show();
						var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
						var tarnode = targetNode;
					    treeObj.reAsyncChildNodes(tarnode, "refresh");
					}else{
						confirmVal = true;
						$("#CategoryViewSuccess").html(
								"<div class='alert alert-success fade in'>"
										+ "<strong>操作成功</strong></div>");
						$("#CategoryViewOneSuccess").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
						var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
						categoryQuery(treeNodes[0].id);
						if (targetNode.pId!=treeNodes[0].pId) {
							//获取被拖节点的父节点
						    var treenode=treeNodes[0].getParentNode();
						    $.ajax({
								type : "post",
								contentType : "application/x-www-form-urlencoded;charset=utf-8",
								url : __ctxPath + "/category/ajaxAsyncList",
								async : false,
								dataType : "json",
								ajaxStart : function() {
									$("#loading-container").attr("class",
											"loading-container");
								},
								ajaxStop : function() {
									//隐藏加载提示
									setTimeout(function() {
										$("#loading-container").addClass(
												"loading-inactive")
									}, 300);
								},
								data : {
									"id" : treenode.id,
									"channelSid":treenode.channelSid,
									"shopSid":treenode.shopSid,
									"categoryType":treenode.categoryType
								},
								success : function(response) {
									treeObj.expandNode(treenode, true, true, true);
									}
						});
							//获取目标节点的父节点
							if(targetNode.getParentNode()==null){
								var tarnode = targetNode;
							    $.ajax({
									type : "post",
									contentType : "application/x-www-form-urlencoded;charset=utf-8",
									url : __ctxPath + "/category/ajaxAsyncList",
									async : false,
									dataType : "json",
									ajaxStart : function() {
										$("#loading-container").attr("class",
												"loading-container");
									},
									ajaxStop : function() {
										//隐藏加载提示
										setTimeout(function() {
											$("#loading-container").addClass(
													"loading-inactive")
										}, 300);
									},
									data : {
										"id" : tarnode.id,
										"channelSid":tarnode.channelSid,
										"shopSid":tarnode.shopSid,
										"categoryType":tarnode.categoryType
									},
									success : function(response) {
									    treeObj.expandNode(tarnode, true, true, true);
										}
								});
							}else{
								var tarnode = targetNode.getParentNode();
							    $.ajax({
									type : "post",
									contentType : "application/x-www-form-urlencoded;charset=utf-8",
									url : __ctxPath + "/category/ajaxAsyncList",
									async : false,
									dataType : "json",
									ajaxStart : function() {
										$("#loading-container").attr("class",
												"loading-container");
									},
									ajaxStop : function() {
										//隐藏加载提示
										setTimeout(function() {
											$("#loading-container").addClass(
													"loading-inactive")
										}, 300);
									},
									data : {
										"id" : tarnode.id,
										"channelSid":tarnode.channelSid,
										"shopSid":tarnode.shopSid,
										"categoryType":tarnode.categoryType
									},
									success : function(response) {
									    treeObj.expandNode(tarnode, true, true, true);
										}
								});	
							}
						}else if(targetNode.pId==treeNodes[0].pId){
							//获取拖拽节点的父节点
							var treenode=treeNodes[0].getParentNode();
						    treeObj.reAsyncChildNodes(treenode, "refresh");
						}
					}
				},
				error : function(XMLHttpRequest, textStatus) {
					var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
					if(sstatus != "sessionOut"){
						$("#CategoryViewSuccess").html(
								"<div class='alert alert-success fade in'>"
										+ "<strong>网络有点不给力呀!</strong></div>");
						$("#CategoryViewOneSuccess").attr({
							"style" : "display:block;",
							"aria-hidden" : "false",
							"class" : "modal modal-message modal-success"
						});
						categoryQuery();
					}
					if(sstatus=="sessionOut"){     
		            	 $("#warning3").css('display','block');     
		             }
				}
			});
			return confirmVal;
		 /* } else { */
		/* 	alert('只能进行同级排序');
			return false; */
		/* } */ 
		 ; 
		return true;
	}
	function onDrag(event, treeId, treeNodes) {
		className = (className === "dark" ? "" : "dark");
		showLog("[ " + getTime() + " onDrag ]&nbsp;&nbsp;&nbsp;&nbsp; drag: "
				+ treeNodes.length + " nodes.");
	}
	function onDrop(event, treeId, treeNodes, targetNode, moveType, isCopy) {
		className = (className === "dark" ? "" : "dark");
		showLog("[ " + getTime()
				+ " onDrop ]&nbsp;&nbsp;&nbsp;&nbsp; moveType:" + moveType);
		showLog("target: " + (targetNode ? targetNode.name : "root")
				+ "  -- is "
				+ (isCopy == null ? "cancel" : isCopy ? "copy" : "move"))
	}
	function onExpand(event, treeId, treeNode) {
		if (treeNode === autoExpandNode) {
			className = (className === "dark" ? "" : "dark");
			showLog("[ " + getTime() + " onExpand ]&nbsp;&nbsp;&nbsp;&nbsp;"
					+ treeNode.name);
		}
	}

	function showLog(str) {
		if (!log)
			log = $("#log");
		log.append("<li class='"+className+"'>" + str + "</li>");
		if (log.children("li").length > 8) {
			log.get(0).removeChild(log.children("li")[0]);
		}
	}
	function getTime() {
		var now = new Date(), h = now.getHours(), m = now.getMinutes(), s = now
				.getSeconds(), ms = now.getMilliseconds();
		return (h + ":" + m + ":" + s + " " + ms);
	}

	function setTrigger() {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	}
	

	function refreshAllZTree(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/list",
			async : false,
			dataType : "json",
			data:{
				"cache":"1"
			},
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				/* zTree使用 */
				var zTreeCate = new Array();
				for(var i=0;i<response.length;i++){
					if(response[i].categoryType==2){
						zTreeCate.push(response[i]);
					}
				}
				if(zTreeCate.length != 0){
					$.fn.zTree.init($("#treeDemo"), setting, zTreeCate);
				}
			}
		});
		initCategory();
		$("#pageSelect").change(categoryQuery);

		//获取所有渠道
		/* $.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/channel/findChannel",
			async : false,
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				获取所有渠道 
				$("#appGBFLDivChannel").empty();
				var option = "";
				option += "<option value='0'>全渠道</option>";
				for (var i = 0; i < response.length; i++) {
					if(response[i].channelName=='全渠道'){
						
					}else{
						option += "<option value='"+response[i].sid+"'>"
						+ response[i].channelName + "</option>";
					}
				}
				$("#appGBFLDivChannel").append(option);
			}
		}); */

		$("#hrootstatus").attr("checked", true)
		$("#yisdisplay").attr("checked", true)
		$("#isDisplay1").attr("checked", true)
		$("#status1").attr("checked", true)
		
	}
	
	/* 初始化tree树 */
	$(function() {
		
		refreshAllZTree();
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/getCategoryButton",
			async : false,
			dataType : "json",
			success : function(response) {
				if(response.success=="false"){
					$("#prodCateButton").val(2);
				}else{
					if(response.data==0){
						$("#prodCateButton").val(0);
					}else if(response.data==1){
						$("#prodCateButton").val(1);
					}
				}
			}
		});
		
		$("#appGBFLDivChannel").change(function(){
			var channelSid=$(this).val();
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/category/selectCategoryList",
				async : false,
				dataType : "json",
				data : {
					"parentSid" : "0",
				    "isDisplay" : "1",
				    "categoryType" : "3",
				    "pageSize" : "9999",
				    "currenPage" : "1",
				    "channelSid" : channelSid
				},
				success : function(response) {
					if(response.success=="true"){
						var list=response.data.list;
						var status=true;
						for(var i=0;i<list.length;i++){
							if(list[i].status=='Y'){
								status=false;
								break;
							}
						}
						if(!status){
							$("#nrootstatus").prop("checked", true);
						} else {
							$("#hrootstatus").prop("checked", true);
						}
					} else {
						$("#hrootstatus").prop("checked", true);
					}
				}
			});
		});
		
	});
	
	
	function categoryQuery(data) {
		if (data != '') {
			$("#cid").val(data);
		}
		var params = $("#category_form").serialize();
		LA.sysCode = '10';
		LA.log("category.categoryQuery", "统计分类查询：" + params, getCookieValue("username"), sessionId);
		params = decodeURI(params);
		categoryPagination.onLoad(params);
	}
	function reset() {
		categoryQuery();
	}
	//初始化属性
	function initCategory() {
		categoryPagination = $("#categoryPagination").myPagination(
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
						url : __ctxPath + "/props/list",
						dataType : 'json',
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						callback : function(data) {
							//使用模板
							$("#category_tab tbody").setTemplateElement(
									"category-list").processTemplate(data);
						}
					}
				});
	}
	function editColor() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text(buildErrorMessage("","只能选择一列！"));
	        $("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text(buildErrorMessage("","请选取要修改的列！"));
	        $("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
	}
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
	function spanTd(propsSid) {
		if ($("#spanTd_" + propsSid).attr("class") == "expand-collapse click-expand glyphicon glyphicon-plus") {
			$("#spanTd_" + propsSid).attr("class",
					"expand-collapse click-collapse glyphicon glyphicon-minus");
			$
					.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/values/list1",
						async : false,
						dataType : "json",
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						data : {
							"propSid" : propsSid
						},
						success : function(response) {
							/* if (response.rows == "f该属性没有有效的属性值") {
								alert(response.rows);
								return;
							} */
							var result = response;
							var option = "<tr id='afterTr"+propsSid+"'><td></td><td colspan='5'><div style='padding:2px'>"
									+ "<table class='table table-bordered table-striped table-condensed table-hover flip-content'>"
									+ "<tr role='row'>"
									+ "<th>属性值编码</th>"
									+ "<th>属性值名称</th>"
									+ "<th>属性值描述</th>"
									+ "</tr>";
							for (var i = 0; i < result.length; i++) {
								var ele = result[i];
								option += "<tr><td>" + ele.valuesSid
										+ "</td><td>" + ele.valuesName
										+ "</td><td>" + ele.valuesDesc
										+ "</td>";
							}
							option += "</tr></table></div></td></tr>";
							$("#gradeX" + propsSid).after(option);
						}
					});
		} else {
			$("#spanTd_" + propsSid).attr("class",
					"expand-collapse click-expand glyphicon glyphicon-plus");

			$("#afterTr" + propsSid).remove();
		}
	}
	/* 添加根部节点 */
	function appGBFL() {
		$("#appGBFLDivName").val("");
		$("input[name='appGBFLDivNameStatus']").attr("checked", "false");
		$("input[name='appGBFLDivNameStatusIsDisplay']").attr("checked",
				"false");
		$("#appGBFLDivId").val(0);
		$("#appGBFLDivIsParent").val(1);
		$("#appGBFLDivSid").val("");
		$("#appGBFLDiv").show();
		
		var  selectoption1="<select onchange='getType(this.value)' name='categoryType'"+
		"id='appGBFLDivType' style='width: 99.9%'>"+
		"<option value='0' class='delectcate' selected='selected'>工业分类</option>"+
		"<option value='2' class='delectcate'>统计分类</option>"+
		"<option value='3'>展示分类</option>"+
	    "</select>";
	    
	    var selectoption2="<select onchange='getType(this.value)' name='categoryType'"+
		"id='appGBFLDivType' style='width: 99.9%'>"+
		"<option value='3'>展示分类</option>"+
	    "</select>";
	    
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/bw/getCountByCategoryType",
			async : false,
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass(
							"loading-inactive")
				}, 300);
			},
			success : function(response) {
				if (response.data < 2) {
					$("select").remove("#appGBFLDivType");
					$("#appendSelect").append(selectoption1)
					return;
				}else if(response.data>=2){
					/* $("option").remove(".delectcate"); */
					$("select").remove("#appGBFLDivType");
					$("#appendSelect").append(selectoption2)
				}
			
			}
		});
		
		

	}
	/* 级联获取门店 */
	/* function getStroe() {
		$("#storeid").show();
		var optionval = $("#appGBFLDivType").val();
		if (optionval == 1) {
			$("#storeid").show();
			//获取所有门店
			$
					.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/organization/selectAllStore",
						async : false,
						dataType : "json",
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						data : {
							'organizationType' : $("#type").val(),
						},
						success : function(response) { */
							/* 获取所有门店 */
							/*var option = "";
						 	for (var i = 0; i < response.length; i++) {
								option += "<option value='"+response[i].sid+"'>"
										+ response[i].organizationName
										+ "</option>";
							}
							$("#appGBFLDivOrganiztion").append(option);
						}
					});
		} else {
			$("#storeid").hide();
		}

	} */
	
	
	/* 保存根部节点 */
	function appGBFLDivSave() {
		/* 如果是工业分类和统计分类只能是全渠道 */
		var appGBFLDivType = $("#appGBFLDivType").val();
		var appGBFLDivChannel = $("#appGBFLDivChannel").val();
		var appGBFLDivOrganiztion = $("#appGBFLDivOrganiztion").val();
		var rootname = $("#appGBFLDivName").val()
		var shopname = $("#appGBFLDivOrganiztion").val();
		/* 校验 */
		if (rootname == "" || rootname == null) {
			alert("名称不能为空")
			return;
		}
		if (rootname.length > 60) {
			alert("名称大于60个字符");
			return;
		}

// 		var optionval = $("#appGBFLDivType").val();
// 		if (optionval == 1) {
// 			var shopval = $("#appGBFLDivOrganiztion").val();
// 			if (shopval == "--请选择门店--") {
// 				alert("请选择对应的门店")
// 				return;
// 			}
// 		}
		if (appGBFLDivType == 0 || appGBFLDivType == 2 || appGBFLDivType == 1) {
			if (appGBFLDivChannel == 0) {
				appGBFLDivSaveTo();
			} else {
				alert("工业分类、统计分类、只能为全渠道!");
			}
		} else {
			appGBFLDivSaveTo();
		}
	}
	//根部节点提交使用方法
	function appGBFLDivSaveTo() {
		$.ajax({
			type : "post",
			url : __ctxPath + "/category/add",
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			data : $("#appGBFLDivForm").serialize(),

			success : function(response) {
				if (response.data == "添加成功") {
					$("#categoryDIV").hide();
					$("#CategoryViewSuccess").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>" 
									+ "操作成功，返回列表页!</strong></div>");
					$("#CategoryViewOneSuccess").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					refreshAllZTree();
				}else if (response.data.errorCode == "00109010") {
					$("#categoryDIV").hide();
					$("#CategoryViewSuccess").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>" 
									+ "修改失败!</strong></div>");
					$("#CategoryViewOneSuccess").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					$("#name").val("");
					refuseZtree();
				}
				else if (response.data.errorCode == "00109006") {
					$("#categoryDIV").hide();
					$("#CategoryViewSuccess").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>" 
									+ "添加失败!</strong></div>");
					$("#CategoryViewOneSuccess").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					refuseZtree();
				}else if (response.data.errorCode == "00109007") {
					$("#categoryDIV").hide();
					$("#CategoryViewSuccess").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>" 
									+ "操作失败，该上级分类已经存在!</strong></div>");
					$("#CategoryViewOneSuccess").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					$("#name").val("");
					refuseZtree();
				}
				else if (response.data.errorCode == "00109009") {
					$("#categoryDIV").hide();
					$("#CategoryViewSuccess").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>"
									+ "亲，只能有一套有效的工业分类或统计分类!</strong></div>");
					$("#CategoryViewOneSuccess").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					$("#name").val("");
					refuseZtree();
				}
				 else {
					$("#categoryDIV").hide();
					$("#CategoryViewSuccess").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>" 
									+ "返回列表页!</strong></div>");
					$("#CategoryViewOneSuccess").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					$("#name").val("");
					refuseZtree();
				}
			}
		});
	}
	/* 添加品类 */
	function append() {
		LA.sysCode = '10';
		LA.log("category.append", "统计分类添加", getCookieValue("username"), sessionId);
		/* 获取 zTree对象 */
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		/* 获取 zTree 的全部节点数据 */
		var nodes = treeObj.getNodes();
		/* 获取 zTree 当前被选中的节点数据集合 */
		var selectNodes = treeObj.getSelectedNodes();
		
		if(selectNodes==""){
        	$("#warning2Body").text(buildErrorMessage("","未选中节点！"));
	        $("#warning2").show();
			return;
		}
		// id
		var catasid = selectNodes[0].id;
		var isleaf = selectNodes[0].isLeaf;
		var cateType=selectNodes[0].categoryType;
		if(catasid=="showCate"){
			$("#warning2Body").text("该级展示分类不能添加");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		if(cateType=="1"){
			$("#warning2Body").text("管理分类不能添加");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
		}else
			//如果当前是子节点，则查询该子节点下是否有商品
		if (isleaf == 'Y') {
			$.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : __ctxPath + "/category/getCountByIsLeaf",
						async : false,
						dataType : "json",
						data : {
							"id" : catasid
						},
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						success : function(response) {
							if (response.data >= '1') {
								alert("该级品类已经有商品，不能再添加下级分类了");
								return;
							}else{
								if (selectNodes != "") {
									$("#name").val("");
// 									$("input[name='status']").attr("checked", "false");
// 									$("input[name='isDisplay']").attr("checked", "false");
									$("#divId").val(selectNodes[0].id);
									if(cateType==3){
										$("#entryCodeDiv2").hide();
										$("#entryCode2").val("");
									}else{
										$("#entryCodeDiv2").show();
										$("#entryCode2").val("");
									}
									$("#divSid").val("");
									$("#categoryDIV").show();
								} else {
									$("#warning2Body").text(buildErrorMessage("","未选中节点！"));
							        $("#warning2").show();
									return;
								}
							}
						}
					});
		}else{
			if (selectNodes != "") {
				$("#name").val("");
// 				$("input[name='status']").attr("checked", "false");
// 				$("input[name='isDisplay']").attr("checked", "false");
				$("#divId").val(selectNodes[0].id);
				if(cateType==3){
					$("#entryCodeDiv2").hide();
					$("#entryCode2").val("");
				}else{
					$("#entryCodeDiv2").show();
					$("#entryCode2").val("");
				}
				$("#divSid").val("");
				$("#categoryDIV").show();
			} else{
				$("#warning2Body").text(buildErrorMessage("","未选中节点！"));
		        $("#warning2").show();
				return;
			}
			var levels = $("#divLevel").val(selectNodes[0].clevel);
			/* 渠道Sid */
			$("#divChannelSid").val(nodes[0].channelSid);
			/* 分类类别 */
			$("#divTypeSid").val(nodes[0].categoryType);

			$("#divRootSid").val(nodes[0].rootSid);

// 			$("#divShopSid").val(nodes[0].shopSid);
		}
	}
	//修改品类
	function edit() {
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
		var cateType=treeObj[0].categoryType;
		var entryCode=treeObj[0].entryCode;
		if(treeObj[0].id=="showCate"){
			$("#warning2Body").text("该级展示分类不能修改");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		if(cateType=="1"){
			$("#warning2Body").text("管理分类不能修改");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		if(cateType=="2"){
			$("#warning2Body").text("统计分类不能修改");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		if (treeObj != "") {
			$("#divId").val("");
			$.ajax({
				type : "post",
				url : __ctxPath + "/category/edit?id=" + treeObj[0].id,
				dataType : "json",
				ajaxStart : function() {
					$("#loading-container").attr("class", "loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass("loading-inactive")
					}, 300);
				},
				success : function(response) {
					$("#name").val(response.name);
					if (response.status == "Y") {
						$("#status1").attr("checked", "checked");
					} else {
						$("#status0").attr("checked", "checked");
					}
					if (response.isDisplay == 1) {
						$("#isDisplay1").attr("checked", "checked");
					} else {
						$("#isDisplay0").attr("checked", "checked");
					}
				}
			});
			$("#divSid").val(treeObj[0].id);
			if(cateType==3){
				$("#entryCodeDiv2").hide();
				$("#entryCode2").val("");
				$("#entryCode1").val("");
			}else{
				$("#entryCodeDiv2").show();
				$("#entryCode2").val(entryCode);
				$("#entryCode1").val(entryCode);
			}
			$("#categoryDIV").show();
		} else {
			$("#warning2Body").text(buildErrorMessage("","未选中节点！"));
	        $("#warning2").show();
			return;
		}
	}
	// 停用
	function categoryDisable() {
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
		var tree = $.fn.zTree.getZTreeObj("treeDemo");
		var cateType=treeObj[0].categoryType;
		var catasid =treeObj[0].id;
		var isleaf =treeObj[0].isLeaf;
		if(catasid=="showCate"){
			$("#warning2Body").text("该级展示分类不能停用");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		if(cateType=="1"){
			$("#warning2Body").text("管理分类不能停用");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		if(cateType=="2"){
			$("#warning2Body").text("统计分类不能停用");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		var flag=false;
		if(isleaf=="Y"&&cateType==0){
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/category/getCountByIsLeaf",
				async : false,
				dataType : "json",
				data : {
					"id" : catasid
				},
				ajaxStart : function() {
					$("#loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass(
								"loading-inactive")
					}, 300);
				},
				success : function(response) {
					if (response.data >= '1') {
						$("#warning2Body").text("该品类下已经有商品，不能停用");
						$("#warning2").attr("style", "z-index:9999");
						$("#warning2").show();
							flag=true;
					}
				}
			});
		}
		if(flag){
			return false;
		}
		if (treeObj != "") {
			$.ajax({
						type : "post",
						url : __ctxPath + "/category/updateStatus",
						data : {
							"id" : treeObj[0].id,
							"categoryType":treeObj[0].categoryType
						},
						dataType : "json",
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						success : function(response) {
							if (response.status == "success") {
								$("#modal-body-success")
										.html(
												"<div class='alert alert-success fade in'>"
														+ "<strong>操作成功，返回列表页!</strong></div>");
								$("#modal-success")
										.attr(
												{
													"style" : "display:block;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-success"
												});
								if(treeObj[0].isLeaf=='Y'){
								    var treenode=treeObj[0].getParentNode();
								    tree.reAsyncChildNodes(treenode, "refresh");
								}else if(treeObj[0].isLeaf=='N'){
									var treenode=treeObj[0];
									tree.reAsyncChildNodes(treenode, "refresh");
									refreshAllZTree(); 
								}
								
							} else {
								$("#warning2Body").text(buildErrorMessage("",response.message));
						        $("#warning2").show();
							}
							/* refreshAllZTree(); */
						}
					});
		} else {
			$("#warning2Body").text(buildErrorMessage("","未选中节点！"));
	        $("#warning2").show();
			return;
		}
	}
	
	
	function deleteCategory(){
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
		var cateType=treeObj[0].categoryType;
		var catasid =treeObj[0].id;
		var isleaf =treeObj[0].isLeaf;
		var flag=false;
		if(isleaf=="Y"&&cateType==0){
			$.ajax({
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				url : __ctxPath + "/category/getCountByIsLeaf",
				async : false,
				dataType : "json",
				data : {
					"id" : catasid
				},
				ajaxStart : function() {
					$("#loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					setTimeout(function() {
						$("#loading-container").addClass(
								"loading-inactive")
					}, 300);
				},
				success : function(response) {
					if (response.data >= '1') {
						$("#warning2Body").text("该品类下已经有商品，不能删除");
						$("#warning2").attr("style", "z-index:9999");
						$("#warning2").show();
						flag=true;
					}
				}
			});
		}
		if(flag){
			return false;
		}
		if (treeObj != "") {
			$
					.ajax({
						type : "post",
						url : __ctxPath + "/category/del",
						dataType : "json",
						data : {
							"id" : treeObj[0].id,
							"categoryType":treeObj[0].categoryType
						},
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						success : function(response) {
							if (response.status == "success") {
								$("#modal-body-success")
										.html(
												"<div class='alert alert-success fade in'>"
														+ "<strong>操作成功，返回列表页!</strong></div>");
								$("#modal-success")
										.attr(
												{
													"style" : "display:block;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-success"
												});
								var tree= $.fn.zTree.getZTreeObj("treeDemo");
								if (treeObj[0].isLeaf=='Y') {
									if(treeObj[0].getParentNode().getParentNode()==null){
										refreshAllZTree(); 
									}else{
										var treenode=treeObj[0].getParentNode().getParentNode();
										tree.reAsyncChildNodes(treenode, "refresh");
									}
								}else if(treeObj[0].isLeaf=='N'){
									if(treeObj[0].getParentNode()==null||treeObj[0].getParentNode().id=="showCate"){
										refreshAllZTree(); 
									}else{
										var treenode=treeObj[0].getParentNode();
										tree.reAsyncChildNodes(treenode, "refresh");
									}
								}
							} else {
								$("#warning2Body").text(buildErrorMessage("",response.message));
						        $("#warning2").show();
							}
						}
					});
			
		} else {
			$("#warning2Body").text(buildErrorMessage("","未选中节点！"));
	        $("#warning2").show();
			return;
		}
	}
	

	
	// 删除
	function categoryDel() {
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var cateType=treeObj.getSelectedNodes()[0].categoryType;
		if(treeObj.getSelectedNodes()[0].id=="showCate"){
			$("#warning2Body").text("该级展示分类不能删除");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		if(cateType=="1"){
			$("#warning2Body").text("管理分类不能删除");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		if(cateType=="2"){
			$("#warning2Body").text("统计分类不能删除");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		confirmOkAndNo(function(){
	      	var sNodes = treeObj.getCheckedNodes(true);
	      	var resourceSid="";
	      	if (sNodes.length > 0) {
	      		for(var i=0;i<sNodes.length;i++){
	      			var tId = sNodes[i].id;
	      			resourceSid+=tId+",";
	      		}
	      	}
	      	deleteCategory();
		});
	}

	// 保存分类和修改分类
	function saveDivFrom() {
		/* 获取 zTree对象 */
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		/* 获取 zTree 当前被选中的节点数据集合 */
		var selectNodes = treeObj.getSelectedNodes();
		$("#divChannelSid").val(selectNodes[0].channelSid);
		if ($("#divSid").val() != '') {
			$("#divLevel").val(selectNodes[0].clevel);
		} else {
			$("#divLevel").val(selectNodes[0].clevel + 1);
		}
		$("#divRootSid").val(selectNodes[0].rootSid);
 
		$("#divTypeSid").val(selectNodes[0].categoryType);
		//判断是添加还是修改
		var sid = $("#divSid").val();
		if (sid != "") {
			$("#divId").val(selectNodes[0].pId=="showCate"?"0":selectNodes[0].pId);
		}
		var childName = $("#name").val();
		var entryCode = $("#entryCode2").val();
		var entryCode1 = $("#entryCode1").val();
		if(entryCode==entryCode1){
			 $("#entryCode2").val("");
			 $("#entryCode1").val("");
		}
		
		var cateType = $("#divTypeSid ").val();
// 		var newStatus = $("#divForm input[name='status']");
// 		var newStatu =null;
// 		newStatus.each(function(){
// 			if(this.checked==true){
// 				newStatu=$(this).val();
// 			}
// 		})
		if (childName == "" || childName == null) {
			$("#warning2Body").text("分类名称不能为空");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
 		if(cateType==0||cateType==2){
			if (entryCode == "" || entryCode == null) {
				$("#warning2Body").text("分类编码不能为空");
				$("#warning2").attr("style", "z-index:9999");
				$("#warning2").show();
				return;
			}
 		}
		if (childName.length > 60) {
			$("#warning2Body").text("分类名称大于60个字符");
			$("#warning2").attr("style", "z-index:9999");
			$("#warning2").show();
			return;
		}
		LA.sysCode = '10';
		LA.log("category.saveDivFrom", "统计分类添加保存：" + $("#divForm").serialize(), getCookieValue("username"), sessionId);
		$
				.ajax({
					type : "post",
					url : __ctxPath + "/category/add",
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
					data : $("#divForm").serialize(),
					success : function(response) {
						if (response.success == "true") {
							if(response.data=="添加成功"){
								$("#categoryDIV").hide();
								$("#CategoryViewSuccess").html(
										"<div class='alert alert-success fade in'>"
												+ "<strong>添加成功</strong></div>");
								$("#CategoryViewOneSuccess").attr({
									"style" : "display:block;",
									"aria-hidden" : "false",
									"class" : "modal modal-message modal-success"
								});
								if(selectNodes==""){
									refreshAllZTree();
									return;
								}
								var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
								if (selectNodes[0].isLeaf=="Y") {
									var parentNodes=selectNodes[0].getParentNode();	
									treeObj.reAsyncChildNodes(parentNodes, "refresh");
								}else if(selectNodes[0].isLeaf=="N"){
									 treeObj.reAsyncChildNodes(selectNodes[0], "refresh");
								}
							}else{
								/* updateNodesAfter(); */
								$("#categoryDIV").hide();
								$("#CategoryViewSuccess")
										.html(
												"<div class='alert alert-success fade in'>"
														+ "</i><strong>修改成功</strong></div>");
								$("#CategoryViewOneSuccess").attr({
									"style" : "display:block;",
									"aria-hidden" : "false",
									"class" : "modal modal-message modal-success"
								});
								$("#name").val("");
								var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
								var nodes =  $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
								if (nodes.length>0) {
									nodes[0].name=childName;
									treeObj.updateNode(nodes[0]);
								}
								if (nodes[0].isLeaf=="Y") {
									   var parentNodes=nodes[0].getParentNode();	
									   treeObj.reAsyncChildNodes(parentNodes, "refresh");
								}else if(nodes[0].isLeaf=="N"){
									refreshAllZTree();
									   var treenode=nodes[0];
										treeObj.reAsyncChildNodes(treenode, "refresh");
// 										if(newStatu=="Y"){
// 											alert("y");
// 											nodes[0].status="Y";
// 										}else{
// 											alert("n");
// 											nodes[0].status="N";
// 										}
// 										nodes[0].status="Y";
// 										alert(nodes[0].status)
// 										treeObj.updateNode(treenode);;
								}
							}
						}else {
							$("#categoryDIV").hide();
							$("#CategoryViewSuccess")
									.html(
											"<div class='alert alert-success fade in'>"
													+ "</i><strong>"+response.data.errorMsg+"</strong></div>");
							$("#CategoryViewOneSuccess").attr({
								"style" : "display:block;",
								"aria-hidden" : "false",
								"class" : "modal modal-message modal-success"
							});
							$("#name").val("");
						}
						
					}
					
				});
	}

	// 编辑保存分类和属性
	function saveDivFrom2() {

		var notNull = new Array();
		$("#selectedProps option").each(function(j) {
			var propsid = $(this).val();
			if ($(this).attr("notNull")!="0") {
				notNull.push({
					'notNull' : 1,
					'propsid' : propsid
				});
			}else{
			
				notNull.push({
					'notNull' : 0,
					'propsid' : propsid
				});
			}
		});
		insert1 = JSON.stringify(notNull);
		insert1 = insert1.replace(/\%/g, "%25");
		insert1 = insert1.replace(/\#/g, "%23");
		insert1 = insert1.replace(/\&/g, "%26");
		insert1 = insert1.replace(/\+/g, "%2B");
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
		$.ajax({
			type : "post",
			url : __ctxPath + "/provalues/add",
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			data : {
				'cid' : treeObj[0].id,
				'propsid' : $("#Div2PropsSid").val(),
				'name' : $("#name2").val(),
				'notNull' : insert1
			},
			success : function(response) {
				/* alert(treeObj[0].id); */
				if (response.success == 'true') {
					$("#modal-body-success").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>" + response.message
									+ "，返回列表页!</strong></div>");
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					
					
				} else {
					$("#modal-body-success").html(
							"<div class='alert alert-success fade in'>"
									+ "<strong>" + response.message
									+ "，返回列表页!</strong></div>");
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
					
				}
				$("#categoryDIV2").hide();
				$("#pdict").val("");
				$("#div2Table").html("");
				categoryQuery(treeObj[0].id);
			}
		});
	}
	/* 维护按钮 */
	function updateRole() {
		$("#selectedProps").html("");
		$("#pdict").val("");
		/* 获取 zTree对象 */
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		/* 获取 zTree 的全部节点数据 */
		var nodes = treeObj.getNodes();
		/* 获取 zTree 当前被选中的节点数据集合 */
		var selectNodes = treeObj.getSelectedNodes();
		if (selectNodes != '') {
			$
					.ajax({
						url : __ctxPath + "/propvals/edit?id="
								+ selectNodes[0].id,
						dataType : "json",
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						async : false,
						success : function(response) {
							if (response.status == "Y") {
								$("#name2").val(response.name);
								$("#cateCode2").val(response.categoryCode);
								$("#Div2PropsSid").val(response.propsid);
								propsid = response.propsid;
								notNull = response.notNull;
								/* $("#headtitle")
										.html(
												"<tr><td width='50px'>选择</td><td width='100px'>属性</td><td width='250px'>属性描述</td><td width='89px'>是否为必填</td><td width='17px'></tr>");
								$
								$("#div2Table")
								.html(
										"<tr style='display:none'><td width='16.5%'></td><td width='35.6%'>属性</td><td width='35.6%'>属性描述</td><td width='50%'>是否为必选</td></tr>");
						 */
										$.ajax({
											url : __ctxPath
													+ "/propscombox/list?id="
													+ selectNodes[0].id,
											dataType : "json",
											ajaxStart : function() {
												$("#loading-container").attr(
														"class",
														"loading-container");
											},
											ajaxStop : function() {
												//隐藏加载提示
												setTimeout(
														function() {
															$(
																	"#loading-container")
																	.addClass(
																			"loading-inactive")
														}, 300);
											},
											async : false,
											success : function(response) {
												var result = response;
												var option = "";
												//循环正常属性列表与已经选中的做比较
												for (var i = 0; i < result.length; i++) {
													var ele = result[i];
													
													option += "<tr id='seleProp_"+ele.propsSid+"'>"
															+ "<td width='11%' style='vertical-align: text-top;padding: 0px;'>"
															+ "<div class='checkbox'><label>"
															+ "<input type='checkbox' div2TableCheck='on' propsid='"+ele.propsSid+"' value="+ele.propsName+" >"
															+ "<span class='text' style='margin:5px 0 9px -9px;'></span></label>"
															+ "</div>"
															+ "</td>"
															+ "<td width='22%' style='padding: 0px;'>"
															+ ele.propsName
															+ "</td>"
															+ "<td width='50%' style='padding: 0px;'>"
															+ ele.propsDesc
															+ "</td>"
															+ "<td width='17%' style='padding: 0px;'>"
															+ "<div class='checkbox'><label>"
															+ "<input type='checkbox' onCheck2='ch'  onCheck2Sid='"+ele.propsSid+"' name='propsName_"+ele.propsSid+"'>"
															+ "<span class='text'></span></label>"
															+ "</div>"
															+ "</td>" + "</tr>";
												}
												$("#div2Table").html(option);
												var id = "";
												var selectOption = "";
												$("#div2Table input[div2TableCheck='on']").each(function(i) {
													for (var j = 0; j < propsid.length; j++) {
														// 已经关联的和列表ID一样打勾
														id=$(this).attr("propsid");
														if (propsid[j] == id) {
															$(this).attr("checked","checked");
															$("#seleProp_"+id).hide();
															selectOption += "<option value='"+id+"' notNull='0'>"+$(this).val()+"</option>";
														}
													}
												});
												$("#selectedProps").html(selectOption);
												$("#div2Table input[onCheck2='ch']").each(function(i) {
													for (var j = 0; j < notNull.length; j++) {
														// 已经关联的和列表ID一样打勾
														if (propsid[j] == $(this).attr("onCheck2Sid")) {
															if (notNull[j] == 1) {
																$(this).attr("checked","checked");
																$("#selectedProps option[value='"+$(this).attr("onCheck2Sid")+"']").attr("notNull","1");
															}
														}
													}
												});
											}
										});
								
								$("#categoryDIV2").show();
							} else {
								$("#warning2Body").text(buildErrorMessage("","无效分类,无法维护！"));
						        $("#warning2").show();
							}
						}
					});
		} else {
			$("#warning2Body").text(buildErrorMessage("","未选中分类节点！"));
	        $("#warning2").show();
		}
	}
	/* 属性列表中的tr内容被选中触发 */
	function div2TrChange() {
		var propsid = new Array();
		var names = "";
		$("#div2Table input[div2TableCheck='on']:checked").each(function(i) {
			propsid.push($(this).attr('propsid'));
		});
		$("#Div2PropsSid").val(propsid);

	}
	/* 属性列表搜索按钮 */
	function divTabApp_Search() {
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
		var propsName = $("#pdict").val();
		/* $("#headtitle")
				.html(
						"<tr><td width='16%'>选择</td><td width='34.6%'>属性</td><td width='34.6%'>属性描述</td><td width='50%'>是否为必填</td></tr>");
		$
		$("#div2Table")
		.html(
				"<tr style='display:none'><td width='16%'></td><td width='34.6%'>属性</td><td width='34.6%'>属性描述</td><td width='50%'>是否为必选</td></tr>");
 */
 				$.ajax({
					type : "post",
					url : __ctxPath + "/propscombox/list",
					data : {
						"id" : treeObj[0].id,
						"propsName" : propsName
					},
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
					async : false,
					success : function(response) {
						var result = response;
						var option = "";
						//循环正常属性列表与已经选中的做比较
						for (var i = 0; i < result.length; i++) {
							var ele = result[i];
							option += "<tr id='seleProp_"+ele.propsSid+"'>"
									+ "<td width='11%' style='vertical-align: text-top;padding: 0px;'>"
									+ "<div class='checkbox'><label>"
									+ "<input type='checkbox' div2TableCheck='on' propsid='"+ele.propsSid+"' value="+ele.propsName+" >"
									+ "<span class='text' style='margin:5px 0 9px -9px;'></span></label>"
									+ "</div>"
									+ "</td>"
									+ "<td width='22%' style='padding: 0px;'>"
									+ ele.propsName
									+ "</td>"
									+ "<td width='50%' style='padding: 0px;'>"
									+ ele.propsDesc
									+ "</td>"
									+ "<td width='17%' style='padding: 0px;'>"
									+ "<div class='checkbox'><label>"
									+ "<input type='checkbox' onCheck2='ch'  onCheck2Sid='"+ele.propsSid+"' name='propsName_"+ele.propsSid+"'>"
									+ "<span class='text'></span></label>"
									+ "</div>"
									+ "</td>" + "</tr>";
						}
						$("#div2Table").html(option);
						var id = "";
						var selectOption = "";
						$("#div2Table input[div2TableCheck='on']").each(function(i) {
							for (var j = 0; j < propsid.length; j++) {
								// 已经关联的和列表ID一样打勾
								id=$(this).attr("propsid");
								if (propsid[j] == id) {
									$(this).attr("checked","checked");
									$("#seleProp_"+id).hide();
								}
							}
						});
						$("#selectedProps option").each(function(){
							$("#seleProp_"+$(this).val()).hide();
							$("#div2Table input[propsid='"+$(this).val()+"']").attr("checked","checked");
							if($(this).attr("notNull")=="1"){
								$("#div2Table input[name='propsName_"+$(this).val()+"']").attr("checked","checked");
							}
						});
						$("#div2Table input[onCheck2='ch']").each(function(i) {
							for (var j = 0; j < notNull.length; j++) {
								// 已经关联的和列表ID一样打勾
								if (propsid[j] == $(this).attr("onCheck2Sid")) {
									if (notNull[j] == 1) {
										$(this).attr("checked", "checked");
									}
								}
							}
						});
					}
				});
	}
	/* 成功确定按钮 */
	function successBtn() {
		$("#categoryDIV").hide();
		$("#categoryDIV2").hide();
		$("#appGBFLDiv").hide();
		$("#modal-success").hide();
		$("#CategoryViewOneSuccess").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
		if(!treeObj[0]=='undefined'){
			categoryQuery(treeObj[0].id);
		}
	}

	/* 节点刷新 */
	function updateNodesAfter(){
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes =  $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
	    var names= $("input[name='name']").val();
		if (nodes.length>0) {
			
			treeObj.updateNode(nodes[0]);
		}
	}
	
	/* 成功确定按钮使用异步刷新ztree和右侧列表 */
	function refuseZtree() {
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
		if (treeObj != "") {
			updateNodesAfter();
		}
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/list",
			async : false,
			dataType : "json",
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				/* zTree使用 */
				var zTreeCate = new Array();
				for(var i=0;i<response.length;i++){
					if(response[i].categoryType==2){
						zTreeCate.push(response[i]);
					}
				}
				if(zTreeCate.length != 0){
					$.fn.zTree.init($("#treeDemo"), setting, zTreeCate);
				}
			}
		});
	}
	function closeCategoryDiv() {
		$("#categoryDIV").hide();
		$("#categoryDIV2").hide();
		$("#appGBFLDiv").hide();
		$("#name").val("");
	}
</script>
<script type="text/javascript">
	function leftToRight(){
		var selectedProps = $("#selectedProps");
		$("#div2Table input[div2TableCheck='on']:checked").each(function(){
			var propsid = $(this).attr("propsid");
			if($("#seleProp_"+propsid).css("display")!="none"){
				$("#seleProp_"+propsid).hide();
				selectedProps.append("<option value='"+propsid+"' notNull='0'>"+$(this).val()+"</option>");
			}
		});
		$("#div2Table input[onCheck2='ch']:checked").each(function(i) {
			$("#selectedProps option[value='"+$(this).attr("onCheck2Sid")+"']").attr("notNull","1");
		});
		getDiv2PropsSid();
	}
	function rightToLeft(){
		$("#selectedProps option:selected").each(function(){
			$("#seleProp_"+$(this).val()).show();
			$(this).remove();
			$("#div2Table input[name='propsName_"+$(this).val()+"]").prop("checked","checked");
		});
		getDiv2PropsSid();
	}
	function getDiv2PropsSid() {
		var propsid = new Array();
		var names = "";
		$("#selectedProps option").each(function(i) {
			propsid.push($(this).val());
		});
		$("#Div2PropsSid").val(propsid);
	}
</script>
<script type="text/javascript">
	function find(){
		LA.sysCode = '10';
		LA.log("category.find", "统计分类根据编码查询：" + $("#categoryCode").val(), getCookieValue("username"), sessionId);
		refreshAllZTree();
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/category/findAllParentCategoryByParam1",
			async : false,
			dataType : "json",
			data : {
				"categoryType" : "2",
				"categoryCode" : $("#categoryCode").val()
			},
			ajaxStart : function() {
				$("#loading-container").attr("class", "loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				}, 300);
			},
			success : function(response) {
				if(response.success == "true"){
				    if(response.data != ""){
				    	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
						isAutoOpen = true;
						list_1 = response.data;
						//var selectNode;
						index_1 = list_1.length - 1;
						var node = treeObj.getNodeByParam("id", list_1[index_1].sid);
						treeObj.expandNode(node, true, true, true);
				    } else {
				    	$("#warning2Body").text(buildErrorMessage("","分类编码不存在！"));
				        $("#warning2").show();
				    }
				}
			}
		});
	}
	
	function reset(){
		$("#categoryCode").val("");
		refreshAllZTree();
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
						<div class="col-md-4" style="width:40%;float:left;">
	                        <div class="well clearfix" style="padding: 10px;">
	                            <div class="">
	                                <a class="notbtn purple btn-sm fa fa-star" style="width: 99.9%">&nbsp;统计分类树信息</a>
	                            </div>
	                            &nbsp;
	                            <div class="">
	                                <a class="btn btn-default purple btn-sm fa fa-plus" style="margin-top: -5px;" id="addbutton" onclick="append()">&nbsp;添加</a>&nbsp;&nbsp;&nbsp;
	                                <!-- <a class="btn btn-default purple btn-sm fa fa-edit" onclick="edit()">&nbsp;修改</a>
	                                <a class="btn btn-default purple btn-sm fa fa-stop" onclick="categoryDisable()">&nbsp;停用</a>
	                                <a class="btn btn-default purple btn-sm fa fa-trash-o" onclick="categoryDel()">&nbsp;删除</a> -->
	                                <span>编码：</span>
	                                <input type="text" id="categoryCode" style="height:26px;"/>&nbsp;&nbsp;
	                                <a onclick="find();" class="btn btn-default btn-sm" style="margin-top: -5px;">查询</a>
	                                <a onclick="reset();" class="btn btn-default btn-sm" style="margin-top: -5px;">重置</a>
	                            </div>
	                            &nbsp;
	                            <div class="" style="height: 345px;overflow: auto;">
	                                <ul id="treeDemo" class="ztree"></ul>
	                            </div>
	                            &nbsp;
	                        </div>
	                    </div>
						<input type="hidden" id="prodCateButton" value="2"></input>
	                    <div style="width:58%;float:left;display: none;">
	                        <div class="widget">
	                        	<div class="widget-header ">
	                                <h5 class="widget-caption" id="widget"></h5>
	                                <div class="widget-buttons">
	                                    <a href="#" data-toggle="maximize"></a>
	                                    <a href="#" data-toggle="collapse" onclick="tab('pro');">
	                                        <i class="fa fa-minus" id="pro-i"></i>
	                                    </a>
	                                    <a href="#" data-toggle="dispose"></a>
	                                </div>
	                            </div>
	                            <form id="category_form" action="">
	                                <input type="hidden" id="cid" name="cid" />
	                            </form>
	                            <div class="widget-body" id="pro">
	                                <div class="table-toolbar">
	                                    <div class="btn-group pull-right">
	                                        <div class="col-md-12">
	                                            <a id="editabledatatable_new" onclick="updateRole();"
	                                               class="btn btn-default purple btn-sm fa fa-edit"> 维护 </a>
	                                        </div>
	                                        &nbsp;
	                                    </div>
	                                </div>
	                                <table class="table table-bordered table-striped table-condensed table-hover flip-content">
	                                    <thead class="flip-content bordered-darkorange">
	                                    <tr role="row">
	                                        <th width="10%"></th>
	                                        <th width="15%">属性编号</th>
	                                        <th width="22%">属性名称</th>
	                                        <th width="15%">属性类型</th>
	                                        <th width="15%">分类编号</th>
	                                        <th width="20%">分类名称</th>
	                                        <th width="14px"></th>
	                                    </tr>
	                                    </thead>
	                                </table>
	                                <div style="height: 326px;overflow-y: scroll;">
	                                <table
	                                        class="table table-bordered table-striped table-condensed table-hover flip-content"
	                                        id="category_tab">
	                                    <!-- <thead class="flip-content bordered-darkorange">
	                                    <tr role="row">
	                                        <th width="35px;"></th>
	                                        <th>属性编号</th>
	                                        <th>属性名称</th>
	                                        <th>属性类型</th>
	                                        <th>分类编号</th>
	                                        <th>分类名称</th>
	                                    </tr>
	                                    </thead> -->
	                                    <tbody>
	                                    </tbody>
	                                </table>
	                                </div>
	                               <!--  <div id="categoryPagination"></div> -->
	                            </div>
	                            <!-- Templates -->
	                            <p style="display: none">
										<textarea id="category-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX" id="gradeX{$T.Result.propsSid}">
													<td width="10%" align="center" style="vertical-align:middle;cursor:pointer;" onclick="spanTd({$T.Result.propsSid},{$T.Result.categorySid},{$T.Result.channelSid})">
														<span id="spanTd_{$T.Result.propsSid}" class="expand-collapse click-expand glyphicon glyphicon-plus"></span>
													</td>
													<td width="15%" id="sid_{$T.Result.sid}" style="vertical-align:middle;">
														{$T.Result.propsSid}
													</td>
													<td width="22%" id="roleName_{$T.Result.sid}" style="vertical-align:middle;">{$T.Result.propsName}</td>
													<td width="15%" id="roleName_{$T.Result.sid}" style="vertical-align:middle;">
														{#if $T.Result.isEnumProp == 0}枚举
						                      			{#elseif $T.Result.isEnumProp == 1}文本
						                   				{#/if}
													</td>
													<td width="15%" id="roleCode_{$T.Result.sid}" style="vertical-align:middle;">{$T.Result.categorySid}</td>
													<td width="20%" id="createdTime_{$T.Result.sid}" style="vertical-align:middle;">{$T.Result.categoryName}</td>
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
									</p>
	                        </div>
                        </div>
					</div>
				</div>
				<!-- Add DIV root classification used -->
				<div class="modal modal-darkorange" style="margin: 40px auto;"
					id="appGBFLDiv">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button" onclick="closeCategoryDiv();">×</button>
								<h4 class="modal-title">根部分类信息</h4>
							</div>
							<div class="modal-body">
								<div class="bootbox-body">
									<div class="row" style="padding: 10px;">
										<div class="col-lg-12 col-sm-12 col-xs-12">
											<form id="appGBFLDivForm" method="post"
												class="form-horizontal" enctype="multipart/form-data" onsubmit="return false">
												<input type="hidden" id="appGBFLDivId" name="id" /> <input
													type="hidden" id="appGBFLDivSid" name="sid" /> <input
													type="hidden" id="appGBFLDivIsParent" name="isParent" />
												<div class="col-md-12">
													<div class="col-lg-3">根部分类名称:</div>
													<div class="col-lg-9">
														<input type="text" placeholder="必填" id="appGBFLDivName"
															name="name" style="width: 90.9%" /><strong
															style="color: red">※</strong>
													</div>
													&nbsp;
												</div>
												<div class="col-md-6">
													<div class="col-lg-12" id="appendSelect">
													分类类别:
														<!-- 分类类别: <select name="categoryType"
															id="appGBFLDivType" style="width: 99.9%">
															<option value="0" selected="selected">工业分类</option>
															<option value="2">统计分类</option>
															<option value="3">展示分类</option>
														</select> -->
													</div>
												</div>
												<div class="col-md-6" id="channelid">
													<div class="col-lg-12">
														渠道: <select name="channelSid" id="appGBFLDivChannel"
															style="width: 99.9%">
<!-- 															<option value="0">全渠道</option> -->
														</select>
													</div>
													&nbsp;
												</div>
<!-- 												<div id="storeid" class="col-md-6" style="display: none"> -->
<!-- 													<div class="col-lg-12"> -->
<!-- 														门店: <input type="hidden" id="type" value="3"> <select -->
<!-- 															name="shopSid" id="appGBFLDivOrganiztion" -->
<!-- 															style="width: 99.9%"> -->
<!-- 															<option>--请选择门店--</option> -->
<!-- 														</select> -->
<!-- 													</div> -->
<!-- 													&nbsp; -->
<!-- 												</div> -->

												<div class="col-lg-6">
													<div class="col-md-12">
														<div class="radio">
															状态: <label> <input class="basic" type="radio"
																id="hrootstatus" name="status" value="Y" checked> <span
																class="text">有效</span>
															</label> <label> <input class="basic" type="radio"
																id="nrootstatus" name="status" value="N"> <span
																class="text">无效</span>
															</label>
														</div>
														<div class="radio" style="display: none;">
															<label> <input class="inverted" type="radio"
																name="status"> <span class="text"></span>
															</label>
														</div>
													</div>
												</div>
												<!-- <div class="col-lg-6" style="display: none">
													<div class="col-md-12">
														<div class="radio">
															显示: <label> <input class="basic" type="radio"
																id="yisdisplay" name="isDisplay" value="1" checked="checked"> <span
																class="text">显示</span>
															</label> <label> <input class="basic" type="radio"
																name="isDisplay" value="0"> <span class="text">不显示</span>
															</label>
														</div>
														<div class="radio" style="display: none;">
															<label> <input class="inverted" type="radio"
																name="isDisplay"> <span class="text"></span>
															</label>
														</div>
													</div>
												</div> -->
											</form>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button class="btn btn-default" type="button"
									onclick="appGBFLDivSave();">保存</button>
								<button data-dismiss="modal" class="btn btn-default"
									onclick="closeCategoryDiv();" type="button">取消</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- Add DIV root classification used ||| End -->
				<!-- Add DIV classification used -->
				<div class="modal modal-darkorange" id="categoryDIV">
					<div class="modal-dialog" style="width: 400px; margin: 100px auto;">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button" onclick="closeCategoryDiv();">×</button>
								<h4 class="modal-title">分类信息</h4>
							</div>
							<div class="modal-body">
								<div class="bootbox-body">
									<div class="row" style="padding: 10px;">
										<div class="col-md-12">
											<form id="divForm" method="post" class="form-horizontal"
												enctype="multipart/form-data" onsubmit="return false">
												<input type="hidden" id="divId" name="id" /> <input
													type="hidden" id="divSid" name="sid" />
												<!-- 父级sids -->
												<input type="hidden" id="divChannelSid" name="channelSid" />
												<input type="hidden" id="divTypeSid" name="categoryType" />
												<input type="hidden" id="divLevel" name="level" /> <input
													type="hidden" id="divIsParent" name="isParent" value="0" />
												<input type="hidden" id="divRootSid" name="rootSid">
<!-- 												<input type="hidden" id="divShopSid" name="shopSid"> -->
												<input type="hidden" id="divIsLeaf" name="isLeaf">
												<div class="form-group">
													分类名称： <input type="text" placeholder="必填"
														class="form-control" id="name" name="name" >
												</div>
												<div class="form-group" id="entryCodeDiv2" style="display:none">
													分类编码： <input type="text" placeholder="必填" onkeyup="value=value.replace(/[^0-9- ]/g,'');"
														class="form-control" id="entryCode2" name="entryCode" >
												</div>
												<div class="form-group">
													状态
													<div class="radio">
														<label> <input class="basic" type="radio"
															id="status1" name="status" value="Y" checked="checked"> <span
															class="text">有效</span>
														</label> <label> <input class="basic" type="radio"
															id="status0" name="status" value="N" > <span
															class="text">无效</span>
														</label>
													</div>
													<div class="radio" style="display: none;">
														<label> <input class="inverted" type="radio"
															name="status"> <span class="text"></span>
														</label>
													</div>
												</div>
												<!-- <div class="form-group" style="display: none">
													显示状态
													<div class="radio">
														<label> <input class="basic" type="radio"
															id="isDisplay1" name="isDisplay" value="1" checked="checked"> <span
															class="text">显示</span>
														</label> <label> <input class="basic" type="radio"
															id="isDisplay0" name="isDisplay" value="0"> <span
															class="text">不显示</span>
														</label>
													</div>
													<div class="radio" style="display: none;">
														<label> <input class="inverted" type="radio"
															name="isDisplay"> <span class="text"></span>
														</label>
													</div>
												</div> -->
											</form>
											<input type="hidden"id="entryCode1" name="entryCode1" >
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button class="btn btn-default" type="button"
									onclick="saveDivFrom();">保存</button>
								<button data-dismiss="modal" class="btn btn-default"
									onclick="closeCategoryDiv();" type="button">取消</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- Add DIV classification used ||| End-->
				<div class="modal modal-darkorange" id="categoryDIV2">
					<div class="modal-dialog" style="margin: 60px auto;width:700px;">
						<div class="modal-content">
							<div class="modal-header">
								<button aria-hidden="true" data-dismiss="modal" class="close"
									type="button" onclick="closeCategoryDiv();">×</button>
								<h4 class="modal-title">属性信息</h4>
							</div>
							<div class="modal-body">
								<div class="bootbox-body">
									<div class="row" style="padding: 10px;">
										<div class="col-lg-12 col-sm-12 col-xs-12">
											<form id="div2Form" method="post" class="form-horizontal"
												enctype="multipart/form-data">
												<div class="col-md-12">
													<div class="col-lg-6">分类名称：</div>
													<div class="col-lg-6">分类编码：</div>
													<div class="col-lg-6">
														<span class="input-icon icon-right"> <input
															type="text" placeholder="Name" readonly="readonly"
															id="name2" name="name" class="form-control" style="width:100%;">
														</span> <input type="hidden" id="Div2PropsSid" />
													</div>
													<div class="col-lg-6">
														<span class="input-icon icon-right"> <input
															type="text" placeholder="0" readonly="readonly"
															id="cateCode2" class="form-control" style="width:100%;"> 
														</span>
													</div>
												</div>
												<div class="col-md-12">
													<div class="col-lg-12">属性名称：</div>
													<div class="col-lg-12">
														<span class="input-icon icon-right"> <input type="text" style="width:100%;"
															id="pdict" name="propsid" class="form-control input-sm">
															<i class="glyphicon glyphicon-search danger"
															onclick="divTabApp_Search()"
															style="left: 93.5%; cursor: pointer;"></i>
														</span>
														<select size="7" multiple="multiple" id="selectedProps"
															 style="height: 276px;width:150px;color:black;
															 font-size: 14px;float: right;margin: 15px 0 0 0;">
														</select>
														<div style="height: 156px;width:30px;color:black;
															 font-size: 20px;float: right;margin: 120px 5px 0 5px;">
															<a onclick="leftToRight();" class="btn btn-default purple btn-sm"> > </a>
															<br>
															<a onclick="rightToLeft();" class="btn btn-default purple btn-sm"> < </a>
														</div>
														<!-- 自定义滚动条 -->
														<table id="headtitle" class="mt15 table table-bordered" style="float: left;width:400px;">
															<tr>
																<td width='11%'>选择</td>
																<td width='22%'>属性</td>
																<td width='50%'>属性描述</td>
																<td width='17%'>是否必填</td>
																<td width=''></td>
															</tr>
														</table>
														<div class="table-bordered" style="overflow-y: scroll; height: 240px;float: left;width:400px;">
															<table class="table table-bordered" id="div2Table">
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
								<button class="btn btn-default" type="button"
									onclick="saveDivFrom2();">保存</button>
								<button data-dismiss="modal" class="btn btn-default"
									onclick="closeCategoryDiv();" type="button">取消</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
			</div>
		</div>
	</div>
	<div aria-hidden="true" style="display: none;"
		class="modal modal-message modal-success fade"
		id="CategoryViewOneSuccess">
		<div class="modal-dialog" style="margin: 150px auto;">
			<div class="modal-content">
				<div class="modal-header">
					<h5>温馨提示</h5>
				</div>
				<div class="modal-body" id="CategoryViewSuccess">You have done
					great!</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-success" type="button"
						onclick="successBtn()">确定</button>
				</div>
			</div>
			<!-- / .modal-content -->
		</div>
		<!-- / .modal-dialog -->
	</div>
</body>
</html>