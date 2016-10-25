<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setAttribute("ctx", request.getContextPath());%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/js/jquery.ztree.all-3.5.min.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>

<link rel="stylesheet" href="${ctx}/css/zTreeStyle/metro.css">
<title>商品基本信息</title>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	var sessionId = "<%=request.getSession().getId() %>";
	var zNodes="";
	$(function(){
		$("#sid").val(sid);
		$("#roleName").val(roleName_);
		$("#roleCode").val(roleCode_);
		$("#roleSid1").val(sid);
		$("#roleName1").val(roleName_);
		$("#roleCode1").val(roleCode_);
		
  		$("#save").click(function(){
  			aquireNodeIds();
  			//saveFrom();
  		});
  		$("#close").click(function(){
  			$("#pageBody").load(__ctxPath+"/jsp/userRole.jsp");
  		});
  		$.ajax({
 			type:"post",
	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
	        url:__ctxPath + "/limitRoleResource/getLimitResources",
	        dataType: "json",
	        data: $("#theForm").serialize(),
	        success:function(response) {
					//alert(response.list);
	        	zNodes=response.list;
	        	$("#znodes").val(zNodes);
	        	//alert(zNodes);
	        	var t = $("#tree");
	            t = $.fn.zTree.init(t, setting2, zNodes);
       	}
		});
	});
	function aquireNodeIds(){
		bootbox.confirm("确定要保存吗?", function(r){
			if(r){
				var treeObj = $.fn.zTree.getZTreeObj("tree");
	      		var sNodes = treeObj.getCheckedNodes(true);
	      		var resourceSid="";
	      		if (sNodes.length > 0) {
	      		for(var i=0;i<sNodes.length;i++){
	      			var tId = sNodes[i].id;
	      			resourceSid+=tId+",";
	      			}
	      		}
	      		$("#resourceSid").val(resourceSid);
	      		saveFrom();
			}
		});
			
		/**
		选中某个节点
		var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.checkNode(zTree.getNodeByParam( 101), true );
		**/
	}
  	//保存数据
  	
  	function saveFrom(){
  		LA.sysCode = '10';
  		LA.log("role.savaLimitRoleResource", "修改角色资源权限：" + $("#theForm").serialize(), getCookieValue("username"), sessionId);
  		$.ajax({
  			 type:"post",
 	        contentType: "application/x-www-form-urlencoded;charset=utf-8",
 	        url:__ctxPath + "/limitRoleResource/savaLimitRoleResource",
 	        dataType: "json",
 	        data: $("#theForm").serialize(),
	        success:function(response) {
	        	if(response.success == 'true'){
					$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
						"<strong>保存成功，返回列表页!</strong></div>");
  	  				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
				}else{
					$("#warning2Body").text(buildErrorMessage("","保存失败！"));
					$("#warning2").show();
				}
        	}
		});
  	}
  	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#pageBody").load(__ctxPath+"/jsp/userRole.jsp");
	}
  	
  	 var zTree;
     var demoIframe;

     var setting = {
         check: {
             enable: true
         },
         view: {
             dblClickExpand: false,
             showLine: true,
             selectedMulti: false
         },
         data: {
             simpleData: {
                 enable:true,
                 idKey: "id",
                 pIdKey: "pId",
                 rootPId: ""
             }
         },
         callback: {
             beforeClick: function(treeId, treeNode) {
                 var zTree = $.fn.zTree.getZTreeObj("tree");
                 if (treeNode.isParent) {
                     zTree.expandNode(treeNode);
                     return false;
                 } else {
                     demoIframe.attr("src",treeNode.file + ".html");
                     return true;
                 }
             }
         }
     };

     var setting2 = {
    		 check: {
                 enable: true
             },
             view: {
                 dblClickExpand: false,
                 showLine: true,
                 selectedMulti: false
             },
             data: {
                 simpleData: {
                     enable:true,
                     idKey: "id",
                     pIdKey: "pId",
                     rootPId: ""
                 }
             },
			async : {
				enable : true,
				url : __ctxPath + "/rolePermission/ajaxAsyncList",
				dataType : "json",
				autoParam : [ "id", "channelSid", "shopSid", "categoryType" ],
				otherParam : {
					"roleSid" : sid
				},
				dataFilter : filter
			},
			callback : {
				beforeClick: function(treeId, treeNode) {
		                var zTree = $.fn.zTree.getZTreeObj("manageCateTree");
		                if (treeNode.isParent) {
		                    zTree.expandNode(treeNode);
		                    return false;
		                } else {
		                    demoIframe.attr("src",treeNode.file + ".html");
		                    return true;
		                }
		            },
				onCheck : function(event, treeId, treeNode) {
					if(treeNode.clevel == 3){
						var treeObj = $.fn.zTree.getZTreeObj("manageCateTree");//获取ztree对象  
						treeObj.expandNode(treeNode, true, true, true);
					}
				},
				onAsyncSuccess : function(event, treeId, treeNode, msg) {
					if(treeNode.clevel == 3 && treeNode.checked == true){
						var zTreeCate = new Array();
						var treeObj = $.fn.zTree.getZTreeObj("manageCateTree");
						treeObj.removeChildNodes(treeNode);
						for(var i=0;i<msg.length;i++){
							var node = msg[i]
							node.checked=true;
							zTreeCate.push(node);
						}
						treeObj.addNodes(treeNode,zTreeCate,false);
					}
				}
			}
		};	
  
     function loadReady() {
         var bodyH = demoIframe.contents().find("body").get(0).scrollHeight,
                 htmlH = demoIframe.contents().find("html").get(0).scrollHeight,
                 maxH = Math.max(bodyH, htmlH), minH = Math.min(bodyH, htmlH),
                 h = demoIframe.height() >= maxH ? minH:maxH ;
         if (h < 530) h = 530;
         demoIframe.height(h);
     }
     function filter(treeId, parentNode, childNodes) {
 		if (!childNodes)
 			return null;
 		for (var i = 0, l = childNodes.length; i < l; i++) {
 			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
 		}
 		return childNodes;
 	 }
	</script> 
<script type="text/javascript">
	function leftToRight(id1, id2){
		$("#"+id1+" option:selected").each(function(){
			$(this).appendTo($("#"+id2));
		});
		loadManageCateTree();
	}
	function rightToLeft(id1, id2){
		$("#"+id1+" option:selected").each(function(){
			$(this).appendTo($("#"+id2));
		});
		loadManageCateTree();
	}
	function getDiv2PropsSid() {
		var shopSids = "", shopGroupSids = "", channelSids = "";
		$("#shopSid1 option").each(function(){
			shopSids += $(this).attr("code") + ",";
			shopGroupSids += $(this).attr("groupSid") + ",";
		});
		$("#channelSid1 option").each(function(){
			channelSids += $(this).attr("value") + ",";
		});
		$("#shopSids").val(shopSids);
		$("#shopGroupSids").val(shopGroupSids);
		$("#channelSids").val(channelSids);
	}

var shopPermission,channelPermission,manageCatePermission;
var allManageCateRoot;
function selectAllPermission(){
	$.ajax({
        type : "post",
        contentType : "application/x-www-form-urlencoded;charset=utf-8",
        url : __ctxPath + "/rolePermission/getRolePermissionsByRoleSid",
        dataType : "json",
        async : false,
        data : {
        	"roleSid" : $("#roleSid1").val()
        },
        success : function(response) {
            if(response.success){
            	shopPermission = response.shopPermission;
            	channelPermission = response.channelPermission;
            	manageCatePermission = response.manageCatePermission;
            }
            return;
        },
        error : function(XMLHttpRequest, textStatus) {
            var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
            if(sstatus != "sessionOut"){
                $("#warning2Body").text("系统错误!");
                $("#warning2").show();
            }
            if(sstatus=="sessionOut"){
                $("#warning3").css('display','block');
            }
        }
    });
}
function selectAllShop(){
	$.ajax({
        type : "post",
        contentType : "application/x-www-form-urlencoded;charset=utf-8",
        url : __ctxPath + "/shoppe/queryShopList",
        dataType : "json",
        async : false,
        data : "organizationType=3",
        success : function(response) {
            var result = response.list;
            for (var i = 0; i < result.length; i++) {
            	var isAdd = true;
            	var ele = result[i];
            	var option = $("<option value='" + ele.sid + "' code='"
            			  + ele.organizationCode + "' groupSid='" + ele.groupSid + "'>" + ele.organizationName + "</option>");
            	for(var j = 0; j < shopPermission.length; j++){
            		var permission = shopPermission[j];
            		if(ele.organizationCode == permission.permission 
            				&& ele.groupSid == permission.col1){
            			option.appendTo($("#shopSid1"));
            			isAdd = false;
            			break;
            		}
            	}
            	if(isAdd){
            		option.appendTo($("#shopSid"));
            	}
            }
            return;
        },
        error : function(XMLHttpRequest, textStatus) {
            var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
            if(sstatus != "sessionOut"){
                $("#warning2Body").text("系统错误!");
                $("#warning2").show();
            }
            if(sstatus=="sessionOut"){
                $("#warning3").css('display','block');
            }
        }
    });
}
function selectAllChannel(){
	$.ajax({
  		type: "post",
  		contentType: "application/x-www-form-urlencoded;charset=utf-8",
  		url: __ctxPath + "/channelDisplay/queryAllChannelDisplays",
  		async : false,
  		data:{
  			"channelStatus" : "0"
  		},
  		dataType: "json",
  		success: function(response) {
  			var result = response.list;
  			if(result == null) return;
  			for ( var i = 0; i < result.length; i++) {
  				var isAdd = true;
  				var ele = result[i];
  				var option = $("<option value='" + ele.channelCode + "'>" + ele.channelName + "</option>");
  				for(var j = 0; j < channelPermission.length; j++){
            		var permission = channelPermission[j];
            		if(ele.channelCode == permission.permission){
            			option.appendTo($("#channelSid1"));
            			isAdd = false;
            			break;
            		}
            	}
  				if(isAdd){
  					option.appendTo($("#channelSid"));
  				}
  			}
  			return;
  		},
        error : function(XMLHttpRequest, textStatus) {
            var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
            if(sstatus != "sessionOut"){
                $("#warning2Body").text("系统错误!");
                $("#warning2").show();
            }
            if(sstatus=="sessionOut"){
                $("#warning3").css('display','block');
            }
        }
  	});
}
function getManageCateSids(){
	var treeObj = $.fn.zTree.getZTreeObj("manageCateTree");
	var manageCateSids="", manageCateShopCodes="", manageCateLevels="", manageCateParentCodes="";
	if(treeObj != null){
		var sNodes = treeObj.getCheckedNodes(true);
		if (sNodes.length > 0) {
		for(var i=0;i<sNodes.length;i++){
			var parentCode = sNodes[i].getParentNode().code;
			var code = sNodes[i].code;
			var shopSid = sNodes[i].shopSid;
			var level = sNodes[i].clevel;
				manageCateSids += code + ",";
				manageCateShopCodes += shopSid + ",";
				manageCateLevels += level + ",";
				manageCateParentCodes += parentCode + ",";
			}
		}
	}
	$("#manageCateSids").val(manageCateSids);
	$("#manageCateShopCodes").val(manageCateShopCodes);
	$("#manageCateLevels").val(manageCateLevels);
	$("#manageCateParentCodes").val(manageCateParentCodes);
}
function saveRoleLimit(){
	
	getDiv2PropsSid();
	getManageCateSids();
	updateMemberInfo();
	LA.sysCode = '10';
	LA.log("role.saveRoleLimit", "修改角色权限：" + {
 			"roleSid" : $("#roleSid1").val(),
 			"shopSids" : $("#shopSids").val(),
 			"shopGroupSids" : $("#shopGroupSids").val(),
 			"channelSids" : $("#channelSids").val(),
 			"manageCateSids" : $("#manageCateSids").val(),
 			"manageCateShopCodes" : $("#manageCateShopCodes").val(),
 			"manageCateLevels" : $("#manageCateLevels").val(),
 			"manageCateParentCodes" : $("#manageCateParentCodes").val()
 		}, getCookieValue("username"), sessionId);
	$.ajax({
  		type: "post",
  		contentType: "application/x-www-form-urlencoded;charset=utf-8",
  		url: __ctxPath + "/rolePermission/saveRolePermissions",
  		async : false,
  		data:{
  			"roleSid" : $("#roleSid1").val(),
  			"shopSids" : $("#shopSids").val(),
  			"shopGroupSids" : $("#shopGroupSids").val(),
  			"channelSids" : $("#channelSids").val(),
  			"manageCateSids" : $("#manageCateSids").val(),
  			"manageCateShopCodes" : $("#manageCateShopCodes").val(),
  			"manageCateLevels" : $("#manageCateLevels").val(),
  			"manageCateParentCodes" : $("#manageCateParentCodes").val()
  		},
  		dataType: "json",
  		success: function(response) {
  			if(response.success){
  				$("#modal-body-success").html("<div class='alert alert-success fade in'>"+
					"<strong>保存成功，返回列表页!</strong></div>");
				$("#modal-success").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-success"});
  			}else{
				$("#warning2Body").text(buildErrorMessage("","保存失败！"));
				$("#warning2").show();
			}
  			return;
  		},
        error : function(XMLHttpRequest, textStatus) {
            var sstatus =  XMLHttpRequest.getResponseHeader("sessionStatus");
            if(sstatus != "sessionOut"){
                $("#warning2Body").text("系统错误!");
                $("#warning2").show();
            }
            if(sstatus=="sessionOut"){
                $("#warning3").css('display','block');
            }
        }
  	});
}
function manageCateTree() {
	$.ajax({
		type : "post",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/category/list",
		async : false,
		data : {
			"categoryType" : 1
		},
		dataType : "json",
		ajaxStart : function() {
			$("#loading-container").prop("class", "loading-container");
		},
		ajaxStop : function() {
			$("#loading-container").addClass("loading-inactive");
		},
		success : function(response) {
			allManageCateRoot = response;
			loadManageCateTree();
		}
	});
}
function loadManageCateTree(){
	var zTreeCate = new Array();
	$("#shopSid1 option").each(function(){
		var shopSid = $(this).attr("code");
		for(var i=0;i<allManageCateRoot.length;i++){
			if(allManageCateRoot[i].shopSid==shopSid){
				zTreeCate.push(allManageCateRoot[i]);
			}
		}
	});
	$("#manageCateTree").html("");
	if(zTreeCate.length != 0){
		$.fn.zTree.init($("#manageCateTree"), setting2, zTreeCate);
	}
}

function loadMemberInfo(){
	$.ajax({
		type : "get",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/sysConfig/findSysConfigByRole",
		async : false,
		data : {
			"roleSid" : $("#roleSid1").val(),
			"roleCode" : $("#roleCode1").val()
		},
		dataType : "json",
		ajaxStart : function() {
			$("#loading-container").prop("class", "loading-container");
		},
		ajaxStop : function() {
			$("#loading-container").addClass("loading-inactive");
		},
		success : function(response) {
			if(response.success){
				var ele = response.data;
				if(ele.sysValue == 1){
					$("#memberInfo").attr("checked", "checked");
				}
				$("#sysValue").val(ele.sysValue);
			} else {
				$("#warning2Body").text(response.msg);
                $("#warning2").show();
			}
		}
	});
}
function updateMemberInfo(){
	LA.sysCode = '10';
	LA.log("role.updateMemberInfo", "修改用户敏感信息是否屏蔽：" + $("#sysValue").val(), getCookieValue("username"), sessionId);
	$.ajax({
		type : "get",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : __ctxPath + "/sysConfig/editSysConfigByRole",
		async : false,
		data : {
			"roleSid" : $("#roleSid1").val(),
			"roleCode" : $("#roleCode1").val(),
			"key" : "memberInfo",
			"value" : $("#sysValue").val()
		},
		dataType : "json",
		ajaxStart : function() {
			$("#loading-container").prop("class", "loading-container");
		},
		ajaxStop : function() {
			$("#loading-container").addClass("loading-inactive");
		},
		success : function(response) {
			if(response.success){
				
			} else {
				$("#warning2Body").text(response.msg);
                $("#warning2").show();
			}
		}
	});
}
</script>
<script type="text/javascript">
$(function(){
	selectAllPermission();
	selectAllShop();
	selectAllChannel();
	manageCateTree();
	$("#save1").click(saveRoleLimit);
	loadMemberInfo();
	$("#memberInfo").click(function(){
		var ii = $("#sysValue").val();
		if(ii == "1"){
			$("#sysValue").val("0");
		} else {
			$("#sysValue").val("1");
		}
	});
});
</script>
</head>
<body>
	<div class="page-body">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">角色赋权限</span>
							</div>
							<div class="widget-body">
								<div class="tabbable">
									<ul class="nav nav-tabs" id="myTab">
										<li class="active" id=""><a data-toggle="tab"
											href="#resourceAuth"> <span>角色资源授权</span>
										</a></li>
										
										<li class="tab-red" id=""><a data-toggle="tab"
											href="#limitAuth"> <span>角色权限授权</span>
										</a></li>
									</ul>
									<div class="tab-content">
										<div id="resourceAuth" class="tab-pane in active">
											<form id="theForm" method="post" class="form-horizontal">   
												<input type="hidden" id="resourceSid" name="resourceSid">
												<input type="hidden" id="sid" name="orleSid"/>
												<div class="form-group">
													<label class="col-lg-3 control-label" style="width: 100px">角色名称</label>
													<div class="col-lg-6" style="width:200px">
														<input type="text" class="form-control" id="roleName" readonly="readonly" name="roleName" placeholder="必填"/>
													</div>
													<label class="col-lg-3 control-label" style="width: 100px">角色编码</label>
													<div class="col-lg-6" style="width: 200px">
														<input type="text" class="form-control" id="roleCode" readonly="readonly" name="roleCode" placeholder="必填"/>
													</div>
													<div class="col-lg-6" style="width: 25%;">
														<input class="btn btn-success" style="width: 25%;" id="save" type="button" value="保存" />&emsp;&emsp;
													</div>
												</div>
											</form>
											<div style="padding-left: 150px;">
												<ul id="tree" class="ztree" style="width:560px; overflow:auto;"></ul>
											</div>
										</div>
										<div id="limitAuth" class="tab-pane">
											<form id="theForm1" method="post" class="form-horizontal">
												<input type="hidden" id="shopSids" name="shopSids" value=""/>
												<input type="hidden" id="shopGroupSids" name="shopGroupSids" value=""/>
												<input type="hidden" id="channelSids" name="channelSids" value=""/>
												<input type="hidden" id="manageCateSids" name="manageCateSids"/> 
												<input type="hidden" id="manageCateShopCodes" name="manageCateShopCodes"/>
												<input type="hidden" id="manageCateLevels" name="manageCateLevels"/>
												<input type="hidden" id="manageCateParentCodes" name="manageCateParentCodes"/>
												<input type="hidden" id="roleSid1" name="orleSid"/>
												<div class="form-group">
													<label class="col-lg-3 control-label" style="width: 100px">角色名称：</label>
													<div class="col-lg-6" style="width:200px">
														<input type="text" class="form-control" id="roleName1" readonly="readonly" name="roleName" placeholder="必填"/>
													</div>
													<label class="col-lg-3 control-label" style="width: 100px">角色编码：</label>
													<div class="col-lg-6" style="width: 200px">
														<input type="text" class="form-control" id="roleCode1" readonly="readonly" name="roleCode" placeholder="必填"/>
													</div>
													<div class="col-lg-6" style="width: 25%;">
														<input class="btn btn-success" style="width: 25%;" id="save1" type="button" value="保存" />&emsp;&emsp;
													</div>
												</div>
												<div class="form-group">
													<label class="col-lg-3 control-label" style="width: 180px">用户敏感信息是否屏蔽：</label>
													<label class="control-label"> 
														<input type="checkbox" id="memberInfo" value="on" class="checkbox-slider toggle yesno"> 
														<span class="text"></span>
													</label> 
													<input type="hidden" id="sysValue" name="sysValue" value="1">
												</div>
												<div style="overflow: auto;padding: 0 20px;">
													<div style="width: 50%;float: left;">
														<label style="width: 100%">选择门店：</label>
														<select multiple="multiple" size="10" id="shopSid" style="width: 200px;float: left;font-size: 14px;">
														</select>
														<div style="height: auto;width:30px;color:black;
															 font-size: 20px;float: left;margin: 65px 5px 0 5px;">
															<a class="btn btn-default purple btn-sm" onclick="leftToRight('shopSid', 'shopSid1');"> &gt; </a>
															<br>
															<a class="btn btn-default purple btn-sm" onclick="rightToLeft('shopSid1', 'shopSid');"> &lt; </a>
														</div>
														<select multiple="multiple" size="10" style="width: 200px;font-size: 14px;" id="shopSid1">
														</select>
													</div>
													
													<div style="width: 50%;float: left;">
													<label style="width: 100%">选择渠道：</label>
														<select multiple="multiple" size="10" id="channelSid" style="width: 200px;float: left;font-size: 14px;">
														</select>
														<div style="height: auto;width:30px;color:black;
															 font-size: 20px;float: left;margin: 65px 5px 0 5px;">
															<a class="btn btn-default purple btn-sm" onclick="leftToRight('channelSid', 'channelSid1');"> &gt; </a>
															<br>
															<a class="btn btn-default purple btn-sm" onclick="rightToLeft('channelSid1', 'channelSid');"> &lt; </a>
														</div>
														<select multiple="multiple" size="10" style="width: 200px;font-size: 14px;" id="channelSid1">
														</select>
													</div>
												</div>
											</form>
											<div style="padding: 10px 20px;">
												<span>选择管理分类：</span>
												<ul id="manageCateTree" class="ztree" style="width:560px; overflow:auto;"></ul>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<table bordercolor="red"></table>
	</div>
</body>
</html>